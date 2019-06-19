using System.Drawing;
using Brush = System.Windows.Media.Brush;

namespace Client
{
    public struct LineCanvasStruct
    {
        public Point Start { get; set; }
        public Point End { get; set; }
        public Brush Stroke { get; set; }
        public float Thickness { get; set; }
        public bool IsDrawn { get; set; }

        public LineCanvasStruct(Point start, Point end, Brush stroke, float thickness)
        {
            Start = start;
            End = end;
            Stroke = stroke;
            Thickness = thickness;
            IsDrawn = false;
        }
    }
}
