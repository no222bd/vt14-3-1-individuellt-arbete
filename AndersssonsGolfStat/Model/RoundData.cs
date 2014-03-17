using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class RoundData
    {
        public int RoundID { get; set; }
        
        public DateTime Date { get; set; }
                
        public string Name { get; set; }


        [Required(ErrorMessage = "- Ett Datum måste anges.")]
        [RegularExpression(@"^(19|20)[0-9][0-9]-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$", ErrorMessage = "- Datum skall anges i formatet ÅÅÅÅ-MM-DD.")]
        public string DateString
        {
            get
            {
                return Date.ToShortDateString();
            }
            set
            {
                DateTime temp;
                if(DateTime.TryParse(value, out temp))
                {
                    Date = temp;
                }
            }
        }


        [Required(ErrorMessage = "- Antalet FairwayInRegulation måste anges.")]
        [RegularExpression(@"^((0|1)[0-8])|[0-9]$", ErrorMessage = "- Antal FairwayInRegulation kan max vara 18.")]
        public byte FIR { get; set; }
        
        public float FIRpro { get; set; }

        [Required(ErrorMessage = "- Antalet GreenInRegulation måste anges.")]
        [RegularExpression(@"^((0|1)[0-8])|[0-9]$", ErrorMessage = "- Antal GreenInRegulation kan max vara 18.")]
        public byte GIR { get; set; }
        
        public float GIRpro { get; set; }

        [Required(ErrorMessage = "- Antalet Puttar måste anges.")]
        [RegularExpression(@"^([0-9][0-9])|[0-9]$", ErrorMessage = "- Antal Puttar kan max vara 99.")]
        public byte Putts { get; set; }
        
        public float Puttsavg { get; set; }
        
        [Required(ErrorMessage = "- Antalet Plikt måste anges.")]
        [RegularExpression(@"^([0-9][0-9])|[0-9]$", ErrorMessage = "- Antal Plikt kan max vara 99.")]
        public byte Penalties { get; set; }

        [Required(ErrorMessage = "- Antalet Slag måste anges.")]
        [RegularExpression(@"^([5-9][0-9])|([0-1]?[0-4][0-9])$", ErrorMessage = "- Antal Slag skall vara inom intervallet 50 - 149.")]
        public byte Strokes { get; set; }
        
        public int Brutto { get; set; }
        
        public byte Fairways { get; set; }

        
    }
}