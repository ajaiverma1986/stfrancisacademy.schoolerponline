<%@ Page Title=" Duration wise Fee Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="FeeDuration.aspx.cs" Inherits="BranchPanel_FeeDuration" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
                $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });

            });

        });
    </script>
    <style type="text/css">
        .active1 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>
    <style>
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Collection</a></li>
            <li style="background: none;"><a class="active">Period Fee Report</a></li>
        </ul>

        <div class="arrowt">
            <a href="Recentfee.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Duartion-Wise Fee Report
        </div>

        <br />

        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form" style="margin-left: 167px;">
                    <label>
                        From<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtDate" runat="server" AutoPostBack="true" Text="From" Style="background: url(../images/calender.png) right center no-repeat;"
                        OnTextChanged="txtDate_TextChanged" ToolTip="Select date and then to date to show details for a duration."></asp:TextBox>
                </div>
                <div class="for_sigle_row_form" style="margin-left: 167px;">
                    <label>
                        To Date<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtToDate" runat="server" AutoPostBack="true" Text="To" Style="background: url(../images/calender.png) right center no-repeat;"
                        OnTextChanged="txtToDate_TextChanged" ToolTip="Select to show the amount details for a particular day."></asp:TextBox>
                </div>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                    <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 700px; padding: 5px 20px; background: #fff; margin: 0px auto;"
                        runat="server" id="tblMain">
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <b>
                                        <asp:Label runat="server" ID="lbl1" Text="Total Amount payable till Date:"></asp:Label>
                                    </b>
                                    <asp:Label ID="lblDatePay" runat="server" Font-Size="13px" ForeColor="Black"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <b>
                                        <asp:Label runat="server" ID="lbl2" Text="Total Amount paid till Date:"></asp:Label>
                                    </b>
                                    <asp:Label ID="lblPaidAmount" runat="server" Font-Size="13px" ForeColor="Black"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="for_sigle_row_form">
                                    <b>
                                        <asp:Label runat="server" ID="lbl3" Text="Total Due Amount:"></asp:Label>
                                    </b>
                                    <asp:Label ID="lbTotalDue" runat="server" Font-Size="13px" ForeColor="Black"></asp:Label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" valign="baseline">
                                <div class="for_sigle_row_form">
                                    <asp:Button runat="server" ID="btnTotalBack" Text="Reset" CssClass="button_save" ToolTip="Click here to go back to the list."
                                        OnClick="btnTotalBack_Click" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
        </div>
    </div>
</asp:Content>