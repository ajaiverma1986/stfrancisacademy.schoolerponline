<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="attendance-report-monthly-wise.aspx.cs" Inherits="BranchPanel_attendance_report_monthly_wise" %>

<%@ Register Src="~/BranchPanel/employee/attendance-management.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" />

    <script type="text/javascript">

        var payid = 0, eid = 0, fromdate = "", todate = "", refno = "", sumforwork = 0, sumforpresent = 0, sumforlate = 0, sumforhalf = 0, sumforpaid = 0, sumforunpaid = 0, sumforabsent = 0, name = "";

        function pageLoad() {
            document.title = 'Monthly Wise Attendance Report';
        }

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_txtattendancedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_txtattendancetodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_ddlpayid").change(function () {
                payid = $(this).val();
                Fill_Main_Grid();
            });

            $("#ctl00_ContentPlaceHolder1_txtname").on("keyup", function () {
                payid = $("#ctl00_ContentPlaceHolder1_ddlpayid option:selected").val();
                name = $("#ctl00_ContentPlaceHolder1_txtname").val().trim();
                Fill_Main_Grid();

                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtrefno").on("change blur", function () {

                payid = $("#ctl00_ContentPlaceHolder1_ddlpayid option:selected").val();
                refno = $("#ctl00_ContentPlaceHolder1_txtrefno").val().trim();
                Fill_Main_Grid();
                return false;
            });

            $(document).on("click", "[id*=gvdetails] [id*=lbtndetails]", function () {
                eid = $(this).parent('div').find('.eid').text();
                if (eid != 0) {
                    FillDetailsGrid();
                }
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnback").click(function () {
                $("#ctl00_ContentPlaceHolder1_tabledescription").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_tabledetails").css("display", "block");
                $("#divfordropdown").css("display", "block");
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_txtattendancedate").on("change", function () {
                fromdate = $("#ctl00_ContentPlaceHolder1_txtattendancedate").val();
                FillDetailsGrid();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtattendancetodate").on("change", function () {
                todate = $("#ctl00_ContentPlaceHolder1_txtattendancetodate").val();
                FillDetailsGrid();
                return false;
            });

        });

        function Fill_Main_Grid() {

            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "attendance-report-monthly-wise.aspx/bindattendancedetails",
                     data: "{'payid':'" + payid + "','refno':'" + refno + "','name':'" + name + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         var srno = 1;
                         $("[id*=gvdetails] tr:gt(1)").remove();

                         if (data.d.length > 0) {

                             $("#ctl00_ContentPlaceHolder1_tabledescription").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_tabledetails").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_divfornoofpresenttotal").css("display", "block");
                             sumforwork = 0, sumforpresent = 0, sumforlate = 0, sumforhalf = 0, sumforpaid = 0, sumforunpaid = 0, sumforabsent = 0;
                             for (var i = 0; i < data.d.length; i++) {
                                 var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                                 $("[id$=gvdetails]").append(row);

                                 $(row).find(".RowNumber").html(data.d[i].RowNumber);

                                 $(row).find(".RefNo").html(data.d[i].RefNo);
                                 $(row).find(".Name").html(data.d[i].Name);
                                 $(row).find(".Noofworkingdays").html(data.d[i].Noofworkingdays);

                                 $(row).find(".Noofpresentdays").html(data.d[i].Noofpresentdays);

                                 $(row).find(".NoofLateCome").html(data.d[i].NoofLateCome);

                                 $(row).find(".NoofHalfDays").html(data.d[i].NoofHalfDays);

                                 $(row).find(".NoofPaidLeave").html(data.d[i].NoofPaidLeave);

                                 $(row).find(".Noofunpaidleave").html(data.d[i].Noofunpaidleave);

                                 $(row).find(".Noofabsentdays").html(data.d[i].Noofabsentdays);

                                 $(row).find(".eid").html(data.d[i].eid);

                                 $(row).find(".showdetails").css("display", "block");

                                 sumforwork = parseInt(sumforwork) + parseInt(data.d[i].Noofworkingdays);

                                 sumforpresent = parseInt(sumforpresent) + parseInt(data.d[i].Noofpresentdays);

                                 sumforlate = parseInt(sumforlate) + parseInt(data.d[i].NoofLateCome);

                                 sumforhalf = parseInt(sumforhalf) + parseInt(data.d[i].NoofHalfDays);

                                 sumforpaid = parseInt(sumforpaid) + parseInt(data.d[i].NoofPaidLeave);

                                 sumforunpaid = parseInt(sumforunpaid) + parseInt(data.d[i].Noofunpaidleave);

                                 sumforabsent = parseInt(sumforabsent) + parseInt(data.d[i].Noofabsentdays);
                             }

                             $("[id*=lblwork]").html(sumforwork);
                             $("[id*=lblPresent]").html(sumforpresent);
                             $("[id*=lblLate]").html(sumforlate);
                             $("[id*=lblHalf]").html(sumforhalf);

                             $("[id*=lblPaid]").html(sumforpaid);

                             $("[id*=lblUnpaid]").html(sumforunpaid);

                             $("[id*=lblAbsent]").html(sumforabsent);

                             $("#ctl00_ContentPlaceHolder1_lblmsgformaingrid").css("display", "none");
                             refno = "";
                             call_progressbar("end");
                         }
                         else {
                             var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                             $("[id$=gvdetails]").append(row);
                             $(row).find(".RowNumber").css("display", "none");
                             $(row).find(".RefNo").css("display", "none");
                             $(row).find(".Name").css("display", "none");
                             $(row).find(".Noofworkingdays").css("display", "none");
                             $(row).find(".Noofpresentdays").css("display", "none");
                             $(row).find(".NoofLateCome").css("display", "none");
                             $(row).find(".NoofHalfDays").css("display", "none");
                             $(row).find(".NoofPaidLeave").css("display", "none");
                             $(row).find(".Noofunpaidleave").css("display", "none");
                             $(row).find(".Noofabsentdays").css("display", "none");
                             $(row).find(".eid").css("display", "none");
                             $(row).find(".showdetails").css("display", "none");
                             $("#ctl00_ContentPlaceHolder1_lblmsgformaingrid").css("display", "block");
                             $("#ctl00_ContentPlaceHolder1_divfornoofpresenttotal").css("display", "none");
                             call_progressbar("end");
                         }
                         $("[id*=gvdetails] tr").show();
                         $("[id*=gvdetails] tr:eq(1)").hide();

                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });

        }

        function FillDetailsGrid() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "attendance-report-monthly-wise.aspx/BindDetailsGrid",
                     data: "{'eid':'" + eid + "','fromdate':'" + fromdate + "','todate':'" + todate + "','payid':'" + payid + "'}",
                     dataType: "json",
                     success: function (data) {
                         var srno = 1;
                         $("[id*=gridfordailyattreport] tr:gt(1)").remove();
                         $("#ctl00_ContentPlaceHolder1_tabledescription").css("display", "block");
                         $("#ctl00_ContentPlaceHolder1_tabledetails").css("display", "none");
                         $("#divfordropdown").css("display", "none");
                         if (data.d.length > 0) {
                             $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "none");
                             for (var i = 0; i < data.d.length; i++) {
                                 var row = $("[id*=gridfordailyattreport] tr:eq(1)").clone(true);
                                 $("[id$=gridfordailyattreport]").append(row);
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
                                 call_progressbar("end");
                             }

                         }
                         else {
                             var row = $("[id*=gridfordailyattreport] tr:eq(1)").clone(true);
                             $("[id$=gridfordailyattreport]").append(row);

                             $(row).find(".Number").css("display", "none");

                             $(row).find(".RefNo").css("display", "none");
                             $(row).find(".Name").css("display", "none");
                             $(row).find(".Date").css("display", "none");

                             $(row).find(".present").css("display", "none");
                             $(row).find(".Intime").css("display", "none");
                             $(row).find(".Outtime").css("display", "none");

                             $(row).find(".islate").css("display", "none");
                             $(row).find(".ishalfday").css("display", "none");
                             $(row).find(".paidleave").css("display", "none");
                             $(row).find(".unpaidleave").css("display", "none");

                             $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "block");
                             call_progressbar("end");
                         }

                         $("[id*=gridfordailyattreport] tr").show();
                         $("[id*=gridfordailyattreport] tr:eq(1)").hide();

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

    <style type="text/css">
        .activemonthlyattendancereport {
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

        .user-deatils1 span {
            float: left;
            font-size: 10px;
            margin-top: 3px;
        }

        .user-deatils1 dt {
            font-size: 11px !important;
            width: 150px !important;
        }

        .student-photo_frame1 {
            height: 150px !important;
        }

        .stm td {
            border-bottom: 1px solid #dddddd;
            border-right: 1px solid #dddddd;
            line-height: 27px;
            padding-left: 10px;
            padding-right: 5px;
            color: #333;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Attendance Management</a></li>

            <li style="background: none;"><a class="active" href="#">Monthly Wise Attendance Report</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div id="divfordropdown" class="for_sigle_row_form" style="margin-left: 0px">
            <asp:DropDownList ID="ddlpayid" runat="server" Style="margin-left: 10px; width: 160px">
            </asp:DropDownList>
            <asp:TextBox ID="txtname" placeholder="Name" Style="margin-left: 10px; width: 150px" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtrefno" placeholder="Reference No." Style="margin-left: 10px; width: 150px" runat="server"></asp:TextBox>
        </div>
        <div id="divformonthly" runat="server">
            <table width="100%" id="tabledetails" runat="server" border="0" cellspacing="0" cellpadding="0" style="display: none">

                <tr>
                    <td align="left" colspan="11" style="width: 100%;">
                        <%--<div style="height: auto!important; width: 119%; max-height: 500px; height: auto; overflow-x: scroll!important">--%>
                        <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" CssClass="stm" CellPadding="5" Width="100%" HeaderStyle-Height="0px">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="55px" />--%>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Ref No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrefno" runat="server" Text='<%# Eval("RefNo") %>' CssClass="RefNo"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="150px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>' Style="float: left; padding-left: 5px" CssClass="Name"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="300px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Working" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainworkingdays" runat="server" Text='<%# Eval("Noofworkingdays") %>' CssClass="Noofworkingdays"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Present" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainpresentdays" runat="server" Text='<%# Eval("Noofpresentdays") %>' Width="15px" Enabled="false" CssClass="Noofpresentdays" />
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainlatedays" runat="server" Text='<%# Eval("NoofLateCome") %>' CssClass="NoofLateCome"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Half" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainhalfdays" runat="server" Text='<%# Eval("NoofHalfDays") %>' CssClass="NoofHalfDays"></asp:Label>
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Paid" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainpaidleave" runat="server" Text='<%# Eval("NoofPaidLeave") %>' Width="15px" Enabled="false" CssClass="NoofPaidLeave" />
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Unpaid" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmaintotalunpaidleave" runat="server" Text='<%# Eval("Noofunpaidleave") %>' Width="15px" Enabled="false" CssClass="Noofunpaidleave" />
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Absent" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmaintotalabsentdays" runat="server" Text='<%# Eval("Noofabsentdays") %>' Width="15px" Enabled="false" CssClass="Noofabsentdays" />
                                    </ItemTemplate>
                                    <%--<ItemStyle Width="50px" />--%>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Details" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div style="width: 50px">
                                            <asp:ImageButton ID="lbtndetails" runat="server" ToolTip="Click here to show attendance details" CssClass="showdetails" Width="20px" ImageUrl="~/images/showdetails.png" />
                                            <asp:Label ID="lbleid" runat="server" Text='<%# Eval("eid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                        <div id="divfornoofpresenttotal" style="width: 100%; background-color: #F1F1F1" runat="server">

                            <asp:Label ID="lbltotaltext" runat="server" Text="Total:-" Style="margin-left: 217px; font-size: 20px; color: green"></asp:Label>
                            <asp:Label ID="lblwork" runat="server" Text="0" Style="margin-left: 92px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblPresent" runat="server" Text="0" Style="margin-left: 45px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblLate" runat="server" Text="0" Style="margin-left: 60px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblHalf" runat="server" Text="0" Style="margin-left: 61px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblPaid" runat="server" Text="0" Style="margin-left: 63px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblUnpaid" runat="server" Text="0" Style="margin-left: 64px; font-size: 11pt"></asp:Label>
                            <asp:Label ID="lblAbsent" runat="server" Text="0" Style="margin-left: 72px; font-size: 11pt"></asp:Label>
                        </div>
                        <asp:Label ID="lblmsgformaingrid" runat="server" Text="No attendance found according to your searching" Style="display: none; color: red; font-size: 15px"></asp:Label>
                        <%--</div>--%>
                    </td>
                </tr>
            </table>
            <table id="tabledescription" style="display: none" width="100%" runat="server" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="left" colspan="11" style="width: 100%;">

                        <div class="for_sigle_row_form" style="margin-left: 0px">

                            <asp:TextBox ID="txtattendancedate" runat="server" Placeholder="From Date" Style="margin-left: 10px; width: 150px"></asp:TextBox>
                            <asp:TextBox ID="txtattendancetodate" runat="server" Placeholder="To Date" Style="width: 150px"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="11" style="width: 100%;">
                        <asp:GridView runat="server" ID="gridfordailyattreport" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("Number") %>' CssClass="Number"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Ref No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrefnono" runat="server" Text='<%# Eval("RefNo") %>' CssClass="RefNo"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%# Eval("Name") %>' CssClass="Name"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldate" runat="server" Text='<%# Eval("Date","{0:MMM dd yyyy}") %>' CssClass="Date"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Present/Absent" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lblpresentstatus" runat="server" ImageUrl='<%# Eval("present") %>' Width="15px" Enabled="false" CssClass="present" />
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
                                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lbllatestatus" runat="server" ImageUrl='<%# Eval("islate") %>' Width="15px" Enabled="false" CssClass="islate" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Halfday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lblhalfdaystatus" runat="server" ImageUrl='<%# Eval("ishalfday") %>' Width="15px" Enabled="false" CssClass="ishalfday" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="PaidLeave" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lblpaidleavestatus" runat="server" ImageUrl='<%# Eval("paidleave") %>' Width="15px" Enabled="false" CssClass="paidleave" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="UnPaidLeave" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="lblunpaidleavestatus" runat="server" ImageUrl='<%# Eval("unpaidleave") %>' Width="15px" Enabled="false" CssClass="unpaidleave" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                        <asp:Label ID="lblmsg" runat="server" Text="No monthly attendance details available." ForeColor="Red" Style="margin-left: 10px;"></asp:Label>
                        <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button" Style="margin-left: 20px !important; width: 60px !important; margin-top: 10px !important; cursor: pointer" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>