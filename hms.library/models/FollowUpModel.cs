using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class FollowUpModel
    {
        
        /// <summary>
        /// Follow Up Models
        /// </summary>
        public string FNo { get; set; } 
        public string DiagNo { get; set; } 
        public string RegNo { get; set; } 
        public string Date { get; set; } 
        public string Status { get; set; } 
        public string FollowUptype { get; set; } 
        public string TerminationPeriod { get; set; }
        /// <summary>
        /// Follow Disease Up Models
        /// </summary>
        public string DiseaseName { get; set; }
        public string TNo { get; set; }
        /// <summary>
        /// Follow Up Disease Treatment Models
        /// </summary>
        public string TreatmentType { get; set; }
    }
}
