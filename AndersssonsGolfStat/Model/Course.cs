using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class Course
    {
        //tinyint = byte   ,  smallint = short
        public int CourseID { get; set; }
        public string Name { get; set; }
        public byte Par { get; set; }
        public byte Fairways { get; set; }
    }
}