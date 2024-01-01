using hms.library.classes;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;

namespace hms.ui.app.opd
{
    public partial class app : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) 
            {
                GetAppointment();
                GetUserFullName();
                GetAutomationSetting();
                GetDiseaseName();
            }
        }
        public void GetDiseaseName()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            ddlDiseaseStatusName.DataSource = disease.GetDisease;
            ddlDiseaseStatusName.DataTextField = "DiseaseName";
            ddlDiseaseStatusName.DataBind();
            //
            ddlDiseaseNameTreatmentType.DataSource = disease.GetDisease;
            ddlDiseaseNameTreatmentType.DataTextField = "DiseaseName";
            ddlDiseaseNameTreatmentType.DataBind();
            //
            ddlDiseaseTypeName.DataSource = disease.GetDisease;
            ddlDiseaseTypeName.DataTextField = "DiseaseName";
            ddlDiseaseTypeName.DataBind();
        }

        public void GetAppointment()
        {
            IPatient patient = Factory.CreatePatientObj();

            List<AppointmentModel> dt = patient.GetAppointmentData();

            if(dt.Count > 0 )
            {
                rptrAppointment.DataSource = dt;
                rptrAppointment.DataBind();
            }
        }
        public void GetUserFullName()
        {
            IUser user = Factory.CreateUserObj(); 
            fullName.InnerText = user.GetUserFullName();
        }
        public void GetAutomationSetting()
        {
            IAutomation automationSetting = Factory.CreateAutomationObj();
            automationSetting.SettingType = "EnableAutomation";
            automation.Checked = automationSetting.CheckSettings();
            automationSetting.SettingType = "EnableAppointment";
            appointment.Checked = automationSetting.CheckSettings();
            automationSetting.SettingType = "EnableEmail";
            email.Checked = automationSetting.CheckSettings();
            automationSetting.SettingType = "EnableReport";
            report.Checked = automationSetting.CheckSettings();
        }
    }
}