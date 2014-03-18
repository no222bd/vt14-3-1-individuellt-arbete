using AndersssonsGolfStat.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    // Service-klass som bildar gränssnitt mellan modell-klasserna och presentationslogikslagret
    public class Service
    {
        private CourseDAL _courseDAL;
        private RoundDAL _roundDAL;
        private RoundDataDAL _roundDataDAL;

        // "Lazy" Initialization. Objekten skapas först när det finns ett behov av dem.

        private CourseDAL CourseDAL
        {
            get { return _courseDAL ?? (_courseDAL = new CourseDAL()); }
        }

        private RoundDAL RoundDAL
        {
            get { return _roundDAL ?? (_roundDAL = new RoundDAL()); }
        }

        private RoundDataDAL RoundDataDAL
        {
            get { return _roundDataDAL ?? (_roundDataDAL = new RoundDataDAL()); }
        }
        
        // Hämtar data om samtliga spelade rundor
        public IEnumerable<RoundData> GetRoundData()
        {
            return RoundDataDAL.GetRoundData();
        }

        // Hämtar data om en spelad runda
        public RoundData GetRoundDataByRoundId(int roundId)
        {
            return  RoundDataDAL.GetRoundDataByRoundId(roundId);
        }

        // Sparar ny runda i databasen
        public void InsertRoundData(RoundData roundData)
        {
            // Validering av RoundData objekt m.h.a. Data annotation
            var validationContext = new ValidationContext(roundData);
            var validationResults = new List<ValidationResult>();

            if (!Validator.TryValidateObject(roundData, validationContext, validationResults, true))
            {
                var ex = new ValidationException();
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }

            RoundDataDAL.InsertRoundData(roundData);
        }

        // Uppdaterar en runda i databasen
        public void UpdateRoundData(RoundData roundData)
        {
            // Validering av RoundData objekt m.h.a. Data annotation
            var validationContext = new ValidationContext(roundData);
            var validationResults = new List<ValidationResult>();

            if (!Validator.TryValidateObject(roundData, validationContext, validationResults, true))
            {
                var ex = new ValidationException();
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }
            
            RoundDataDAL.UpdateRoundData(roundData);
        }

        // Tar bort en runda samt all data i tabellen RoundStat som är kopplad till rundan
        public void DeleteRound(int roundId)
        {
            RoundDAL.DeleteRound(roundId);
        }


        // Hämtar samtliga banor
        public IEnumerable<Course> GetCourses()
        {
            return CourseDAL.GetCourses();
        }

        // Hämtar ett antal banor baserat på radindex och sidstorlek
        public IEnumerable<Course> GetCoursesPageWise(int maximumRowsint, int startRowIndex, out int totalRowCount)
        {
            return CourseDAL.GetCoursesPageWise(maximumRowsint, startRowIndex, out totalRowCount);
        }

        // Hämta bana m.h.a. CourseID
        public Course GetCourseById(int courseId)
        {
            return CourseDAL.GetCourseById(courseId);
        }

        // Sparar en ny bana i databasen
        public void InsertCourse(Course course)
        {
            // Validering av Course objekt m.h.a. Data annotation
            var validationContext = new ValidationContext(course);
            var validationResults = new List<ValidationResult>();

            if (!Validator.TryValidateObject(course, validationContext, validationResults, true))
            {
                var ex = new ValidationException();
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }

            CourseDAL.InsertCourse(course);
        }

        // Uppdaterar bana
        public void UpdateCourse(Course course)
        {
            // Validering av Course objekt m.h.a. Data annotation
            var validationContext = new ValidationContext(course);
            var validationResults = new List<ValidationResult>();

            if (!Validator.TryValidateObject(course, validationContext, validationResults, true))
            {
                var ex = new ValidationException();
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }

            CourseDAL.UpdateCourse(course);
        }

        // Tar bort en runda från databasen
        public void DeleteCourse(int courseId)
        {
            CourseDAL.DeleteCourse(courseId);
        }
    }
}