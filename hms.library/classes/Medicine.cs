using hms.db.access;
using hms.library.models;
using System.Collections.Generic;
using System.Linq;

namespace hms.library.classes
{
    public class Medicine : Sql, IMedicine
    {
        public string DiagnosisNumber { get; set; }
        public string MedicineNumber { get; set; }
        public string MedicineName { get; set; }
        public string Precaution { get; set; }
        public string Dose { get; set; }
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

        public Medicine() { }
        public void CreateMedicine(MedicineModel medicineModel)
        {
            cmdText = "INSERT INTO MedicineCatelog " +
                    $"VALUES('{medicineModel.MedicineName}'," +
                    $"'{medicineModel.Type}'," +
                    $"'{medicineModel.Precaution}')";
            Execute();
        }
        public void AddMedicineSchedule()
        {
            cmdText = "INSERT INTO Medicine " +
                $"VALUES('{RegistrationNumber}'," +
                $"'{DiagnosisNumber}'," +
                $"'{MedicineName}'," +
                $"'{Dose}'," +
                $"'{Date}')";
            Execute();
        }
        public void DeleteMedicine() { }
        public void UpdateMedicine() { }
        public List<MedicineModel> GetMedicine
        {
            get
            {
                cmdText = "SELECT * FROM MedicineCatelog";
                return GetData<MedicineModel>(cmdText).ToList();
            }
        }
    }
}