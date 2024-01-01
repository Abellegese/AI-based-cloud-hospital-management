using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class ReminderModel
    {
        public Int64 Id { get; set; }
        public string Name { get; set; }
        public string Date { get; set; }
        public string Task { get; set; }
        public string Cycle { get; set; }
        public string User { get; set; }
    }
}
