using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace laboratorium_10
{
    class DataController
    {
        private delegate int CompareCarsPowerDelegate(Car car1, Car car2);
        public static List<Car> myCars = new List<Car>(){
                new Car("E250", new Engine(1.8, 204, "CGI"), 2009),
                new Car("E350", new Engine(3.5, 292, "CGI"), 2009),
                new Car("A6", new Engine(2.5, 187, "FSI"), 2012),
                new Car("A6", new Engine(2.8, 220, "FSI"), 2012),
                new Car("A6", new Engine(3.0, 295, "TFSI"), 2012),
                new Car("A6", new Engine(2.0, 175, "TDI"), 2011),
                new Car("A6", new Engine(3.0, 309, "TDI"), 2011),
                new Car("S6", new Engine(4.0, 414, "TFSI"), 2012),
                new Car("S8", new Engine(4.0, 513, "TFSI"), 2012)
        };
        
        public static void LinqStatements()
        {
            var methodBasedSyntaxQuery = myCars
                .Where(s => s.model.Equals("A6"))
                .Select(car =>
                    new
                    {
                        engineType = String.Compare(car.motor.model, "TDI") == 0
                            ? "diesel"
                            : "petrol",
                        hppl = car.motor.horsePower / car.motor.displacement,
                    })
                    .GroupBy(elem => elem.engineType)
                    .Select(elem => new
                    {
                        name = elem.First().engineType.ToString(),
                        value = elem.Average(s => s.hppl).ToString()
                    })
                    .OrderByDescending(t => t.value)
                    .Select(elem => $"{elem.name} = {elem.value}");

            var queryExpresionSyntax = from elem
                                       in (from car in myCars
                                           where car.model.Equals("A6")
                                           select new
                                           {
                                               engineType = String.Compare(car.motor.model, "TDI") == 0
                                                           ? "diesel"
                                                           : "petrol",
                                               hppl = car.motor.horsePower / car.motor.displacement,
                                           })
                                       group elem by elem.engineType into elemGrouped
                                       select new
                                       {
                                           name = elemGrouped.First().engineType.ToString(),
                                           value = elemGrouped.Average(s => s.hppl).ToString()
                                       } into elemSelected
                                       orderby elemSelected.value descending
                                       select $"{elemSelected.name} = {elemSelected.value}";


            OutputWriter.Write("Query Expression Syntax:");
            OutputWriter.Write(queryExpresionSyntax);

            OutputWriter.WriteEmptyLine();
            OutputWriter.Write("Method-based Syntax:");
            OutputWriter.Write(methodBasedSyntaxQuery);

        }

        public static void PerformOperations()
        {
            List<Car> myCarsCopy = new List<Car>(myCars);
            CompareCarsPowerDelegate arg1 = CompareCarsPowers;
            Predicate<Car> arg2 = IsTDI;
            Action<Car> arg3 = ShowMessageBox;

            myCarsCopy.Sort(new Comparison<Car>(arg1));

            OutputWriter.WriteEmptyLine();
            OutputWriter.Write("myCars sorted by horsePower:");
            OutputWriter.Write(myCarsCopy);
            

            myCarsCopy.FindAll(arg2).ForEach(arg3);
        }

        public static void SortingAndSearchingWithCarBindingList()
        {
            CarBindingList myCarsBindingList = new CarBindingList(myCars);
            PerformBindingListSearching(myCarsBindingList);
            PerformBindingListSorting(myCarsBindingList);
        }

        private static void PerformBindingListSorting(CarBindingList myCarsBindingList)
        {
            myCarsBindingList.Sort("model", System.ComponentModel.ListSortDirection.Ascending);
            OutputWriter.WriteEmptyLine();
            OutputWriter.Write("myCars sorted by model ASC");
            OutputWriter.Write(myCarsBindingList);
        }

        private static void PerformBindingListSearching(CarBindingList myCarsBindingList)
        {
            var searchResult = myCarsBindingList.FindCars("motor.displacement", 1.8);
            OutputWriter.WriteEmptyLine();
            OutputWriter.Write("Searching motor.displacement = 1.8 in myCars using BindingList:");
            if (searchResult != null)
            {
                OutputWriter.Write(searchResult);
            }
            else OutputWriter.Write("null");

            searchResult = myCarsBindingList.FindCars("model", "A6");
            OutputWriter.WriteEmptyLine();
            OutputWriter.Write("Searching model A6 in myCars using BindingList:");
            if (searchResult != null)
            {
                OutputWriter.Write(searchResult);
            }
            else OutputWriter.Write("null");
        }

        private static int CompareCarsPowers(Car car1, Car car2)
        {
            if (car1.motor.horsePower >= car2.motor.horsePower)
            {
                return 1;
            }
            else
            {
                return -1;
            }
        }

        private static bool IsTDI(Car car)
        {
            return car.motor.model.Equals("TDI");
        }

        private static void ShowMessageBox(Car car)
        {
            string message = car.ToString();
            string caption = "Car";
            MessageBoxButtons buttons = MessageBoxButtons.OK;
            DialogResult result = MessageBox.Show(message, caption, buttons);
        }

    }
}
