<%@ Page Title="Registration Confirm" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="RegConfirm.aspx.cs" Inherits="BranchPanel_RegConfirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        h1 {
            font-size: 24px;
            float: right;
            color: #666;
            font-weight: normal;
            font-family: Arial, Helvetica, sans-serif;
            margin: 10px 0px 0px 0px;
            padding: 0px;
        }
        .aqs {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
            color: #333;
            line-height: 17px;
            padding: 0px 7px;
        }
            .aqs span {
                font-size: 12px;
                font-family: Arial, Helvetica, sans-serif;
                color: #000;
                font-weight: bold;
            }
        .aqs1 td {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
            color: #666;
            border-left: 1px solid #CCC;
            border-bottom: 1px solid #CCC;
            padding: 3px 7px;
        }
        .aqs2 {
            border-top: 1px solid #CCC;
            padding-left: 25px;
        }
        .aqs3 {
            border-top: 1px solid #CCC;
            border-right: 1px solid #CCC;
            text-align: center;
        }
        .aqs4 {
            border-right: 1px solid #CCC;
            text-align: right;
        }
        .clear {
            clear: both;
        }
    </style>
    <script type="text/javascript">
        function PrintGridData() {
            var printContent = document.getElementById('<%=divforprint.ClientID%>');
            var uniqueName = new Date();
            var printWindow = window.open('left=500,top=500,width=500,height=500');
            printWindow.document.write(printContent.innerHTML);
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="RegList.aspx">Student Administration</a></li>
            <li style="background: none;"><a class="active" href="#">Registration</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Registration Receipt
        </div>
        <br />
        <div class="tab-content" id="divforprint" runat="server">
            <div style="margin: 0px auto; width: 700px;">
                <table id="printT" width="700" border="0" cellspacing="0" cellpadding="0" class="aqs" background-color="red">

                    <tr>
                        <td colspan="2">
                            <img src="../images/logo_awapal.png" alt="logo" style="float: left;" />

                            <h1>Registration Receipt </h1>
                        </td>
                    </tr>
                    <tr>
                        <td height="50" style="border-bottom: 1px solid #666; padding: 20px 0px 7px 0px;"><strong>Branch Address : </strong>
                            <br />
                            <asp:Label ID="lblBranchAdd" runat="server" Text="Label"></asp:Label>
                            <br />
                            <asp:Label ID="lblBrCity" runat="server" Text="Label"></asp:Label>
                            &nbsp;<asp:Label ID="lblBrState" runat="server" Text="Label"></asp:Label>
                            &nbsp;<asp:Label ID="lblPinCode" runat="server" Text="Label"></asp:Label>
                            <br />
                        </td>

                        <td style="border-bottom: 1px solid #666; padding: 20px 0px 7px 0px;">
                            <span style="float: right; width: 200px; text-align: right;">Registration Date:&nbsp;
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></span>
                            <br />
                            <span style="float: right; width: 200px; text-align: right;"><strong>Registration No</strong>:&nbsp;
                                <asp:Label ID="lblRegistrationNo1" runat="server" Text="Label"></asp:Label></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 15px;"><strong>Name</strong>:
        <asp:Label ID="lblName" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td align="right" style="padding-top: 15px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding: 0px;">
                            <table width="700" border="0" cellspacing="0" cellpadding="0" class="aqs1">
                                <tr>
                                    <td width="27%" class="aqs2"><strong>Father's Name</strong></td>
                                    <td colspan="2" class="aqs2">
                                        <asp:Label ID="lblFatherName" runat="server" Text="Label"></asp:Label></td>
                                    <td rowspan="10" class="aqs3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Mother's Name</strong></td>
                                    <td height="8" colspan="2" valign="top">
                                        <asp:Label ID="lblMotherName" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Date of Birth</strong></td>
                                    <td height="8" colspan="2" valign="top">
                                        <asp:Label ID="lblDOB" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Applied Class</strong></td>
                                    <td height="8" colspan="2" valign="top">
                                        <asp:Label ID="lblClass" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Address</strong></td>
                                    <td height="16" colspan="2" valign="top">
                                        <asp:Label ID="lblAddress" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Contact No.</strong></td>
                                    <td colspan="2" valign="top">
                                        <asp:Label ID="lblMobile" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <td valign="top" class="aqs2"><strong>Payment Mode</strong></td>
                                <td colspan="2" valign="top">
                                    <asp:Label runat="server" ID="lblMode" Text="Label"></asp:Label></td>
                    </tr>
                    <tr runat="server" id="tr1">
                        <td valign="top" class="aqs2"><strong>Bank Name</strong></td>
                        <td colspan="2" valign="top">
                            <asp:Label ID="lblBank" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                    <tr runat="server" id="tr2">
                        <td valign="top" class="aqs2"><strong>Cheque/DD Number</strong></td>
                        <td colspan="2" valign="top">
                            <asp:Label ID="lblCDD" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3"><strong>Awapal Solutions Pvt. Ltd.</strong></td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">Authorized Signatory</td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">This is a computer generated receipt and requires no signature.</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="border-top: 1px solid #666; padding-top: 7px;">&nbsp;</td>
                    </tr>
                </table>
            </div>
        </div>
        <br />
        <asp:Button runat="server" ID="btnPrint" CssClass="button_save" Text="PRINT" OnClientClick="javascript:return PrintGridData()" />
        <asp:Button ID="btnCancel" Text="BACK" runat="server" CssClass="button_save"
            ToolTip="Click here to go to the previous page" OnClick="btnCancel_Click" />
    </div>
</asp:Content>