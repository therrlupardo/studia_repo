using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using System.Xml.XPath;

namespace laboratorium_9
{
    class Program
    {
        private static readonly List<Car> myCars = new List<Car>
            {
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

        static void Main()
        {
            LinqStatements();
            SerializeAndDeserialize();
            XPathStatements();
            LinqSerialization();
            MyCarsToXHTMLTable();
            ModifyCarsCollectionXML();
        }

        private static void LinqSerialization()
        {
            IEnumerable<XElement> nodes = myCars
                .Select(n =>
                new XElement("car",
                    new XElement("model", n.model),
                    new XElement("engine",
                        new XAttribute("model", n.motor.model),
                        new XElement("displacement", n.motor.displacement),
                        new XElement("horsePower", n.motor.horsePower)),
                    new XElement("year", n.year)));
            XElement rootNode = new XElement("cars", nodes);
            rootNode.Save("CarsCollectionLinq.xml");
        }

        private static void LinqStatements()
        {
            var myCarToAnonymousTypeQuery = myCars
                                                .Where(s => s.model.Equals("A6"))
                                                .Select(car =>
                                                    new
                                                    {
                                                        engineType = String.Compare(car.motor.model, "TDI") == 0
                                                                   ? "diesel"
                                                                   : "petrol",
                                                        hppl = car.motor.horsePower / car.motor.displacement,
                                                    });
            foreach (var elem in myCarToAnonymousTypeQuery)
            {
                Console.WriteLine(elem.ToString());
            }
            Console.WriteLine();
            var groupedQuery = myCarToAnonymousTypeQuery
                .GroupBy(elem => elem.engineType)
                .Select(elem => $"{elem.First().engineType}: {elem.Average(s => s.hppl).ToString()}");
            foreach (var elem in groupedQuery)
            {
                Console.WriteLine(elem);
            }
            Console.WriteLine();
        }

        private static void ModifyCarsCollectionXML()
        {
            XElement template = XElement.Load("CarsCollection.xml");
            foreach(var car in template.Elements())
            {
                foreach(var field in car.Elements())
                {
                    if(field.Name == "engine")
                    {
                        foreach(var engineElement in field.Elements())
                        {
                            if(engineElement.Name == "horsePower")
                            {
                                engineElement.Name = "hp";
                            }
                        }
                    }
                    else if (field.Name == "model")
                    {
                        var yearField = car.Element("year");
                        XAttribute attribute = new XAttribute("year", yearField.Value);
                        field.Add(attribute);
                        yearField.Remove();
                    }
                }
            }
            template.Save("CarsCollectionModified.xml");
        }

        private static void MyCarsToXHTMLTable()
        {
            IEnumerable<XElement> rows = myCars
                .Select(car =>
                new XElement("tr", new XAttribute("style", "border: 2px solid black"),
                    new XElement("td", new XAttribute("style", "border: 2px double black"), car.model),
                    new XElement("td", new XAttribute("style", "border: 2px double black"), car.motor.model),
                    new XElement("td", new XAttribute("style", "border: 2px double black"), car.motor.displacement),
                    new XElement("td", new XAttribute("style", "border: 2px double black"), car.motor.horsePower),
                    new XElement("td", new XAttribute("style", "border: 2px double black"), car.year)));
            XElement table = new XElement("table", new XAttribute("style", "border: 2px double black"), rows);
            XElement template = XElement.Load("template.html");
            XElement body = template.Element("{http://www.w3.org/1999/xhtml}body");
            body.Add(table);
            template.Save("templateWithTable.html");
        }

        private static void SerializeAndDeserialize()
        {
            var fileName = "CarsCollection.xml";
            var currentDirectory = Directory.GetCurrentDirectory();
            var filePath = Path.Combine(currentDirectory, fileName);
            Serializator.SerializeCollection(myCars, filePath);
            var deserializedList = Serializator.DeserializeXML(filePath);
            Console.Write("Models of cars from deserialized list: ");
            foreach(var elem in deserializedList)
            {
                Console.Write($"{elem.model} ");
            }
            Console.WriteLine();
            Console.WriteLine();
        }

        private static void XPathStatements()
        {
            XElement rootNode = XElement.Load("CarsCollection.xml");
            var countAvarageXPath = "sum(//car/engine[@model!=\"TDI\"]/horsePower) div count(//car/engine[@model!=\"TDI\"]/horsePower)";
            Console.WriteLine($"Średnia: {(double)rootNode.XPathEvaluate(countAvarageXPath)}");

            var removeDuplicatesXPath = "//car[following-sibling::car/model = model]";
            IEnumerable<XElement> models = rootNode.XPathSelectElements(removeDuplicatesXPath);

            var fileName = "CarsCollectionNoRepeats.xml";
            var currentDirectory = Directory.GetCurrentDirectory();
            var filePath = Path.Combine(currentDirectory, fileName);
            using (var writer = new StreamWriter(filePath))
            {
                foreach(var model in models)
                {
                    writer.WriteLine(model);   
                }
            }
        }



    }
}
