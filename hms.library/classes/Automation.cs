using FluentEmail.Core;
using Hangfire;
using Hangfire.SqlServer;
using hms.db.access;
using hms.library.models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace hms.library.classes
{
    public class Automation : Sql, IAutomation
    {
        public string SettingType { get; set; }
        public bool IsEnabled
        {
            get
            {
                return CheckSettings();
            }
            set { ; }
        }
        public bool IsFireable
        {
            get;
            set;
        }
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
        public Automation()
        {
            JobStorage.Current = new SqlServerStorage(connectionString);
        }
        public void InitiateEmailAutomation()
        {
            SettingType = "EnableEmail";
            if (IsEnabled)
            {
                RecurringJob.AddOrUpdate<IEmail>
                (
                    "Email",
                    x => x.SendEmail(),
                    Cron.Daily()
                );
            }
        }
        public void AutomateEmail()
        {
            SettingType = "EnableEmail";
            if (IsEnabled)
            {
                JobStorage.Current = new SqlServerStorage(connectionString);
                var jobId = BackgroundJob.Schedule(
                    () => Console.WriteLine("Delayed!"),
                    TimeSpan.FromDays(7)
                    );
                RecurringJob.AddOrUpdate<Emailer>
                (
                    "EmailWithoutAttachment",
                    x => x.SendEmail(),
                    Cron.Minutely()
                );
            }
            else
            {
                RemoveAutomation("EmailWithoutAttachment");
            }
        }
        public void AutomateAppointment()
        {
            SettingType = "EnableAppointment";
            IsFireable = Factory      //Check the repport Automation Table is not empty after all
                .CreatePatientObj()
                .CheckAppointments();
            if (IsEnabled)
            {
                if (IsFireable)
                {
                    JobStorage.Current = new SqlServerStorage(connectionString);
                    RecurringJob.AddOrUpdate<Alert>
                    (
                        "Appointment",
                        x => x.CreateAppointmentAlert(Factory
                            .CreatePatientObj()
                            .GetAppointmentUsers()
                        ),
                        Cron.Minutely()
                    );
                }
            }
            else
            {
                RemoveAutomation("Appointment");
            }
        }
        public void RemoveAutomation(string jobId)
        {
            RecurringJob.RemoveIfExists(jobId);
        }

        [Obsolete]
        public void AutomateReport(List<ReportModel> data) //This job has to be looped over the datatable
        {
            SettingType = "EnableReport"; 
            int rowCount = data.Count;

            if(rowCount > 0)
            {
                IsFireable = true;
            }

            if (IsEnabled)
            {
                if (IsFireable)
                {
                    for (int i = 0; i < data.Count; i++)
                    {
                        var jobId = 
                            data[i].Cycle +
                            data[i].ReportType +
                            data[i].Name +
                            data[i].RecipientAddress;

                        if (data[i].Cycle == "Daily")
                        {
                            JobStorage.Current = new SqlServerStorage(connectionString);
                            RecurringJob.AddOrUpdate<Report>
                            (
                                jobId,
                                x => x.SendReport(),
                                Cron.Minutely()
                            );
                        }
                        if (data[i].Cycle == "Monthly")
                        {
                            JobStorage.Current = new SqlServerStorage(connectionString);
                            RecurringJob.AddOrUpdate<Report>
                            (
                                jobId,
                                x => x.SendReport(),
                                Cron.DayInterval(30)
                            );
                        }
                    }
                }
            }
            else
            {
                RemoveReportAutomation(data);
            }
        }
        public void RemoveReportAutomation(List<ReportModel> data)
        {

            for (int i = 0; i < data.Count; i++)
            {
                var jobId =
                    data[i].Cycle+
                    data[i].ReportType +
                    Name +
                    data[i].RecipientAddress;
                RemoveAutomation(jobId);
            }
        }
        public void AutomateReminder()
        {
            SettingType = "EnableAppointment";

            if (IsEnabled)
            {
                if (IsFireable)
                {
                    JobStorage.Current = new SqlServerStorage(connectionString);
                    RecurringJob.AddOrUpdate<Alert>
                    (
                        "Appointment",
                        x => x.CreateAppointmentAlert(Factory
                            .CreatePatientObj()
                            .GetAppointmentUsers()
                        ),
                        Cron.Minutely()
                    );
                }
            }
            else
            {
                RemoveAutomation("Appointment");
            }
        }
        public bool CheckSettings()
        {
            cmdText = "SELECT * FROM Settings";
            var result = GetData<SettingModel>(cmdText).ToList();

            bool isEnabled = false;
            switch (SettingType)
            {
                case "EnableAutomation":
                    isEnabled = bool
                        .Parse(result[0]
                        .EnableAutomation
                        .ToLower());
                    break;
                case "EnableAppointment":
                    isEnabled = bool
                        .Parse(result[0]
                        .EnableAppointment
                        .ToLower());
                    break;
                case "EnableReport":
                    isEnabled = bool
                        .Parse(result[0]
                        .EnableReport
                        .ToLower());
                    break;
                case "EnableReminder":
                    isEnabled = bool
                        .Parse(result[0]
                        .EnableReminder
                        .ToLower());
                    break;
                case "EnableEmail":
                    isEnabled = bool
                        .Parse(result[0]
                        .EnableEmail
                        .ToLower());
                    break;
            }
            return isEnabled;

        }
    }
}