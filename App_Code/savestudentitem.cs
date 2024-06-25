using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for savestudentitem
/// </summary>
public class savestudentitem
{
    private DataUtility objDUT = new DataUtility();

    public int SaveRightInformation(string RightXml)
    {
        int returnValue = 0;
        SqlParameter[] RightParam = new SqlParameter[3];
        try
        {
            RightParam[0] = new SqlParameter("@ItemXml", RightXml);
            RightParam[1] = new SqlParameter("@QueryType", "SaveItem");
            RightParam[2] = new SqlParameter("@intResult", SqlDbType.Int);
            RightParam[2].Direction = ParameterDirection.Output;

            returnValue = objDUT.ExecuteSqlSP(RightParam, "[uspSaveItem]"); //SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, "[dbo].[uspModulePermission]", RightParam);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return returnValue;
    }

    public string updateORinsertHostelFee(string RegNo,int Brid,string STDFNAME,int isHostel)
    {
            string str="";
            string str1="";
            string str2="";
            string strsd="";
            int result=0;
            int result1=0;

            if(RegNo.Trim() == "")
            {
                int rid = 0;
                rid = Convert.ToInt32((objDUT.GetScalar("Select isnull(Max(Rid),0) from tbl_StudentRegistration where brid=" + Brid)));
                if (rid > 0)
                {
                    if (STDFNAME.Length > 3)
                    {
                        RegNo = STDFNAME.Substring(0, 4).Trim() + Brid + rid.ToString();
                    }
                    else
                    {
                        {
                            RegNo = STDFNAME.Substring(0, Convert.ToInt32(STDFNAME.Length)).Trim() + Brid + rid.ToString();
                        }
                    }
                }
            }

            int SturegNo = 0;
            decimal hostelFee = 0;
            strsd = @"Select ISNULL(SA.StuRegNo,'') StuRegNo from tbl_StudentRegistration SR
		                inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
		                inner join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo and SM.Brid = SA.Brid
		                Where SR.Registration_No='" + RegNo + "' ";

            SturegNo = (int)(objDUT.GetScalar(strsd));
            if (SturegNo > 0)
            {
                string strHostel = @"select isnull(Sum(FeeAmt),0) FeeAmt from mst_hostelFee where Brid=" + Convert.ToInt32(Brid);
                hostelFee = (decimal)(objDUT.GetScalar(strHostel));

                string strAsaid = "select top 1 asaid from tbl_StudentAdmissionInstallment where SturegNo=" + SturegNo + " and Brid=" + Convert.ToInt32(Brid) + " and PaymentStatusId=1";
                int ASAID = (int)(objDUT.GetScalar(strAsaid));                

                if (Convert.ToInt32(isHostel) == 1)
                {
                    str1 = @"update tbl_StudentAdmissionMaster SET FeeWithoutDiscount=(FeeWithoutDiscount+"+hostelFee+"),"+
					               " NonTaxableAmount=(NonTaxableAmount+"+hostelFee+"),PayableFeeWithoutTax =(PayableFeeWithoutTax+"+hostelFee+") "+
					               " where StuRegNo = "+ SturegNo.ToString() +" and Brid = " + Convert.ToInt32(Brid);
					
                    result = (int)(objDUT.ExecuteSql(str1));

					str2 = @"update tbl_StudentAdmissionInstallment SET HostelFee="+hostelFee+
						           " ,InstallmentAmount=(InstallmentAmount+"+hostelFee+"),NonTaxableAmount=(NonTaxableAmount+"+hostelFee+")"+
                                   " where SturegNo=" + SturegNo + " and Brid=" + Convert.ToInt32(Brid) + " and ASAID = " + ASAID + 
						           " and PaymentStatusId=1";

                    result1 = (int)(objDUT.ExecuteSql(str2));

                }
                else
                {
                   string strCount = @"Select Count(*) from tbl_StudentAdmissionInstallment where SturegNo="+SturegNo+" and Brid=" + Convert.ToInt32(Brid) + " and HostelFee <> 0";
                    int count = (int)(objDUT.GetScalar(strCount));
					if(count>0)
                    {
					str1 = @"update tbl_StudentAdmissionMaster SET FeeWithoutDiscount=(FeeWithoutDiscount-"+hostelFee+"),"+
						    " NonTaxableAmount=(NonTaxableAmount-"+hostelFee+"),PayableFeeWithoutTax =(PayableFeeWithoutTax-"+hostelFee+")"+
							" where SturegNo="+SturegNo+" and Brid=" + Convert.ToInt32(Brid);

                    result = (int)(objDUT.ExecuteSql(str1));

                    str2 = @"update tbl_StudentAdmissionInstallment SET InstallmentAmount=(InstallmentAmount-ISNULL(HostelFee,0)),
							NonTaxableAmount=(NonTaxableAmount-ISNULL(HostelFee,0)),TransPortAmt=0.0  where SturegNo="+SturegNo+
                            " and Brid=" + Convert.ToInt32(Brid)+" and HostelFee <> 0";                    
                    result1 = (int)(objDUT.ExecuteSql(str2));
                    }
                }
            }
            return RegNo;
    }
}