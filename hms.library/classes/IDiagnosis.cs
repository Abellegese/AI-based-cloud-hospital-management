using hms.library.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public interface IDiagnosis
    {
        DateTime Date { get; set; }
        string ProvisionalDiagnosis { get; set; }
        string Remark { get; set; }
        string Biochemistry { get; set; }
        string Stool { get; set; }
        string Blood { get; set; }
        string Colonscopy { get; set; }
        string Gastroscopy { get; set; }
        string Urine { get; set; }
        string Xray { get; set; }
        string Sonography { get; set; }
        string Others { get; set; }
        string FinalDiagnosis { get; set; }
        string ECG { get; set; }
        void CreateDiagnosis();
        void EndAllDiagSessions();
        List<DiagnosisModel> GetDiagnosisData();
        List<DiagnosisModel> GetPatientDiagHistory();
        List<DiagnosisModel> GetPatientDiagnosis();
    }
}
