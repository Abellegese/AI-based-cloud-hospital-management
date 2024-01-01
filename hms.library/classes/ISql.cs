using System.Data;

namespace hms.library.classes
{
    public interface ISql
    {
        string cmdText { get; set; }

        void ExecuteCud();
        DataSet ReadDataset();
        DataTable ReadTable();
    }
}