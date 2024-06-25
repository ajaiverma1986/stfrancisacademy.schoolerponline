<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="take-student-assign.aspx.cs" Inherits="BranchPanel_AttendanceManagement_take_student_assign" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Take/Update Assignment</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Assignment Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class For Assignment<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form" >
                        <label>
                            Section  For Attendance<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlsection" runat="server">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtdateforattendance" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
                    </div>
                     <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>
                    Assignment Topic<span style="color: Red">*</span>
                </label>
                <asp:TextBox ID="txttopic" runat="server" Width="200px"></asp:TextBox>
            </div>
                    <div class="for_sigle_row_form">
                <label>
                    Assign By<span style="color: Red">*</span>
                </label>
                <asp:TextBox ID="txtassign" runat="server" Width="200px"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="position: relative;">
                <label>
                    Upload Result<span style="color: Red">*</span></label>
                <asp:FileUpload runat="server" ID="fu1" />&nbsp;
                <div class="df0" style="left: 480px;">
                </div>
            </div>
                            <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="btnSend" runat="server" Text="Upload " CssClass="button_save" 
                ToolTip="Click here to upload the assignment." OnClick="btnSend_Click" />
        </div>
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
                    <div class="for_sigle_row_form" style="margin-bottom:10px;display:none" id="divforsubmit">
                        <label>
                        </label>
                        <asp:Button ID="btnforsubmit" runat="server" Text="SUBMIT" CssClass="button_save" />
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

            //$('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
            //    $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
            //    $.ajax({
            //        type: 'POST',
            //        contentType: "application/json; charset=utf-8",
            //        url: "take-student-assign.aspx/BindSectionDDL",
            //        data: "{'Classid':'" + $(this).val() + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            $('#ctl00_ContentPlaceHolder1_ddlsection').html('<option value="0">--Select Section--</option>');
            //            if (data.d.length > 0) {
            //                for (var i = 0; i < data.d.length; i++) {
            //                    $('#ctl00_ContentPlaceHolder1_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
            //                }
            //            }
            //        }
            //    });
            //});
            //$('#ctl00_ContentPlaceHolder1_btnforsubmit').click(function () {
            //    $('.tblforattendance').find('tbody').find('tr:gt(0)').each(function () {
            //        AdmissionNo = AdmissionNo + ',' + $(this).find('td:eq(1)').html();
            //        SturegNo = SturegNo + ',' + $(this).find('td:eq(2)').find('input[type="checkbox"]').val();
            //        if ($(this).find('td:eq(2)').find('input[type="checkbox"]').prop('checked') == true) {
            //            AttendanceStatus = AttendanceStatus + ',' + '0';
            //        }
            //        else {
            //            AttendanceStatus = AttendanceStatus + ',' + '1';
            //        } 
            //    });
            //    AdmissionNo = AdmissionNo.slice(1, AdmissionNo.length);
            //    SturegNo = SturegNo.slice(1, SturegNo.length);
            //    AttendanceStatus = AttendanceStatus.slice(1, AttendanceStatus.length);
            //    $.ajax({
            //        type: 'POST',
            //        contentType: "application/json; charset=utf-8",
            //        url: "take-student-assign.aspx/TakeAttendance",
            //        data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d == '1') {
            //                alertify.success('Attendance Taken Successfully.');
            //            }
            //            if (data.d == '0') {
            //                alertify.success('Some Error While Taking Attendance.');
            //            }
            //            AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
            //            return false;
            //        }
            //    });
            //    return false;
            //});
            //$('#ctl00_ContentPlaceHolder1_ddlsection,#ctl00_ContentPlaceHolder1_txtdateforattendance').change(function () {
            //    TakeAttendanceDefault();
            //});

            //$('.chkforabsent').live('change', function () {
            //    if ($(this).prop('checked') == true) {
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'red');
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', 'cursive');
            //    }
            //    else {
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'black');
            //        $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', '"Helvetica Neue",Helvetica,Arial,sans-serif');
            //    }
            //});

        });
        //function TakeAttendanceDefault() {
        //    if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
        //        alertify.error('Select Class Please.');
        //    }
        //    else if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
        //        alertify.error('Select Section Please.');
        //    }
        //    else if ($('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() == '') {
        //        alertify.error('Select Date Please.');
        //    }
        //    else {
        //        BindAttendanceGrid();
        //    }
        //    return false;
        //}
        //function BindAttendanceGrid() {
        //    $('#divforsubmit').css("display", "none");
        //    var trforappend = '', trclass = '', tdclass = '';
        //    $.ajax({
        //        type: 'POST',
        //        contentType: "application/json; charset=utf-8",
        //        url: "take-student-assign.aspx/BindAttendanceGrid",
        //        data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "','Date':'" + $('#ctl00_ContentPlaceHolder1_txtdateforattendance').val() + "'}",
        //        dataType: "json",
        //        success: function (data) {
        //            $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
        //            if (data.d.length > 0) {
        //                $('#divforsubmit').css("display", "block");
        //                for (var i = 0; i < data.d.length; i++) {
        //                    if (i % 2 == 0) {
        //                        trclass = 'stm_dark'
        //                    }
        //                    else {
        //                        trclass = 'stm_light'
        //                    }
        //                    if (data.d[i].CHECKBOXSTATUS != '') {
        //                        tdclass = 'style="color:red;font-family:cursive"'
        //                    }
        //                    else {
        //                        tdclass = '';
        //                    }
        //                    trforappend = trforappend + '<tr class="' + trclass + '">' +
        //                        '<td>' + data.d[i].ROWNUMBER + '</td>' +
        //                        '<td>' + data.d[i].ADMISSIONNO + '</td>' +
        //                        '<td><input type="checkbox" value="' + data.d[i].STUREGNO + '" ' + data.d[i].CHECKBOXSTATUS + ' class="chkforabsent" /></td>' +
        //                        '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
        //                        '<td>' + data.d[i].ATTENDANCESTATUS + '</td>' +
        //                        '</tr>'
        //                }
        //            }
        //            else {
        //                trforappend = '<tr>' +
        //                        '<td></td>' +
        //                        '<td></td>' +
        //                        '<td>No Student List Found.</td>' +
        //                        '<td</td>' +
        //                        '<td></td>' +
        //                        '</tr>'
        //            }
        //            $('.tblforattendance').append(trforappend);
        //            trforappend = '', trclass = '';
        //        }
        //    });
        //}
    </script>
</asp:Content>