<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="set-attendence.aspx.cs" Inherits="BranchPanel_set_attendence" %>

<%@ Register Src="~/BranchPanel/employee/attendance-management.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .activesetattendance {
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

        .ti_tx, .mi_tx, .mer_tx {
            width: 100%;
            text-align: center;
            margin: 10px 0;
        }

        .timepickerintime, .timepickerouttime {
            padding-left: 5px !Important;
            padding-top: 2px !Important;
            padding-bottom: 2px !Important;
        }

        .ui-datepicker-calendar th span {
            color: black !important;
        }

        .time, .mins, .meridian {
            width: 60px;
            float: left;
            margin: 0px 10px;
            font-size: 20px;
            color: #2d2e2e;
            font-family: 'arial';
            font-weight: 700;
        }

        .prev, .next {
            cursor: pointer;
            padding: 18px;
            width: 28%;
            border: 1px solid #ccc;
            margin: auto;
            border-radius: 5px;
            background: url(../../images/arrow.png) no-repeat;
        }

            .prev:hover, .next:hover {
                background-color: #ccc;
            }

        .next {
            background-position: 50% 150%;
        }

        .prev {
            background-position: 50% -50%;
        }

        .time_pick {
            position: relative;
        }

        .timepicker_wrap {
            padding: 10px;
            border-radius: 5px;
            z-index: 2;
            display: none;
            width: 240px;
            box-shadow: 2px 2px 5px 0px rgba(50, 50, 50, 0.35);
            background: #f6f6f6;
            border: 1px solid #ccc;
            float: left;
            position: absolute;
            top: 27px;
            left: 0px !important;
        }

        .arrow_top {
            position: absolute;
            top: -10px;
            left: 20px;
            width: 18px;
            height: 10px;
            z-index: 3;
            background: url(../../images/top_arr.png) no-repeat;
        }

        #ui-datepicker-div {
            width: 900px !important;
            left: 350px !important;
            top: 320px !important;
        }

        .ui-datepicker-calendar th span {
            font-size: 30px !important;
        }

        .ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
            font-size: 20px !important;
        }

        .ui-datepicker-week-end {
            color: #1C94C4 !important;
        }

        .ui-datepicker .ui-datepicker-header {
            margin-left: 250px !important;
            width: 400px !important;
            height: 35px !important;
        }

        .ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {
            height: 31px !important;
            font-size: 27px !important;
        }
    </style>

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <script type="text/javascript" src="../../js/timepicki.js">
    </script>
    <script type="text/javascript">
        var DateTxt = "", markasabsent = "0", intime = "", outtime = "", empno = "";

        function pageLoad() {
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $(".timepickerintime").timepicki();
            $(".timepickerouttime").timepicki();

            $("#ctl00_ContentPlaceHolder1_txtdateforattendance").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date(),
            });

            var yrRange = new Date().getFullYear();
            alert(yrRange);

            $('#ctl00_ContentPlaceHolder1_txtdateforattendance').datepicker().focus();
        }

        $(document).ready(function () {

            //var yrRange = new Date().getFullYear();
            //alert(yrRange);

            $(".timepickerintime").timepicki();
            $(".timepickerouttime").timepicki();

            $("#ctl00_ContentPlaceHolder1_txtdateforattendance").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                yearRange: '2014:2015',
                maxDate: new Date(),
            });

            $('#ctl00_ContentPlaceHolder1_txtdateforattendance').datepicker().focus();

            $('.lbtnabsent').click(function () {
                $(".chkall").find("input[type='checkbox']")
                markasabsent = "1";
                intime = $(this).parents("tr").find(".timepickerintime").val()
                outtime = $(this).parents("tr").find(".timepickerouttime").val()
                empno = $(this).parent("td").find("input[type='hidden']").val();
                UpdateAttendance();
                return false;
            });

            $('.lbtnedit').click(function () {
                $('.lbtnedit').css("display", "none");
                $('.lbtnupdate').css("display", "block");
                $('.lbtncancel').css("display", "block");
                return false;
            });

            $('.lbtnupdate').click(function () {
                markasabsent = "0";
                intime = $(this).parents("tr").find(".timepickerintime").val()
                outtime = $(this).parents("tr").find(".timepickerouttime").val()
                empno = $(this).parents("tr").find("input[type='hidden']").val();
                UpdateAttendance();
                return false;
            });

            $('.lbtncancel').click(function () {
                $('.lbtnedit').css("display", "block");
                $('.lbtnupdate').css("display", "none");
                $('.lbtncancel').css("display", "none");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnclose').click(function () {
                CloseDay();
            });

            $('#ctl00_ContentPlaceHolder1_txtdateforattendance').change(function () {
                DateTxt = $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val();
                if (DateTxt == "") {
                    alert("Select Date First");
                    $('#ctl00_ContentPlaceHolder1_txtdateforattendance').focus();
                    return false;
                }
                SetAttendance();
            });

        });

        function CloseDay() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/CloseDay",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alert("Attendance closed sucessfully.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        BindGrid();
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'none');
                    }
                    return false;
                },
                error: function (result) {
                    alert("Some Internal Error");
                    return false;
                }
            });
        }

        function SetAttendance() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/InsertAttendance",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alert("Attendance Taken Sucessfully.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        BindGrid();
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'block');
                    }

                    if (data.d == 2) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alert("Attendance has already taken");
                        $('#ctl00_ContentPlaceHolder1_txtdateforattendance').focus();
                    }

                    if (data.d == 3) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alert("Today is weekly off.");
                        $('#ctl00_ContentPlaceHolder1_txtdateforattendance').focus();
                    }

                    if (data.d == 4) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alert("Today is holiday");
                        $('#ctl00_ContentPlaceHolder1_txtdateforattendance').focus();
                    }

                    if (data.d == 5) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alert("Today is holiday & as well weekly off.");
                        $('#ctl00_ContentPlaceHolder1_txtdateforattendance').focus();
                    }

                    if (data.d == 6) {
                        alert("Attendance has already taken but you did not close the day so please close day.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        BindGrid();
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'block');
                    }

                    return false;
                },
                error: function (result) {
                    alert("Some Internal Error");
                    return false;
                }
            });
        }

        function UpdateAttendance() {
            $(".chkabsent").prop('disabled', true);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/UpdateAttendance",
                data: "{'Date':'" + DateTxt + "','eid':'" + empno + "','intime':'" + intime + "','outtime':'" + outtime + "','absent':'" + markasabsent + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d >= 1) {
                        alert("Attendance Updated Sucessfully.");
                    }
                    DateTxt = "", markasabsent = "0", intime = "", outtime = "", empno = "";
                    return false;
                },
                error: function (result) {
                    alert("Some Internal Error");
                    return false;
                }
            });
        }

        function BindGrid() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/BindDatatable",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {

                    $("[id*=gvdetails] tr:gt(1)").remove();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find(".EmpNo").html(data.d[i].Emp_No);
                            $(row).find(".EmpName").html(data.d[i].Name);

                            var intime = data.d[i].intime;
                            $(row).find(".timepickerintime").val(data.d[i].intime);
                            $(row).find(".timepickerouttime").val(data.d[i].outtime);
                            $(row).find("td input[type=hidden]").val(data.d[i].eid);
                        }

                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:eq(1)").hide();
                    }

                    $(".timepickerintime").timepicki();
                    $(".timepickerouttime").timepicki();
                },
                error: function (result) {
                    alert("Some Internal Error");
                }
            });
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Management</a></li>
            <li><a>Attendance Management</a></li>
            <li style="background: none;"><a class="active" href="#">Set Attendance Manually</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="margin-bottom: 50px ! important; margin-top: 30px !important; background-color: #F7F7F7; height: auto !important;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div class="for_sigle_row_form" style="margin-bottom: 5px !important">
                            <label style="padding-top: 7px;">
                                Selected Date
                            </label>
                            <asp:TextBox ID="txtdateforattendance" runat="server" Placeholder="Select Date" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="divgrid" runat="server" style="display: block;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr id="trmessage" style="display: none">
                        <td>
                            <asp:Label ID="lblmessage" runat="server" Text="Today Is Holiday So You Can't Take Attendance." Style="color: red; font-size: 15px; margin-left: 150px;"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trgrid" runat="server" style="display: block">
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                                GridLines="None" Width="100%" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Emp No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdType" runat="server" Text='<%# Eval("Emp_No") %>' CssClass="EmpNo"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Emp Name" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNoOfClicks" runat="server" Text='<%# Eval("Name") %>' CssClass="EmpName"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="200px" HeaderText="In Time" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtintimetimepicer" runat="server" Text='<%# Eval("intime") %>' CssClass="timepickerintime"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Out Time" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtouttimepicer" runat="server" Text='<%# Eval("outtime") %>' CssClass="timepickerouttime"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Click As Absent" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnabsent" runat="server" Text="Click For Absent" Style="text-decoration: none; display: block; float: left; margin-left: 40px ! important" CssClass="lbtnabsent" OnClientClick="return false;"></asp:LinkButton>
                                            <asp:HiddenField ID="hfidforupdate" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnedit" runat="server" Text="Edit" Style="text-decoration: none; display: block; width: 50px; float: left; margin-left: 65px ! important" CssClass="lbtnedit" OnClientClick="return false;"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnupdate" runat="server" Text="Update" Style="text-decoration: none; display: none; width: 70px; float: left; margin-left: 20px ! important" CssClass="lbtnupdate" OnClientClick="return false;"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtncancel" runat="server" Text="Cancel" Style="text-decoration: none; display: none; width: 70px; float: left" CssClass="lbtncancel" OnClientClick="return false;"></asp:LinkButton>
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

                <div class="for_sigle_row_form" style="margin-bottom: 5px !important">
                    <label style="padding-top: 7px;">
                    </label>
                    <asp:Button ID="btnclose" runat="server" Text="Close Day" CssClass="button2" Style="width: 124px; cursor: pointer; display: none" OnClientClick="return false;" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>