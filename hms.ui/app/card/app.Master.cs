using hms.library.classes;
using System;

namespace hms.ui.app.card
{
    public partial class app : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if(!IsPostBack)
            //    GetNotif();
        }

        protected void btnCreateOpd_Click(object sender, EventArgs e)
        {
            IOpd opd = Factory.CreateOpdObj();
            opd.OpdName = txtOpdName.Text;
            opd.OpdStatus = "Active";
            opd.CreateOpd();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            IOpd opd = Factory.CreateOpdObj();
            opd.OpdName = txtOpdName.Text;
            opd.OpdStatus = "Active";
            opd.CreateOpd();
        }
        //public void GetNotif()
        //{
        //    string cs = ConfigurationManager.ConnectionStrings["MyDatabaseConnectionString1"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("select * from tblnotification", con))
        //        {

        //            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
        //            {
        //                DataTable dt = new DataTable();
        //                sda.Fill(dt);
        //                rptrNotification.DataSource = dt;
        //                rptrNotification.DataBind();
        //            }
        //        }
        //    }
        //}
    }
}