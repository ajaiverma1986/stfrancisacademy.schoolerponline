<%@ Page Title="Reciept" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Receipt.aspx.cs" Inherits="BranchPanel_Receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .divContent {
            background-color: White;
            padding: 30px 30px 30px 30px;
            min-height: 800px;
        }

        .tblRectangleBorder {
            font-family: Arial,Helvetica,sans-serif;
            background-color: White;
            color: Black;
            -webkit-box-shadow: 0px 0px 1px 4px #fafafa;
            -moz-box-shadow: 0px 0px 1px 4px #F8A88D;
            box-shadow: 0 0 10px #D0D0D0 inset;
            border-radius: 7px;
            padding: 30px 20px 30px 20px;
            align: center;
        }

        .firstTD {
            margin-bottom: -0.75em;
            margin-top: -0.2em;
            height: auto;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 0px 0px 0px 20px;
            color: #1C6099;
            font-weight: normal;
            padding-right: 15px;
        }

        .secondTD {
            font-size: 14px;
            font-family: Arial,Helvetica,sans-serif;
            text-align: left;
            padding-left: 20px;
        }

        .ddl {
            margin-top: 5px;
            height: 29px;
            margin: 10 0 5px;
            padding: 5px;
            width: 243px;
            border-radius: 4px;
            margin-top: 7px;
        }

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }

        .aspButton {
            border: 1px solid #ff6262;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 15px;
            font-family: arial, helvetica, sans-serif;
            padding: 3px 8px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #ff3434;
            background-image: linear-gradient(to bottom, #ff9a9a, #ff4040);
        }
    </style>

    <div id="content" runat="server" class="divContent" align="center">

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
    </div>
</asp:Content>