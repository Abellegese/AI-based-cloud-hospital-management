using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class SettingModel
    {
        public Int64 Id { get; set; }
        public string EnableAutomation { get; set; }
        public string EnableAppointment { get; set; }
        public string EnableReport { get; set; }
        public string EnableReminder { get; set; }
        public string EnableEmail { get; set; }
    }
}
