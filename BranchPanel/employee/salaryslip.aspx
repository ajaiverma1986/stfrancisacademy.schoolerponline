<%@ Page Language="C#" AutoEventWireup="true" CodeFile="salaryslip.aspx.cs" Inherits="salaryslip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <style type="text/css">
       #wrapper {
           width: 800px;
           margin: auto;
           text-align: center;
       }

           #wrapper h3 {
               font-weight: normal;
               font-family: Verdana;
               font-size: 13px;
           }

           #wrapper table td {
               padding: 10px;
           }
   </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
        <div style="background:#000">
    <h1><img src="../images/logo.png" style="padding:10px" /></h1>
            </div>
        <h3><strong>Awapal Solutions Pvt. Ltd.</strong> B-151 2nd Floor, Udhyog Marg Sector-6 Noida<br />Uttar Pradesh, Pin Code - 201301, INDIA<br />Pay slip for the Month of Dec’ 2014</h3>
        <div style="border:1px solid #000; width:100%; height:auto; background-image: url(../../images/watermark.png)!important">
            <table style="width:50%; float:left;text-align:left">
                <tr>
                    <td><label>Employee Name </label></td>
                    <td><strong>Shourya Verdhan Singh Sengar</strong></td>
                </tr>
                  <tr>
                    <td>Emp ID</td>
                    <td>AWS0028</td>
                </tr>
                  <tr>
                    <td>Designation</td>
                    <td>Developer</td>
                </tr>
                  <tr>
                    <td>Date of Joining</td>
                    <td>April 2 2014</td>
                </tr>
            </table>
            <table cellspacing="0" style="width:50%; float:right; border-left:1px solid #000; text-align:left; padding:0px!important; height:170px">
                <tr">
                    <td>Bank account no</td>
                    <td>83001505081</td>
                </tr>
                   <tr>
                    <td>Employee PAN</td>
                    <td><strong>DDWPS9192D</strong></td>
                </tr>
                   <tr>
                    <td>Days  Paid</td>
                    <td>28</td>
                </tr>
                   <tr>
                    <td>Leaves Taken</td>
                    <td>Nil</td>
                </tr>
            </table>
            <table cellspacing="0" style="width:100%; border-top:1PX #000 solid">
                <tr>
                    <td style=" border-bottom:#000 1px solid; width:25%; text-align:left">Earnings</td>
                    <td style=" border-bottom:#000 1px solid; border-left:1px solid #000; width:25%">Actual</td>
                    <td style="border-bottom:#000 1px solid; border-left:1px solid #000; border-right:1px solid #000; width:25%">Earned</td>
                    <td style="border-bottom:#000 1px solid; width:25%">Deductions</td>
                </tr>
                <tr>
                    <td style=" width:25%;text-align:left">Basic</td>
                    <td style="border-left:1px solid #000; width:25%">8500</td>
                    <td style="border-left:1px solid #000; width:25%">8500</td>
                    <td style="border-left:1px solid #000; width:25%">PF</td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">HRA</td>
                    <td style="border-left:1px solid #000; width:25%">5250</td>
                    <td style="border-left:1px solid #000; width:25%">5250</td>
                    <td style="border-left:1px solid #000; width:25%">ESIC</td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">CCA</td>
                    <td style="border-left:1px solid #000; width:25%">2050</td>
                    <td style="border-left:1px solid #000; width:25%">2050</td>
                    <td style="border-left:1px solid #000; width:25%">TDS</td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Medical Allowance</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%">Advance</td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Skill Allowance</td>
                    <td style="border-left:1px solid #000; width:25%">4000</td>
                    <td style="border-left:1px solid #000; width:25%">4000</td>
                    <td style="border-left:1px solid #000; width:25%">Others</td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Attendance Allowance</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Conveyance</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%">3000</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Overtime Payout</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%">1500</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                 <tr>
                    <td style=" width:25%;text-align:left">Referral Payout</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                 <tr>
                    <td style=" width:25%;text-align:left">Arrears</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%">1973</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                  <tr>
                    <td style=" width:25%;text-align:left">Leave Encashment</td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                    <td style="border-left:1px solid #000; width:25%"></td>
                </tr>
                 <tr>
                    <td style=" width:25%;text-align:left; border-top:1px solid #000;border-bottom:1px solid #000;"><strong>Gross Earnings </strong> </td>
                    <td style="border-left:1px solid #000; border-top:1px solid #000; border-bottom:1px solid #000; width:25%"><strong>28800</strong></td>
                    <td style="border-left:1px solid #000; border-top:1px solid #000; border-bottom:1px solid #000; width:25%"><strong>31273</strong></td>
                    <td style="border-left:1px solid #000; border-top:1px solid #000;border-bottom:1px solid #000; width:25%"><strong>Gross Deductions</strong></td>
                </tr>
                <tr>
                    <td style="text-align:left"><strong>Net Payable Salary</strong> </td>
                    <td colspan="3"><strong>31273(THIRTY ONE THOUSEND TWO HUNDRED SEVENTY THREE)</strong></td>
                </tr>
            </table>
        </div>
         <h3>‘’This is a computer generated Pay slip. Signature is not required.’’</h3>
    </div>
    </form>
</body>
</html>