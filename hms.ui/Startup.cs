using Hangfire;
using Hangfire.SqlServer;
using Microsoft.Owin;
using Owin;
using System;
using System.Threading.Tasks;

[assembly: OwinStartup(typeof(hms.ui.Startup))]

namespace hms.ui
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            GlobalConfiguration.Configuration
                .UseSqlServerStorage("ConnectionString");

            app.UseHangfireDashboard();
            app.UseHangfireServer();
            app.MapSignalR();
        }
    }
}
