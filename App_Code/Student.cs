using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
public class Student
{
    public int ASAID { get; set; }
    public string AdmissionNo { get; set; }
    public string Name { get; set; }
    public string Classname { get; set; }
    public decimal InstallmentAmount { get; set; }
    public decimal Tax { get; set; }
    public string InstallmentDate { get; set; }
    public string InstallmentName { get; set; }
    public string FeeDescription { get; set; }
    public string DiscountDescription { get; set; }
}
public class FinancialYear
{
    public int Fyid { get; set; }
    public string FyName { get; set; }
}
public class AdminLogin
{
    public int Brid { get; set; }
    public string UserId { get; set; }
    public string UserName { get; set; }
    public int SAMID { get; set; }
    public string Api { get; set; }
    public string login { get; set; }
    public string   pass1 { get; set; }
    public string  prodid { get; set; }
    public string  Url { get; set; }
    public string custacc { get; set; }
}
public class StudentDetails
{
    public string userid { get; set; }
    public string Name { get; set; }
    public string Dob { get; set; }
    public string fathername { get; set; }
    public string address { get; set; }
    public string mobile { get; set; }
    public string photo { get; set; }
    public string CollegeName { get; set; }
    public string sessionYear { get; set; }
    public string classID { get; set; }
    public string className { get; set; }
    public string password { get; set; }
    public string studentEmailID { get; set; }
    public string SectionId { get; set; }
}

public class ResultSuccess
{
  
    public string result { get; set; }
}

public class getFeeTrans
{
    public string mmp_txn { get; set; }

    public string mer_txn { get; set; }

    public string amt { get; set; }

    public string prod { get; set; }

    public string date { get; set; }

    public string bank_txn { get; set; }

    public string f_code { get; set; }

    public string clientcode { get; set; }

    public string bank_name { get; set; }

    public string auth_code { get; set; }

    public string ipg_txn_id { get; set; }

    public string merchant_id { get; set; }

    public string desc { get; set; }

    public string discriminator { get; set; }

    public string surcharge { get; set; }

    public string CardNumber { get; set; }
}
