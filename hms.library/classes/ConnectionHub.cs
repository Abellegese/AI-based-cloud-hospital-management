using Microsoft.AspNet.SignalR;
using System.Threading.Tasks;

namespace hms.library.classes
{
    public class ConnectionHub : Hub
    {
        public override Task OnConnected()
        {
            string name = Context.User.Identity.Name;

            return base.OnConnected();
        }
    }
}