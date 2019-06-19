using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace laboratorium_10
{
    class OutputWriter
    {
        private static string filePath = "../../output.txt";
        public static void Write(String text)
        {
            if (!File.Exists(filePath))
            {
                using (StreamWriter sw = File.CreateText(filePath))
                {
                    sw.WriteLine(text);
                }
            }
            else
            {
                using (StreamWriter sw = File.AppendText(filePath))
                {
                    sw.WriteLine(text);
                }
            }
           

        }
        public static void Write(ArrayList list)
        {
            foreach (var item in list)
            {
                Write(item.ToString());
            }
        }
        public static void Write<T>(List<T> list)
        {
            foreach(var item in list)
            {
                Write(item.ToString());
            }
        }

        public static void Write(CarBindingList list)
        {
            foreach (var item in list)
            {
                Write(item.ToString());
            }
        }

        public static void Write<T>(IEnumerable<T> ts)
        {
            foreach(var elem in ts)
            {
                Write(elem.ToString());
            }
        }

        public static void RemoveOutputFile()
        {
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
        }

        public static void WriteEmptyLine()
        {
            Write("");
        }


    }
}
