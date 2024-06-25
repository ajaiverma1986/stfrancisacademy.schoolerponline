using System.Data;

/// <summary>
/// Summary description for BLL
/// </summary>
public class BLL
{
    private DAL objUserDAL = new DAL();

    public BLL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    // (int p1,int p2,int transport,int monthid,string sfname,string smname,string slname,System.DateTime sdob,string ffname,string flname,string contactno)
    public static DataTable getclassfee(int p1, int p2, int p3, int p4, string sfname, string smname, string slname, System.DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        try
        {
            return DAL.getclassfee(p1, p2, p3, p4, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable discountfeeheadwise(string dstudentid)
    {
        try
        {
            return DAL.discountfeeheadwise_detial(dstudentid);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable getclassfee1(int p1, int p2, int p3,int fyid)
    {
        try
        {
            return DAL.getclassfee1(p1, p2, p3, fyid.ToString());
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public double getstudentid()
    {
        return objUserDAL.Getstudentmaxid();
    }

    public static DataTable getclass(int id)
    {
        return DAL.getclass(id);
    }

    public static DataTable getmedicalvacination()
    {
        return DAL.getmedicalvacination();
    }

    public DataTable bindfirst()
    {
        return objUserDAL.bindfirst();
    }

    public DataTable bindfirstsecondgrid()
    {
        return objUserDAL.bindfirstsecondgrid();
    }

    public DataTable bindfirststhirdgrid()
    {
        return objUserDAL.bindfirststhirdgrid();
    }

    public DataTable bindqualification()
    {
        return objUserDAL.bindqualification();
    }

    public static DataTable getclassfeestructure(int classid, int brid)
    {
        return DAL.getclassfeestructure(classid, brid);
    }

    public double InsertstUdentInformation(BEL objUserDetails)
    {
        try
        {
            return objUserDAL.InsertstUdentInformation(objUserDetails);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
            objUserDAL = null;
        }
    }

    public static DataTable bindpayfee(int p1, int p2, int transport, int monthid, string sfname, string smname, string slname, System.DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        try
        {
            return DAL.bindpayfee(p1, p2, transport, monthid, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindovercollection()
    {
        try
        {
            return DAL.bindovercollection();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindtransaction()
    {
        try
        {
            return DAL.bindtransaction();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindfeestructure(int p1, int p2, int transport, int monthid, string sfname, string smname, string slname, System.DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        try
        {
            return DAL.bindfeestructure(p1, p2, transport, monthid, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public DataTable binddatalist5()
    {
        try
        {
            return objUserDAL.binddatalist5();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public DataTable binddatalist()
    {
        try
        {
            return objUserDAL.binddatalist();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public DataTable bindstudentslist()
    {
        try
        {
            return objUserDAL.bindstudentslist();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindmonthwisefee()
    {
        try
        {
            return DAL.bindmonthwisefee();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindstudentfeetotal()
    {
        try
        {
            return DAL.bindstudentfeetotal();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static int countstudentwithType(string feetype)
    {
        try
        {
            return DAL.countstudentwithType(feetype);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static int counrecords()
    {
        try
        {
            return DAL.counrecords();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindstudentsrecodrs()
    {
        try
        {
            return DAL.bindstudentsrecodrs();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindclasswisefee()
    {
        try
        {
            return DAL.bindclasswisefee();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable showfinepaytime()
    {
        try
        {
            return DAL.showfinepaytime();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable recentfee()
    {
        try
        {
            return DAL.recentfee();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable recentfeeonpageload()
    {
        try
        {
            return DAL.recentfeeonpageload();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindstudentfeestruct()
    {
        try
        {
            return DAL.bindstudentfeestruct();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable bindstudentmonthfeestruct()
    {
        try
        {
            return DAL.bindstudentmonthfeestruct();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static int countrecentfee()
    {
        try
        {
            return DAL.countrecentfee();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static int counttransaction()
    {
        try
        {
            return DAL.counttransaction();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable searchstudentdatalist()
    {
        try
        {
            return DAL.searchstudentdatalist();
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public int insertpayfee(BEL objUserDetails)
    {
        try
        {
            return objUserDAL.insertpayfee(objUserDetails);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
            objUserDAL = null;
        }
    }

    public DataTable bindmonthgrid()
    {
        return objUserDAL.bindmonthgrid();
    }

    public DataTable bindmonthgrid2()
    {
        return objUserDAL.bindmonthgrid2();
    }

    public DataTable binddatalistsearch()
    {
        return objUserDAL.binddatalistsearch();
    }

    public static DataTable bindpaystructure(int adid)
    {
        try
        {
            return DAL.bindpaystructure(adid);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }

    public static DataTable getstudenttransport_detail(string p1, int p2, string mode)
    {
        try
        {
            return DAL.bindstudent_transport_detial(p1, p2, mode);
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }



    public static DataTable getclassfeenew(int classid, int p, int transport,int fyid)
    {
        try
        {
            return DAL.getclassfee1(classid, p, transport,fyid.ToString());
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
        }
    }
}