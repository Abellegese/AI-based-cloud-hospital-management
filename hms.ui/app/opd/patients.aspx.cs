using hms.library.classes;
using System;

namespace hms.ui.app.opd
{
    public partial class patients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetPatients();
            }
        }
        private void GetPatients()
        {
            IPatient patient = Factory.CreatePatientObj();
            rptrPatient.DataSource = patient
                .GetPatients();
            rptrPatient
                .DataBind();
        }
    }
}