using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class Round
    {
        public int RoundID { get; set; }
        public int CourseID { get; set; }
        public DateTime Date { get; set; }
    }
}