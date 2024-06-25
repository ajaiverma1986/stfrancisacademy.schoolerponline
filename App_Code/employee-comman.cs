using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for employee_comman
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class employee_comman : System.Web.Services.WebService {

    public employee_comman () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    public int ID { get; set; }

    public int EmployeeID { get; set; }

    public int AssociatedToID { get; set; }

    public int AssociationID { get; set; }

    public string FirstName { get; set; }

    public string LastName { get; set; }

    public bool IsActive { get; set; }

    public bool IsDeleted { get; set; }

    public int CreatedByID { get; set; }

    public DateTime CreatedOn { get; set; }

    public int ModByID { get; set; }

    public DateTime ModOn { get; set; }
}
