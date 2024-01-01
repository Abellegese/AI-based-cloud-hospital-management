using hms.library.models;
using System.Collections.Generic;
using System.Data;

namespace hms.library.classes
{
    public interface IAppointment
    {
        string DoctorName { get; set; }
        string Notes { get; set; }
        string AppointmentDate { get; set; }
        void CreateAppointment();
        List<AppointmentModel> GetAppointmentData();
        bool CheckAppointments();
        List<AppointmentModel> GetAppointmentUsers();
    }
}
