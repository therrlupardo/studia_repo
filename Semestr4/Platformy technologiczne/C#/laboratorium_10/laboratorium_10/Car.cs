using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;

namespace laboratorium_10
{
    public class Car
    {
        public string model { get; set; }
        public int year { get; set; }

        public Engine motor { get;  set; }

        public Car()
        {
            motor = new Engine();
        }

        public Car(string model, Engine motor, int year)
        {
            this.model = model;
            this.motor = motor;
            this.year = year;
        }

        public override string ToString()
        {
            return $"Model: {model}, Year: {year}, Engine: {motor}";
        }
    }
}
