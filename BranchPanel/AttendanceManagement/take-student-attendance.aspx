<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="take-student-attendance.aspx.cs" Inherits="BranchPanel_AttendanceManagement_take_student_attendance" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">    
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Take/Update Attendance</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Attendance Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class For Attendance<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        <asp:HiddenField ID="hdClassId" runat="server" Value="5"/>
                        <asp:HiddenField ID="hdClassName" runat="server" Value="5"/>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Section  For Attendance<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                        <asp:HiddenField ID="hdSectionId" runat="server" Value="-1"/>
                        <asp:HiddenField ID="hdSectionName" runat="server" Value="-1"/>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Update Option<span style="color: #ff0066">*</span></label>
                        <asp:DropDownList ID="ddlUpdateOption" runat="server">
                            <asp:ListItem Selected="True" Value="0" Text="--Select Option--"></asp:ListItem>
                            <asp:ListItem Value="1" Text="By Website"></asp:ListItem>
                            <asp:ListItem Value="2" Text="By Upload Excel"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form" id="divDate1">
                        <label>
                            Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtdateforattendance" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
                    </div>
                    <div id="divStdAttByExcel">
                        <div class="sub-heading">
                            Update Student Attandance by Uploading Excel
                                <div class="upload">
                                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;" OnClick="IBExcel_Click"
                                        ToolTip="Click here to download Excel sheet" />
                                </div>
                        </div>
                        <div class="ClassForAttendance2">
                            <div style="margin-left: 4%;">
                                <asp:FileUpload ID="FileUpload2" runat="server" />
                                &nbsp;
                           <asp:Button ID="Button2" Style="" runat="server" Text="Upload" CssClass="button_save" OnClick="btnUpload1_Click" />
                                <%--<asp:Button id="Button2"  runat="server" Text="Upload"  style="background-color: cornflowerblue;padding: 3px;border-radius: 3px;color: white;" OnClick="btnUpload1_Click"/><br />--%>
                                <asp:Label ID="lblError2" runat="server" ForeColor="Red"></asp:Label>
                                <asp:Label ID="lblmessage2" runat="server" ForeColor="Green"></asp:Label>
                            </div>
                        </div>
                        <div class="ClassForAttendance1">
                            <table class="stm tblforattendance1" border="1" width="100%" style="display:none">
                                <tr class="stm_head">
                                    <th>Student Name</th>
                                    <th>Admission No</th>
                                    <th>RegNo</th>
                                    <th>Class</th>
                                    <th>Section</th>
                                    <th>Attandance Status</th>
                                </tr>
                            </table>
                        </div>
                        <br />
                    </div>
                    <div id="divStdAttByWeb">
                        <div class="sub-heading">
                            Student List
                        </div>
                        <div class="ClassForAttendance">
                            <table class="stm tblforattendance" width="100%">
                                <tr class="stm_head">
                                    <th>S.NO.</th>
                                    <th>Admission NO</th>
                                    <th>Mark As Absent</th>
                                    <th>Student Name</th>
                                    <th>Attendance Status</th>
                                </tr>
                            </table>
                        </div>
                        <div class="for_sigle_row_form" style="margin-bottom: 10px; display: none" id="divforsubmit">
                            <label>
                            </label>
                            <asp:Button ID="btnforsubmit" runat="server" Text="SUBMIT" CssClass="button_save" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2015;
        var AdmissionNo = '', AttendanceStatus = '', SturegNo = '', Mode = 0;
        $(document).ready(function () {
            $('#divDate').hide();
            $('#divStdAttByExcel').hide();
            $('#divStdAttByWeb').hide();

            $("#ctl00_ContentPlaceHolder1_txtdateforattendance").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());

            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {                
                $('#ctl00_ContentPlaceHolder1_lblError2').val('');
                $('#ctl00_ContentPlaceHolder1_lblmessage2').val('');
                $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "take-student-attendance.aspx/BindSectionDDL",
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
            $('#ctl00_ContentPlaceHolder1_btnforsubmit').click(function () {
                $('.tblforattendance').find('tbody').find('tr:gt(0)').each(function () {
                    AdmissionNo = AdmissionNo + ',' + $(this).find('td:eq(1)').html();
                    SturegNo = SturegNo + ',' + $(this).find('td:eq(2)').find('input[type="checkbox"]').val();
                    if ($(this).find('td:eq(2)').find('input[type="checkbox"]').prop('checked') == true) {
                        AttendanceStatus = AttendanceStatus + ',' + '0';
                    }
                    else {
                        AttendanceStatus = AttendanceStatus + ',' + '1';
                    }
                });
                debugger
                AdmissionNo = AdmissionNo.slice(1, AdmissionNo.length);
                SturegNo = SturegNo.slice(1, SturegNo.length);
                AttendanceStatus = AttendanceStatus.slice(1, AttendanceStatus.length);
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "take-student-attendance.aspx/TakeAttendance",
                    data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == '1') {
                            alertify.success('Attendance Taken Successfully.');
                        }
                        if (data.d == '0') {
                            alertify.success('Some Error While Taking Attendance.');
                        }
                        AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
                        return false;
                    }
                });
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlUpdateOption,#ctl00_ContentPlaceHolder1_txtdateforattendance').change(function () {
                getClassSection();
                $('#ctl00_ContentPlaceHolder1_lblError2').val('');
                $('#ctl00_ContentPlaceHolder1_lblmessage2').val('');
                if ($('#ctl00_ContentPlaceHolder1_ddlUpdateOption').val() == '1') {
                    $('#divDate').show();
                    $('#divStdAttByExcel').hide();
                    $('#divStdAttByWeb').show();
                    Mode = 1;
                } else {
                    $('#divDate').hide();
                    $('#divStdAttByExcel').show();
                    $('#divStdAttByWeb').hide();
                    Mode = 2;
                }
                TakeAttendanceDefault();
            });
            //$(".BtnExcel").click(function (e) {
            //    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
            //        if (e) {
            //            //var className = $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').find('option:selected').text();
            //            //var section = $('#ctl00_ContentPlaceHolder1_ddlsection').find('option:selected').text();
            //            //var todaysDate = moment().format('DD-MM-YYYY');
            //            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.ClassForAttendance1').html()));
            //            e.preventDefault();
            //        }
            //    });
            //    return false;
            //});
            $('.chkforabsent').live('change', function () {
                if ($(this).prop('checked') == true) {
                    $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'red');
                    $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', 'cursive');
                }
                else {
                    $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'black');
                    $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', '"Helvetica Neue",Helvetica,Arial,sans-serif');
                }
            });
        });
        function GetStdAttandance() {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "take-student-attendance.aspx/GetTableCoumn",
                data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '1') {
                        alertify.success('Attendance Taken Successfully.');
                    }
                    if (data.d == '0') {
                        alertify.success('Some Error While Taking Attendance.');
                    }
                    AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
                    return false;
                }
            });
        }
        function getClassSection() {
            $('#<%= hdClassId.ClientID %>').val($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val());
            $('#<%= hdSectionId.ClientID %>').val($('#ctl00_ContentPlaceHolder1_ddlsection').val());

            $('#<%= hdClassName.ClientID %>').val($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').find('option:selected').text());
            $('#<%= hdSectionName.ClientID %>').val($('#ctl00_ContentPlaceHolder1_ddlsection').find('option:selected').text());
        }

        function TakeAttendanceDefault() {
            getClassSection();
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
                if (Mode == 1) {
                    BindAttendanceGrid();
                }
            }
            return false;
        }
        function BindAttendanceGrid() {
            $('#divforsubmit').css("display", "none");
            var trforappend = '', trclass = '', tdclass = '';
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "take-student-attendance.aspx/BindAttendanceGrid",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (Mode == 1) {
                        $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
                    } else {
                        $('.tblforattendance1').find('tbody').find('tr:gt(0)').remove();
                    }

                    if (data.d.length > 0) {
                        $('#divforsubmit').css("display", "block");
                        for (var i = 0; i < data.d.length; i++) {
                            var attandane = 0;
                            if (i % 2 == 0) {
                                trclass = 'stm_dark'
                            }
                            else {
                                trclass = 'stm_light'
                            }
                            if (data.d[i].CHECKBOXSTATUS != '') {
                                if (Mode == 1) {
                                    tdclass = 'style="color:red;font-family:cursive"';
                                } else {
                                    attandane = 1;
                                }
                            }
                            else {
                                tdclass = '';
                                attandane = 0;
                            }
                            if (Mode == 1) {
                                trforappend = trforappend + '<tr class="' + trclass + '">' +
                                    '<td>' + data.d[i].ROWNUMBER + '</td>' +
                                    '<td>' + data.d[i].ADMISSIONNO + '</td>' +
                                    '<td><input type="checkbox" value="' + data.d[i].STUREGNO + '" ' + data.d[i].CHECKBOXSTATUS + ' class="chkforabsent" /></td>' +
                                    '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
                                    '<td>' + data.d[i].ATTENDANCESTATUS + '</td>' +
                                    '</tr>'
                            } else {
                                trforappend = trforappend + '<tr class="' + trclass + ' excelTable">' +
                                    '<td ' + tdclass + '>' + data.d[i].NAME + '(' + data.d[i].REGNEWNO + ')</td>' +
                                    '<td ' + tdclass + '>' + data.d[i].ADMISSIONNO + '</td>' +
                                    '<td ' + tdclass + '>' + data.d[i].STUREGNO + '</td>' +
                                    '<td ' + tdclass + '>' + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').find('option:selected').text() + '</td>' +
                                    '<td ' + tdclass + '>' + $('#ctl00_ContentPlaceHolder1_ddlsection').find('option:selected').text() + '</td>' +
                                    '<td ' + tdclass + '>' + attandane + '</td>' +
                                    '</tr>'
                            }
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
                    if (Mode == 1) {
                        $('.tblforattendance').append(trforappend);
                    } else {
                        $('.tblforattendance1').append(trforappend);
                    }
                }
            });
        }
    </script>
</asp:Content>
