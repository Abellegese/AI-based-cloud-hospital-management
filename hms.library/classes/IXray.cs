using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public interface IXray
    {
        string ImageType { get; set; }
        string ImagePath { get; set; }
        void SaveXrayImage();
    }
}
