using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{
    public class CourseDAL:DALBase
    {
        public IEnumerable<Course> GetCourses()
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var courses = new List<Course>(100);

                    var cmd = new SqlCommand("app.usp_getCourses", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        var courseIdIndex = reader.GetOrdinal("CourseID");
                        var nameIndex = reader.GetOrdinal("Name");
                        var parIndex = reader.GetOrdinal("Par");
                        var fairwaysIndex = reader.GetOrdinal("Fairways");

                        while (reader.Read())
                        {
                            courses.Add(new Course
                            {
                                CourseID = reader.GetInt32(courseIdIndex),
                                Name = reader.GetString(nameIndex),
                                Par = reader.GetByte(parIndex),
                                Fairways = reader.GetByte(fairwaysIndex)
                            });
                        }
                    }

                    courses.TrimExcess();

                    return courses;
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid hämtning av banor från databasen.");
                }
            }
        }

        public void InsertCourse(Course course)
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                    var cmd = new SqlCommand("app.usp_insertCourse", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = course.Name;
                    cmd.Parameters.Add("@Par", SqlDbType.Int).Value = course.Par;
                    cmd.Parameters.Add("@Fairways", SqlDbType.Int).Value = course.Fairways;

                    //cmd.Parameters.Add("@ContactID", SqlDbType.Int, 4).Direction = ParameterDirection.Output;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid skapandet av bana i databasen.");
                //}
            }
        }

        public void UpdateCourse(Course course)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_updateCourse", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@CourseID", SqlDbType.Int).Value = course.CourseID;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar, 30).Value = course.Name;
                    cmd.Parameters.Add("@Par", SqlDbType.TinyInt).Value = course.Par;
                    cmd.Parameters.Add("@Fairways", SqlDbType.TinyInt).Value = course.Fairways;
                   
                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid uppdateringen av bana i databasen.");
                }
            }
        }


        public Course GetCourseById(int courseId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_getCourseById", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@CourseID", SqlDbType.Int).Value = courseId;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        var courseIdIndex = reader.GetOrdinal("CourseID");
                        var nameIndex = reader.GetOrdinal("Name");
                        var parIndex = reader.GetOrdinal("Par");
                        var fairwaysIndex = reader.GetOrdinal("Fairways");

                        if (reader.Read())
                        {
                            return new Course
                            {
                                CourseID = reader.GetInt32(courseIdIndex),
                                Name = reader.GetString(nameIndex),
                                Par = reader.GetByte(parIndex),
                                Fairways = reader.GetByte(fairwaysIndex)
                            };
                        }
                    }

                    return null;
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått i samband med hämtandet av en bana i databasen.");
                }
            }
        }

        public void DeleteCourse(int courseId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_deleteCourse", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@CourseID", SqlDbType.Int).Value = courseId;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått i samband med borttagning av bana i databasen.");
                }
            }
        }
    
    
    }
}