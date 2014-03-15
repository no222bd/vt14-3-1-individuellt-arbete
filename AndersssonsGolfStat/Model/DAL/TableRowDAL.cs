using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{
    public class TableRowDAL : DALBase
    {
        public IEnumerable<TableRow> GetTableRows()
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                    var tableRows = new List<TableRow>(100);

                    var cmd = new SqlCommand("app.usp_getTableRows", conn);
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
                            tableRows.Add(new TableRow
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

                    tableRows.TrimExcess();

                    return tableRows;
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid hämtning av tabellrader från databasen.");
                //}
            }
        }

        public TableRow GetTableRowByRoundId(int roundId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_getTableRowByRoundId", conn);
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
                            return new TableRow
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

        public void InsertTableRow(TableRow tableRow)
        {
            using (var conn = CreateConnection())
            {
                //try
                //{
                var cmd = new SqlCommand("[app].[usp_insertTableRow]", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Date", SqlDbType.Date).Value = tableRow.Date;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = tableRow.Name;
                    cmd.Parameters.Add("@GIR", SqlDbType.TinyInt).Value = tableRow.GIR;
                    cmd.Parameters.Add("@FIR", SqlDbType.TinyInt).Value = tableRow.FIR;
                    cmd.Parameters.Add("@Putts", SqlDbType.TinyInt).Value = tableRow.Putts;
                    cmd.Parameters.Add("@Penalties", SqlDbType.TinyInt).Value = tableRow.Penalties;
                    cmd.Parameters.Add("@Strokes", SqlDbType.TinyInt).Value = tableRow.Strokes;

                   


                    conn.Open();

                    cmd.ExecuteNonQuery();
                //}
                //catch
                //{
                //    throw new ApplicationException("Ett fel har uppstått vid skapandet av tabellrad i databasen.");
                //}
            }
        }

        public void UpdateTableRow(TableRow tableRow)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    var cmd = new SqlCommand("app.usp_updateTableRow", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@RoundID", SqlDbType.Int).Value = tableRow.RoundID;
                    cmd.Parameters.Add("@Name", SqlDbType.VarChar, 30).Value = tableRow.Name;
                    cmd.Parameters.Add("@Date", SqlDbType.Date).Value = tableRow.Date;
                    cmd.Parameters.Add("@GIR", SqlDbType.TinyInt).Value = tableRow.GIR;
                    cmd.Parameters.Add("@FIR", SqlDbType.TinyInt).Value = tableRow.FIR;
                    cmd.Parameters.Add("@Putts", SqlDbType.TinyInt).Value = tableRow.Putts;
                    cmd.Parameters.Add("@Penalties", SqlDbType.TinyInt).Value = tableRow.Penalties;
                    cmd.Parameters.Add("@Strokes", SqlDbType.TinyInt).Value = tableRow.Strokes;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("Ett fel har uppstått vid uppdateringen av tabellrad i databasen.");
                }
            }
        }

        
    }
}