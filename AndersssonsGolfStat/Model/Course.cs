using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    // Klass som motsvarar en rad i databastabellen Course
    public class Course
    {
        public int CourseID { get; set; }
        
        // Valideringsregler Data annotation
        [Required(ErrorMessage = "- Ett namn måste anges.")]
        [StringLength(30, ErrorMessage = "- Namnet kan bestå av som mest 30 tecken.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "- Banans par måste anges.")]
        [RegularExpression(@"^((6|7)[0-9])|[80]$", ErrorMessage = "- Par måste vara i intervallet 60 - 80.")]
        public byte Par { get; set; }

        [Required(ErrorMessage = "- Antal möjliga firwayträffar måste anges.")]
        [RegularExpression(@"^((0|1)[0-8])|[0-9]$", ErrorMessage = "- Antal fairways kan max vara 18.")]
        public byte Fairways { get; set; }
    }
}