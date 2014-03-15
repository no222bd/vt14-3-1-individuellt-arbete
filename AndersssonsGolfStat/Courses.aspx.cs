using AndersssonsGolfStat.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AndersssonsGolfStat
{
    public partial class Courses : System.Web.UI.Page
    {
        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //UpdatePanel.Visible = false;
        }

        public IEnumerable<Course> CourseListView_GetData()
        {
            return Service.GetCourses();
        }

        public void NewFormView_InsertItem(Course course)
        {
            Service.InsertCourse(course);
        }

        protected void CourseListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "New")
                InsertPanel.Visible = true;

            if (e.CommandName == "Edit")
                UpdatePanel.Visible = true;
        }

        public void UpdateFormView_UpdateItem(int CourseID)
        {
            var course = Service.GetCourseById(CourseID);

            if (TryUpdateModel(course))
            {
                Service.UpdateCourse(course);
            }
        }

        public void UpdateFormView_DeleteItem(int CourseID)
        {
            Service.DeleteCourse(CourseID);
        }

        public AndersssonsGolfStat.Model.Course UpdateFormView_GetItem([QueryString("CID")]int CourseID)
        {
            return Service.GetCourseById(CourseID);
        }
    }
}