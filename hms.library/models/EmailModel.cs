using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.models
{
    public class EmailModel
    {
        public string Recipient { get; set; }
        public string Subject { get; set; }
        public string AttachmentPath { get; set; }
        public string TemplatePath { get; set; }
    }
}
