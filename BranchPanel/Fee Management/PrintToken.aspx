<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintToken.aspx.cs" Inherits="BranchPanel_Fee_Management_PrintToken" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        #tblFee, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

            #tblFee th, td {
                padding: 5px;
                text-align: left;
            }

        #t {
            border: none;
            float: right;
            text-align: center;
            width: 38%;
            margin: -43px 0 0 0;
            border-top: 2px solid black;
            border-collapse: separate;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="font-size: 14px;">
        <asp:HiddenField runat="server" ID="ResultType" Value="0" />
        <asp:GridView ID="grdSTDResult" runat="server" EmptyDataText="No data found !" BorderStyle="None" GridLines="None" OnRowCreated="OnRowCreated"
            AutoGenerateColumns="false" Width="100%" OnRowDataBound="grdSTDResult_RowDataBound">
            <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="None">
                    <HeaderStyle CssClass="HiddenCol" />
                    <ItemTemplate>
                        <asp:HiddenField ID="dfrollno" runat="server" Value='<% #Bind("ASAID")%>'></asp:HiddenField>
                        <asp:HiddenField ID="dfregno" runat="server" Value='<% #Bind("STUREGNO")%>'></asp:HiddenField>
                        <div style="width: 840px;  border: solid 1px black; padding: 10px 10px 10px 10px; margin-bottom: 245px;">
                            <br />
                            <table style="width: 100%; text-align: center; border: none; margin-top: -25px;">
                                <tr>
                                    <td style="text-align: left; border: none;"><span id="SWebsite" runat="server"></span>
                                    </td>
                                    <td style="text-align: center; border: none;"><span id="SEmailID" runat="server"></span>
                                    </td>
                                    <td style="text-align: right; border: none;">Mob: <span id="SMobile" runat="server"></span>
                                        <br />
                                        <span id="SpFone" runat="server"></span>
                                    </td>
                                </tr>
                                <%--<tr>
                                   <td style="text-align: left; border: none;width:100%" colspan="3">
                                         <img id="grdSTDResult_ctl02_Image3" class="schoollogo" src="../images/headerstmotihari.jpg" style="height:170px;width:100%;border-width:0px;">
                                    </td>
                                </tr>
                                --%>
                                <tr>
                                    <td style="text-align: left; border: none;" colspan="3">
                                        <asp:Image ID="Image1" runat="server" CssClass="schoollogo" Height="50px" Width="50px" ImageUrl="~/images/9update.png" />
                                        <div style="text-align: center; margin: -65px 0 0 0; height: 73px;">
                                            <h1 style="margin: 0; font-size: 25px"><span id="SpScool" runat="server"></span></h1>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 14px"><span id="SSAddress" runat="server"></span></h3>
                                            <h3 style="margin: 0; font-size: 7px"><span id="affhead" runat="server">Affiliation No:</span>
                                                <span id="SchoolAffia" runat="server"></span></h3>
                                            <div style="border-bottom: solid 2px black; width: 100%; font-size: 1px;"></div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border: none; text-align: center">
                                        <span style="font-size: 20px">Due Reminder/Demand Slip</span>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td colspan="3" style="border: none">
                                        <div style="height: 5px"></div>
                                        <center><span id="tc" style="border: solid 1px black; padding: 5px;border-radius: 10px 10px 10px 10px;width: 390px;font-size: 20px; font-weight: 600; color:white; background-color:black">ADMIT CARD &nbsp;&nbspAcademic Session : 2019-2020</span></center>

                                    </td>
                                </tr>--%>
                            </table>
                            <div style="text-align: left">
                                <span>Dear Guardian,</span><br />
                                <span>This is to inform you that Miss/Mr.
                                    <span id="lblStdName" runat="server" style="border: none; font-weight: 800;">Name</span>
                                    S/D/O
                                    <span id="lblFName" runat="server" style="border: none; font-weight: 800;">Name</span>
                                    is regular student of class
                                     <span id="lblClass" runat="server" style="border: none; font-weight: 800;">Name</span>
									 :Section: <span id="SpanSec" runat="server" style="border: none; font-weight: 800;">Name</span>
									 :Admi. No: <span id="lblAdnumber" runat="server" style="border: none; font-weight: 800;">Name</span>
                                    and whose fee is due in the following heads.
                                </span>
                            </div>
                            <div>
                                <table id="tblFee" style="text-align: center;width:60%">
                                    <tr><td id="tdFeedetails" runat="server"></td></tr>
                                    <tr style="font-weight: 800; display:none">
                                        <td>Month Name</td>
                                        <td>Fee Name</td>
                                        <td>Balance Amount</td>
                                    </tr>
                                    <tr style="display:none">
                                        <td><span id="SpMName" runat="server">April</span></td>
                                        <td><span id="spFeeHead" runat="server">0.00</span></td>
                                        <td><span id="SpBalance" runat="server">0.00</span></td>
                                    </tr>
                                </table>

                                <table id="t" border="1" >
                                    <tr style="font-weight: 600; border: hidden; text-align: center;">
                                        <td style="border: hidden; text-align: center;">Principal's Signature&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;Accountant Signature</td>
                                    </tr>
									
                                    <tr style="border: hidden; text-align: center;">
                                        <td style="border: hidden; text-align: center;"><span id="SpDate" runat="server">0.00</span></td>
                                    </tr>
									
                                </table>
								<table>
								<tr style="font-weight: 800; border: hidden; text-align: center;">
                                        <td style="border: hidden; text-align: center;">Note: After 15th of each month late fine will be added Rs. 100/00</td>
                                    </tr>
								</table>
								
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>

