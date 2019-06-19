using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Windows.Forms;
using System.Windows;
using System.Windows.Media;
using Color = System.Drawing.Color;
using Point = System.Drawing.Point;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Shapes;
using System.Windows.Threading;
using MouseEventArgs = System.Windows.Input.MouseEventArgs;

namespace Client
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        private bool _isConnected;
        private Color _myColor;
        private UdpClient _udpClient;
        private IPEndPoint _ipEndPoint;
        private Dictionary<byte, ColoredPoint> _clientsPoints;
        private Task _task;
        private List<LineCanvasStruct> _lines;
        private int _listPrevLength;



        public MainWindow()
        {
            InitializeComponent();
            ChangeConnectionState(false);
            _myColor = Color.Black;
            _udpClient = new UdpClient();
            _clientsPoints = new Dictionary<byte, ColoredPoint>();
            _lines = new List<LineCanvasStruct>();
            _listPrevLength = 0;
            
        }



        private void ButtonClick_Connect(object sender, RoutedEventArgs e)
        {
            if (!_isConnected)
            {
                _udpClient.Connect(TextBoxIp.Text, port: Int32.Parse(TextBoxPort.Text));
                _udpClient.Send(Encoding.ASCII.GetBytes("connect"), 7);

                _ipEndPoint = new IPEndPoint(IPAddress.Any, 0);
                var data = _udpClient.Receive(ref _ipEndPoint);
                _ipEndPoint.Port = BitConverter.ToInt16(data, 0);
                _udpClient.Connect(_ipEndPoint);
                ChangeConnectionState(true);
                _task = Task.Factory.StartNew(WaitForPaintData);
            }
        }



        private void ButtonClick_Disconnect(object sender, RoutedEventArgs e)
        {
            if (_isConnected)
            {
                _udpClient.Connect(TextBoxIp.Text, Int32.Parse(TextBoxPort.Text));
                _udpClient.Send(Encoding.ASCII.GetBytes("disconnect"), 10);
                _udpClient.Close();

                _task.Wait();
                _udpClient = new UdpClient();
                ChangeConnectionState(false);
            }
        }

        private void ChangeConnectionState(bool status)
        {
            _isConnected = status;
            ButtonConnect.IsEnabled = !status;
            ButtonDisconnect.IsEnabled = status;
            TextBoxStatus.Text = status ? "Connected" : "Disconnected";
            TextBoxIp.IsEnabled = !status;
            TextBoxPort.IsEnabled = !status;
        }

        private void ButtonClick_Color(object sender, RoutedEventArgs e)
        {
            ColorDialog colorDialog = new ColorDialog();
            if (colorDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                _myColor = colorDialog.Color;

                RectangleColor.Fill = new SolidColorBrush(System.Windows.Media.Color.FromRgb(
                    colorDialog.Color.R,
                    colorDialog.Color.G,
                    colorDialog.Color.B));
            }
        }
        private void WaitForPaintData()
        {
            try
            {
                while (_isConnected)
                {
                    IPEndPoint endPoint = new IPEndPoint(IPAddress.Any, 0);
                    Debug.WriteLine("Waiting");
                    byte[] bytes = _udpClient.Receive(ref endPoint);
                    Debug.WriteLine("Got something!");
                    byte id = bytes[0];
                    MenageIncomingMessage(bytes, id);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }
        }

        private void MenageIncomingMessage(byte[] bytes, byte id)
        {
            switch (bytes[1])
            {
                case 0x01:
                    {
                        byte[] color = new byte[4];
                        Buffer.BlockCopy(bytes, 2, color, 0, color.Length);
                        _clientsPoints[id] = new ColoredPoint(Color.FromArgb(BitConverter.ToInt32(color, 0)), new Point(0));
                        break;
                    }

                case 0x02:
                    {
                        PerformDrawingAction(bytes, id);
                        break;
                    }

                case 0x03:
                    {
                        PerformStopDrawing(id);
                        break;
                    }
            }
        }

        private void PerformStopDrawing(byte id)
        {
            try
            {
                
                var client = _clientsPoints[id];
                client.Point = new Point(0);
            }
            catch (KeyNotFoundException)
            {
            }
        }

        private void PerformDrawingAction(byte[] bytes, byte id)
        {
            try
            {
                MyCanvas.Dispatcher.Invoke(DispatcherPriority.Background,
                    new Action(() =>
                    {
                        var client = _clientsPoints[id];
                        byte[] position = new byte[4];
                        Buffer.BlockCopy(bytes, 2, position, 0, position.Length);
                        Point point = new Point(BitConverter.ToInt32(position, 0));
                        if (client.Point.IsEmpty)
                        {
                            client.Point = point;
                        }
                        Brush brush = new SolidColorBrush(
                            System.Windows.Media.Color.FromRgb(
                                client.Color.R,
                                client.Color.G,
                                client.Color.B));

                        Line line = new Line()
                        {
                            X1 = point.X-5.0f,
                            X2 = point.X,
                            Y1 = point.Y-5.0f,
                            Y2 = point.Y,
                            Stroke = brush,
                            StrokeThickness = 5.0f
                        };
                        Debug.WriteLine($"Attempt to draw line from ({line.X1}, {line.Y1}) to ({line.X2}, {line.Y2})."+
                                                  $"Brush color {client.Color.R}:{client.Color.G}:{client.Color.B}");
                        MyCanvas.Children.Add(line);
                    }));

            }
            catch (KeyNotFoundException)
            {
            }
        }



        private void Canvas_MouseDown(object sender, MouseButtonEventArgs mouseButtonEventArgs)
        {
            if (_isConnected)
            {
                byte[] bytes = new byte[5];
                bytes[0] = 0x01;
                Buffer.BlockCopy(BitConverter.GetBytes(_myColor.ToArgb()), 0, bytes, 1, sizeof(int));
                _udpClient.Send(bytes, bytes.Length);
            }

        }
        private void Canvas_MouseMove(object sender, MouseEventArgs eventArgs)
        {
            if (_isConnected && eventArgs.LeftButton == MouseButtonState.Pressed)
            {
                byte[] bytes = new byte[5];
                bytes[0] = 0x02;
                Buffer.BlockCopy(BitConverter.GetBytes((short)eventArgs.GetPosition(this).X), 0, bytes, 1, 2);
                Buffer.BlockCopy(BitConverter.GetBytes((short)eventArgs.GetPosition(this).Y), 0, bytes, 3, 2);
                _udpClient.Send(bytes, bytes.Length);
            }
        }
        private void Canvas_MouseUp(object sender, MouseButtonEventArgs mouseEventArgs)
        {
            if (_isConnected)
            {
                byte[] bytes = new byte[1];
                bytes[0] = 0x03;
                _udpClient.Send(bytes, bytes.Length);
            }
        }
    }
}
