using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IPatientCud
    {
        void CreatePatient();
        void DeletePatient();
        void UpdatePatient();
        List<string> SearchPatient { get; }
        List<PatientModel> GetPatientByGender { get; }
        List<AppointmentModel> GetAppointmentByStatus { get; }

        bool CheckPatient();
        bool CheckRequest();
        void EndDiagnosisSession();
        List<PatientModel> GetPatients();
        List<PatientModel> GetPatientDetails();
        int GetRequestOnProgress();
        List<DiagnosisModel> GetPatientHistory();
    }
}
