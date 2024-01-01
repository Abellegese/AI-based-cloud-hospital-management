namespace hms.library.classes
{
    public class Factory
    {
        public static IAlert CreateAlertObj()
        {
            return new Alert();
        }
        public static IAutomation CreateAutomationObj()
        {
            return new Automation();
        }
        public static IDocument CreateDocumentObj()
        {
            return new Documents();
        }
        public static IMedicine CreateMedicineObj()
        {
            return new Medicine();
        }
        public static IDisease CreateDiseaseObj()
        {
            return new Disease();
        }
        public static ICard CreateCardObj()
        {
            return new Card();
        }
        public static IPatient CreatePatientObj()
        {
            return new Patient();
        }
        public static IOpd CreateOpdObj()
        {
            return new Opd();
        }
        public static ILab CreateLabObj()
        {
            return new Lab();
        }
        public static IUser CreateUserObj()
        {
            return new User();
        }
        public static ISetting CreateSettingObj()
        {
            return new Setting();
        }
        public static IEmail CreateEmailObj()
        {
            return new Emailer();
        }
        public static IReport CreateReportObj()
        {
            return new Report();
        }
    }
}