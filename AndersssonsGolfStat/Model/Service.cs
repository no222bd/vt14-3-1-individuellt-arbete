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
        private TableRowDAL _tableRowDAL;

        private CourseDAL CourseDAL
        {
            get { return _courseDAL ?? (_courseDAL = new CourseDAL()); }
        }

        private RoundDAL RoundDAL
        {
            get { return _roundDAL ?? (_roundDAL = new RoundDAL()); }
        }

        private TableRowDAL TableRowDAL
        {
            get { return _tableRowDAL ?? (_tableRowDAL = new TableRowDAL()); }
        }
        //------------------------------------------------------------------------------------------
        
        

        //public IEnumerable<Round> GetRounds()
        //{
        //    return RoundDAL.GetRounds();
        //}

        public IEnumerable<TableRow> GetTableRows()
        {
            return TableRowDAL.GetTableRows();
        }

        public TableRow GetTableRowByCourseId(int courseId)
        {
            return TableRowDAL.GetTableRowByRoundId(courseId);
        }

        public void InsertTableRow(TableRow tableRow)
        {
            TableRowDAL.InsertTableRow(tableRow);
        }

        public void UpdateTableRow(TableRow tableRow)
        {
            TableRowDAL.UpdateTableRow(tableRow);
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
    }
}