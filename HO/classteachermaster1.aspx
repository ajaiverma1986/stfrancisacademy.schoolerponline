<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="classteachermaster1.aspx.cs" Inherits="HO_classteachermaster1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var Fyid = 0, ClassID = 0, Brid = 0, SectionID = 0, TeacherID = 0, count = 0;
        $(document).ready(function () {
            $('.gridSubject').hide();
            BindFinancialYear();
            $("#btnSubmit").live('click', function () {
                if ($("#ctl00_ContentPlaceHolder1_ddlTeacher").val() == "0") {
                    alertify.error('Please Select Teacher');
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlclass").val() == "0") {
                    alertify.error('Please Select Class');
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlSection").val() == "0") {
                    alertify.error('Please Select Section');
                    return false;
                }
                var Allstatus = '', AllsubjectId = '';;
                $('#gridSubjectList').find('tr:gt(0)').each(function () {  
                    var status = 0;
                    var checkbox = $(this).find('td:eq(2)').find('input[type="checkbox"]');
                    if (checkbox.prop('checked') == true)
                        status = 1;
                    else
                        status = 0;
                    Allstatus = Allstatus + '~' + status;

                    var subjectId = $(this).find('td:eq(0)').find('input[type="hidden"]').val();
                    AllsubjectId = AllsubjectId + '~' + subjectId;
                });
                if (Brid != "0" && Fyid != "0" && ClassID != "0" && SectionID != "0" && TeacherID != "0") {
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "classteachermaster1.aspx/SaveOrUpdateSubjectToTeacher",
                        data: "{'Brid':'" + Brid + "','Fyid':'" + Fyid + "','Classid':'" + ClassID + "','Sectionid':'" + SectionID + "','Eid':'" + TeacherID + "','SubjectID':'" + AllsubjectId + "','Status':'" + Allstatus + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d > 0) {
                                alertify.success('Records are Updated.');
                            } else {
                                alertify.error('Some Record are not Updated');
                            }
                        }
                    });
                }
            });
            $("#chkAllStatus").live('click', function () {
                $('#gridSubjectList').find('tr:gt(0)').each(function () {
                    var checkbox = $(this).find('td:eq(2)').find('input[type="checkbox"]');
                    if ($("#chkAllStatus").prop('checked') == true)
                        checkbox.attr('checked', true);
                    else
                        checkbox.attr('checked', false);
                });
            });
            $("#chkAllStatus").live('click', function () {
                $('#gridSubjectList').find('tr:gt(0)').each(function () {
                    var checkbox = $(this).find('td:eq(2)').find('input[type="checkbox"]');
                    if ($("#chkAllStatus").prop('checked') == true)
                        checkbox.attr('checked', true);
                    else
                        checkbox.attr('checked', false);
                });
            });
            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").live('change', function () {
                Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
                if (Fyid != undefined && Fyid != "0") {
                    BindClass();
                }
            });
            $("#ctl00_ContentPlaceHolder1_ddlTeacher").live('change', function () {
                TeacherID = $("#ctl00_ContentPlaceHolder1_ddlTeacher").val();
                if (TeacherID != undefined && TeacherID != "0") {
                    BindSubject();
                } else {
                    $('.gridSubject').hide();
                }
            });
            $("#ctl00_ContentPlaceHolder1_ddlclass").live('change', function () {
                $('.gridSubject').hide();
                ClassID = $("#ctl00_ContentPlaceHolder1_ddlclass").val();
                BindSection();
            });
            $("#ctl00_ContentPlaceHolder1_ddlSection").live('change', function () {
                SectionID = $("#ctl00_ContentPlaceHolder1_ddlSection").val();
                if (SectionID != undefined && SectionID != "0") {
                    BindSubject();
                }
            });
        });
        function BindSubject() {
            if ($("#ctl00_ContentPlaceHolder1_ddlclass").val() == "0") {
                alertify.error('Please Select Class');
                return false;
            }
            if ($("#ctl00_ContentPlaceHolder1_ddlSection").val() == "0") {
                alertify.error('Please Select Section');
                return false;
            }
            if ($("#ctl00_ContentPlaceHolder1_ddlTeacher").val() == "0") {
                alertify.error('Please Select Teacher');
                return false;
            }

            $('.gridSubject').show();
            var trforappend = '', ClassPaid = '';
            $('#gridSubjectList tbody').find('tr:gt(0)').remove();
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "classteachermaster1.aspx/BindSubjectList",
                data: "{'Brid':'" + Brid + "','Fyid':'" + Fyid + "','Classid':'" + ClassID + "','Sectionid':'" + SectionID + "','Eid':'" + TeacherID + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 == 0)
                                ClassPaid = "stm_dark";
                            else
                                ClassPaid = "stm_light";

                            var chkStatus = '';
                            if (data.d[i].Status == 1)
                                chkStatus = 'checked'
                            else
                                chkStatus = '';

                            trforappend = trforappend + '<tr class=' + ClassPaid + '>'
                                + '<td><input type="hidden" value=' + data.d[i].SubjectId + ' />' + (i + 1) + '</td>'
                                + '<td>' + data.d[i].SubName + '</td>'
                                + '<td><input type="checkbox" id="chkStatus" name="chkStatus" value="chkStatus" ' + chkStatus + '></td>'
                                + '</tr>'
                        }
                    }
                    $('#gridSubjectList tbody').append(trforappend);
                }
            });
        }
        function BindFinancialYear() {
            call_progressbar('start');
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "AdmissionType.aspx/getFinancialYears",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            $.each(data.d, function (data, value) {
                                $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").append($("<option></option>").val(value.Fyid).html(value.FYName));
                            });
                            Fyid = data.d[0].CurrentFyid;
                            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val(data.d[0].CurrentFyid);
                            if (Fyid != undefined && Fyid != "0") {
                                BindBranch();
                            }
                        }
                        call_progressbar('end');
                    },
                    error: function (result) {
                        call_progressbar('end');
                        alertify.error("Some Error Occue While City Is Updating.");
                        return false;
                    }
                });
        }
        function BindBranch() {
            $('#ctl00_ContentPlaceHolder1_ddlBranch').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindBranchDDL",
                data: "{'Fyid':'" + Fyid + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlBranch').html('<option value="0">--Select Branch--</option>');
                    if (data.d.length > 0) {
                        Brid = $('#ctl00_ContentPlaceHolder1_hfBrid').val();
                        for (var i = 0; i < data.d.length; i++) {
                            if (Brid == data.d[i].Brid) {
                                $('#ctl00_ContentPlaceHolder1_ddlBranch').append('<option value="' + data.d[i].Brid + '">' + data.d[i].BrName + '</option>');
                            }
                        }
                        $('#ctl00_ContentPlaceHolder1_ddlBranch').val($('#ctl00_ContentPlaceHolder1_hfBrid').val());
                        BindTeacherList();
                        if (Fyid != undefined && Fyid != "0") {
                            BindClass();
                        }
                    }
                }
            });
        }
        function BindClass() {
            $('#ctl00_ContentPlaceHolder1_ddlclass').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindClassDDL",
                data: "{'Fyid':'" + Fyid + "','Brid':'" + Brid + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlclass').html('<option value="0">--Select Class--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                        }
                    }
                }
            });
        }
        function BindSection() {
            $('#ctl00_ContentPlaceHolder1_ddlSection').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../BranchPanel/Admission/new-admission.aspx/BindSectionDDL",
                data: "{'Classid':'" + ClassID + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlSection').html('<option value="0">--Select Section--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlSection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                        }
                    }
                }
            });
        }
        function BindTeacherList() {
            $('#ctl00_ContentPlaceHolder1_ddlTeacher').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "classteachermaster1.aspx/BindTeacherList",
                data: "{'Brid':'" + Brid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#ctl00_ContentPlaceHolder1_ddlTeacher').html('<option value="0">--Select Teacher--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddlTeacher').append('<option value="' + data.d[i].Eid + '">' + data.d[i].EmpName + '</option>');
                            }
                        }
                    }
                }
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/load_process.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
    </script>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Teacher in Class and Section</h2>
        </div>
        <div style="width: 50%; float: left">
            <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server"></asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <asp:HiddenField ID="hfBrid" runat="server" />
                <label>Select Branch<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlBranch" runat="server" Enabled="false"></asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>Select Teacher<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlTeacher" runat="server"></asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>Select Class<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlclass" runat="server"></asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>Select Section<span style="color: Red; font-weight: bold">*</span></label>
                <asp:DropDownList ID="ddlSection" runat="server"></asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form gridSubject">
                <center>
                    <button type="button" id="btnSubmit" class="button_save">Save</button>
                    <button type="button" id="btnCanel" class="button2">Canel</button>
                </center>
            </div>
        </div>
        <div class="for_sigle_row_form gridSubject" style="width: 50%; float: right">
            <table id="gridSubjectList" class="stm" cellspacing="0" cellpadding="6" border="0" style="width: 90%; border-collapse: collapse;">
                <tbody>
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col">S.No </th>
                        <th align="center" scope="col">Subject Name</th>
                        <th align="center" scope="col">Status<input type="checkbox" style="float: right" id="chkAllStatus" name="chkAllStatus" value="chkAllStatus" /></th>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="for_sigle_row_form" style="width: 50%; float: right">
        </div>
        <div class="clear"></div>
        <br />
    </div>
    <div id="divProgressBar" class="progress" style="padding: 10% 0 0 0"></div>
</asp:Content>
