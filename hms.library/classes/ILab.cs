using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface ILab : IRequestStatus
    {
        string Date { get; set; }
        string Opd { get; set; }
        string RegistrationNumber { get; set; }
        string Remark { get; set; }
        string TestNumber { get; set; }
        string TestType { get; set; }
        string Description { get; set; }
        string Session { get; set; }
        string Status { get; set; }

        void CreateOtherTest();
        List<DefaultTestModel> GetAllDefaultTestResult();
        List<DefaultTestModel> GetOtherTestResult();
        void SendTestResult();
    }
}