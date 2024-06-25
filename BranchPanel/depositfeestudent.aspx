<%@ Page Title="Deposite Fee" Language="C#" AutoEventWireup="true" CodeFile="depositfeestudent.aspx.cs"
    MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_depositfeestudent" %>

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
            //border-left:1px solid #CCC;
            border-bottom: 1px solid #CCC;
            padding: 3px 7px;
        }

        .aqs2 {
            border-top: 1px solid #CCC;
            background: #f1f1f1;
            padding-left: 25px;
        }

        .aqs3 {
            border-top: 1px solid #CCC;
            border-right: 1px solid #CCC;
            background: #f1f1f1;
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
            var prtGrid = document.getElementById('pp');
            prtGrid.border = 0;

            var prtwin = window.open('', 'PrintGridViewData', 'left=0,top=0,width=1000,height=700,tollbar=0,scrollbars=1,status=0,resizable=1,fontsize=20px');
            prtwin.document.write(prtGrid.outerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();
            prtwin.close();
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            var username = '<%= Session["Adid"] %>';

        });
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Fee Management </a></li>
            <li><a href="#">Fee Collection </a></li>
            <li style="background: none;"><a class="active" href="getDistID.aspx?type=FS">Fee Receipt
            </a></li>
            <div class="arrowt">
                <a href="studentadmissionlistaspx.aspx">
                    <img src="../images/back-button.png" /></a>
            </div>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <%--<iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>--%>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Fee Receipt
        </div>
        <br />
        <div class="tab-content" id="pp">
            <div style="margin: 0px auto; width: 700px;">
                <table width="700" border="0" cellspacing="0" cellpadding="0" class="aqs" background-color="red">
                    <tr>
                        <td colspan="2">
                            <img src="../images/logosmall.png" alt="logo" style="float: left;" />
                            <h1>Fee  Receipt
                            </h1>
                        </td>
                    </tr>
                    <tr>
                        <td height="50" style="border-bottom: 1px solid #666; padding: 20px 0px 7px 0px;">
                            <strong>Address</strong>
                            <br />
                            <%-- 97 Sant Nagar East of Kailash--%>
                            <br />
                            <%--  New Delhi 110065--%>
                        </td>
                        <td style="border-bottom: 1px solid #666; padding: 20px 0px 7px 0px;">
                            <span style="float: right; width: 200px; text-align: right;">Date of Payment: &nbsp;<asp:Label runat="server" ID="lblDate"></asp:Label></span><br />
                            <span style="float: right; width: 200px; text-align: right;">Receipt No: &nbsp;
                                <asp:Label ID="lblreceiptno" runat="server"></asp:Label></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 15px;">
                            <strong>Name</strong>:&nbsp;
                            <asp:Label ID="lblname" runat="server"></asp:Label>
                        </td>
                        <td align="right" style="padding-top: 15px;">
                            <strong>Academic Year</strong>: &nbsp;
                            <asp:Label runat="server" ID="lblYear"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Class</strong>: &nbsp;
                            <asp:Label runat="server" ID="lblClass"></asp:Label>
                        </td>
                        <td align="right">
                            <strong>Admission No</strong>:&nbsp;<asp:Label ID="lblrollno" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td>
                            <strong>Paid fees : </strong>
                            <asp:Label ID="lblmonth23" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <%--  <tr>
                        <td colspan="2" style="padding: 0px;">
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">
                            <table width="700" border="0" cellspacing="0" cellpadding="0" class="aqs1">
                                <tr>
                                    <td>
                                        <span></span>
                                    </td>
                                    <asp:GridView ID="GridView1" runat="server" ShowHeader="true"
                                        ShowFooter="true" AutoGenerateColumns="false" GridLines="None"
                                        Width="100%" CssClass="stm" OnRowDataBound="GridView1_RowDataBound">
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
                                                <FooterTemplate>
                                                    <table width="100%" cellpadding="0px" cellspacing="0px" style="padding-right: 0px !important; margin-left: -10px;">
                                                        <tr style="font-weight: bold; margin: 0px; padding: 0px;">
                                                            <td align="left">Total
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Amount
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <b>Rs.  </b>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Credit","{0:0.00}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <table width="100%" cellpadding="0px" style="margin-left: -10px;">
                                                        <tr style="font-weight: bold">
                                                            <td>Rs.
                                                                <asp:Label ID="lblTotalcredit" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Month
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmonth" runat="server" Text='<%# Bind("MonthName") %>'></asp:Label>&nbsp;
                                           <%-- <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("duration") %>'></asp:Label>--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="stm_dark" />
                                        <HeaderStyle CssClass="stm_head" />
                                        <AlternatingRowStyle CssClass="stm_light" />
                                    </asp:GridView>
                                </tr>
                            </table>

                            <tr>
                                <td style="padding-top: 15px;">
                                    <strong>Fee Details</strong>:&nbsp;
                                </td>
                            </tr>

                            <%--  <table width="700" border="0" cellspacing="0" cellpadding="0" class="aqs1">
                                <tr>
                                    <td>
                                        <span></span>
                                    </td>
                                    <asp:GridView ID="GridView2" runat="server" ShowHeader="true"
                                        ShowFooter="true"  AutoGenerateColumns="false" GridLines="None"
                                        Width="100%" CssClass="stm">
                                        <Columns>

                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Total Fee
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lbtotalfee" runat="server" Text='<%# Bind("totalfees","{0:0.00}") %>'></asp:Label>&nbsp;
                                           <%-- <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("duration") %>'></asp:Label>--%>
                            <%-- </ItemTemplate>
                                            </asp:TemplateField>
                                           <asp:TemplateField>
                                                <HeaderTemplate>--%>
                            <%-- Paid Fee
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lbpaidfee" runat="server" Text='<%# Bind("paidamount","{0:0.00}") %>'></asp:Label>&nbsp;
                                           <%-- <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("duration") %>'></asp:Label>--%>
                            <%-- </ItemTemplate>
                                            </asp:TemplateField>

                                              <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Balance Fee
                                                </HeaderTemplate>
                                                <ItemTemplate>--%>
                            <%-- <asp:Label ID="lbbalfee" runat="server" Text='<%# Bind("balancefee","{0:0.00}") %>'></asp:Label>&nbsp;--%>
                            <%-- <asp:Label runat="server" ID="lblDuration" Text='<%# Bind("duration") %>'></asp:Label>--%>
                            <%-- </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle CssClass="stm_dark" />
                                        <HeaderStyle CssClass="stm_head" />
                                        <AlternatingRowStyle CssClass="stm_light" />
                                    </asp:GridView>
                                </tr>
                            </table>--%>
                        </td>
                    </tr>
                </table>
                <table width="100%" cellpadding="0px" style="margin-left: 10px;">
                    <tr>
                        <td colspan="1">&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <strong>Little Illusions Play School</strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Authorized Signatory
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                            This is a computer generated receipt and requires no signature.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="border-top: 1px solid #666; padding-top: 7px;">&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td id="tdButton" align="center" colspan="2" valign="middle">
                            <input id="p" class="btn btn-success button-submit " onclick="javascript: return PrintGridData()"
                                type="image" src="../images/but_print.gif" value="Print" /><br />
                            &nbsp;&nbsp;<br />
                            <%-- <asp:Button ID="btnCancel" Text="BACK" runat="server" CssClass="button2" ToolTip="Click here to go to the previous page"
                                OnClick="btnCancel_Click" />--%>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>