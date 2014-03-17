using AndersssonsGolfStat.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model
{
    public class Service
    {
        private CourseDAL _courseDAL;
        private RoundDAL _roundDAL;
        private RoundDataDAL _roundDataDAL;

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
        //------------------------------------------------------------------------------------------
        
        public IEnumerable<RoundData> GetRoundData()
        {
            return RoundDataDAL.GetRoundData();
        }

        public RoundData GetRoundDataByRoundId(int roundId)
        {
            return  RoundDataDAL.GetRoundDataByRoundId(roundId);
        }

        public void InsertRoundData(RoundData roundData)
        {
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

        public void UpdateRoundData(RoundData roundData)
        {
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

        // Round
        public void DeleteRound(int roundId)
        {
            RoundDAL.DeleteRound(roundId);
        }


        // Course
        public IEnumerable<Course> GetCourses()
        {
            return CourseDAL.GetCourses();
        }

        public IEnumerable<Course> GetCoursesPageWise(int maximumRowsint, int startRowIndex, out int totalRowCount)
        {
            return CourseDAL.GetCoursesPageWise(maximumRowsint, startRowIndex, out totalRowCount);
        }

        public Course GetCourseById(int courseId)
        {
            return CourseDAL.GetCourseById(courseId);
        }

        public void InsertCourse(Course course)
        {
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

        public void UpdateCourse(Course course)
        {
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

        public void DeleteCourse(int courseId)
        {
            CourseDAL.DeleteCourse(courseId);
        }
    }
}