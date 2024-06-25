using System;

public class Employee
{
    public Employee()
    {
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