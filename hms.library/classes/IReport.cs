using hms.library.models;
using System;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IReport
    {
        string Cycle { get; set; }
        string Name { get; set; }
        string Notes { get; set; }
        string RecipientAddress { get; set; }
        string ReportType { get; set; }
        DateTime StartDate { get; set; }
        List<ReportModel> GetAutomatedReportByName { get; }
        DateTime FromDate { get; set; }
        DateTime ToDate { get; set; }
        List<ReportModel> GetAutomatedReport { get; }

        void CreateReportAutomation(ReportModel reportModel);
        void RemoveReportAutomation();
        void SendReport();
    }
}