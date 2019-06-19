using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace laboratorium_10
{
    public class Engine : IComparable
    {
        public double displacement { get; set; }

        public int horsePower { get; set; }

        public string model { get; set; }

        public Engine() { }
        public Engine(double displacement, int horsePower, string model)
        {
            this.displacement = displacement;
            this.horsePower = horsePower;
            this.model = model;
        }

        public override string ToString()
        {
            return $"{model} {displacement} ({horsePower} hp)"; 
        }

        public int CompareTo(object obj)
        {
            Engine other = (Engine)obj;
            if (model.CompareTo(other.model) != 0)
            {
                return model.CompareTo(other.model);
            }
            else if (displacement.CompareTo(other.displacement) != 0)
            {
                return displacement.CompareTo(other.displacement);
            }
            return horsePower.CompareTo(other.horsePower);
        }
    }
}
