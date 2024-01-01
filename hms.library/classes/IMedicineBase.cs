namespace hms.library.classes
{
    public interface IMedicineBase
    {
        string Dose { get; set; }
        string MedicineName { get; set; }
        string MedicineNumber { get; set; }
        string Precaution { get; set; }
        string Date { get; set; }
    }
}
