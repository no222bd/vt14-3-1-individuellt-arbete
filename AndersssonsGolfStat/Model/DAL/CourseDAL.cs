using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{   
    // Dataåtkomstklass som tillhandahåller metoder för interaktion med databastabellen Course 
    public class CourseDAL:DALBase
    {
        // Returnerar en lista innehållandes samtliga banor i form av Course objekt
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

                        // Populerar listan med Course objekt
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

                    // Tar bort icke nyttjade platser från listan
                    courses.TrimExcess();

                    return courses;
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid hämtning av banor från databasen.");
                }
            }
        }

        // Returnerar en lista men Course objekt basert på vilken sida i pageneringen som skall visas
        public IEnumerable<Course> GetCoursesPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var courses = new List<Course>(100);

                    var cmd = new SqlCommand("app.usp_getCoursesPageWise", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Anger parametrarna för sidindex samt sidstorlek
                    cmd.Parameters.Add("@StartRowIndex", SqlDbType.Int).Value = startRowIndex;
                    cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = maximumRows;
                    
                    // Anger OUT parametern för totala antalet poster
                    cmd.Parameters.Add("@RowCount", SqlDbType.Int).Direction = ParameterDirection.Output;

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

                    // Tilldelar variabeln totalRowCount "retur"-värdet från den lagrade proceduren
                    totalRowCount = (int)cmd.Parameters["@RowCount"].Value;

                    courses.TrimExcess();

                    return courses;
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid hämtning av banor sidvis från databasen.");
                }
            }
        }

        // Lagrar en ny bana i tabellen Course
        public void InsertCourse(Course course)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_insertCourse", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = course.Name;
                    cmd.Parameters.Add("@Par", SqlDbType.Int).Value = course.Par;
                    cmd.Parameters.Add("@Fairways", SqlDbType.Int).Value = course.Fairways;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    throw new ApplicationException(ex.Message); //"Ett fel har uppstått vid skapandet av banan i databasen.",
                }
            }
        }

        // Uppdaterar en bana i tabellen Course
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
                catch(Exception ex)
                {
                    throw new ApplicationException(ex.Message);//"Ett fel har uppstått vid uppdateringen av banan i databasen.", 
                }
            }
        }

        // Hämtar med hjälp av CourseID en bana från tabellen Course
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
                    throw new ApplicationException("Ett fel har uppstått i samband med hämtandet av banan i databasen.");
                }
            }
        }

        // Tar bort en banan ur tabellen Course
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
                    throw new ApplicationException("Ett fel har uppstått i samband med borttagning av banan i databasen.");
                }
            }
        }
    }
}