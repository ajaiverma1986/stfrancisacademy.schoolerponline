<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="list-of-holiday.aspx.cs" Inherits="BranchPanel_list_of_holiday" %>

<%@ Register Src="~/BranchPanel/employee/set-holiday.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .for_sigle_row_form {
            margin-left: 0px !important;
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

        #ctl00_ContentPlaceHolder1_Grid_Calender a {
            cursor: pointer !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender th {
            background-color: green;
            color: white !important;
            font-size: 20px !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
            height: 50px !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender {
            border: 2px solid #CDCDCD !important;
        }

        #contentPane {
            min-height: 440px !important;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">

        var month = "0";

        function pageLoad() {
            document.title = 'Holiday List';
        }

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }

        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddlmonth').change(function () {
                month = $(this).val();
                DatePicker();
            })
        });

        function DatePicker() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "list-of-holiday.aspx/BindDbDatePicker",
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
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Holiday Management</a></li>
            <li style="background: none;"><a class="active" href="#">Holiday List</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="margin-bottom: 50px ! important; margin-top: 30px !important; background-color: #F7F7F7; height: auto !important;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div class="for_sigle_row_form" style="background-color: #CDCDCD !important;">
                            <asp:DropDownList ID="ddlmonth" runat="server" Style="width: 120px !important; height: 25px !important; padding: 2px 2px 2px 20px !important; border: 2px solid #007ACC !important;">
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
                                        <asp:LinkButton ID="lblsunday" runat="server" Text='<%# Eval("Sun") %>' CssClass="Sun" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblmonday" runat="server" Text='<%# Eval("Mon") %>' CssClass="Mon" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Tuesday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbltuesday" runat="server" Text='<%# Eval("Tue") %>' CssClass="Tue" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Wednesday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblwednesday" runat="server" Text='<%# Eval("Wed") %>' CssClass="Wed" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Thursday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblthrsday" runat="server" Text='<%# Eval("Thr") %>' CssClass="Thu" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Friday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblfriday" runat="server" Text='<%# Eval("Fri") %>' CssClass="Fri" Enabled="false"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Saturday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblsaturday" runat="server" Text='<%# Eval("Sat") %>' CssClass="Sat" Enabled="false"></asp:LinkButton>
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
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>