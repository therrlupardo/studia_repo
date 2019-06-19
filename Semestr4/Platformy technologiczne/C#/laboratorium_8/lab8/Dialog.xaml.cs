using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Text.RegularExpressions;
using System.IO;

namespace lab8
{
    /// <summary>
    /// Logika interakcji dla klasy Dialog.xaml
    /// </summary>
    public partial class Dialog : Window
    {
        private string path;
        private string name;
        private bool success;
        public Dialog(string path)
        {
            InitializeComponent();
            this.path = path;
            success = false;
        }

        public void ButtonOK_Click(object sender, RoutedEventArgs e)
        {
            bool isFile = (bool)radioButtonFile.IsChecked;
            bool isDirectory = (bool)radioButtonDirectory.IsChecked;
            if (isFile && !Regex.IsMatch(dialogName.Text, "^[a-zA-Z0-9_~-]{1,8}\\.(txt|php|html)$"))
            {
                System.Windows.MessageBox.Show("Wrong name!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else if(!isFile && !isDirectory)
            {
                System.Windows.MessageBox.Show("Specify what do you want to be created!", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                name = dialogName.Text;
                path = path + "\\" + name;
                FileAttributes attributes = FileAttributes.Normal;
                if ((bool)checkBoxRO.IsChecked)
                {
                    attributes |= FileAttributes.ReadOnly;
                }
                if ((bool)checkBoxA.IsChecked)
                {
                    attributes |= FileAttributes.Archive;
                }
                if ((bool)checkBoxH.IsChecked)
                {
                    attributes |= FileAttributes.Hidden;
                }
                if ((bool)checkBoxS.IsChecked)
                {
                    attributes |= FileAttributes.System;
                }
                if (isFile)
                {
                    File.Create(path);
                }
                else if (isDirectory)
                {
                    Directory.CreateDirectory(path);
                }
                File.SetAttributes(path, attributes);
                success = true;
                Close();
            }
        }

        private void ButtonCancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        public bool Succeeded()
        {
            return success;
        }

        public string GetPath()
        {
            return path;
        }
    }
}
