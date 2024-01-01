using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace hms.library.classes
{
    public class Alert : Sql, IAlert
    {
        public string Date { get; set; }
        public string Description { get; set; }
        public string Who { get; set; }
        public string User { get; set; }
        public string Status { get; set; }
        public string Icon { get; set; }
        public string Bg { get; set; }
        public string Query { get; set; }
        public string UserType { get; set; }
        public string AlertType { get; set; }
        public string TransId { get; set; }
        public string TransOwner { get; set; }
        public Alert() { }

        public void CreateAlert()
        {
            Query = CreateAlertUrl();

            cmdText = "INSERT INTO Alert VALUES (" +
                    "'" + Date + "'," +
                    "'" + Description + "'," +
                    "'" + Who + "'," +
                    "'" + User + "'," +
                    "'" + Status + "'," +
                    "'" + Icon + "'," +
                    "'" + Bg + "'," +
                    "'" + Query + "'," +
                    "'" + UserType + "')";
            Execute();
        }
        public string CreateAlertUrl()
        {
            string url = string.Empty;

            return url;
        }
        public void CreateAppointmentAlert(List<AppointmentModel> userList)
        {
            Date = DateTime.Now.ToString("dd MMM yyyy");
            User = Who;
            Status = "UnSeen";
            Query = string.Empty;
            UserType = "OPD";
            Icon = "bi bi-clock text-white";
            Bg = "icon-circle bg bg-warning";
            Description = "You have appointment for " + userList.Count + " patients. Please check it.";
            for (int i = 0; i < userList.Count; i++)
            {
                cmdText = "INSERT INTO Alert VALUES (" +
                    "'" + Date + "'," +
                    "'" + Description + "'," +
                    "'" + userList[i].DocName + "'," +
                    "'" + userList[i].DocName + "'," +
                    "'" + Status + "'," +
                    "'" + Icon + "'," +
                    "'" + Bg + "'," +
                    "'" + Query + "'," +
                    "'" + UserType + "')";
                Execute();
            }
            AlertHub.ShowAutomationAlertForOpd();
        }
        public List<AlertModel> GetAlert()
        {
            Who = Factory
                .CreateUserObj()
                .GetUserFullName();
            cmdText = $"SELECT * FROM Alert WHERE Users = '{Who}'";

            return GetData<AlertModel>(cmdText).ToList();
        }
    }
}
