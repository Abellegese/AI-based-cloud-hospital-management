using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace hms.library.models
{
    public class DiagnosisModel
    {
        public long id { get; set; }
        public string DiagNo { get; set; }
        public string RegNo { get; set; }
        public string Date { get; set; }
        public string ProvDiag { get; set; }
        public string Remark { get; set; }
        public string BioChemistry { get; set; }
        public string Stool { get; set; }
        public string Blood { get; set; }
        public string Colonoscopy { get; set; }
        public string Gastroscopy { get; set; }
        public string Urine { get; set; }
        public string XRay { get; set; }
        public string Sonograph { get; set; }
        public string Others { get; set; }
        public string FinalDiag { get; set; }
        public string ECG { get; set; }
        public string Status { get; set; }
        public string Opd { get; set; }
        public string Description { get; set; }
        public string DueDate { get; set; }
        public string Notes { get; set; }
        public string MedName { get; set; }
        public string Dose { get; set; }

    }
}
