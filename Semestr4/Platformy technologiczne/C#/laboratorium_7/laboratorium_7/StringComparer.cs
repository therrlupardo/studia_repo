using System;
using System.Collections.Generic;
using System.Text;

namespace laboratorium_7
{
    [Serializable]
    public class StringComparer : IComparer<string>
    {
        public int Compare(string a, string b)
        {
            if (a.Length > b.Length)
            {
                return 1;
            }
            else if (a.Length < b.Length)
            {
                return -1       ;
            }
            else
            {
                return a.CompareTo(b);
            }
        }
    }
}
