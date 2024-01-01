using hms.library.models;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IPatient : IPatientBase,
        IPatientCud,
        IInjection,
        IDiet,
        IRequest,
        IDiagnosis,
        IAppointment,
        IReminder,
        IFollowUp,
        IXray
    {
        List<RequestModel> GetDailyRequest();
    }
}