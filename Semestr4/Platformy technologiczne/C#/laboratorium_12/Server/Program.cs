using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace Server
{
    public class Program
    {
        private UdpClient _udpConnectionServer;
        private UdpClient _udpPaintServer;
        private List<IPEndPoint> _udpClients;
        private BlockingCollection<KeyValuePair<byte, byte[]>> _paintCollection;

        private static void Main()
        {
            var program = new Program
            {
                _udpConnectionServer = new UdpClient(7777),
                _udpPaintServer = new UdpClient(7778),
                _udpClients = new List<IPEndPoint>(),
                _paintCollection = new BlockingCollection<KeyValuePair<byte, byte[]>>(
                    new ConcurrentBag<KeyValuePair<byte, byte[]>>())
            };

            var watchingTask = Task.Factory.StartNew(() => program.WatchClients());
            var collectPaintDataTask = Task.Factory.StartNew(() => program.CollectPaintData());
            var sendPaintDataTask = Task.Factory.StartNew(() => program.SendPaintData());

            Console.WriteLine($"Server started at port {((IPEndPoint) program._udpConnectionServer.Client.LocalEndPoint).Port}");

            Task.WaitAll(watchingTask, collectPaintDataTask, sendPaintDataTask);
        }

        private void SendPaintData()
        {
            try
            {
                while (true)
                {
                    var data = _paintCollection.Take();
                    byte[] message = new byte[1 + data.Value.Length];
                    message[0] = data.Key;
                    Buffer.BlockCopy(data.Value, 0, message, 1, data.Value.Length);
                    _udpClients.ForEach(client => _udpPaintServer.Send(message, message.Length, client));
                   
                }
               
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }
        }

        private void CollectPaintData()
        {
            try
            {
                while (true)
                {
                    IPEndPoint endPoint = new IPEndPoint(IPAddress.Any, 0);
                    byte[] bytes = _udpPaintServer.Receive(ref endPoint);
                    var client = _udpClients.FindIndex(x => x.Equals(endPoint));
                    if (client == -1)
                    {
                        Console.WriteLine($"Unkonwn client {endPoint} wants to draw something. Connection terminated.");
                    }
                    else
                    {
                        switch (bytes[0])
                        {
                            case 0x01:
                            {
                                Console.WriteLine($"{endPoint} started drawing!");
                                break;
                            }
                            case 0x02:
                            {
                                Console.WriteLine($"{endPoint} sent point!");
                                break;
                            }
                            case 0x03:
                            {
                                Console.WriteLine($"{endPoint} stopped drawing!");
                                break;
                            }
                            default:
                                Console.WriteLine("OTHER");
                                continue;
                        }
                        _paintCollection.Add(new KeyValuePair<byte, byte[]>((byte)client, bytes));
                    }

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }
            
        }

        private void WatchClients()
        {
            try
            {
                while (true)
                {
                    IPEndPoint endPoint = new IPEndPoint(IPAddress.Any, 0);
                    byte[] bytes = _udpConnectionServer.Receive(ref endPoint);
                    string message = Encoding.ASCII.GetString(bytes);
                    if (message.Equals("connect"))
                    {
                        Console.WriteLine($"{endPoint} connected");
                        _udpClients.Add(endPoint);
                        byte[] messageBack = BitConverter.GetBytes((short)((IPEndPoint) _udpPaintServer.Client.LocalEndPoint).Port);
                        _udpConnectionServer.Send(messageBack, messageBack.Length, endPoint);
                    }
                    else if (message.Equals("disconnect"))
                    {
                        _udpClients.Remove(endPoint);
                        Console.WriteLine($"{endPoint} disconnected");
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                Console.WriteLine(e.StackTrace);
            }
        }
    }

}
