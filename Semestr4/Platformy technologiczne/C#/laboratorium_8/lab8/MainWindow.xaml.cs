using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MenuItem = System.Windows.Controls.MenuItem;

namespace lab8
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Open(object sender, RoutedEventArgs e)
        {
            var dlg = new FolderBrowserDialog()
            {
                Description = "Select directory to open"
            };
            DialogResult result = dlg.ShowDialog();
            if(result == System.Windows.Forms.DialogResult.OK)
            {
                treeView.Items.Clear();
                //var parts = dlg.SelectedPath.Split('\\');
                DirectoryInfo dir = new DirectoryInfo(dlg.SelectedPath);
                var root = MakeTreeDirectory(dir);
                treeView.Items.Add(root);
            }
        }

        private void Exit(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private TreeViewItem MakeTreeFile(FileInfo file)
        {
            var item = new TreeViewItem
            {
                Header = file.Name,
                Tag = file.FullName
            };
            item.ContextMenu = new System.Windows.Controls.ContextMenu();
            var menuItem1 = new MenuItem { Header = "Open" };
            menuItem1.Click += new RoutedEventHandler(MenuItemOpenClick);
            var menuItem2 = new MenuItem { Header = "Delete" };
            menuItem2.Click += new RoutedEventHandler(MenuItemDeleteClick);
            item.ContextMenu.Items.Add(menuItem1);
            item.ContextMenu.Items.Add(menuItem2);
            item.Selected += new RoutedEventHandler(StatusBarUpdate);
            return item;
        }

       

        private TreeViewItem MakeTreeDirectory(DirectoryInfo dir)
        {
            var root = new TreeViewItem
            {
                Header = dir.Name,
                Tag = dir.FullName
            };

            root.ContextMenu = new System.Windows.Controls.ContextMenu();
            var menuItem1 = new MenuItem { Header = "Create" };
            menuItem1.Click += new RoutedEventHandler(MenuItemCreateClick);
            var menuItem2 = new MenuItem { Header = "Delete" };
            menuItem2.Click += new RoutedEventHandler(MenuItemDeleteClick);
            root.ContextMenu.Items.Add(menuItem1);
            root.ContextMenu.Items.Add(menuItem2);

            foreach (DirectoryInfo subdir in dir.GetDirectories())
            {
                root.Items.Add(MakeTreeDirectory(subdir));
            }
            foreach (FileInfo file in dir.GetFiles())
            {
                root.Items.Add(MakeTreeFile(file));
            }
            root.Selected += new RoutedEventHandler(StatusBarUpdate);
            return root;
        }

        private void MenuItemCreateClick(object sender, RoutedEventArgs e)
        {
            TreeViewItem folder = (TreeViewItem)treeView.SelectedItem;
            string path = (string)folder.Tag;
            Dialog dialog = new Dialog(path);
            dialog.ShowDialog();
            if (dialog.Succeeded())
            {
                if (File.Exists(dialog.GetPath()))
                {
                    FileInfo file = new FileInfo(dialog.GetPath());
                    folder.Items.Add(MakeTreeFile(file));
                }
                else if (Directory.Exists(dialog.GetPath()))
                {
                    DirectoryInfo dir = new DirectoryInfo(dialog.GetPath());
                    folder.Items.Add(MakeTreeDirectory(dir));
                }
            }
        }

        private void MenuItemDeleteClick(object sender, RoutedEventArgs e)
        {
            TreeViewItem item = (TreeViewItem)treeView.SelectedItem;
            string path = (string)item.Tag;
            FileAttributes attributes = File.GetAttributes(path);
            File.SetAttributes(path, attributes & ~FileAttributes.ReadOnly);
            if((attributes & FileAttributes.Directory) == FileAttributes.Directory)
            {
                deleteDirectory(path);
            }
            else
            {
                File.Delete(path);
            }
            if ((TreeViewItem) treeView.Items[0] != item)
            {
                TreeViewItem parent = (TreeViewItem)item.Parent; 
                parent.Items.Remove(item);
            }
            else
            {
                treeView.Items.Clear();
            }
        }

        private void deleteDirectory(string path)
        {
            DirectoryInfo dir = new DirectoryInfo(path);
            foreach(var subdir in dir.GetDirectories())
            {
                deleteDirectory(subdir.FullName);
            }
            foreach(var file in dir.GetFiles())
            {
                File.Delete(file.FullName);
            }
            Directory.Delete(path);
        }

        private void MenuItemOpenClick(object sender, RoutedEventArgs e)
        {
            TreeViewItem item = (TreeViewItem)treeView.SelectedItem;
            string content = File.ReadAllText((string)item.Tag);
            scrollViewer.Content = new TextBlock() { Text = content };           
        }

        private void StatusBarUpdate(object sender, RoutedEventArgs e)
        {
            TreeViewItem item = (TreeViewItem)treeView.SelectedItem;
            FileAttributes attributes = File.GetAttributes((string)item.Tag);
            statusDOS.Text = "";
            if((attributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
            {
                statusDOS.Text += 'r';
            }
            else
            {
                statusDOS.Text += '-';
            }
            if ((attributes & FileAttributes.Archive) == FileAttributes.Archive)
            {
                statusDOS.Text += 'a';
            }
            else
            {
                statusDOS.Text += '-';
            }
            if ((attributes & FileAttributes.Hidden) == FileAttributes.Hidden)
            {
                statusDOS.Text += 'h';
            }
            else
            {
                statusDOS.Text += '-';
            }
            if ((attributes & FileAttributes.System) == FileAttributes.System)
            {
                statusDOS.Text += 's';
            }
            else
            {
                statusDOS.Text += '-';
            }
        }
    }
}
