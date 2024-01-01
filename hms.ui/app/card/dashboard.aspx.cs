using hms.library.classes;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Web.Services;

namespace hms.ui.app.card
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<int> GetRequestProgress()
        {
            IPatient patient = Factory.CreatePatientObj();
            List<int> requestCounts = new List<int>();
            patient.Status = "pending";
            int pendingRequest = patient.GetRequestOnProgress();
            patient.Status = "examining";
            int examiningRequest = patient.GetRequestOnProgress();
            requestCounts.Add(pendingRequest);
            requestCounts.Add(examiningRequest);
            return requestCounts;
        }
        [WebMethod]
        public static List<Int64> GetPatientByGender()
        {
            IPatient patient = Factory.CreatePatientObj();
            List<Int64> genderCount = new List<Int64>();
            Int64 maleCount = 0;
            Int64 femaleCount = 0;
            patient.Gender = "Male";
            if (patient.GetPatientByGender.Count > 0)
            {
                maleCount = patient.GetPatientByGender[0].GenderCount;
            }
            patient.Gender = "Female";
            if (patient.GetPatientByGender.Count > 0)
            {
                femaleCount = patient.GetPatientByGender[0].GenderCount;
            }
            genderCount.Add(maleCount);
            genderCount.Add(femaleCount);
            return genderCount;
        }
        [WebMethod]
        public static List<Int64> GetAppointmentByStatus()
        {
            IPatient patient = Factory.CreatePatientObj();
            List<Int64> appointmentCount = new List<Int64>();
            Int64 ongoingCount = 0;
            Int64 duePassesCount = 0;
            Int64 completedCount = 0;
            patient.Status = "OnGoing";
            if (patient.GetAppointmentByStatus.Count > 0)
            {
                ongoingCount = patient.GetAppointmentByStatus[0].AppointmentCount;
            }
            patient.Status = "Due Passed";
            if (patient.GetAppointmentByStatus.Count > 0)
            {
                duePassesCount = patient.GetAppointmentByStatus[0].AppointmentCount;
            }
            patient.Status = "Completed";
            if (patient.GetAppointmentByStatus.Count > 0)
            {
                completedCount = patient.GetAppointmentByStatus[0].AppointmentCount;
            }
            appointmentCount.Add(ongoingCount);
            appointmentCount.Add(duePassesCount);
            appointmentCount.Add(completedCount);
            return appointmentCount;
        }
    }
}