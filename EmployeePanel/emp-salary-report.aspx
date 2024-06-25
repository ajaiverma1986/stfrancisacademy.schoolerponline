<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="emp-salary-report.aspx.cs" Inherits="EmployeePanel_emp_salary_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .salaryactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        td {
            border-bottom: 1px black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }
    </style>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Salary Report
                    </h1>
                </div>
                <div class="main-content">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 50px !important;" id="tablemaingrid" runat="server">
                        <tr id="trmaingridrecord" runat="server" style="display: block">
                            <td colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                                <asp:GridView runat="server" ID="gridmain" ShowHeader="true" AutoGenerateColumns="false"
                                    Width="100%" CssClass="stm">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-Width="70px" HeaderText="S.No" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Month" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainmonth" runat="server" Text='<%# Eval("Month") %>' CssClass="Month"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainmonthlysalary" runat="server" Text='<%# Eval("monthlysalary") %>' CssClass="monthlysalary"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="250px" HeaderText="Sys.calculated salary" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmaincalculatedsalary" runat="server" Text='<%# Eval("calculatedsalary") %>' CssClass="calculatedsalary"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="250px" HeaderText="Recalculated Salary" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblrecalculatedsalary" runat="server" Text='<%# Eval("Recalculatedsalary") %>' CssClass="Recalculatedsalary"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Tax Deduction" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblresalarydeduction" runat="server" Text='<%# Eval("deduction") %>' CssClass="taxdeduction"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Status" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("paystatus") %>' CssClass="paystatus"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light clseveryrow" />
                                    <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>