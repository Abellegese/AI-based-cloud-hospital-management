using hms.library.classes;
using System;

namespace hms.ui.app
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetRooms();
            }
        }
        private void GetRooms()
        {
            IOpd patient = Factory.CreateOpdObj();
            ddlOpd.DataSource = patient.GetRooms();
            ddlOpd.DataValueField = "id";
            ddlOpd.DataTextField = "Name";
            ddlOpd.DataBind();
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            IUser user = Factory.CreateUserObj();
            user.UserName = txtUsername.Text;
            user.Password = txtPassword.Text;

            int res = user.LogIn();
            if (res > 0)
            {

                Session["USERNAME"] = txtUsername.Text;
                Session["OPD"] = ddlOpd.SelectedItem.Text;
                Session["Utype"] = "OPD";
                Response.Redirect("~/app/opd/dashboard.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid Username Or Password";
            }
        }
    }
}