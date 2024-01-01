using hms.library.classes;
using hms.library.models;
using hms.ui.app.card;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Security;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace hms.ui.app.opd
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["OPD"] != null)
            {
                if (!IsPostBack)
                {
                    GetDiseaseInfo();
                    GetTreatmentTypes();
                }
            }
            else
            {
                Response.Redirect("~/app/login/login.aspx"); 
            }
        }
        private void GetDiseaseInfo()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            ddlDiseaseCondion.DataSource = disease.GetDiseaseStatus;
            ddlDiseaseCondion.DataTextField = "Status";
            ddlDiseaseCondion.DataBind();
            //
            ddlDiseaseType.DataSource = disease.GetDiseaseType;
            ddlDiseaseType.DataTextField = "DiseaseType";
            ddlDiseaseType.DataBind();
            //
            ddlDiseaseNamePositive.DataSource = disease.GetDisease;
            ddlDiseaseNamePositive.DataTextField = "DiseaseName";
            ddlDiseaseNamePositive.DataBind();
            //
            ddlDiseaseNameFollowUp.DataSource = disease.GetDisease;
            ddlDiseaseNameFollowUp.DataTextField = "DiseaseName";
            ddlDiseaseNameFollowUp.DataBind();
            ddlDiseaseNameFollowUp.Items.Insert(0, new ListItem("-Select Disease-", "0"));
        }
        private void GetTreatmentTypes()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            ddlDiseaseTreatmentTypeFollowUp.DataSource = disease.GetDiseaseTreatmentType;
            ddlDiseaseTreatmentTypeFollowUp.DataTextField = "TreatmentType";
            ddlDiseaseTreatmentTypeFollowUp.DataBind();
            ddlDiseaseTreatmentTypeFollowUp.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        [WebMethod]
        public static string GetPendingRequestCount()
        {
            IPatient patient = Factory.CreatePatientObj();

            return patient
                .GetPatients()
                .ToString();
        }
        [WebMethod]
        public static void SaveDiseasePositive(
            string regNo,
            string diseaseName,
            string diseaseType,
            string severity,
            string notes)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.RegistrationNumber = regNo;
            disease.Date = DateTime.Now.ToString();
            disease.DiseaseName = diseaseName;
            disease.DiseaseType = diseaseType;
            disease.Severity = severity;
            disease.Notes = notes;
            disease.BindDiseaseForPatient();

        }
        [WebMethod]
        public static List<RequestModel> GetPendingRequest()
        {
            IPatient patient = Factory.CreatePatientObj();
            List<RequestModel> request = patient.GetPendingRequest();
            return request;
        }
        [WebMethod]
        public static void SendTestRequest
            (
            string regNo,
            string remark,
            string biochemistry,
            string stool,
            string blood,
            string colonscopy,
            string gastroscopy,
            string urine,
            string xray,
            string sonography,
            string ecg,
            string others
            )
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.Status = "examining";
            patient.UpdateRequest();
            //Creating Diagnosis Data
            patient.Date = DateTime.Now;
            patient.ProvisionalDiagnosis = "";
            patient.Remark = remark;
            patient.Biochemistry = biochemistry;
            patient.Stool = stool;
            patient.Blood = blood;
            patient.Colonscopy = colonscopy;
            patient.Gastroscopy = gastroscopy;
            patient.Urine = urine;
            patient.Xray = xray;
            patient.Sonography = sonography;
            patient.Others = others;
            patient.FinalDiagnosis = "";
            patient.ECG = ecg;
            patient.Status = "examining";
            patient.CreateDiagnosis();
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
        public static List<DefaultTestModel> GetOtherTest(string regNo)
        {
            ILab lab = Factory.CreateLabObj();

            lab.TestNumber = regNo + '-' + DateTime.Now.ToString("dd-MM-yy");
            lab.RegistrationNumber = regNo;

            return lab.GetOtherTestResult();
        }
        [WebMethod]
        public static void EndDiagSession(string finalDiag, string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.FinalDiagnosis = finalDiag;
            patient.Status = "completed";
            patient.EndDiagnosisSession();
        }
        [WebMethod]
        public static List<DiagnosisModel> GetDiagHistory(string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;

            return patient.GetPatientDiagHistory();
        }
        [WebMethod]
        public static void CreateAppointment(
            string notes,
            string dueDate,
            string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.Notes = notes;
            patient.AppointmentDate = dueDate;
            patient.Status = "OnGoing";

            IUser user = Factory.CreateUserObj();

            patient.DoctorName = user.GetUserFullName();

            patient.CreateAppointment();

        }
        [WebMethod]
        public static void CreateInjectionSchedule(string notes,
            string dueDate,
            string regNo,
            string injectionName)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.InjectionName = injectionName;
            patient.Notes = notes;
            patient.InjectionDueDate = dueDate;
            patient.Status = "OnGoing";
            patient.AddInjectionSchedule();

        }
        [WebMethod]
        public static string GetRequestCount()
        {
            IPatient patient = Factory.CreatePatientObj();

            return patient
                .GetPendingRequestCount()
                .ToString();
        }
        [WebMethod]
        public static void CreateMedicieSchedule(
            string notes,
            string medName,
            string regNo)
        {
            IMedicine medicine = Factory.CreateMedicineObj();
            medicine.RegistrationNumber = regNo;
            medicine.Dose = notes;
            medicine.MedicineName = medName;
            medicine.Date = DateTime.Now.ToString();
            medicine.AddMedicineSchedule();
        }
        //This method execute the update command
        //from app.Master page
        [WebMethod]
        public static string SaveAutomationSetting(SettingModel setting)
        {
            ISetting settings = Factory.CreateSettingObj();
            settings.UpdateAutomationSettings(setting);
            IReport report = Factory.CreateReportObj();
            var data = report.GetAutomatedReportByName;
            IAutomation automation= Factory.CreateAutomationObj();
            automation.AutomateAppointment();
            automation.AutomateEmail();
            automation.AutomateReport(data);
            return "success";
        }
        [WebMethod]
        public static void SaveReportAutomation(ReportModel reportModel)
        {
            IReport report = Factory.CreateReportObj();
            report.CreateReportAutomation(reportModel);
        }
        [WebMethod]
        public static void SaveReminder(ReminderModel reminderModel)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.CreateReminder(reminderModel);
        }
        [WebMethod]
        public static void SaveDisease(DiseaseModel diseaseModel)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.CreateDisease(diseaseModel);
        }
        [WebMethod]
        public static void SaveMedicine(MedicineModel medicineModel)
        {
            IMedicine medicine = Factory.CreateMedicineObj();
            medicine.CreateMedicine(medicineModel);
        }
        [WebMethod]
        public static void SaveDiseaseStatus(DiseaseModel diseaseModel)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.CreateDiseaseStatus(diseaseModel);
        }
        [WebMethod]
        public static void SaveDiseaseType(DiseaseModel diseaseModel)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.CreateDiseaseType(diseaseModel);
        }
        [WebMethod]
        public static void SaveDiseaseTreatmentType(DiseaseModel diseaseModel)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.CreateDiseaseTreatment(diseaseModel);
        }
        [WebMethod]
        public static int SaveFollowUpTreatmentType(string regNo, string treatmentType, string diseaseName)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.TreatmentType = treatmentType;
            patient.DiseaseName = diseaseName;
            int rowCount = patient.CheckFollowUpTreatmentType;
            if (rowCount == 0)
            {
                patient.CreateFollowUpTreatmentType();
            }
            return rowCount;
        }
        [WebMethod]
        public static int SaveFollowUpDisease(string regNo, string diseaseName)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.DiseaseName = diseaseName;
            int rowCount = patient.CheckFollowUpDiseaseType;
            if (rowCount == 0)
            {
                patient.CreateFollowUpDiseaseType();
            }
            return rowCount;
        }
        [WebMethod]
        public static int SaveFollowUp(string regNo, string followUpType, string terminatioPeriod)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.FollowUptype = followUpType;
            patient.TerminationPeriod = terminatioPeriod;
            int rowCount = patient.CheckPatientFollowUp;
            if (rowCount == 0)
            {
                patient.CreatePatientFollowUp();
            }
            return rowCount;
        }
        [WebMethod]
        public static List<DiseaseModel> GetDisease()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            return disease.GetDisease;
        }
        [WebMethod]
        public static List<MedicineModel> GetMedicine()
        {
            IMedicine medicine = Factory.CreateMedicineObj();
            return medicine.GetMedicine;
        }
        [WebMethod]
        public static List<DiseaseModel> GetDiseaseStatus()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            return disease.GetDiseaseStatus;
        }
        [WebMethod]
        public static List<DiseaseModel> GetDiseaseType()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            return disease.GetDiseaseType;
        }
        [WebMethod]
        public static List<FollowUpModel> GetFollowUp()
        {
            IPatient patient = Factory.CreatePatientObj();
            return patient.GetFollowUp;
        }
        [WebMethod]
        public static List<DiseaseModel> GetDiseaseTreatmentType()
        {
            IDisease disease = Factory.CreateDiseaseObj();
            return disease.GetDiseaseTreatmentType;
        }
        [WebMethod]
        public static void EndAllDiagSession()
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.EndAllDiagSessions();
        }
        [WebMethod]
        public static List<AlertModel> GetAlertData()
        {
            IAlert alert = Factory.CreateAlertObj();
            return alert.GetAlert();
        }
        [WebMethod]
        public static List<RequestModel> GetRequestData()
        {
            IPatient patient = Factory.CreatePatientObj();
            return patient.GetDailyRequest();
        }
        [WebMethod]
        public static List<DiagnosisModel> GetPatientHistory(string regNo)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            return patient.GetPatientHistory();
        }
        [WebMethod]
        public static List<ReportModel> GetAutomatedReport()
        {
            IReport report = Factory.CreateReportObj();

            return report.GetAutomatedReportByName;

        }
        [WebMethod]
        public static List<ReminderModel> GetReminder()
        {
            IPatient patient = Factory.CreatePatientObj();

            return patient.GetReminder();

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
        protected void Button1_Click(object sender, EventArgs e)
        {
            IDisease disease = Factory.CreateDiseaseObj();
            disease.RegistrationNumber = "002";
            disease.DiagnosisNumber = "002" + "-" + DateTime.Now.ToString("dd-MM-yy");
            disease.Date = DateTime.Now.ToString();
            disease.DiseaseName = "Malaria";
            disease.DiseaseType = "Vivax";
            disease.Severity = "Raised";
            disease.Notes = "Sample Notes";
            disease.BindDiseaseForPatient();
        }
        [WebMethod]
        public static void SaveXrayImage(string regNo, string imageType, string imagePath)
        {
            IPatient patient = Factory.CreatePatientObj();
            patient.RegistrationNumber = regNo;
            patient.ImageType = imageType;
            patient.ImagePath = imagePath;
            patient.SaveXrayImage();
        }
    }
}