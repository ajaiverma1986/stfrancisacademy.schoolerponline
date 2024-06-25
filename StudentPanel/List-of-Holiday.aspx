<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="List-of-Holiday.aspx.cs" Inherits="StudentPanel_List_of_Holiday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">


           .calenderactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .calenderactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .stmforpast tr td {
            height: 30px !important;
        }

        .for_sigle_row_form {
            margin-left: 0 !important;
            min-height: 13% !important;
            padding: 5px 0 !important;
            width: 100% !important;
        }
    </style>
    <script type="text/javascript">

        var month = "0";

        function pageLoad() {

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
            $('#ctl00_head_ddlmonth').change(function () {
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
    <div class="clear"></div>
    <link href="css/exam.css" rel="stylesheet" />
    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    
                    <h1>
                        <i class="fa fa-calendar-o" style="color: white"></i>
                        Institute Calender
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                 
                    <table style="width: 100%" >
                        <tr>
                            <td>
                                <div class="clear"></div>
                                <div class="for_sigle_row_form">
                                    <asp:DropDownList ID="ddlmonth" runat="server" Style="width: 120px !important; padding: 7px !important; outline:none; border: 1px solid #ddd !important; ">
                                    </asp:DropDownList>
                                </div>
                                <div class="clear"></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="clear"></div>
                                   <div class="student-panel-tbl">
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
                                       </div>
                            </td>
                        </tr>
                    </table>
                      
                </div>
            </div>
        </div>
    </div>
    <div id="div1" class="progress"></div>
    <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>