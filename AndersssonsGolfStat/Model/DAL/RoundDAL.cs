using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{
    public class RoundDAL : DALBase
    {
        public void DeleteRound(int roundId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_deleteRound", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoundID", SqlDbType.Int).Value = roundId;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått i samband med borttagning av rundan i databasen.");
                }
            }
        }
    }
}

        //public IEnumerable<Round> GetRounds()
        //{
        //    using (var conn = CreateConnection())
        //    {
        //        try
        //        {
        //            var rounds = new List<Round>(100);

        //            var cmd = new SqlCommand("app.usp_GetRounds", conn);
        //            cmd.CommandType = CommandType.StoredProcedure;

        //            conn.Open();

        //            using (var reader = cmd.ExecuteReader())
        //            {
        //                var roundIdIndex = reader.GetOrdinal("RoundID");
        //                var courseIdIndex = reader.GetOrdinal("CourseID");
        //                var dateIndex = reader.GetOrdinal("Date");

        //                while (reader.Read())
        //                {
        //                    rounds.Add(new Round
        //                    {
        //                        RoundID = reader.GetInt32(roundIdIndex),
        //                        CourseID = reader.GetInt32(courseIdIndex),
        //                        Date = reader.GetDateTime(dateIndex)
        //                    });
        //                }
        //            }

        //            rounds.TrimExcess();

        //            return rounds;
        //        }
        //        catch
        //        {
        //            throw new ApplicationException("Ett fel har uppstått vid hämtning av rundor från databasen.");
        //        }
        //    }
        //}



//public void InsertRound(Round round)
//{
//    using (var conn = CreateConnection())
//    {
//        try
//        {
//            var cmd = new SqlCommand("app.usp_insertRound", conn);
//            cmd.CommandType = CommandType.StoredProcedure;

//            cmd.Parameters.Add("@CourseID", SqlDbType.Int).Value = round.CourseID;
//            cmd.Parameters.Add("@Date", SqlDbType.Date).Value = round.Date;

//            conn.Open();

//            cmd.ExecuteNonQuery();
//        }
//        catch
//        {
//            throw new ApplicationException("Ett fel har uppstått vid skapandet av runda i databasen.");
//        }
//    }
//}