<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="daily-wise-attendance-report.aspx.cs" Inherits="BranchPanel_daily_wise_attendance_report" %>

<%@ Register Src="~/BranchPanel/employee/attendance-management.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" />

    <style type="text/css">
        .activemonthlyattendancereportdaily {
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

        .footer {
            font-weight: bold;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        var a = jQuery.noConflict();
        var datefrom = "", dateto = "", date = "", financialid = "0", monthid = "0", pagecount = "", pageno = 1, pagecount = 1, pagesize = 30, sum = 0, sumforabsent = 0, sumforlate = 0, sumfortotal = 0, name = "";
        function pageLoad() {

            financialid = a("#ctl00_ContentPlaceHolder1_ddlfinancialyear option:selected").val();

            monthid = a("#ctl00_ContentPlaceHolder1_ddlmonth option:selected").val();

            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $("#ctl00_ContentPlaceHolder1_lblpage").html(1);
            $("#ctl00_ContentPlaceHolder1_lblTotalPages").html(pagecount);

            document.title = 'Daily Wise Attendance Report';

        }

        $(document).ready(function () {

            a("#ctl00_ContentPlaceHolder1_txtattendancedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });
            a("#ctl00_ContentPlaceHolder1_txtattendancetodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            a(document).on("click", "[id*=maingridviewforreport] [id*=lnkbtnfortotal]", function () {
                date = $(this).parent('div').find('.dateforgrid').text();
                fill_grid();
                return false;
            });

            a(document).on("click", "[id*=maingridviewforreport] [id*=lbldate]", function () {
                date = $(this).parent('div').find('.dateforbind').text();
                fill_grid();
                return false;
            });

            a("#ctl00_ContentPlaceHolder1_btnback").click(function () {
                $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_maingrid").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_txtname").val("");
                return false;
            });

            a("#ctl00_ContentPlaceHolder1_ddlfinancialyear").change(function () {
                pageno = 1;
                financialid = $(this).val();
                Fill_Main_Grid();
            });

            a("#ctl00_ContentPlaceHolder1_ddlmonth").change(function () {
                pageno = 1;
                monthid = $(this).val();
                Fill_Main_Grid();
            });
            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
            $("#btnfirst").click(function () {
                pageno = 1;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                Fill_Main_Grid();
            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    Fill_Main_Grid();
                }
            });
            $("#btnnext").click(function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    Fill_Main_Grid();
                }
            });

            $("#btnlast").click(function () {
                pageno = pagecount;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                Fill_Main_Grid();
            });

            $("#ctl00_ContentPlaceHolder1_txtattendancedate").change(function () {

                datefrom = $("#ctl00_ContentPlaceHolder1_txtattendancedate").val();
                Fill_Main_Grid();
                return false;
            });

            a("#ctl00_ContentPlaceHolder1_txtattendancetodate").on("change", function () {
                dateto = $("#ctl00_ContentPlaceHolder1_txtattendancetodate").val();
                Fill_Main_Grid();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtname").on("keyup", function () {
                name = $("#ctl00_ContentPlaceHolder1_txtname").val().trim();
                fill_grid();
                name = "";
                return false;
            });

        });

        function fill_grid() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "daily-wise-attendance-report.aspx/bindattendancedetails",
                     data: "{'date':'" + date + "','name':'" + name + "'}",
                     dataType: "json",
                     success: function (data) {
                         var srno = 1;
                         $("[id*=gvdetails] tr:gt(1)").remove();

                         if (data.d.length > 0) {

                             $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_maingrid").css("display", "none");
                             for (var i = 0; i < data.d.length; i++) {
                                 var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                                 $("[id$=gvdetails]").append(row);
                                 $(row).find(".Number").html(data.d[i].Number);
                                 $(row).find(".RefNo").html(data.d[i].RefNo);
                                 $(row).find(".Name").html(data.d[i].Name);
                                 $(row).find(".Date").html(data.d[i].Date);
                                 $(row).find(".present").attr("src", data.d[i].present);
                                 $(row).find(".Intime").html(data.d[i].Intime);
                                 $(row).find(".Outtime").html(data.d[i].Outtime);
                                 $(row).find(".islate").attr("src", data.d[i].islate);
                                 $(row).find(".ishalfday").attr("src", data.d[i].ishalfday);
                                 $(row).find(".paidleave").attr("src", data.d[i].paidleave);
                                 $(row).find(".unpaidleave").attr("src", data.d[i].unpaidleave);

                             }
                             $("#ctl00_ContentPlaceHolder1_gvdetails").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "none");
                             call_progressbar("end");

                         }
                         else {
                             $("#ctl00_ContentPlaceHolder1_gvdetails").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "block");

                         }

                         $("[id*=gvdetails] tr").show();
                         $("[id*=gvdetails] tr:eq(1)").hide();
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });
        }

        function Fill_Main_Grid() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "daily-wise-attendance-report.aspx/BindMainGrid",
                     data: "{'datefrom':'" + datefrom + "','dateto':'" + dateto + "','financialid':'" + financialid + "','monthid':'" + monthid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                     dataType: "json",
                     success: function (data) {
                         var srno = 1;
                         $("[id*=maingridviewforreport] tr:gt(1)").remove();

                         if (data.d.length > 0) {
                             $('#ctl00_ContentPlaceHolder1_onlygrid').css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_lblmsgformaingrid").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_divforpagging").css("display", "block");
                             $(".footer").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_divfornoofpresenttotal").css("display", "block");

                             sum = 0, sumforabsent = 0, sumforlate = 0, sumfortotal = 0;
                             for (var i = 0; i < data.d.length; i++) {
                                 var row = $("[id*=maingridviewforreport] tr:eq(1)").clone(true);
                                 $("[id$=maingridviewforreport]").append(row);
                                 $(row).find(".RowNumber").html(data.d[i].RowNumber);
                                 $(row).find(".dateforbind").html(data.d[i].Date);
                                 $(row).find(".NoOfPresent").html(data.d[i].NoOfPresent);
                                 $(row).find(".NoofAbsent").html(data.d[i].NoofAbsent);
                                 $(row).find(".NoofLate").html(data.d[i].NoofLate);
                                 $(row).find(".Total").html(data.d[i].Total);
                                 $(row).find(".dateforgrid").html(data.d[i].Date);
                                 pagecount = data.d[i].pagecount;

                                 //this code is for doing total for all digit columns
                                 sum = parseInt(sum) + parseInt(data.d[i].NoOfPresent);
                                 sumforabsent = parseInt(sumforabsent) + parseInt(data.d[i].NoofAbsent);
                                 sumforlate = parseInt(sumforlate) + parseInt(data.d[i].NoofLate);
                                 sumfortotal = parseInt(sumfortotal) + parseInt(data.d[i].Total);
                                 if (pagecount == 1) {
                                     $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                     $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                                 }
                                 else {
                                     $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                     $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                                 }
                             }
                             $("[id*=lbltotalfornoofpresent]").html(sum);
                             $("[id*=lbltotalfornoofabsent]").html(sumforabsent);
                             $("[id*=lbltotalfornooflate]").html(sumforlate);
                             $("[id*=lbltotalfortotal]").html(sumfortotal);
                         }
                         else {

                             var row = $("[id*=maingridviewforreport] tr:eq(1)").clone(true);
                             $("[id$=maingridviewforreport]").append(row);
                             $(row).find(".RowNumber").css("display", "none");
                             $(row).find(".dateforbind").css("display", "none");
                             $(row).find(".NoOfPresent").css("display", "none");
                             $(row).find(".NoofAbsent").css("display", "none");
                             $(row).find(".NoofLate").css("display", "none");
                             $(row).find(".Total").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_lblmsgformaingrid").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_divforpagging").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_divfornoofpresenttotal").css("display", "none");
                         }

                         $("[id*=maingridviewforreport] tr").show();
                         $("[id*=maingridviewforreport] tr:eq(1)").hide();
                         call_progressbar("end");

                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });
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
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Attendance Management</a></li>
            <li style="background: none;"><a class="active" href="#">Daily Wise Attendance Report</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="maingrid" runat="server" style="display: block; margin-bottom: 50px !important;">

            <div class="for_sigle_row_form" style="margin-left: -0px">
                <asp:TextBox ID="txtattendancedate" runat="server" Placeholder="From Date" Style="margin-left: 5px; width: 150px"></asp:TextBox>
                <asp:TextBox ID="txtattendancetodate" runat="server" Placeholder="To Date" Style="margin-left: 5px; width: 150px"></asp:TextBox>
                <asp:DropDownList ID="ddlmonth" runat="server" Style="margin-left: 5px;" Width="130px">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" Style="margin-left: 5px" Width="180px"></asp:DropDownList>
            </div>

            <div id="onlygrid" runat="server" style="width: 100%!important">
                <asp:GridView runat="server" ID="maingridviewforreport" ShowHeader="true" AutoGenerateColumns="false"
                    GridLines="None" Width="100%" CssClass="stm">
                    <Columns>
                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lbldate" ToolTip="Click here for more details." runat="server" Text='<%# Eval("Date","{0:MMM dd yyyy}") %>' Style="cursor: pointer" CssClass="dateforbind"></asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Present" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblpresent" runat="server" Text='<%# Eval("NoOfPresent") %>' CssClass="NoOfPresent"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Absent" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblabsent" runat="server" Text='<%# Eval("NoofAbsent") %>' CssClass="NoofAbsent"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblnooflate" runat="server" Text='<%# Eval("NoofLate") %>' CssClass="NoofLate"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lnkbtnfortotal" ToolTip="Click here for more details." runat="server" Text='<%# Eval("Total") %>' CssClass="Total"></asp:LinkButton>
                                    <asp:Label ID="lbldateforlabel" runat="server" Text='<%# Eval("Date","{0:MMM dd yyyy}") %>' Style="display: none" CssClass="dateforgrid"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <FooterStyle CssClass="footer" />
                </asp:GridView>
            </div>
            <asp:Label ID="lblmsgformaingrid" runat="server" Text="No attendance report available according to your selection." Style="margin-left: 12px; display: none; margin-top: 10px; margin-bottom: 10px !important;" Font-Size="11pt" ForeColor="Red"></asp:Label>
            <div id="divfornoofpresenttotal" style="width: 100%" runat="server">

                <asp:Label ID="lbltotaltext" runat="server" Text="Total:-" Style="margin-left: 163px; font-size: 20px; color: green"></asp:Label>

                <asp:Label ID="lbltotalfornoofpresent" runat="server" Text="0" Style="margin-left: 150px; font-size: 11pt"></asp:Label>

                <asp:Label ID="lbltotalfornoofabsent" runat="server" Text="0" Style="margin-left: 151px; font-size: 11pt"></asp:Label>
                <asp:Label ID="lbltotalfornooflate" runat="server" Text="0" Style="margin-left: 165px; font-size: 11pt"></asp:Label>

                <asp:Label ID="lbltotalfortotal" runat="server" Text="0" Style="margin-left: 162px; font-size: 11pt"></asp:Label>
            </div>
            <asp:HiddenField ID="hfpages" runat="server" />
            <div id="divforpagging" class="containerHeadline" runat="server">
                <div style="margin-left: 0px; float: left; width: 400px;">
                    <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                    of
                <asp:Label ID="lblTotalPages" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <span style="font-size: 11pt">Page</span>
                </div>
                <div style="margin-left: 0px; float: left; width: 300px;">

                    <img src="../../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                </div>
            </div>
        </div>

        <div id="divgrid" runat="server" style="display: none;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">

                <tr id="trgrid" runat="server" style="display: block">
                    <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <div class="for_sigle_row_form">
                            <asp:TextBox ID="txtname" runat="server" Placeholder="Name" Style="margin-left: -130px; width: 150px"></asp:TextBox>
                        </div>
                        <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" Width="1065" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="50px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("Number") %>' CssClass="Number"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Ref No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("RefNo") %>' CssClass="RefNo"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="250px" HeaderText="Employee Name" ItemStyle-HorizontalAlign="left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployeename" runat="server" Text='<%# Eval("Name") %>' Style="float: left" CssClass="Name"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblreportdate" runat="server" Text='<%# Eval("Date","{0:MMM dd yyyy}") %>' CssClass="Date"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Present/Absent" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="lblpresentstatus" runat="server" Width="16px" ImageUrl='<%# Eval("present") %>' CssClass="present"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="In Time" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblintime" runat="server" Text='<%# Eval("Intime") %>' CssClass="Intime"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Out Time" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblouttime" runat="server" Text='<%# Eval("Outtime") %>' CssClass="Outtime"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="60px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="lbllatestatus" runat="server" Width="16px" ImageUrl='<%# Eval("islate") %>' CssClass="islate"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="60px" HeaderText="Halfday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="lblhalfdaystatus" runat="server" Width="16px" ImageUrl='<%# Eval("ishalfday") %>' CssClass="ishalfday"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="60px" HeaderText="PaidLeave" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="lblpaidleavestatus" runat="server" Width="16px" ImageUrl='<%# Eval("paidleave") %>' CssClass="paidleave"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="60px" HeaderText="UnPaidLeave" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="lblunpaidleavestatus" runat="server" Width="16px" ImageUrl='<%# Eval("unpaidleave") %>' CssClass="unpaidleave"></asp:Image>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                        <asp:Label ID="lblmsg" runat="server" Text="No attendance report available" Style="margin-left: 10px; display: none" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="for_sigle_row_form" style="font-size: 15px !important">
                <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button2" Style="margin-left: -130px !important; cursor: pointer" />
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>