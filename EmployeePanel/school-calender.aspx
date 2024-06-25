<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="school-calender.aspx.cs" Inherits="EmployeePanel_school_calender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .calenderactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .for_sigle_row_form {
            margin-left: 0px !important;
        }

        #ctl00_head_Grid_Calender_ctl03_lblsaturday {
            width: 200px !important;
        }

        .activelistofholiday {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        #ctl00_head_Grid_Calender td span {
            width: 100% !important;
        }

        #ctl00_head_Grid_Calender th {
            background-color: #82403B;
            color: white !important;
            font-size: 20px !important;
        }

        #ctl00_head_Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
            height: 50px !important;
        }

        #ctl00_head_Grid_Calender {
            border: 2px solid #CDCDCD !important;
        }

        #contentPane {
            min-height: 440px !important;
        }

        .stm td {
            color: #333;
            line-height: 12px !important;
            text-align: center;
        }

        .overflow {
            overflow: auto !important;
            border-radius: 10px;
            border: 3px solid #82403B;
        }
    </style>
    <script src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        var month = "0";
        $(document).ready(function () {
            $('#ctl00_head_ddlmonth').change(function () {
                month = $(this).val();
                DatePicker();
            })
        });

        function DatePicker() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "school-calender.aspx/BindDbDatePicker",
                data: "{'month':'" + month + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=Grid_Calender] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=Grid_Calender] tr:eq(1)").clone(true);
                            $("[id$=Grid_Calender]").append(row);
                            $(row).find('.Sun').html(data.d[i].sun);
                            $(row).find('.Mon').html(data.d[i].mon);
                            $(row).find('.Tue').html(data.d[i].tue);
                            $(row).find('.Wed').html(data.d[i].wed);
                            $(row).find('.Thu').html(data.d[i].thu);
                            $(row).find('.Fri').html(data.d[i].fri);
                            $(row).find('.Sat').html(data.d[i].sat);
                        }

                        $("[id*=Grid_Calender] tr").show();
                        $("[id*=Grid_Calender] tr:eq(1)").hide();
                    }
                },
                error: function (result) {
                }
            });
        }
    </script>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <%--<a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout--%>
                        </a>
                        <%--<li><a href="../../Logout.aspx?s=<%=Session["BrRoleID"]%>">Logout</a> </li>--%>
                        <a href="../../Logout.aspx?s=eid">Logout</a></div>
                    <h1>
                        <i class="icon-user"></i>
                        Calender
                    </h1>
                </div>
                <div class="main-content">
                    <div style="background-color: #F7F7F7; height: auto !important;" class="overflow">
                        <table width="100%">
                            <tr>
                                <td>
                                    <div class="for_sigle_row_form" style="background-color: #CDCDCD !important;">
                                        <asp:DropDownList ID="ddlmonth" runat="server" Style="width: 120px !important; height: 25px !important; padding: 2px 2px 2px 20px !important; border: 1px solid #007ACC !important; margin-left: 10px !important;">
                                        </asp:DropDownList>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView runat="server" ID="Grid_Calender" ShowHeader="true" AutoGenerateColumns="false"
                                        GridLines="None" Width="100%" CssClass="stm">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Sunday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsunday" runat="server" Text='<%# Eval("Sun") %>' CssClass="Sun" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmonday" runat="server" Text='<%# Eval("Mon") %>' CssClass="Mon" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Tuesday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbltuesday" runat="server" Text='<%# Eval("Tue") %>' CssClass="Tue" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Wednesday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblwednesday" runat="server" Text='<%# Eval("Wed") %>' CssClass="Wed" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Thursday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblthrsday" runat="server" Text='<%# Eval("Thr") %>' CssClass="Thu" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Friday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblfriday" runat="server" Text='<%# Eval("Fri") %>' CssClass="Fri" Enabled="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Saturday" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsaturday" runat="server" Text='<%# Eval("Sat") %>' CssClass="Sat" Enabled="false"></asp:Label>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>