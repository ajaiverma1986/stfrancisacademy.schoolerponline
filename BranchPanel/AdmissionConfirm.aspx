<%@ Page Title="Admission" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AdmissionConfirm.aspx.cs" Inherits="BranchPanel_AdmissionConfirm" %>

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

    <script>
    </script>
    <script type="text/javascript">
        function PrintGridData() {
            var prtGrid = document.getElementById('printT');
            prtGrid.border = 0;

            var prtwin = window.open('', 'PrintGridViewData', 'left=0,top=0,width=1000,height=700,tollbar=0,scrollbars=1,status=0,resizable=1,fontsize=20px');
            prtwin.document.write(prtGrid.outerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();
            prtwin.close();
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li style="background: none;"><a class="active" href="#">Admission</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Admission Receipt
        </div>
        <br />
        <div class="tab-content">
            <div style="margin: 0px auto; width: 700px;">
                <table id="printT" width="700" border="0" cellspacing="0" cellpadding="0" class="aqs" background-color="red">

                    <tr>
                        <td colspan="2">
                            <img src="../images/logo_awapal.png" alt="logo" style="float: left;" />

                            <h1>Admission Receipt </h1>
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
                            <%--<span style="float:right; width:75px; text-align:right;">
        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/bbg_5.jpg" /> </span><br />--%>
                            <span style="float: right; width: 200px; text-align: right;">Admission Date:&nbsp;
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></span>
                            <br />
                            <span style="float: right; width: 200px; text-align: right;"><strong>Admission No</strong>:&nbsp;
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
                                    <td rowspan="5" class="aqs3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Mother's Name</strong></td>
                                    <td height="8" colspan="2" valign="top">
                                        <asp:Label ID="lblMotherName" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Class</strong></td>
                                    <td colspan="2" valign="top">
                                        <asp:Label ID="lblClass" runat="server" Text="Label"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td valign="top" class="aqs2"><strong>Date of Birth</strong></td>
                                    <td height="8" colspan="2" valign="top">
                                        <asp:Label ID="lblDOB" runat="server" Text="Label"></asp:Label></td>
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
                            </table>
                        </td>
                    </tr>

                    <tr id="tdfee" runat="server">
                        <td style="padding-top: 15px;"><strong>Paid Fee Structure</strong>:
                        </td>
                        <td align="right" style="padding-top: 15px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding: 0px;">

                            <asp:GridView ID="GridView1" runat="server" ShowHeader="true"
                                ShowFooter="true" AutoGenerateColumns="false" GridLines="None"
                                Width="100%" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <HeaderTemplate>
                                            S.No.
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Particulars
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblParticulars" runat="server" Text='<%# Bind("transtype") %>'></asp:Label>&nbsp;
                                           <%-- <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("duration") %>'></asp:Label>--%>
                                        </ItemTemplate>
                                        <%--  <FooterTemplate>
                                                    <table width="100%" cellpadding="0px" cellspacing="0px" style="padding-right: 0px !important; margin-left: -10px;">
                                                        <tr style="font-weight: bold; margin: 0px; padding: 0px;">
                                                            <td align="left">Total
                                                            </td>
                                                        </tr>
                                                        <tr style="font-weight: bold">
                                                            <td align="left">Paid
                                                            </td>
                                                        </tr>
                                                        <tr style="font-weight: bold">
                                                            <td align="left">Balance
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </FooterTemplate>--%>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Paid Amount
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <b>Rs.  </b>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("payfee","{0:0.00}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Month
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbmonth" runat="server" Text='<%# Bind("monthname") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <%--    <tr>
                        <td colspan="2"><strong>Awapal Solutions Pvt. Ltd.</strong></td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">Authorized Signatory</td>
                    </tr>

                    <tr>
                        <td colspan="2" align="center">This is a computer generated receipt and requires no signature.</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="border-top: 1px solid #666; padding-top: 7px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td id="tdButton" align="center" colspan="2" valign="middle">
                            <%--<input id="p" class="btn btn-success button-submit " onclick="javascript:return PrintGridData()" type="image" src="../images/but_print.gif" value="Print" />--%>
                            <asp:Button runat="server" ID="btnPrint" CssClass="button_save" Text="PRINT" OnClientClick="javascript:return PrintGridData()" />
                            <br />
                            &nbsp;<asp:Button ID="btnCancel" Text="BACK" runat="server" CssClass="button_cancel"
                                ToolTip="Click here to go to the previous page"
                                OnClick="btnCancel_Click" Style="margin-left: -12px;" />

                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:LinkButton runat="server" ID="LBPayNow" Text="Pay Now"
                                OnClick="LBPayNow_Click" Visible="false" ToolTip="Click here to pay fee immidiately."></asp:LinkButton><br />
                            <asp:LinkButton runat="server" Visible="false" ID="LBPayLater" Text="Pay Later"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>