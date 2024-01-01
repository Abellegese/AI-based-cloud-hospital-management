using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hms.db.access
{
    public class Factory
    {
        public static ISql CreateSqlObj()
        {
            return new Sql();
        }
    }
}
