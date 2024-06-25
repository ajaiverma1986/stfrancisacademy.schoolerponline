using System;
using System.Data;
using System.Data.SqlClient;

public class enquiry1
{
    private DataUtility objdut = new DataUtility();

    public enquiry1()
    {
    }

    private int _cid;

    public int cid
    {
        get { return _cid; }
        set { _cid = value; }
    }

    private int _sid;

    public int sid
    {
        get { return _sid; }
        set { _sid = value; }
    }

    private string _sourcename;

    public string sourcename
    {
        get { return _sourcename; }
        set { _sourcename = value; }
    }

    private string _coursename;

    public string coursename
    {
        get { return _coursename; }
        set { _coursename = value; }
    }

    private string _sname;

    public string sname
    {
        get { return _sname; }
        set { _sname = value; }
    }

    private string _mobile1;

    public string mobile1
    {
        get { return _mobile1; }
        set { _mobile1 = value; }
    }

    private string _mobile2;

    public string mobile2
    {
        get { return _mobile2; }
        set { _mobile2 = value; }
    }

    private string _emailid;

    public string emailid
    {
        get { return _emailid; }
        set { _emailid = value; }
    }

    private int _level;

    public int level
    {
        get { return _level; }
        set { _level = value; }
    }

    private string _address;

    public string address
    {
        get { return _address; }
        set { _address = value; }
    }

    private string _city;

    public string city
    {
        get { return _city; }
        set { _city = value; }
    }

    public int insert()
    {
        SqlParameter[] param = new SqlParameter[12];
        string Query = "dbo.usp_enquiryform1";
        param[0] = new SqlParameter("@name ", sname);
        param[1] = new SqlParameter("@mobile1 ", mobile1);
        param[2] = new SqlParameter("@mobile2 ", mobile2);
        param[3] = new SqlParameter("@emailid ", emailid);
        param[4] = new SqlParameter("@level", level);
        param[5] = new SqlParameter("@courseid", cid);
        param[6] = new SqlParameter("@coursename", coursename);
        param[7] = new SqlParameter("@sid ", sid);
        param[8] = new SqlParameter("@sourcename", sourcename);

        param[9] = new SqlParameter("@address ", address);
        param[10] = new SqlParameter("@city", city);
        param[11] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[11].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, Query); //objdut.ExecuteSql(param, Query);
        if (result > 0)
        {
            return result;
        }
        else
        {
            return 0;
        }
    }
}