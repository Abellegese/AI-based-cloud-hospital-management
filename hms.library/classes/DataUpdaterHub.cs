using Microsoft.AspNet.SignalR;

namespace hms.library.classes
{
    public class DataUpdaterHub : Hub
    {
        public static void FireRequest()
        {
            IHubContext context = GlobalHost.ConnectionManager.GetHubContext<DataUpdaterHub>();
            context.Clients.All.updater();
        }
    }
}