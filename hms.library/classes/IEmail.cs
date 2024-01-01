namespace hms.library.classes
{
    public interface IEmail
    {
        string Recipient { get; set; }
        string Subject { get; set; }
        string AttachmentPath { get; set; }
        string TemplatePath { get; set; }

        void SendEmail();
        void SendEmailWithAttachment<T>(T models);
    }
}