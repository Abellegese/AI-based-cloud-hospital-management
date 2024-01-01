using hms.db.access;
using hms.library.models;
using System.Linq;
using System.Web;

namespace hms.library.classes
{
    public class User : Sql, IUser
    {
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string UserType { get; set; }
        public string Status { get; set; }
        public User() { }

        public void CreateCustomerUser()
        {

        }
        public void RemoveCustomerUser()
        {

        }
        public void CreateAdminUser()
        {

        }
        public void UpdateAdminUserStatus() { }
        public void UpdateAdminUserCredentials() { }
        public int LogIn()
        {
            SqlUserName = UserName;
            SqlPassword = Password;
            return GetDataByStoredProcedure<string, dynamic>
                ("dbo.Login", new { SqlUserName, SqlPassword }).Count();
        }
        public void LogOut() { }
        public string GetUserFullName()
        {
            UserName = HttpContext
                .Current
                .Session["USERNAME"]
                .ToString();
            var result = GetDataByStoredProcedure<UserModel, dynamic>(
                                "dbo.GetUser", new { UserName });
            int rowCount = result.Count();
            if (rowCount > 0)
            {
                Name = result.ToList()[0].Name;
            }
            return Name;

        }
    }
}