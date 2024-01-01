using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IMedicineCud
    {
        List<MedicineModel> GetMedicine { get; }
        void CreateMedicine(MedicineModel medicineModel);
        void DeleteMedicine();
        void UpdateMedicine();
        void AddMedicineSchedule();
    }
}
