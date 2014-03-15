using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class TableRow
    {
        public int RoundID { get; set; }
        public DateTime Date { get; set; }
        public string Name { get; set; }   // Eller CourseID
        public byte FIR { get; set; }
        public float FIRpro { get; set; }
        public byte GIR { get; set; }
        public float GIRpro { get; set; }
        public byte Putts { get; set; }
        public float Puttsavg { get; set; }
        public byte Penalties { get; set; }
        public byte Strokes { get; set; }
        public int Brutto { get; set; }
        public byte Fairways { get; set; }
    }
}