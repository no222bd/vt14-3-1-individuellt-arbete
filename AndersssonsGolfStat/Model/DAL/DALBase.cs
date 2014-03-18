using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace AndersssonsGolfStat.Model.DAL
{
    // Abstrakt klass som tillhandahåller en anslutning till ärvande klasser
    public abstract class DALBase
    {
        static string _connectionString;

        // Statisk konstruktor som initialiseras med anslutningssträngen
        static DALBase()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["WP12_no222bd_Gstat2ConnectionString"].ConnectionString;
        }

        // Returnerar en anslutning till databasen
        protected SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}