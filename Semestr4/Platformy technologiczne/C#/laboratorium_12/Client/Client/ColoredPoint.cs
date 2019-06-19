using Color = System.Drawing.Color;
using Point = System.Drawing.Point;

namespace Client
{
    public struct ColoredPoint
    {
        public Color Color { get; set; }
        public Point Point { get; set; }

        public ColoredPoint(Color color, Point point)
        {
            Color = color;
            Point = point;
        }
    }
}
