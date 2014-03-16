using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{
    public class RoundDataDAL : DALBase
    {
        public IEnumerable<RoundData> GetRoundData()
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                    var roundData = new List<RoundData>(100);

                    var cmd = new SqlCommand("app.usp_getRoundData", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        var roundIdIndex = reader.GetOrdinal("RoundID");
                        var dateIndex = reader.GetOrdinal("Date");
                        var nameIndex = reader.GetOrdinal("Name");
                        var girIndex = reader.GetOrdinal("GIR");
                        var girProIndex = reader.GetOrdinal("GIRpro");
                        var firIndex = reader.GetOrdinal("FIR");
                        var firProIndex = reader.GetOrdinal("FIRpro");
                        var puttsIndex = reader.GetOrdinal("Putts");
                        var puttsAvgIndex = reader.GetOrdinal("Puttsavg");
                        var penaltiesIndex = reader.GetOrdinal("Penalties");
                        var strokesIndex = reader.GetOrdinal("Strokes");
                        var bruttoIndex = reader.GetOrdinal("Brutto");
                        var fairwaysIndex = reader.GetOrdinal("Fairways");

                        while (reader.Read())
                        {
                            roundData.Add(new RoundData
                            {
                                RoundID = reader.GetInt32(roundIdIndex),
                                Date = reader.GetDateTime(dateIndex),
                                Name = reader.GetString(nameIndex),
                                GIR = reader.GetByte(girIndex),
                                GIRpro = reader.GetFloat(girProIndex),
                                FIR = reader.GetByte(firIndex),
                                FIRpro = reader.GetFloat(firProIndex),
                                Putts = reader.GetByte(puttsIndex),
                                Puttsavg = reader.GetFloat(puttsAvgIndex),
                                Penalties = reader.GetByte(penaltiesIndex),
                                Strokes = reader.GetByte(strokesIndex),
                                Brutto = reader.GetInt32(bruttoIndex),
                                Fairways = reader.GetByte(fairwaysIndex)
                            });
                        }
                    }

                    roundData.TrimExcess();

                    return roundData;
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid hämtning av tabellrader från databasen.");
                //}
            }
        }

        public RoundData GetRoundDataByRoundId(int roundId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_getRoundDataByRoundId", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoundID", SqlDbType.Int).Value = roundId;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        var roundIdIndex = reader.GetOrdinal("RoundID");
                        var dateIndex = reader.GetOrdinal("Date");
                        var nameIndex = reader.GetOrdinal("Name");
                        var girIndex = reader.GetOrdinal("GIR");
                        var firIndex = reader.GetOrdinal("FIR");
                        var puttsIndex = reader.GetOrdinal("Putts");
                        var penaltiesIndex = reader.GetOrdinal("Penalties");
                        var strokesIndex = reader.GetOrdinal("Strokes");

                        if (reader.Read())
                        {
                            return new RoundData
                            {
                                RoundID = reader.GetInt32(roundIdIndex),
                                Date = reader.GetDateTime(dateIndex),
                                Name = reader.GetString(nameIndex),
                                GIR = reader.GetByte(girIndex),
                                FIR = reader.GetByte(firIndex),
                                Putts = reader.GetByte(puttsIndex),
                                Penalties = reader.GetByte(penaltiesIndex),
                                Strokes = reader.GetByte(strokesIndex)
                            };
                        }
                    }

                    return null;
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått i samband med hämtandet av en tabellrad i databasen.");
                }
            }
        }

        public void InsertRoundData(RoundData roundData)
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                var cmd = new SqlCommand("[app].[usp_insertRoundData]", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Date", SqlDbType.Date).Value = roundData.Date;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = roundData.Name;
                    cmd.Parameters.Add("@GIR", SqlDbType.TinyInt).Value = roundData.GIR;
                    cmd.Parameters.Add("@FIR", SqlDbType.TinyInt).Value = roundData.FIR;
                    cmd.Parameters.Add("@Putts", SqlDbType.TinyInt).Value = roundData.Putts;
                    cmd.Parameters.Add("@Penalties", SqlDbType.TinyInt).Value = roundData.Penalties;
                    cmd.Parameters.Add("@Strokes", SqlDbType.TinyInt).Value = roundData.Strokes;

                   


                    conn.Open();

                    cmd.ExecuteNonQuery();
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid skapandet av tabellrad i databasen.");
                //}
            }
        }

        public void UpdateRoundData(RoundData roundData)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_updateRoundData", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoundID", SqlDbType.Int).Value = roundData.RoundID;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar, 30).Value = roundData.Name;
                    cmd.Parameters.Add("@Date", SqlDbType.Date).Value = roundData.Date;
                    cmd.Parameters.Add("@GIR", SqlDbType.TinyInt).Value = roundData.GIR;
                    cmd.Parameters.Add("@FIR", SqlDbType.TinyInt).Value = roundData.FIR;
                    cmd.Parameters.Add("@Putts", SqlDbType.TinyInt).Value = roundData.Putts;
                    cmd.Parameters.Add("@Penalties", SqlDbType.TinyInt).Value = roundData.Penalties;
                    cmd.Parameters.Add("@Strokes", SqlDbType.TinyInt).Value = roundData.Strokes;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid uppdateringen av tabellrad i databasen.");
                }
            }
        }



        public IEnumerable<RoundData> GetRoundDataPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                var roundData = new List<RoundData>(100);

                var cmd = new SqlCommand("app.usp_getRoundDataPageWise", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@StartRowIndex", SqlDbType.Int).Value = startRowIndex;
                cmd.Parameters.Add("@PageSize", SqlDbType.Int).Value = maximumRows;
                
                cmd.Parameters.Add("@RowCount", SqlDbType.Int).Direction = ParameterDirection.Output;


                conn.Open();

                using (var reader = cmd.ExecuteReader())
                {
                    var roundIdIndex = reader.GetOrdinal("RoundID");
                    var dateIndex = reader.GetOrdinal("Date");
                    var nameIndex = reader.GetOrdinal("Name");
                    var girIndex = reader.GetOrdinal("GIR");
                    var girProIndex = reader.GetOrdinal("GIRpro");
                    var firIndex = reader.GetOrdinal("FIR");
                    var firProIndex = reader.GetOrdinal("FIRpro");
                    var puttsIndex = reader.GetOrdinal("Putts");
                    var puttsAvgIndex = reader.GetOrdinal("Puttsavg");
                    var penaltiesIndex = reader.GetOrdinal("Penalties");
                    var strokesIndex = reader.GetOrdinal("Strokes");
                    var bruttoIndex = reader.GetOrdinal("Brutto");
                    var fairwaysIndex = reader.GetOrdinal("Fairways");

                    while (reader.Read())
                    {
                        roundData.Add(new RoundData
                        {
                            RoundID = reader.GetInt32(roundIdIndex),
                            Date = reader.GetDateTime(dateIndex),
                            Name = reader.GetString(nameIndex),
                            GIR = reader.GetByte(girIndex),
                            GIRpro = reader.GetFloat(girProIndex),
                            FIR = reader.GetByte(firIndex),
                            FIRpro = reader.GetFloat(firProIndex),
                            Putts = reader.GetByte(puttsIndex),
                            Puttsavg = reader.GetFloat(puttsAvgIndex),
                            Penalties = reader.GetByte(penaltiesIndex),
                            Strokes = reader.GetByte(strokesIndex),
                            Brutto = reader.GetInt32(bruttoIndex),
                            Fairways = reader.GetByte(fairwaysIndex)
                        });
                    }
                }

                totalRowCount = (int)cmd.Parameters["@RowCount"].Value;

                roundData.TrimExcess();

                return roundData;
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid hämtning av tabellrader från databasen.");
                //}
            }
        }

    }
}