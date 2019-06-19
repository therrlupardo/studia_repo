using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml.Serialization;

namespace laboratorium_9
{
    class Serializator
    {
        public static List<Car> DeserializeXML(string filePath)
        {
            List<Car> list = new List<Car>();
            XmlSerializer serializer = new XmlSerializer(typeof(List<Car>),
                new XmlRootAttribute("cars"));
            using (Stream reader = new FileStream(filePath, FileMode.Open))
            {
                list = (List<Car>)serializer.Deserialize(reader);
            }
            return list;
        }

        public static void SerializeCollection(List<Car> listOfCars, string filename)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(List<Car>),
                new XmlRootAttribute("cars"));
            using (TextWriter writer = new StreamWriter(filename))
            {
                serializer.Serialize(writer, listOfCars);
            }
        }

    }
}
