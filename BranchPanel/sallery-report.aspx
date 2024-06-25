<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="sallery-report.aspx.cs" Inherits="BranchPanel_sallery_report" %>

<%@ Register Src="~/BranchPanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activesalleryreport {
            border-color: #ccc!important;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px!important;
            margin-top: 3px;
        }

        .user-deatils1 span {
            margin-top: 6px;
        }

        .user-deatils1 dt {
            font-size: 11px;
            width: 125px!important;
        }
    </style>
    <script src="../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function pageLoad() {
            document.title = "Employee Salary Report";

        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Salary Report</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <%--<My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <asp:UpdatePanel ID="updtpnl" runat="server" UpdateMode="Always">
            <ContentTemplate>

                <%--        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Salary Report
        </div>--%>
                <div class="for_sigle_row_form" style="margin-left: 227px; width: 563px; min-height: 50px; margin-top: 10px !important; margin-bottom: 7px !important">
                    <div class="for_sigle_row_form" style="margin-left: -68px">
                        <label>
                            Select Payid<span style="color: Red">*</span>
                        </label>
                        <asp:DropDownList ID="ddlpayid" runat="server" OnSelectedIndexChanged="ddlpayid_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="left" colspan="11" style="width: 100%; padding: 0px 10px 10px 10px;">
                            <asp:GridView ID="gvsalaryreports" AutoGenerateColumns="false" ShowHeader="true"
                                GridLines="None" CellPadding="5" runat="server" Width="100%" HeaderStyle-Height="0px" OnRowCommand="gvsalaryreports_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="student-photo_frame1" style="height: 190px; margin-top: 10px;">
                                                <div class="student-photo_frame_img">
                                                    <asp:Image runat="server" ID="imgsource" ImageUrl='<%#Eval ("photo","~/facultyimage/{0}") %>' CssClass="forcheckclick" />
                                                </div>
                                                <div style="float: left; width: 300px">
                                                    <div class="user-deatils1">
                                                        <asp:LinkButton ID="lbtn3" runat="server" Text='<%# Bind("Name") %>' CssClass="swet">
                                                        </asp:LinkButton>
                                                        <asp:Label ID="lbleid2" runat="server" Text='<%# Bind("empid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                                    </div>
                                                    <div class="clear"></div>
                                                    <div class="user-deatils1">
                                                        <dt>Ref No:</dt>
                                                        <asp:Label ID="lblrefno" runat="server" Text='<%#  Eval("refno")  %>' CssClass="refno"></asp:Label>
                                                        </span>
                                                    </div>
                                                    <div class="user-deatils1">
                                                        <dt>Designation :</dt>
                                                        <asp:Label ID="lbldesignation" runat="server" Text='<%#  Eval("Designation")  %>' CssClass="title"></asp:Label>
                                                        </span>
                                                    </div>
                                                    <div class="user-deatils1">
                                                        <dt>Monthly Salary:</dt>
                                                        <asp:Label ID="lblworkingdays" runat="server" Text='<%#  Eval("monthlysalary","{0:f}")  %>' CssClass="monthlysalary"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Calculated Salary:</dt>
                                                        <asp:Label ID="lblpresenetdays" runat="server" Text='<%#  Eval("calculatedsalary","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Modified Salary:</dt>
                                                        <asp:Label ID="lbllatedays" runat="server" Text='<%#  Eval("Modifiedsalary","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Payable Amount:</dt>
                                                        <asp:Label ID="lblabsentdays" runat="server" Text='<%#  Eval("PayableAmt","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div style="float: left; width: 330px; margin-top: 35px">

                                                    <div class="user-deatils1">
                                                        <dt>Advanced Amount:</dt>
                                                        <asp:Label ID="Label3" runat="server" Text='<%#  Eval("advanceamount","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Paid Amount:</dt>
                                                        <asp:Label ID="lbleffectivedays" runat="server" Text='<%#  Eval("PaidAmt","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Closing Balance:</dt>
                                                        <asp:Label ID="lblpaidleave" runat="server" Text='<%#  Eval("closingbalance","{0:f}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Payment Date:</dt>
                                                        <asp:Label ID="lblhalfdays" runat="server" Text='<%#  Eval("paymentdate","{0:dd/MM/yyyy}")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Payment Mode:</dt>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#  Eval("paymentmode")  %>' CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>

                                                    <div class="user-deatils1">
                                                        <dt>Pay ID:</dt>
                                                        <asp:Label ID="lblpayname" runat="server" Text='<%#  Eval("payname")  %>' Style="width: 200px!important" CssClass="mobile"></asp:Label>
                                                        </span>
                                                    </div>
                                                </div>

                                                <div class="user-deatils1">
                                                    <div class="del-active">
                                                        <asp:LinkButton ID="lbtn53" runat="server" CommandName="ShowDetails" Text="Show Details" ToolTip="Click here to show attendance details " CommandArgument='<%#Eval("payid") %>' CssClass="LinkClick">
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="No Record Found" Style="display: none; color: red; font-size: 20px"></asp:Label>
                        </td>
                    </tr>
                </table>

                <table id="tblforsalarydetails" visible="false" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                                GridLines="None" Width="1065" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Total Working Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalworkingdays" runat="server" Text='<%# Eval("workingdayofoffice") %>' CssClass="lbltotalworkingdays"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="165px" HeaderText="Employee Working Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblemployeeworkingdays" runat="server" Text='<%# Eval("workingdayofemployees") %>' CssClass="lblemployeeworkingdays"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Total Unpaid Leave" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalunpaidleave" runat="server" Text='<%# Eval("totalunpaidleave") %>' CssClass="lbltotalunpaidleave"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Total Paid Leave" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalpaidleave" runat="server" Text='<%# Eval("totalpaidleave") %>' CssClass="lbltotalpaidleave"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Total Late Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotallateday" runat="server" Text='<%# Eval("totallate") %>' CssClass="lbltotallateday"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="95px" HeaderText="Total Half Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalhalfday" runat="server" Text='<%# Eval("totalhalfday") %>' CssClass="lbltotalhalfday"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-Width="105px" HeaderText="User Effective Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="txteffectiveday" runat="server" Text='<%# Eval("effectivedays_system") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-Width="105px" HeaderText="Admin Effective Days" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="txteffectiveday" runat="server" Text='<%# Eval("effectivedays_changebyadmin") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalmonthlysallery" runat="server" Text='<%# Eval("monthlysalary","{0:f}") %>' CssClass="lbltotalmonthlysallery"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-Width="125px" HeaderText="Calculated Salary" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalcalculatedsallery" runat="server" Text='<%# Eval("calculatedsalary","{0:f}") %>' CssClass="lblcalculatedsalary"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-Width="125px" HeaderText="Modified Salary" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltotalcalculatedsallery" runat="server" Text='<%# Eval("Modifiedsallery","{0:f}") %>' CssClass="lbltotalcalculatedsallery"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnback" runat="server" Text="Back" Visible="false" CssClass="button2" OnClick="btnback_Click" Style="cursor: pointer" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>