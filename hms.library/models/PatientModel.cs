using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class PatientModel
    {
        public long id { get; set; }
        public string RegNo { get; set; }
        public DateTime RegDate { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Contact { get; set; }
        public string Email { get; set; }
        public string MaritalStatus { get; set; }
        public string Religion { get; set; }
        public string Gender { get; set; }
        public string BirthDate { get; set; }
        public string Age { get; set; }
        public Int64 GenderCount { get; set; }
    }
}
