using hms.library.models;
using System.Collections.Generic;
using System.Data;

namespace hms.library.classes
{
    public interface IPatientBase
    {
        string DiagnosisNumber { get; set; }
        string Address { get; set; }
        string Age { get; set; }
        string BirthDate { get; set; }
        string City { get; set; }
        string Contact { get; set; }
        string Email { get; set; }
        string Gender { get; set; }
        string MaritalStatus { get; set; }
        string Name { get; set; }
        string RegistrationDate { get; set; }
        string RegistrationNumber { get; set; }
        string Religion { get; set; }
        string RequestNumber { get; set; }
    }
}
