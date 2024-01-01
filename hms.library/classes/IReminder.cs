using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public interface IReminder
    {
        string Task { get; set; }
        string Cycle { get; set; }
        string User { get; set; }
        void CreateReminder(ReminderModel reminderModel);
        List<ReminderModel> GetReminder();
    }
}
