using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using System.Windows;
using System.Windows.Forms;

namespace laboratorium_11
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    public partial class MainWindow
    {
        private NewtonSymbol _newtonSymbol;
        private int _highestPercentageReached;
        public MainWindow()
        {
            InitializeComponent();
        }
        private void ButtonClick_NewtonSymbolTasks(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(TextBoxN.Text, out n) || !Int32.TryParse(TextBoxK.Text, out k))
            {
                SetErrorLabel("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!");
                return;
            }
            _newtonSymbol = new NewtonSymbol(n, k);
            double result = _newtonSymbol.CalculateTasks();
            switch (result)
            {
                case -1:
                    SetErrorLabel("n i k muszą być większe od 0!");
                    break;
                case -2:
                    SetErrorLabel("k nie może być większe niż n!");
                    break;
                default:
                    TextBoxTasks.Text = result.ToString(CultureInfo.InvariantCulture);
                    SetErrorLabel("");
                    break;
            }
            
        }
        private void ButtonClick_NewtonSymbolDelegates(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(TextBoxN.Text, out n) || !Int32.TryParse(TextBoxK.Text, out k))
            {
                SetErrorLabel("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!");
                return;
            }
            _newtonSymbol = new NewtonSymbol(n, k);
            double result = _newtonSymbol.CalculateDelegates();
            switch (result)
            {
                case -1:
                    SetErrorLabel("n i k muszą być większe od 0!");
                    break;
                case -2:
                    SetErrorLabel("k nie może być większe niż n!");
                    break;
                default:
                    TextBoxDelegates.Text = result.ToString(CultureInfo.InvariantCulture);
                    SetErrorLabel("");
                    break;
            }
        }
        private async void ButtonClick_NewtonSymbolAsyncAwait(object sender, RoutedEventArgs e)
        {
            int k, n;
            if (!Int32.TryParse(TextBoxN.Text, out n) || !Int32.TryParse(TextBoxK.Text, out k))
            {
                SetErrorLabel("Aby obliczyć wartość Symbolu Newtona musisz najpierw ustawić n i k!");
                return;
            }
            _newtonSymbol = new NewtonSymbol(n, k);
            double result = await _newtonSymbol.CalculateAsyncAwait();
            switch (result)
            {
                case -1:
                    SetErrorLabel("n i k muszą być większe od 0!");
                    break;
                case -2:
                    SetErrorLabel("k nie może być większe niż n!");
                    break;
                default:
                    TextBoxAsyncAwait.Text = result.ToString(CultureInfo.InvariantCulture);
                    SetErrorLabel("");
                    break;
            }

        }
        private void ButtonClick_Get(object sender, RoutedEventArgs e)
        {
            int i;
            if(!Int32.TryParse(TextBoxI.Text, out i))
            {
                SetErrorLabel("Aby obliczyć i-ty element ciągu fibonacciego musisz podać i!");
                return;
            }

            if (i <= 0)
            {
                SetErrorLabel("Indeks musi być większy od 0!");
                return;
            }
            BackgroundWorker fibonacciWorker = new BackgroundWorker();
            fibonacciWorker.DoWork += fibonacciWorker_DoWork;
            fibonacciWorker.RunWorkerCompleted += fibonacciWorker_RunWorkerCompleted;
            fibonacciWorker.ProgressChanged += fibonacciWorker_ProgressChanged;
            _highestPercentageReached = 0;
            ProgressBar.Value = 0;
            fibonacciWorker.RunWorkerAsync(i);
        }

        private void fibonacciWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            if (worker != null)
            {
                worker.WorkerReportsProgress = true;
                e.Result = ComputeFibonacci((int) e.Argument, worker, e);
            }
        }

        private void fibonacciWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            TextBoxFibonacci.Text = e.Result.ToString();
        }

        private void fibonacciWorker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            ProgressBar.Value = e.ProgressPercentage;
        }

        private UInt64 ComputeFibonacci(int n, BackgroundWorker worker, DoWorkEventArgs e)
        {
            if(n <= 0)
            {
                SetErrorLabel("Ciąg Fibonacciego można policzyć tylko dla i > 0!");
                return 0;
            }
            UInt64 result = 0;

            if (worker.CancellationPending)
            {
                e.Cancel = true;
            }
            else
            {
                List<UInt64> listOfFibonacciElements = new List<UInt64>();
                
                for(int i = 1; i <= n; i++)
                {
                    if (i <= 2)
                    {
                        listOfFibonacciElements.Add(1);
                    }
                    else
                    {
                        var a = listOfFibonacciElements.Last();
                        listOfFibonacciElements.Remove(a);
                        var b = listOfFibonacciElements.Last();
                        listOfFibonacciElements.Add(a);
                        listOfFibonacciElements.Add(a + b);
                    }
                    int percentComplete = (int)((float)i / n * 100);
                    if (percentComplete > _highestPercentageReached)
                    {
                        _highestPercentageReached = percentComplete;
                        worker.ReportProgress(percentComplete);
                        Thread.Sleep(20);
                    }
                }
                result = listOfFibonacciElements.Last();
            }
            

            return result;
        }

       

        private void ButtonClick_Resolve(object sender, RoutedEventArgs e)
        {
            var domainList = DomainConverter.ConvertDomains();
            TextBoxOutput.Text = "";
            foreach(var domain in domainList)
            {
                TextBoxOutput.Text += $"{domain.Item1} => {domain.Item2}\n";
            }

        }
        private void ButtonClick_Compress(object sender, RoutedEventArgs e)
        {
            var dialog = new FolderBrowserDialog()
            {
                Description = Properties.Resources.MainWindow_ButtonClick_Compress_Select_directory_to_compress
            };
            DialogResult result = dialog.ShowDialog();
            if(result == System.Windows.Forms.DialogResult.OK)
            {
                DirectoryInfo directoryInfo = new DirectoryInfo(dialog.SelectedPath);
                Compresser.CompressDirectory(directoryInfo);
            }

        }
        private void ButtonClick_Decompress(object sender, RoutedEventArgs e)
        {
            var dialog = new FolderBrowserDialog()
            {
                Description = Properties.Resources.MainWindow_ButtonClick_Decompress_Select_directory_to_decompress
            };
            DialogResult result = dialog.ShowDialog();
            if (result == System.Windows.Forms.DialogResult.OK)
            {
                DirectoryInfo directoryInfo = new DirectoryInfo(dialog.SelectedPath);
                Compresser.DecompressDirectory(directoryInfo);
            }
        }
        private void LabelDoubleClick_ClearErrorLabel(object sender, RoutedEventArgs e)
        {
            SetErrorLabel("");
        }

        private void SetErrorLabel(string error)
        {
            LabelError.Content = error;
        }
    }
}
