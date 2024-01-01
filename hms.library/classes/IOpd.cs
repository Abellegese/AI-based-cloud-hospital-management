using hms.library.models;
using System.Collections.Generic;
using System.Data;

namespace hms.library.classes
{
    public interface IOpd
    {
        string OpdName { get; set; }
        string OpdStatus { get; set; }
        void CreateOpd();
        List<RoomModel> GetRooms();
    }
}