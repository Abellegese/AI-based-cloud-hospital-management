using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class DefaultTestModel
    {
        public Int64 id { get; set; }
        public string RegNo { get; set; }
        public string TestNo { get; set; }
        public string TestDate { get; set; }
        public string Description { get; set; }
        public string Remark { get; set; }
        public string Status { get; set; }
        public string Opd { get; set; }
    }
}
