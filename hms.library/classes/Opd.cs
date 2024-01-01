using hms.db.access;
using hms.library.models;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace hms.library.classes
{
    public class Opd : Sql, IOpd
    {
        public string OpdName { get; set; }
        public string OpdStatus { get; set; }
        public Opd() { }
        public void CreateOpd()
        {
            cmdText = "INSERT INTO Rooms " +
                 $"VALUES('{OpdName}'," +
                 $"'{OpdStatus}')";
            Execute();
        }
        public List<RoomModel> GetRooms()
        {
            cmdText = "SELECT * FROM Rooms";
            return GetData<RoomModel>(cmdText).ToList();
        }
    }
}