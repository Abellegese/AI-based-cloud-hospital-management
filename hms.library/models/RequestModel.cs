using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class RequestModel
    {
        public Int64 id { get; set; }
        public string RegNo { get; set; }
        public string ReqNo { get; set; }
        public string Name { get; set; }
        public string Date { get; set; }
        public string Opd { get; set; }
        public string Status { get; set; }
        public string RequestCount { get; set; }
        public string Day { get; set; }
    }
    public class RequestDailyModel
    {

    }
}
