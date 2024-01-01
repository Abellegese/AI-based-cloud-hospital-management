using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class AppointmentModel
    {
        public Int64 id { get; set; }
        public string RegNo { get; set; }
        public string DiagNo { get; set; }
        public string DocName { get; set; }
        public DateTime Date { get; set; }
        public DateTime DueDate { get; set; }
        public string Notes { get; set; }
        public string Status { get; set; }
        public Int64 AppointmentCount { get; set; }
    }
}
