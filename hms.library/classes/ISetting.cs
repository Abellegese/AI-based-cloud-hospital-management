using hms.library.models;

namespace hms.library.classes
{
    public interface ISetting
    {
        string EnableAppointment { get; set; }
        string EnableAutomation { get; set; }
        string EnableEmail { get; set; }
        string EnableReminder { get; set; }
        string EnableReport { get; set; }

        void UpdateAutomationSettings(SettingModel setting);
    }
}