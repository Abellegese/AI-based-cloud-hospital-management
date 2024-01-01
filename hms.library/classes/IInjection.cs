namespace hms.library.classes
{
    public interface IInjection
    {
        string InjectionName { get; set; }
        string InjectionDueDate { get; set; }
        void AddInjectionSchedule();
    }
}
