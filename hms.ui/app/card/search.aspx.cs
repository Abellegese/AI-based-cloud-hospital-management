using hms.library.classes;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace hms.ui.app.card
{
    public partial class search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]

        public static List<string> GetSearchValues(PatientModel patientModel)
        {
            string connectionString = ConfigurationManager
            .ConnectionStrings["ConnectionString"]
            .ConnectionString;
            List<string> lst = new List<string>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = " SELECT Name FROM Patients WHERE RegNo LIKE '%" + patientModel.RegNo + "%' OR Name LIKE '%" + patientModel.Name + "%'";
                    cmd.Connection = con;
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        lst.Add(dr["Name"].ToString());
                    }
                    con.Close();
                }
            }
            return lst;
        }
    }
}