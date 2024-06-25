using System;

/// <summary>
/// Summary description for itemRight
/// </summary>
namespace itemmanager
{
    public class itemRight : IDisposable
    {
        public string studenttID { get; set; }

        public int ItemID { get; set; }

        public bool status { get; set; }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!(disposing))
            {
                return;
            }
        }
    }
}