using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace AndersssonsGolfStat.Model.DAL
{
    public abstract class DALBase
    {
        static string _connectionString;

        static DALBase()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["WP12_no222bd_Gstat2ConnectionString"].ConnectionString;
        }

        protected SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}