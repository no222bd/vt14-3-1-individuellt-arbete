using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class Round
    {   // Klass som motsvarar en rad i databastabellen Round
        // Inga valideringsregler p.g.a. egenskaperna ej sätts av anvädaren
        public int RoundID { get; set; }
        public int CourseID { get; set; }
        public DateTime Date { get; set; }
    }
}