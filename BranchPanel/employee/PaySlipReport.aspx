<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaySlipReport.aspx.cs" Inherits="BranchPanel_employee_PaySlipReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div id="divforprint" style="border: solid 2px black">
                <div style="border: solid 2px black">
                    <div style="padding: 20px">
                        <table width="100%">
                            <tr>
                                <td>
                                    <div style="">
                                        <h1>
                                            <asp:Image runat="server" ID="Image1"  ImageUrl="../../images/logo.png" style="padding: 10px; width: 100px; height: 100px" /></h1>
                                    </div>
                                </td>
                                <td style="float:right">
                                    <div style="font-size:10px">
                                     <div style="font-size:30px"><span runat="server" id="CompanyName" style="font-size:20px"></span></div>
                                     <span runat="server" id="Add"  style=""></span><br />
                                        <span runat="server" id="Add1" style=""></span><br />
                                        <span runat="server" id="SpFone" style=""></span><br />
                                         <span runat="server" id="SMobile" style=""></span><br />
                                         <span runat="server" id="SEmailID" style=""></span><br />
                                        <span runat="server" id="SWebsite" style=""></span><br />
                                        </div>                               
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align:center"><h3> PAY SLIP FOR THE MONTH OF <span runat="server" id="mont" style="">N/A</span></h3></td>
                            </tr>
                        </table>
                        <%-- <div style="border: 1px solid #000; width: 100%; height: auto; background-image: url(../../images/watermark.png)!important">--%>
                        <table style="width: 50%; float: left; text-align: left">
                            <tr>
                                <td>
                                    <label>Employee Name </label>
                                </td>
                                <td>
                                     <asp:Label ID="lblsalaryname" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Emp ID</td>
                                <td>
                                    <asp:Label ID="lblsalaryempid" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Designation</td>
                                <td>
                                    <asp:Label ID="lblsalarydesignation" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Date of Joining</td>
                                <td>
                                    <asp:Label ID="lblsalarydoj" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Days  Paid</td>
                                <td>
                                    <asp:Label ID="lblsalarypaidday" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Toatal Half Days</td>
                                <td>
                                    <asp:Label ID="lblHalfDays" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                        </table>
                       <table style="width: 50%; float: left; text-align: right">
                           <tr>
                                <td>Bank Name</td>
                                <td>
                                    <asp:Label ID="lblSalaryBankName" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Bank account no</td>
                                <td>
                                    <asp:Label ID="lblsalarybankaccno" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Employee PAN</td>
                                <td>
                                    <asp:Label ID="lblsalaryemppanno" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Working Day</td>
                                <td>
                                    <asp:Label ID="lblsalaryWorkingpaidday" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>Leaves Taken</td>
                                <td>
                                    <asp:Label ID="lblsalaryleavetaken" runat="server" Text="----------"></asp:Label></td>
                            </tr>
                        </table>
                        <table cellspacing="0" style="width: 100%; border-top: 1PX #000 solid">
                            <tr>
                                <td style="border-bottom: #000 1px solid; border-left: 1px solid #000; width: 25%; text-align: left; padding:0 0 0 10px">Earnings</td>
                                <td style="border-bottom: #000 1px solid; border-left: 1px solid #000; border-right: 1px solid #000; width: 25%; padding:0 0 0 10px">Amount</td>
                                 <td style="border-bottom: #000 1px solid; width: 25%; padding:0 0 0 10px">Deductions</td>
                                <td style="border-bottom: #000 1px solid; border-left: 1px solid #000; border-right: 1px solid #000; width: 25%; padding:0 0 0 10px">Amount</td>
                               
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Basic</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalarybasicactual" runat="server" Text="----------"></asp:Label></td>
                                 <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">PF</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalarybasicearned" runat="server" Text="----------"></asp:Label></td>                               
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">HRA</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalaryPFaearned" runat="server" Text="----------"></asp:Label></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">ESIC</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalaryESIaearned" runat="server" Text="----------"></asp:Label></td>                                
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">CCA</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalaryccaactual" runat="server" Text="----------"></asp:Label></td>
                                 <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">TDS</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalarytdsearned" runat="server" Text="----------"></asp:Label></td>                               
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Medical Allowance</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">                                     
                                    <asp:Label ID="lblsalarymedicalactual" runat="server" Text="----------"></asp:Label></td>
                                 <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">Advance</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalaryAdvnearned" runat="server" Text="----------"></asp:Label></td>                              
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Skill Allowance</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalaryskillallowanceactual" runat="server" Text="----------"></asp:Label></td>
                                 <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">Others</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalaryskillallowanceearned" runat="server" Text="----------"></asp:Label></td>                               
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Attendance Allowance</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalaryattendenceallowanceactual" runat="server" Text="----------"></asp:Label></td>
                                 <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalaryattendanceallowanceearned" runat="server" Text="----------"></asp:Label></td>                               
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Conveyance</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;">
                                    <asp:Label ID="lblsalaryconveyanceactual" runat="server" Text="----------"></asp:Label></td>
                                   <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;">
                                    <asp:Label ID="lblsalaryconveyanceearned" runat="server" Text="----------"></asp:Label></td>
                              </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Overtime Payout</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;"></td>                           
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Referral Payout</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;"></td>                                
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Arrears</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>                            
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;"></td>
                                </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; padding:0 0 0 10px; border-left: 1px solid #000;">Leave Encashment</td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000;"></td>
                                <td style="border-left: 1px solid #000; width: 25%; padding:0 0 0 10px; border-left: 1px solid #000; border-right: 1px solid #000;"></td>                                
                            </tr>
                            <tr>
                                <td style="width: 25%; text-align: left; border-top: 1px solid #000; border-bottom: 1px solid #000; border-left: 1px solid #000;"><strong>Gross Earnings </strong></td>
                                <td style="border-left: 1px solid #000; border-top: 1px solid #000; border-bottom: 1px solid #000; width: 25%"><strong>
                                    <asp:Label ID="lblgrossearningactual" runat="server" Text="----------"></asp:Label></strong></td>
                                <td style="border-left: 1px solid #000; border-top: 1px solid #000; border-bottom: 1px solid #000; width: 25%"><strong>
                                    <asp:Label ID="lblgrossearningearned" runat="server" Text="----------"></asp:Label></strong></td>
                                <td style="border-left: 1px solid #000; border-top: 1px solid #000; border-bottom: 1px solid #000; width: 25%; border-right: 1px solid #000;"><strong>
                                    <asp:Label ID="lblgrossdeduction" runat="server" Text="----------"></asp:Label></strong></td>
                            </tr>
                            <tr>
                                <td style="text-align: left"><strong>Net Payable Salary</strong> </td>
                                <td colspan="3"><strong><asp:Label ID="lblNetPaySalary" runat="server" Text="----------"></asp:Label></strong>
                                    <strong>(<asp:Label ID="lblNetPaySalaryAlp" runat="server" Text="----------"></asp:Label>)</strong></td>
                            </tr>
                        </table>

                        <h3>‘’This is a computer generated Pay slip. Signature is not required.’’</h3>
                    </div>
                </div>
            </div>    
    </form>
</body>
</html>
