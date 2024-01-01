using System.Collections.Generic;
using System.Data;

namespace hms.db.access
{
    public interface ISql
    {
        string cmdText { get; set; }
        string SqlUserName { get; set; }
        string SqlPassword { get; set; }
        void Execute();
        void ExecuteByStoredProcedure<T>(string storedProcedure, T parameters);
        IEnumerable<T> GetData<T>(string cmdText);
        DataSet ReadDataset();
        DataTable ReadTable();
    }
}