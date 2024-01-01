using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public interface IFollowUp
    {
        string FNo { get; set; } //Follow Up Number
        string DiseaseName { get; set; }
        string TNo { get; set; } //Treatment Number
        string TerminationPeriod { get; set; }
        string TreatmentType { get; set;}
        string FollowUptype { get; set; }
        int CheckPatientFollowUp { get; }
        int CheckFollowUpTreatmentType { get; }
        int CheckFollowUpDiseaseType { get; }
        void CreatePatientFollowUp();
        void CreateFollowUpDiseaseType();
        void CreateFollowUpTreatmentType();
        List<FollowUpModel> GetFollowUp { get; }
    }
}
