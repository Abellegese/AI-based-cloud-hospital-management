using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class ReportModel
    {
        public string ReportType { get; set; }
        public string RecipientAddress { get; set; }
        public string Cycle { get; set; }
        public string StartDate { get; set; }
        public string Notes { get; set; }
        public string Name { get; set; }
        //Report Parameter
        public string RequestCount { get; set; }
    }
}
