<%@ Page Title="View Registration" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="viewregistration.aspx.cs" Inherits="BranchPanel_viewregistration" %>

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
                $("#ctl00_ContentPlaceHolder1_txtMDOB").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });
        });
    </script>
    <style>
        .for_sigle_row_form1 {
            padding: 5px 0;
            width: 100%;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 0px;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="registration-list.aspx">Student Administration</a></li>
            <li><a href="registration-list.aspx">Registration</a></li>
            <li style="background: none;"><a class="active" href="#">View  Student Details</a></li>
        </ul>

        <div class="arrowt">
            <a href="registration-list.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear"></div>
    <asp:Button ID="btn1" runat="server" Text="View Complete Details" CssClass="button_save" OnClick="btn1_Click" ToolTip="click here to view Complete Registration Details " />
    <div class="content_pane_cont input_content" id="contentPane">

        <div class="for_sigle_row_form">

            <label>
                Registration No.(for reference)</label>
            <asp:TextBox ID="txtRegNo" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <asp:UpdatePanel ID="NameApplicant" runat="server">
                <ContentTemplate>
                    <label>
                        Name of Applicant<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFiName" runat="server" CssClass="fname"></asp:TextBox>&nbsp

                                                <asp:TextBox ID="TextBox11" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Date of Birth<span style="color: Red">*</span></label>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>&nbsp;
                                                <asp:Label runat="server" ID="DateTimeLabel" ForeColor="Black" Font-Size="12px" Text=""></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Father's name<span style="color: #ff0066">*</span></label>
            <asp:TextBox ID="txtFFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtFMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtFLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
        </div>
        <div class="for_sigle_row_form">
            <label>
                Mother's name</label>
            <asp:TextBox ID="txtMFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
        </div>
        <div class="for_sigle_row_form">
            <label>
                Gender<span style="color: Red">*</span></label>
            <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                <asp:ListItem Value="0">Female</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="for_sigle_row_form">
            <asp:UpdatePanel ID="up2" runat="server">
                <ContentTemplate>
                    <label>
                        Applying for Class<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlClass">
                    </asp:DropDownList>
                    &nbsp;
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Address Line<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
        </div>
        <div class="for_sigle_row_form">
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanelRegional" runat="server">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <div class="for_sigle_row_form1">
                                                <label>
                                                    Country<span style="color: Red">*</span></label>
                                                <asp:TextBox ID="txtcountry" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="for_sigle_row_form1">
                                                <label>
                                                    State/Province<span style="color: Red">*</span></label>
                                                <asp:TextBox ID="txtstate" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="for_sigle_row_form1">
                                                <label>
                                                    City<span style="color: Red">*</span></label>
                                                <asp:TextBox ID="txtcity" runat="server"></asp:TextBox>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>
                PIN/ZIP code<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="txtPZIP"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Contact No.<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtmob" runat="server" MaxLength="15"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtmob"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div class="tab-pane" id="tab6">
            <div class="for_sigle_row_form">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <label>
                            Registration No.</label><asp:TextBox ID="txtadmNo" runat="server" ReadOnly="true"></asp:TextBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtFFname" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Registration Date</label><asp:TextBox ID="txtAdmDate"
                        ReadOnly="true" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <asp:UpdatePanel ID="upd11" runat="server">
                    <ContentTemplate>
                        <label>
                            Class
                        </label>
                        <asp:TextBox runat="server" ReadOnly="true"
                            ID="txtClassSec"></asp:TextBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlClass" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Button ID="btnupd" runat="server" CssClass="button_save" Text="Update" OnClick="btnupd_Click" />
            </div>
        </div>
    </div>
</asp:Content>