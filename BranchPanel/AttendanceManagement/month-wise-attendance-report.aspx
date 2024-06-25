<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="month-wise-attendance-report.aspx.cs" Inherits="BranchPanel_AttendanceManagement_month_wise_attendance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Monthly Attendance Report</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Attendance Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Session<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlregistrationsession" runat="server">
                            <asp:ListItem Value="0">--Select  Session--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Class<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Section<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Month<span style="color: Red; font-weight: bold">*</span></label>
                         <asp:DropDownList ID="ddlmonth" runat="server">
                            <asp:ListItem Value="0">--Select  Month--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="sub-heading">
                        Attendance List
                    </div>
                    <div class="ClassForAttendance">
                        <table class="stm tblforattendance" width="100%">
                            <tr class="stm_head">
                                <th>S.NO.</th>
                                <th>Admission NO</th>
                                <th>Student Name</th>
                                <th>No Of Days</th>
                                <th>Present</th>
                                <th>Absent</th>
                                <th>Percentage(%)</th>
                                <th>Details</th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2015;
        var Fyid = 0;
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtdateforattendance").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());
            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
                $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "month-wise-attendance-report.aspx/BindSectionDDL",
                    data: "{'Classid':'" + $(this).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddlsection').html('<option value="0">--Select Section--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                            }
                        }
                    }
                });
            });
            $('#ctl00_ContentPlaceHolder1_ddlmonth').change(function () {
                TakeAttendanceDefault();
            });
            $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').change(function () {
                Fyid = $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val();
                BindMonth();
            });
            BindMonth();
        });
        function BindMonth() {
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val();
            $('#ctl00_ContentPlaceHolder1_ddlmonth').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "month-wise-attendance-report.aspx/BindMonthMethod",
                data: "{'Fyid':'" + Fyid + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlmonth').html('<option value="0">--Select Month--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlmonth').append('<option value="' + data.d[i].ID + '">' + data.d[i].NAME + '</option>');
                        }
                    }
                }
            });
        }
        function TakeAttendanceDefault() {
            if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
                alertify.error('Select Class Please.');
            }
            else if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
                alertify.error('Select Section Please.');
            }
            else {
                BindAttendanceGrid();
            }
            return false;
        }
        function BindAttendanceGrid() {
            $('#divforsubmit').css("display", "none");
            var trforappend = '', trclass = '', tdclass = '';
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "month-wise-attendance-report.aspx/BindAttendanceGrid",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "','MonthId':'" + $('#ctl00_ContentPlaceHolder1_ddlmonth').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
                    if (data.d.length > 0) {
                        $('#divforsubmit').css("display", "block");
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 == 0) {
                                trclass = 'stm_dark'
                            }
                            else {
                                trclass = 'stm_light'
                            }
                            trforappend = trforappend + '<tr class="' + trclass + '">' +
                                '<td>' + data.d[i].ROWNUMBER + '</td>' +
                                '<td>' + data.d[i].ADMISSIONNO + '</td>' +
                                '<td>' + data.d[i].NAME + '</td>' +
                                '<td>' + data.d[i].NOD + '</td>' +
                                '<td>' + data.d[i].PRE + '</td>' +
                                '<td>' + data.d[i].ABS + '</td>' +
                                '<td>' + data.d[i].PER + '</td>' +
                                '<td><img class="viewdocument" type="image" style="height:15px;width:15px;border-width:0px;" src="../../images/viewquestion.png" /></td>' +
                                '</tr>'
                        }
                    }
                    else {
                        trforappend = '<tr>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td>No Student List Found.</td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td></td>' +
                                '</tr>'
                    }
                    $('.tblforattendance').append(trforappend);
                    trforappend = '', trclass = '';
                }
            });
        }
    </script>
</asp:Content>

