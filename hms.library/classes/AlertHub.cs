using Microsoft.AspNet.SignalR;

namespace hms.library.classes
{
    public class AlertHub : Hub
    {
        public static void ShowNotificationForOpd()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<AlertHub>();
            context.Clients.All.displayOpdAlert();
        }
        public static void ShowAutomationAlertForOpd()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<AlertHub>();
            context.Clients.All.displayAutomationAlert();
        }
        public static void ShowNotificationForLab()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<AlertHub>();
            context.Clients.All.displayLabAlert();
        }
    }
}