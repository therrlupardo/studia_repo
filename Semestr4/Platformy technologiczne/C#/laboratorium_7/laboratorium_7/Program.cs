using System; 
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace laboratorium_7
{
    static class Program
    {
        static void Main(string[] args)
        {
            string path = args[0];
            if (PrintFiles(path))
            {
                Console.WriteLine();
                Console.WriteLine("Oldest file: {0}", (new DirectoryInfo(path)).GetOldestFile());
                CreateCollection(path);
            }
        }

        public static bool PrintFiles(string path)
        {
            Console.WriteLine(path);
            if (File.Exists(path))  
            {
                ProcessFile(path, 0);
            }
            else if (Directory.Exists(path))
            {
                DirectoryInfo dirInfo = new DirectoryInfo(path);

                ProcessDirectory(path, 0);
            }
            else
            {
                Console.WriteLine("Invalid directory");
                return false;
            }
            return true;
        }

        public static void ProcessDirectory(string path, int depth)
        {
            string[] files = Directory.GetFiles(path);
            foreach (var file in files)
            {
                ProcessFile(file, depth);
            }

            string[] directories = Directory.GetDirectories(path);
            foreach (var directory in directories)
            {
                string[] pathParts = directory.Split("\\");
                string directoryName = pathParts[pathParts.Length - 1];
                for (int i = 0; i < depth; i++)
                {
                    Console.Write("    ");
                }
                DirectoryInfo directoryInfo = new DirectoryInfo(directory);
                DateTime directoryCreation = directoryInfo.GetOldestFile();
                int subfilesCount = (directoryInfo.GetDirectories().Length + directoryInfo.GetFiles().Length);
                Console.Write("{0} ({1}) {2} {3}", directoryName, subfilesCount, directoryCreation, directoryInfo.GetRAHS());
                Console.WriteLine();
                ProcessDirectory(directory, depth + 1);
            }
        }

        public static void ProcessFile(string path, int depth)
        {
            string[] pathParts = path.Split("\\");
            string fileName = pathParts[pathParts.Length - 1];
            for (int i = 0; i < depth; i++)
            {
                Console.Write("    ");
            }
            FileInfo fileInfo = new FileInfo(path);
            Console.Write("{0} ({1} bytes) {2}", fileName, fileInfo.Length, fileInfo.GetRAHS());
            Console.WriteLine();
        }

        public static DateTime GetOldestFile(this DirectoryInfo directory)
        {
            DateTime oldest = new DateTime(2200, 12, 31);
            
            foreach (var directoryInfo in directory.GetDirectories())
            {
                DateTime dirOldest = directoryInfo.GetOldestFile();
                if (dirOldest < oldest)
                {
                    oldest = dirOldest;
                }
            }
            foreach (var fileInfo in directory.GetFiles())
            {
                DateTime creationDate = fileInfo.CreationTime;
                if (creationDate < oldest)
                {
                    oldest = creationDate;
                }
            }
            return oldest;
        }

        public static string GetRAHS(this FileSystemInfo fileSystemInfo)
        {
            string output = "";

            FileAttributes fileAttributes = fileSystemInfo.Attributes;

            if ((fileAttributes & FileAttributes.ReadOnly) == FileAttributes.ReadOnly)
            {
                output += 'r';
            }
            else
            {
                output += '-';
            }

            if ((fileAttributes & FileAttributes.Archive) == FileAttributes.Archive)
            {
                output += 'a';
            }
            else
            {
                output += '-';
            }

            if ((fileAttributes & FileAttributes.Hidden) == FileAttributes.Hidden)
            {
                output += 'h';
            }
            else
            {
                output += '-';
            }

            if ((fileAttributes & FileAttributes.System) == FileAttributes.System)
            {
                output += 's';
            }
            else
            {
                output += '-';
            }
            return output;
        }


        public static void CreateCollection(string path)
        {
            SortedDictionary<string, int> collection = new SortedDictionary<string, int>(new StringComparer());
            if (File.Exists(path))
            {
                FileInfo file = new FileInfo(path);
                collection.Add(file.Name, (int)file.Length);
            }
            else if (Directory.Exists(path))
            {
                DirectoryInfo dir = new DirectoryInfo(path);
                foreach (var subdir in dir.GetDirectories())
                {
                    collection.Add(subdir.Name, (subdir.GetFiles().Length + subdir.GetDirectories().Length));
                }
                foreach (var file in dir.GetFiles())
                {
                    collection.Add(file.Name, (int)file.Length);
                }
            }
            FileStream fs = new FileStream("DataFile.dat", FileMode.Create);
            BinaryFormatter formatter = new BinaryFormatter();
            try
            {   
                formatter.Serialize(fs, collection);
            }
            catch (SerializationException e)
            {
                Console.WriteLine("Serialization error: {0}", e.Message);
            }
            fs.Close();
            Deserialize();
        }

        public static void Deserialize()
        {
            SortedDictionary<string, int> collection = new SortedDictionary<string, int>(new StringComparer());
            FileStream fs = new FileStream("DataFile.dat", FileMode.Open);
            try
            {
                BinaryFormatter formatter = new BinaryFormatter();
                collection = (SortedDictionary<string, int>)formatter.Deserialize(fs);
            }
            catch (SerializationException e)
            {
                Console.WriteLine("Serialization error: {0}", e.Message);
            }

            foreach(var file in collection)
            {
                Console.WriteLine("{0} -> {1}", file.Key, file.Value);
            }
        }
    }   

    

}
