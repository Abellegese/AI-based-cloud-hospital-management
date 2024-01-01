using hms.library.models;
using System.Collections.Generic;
namespace hms.library.classes
{
    public interface IRequestStatus
    {
        List<RequestModel> GetPendingRequest();
        void UpdateRequest();
    }
}
