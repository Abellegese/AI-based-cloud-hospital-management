using hms.library.classes;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;

namespace hms.ui.app.lab
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<RequestModel> GetPendingRequest()
        {
            ILab lab = Factory.CreateLabObj();
            List<RequestModel> request = lab.GetPendingRequest();
            return request;
        }
        [WebMethod]
        public static List<DiagnosisModel> GetDiagnosisRequest(string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            List<DiagnosisModel> lst = patient.GetPatientDiagnosis();

            return lst;
        }
        [WebMethod]
        public static void SendTestResult
            (
            string regNo,
            string opd,
            string description
            )
        {
            ILab lab = Factory.CreateLabObj();

            lab.TestNumber = regNo + '-' + DateTime.Now.ToString("dd-MM-yy");
            lab.RegistrationNumber = regNo;
            lab.Opd = opd;
            lab.Status = "completed";
            lab.Description = description;
            lab.CreateOtherTest();
        }
    }
}