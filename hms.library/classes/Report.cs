using FluentEmail.Core;
using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace hms.library.classes
{
    public class Report : Sql, IReport
    {
        public string ReportType { get; set; }
        public string RecipientAddress { get; set; }
        public string Cycle { get; set; }
        public DateTime StartDate { get; set; }
        public string Notes { get; set; }
        public string Name
        {
            get
            {
                return Factory
                        .CreateUserObj()
                        .GetUserFullName();
            }

            set { }
        }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public Report() { }
        public void CreateReportAutomation(ReportModel reportModel)
        {
            cmdText = $"INSERT INTO ReportAutomation " +
                $"VALUES('{reportModel.ReportType}'," +
                $"'{reportModel.RecipientAddress}'," +
                $"'{reportModel.Cycle}'," +
                $"'{reportModel.StartDate}'," +
                $"'{reportModel.Notes}'," +
                $"'{Name}')";
            Execute();
        }
        public List<ReportModel> GetAutomatedReportByName
        {
            get
            {
                cmdText = $"SELECT * FROM ReportAutomation WHERE Name = '{Name}'";
                return GetData<ReportModel>(cmdText).ToList();
            }
        }
        public List<ReportModel> GetAutomatedReport
        {
            get
            {
                cmdText = $"SELECT * FROM ReportAutomation";
                return GetData<ReportModel>(cmdText).ToList();
            }
        }
        public void SendReport()
        {
            var data = GetAutomatedReport;
            for (int i = 0; i < data.Count; i++)
            {
                if (data[i].Cycle == "Daily") //Put the condition for the cycle of report being  consumed
                {
                    if (data[i].ReportType == "Activity") //Put the condition for the type of report being  consumed
                    {
                        FromDate = Convert.ToDateTime(data[i].StartDate);
                        ToDate = FromDate.AddDays(3);
                        var result = GetActivityReport();
                        //Sending Email
                        var email = Factory.CreateEmailObj();
                        email.Recipient = data[i].RecipientAddress;
                        email.Subject = data[i].Notes;
                        email.SendEmailWithAttachment<dynamic>(new { result[0].RequestCount });
                        //Creating Alert
                        IAlert alert = Factory .CreateAlertObj();
                        alert.Date = DateTime.Now.ToString();
                        alert.Description = "Daily Activity Report has been generated and sent to "+ data[i].RecipientAddress;
                        alert.Who = Name;
                        alert.User = Name;
                        alert.Status = "UnSeen";
                        alert.Icon = "bi bi-mailbox text-white";
                        alert.Bg = "icon-circle bg bg-success";
                        alert.CreateAlert();
                        //Continue with other types of report
                    }
                }
            }
        }
        public List<ReportModel> GetActivityReport()
        {
            cmdText = $"SELECT COUNT(*) AS RequestCount FROM Request WHERE Date BETWEEN '{FromDate}' AND '{ToDate}'";
            return GetData<ReportModel>(cmdText).ToList();
        }
        public void RemoveReportAutomation()
        {
            cmdText = $"DELETE FROM ReportAutomation WHERE Name = '{Name}'";
            Execute();
        }
    }
}