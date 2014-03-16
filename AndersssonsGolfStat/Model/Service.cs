using AndersssonsGolfStat.Model.DAL;
using System;
using System.Collections.Generic;
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
        
        

        //public IEnumerable<Round> GetRounds()
        //{
        //    return RoundDAL.GetRounds();
        //}

        public IEnumerable<RoundData> GetRoundData()
        {
            return RoundDataDAL.GetRoundData();
        }

        public RoundData GetRoundDataByCourseId(int courseId)
        {
            return  RoundDataDAL.GetRoundDataByRoundId(courseId);
        }

        public void InsertRoundData(RoundData roundData)
        {
            RoundDataDAL.InsertRoundData(roundData);
        }

        public void UpdateRoundData(RoundData roundData)
        {
            RoundDataDAL.UpdateRoundData(roundData);
        }

        public void DeleteRound(int roundId)
        {
            RoundDAL.DeleteRound(roundId);
        }

        public IEnumerable<Course> GetCourses()
        {
            return CourseDAL.GetCourses();
        }

        public Course GetCourseById(int courseId)
        {
            return CourseDAL.GetCourseById(courseId);
        }

        public void InsertCourse(Course course)
        {
            CourseDAL.InsertCourse(course);
        }

        public void UpdateCourse(Course course)
        {
            CourseDAL.UpdateCourse(course);
        }

        public void DeleteCourse(int courseId)
        {
            CourseDAL.DeleteCourse(courseId);
        }

        public IEnumerable<RoundData> GetRoundDataPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return RoundDataDAL.GetRoundDataPageWise(maximumRows, startRowIndex, out totalRowCount);
        }
    }
}