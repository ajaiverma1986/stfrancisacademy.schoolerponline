using System;
using System.Collections.Generic;

[Serializable]
public class User
{
    public int UserID { get; set; }

    public int AssociatedToID { get; set; }

    public int AssociationID { get; set; }

    public string UserName { get; set; }

    public string Password { get; set; }

    public int RoleID { get; set; }

    public bool IsActive { get; set; }

    public bool IsDeleted { get; set; }

    public int CreatedByID { get; set; }

    public DateTime CreatedOn { get; set; }

    public DateTime LastLogOn { get; set; }

    public int ModByID { get; set; }

    public DateTime ModOn { get; set; }

    public int brid { get; set; }

    public List<Employee> Employees { get; set; }
}