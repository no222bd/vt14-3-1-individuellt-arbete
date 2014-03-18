using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AndersssonsGolfStat.Model.DAL
{
    // Dataåtkomstklass som tillhandahåller metoder för interaktion med databastabellen Round 
    public class RoundDAL : DALBase
    {
        // Tar bort en runda från tabellen Round. P.g.a. Cascade-Delete så kommer även poster i tabellen RoundStat att tas bort.
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