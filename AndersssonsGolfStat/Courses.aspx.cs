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

        }

        public IEnumerable<Course> CourseListView_GetData()
        {
            try
            {
                return Service.GetCourses();
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
                return null;
            }
        }

        public void NewFormView_InsertItem(Course course)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    Service.InsertCourse(course);

                    ShowMessage(String.Format("Sparandet av banan {0} lyckades.", course.Name));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError(String.Empty, ex);
                }
            }
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
            try
            {
                var course = Service.GetCourseById(CourseID);
                if (course == null)
                {
                    ModelState.AddModelError(String.Empty, String.Format("Banan med ID:et {0} hittades inte i databasen.", CourseID));
                    return;
                }

                if (TryUpdateModel(course))
                {
                    Service.UpdateCourse(course);
                    ShowMessage(String.Format("Uppdaterandet av banan {0} lyckades.", course.Name));
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
            }
        }

        public void UpdateFormView_DeleteItem(int CourseID)
        {
            try
            {
                Service.DeleteCourse(CourseID);
                ShowMessage("Borttagandet av banan lyckades.");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
            }
        }

        public Course UpdateFormView_GetItem([QueryString("CID")]int CourseID)
        {
            try
            {
                return Service.GetCourseById(CourseID);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(String.Empty, ex);
                return null;
            }

        }

        // Visar meddelande efter lyckad operation

        private void ShowMessage(string msg)
        {
            MessageLiteral.Text = msg;
            MessagePanel.Visible = true;
        }
    }
}