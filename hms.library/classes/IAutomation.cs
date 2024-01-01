using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IAutomation
    {
        string SettingType { get; set; }
        bool IsEnabled { get; set; }

        void AutomateAppointment();
        void AutomateEmail();
        void AutomateReport(List<ReportModel> data);
        bool CheckSettings();
        void RemoveAutomation(string jobId);
    }
}