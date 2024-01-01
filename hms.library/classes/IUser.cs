namespace hms.library.classes
{
    public interface IUser
    {
        string Email { get; set; }
        string Name { get; set; }
        string Password { get; set; }
        string Status { get; set; }
        string UserName { get; set; }
        string UserType { get; set; }
        void CreateAdminUser();
        void CreateCustomerUser();
        string GetUserFullName();
        int LogIn();
        void LogOut();
        void RemoveCustomerUser();
        void UpdateAdminUserCredentials();
        void UpdateAdminUserStatus();
    }
}