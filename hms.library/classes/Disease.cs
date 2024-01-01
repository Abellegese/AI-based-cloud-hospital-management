using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace hms.library.classes
{
    public class Disease : Sql, IDisease
    {
        public string DiagnosisNumber
        {
            get { return RegistrationNumber + "-" + DateTime.Now.ToString("dd-MM-yy"); }
            set { }
        }
        public string DiseaseName { get; set; }
        public string Severity { get; set; }
        public string Status { get; set; }
        public string TreatmentType { get; set; }
        public string DiseaseType { get; set; }
        public string HasStatus { get; set; }
        public string Date { get; set; }
        public string Address { get; set; }
        public string Age { get; set; }
        public string BirthDate { get; set; }
        public string City { get; set; }
        public string Contact { get; set; }
        public string Email { get; set; }
        public string Gender { get; set; }
        public string MaritalStatus { get; set; }
        public string Name { get; set; }
        public string RegistrationDate { get; set; }
        public string RegistrationNumber { get; set; }
        public string Religion { get; set; }
        public string RequestNumber { get; set; }
        public string Notes { get; set; }
        public Disease()
        {
        }
        public void CreateDisease(DiseaseModel diseaseModel)
        {
            cmdText = "INSERT INTO Disease " +
                    $"VALUES('{diseaseModel.DiseaseName}'," +
                    $"'{diseaseModel.Severity}')";
            Execute();
        }
        public void CreateDiseaseStatus(DiseaseModel diseaseModel)
        {
            cmdText = "INSERT INTO DiseaseStatus " +
                    $"VALUES('{diseaseModel.DiseaseName}'," +
                    $"'{diseaseModel.Status}'," +
                    $"'{diseaseModel.HasStatus}')";
            Execute();
        }
        public void CreateDiseaseTreatment(DiseaseModel diseaseModel)
        {
            cmdText = "INSERT INTO DiseaseTreatmentType " +
                    $"VALUES('{diseaseModel.DiseaseName}'," +
                    $"'{diseaseModel.TreatmentType}')";
            Execute();
        }
        public void CreateDiseaseType(DiseaseModel diseaseModel)
        {
            cmdText = "INSERT INTO DiseaseType " +
                    $"VALUES('{diseaseModel.DiseaseName}'," +
                    $"'{diseaseModel.DiseaseType}')";
            Execute();
        }
        public void BindDiseaseForPatient()
        {

            cmdText = "INSERT INTO DiseasePositive " +
                    $"VALUES('{DiagnosisNumber}'," +
                    $"'{RegistrationNumber}'," +
                    $"'{Date}'," +
                    $"'{DiseaseName}'," +
                    $"'{DiseaseType}'," +
                    $"'{Severity}'," +
                    $"'{Notes}')";
            Execute();
        }
        public List<DiseaseModel> GetDisease
        {
            get
            {
                cmdText = "SELECT * FROM Disease";
                return GetData<DiseaseModel>(cmdText).ToList();
            }
        }
        public List<DiseaseModel> GetDiseaseStatus
        {
            get
            {
                cmdText = "SELECT * FROM DiseaseStatus";
                return GetData<DiseaseModel>(cmdText).ToList();
            }
        }
        public List<DiseaseModel> GetDiseaseTreatmentType
        {
            get
            {
                cmdText = "SELECT * FROM DiseaseTreatmentType";
                return GetData<DiseaseModel>(cmdText).ToList();
            }
        }
        public List<DiseaseModel> GetDiseaseType
        {
            get
            {
                cmdText = "SELECT * FROM DiseaseType";
                return GetData<DiseaseModel>(cmdText).ToList();
            }
        }

    }
}