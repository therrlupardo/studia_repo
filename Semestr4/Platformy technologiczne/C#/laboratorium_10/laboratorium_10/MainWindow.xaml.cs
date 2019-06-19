using System;
using System.Collections.Generic;
using System.ComponentModel;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Drawing;
using System.Windows.Forms;
using System.Windows.Controls.Primitives;

namespace laboratorium_10
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private CarBindingList myCarsBindingList;
        private BindingSource carBindingSource;
        private Dictionary<string, bool> sortingASC = new Dictionary<string, bool>();

        public MainWindow()
        {
            OutputWriter.RemoveOutputFile();
            DataController.LinqStatements();
            DataController.PerformOperations();
            DataController.SortingAndSearchingWithCarBindingList();


            InitializeComponent();
            InitComboBox();
            InitSorting();
            myCarsBindingList = new CarBindingList(DataController.myCars);
            carBindingSource = new BindingSource();
            UpdateDataGrid();


        }

        private void InitSorting()
        {
            sortingASC.Clear();
            sortingASC.Add("model", false);
            sortingASC.Add("motor", false);
            sortingASC.Add("year", false);

        }

        private void ButtonSearch(object sender, RoutedEventArgs e)
        {
            CheckForNewItems();
            myCarsBindingList = new CarBindingList(DataController.myCars);
            List<Car> resultListOfCars;
            Int32 tmp;
            if (!searchTextBox.Text.Equals(""))
            {
                //OutputWriter.Write(comboBox.SelectedItem.ToString());
                string property = comboBox.SelectedItem.ToString();
                if (Int32.TryParse(searchTextBox.Text, out tmp))
                {
                    resultListOfCars = myCarsBindingList.FindCars(property, tmp);
                }
                else
                {
                    resultListOfCars = myCarsBindingList.FindCars(property, searchTextBox.Text);
                }

                myCarsBindingList = new CarBindingList(resultListOfCars);
                UpdateDataGrid();
            }
        }

        private void CheckForNewItems()
        {
            foreach(Car item in myCarsBindingList)
            {
                if (!DataController.myCars.Contains(item))
                {
                    DataController.myCars.Add(item);
                }
            }
        }

        private void ButtonReload(object sender, RoutedEventArgs e)
        {
            myCarsBindingList = new CarBindingList(DataController.myCars);
            UpdateDataGrid();
        }
        private void SortColumn(object sender, RoutedEventArgs e)
        {
            var columnHeader = sender as DataGridColumnHeader;
            string columnName = columnHeader.ToString().Split(' ')[1].ToLower();
            bool isAsc = sortingASC[columnName];
            InitSorting();
            if (isAsc == true)
            {
                myCarsBindingList.Sort(columnName, ListSortDirection.Descending);
            }
            else
            {
                myCarsBindingList.Sort(columnName, ListSortDirection.Ascending);
            }
            sortingASC[columnName] = !isAsc;
            OutputWriter.Write(myCarsBindingList);
            UpdateDataGrid();
        }
        private void ButtonDeleteRow(object sender, RoutedEventArgs e)
        {
            for (var vis = sender as Visual; vis != null; vis = VisualTreeHelper.GetParent(vis) as Visual)
                if (vis is DataGridRow)
                {
                    var row = (DataGridRow)vis;
                    Car car = (Car)row.Item;
                    myCarsBindingList.Remove(car);
                    DataController.myCars.Remove(car);
                    UpdateDataGrid();
                    break;
                }
            
        }

        private void UpdateDataGrid()
        {

            carBindingSource.DataSource = myCarsBindingList;
            dataGridView1.ItemsSource = carBindingSource;
            
        }

        private void InitComboBox()
        {
            BindingList<string> list = new BindingList<string>();
            list.Add("model");
            list.Add("year");
            list.Add("motor.displacement");
            list.Add("motor.model");
            list.Add("motor.horsePower");
            comboBox.ItemsSource = list;
            comboBox.SelectedIndex = 0;
        }

    }
}
