using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class Round
    {
        // Ingen validering p.g.a. ingen data matas in av användaren
        public int RoundID { get; set; }
        public int CourseID { get; set; }
        public DateTime Date { get; set; }
    }
}