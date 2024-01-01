namespace hms.library
{
    public interface IRequestBase
    {
        string Opd { get; set; }
        string Status { get; set; }
        void SendRequest();
        int GetPendingRequestCount();
    }
}
