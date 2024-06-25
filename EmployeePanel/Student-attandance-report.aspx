<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="Student-attandance-report.aspx.cs" Inherits="EmployeePanel_emp_attandance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>

    <script src="../js/jquery-1.7.2.min.js"></script>
    <script src="../Calender/js/jquery-ui-1.8.19.custom.min.js"></script>
    <script src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .attendanceactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        input {
            cursor: pointer !important;
        }

        #ctl00_head_gridfordailyattreport {
            width: 100% !important;
        }

        .user-deatils1 span {
            float: left;
            font-size: 10px;
            margin-top: 6px;
        }

        .user-deatils1 dt {
            font-size: 11px !important;
            width: 190px !important;
        }

        .student-photo_frame1 {
            height: 150px !important;
        }

        #ctl00_head_gridfordailyattreport td {
            padding-left: 4px !important;
        }

            #ctl00_head_gridfordailyattreport td input {
                margin-left: 25px !important;
            }

        #ui-datepicker-div {
            top:200px;
        }
    </style>

    <script type="text/javascript">
        var payid = "0", fyid = "", fromdate = "", todate = "";

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
            $(".BtnExcel").click(function (e) {
                alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                    if (e) {
                        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                        e.preventDefault();
                    }
                });
                return false;
            });

            $(document).on("click", "[id*=gvDetails] [id*=lbtn53]", function () {
                payid = $(this).parent('td').find('input[type=hidden]').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();
                $('#ctl00_head_tabledetails').css("display", "none");
                $('#tabledescription').css("display", "block");
                $('#ctl00_head_gridfordailyattreport').css("width", "1072px");
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_head_ddlpayid').change(function () {
                payid = $('#ctl00_head_ddlpayid').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();

                BindFirstGridAfterSearch();
                return false;
            });

            $('#ctl00_head_ddlfinancialyear').change(function () {
                payid = $('#ctl00_head_ddlpayid').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();
                BindFirstGridAfterSearch();
                return false;
            });

            $("#ctl00_head_txtattendancedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });

            $("#ctl00_head_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });

            $("#ctl00_head_txtFromDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });

            $("#ctl00_head_txtattendancetodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()
            });

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $('#ctl00_head_btnback').click(function () {
                $('#ctl00_head_tabledetails').css("display", "block");
                $('#tabledescription').css("display", "none");
                $('.trnorecordfound').css("display", "none");
                return false;
            });

            $("#ctl00_head_txtattendancedate").on("change blur", function () {
                fromdate = $("#ctl00_head_txtattendancedate").val();
                BindGridAfterSearch();
                return false;
            });

            $("#ctl00_head_txtattendancetodate").on("change blur", function () {
                todate = $("#ctl00_head_txtattendancetodate").val();
                BindGridAfterSearch();
                return false;
            });

        });

        function BindGridAfterSearch() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "emp-attandance-report.aspx/BindGridByJs",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gridfordailyattreport] tr").show();
                        $('.trnorecordfound').css("display", "none");
                        $('.trnorecordfound').css("width", "900px!important");
                        $("[id*=gridfordailyattreport] tr:gt(1)").remove();

                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gridfordailyattreport] tr:eq(1)").clone(true);
                            $("[id$=gridfordailyattreport]").append(row);
                            $(row).find('.Number').html(data.d[i].Number);
                            $(row).find('.Date').html(data.d[i].Date);
                            $(row).find('.present').attr("src", data.d[i].present);
                            $(row).find('.Intime').html(data.d[i].Intime);
                            $(row).find('.Outtime').html(data.d[i].Outtime);
                            $(row).find('.islate').attr("src", data.d[i].islate);
                            $(row).find('.ishalfday').attr("src", data.d[i].ishalfday);
                            $(row).find('.paidleave').attr("src", data.d[i].paidleave);
                            $(row).find('.unpaidleave').attr("src", data.d[i].unpaidleave);
                        }
                        $("[id*=gridfordailyattreport] tr").show();
                        $("[id*=gridfordailyattreport] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                    else {

                        $("[id*=gridfordailyattreport] tr").hide();
                        $('.trnorecordfound').css("display", "block");
                        $('.trnorecordfound').css("width", "900px!important");
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindFirstGridAfterSearch() {
            call_progressbar("start");
            $('#ctl00_head_divfornoofpresenttotal').css("display", "block");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "emp-attandance-report.aspx/BindMainGridByJs",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gvDetails] tr").show();
                        $('.trnorecordfound').css("display", "none");
                        $("[id*=gvDetails] tr:gt(1)").remove();

                        $("#ctl00_head_trfortop").css("display", "block");
                        $("#ctl00_head_trforbottom").css("display", "block");

                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvDetails] tr:eq(1)").clone(true);
                            $("[id$=gvDetails]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.Month').html(data.d[i].Month);
                            $(row).find('.Noofworkingdays').html(data.d[i].Noofworkingdays);
                            $(row).find('.Noofpresentdays').html(data.d[i].Noofpresentdays);
                            $(row).find('.NoofLateCome').html(data.d[i].NoofLateCome);
                            $(row).find('.NoofHalfDays').html(data.d[i].NoofHalfDays);
                            $(row).find('.NoofPaidLeave').html(data.d[i].NoofPaidLeave);
                            $(row).find('.Noofunpaidleave').html(data.d[i].Noofunpaidleave);
                            $(row).find('.Noofabsentdays').html(data.d[i].Noofabsentdays);
                            if (i <= 1) {
                                $('#ctl00_head_lblwork').html(data.d[i].TotalNoofworkingdays);
                                $('#ctl00_head_lblPresent').html(data.d[i].TotalNoofpresentdays);
                                $('#ctl00_head_lblLate').html(data.d[i].TotalNoofLateCome);
                                $('#ctl00_head_lblHalf').html(data.d[i].TotalNoofHalfDays);
                                $('#ctl00_head_lblPaid').html(data.d[i].TotalNoofPaidLeave);
                                $('#ctl00_head_lblUnpaid').html(data.d[i].TotalNoofunpaidleave);
                                $('#ctl00_head_lblAbsent').html(data.d[i].TotalNoofabsentdays);
                            }

                            $(row).find("input[type=hidden][id*=hfpayid]").val(data.d[i].payid);
                        }
                        $("[id*=gvDetails] tr").show();
                        $("[id*=gvDetails] tr:eq(1)").hide();

                    }
                    else {
                        $("#ctl00_head_trfortop").css("display", "none");
                        $("#ctl00_head_trforbottom").css("display", "none");
                        $('#ctl00_head_divfornoofpresenttotal').css("display", "none ");
                        $("[id*=gvDetails] tr").hide();
                        $('.trnorecordfound').css("display", "block");

                    }
                    if (data.d.length == 1) {
                        $('#ctl00_head_divfornoofpresenttotal').css("display", "none");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }
    </script>
    <style>
        /*tr {
            border-bottom:1px black!important;
        }*/

        td {
            border-bottom: 1px solid black !important;
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
                        Attendance Report
                    </h1>                    
                    <div class="upload">                       
                        <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                            CausesValidation="false" CssClass="BtnExcel" Style="float: right; margin-top:-20px"
                            ToolTip="Click here to download Excel sheet" />
                    </div>
                </div>
                <div class="main-content">
                    <table width="100%" id="tabledetails" border="0" cellspacing="0" cellpadding="0" runat="server" >
                        <tr>
                            <td colspan="2" style="border-bottom: none;
    border-top: none;">From Date</td>
                            <td>
                                <asp:TextBox ID="txtFromDate" runat="server" Text=""></asp:TextBox>
                            </td>
                            <td colspan="2">To Date</td>
                            <td>
                                <asp:TextBox ID="txtToDate" runat="server" Text=""></asp:TextBox>
                            </td>
                             <td>
                                <asp:Button ID="btnfind" runat="server" Text="Find" OnClick="btnfind_Click"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="11">
                                <div style="height:10px; border-bottom: none; border-top: none;"></div>
                            </td>                           
                        </tr>
                        <tr>
                            <td colspan="11" style="width: 100%;">
                                <div class="divforstm">
                                    <asp:GridView runat="server" ID="gvDetails" ShowHeader="true" AutoGenerateColumns="false" CssClass="stm" OnRowDataBound="gvDetails_RowDataBound"
                                        CellPadding="5" Width="100%" HeaderStyle-Height="0px">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="50px" HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbladmno" runat="server" Text='<%# string .Format ("{0:dd/MMM/yyy}", Eval("Date")) %>' CssClass="RowNumber"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Status") %>' />
                                                    <asp:Label ID="lblattendancesttatus" runat="server" Text="" CssClass="Month"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField HeaderStyle-Width="100px" HeaderText="Absent" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" runat="server" Text='<%# Eval("IsAbsent") %>' CssClass="NoofLateCome"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>

                                            <%-- <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Admission No" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladmissionno" runat="server" Text='<%# Eval("AdmissionNo") %>' CssClass="Noofworkingdays"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Registration No" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpersent" runat="server" Text='<%# Eval("Registration_No") %>' Width="15px" Enabled="false" CssClass="Noofpresentdays" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
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
</asp:Content>