using hms.library.classes;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Security.AccessControl;
using System.Web.Services;
using System.Web.UI;
using System.Xml.Linq;

namespace hms.ui.app.card
{
    public partial class patients : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetPatients();
                GetRooms();
            }
        }
        [WebMethod]
        public static bool SendRequest
            (
            string regNo,
            string name,
            string opd
            )
        {

            IPatient patient = Factory.CreatePatientObj();
            patient.RequestNumber = regNo + '-' + DateTime.Now.ToString("dd-MM-yy");
            patient.RegistrationNumber = regNo;
            patient.RegistrationDate = DateTime.Now.ToString();
            patient.Name = name;
            patient.Opd = opd;
            patient.Status = "pending";
            patient.SendRequest();

            return patient.CheckRequest();
        }
        private void GetPatients()
        {
            IPatient patient = Factory.CreatePatientObj();
            rptrPatient.DataSource = patient.GetPatients();
            rptrPatient.DataBind();
        }
        private void GetRooms()
        {
            IOpd patient = Factory.CreateOpdObj();
            ddlOpd.DataSource = patient.GetRooms();
            ddlOpd.DataValueField = "id";
            ddlOpd.DataTextField = "Name";
            ddlOpd.DataBind();
        }
        protected void btnCreatePatient_Click(object sender, EventArgs e)
        {
            IPatient patient = Factory.CreatePatientObj();

            patient.RegistrationNumber = txtRegNumber.Text;
            bool isPatientFound = patient.CheckPatient();
            if (isPatientFound == false)
            {
                //Registering Patients
                patient.RegistrationDate = txtRegDate.Text;
                patient.Name = txtName.Text;
                patient.Address = txtAddress.Text;
                patient.City = txtCity.Text;
                patient.Contact = txtContact.Text;
                patient.Email = txtEmail.Text;
                patient.MaritalStatus = ddlMaritalStatus.SelectedItem.Text;
                patient.Religion = ddlReligion.SelectedItem.Text;
                patient.Gender = ddlGender.SelectedItem.Text;
                patient.BirthDate = txtBirthDate.Text;
                patient.Age = txtAge.Text;

                patient.CreatePatient();

                //Sending Requests to the OPD 
                if (request.Checked)
                {
                    patient.Opd = ddlRooms.SelectedItem.Text;
                    patient.Status = "pending";
                    patient.SendRequest();
                }
            }
            else
            {
                ScriptManager
                    .RegisterStartupScript(this, this.GetType(), "alert", "alert('Patient Exists')", true);
            }
        }
        [WebMethod]
        public static void DeletePatient(string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.DeletePatient();
        }
        [WebMethod]
        public static void UpdatePatient
            (
                string regNo, 
                string name,
                string address,
                string city, 
                string contact,
                string email, 
                string maritalStatus, 
                string religion
            ) 
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.Name = name;
            patient.Address = address;
            patient.City = city;
            patient.Contact = contact;
            patient.Email = email;
            patient.MaritalStatus = maritalStatus;
            patient.Religion = religion;
            patient.UpdatePatient();
        }
        [WebMethod]
        public static List<DiagnosisModel> GetPatientHistory(string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            return patient.GetPatientHistory();
        }
        [WebMethod]
        public static List<string> GetSearchValues(PatientModel patientModel)
        {
            IPatient patient = Factory.CreatePatientObj();
            patientModel.RegNo = patient.RegistrationNumber;
            patientModel.Name =  patient.Name;

            return patient.SearchPatient;
        }
    }
}