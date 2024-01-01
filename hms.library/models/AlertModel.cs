using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class AlertModel
    {
        public Int64 Id { get; set; }
        public string Date { get; set; }
        public string Descr { get; set; }
        public string Who { get; set; }
        public string Users { get; set; }
        public string Status { get; set; }
        public string Icon { get; set; }
        public string Bg { get; set; }
        public string Query { get; set; }
        public string UserType { get; set; }
    }
}
