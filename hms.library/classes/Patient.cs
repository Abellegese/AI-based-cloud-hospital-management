using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace hms.library.classes
{
    public class Patient : Sql, IPatient
    {

        public string RegistrationNumber { get; set; }
        public string RequestNumber { get; set; }
        public string RegistrationDate { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Contact { get; set; }
        public string Email { get; set; }
        public string MaritalStatus { get; set; }
        public string Religion { get; set; }
        public string Gender { get; set; }
        public string BirthDate { get; set; }
        public string Age { get; set; }
        public string DiagnosisNumber
        {
            get { return $"{RegistrationNumber}-{Date:dd-MM-yy}"; }
            set { }
        }
        public string Dose { get; set; }
        public string MedicineName { get; set; }
        public string MedicineNumber { get; set; }
        public string Precaution { get; set; }
        public string Status { get; set; }
        public string DietAdvice { get; set; }
        public string Opd { get; set; }
        public DateTime Date
        {
            get
            {
                return DateTime.Now;
            }

            set { }
        }
        public string ProvisionalDiagnosis { get; set; }
        public string Remark { get; set; }
        public string Biochemistry { get; set; }
        public string Stool { get; set; }
        public string Blood { get; set; }
        public string Colonscopy { get; set; }
        public string Gastroscopy { get; set; }
        public string Urine { get; set; }
        public string Xray { get; set; }
        public string Sonography { get; set; }
        public string Others { get; set; }
        public string FinalDiagnosis { get; set; }
        public string ECG { get; set; }
        public string DoctorName { get; set; }
        public string Notes { get; set; }
        public string AppointmentDate { get; set; }
        public string InjectionName { get; set; }
        public string InjectionDueDate { get; set; }
        public string ReportType { get; set; }
        public string Task { get; set; }
        public string Cycle { get; set; }
        public string FNo
        {
            get { return $"FN-{RegistrationNumber}-{Date:dd-MM-yy}"; }
            set { }
        }
        public string DiseaseName { get; set; }
        public string TNo
        {
            get
            {
                return $"TN-{DiseaseName}-{FNo}";
            }
            set { }
        }
        public string TerminationPeriod { get; set; }
        public string TreatmentType { get; set; }
        public string User
        {
            get
            {
                return Factory
                    .CreateUserObj()
                    .GetUserFullName();
            }
            set { }
        }
        public string FollowUptype { get; set; }
        public string ImageType { get; set; }
        public string ImagePath { get; set; }
        public Patient() { }
        public Patient(string name) => Name = name;
        public bool CheckRequest()
        {
            bool isFound = false;
            var rowCount =  GetDataByStoredProcedure<int, dynamic>(
                                "dbo.GetCompletedDiagnosis", new { RegistrationNumber })
                                .Count();
            if (rowCount > 0)
            {
                isFound = true;
            }
            return isFound;
        }
        public bool CheckPatient()
        {
            bool isFound = false;
            var rowCount = GetDataByStoredProcedure<int, dynamic>(
                            "dbo.GetPatient", new { RegistrationNumber, Name })
                            .Count();
            if (rowCount > 0)
            {
                isFound = true;
            }
            return isFound;
        }
        public void CreatePatient()
        {
            cmdText = $"INSERT INTO Patients " +
                $"VALUES('{RegistrationNumber}'," +
                $"'{RegistrationDate}'," +
                $"'{Name}'," +
                $"'{Address}'," +
                $"'{City}'," +
                $"'{Contact}'," +
                $"'{Email}'," +
                $"'{MaritalStatus}'," +
                $"'{Religion}'," +
                $"'{Gender}'," +
                $"'{BirthDate}'," +
                $"'{Age}')";
            Execute();
        }
        public void UpdatePatient()
        {
            ExecuteByStoredProcedure<dynamic>
                (
                "dbo.UpdatePatient",
                new { RegistrationNumber, Name, Address, City, Contact, Email, MaritalStatus, Religion });

        }
        public List<string> SearchPatient
        {
            get
            {
                return GetDataByStoredProcedure<string, dynamic>("dbo.GetPatient", new { RegistrationNumber, Name }).ToList();
            }
        }

        public void DeletePatient()
        {
            ExecuteByStoredProcedure<dynamic>("dbo.DeletePatient", new { RegistrationNumber });
        }
        public void AddInjectionSchedule()
        {
            cmdText = "INSERT INTO Injection " +
                $"VALUES('{RegistrationNumber}'," +
                $"'{DiagnosisNumber}'," +
                $"'{InjectionName}'," +
                $"'{Date}'," +
                $"'{InjectionDueDate}'," +
                $"'{Notes}'," +
                $"'{Status}')";
            Execute();
        }
        public void CreateDietAdvice()
        {

        }
        public List<PatientModel> GetPatients()
        {
            cmdText = "SELECT * FROM Patients";
            return GetData<PatientModel>(cmdText).ToList();
        }
        public void SendRequest()
        {
            RequestNumber = RegistrationNumber + '-' + DateTime.Now.ToString("dd-MM-yy");

            if (CheckRequest() != true)
            {
                cmdText = "INSERT INTO Request " +
                    $"VALUES('{RegistrationNumber}'," +
                    $"'{RequestNumber}'," +
                    $"'{Name}'," +
                    $"'{RegistrationDate}'," +
                    $"'{Opd}'," +
                    $"'{Status}')";
                try
                {
                    //Executing the command
                    Execute();
                    //Updating Request Table
                    DataUpdaterHub.FireRequest();
                    //Alerting the client for the Event Fired
                    AlertHub.ShowNotificationForOpd();
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }
        public List<PatientModel> GetPatientDetails()
        {
            return GetDataByStoredProcedure<PatientModel, dynamic>(
                        "dbo.GetPatient", new { RegistrationNumber })
                        .ToList();
        }
        public int GetPendingRequestCount()
        {
            cmdText = "SELECT * FROM Request WHERE Status = 'pending' OR Status='examining'";
            int requestCount = GetData<int>(cmdText).Count();
            return requestCount;
        }
        public void UpdateRequest()
        {
            cmdText = $"UPDATE Request SET Status = '{Status}' WHERE RegNo = '{RegistrationNumber}'";
            try
            {
                //Executing the command
                Execute();
                //Updating Request Table
                DataUpdaterHub.FireRequest();
                //Alerting the client for the Event Fired
                if (Status == "examining")
                    AlertHub.ShowNotificationForLab();
                else
                    AlertHub.ShowNotificationForOpd();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<RequestModel> GetPendingRequest()
        {
            cmdText = "SELECT * FROM " +
                       "Request WHERE " +
                       "Status = 'pending' " +
                       "OR Status = 'examining' " +
                       "OR Status = 'completed' " +
                       "ORDER BY Date ASC";
            return GetData<RequestModel>(cmdText).ToList();
        }
        public void CreateDiagnosis()
        {
            cmdText = $"INSERT INTO Diagnosis " +
                $"VALUES('{DiagnosisNumber}'," +
                $"'{RegistrationNumber}'," +
                $"'{Date}'," +
                $"'{ProvisionalDiagnosis}'," +
                $"'{Remark}'," +
                $"'{Biochemistry}'," +
                $"'{Stool}'," +
                $"'{Blood}'," +
                $"'{Colonscopy}'," +
                $"'{Gastroscopy}'," +
                $"'{Urine}'," +
                $"'{Xray}'," +
                $"'{Sonography}'," +
                $"'{Others}'," +
                $"'{FinalDiagnosis}'," +
                $"'{ECG}'," +
                $"'{Status}'," +
                $"'{HttpContext.Current.Session["OPD"]}')";

            try
            {
                Execute();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<DiagnosisModel> GetPatientDiagnosis()
        {
            return GetDataByStoredProcedure<DiagnosisModel, dynamic>
                     ("dbo.GetDiagnosis", new { RegistrationNumber })
                     .ToList();
        }
        public void EndDiagnosisSession()
        {
            //Binding final diag opinion and suggestion
            cmdText = "UPDATE Diagnosis " +
                    $"SET FinalDiag = '{FinalDiagnosis}', Status = '{Status}' " +
                    $"WHERE DiagNo = '{DiagnosisNumber}'";
            Execute();
            //Closing the request
            cmdText = "UPDATE Request " +
                    $"SET Status = 'closed' " +
                    $"WHERE ReqNo = '{DiagnosisNumber}'";
            Execute();
            //Updation Request Data
            DataUpdaterHub.FireRequest();
        }
        //Methods for Getting collective patient history data
        public List<DiagnosisModel> GetDiagnosisData()
        {
            return GetDataByStoredProcedure<DiagnosisModel, dynamic>
                ("dbo.GetCompletedDiagnosis", new {RegistrationNumber}).ToList();
        }
        public List<DiagnosisModel> GetPatientDiagHistory()
        {
            List<DiagnosisModel> diagData = GetDiagnosisData();
            return diagData;
        }
        public void CreateAppointment()
        {
            cmdText = "INSERT INTO Appointment " +
                $"VALUES('{RegistrationNumber}'," +
                $"'{DiagnosisNumber}'," +
                $"'{DoctorName}'," +
                $"'{Date}'," +
                $"'{AppointmentDate}'," +
                $"'{Notes}'," +
                $"'{Status}')";
            Execute();
        }

        public List<AppointmentModel> GetAppointmentData()
        {
            cmdText = "SELECT * FROM Appointment";

            return GetData<AppointmentModel>(cmdText).ToList();
        }
        public void DeleteMedicine()
        {
        }

        public void UpdateMedicine()
        {
        }

        public bool CheckAppointments()
        {
            bool isFireable = false;
            cmdText = "SELECT * " +
                    "FROM Appointment " +
                    "WHERE DATEDIFF(day, DueDate, GETDATE()) < 10";
            int rowCount = ReadTable().Rows.Count;
            if(rowCount > 0)
            {
                isFireable = true;
            }
            return isFireable;
        }
        public void EndAllDiagSessions()
        {
            cmdText = "UPDATE Request " +
                      "SET Status = 'closed' " +
                      "WHERE status = 'pending' " +
                      "OR status = 'completed' " +
                      "OR status = 'examining'";
            Execute();
        }
        public List<AppointmentModel> GetAppointmentUsers()
        {
            cmdText = "SELECT Count(*) as count, DocName " +
                      "FROM Appointment GROUP BY DocName";

            return GetData<AppointmentModel>(cmdText).ToList();
        }
        public List<RequestModel> GetDailyRequest()
        {
            cmdText = "SELECT TOP(5) COUNT(*) AS RequestCount, DATEPART(DAY, Date) " +
                      "AS Day  FROM Request GROUP BY DATEPART(DAY, Date)";
            return GetData<RequestModel>(cmdText).ToList();
        }
        public int GetRequestOnProgress()
        {
            cmdText = $"SELECT * FROM Request WHERE Status = '{Status}'";
            return GetData<int>(cmdText).Count();
        }
        public List<DiagnosisModel> GetPatientHistory()
        {
            return GetDataByStoredProcedure<DiagnosisModel, dynamic>
                        ("dbo.GetPatientHistory", new { RegistrationNumber }).ToList();
        }
        public void CreateReminder(ReminderModel reminderModel)
        {
            cmdText = "INSERT INTO Reminder " +
                    $"VALUES('{reminderModel.Name}'," +
                    $"'{DateTime.Now}'," +
                    $"'{reminderModel.Task}'," +
                    $"'{reminderModel.Cycle}'," +
                    $"'{User}')";
            Execute();
        }
        public List<ReminderModel> GetReminder()
        {
            cmdText = $"SELECT * FROM Reminder WHERE User = '{User}'";

            return GetData<ReminderModel>(cmdText).ToList();
        }
        public void CreatePatientFollowUp()
        {
            Status = "OnProgress";
            cmdText = "INSERT INTO FollowUp " +
                    $"VALUES('{FNo}'," +
                    $"'{DiagnosisNumber}'," +
                    $"'{RegistrationNumber}'," +
                    $"'{Date}'," +
                    $"'{Status}'," +
                    $"'{FollowUptype}'," +
                    $"'{TerminationPeriod}')";
            Execute();
        }
        public void CreateFollowUpDiseaseType()
        {
            cmdText = "INSERT INTO FollowUpDisease " +
                    $"VALUES('{FNo}'," +
                    $"'{DiseaseName}'," +
                    $"'{TNo}')";
            Execute();
        }
        public void CreateFollowUpTreatmentType()
        {
            cmdText = "INSERT INTO FollowUpDiseaseTreatment " +
                    $"VALUES('{TNo}'," +
                    $"'{TreatmentType}')";
            Execute();
        }
        public void SaveXrayImage()
        {
            cmdText = "INSERT INTO XrayImages " +
                    $"VALUES('{RegistrationNumber}'," +
                    $"'{ImageType}'," +
                    $"'{ImagePath}')";
            Execute();
        }
        public int CheckPatientFollowUp
        { 
            get
            {
                cmdText  = $"SELECT * FROM FollowUp WHERE FNo = '{FNo}'";
                return GetData<int>(cmdText).Count();
            }
        }
        public int CheckFollowUpTreatmentType
        {
            get
            {
                cmdText = $"SELECT * FROM FollowUpDiseaseTreatment WHERE TNo = '{TNo}' AND TreatmentType = '{TreatmentType}'";
                return GetData<int>(cmdText).Count();
            }
        }
        public int CheckFollowUpDiseaseType
        {
            get
            {
                cmdText = $"SELECT * FROM FollowUpDisease WHERE FNo = '{FNo}' AND DiseaseName = '{DiseaseName}'";
                return GetData<int>(cmdText).Count();
            }
        }
        public List<PatientModel> GetPatientByGender
        {
            get
            {
                cmdText = $"SELECT COUNT(*) as GenderCount FROM Patients WHERE Gender = '{Gender}'";
                return GetData<PatientModel>(cmdText).ToList();
            }
        }
        public List<AppointmentModel> GetAppointmentByStatus
        {
            get
            {
                cmdText = $"SELECT COUNT(*) as AppointmentCount FROM Appointment WHERE Status = '{Status}'";
                return GetData<AppointmentModel>(cmdText).ToList();
            }
        }
        public List<FollowUpModel> GetFollowUp
        {
            get
            {
                cmdText = $"SELECT * FROM FollowUp";
                return GetData<FollowUpModel>(cmdText).ToList();
            }
        }
    }
}
