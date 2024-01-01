using hms.library.models;
using System;
using System.Collections.Generic;

namespace hms.library.classes
{
    public interface IAlert
    {
        string AlertType { get; set; }
        string Bg { get; set; }
        string Date { get; set; }
        string Description { get; set; }
        string Icon { get; set; }
        string Query { get; set; }
        string Status { get; set; }
        string TransId { get; set; }
        string TransOwner { get; set; }
        string User { get; set; }
        string UserType { get; set; }
        string Who { get; set; }

        void CreateAlert();
        string CreateAlertUrl();
        List<AlertModel> GetAlert();
    }
}