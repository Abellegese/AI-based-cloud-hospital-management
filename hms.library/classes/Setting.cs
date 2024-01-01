using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public class Setting : Sql, ISetting
    {
        public string EnableAutomation { get; set; }
        public string EnableAppointment { get; set; }
        public string EnableReport { get; set; }
        public string EnableReminder { get; set; }
        public string EnableEmail { get; set; }
        public Setting()
        {

        }
        public void UpdateAutomationSettings(SettingModel setting)
        {
            cmdText = $"UPDATE Settings " +
                $"SET EnableAutomation = '{setting.EnableAutomation}'," +
                $"EnableAppointment = '{setting.EnableAppointment}'," +
                $"EnableReport = '{setting.EnableReport}'," +
                $"EnableReminder = '{setting.EnableReminder}'," +
                $"EnableEmail = '{setting.EnableEmail}'";
            Execute();
        }
    }
}
