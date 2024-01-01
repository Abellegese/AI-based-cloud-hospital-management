using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace hms.library.classes
{
    public class Lab : Sql, ILab
    {
        public string TestNumber { get; set; }
        public string RegistrationNumber { get; set; }
        public string TestType { get; set; }
        public string Date { get; set; }
        public string Remark { get; set; }
        public string Description { get; set; }
        public string Opd { get; set; }
        public string Status { get; set; }
        public string Session { get; set; }
        public Lab() { }
        public void SendTestResult()
        {
            TestNumber = RegistrationNumber + '-' + DateTime.Now.ToString("dd-MM-yy");
            cmdText = "INSERT INTO Request " +
                    $"VALUES('{TestNumber}'," +
                    $"'{RegistrationNumber}'," +
                    $"'{TestType}'," +
                    $"'{Date}'," +
                    $"'{Remark}'," +
                    $"'{Opd}')";
            Execute();
            try
            {
                //Executing the command
                Execute();
                //Updating Request Table
                DataUpdaterHub.FireRequest();
                //Alerting the client for the Event Fired
                AlertHub.ShowNotificationForOpd();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<RequestModel> GetPendingRequest()
        {
            cmdText = "SELECT * FROM Request WHERE Status = 'examining' ORDER BY Date ASC";
            return GetData<RequestModel>(cmdText).ToList();
        }
        public void UpdateRequest()
        {
            Status = "completed";
            cmdText = $"UPDATE Request SET Status = '{Status}' WHERE RegNo = '{RegistrationNumber}'";
            Execute();
        }
        public void CreateOtherTest()
        {

            cmdText = "INSERT INTO " +
                "DefaultTest " +
                $"VALUES ('{RegistrationNumber}'" +
                $",'{TestNumber}'" +
                $",'{DateTime.Now}'" +
                $",'{Description}'" +
                $",'{Remark}'" +
                $",'{Status}'" +
                $",'{Opd}')";
            try
            {
                //Creating other result
                Execute();
                //Updating the status of the rquest to completed
                UpdateRequest();
                //Notifiying the opd user
                AlertHub.ShowNotificationForOpd();
                //Updating Request
                DataUpdaterHub.FireRequest();
            }
            catch (Exception)
            {
                throw;
            }
        }
        public List<DefaultTestModel> GetOtherTestResult()
        {
            Session = HttpContext
                    .Current
                    .Session["OPD"]
                    .ToString();

            return GetDataByStoredProcedure<DefaultTestModel, dynamic> (
                    "dbo.GetDefaultTest", new { TestNumber,  Session})
                    .ToList();
        }
        public List<DefaultTestModel> GetAllDefaultTestResult()
        {
            return GetDataByStoredProcedure<DefaultTestModel, dynamic>(
                    "dbo.GetAllDefaultTest", new { TestNumber})
                    .ToList();
        }
    }
}