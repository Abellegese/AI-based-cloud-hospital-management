using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IDisease : IPatientBase
    {
        string DiseaseName { get; set; }
        string Severity { get; set; }
        string Status { get; set; }
        string TreatmentType { get; set; }
        List<DiseaseModel> GetDisease { get; }
        List<DiseaseModel> GetDiseaseStatus { get; }
        List<DiseaseModel> GetDiseaseTreatmentType { get; }
        List<DiseaseModel> GetDiseaseType { get; }
        string Notes { get; set; }
        string Date { get; set; }
        string DiseaseType { get; set; }
        void BindDiseaseForPatient();
        void CreateDisease(DiseaseModel diseaseModel);
        void CreateDiseaseStatus(DiseaseModel diseaseModel);
        void CreateDiseaseTreatment(DiseaseModel diseaseModel);
        void CreateDiseaseType(DiseaseModel diseaseModel);
    }
}