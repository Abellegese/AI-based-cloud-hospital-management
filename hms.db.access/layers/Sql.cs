using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Dapper;

namespace hms.db.access
{
    public class Sql : ISql
    {
        public string cmdText { get; set; }
        public string SqlUserName { get; set; }
        public string SqlPassword { get; set; }

        public string connectionString = ConfigurationManager
            .ConnectionStrings["ConnectionString"]
            .ConnectionString;
        public Sql() { }
        public Sql(string cmdText) => this.cmdText = cmdText;
        //
        // Summary:
        //     Provides sql query execution using high performance dapper access layer 
        public void Execute()
        {
            using (IDbConnection con = new SqlConnection(connectionString))
            {
                con.Execute(cmdText);
            }
        }
        //
        // Summary:
        //     Provides basic ADO.NET sql query execution
        public void ExecuteQuery()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(cmdText, con);
                con.Open();
                cmd.ExecuteScalar();
            }
        }
        //
        // Summary:
        //     Provides data access using high performance dapper access layer  
        public IEnumerable<T> GetData<T>(string cmdText)
        {
            using (IDbConnection con = new SqlConnection(connectionString))
            {
                return con.Query<T>(cmdText);
            }
        }
        public IEnumerable<T> GetDataByStoredProcedure<T, U>(string storedProcedure,
                                                             U parameters)
        {
            using (IDbConnection con = new SqlConnection(connectionString))
            {
                return con.Query<T>(storedProcedure,
                                    parameters,
                                    commandType: CommandType.StoredProcedure);
            }
        }
        public void ExecuteByStoredProcedure<T>(string storedProcedure,
                                                     T parameters)
        {
            using (IDbConnection con = new SqlConnection(connectionString))
            {
               con.Execute(storedProcedure,
                                    parameters,
                                    commandType: CommandType.StoredProcedure);
            }
        }
        public DataTable ReadTable()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(cmdText, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);

            }
            return dt;
        }
        public DataSet ReadDataset()
        {

            DataSet ds = new DataSet();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(cmdText, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            return ds;
        }
    }
}
