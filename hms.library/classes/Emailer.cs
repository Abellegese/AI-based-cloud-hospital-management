using System;
using System.IO;
using System.Reflection;
using System.Threading.Tasks;
using RazorLight;
using FluentEmail.Smtp;
using FluentEmail.Razor;
using FluentEmail.Core.Interfaces;
using FluentEmail.Core;
using System.Net.Mail;
using hms.library.models;

namespace hms.library.classes
{
    public class Emailer : IEmail
    {
        public string Recipient { get; set; }
        public string Subject { get; set; }
        public string AttachmentPath { get; set; }
        public string TemplatePath { get; set; }

        public Emailer() { }
        public void SendEmail()
        {
            try
            {

                //Email.DefaultSender = new SmtpSender(() => new SmtpClient("localhost")
                //{
                //    EnableSsl = false,
                //    DeliveryMethod = SmtpDeliveryMethod.Network,
                //    Port = 25
                //});
                //Email.DefaultRenderer = new CustomRazorRenderer();

                //var email = Email
                //    .From("tim@timco.com")
                //    .To("test@test.com", "Sue")
                //    .Subject("Thanks!")
                //    .UsingTemplateFromFile(
                //    "EmailDefaultTemplate.cshtml",
                //    new ReportModel { Name = "Nestor Campos" })
                //    .Send();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public void SendEmailWithAttachment<T>(T models)
        {
            try
            {
                Email.DefaultSender = new SmtpSender(() => new SmtpClient("localhost")
                {
                    EnableSsl = false,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Port = 25
                });
                Email.DefaultRenderer = new CustomRazorRenderer();

                var email = Email
                    .From("qemersoftplatform@gmail.com")
                    .To(Recipient)
                    .Subject(Subject)
                    .UsingTemplateFromFile(
                    "ActitityReportTemplate.cshtml",
                     models)
                    .Send();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
    public class CustomRazorRenderer : ITemplateRenderer
    {
        private readonly RazorLightEngine _engine;

        public CustomRazorRenderer(string root = null)
        {
            _engine = new RazorLightEngineBuilder()
                .SetOperatingAssembly(Assembly.GetCallingAssembly())
                .UseFileSystemProject(root ?? Directory.GetCurrentDirectory())
                .UseMemoryCachingProvider()
                .Build();
        }

        public Task<string> ParseAsync<T>(string template, T model, bool isHtml = true)
        {
            dynamic viewBag = (model as IViewBagModel)?.ViewBag;
            return _engine.CompileRenderStringAsync<T>(RazorRenderer.GetHashString(template), template, model, viewBag);
        }

        string ITemplateRenderer.Parse<T>(string template, T model, bool isHtml)
        {
            return ParseAsync(template, model, isHtml).GetAwaiter().GetResult();
        }

    }
}