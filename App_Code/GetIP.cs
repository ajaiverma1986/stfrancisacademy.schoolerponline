/// <summary>
/// Summary description for GetIP
/// </summary>
public class GetIP
{
    public GetIP()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetLocalIP()
    {
        string _IP = null;

        // Resolves a host name or IP address to an IPHostEntry instance.

        // IPHostEntry - Provides a container class for Internet host address information.

        System.Net.IPHostEntry _IPHostEntry = System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName());

        // IPAddress class contains the address of a computer on an IP network.

        foreach (System.Net.IPAddress _IPAddress in _IPHostEntry.AddressList)
        {
            // InterNetwork indicates that an IP version 4 address is expected

            // when a Socket connects to an endpoint

            if (_IPAddress.AddressFamily.ToString() == "InterNetwork")
            {
                _IP = _IPAddress.ToString();
            }
        }

        return _IP;
    }
}