<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="daily-student-attendance-report.aspx.cs" Inherits="BranchPanel_AttendanceManagement_daily_student_attendance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Daily Attendance Report</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Attendance Information
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
                            Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtdateforattendance" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
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
                                <th>Present</th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2015;
        var AdmissionNo = '', AttendanceStatus = '', SturegNo = '';
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
                    url: "daily-student-attendance-report.aspx/BindSectionDDL",
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
            $('#ctl00_ContentPlaceHolder1_ddlsection,#ctl00_ContentPlaceHolder1_txtdateforattendance').change(function () {
                TakeAttendanceDefault();
            });
        });
        function TakeAttendanceDefault() {
            if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
                alertify.error('Select Class Please.');
            }
            else if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
                alertify.error('Select Section Please.');
            }
            else if ($('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() == '') {
                alertify.error('Select Date Please.');
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
                url: "daily-student-attendance-report.aspx/BindAttendanceGrid",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
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
                            if (data.d[i].CHECKBOXSTATUS != '') {
                                tdclass = 'style="color:red;font-family:cursive"'
                            }
                            else {
                                tdclass = '';
                            }
                            trforappend = trforappend + '<tr class="' + trclass + '">' +
                                '<td>' + data.d[i].ROWNUMBER + '</td>' +
                                '<td>' + data.d[i].ADMISSIONNO + '</td>' +
                                '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
                                '<td ' + tdclass + '>' + data.d[i].ATTENDANCESTATUS + '</td>' +
                                '</tr>'
                        }
                    }
                    else {
                        trforappend = '<tr>' +
                                '<td></td>' +
                                '<td></td>' +
                                '<td>No Student List Found.</td>' +
                                '<td</td>' +
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

