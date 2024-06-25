<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="create-timetable-schedule.aspx.cs" EnableEventValidation="false" Inherits="BranchPanel_Timetable_create_timetable_schedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .t1 {
        }
        .t2 {
        }
            .t2 input {
                float: left;
                margin-top: 10px;
            }
            .t2 select {
                float: left;
                margin-top: 10px;
            }
        .showpopuptopic {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            left: 50%;
            opacity: 1;
            max-height: 500px;
            display: block;
            overflow: auto;
            padding-bottom: 8px !important;
            top: 15%;
            width: 500px !important;
            margin-left: -250px !important;
        }
    </style>
    <div class="content_pane_cont input_content  main-div-tbl" id="contentPane">
        <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">Time Table Schedule</span>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Class:<span style="color: red">*</span></label>
            <asp:DropDownList ID="ddlclass" runat="server"></asp:DropDownList>
        </div>
         <div class="for_sigle_row_form">
            <label>Select Section:<span style="color: red">*</span></label>
            <asp:DropDownList ID="ddlsection" runat="server"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
                <label>Schedule From Date<span style="font-weight: bold; color: red">*</span></label>
                <input id="txtfromdate" type="text" readonly="readonly" placeholder="Select From Date"/>
            </div>
            <div class="for_sigle_row_form">
                 <label>Schedule To Date</label>
                <input id="txttodate" type="text" readonly="readonly" placeholder="Select To Date"/>
            </div>
        <div class="clear"></div>
        <div id="DaynameList" style="display: none;">
            <table class="stm DaynameList">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Day Name</th>
                    <th>Schedule</th>
                    <th>Status</th>
                    <th>Details</th>
                </tr>
            </table>
        </div>
        <div id="divforsetperiod" style="text-align: center; display: none;" class="showpopuptopic showpopup2">
            <div class="" style="">
                <table  style="width:100%;background-color: white; vertical-align: top;">
                    <tr>
                        <td colspan="2" class="pop-headng-sty">Add Schedule
                            <a id="BtnCancelTopic" title="Close this from here"
                                class="btnClose">
                                <img alt="No Image" src="../../images/popupcross.png" /></a>
                        </td>
                        <td class="t2">
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Period:</label>
                        </td>
                        <td class="t2">
                            <asp:Label ID="lbldayname" runat="server" Text="Dayname"></asp:Label>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Select Subject:<span style="font-weight: bold; color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <select id="ddlsubject"></select>
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Select Teacher:<span style="font-weight: bold; color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <select id="ddlteacher"></select>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Remark:</label>
                        </td>
                        <td class="t2">
                            <textarea id="txta" rows="5" cols=""></textarea>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="btnschedule" runat="server" Text="Submit" CssClass="button_save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="divforperiod" style="display: none">
            <table class="stm ViewPeriodList">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Period</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Set Schedule</th>
                </tr>
            </table>
            <div class="for_sigle_row_form">
            <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button_cancel" />
                </div>
        </div>
         <div id="divfordetail" style="display: none">
            <table class="stm showdetail">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Period</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Subject</th>
                     <th>Teacher</th>
                </tr>
            </table>
            <div class="for_sigle_row_form">
            <asp:Button ID="btnbackfordetail" runat="server" Text="Back" CssClass="button_cancel" />
                </div>
        </div>
        <div id="DivforViewSchedulelist" style="display: none">
            <table class="stm ViewSchedulelist">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Period</th>
                    <th>Subject</th>
                    <th>Teacher</th>
                </tr>
            </table>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_cancel" />
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var year = 2050, valid = 0, starttime = '';
        var classid = 0, dayid = 0, dayname = '', Periodid = 0, periodname = '', subjectid = 0, subjectname = '', teachername='', teacherid = 0, fyid = 0, fromdate = '', todate = '', sectionid = 0, remark = '';
        $(document).ready(function () {
            $("#txtfromdate,#txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:' + year,
                dateFormat: 'dd MM yy'
            });
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                classid = $(this).val();
                if (classid > 0) {
                    BindSection();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlsection').change(function () {
                sectionid = $(this).val();
                $('#DaynameList').show(500);
                $('#divforperiod').css('display', 'none');
                fillClassScheduleList();
            });
            $('.SetSchedule').live('click', function () {
                $('#divfordetail').hide();
                dayid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                var gettr = '<tr>'+$(this).parent('td').parent('tr').html()+'</tr>';
                $('.DaynameList').find('tr:gt(0)').remove();
                $('.DaynameList').append(gettr);
                $('#divforperiod').css('display', 'block');
                showperiod();
                return false;
            });
            $('.btnClose').click(function () {
                $('#divforsetperiod').css('display', 'none');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
                $('#divforperiod').css('display', 'none');
                $('.DaynameList tr:gt(0)').remove();
                fillClassScheduleList();
                return false;
            });
            $('.imgfroaddtopic').click(function () {
                var lasttroftable = $('.showpopuptopic').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopuptopic').find('tbody').find('tr:last').remove();
                var trforadd = $(this).parent('td').parent('tr').prop('outerHTML');
                $('#divaddCourseSchudle .showpopuptopic').append(trforadd);
                $('.showpopuptopic').find('tbody').find('tr:last').find('.imgfroaddtopic').attr('src', '../images/minus.png');
                $('.showpopuptopic').find('tbody').find('tr:last').find('img').removeClass('imgfroaddtopic');
                $('.showpopuptopic').find('tbody').find('tr:last').find('img').addClass('imgfrosubtopic');
                $('#divaddCourseSchudle .showpopuptopic').append(lasttroftable);
                return false;
            });
            $('.imgfrosubtopic').live('click', function () {
                $(this).parent('td').parent('tr').remove();
                return false;
            });
            $('.ViewSchedule').live('click', function () {
                if ($(this).text() == 'View Schedule') {
                    dayid = 0, dayname = '';
                    dayid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    dayname = $(this).parent('td').parent('tr').find('td:eq(1)').html();
                    var trindex = $(this).parent('td').parent('tr').index();
                    var trdata = '<tr>' + $('.stm').find('tr:eq(' + (parseInt(trindex)) + ')').html() + '</tr>'
                    $('.DaynameList').find('tr:gt(0)').remove();
                    $('.DaynameList').append(trdata);
                    $('#DivforViewSchedulelist').show(500);
                    ViewScheduleDetail();
                }
                else {
                    alertify.error("No Record Found.");
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnback').click(function () {
                //fillCourseScheduleList();
                //$('#DivforViewSchedulelist').hide(500);
                return false;
            });
            $('.imgbtnedit').live('click', function () {
                Mode = 2, csid = 0;
                csid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('#ctl00_ContentPlaceHolder1_lbldayname').text(dayname);
                $('#ctl00_ContentPlaceHolder1_ddlfromtime').val($(this).parent('td').parent('tr').find('td:eq(1)').html());
                $('#ctl00_ContentPlaceHolder1_ddltotime').val($(this).parent('td').parent('tr').find('td:eq(2)').html());
                $('#divaddCourseSchudle').show(500);
                $('.imgfroaddtopic').hide();
                return false;
            });
            $('.imgbtndelete').live('click', function () {
                csid = 0, Mode = 3;
                csid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                if (csid > 0) {
                    alertify.confirm("Are You Sure You Want To Delete This Schedule.?", function (e) {
                        if (e) {
                            DeleteCourseSchedule();
                        }
                    });

                }
                return false;
            });
            $('.imgbtnset').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == 0) {
                    alertify.error("Please Select The Section");
                    return false;
                }
                if ($('#txtfromdate').val() == '') {
                    alertify.error("Please Select The From Date");
                    return false;
                }
                else {
                    periodname = $(this).parent('td').parent('tr').find('td:eq(1)').html();
                    Periodid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    starttime = $(this).closest('tr').find('td:eq(2)').html();
                    checkschedule();
                    if (valid==2) {
                        $('#divforsetperiod').show(500);
                        $('#ctl00_ContentPlaceHolder1_lbldayname').text(periodname);
                        Bindsubject();
                        BindTeacher();
                    }
                    return false;
                }
            });
            $('#ctl00_ContentPlaceHolder1_btnschedule').click(function () {
                if ($('#ddlsubject').val() == 0) {
                    alertify.error("Please Select The Subject");
                    return false;
                }
                if ($('#ddlteacher').val() == 0) {
                    alertify.error("Please Select The Teacher");
                    return false;
                }
                else {
                    FillField();
                    SaveTimetableSchedule();
                    $('#divforsetperiod').css('display', 'none');
                    valid = 0;
                    $('#txta').val('');
                    return false;
                }
            });
            $('.viewimage').live('click', function () {
                $('#divforperiod').css('display', 'none');
                $('#divfordetail').show();
                var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                $('.DaynameList').find('tr:gt(0)').remove();
                $('.DaynameList').append(gettr);
                dayid=$(this).parent('td').parent('tr').find('input[type=hidden]').val();
                showDetails();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnbackfordetail').click(function () {
                $('#divfordetail').hide();
                fillClassScheduleList();
                return false;
            });
        });

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        function BindSection() {
            call_progressbar("start");
            $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-timetable-schedule.aspx/Sectionname",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                             $("#ctl00_ContentPlaceHolder1_ddlsection").html("");
                             $("#ctl00_ContentPlaceHolder1_ddlsection").append($("<option></option>").val('0').html('--Select Section--'));
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlsection").append($("<option></option>").val(value.cwsid).html(value.sectionname));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                        call_progressbar("end");
                     }
                 });
        }
        function Bindsubject() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-timetable-schedule.aspx/Subject",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         $("#ddlsubject").html("");
                         //$("#ddlteacher").html("");
                         $("#ddlsubject").append($("<option></option>").val('0').html('--Select Subject--'));
                         //$("#ddlteacher").append($("<option></option>").val('0').html('--Select Teacher--'));
                         $.each(data.d, function (key, value) {
                             $("#ddlsubject").append($("<option></option>").val(value.Subjectid).html(value.Subjectname));
                             //$("#ddlteacher").append($("<option></option>").val(value.cwsid).html(value.sectionname));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                     }
                 });
        }
        function BindTeacher() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-timetable-schedule.aspx/Teacher",
                     data: "{}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         //$("#ddlsubject").html("");
                         $("#ddlteacher").html("");
                         //$("#ddlsubject").append($("<option></option>").val('0').html('--Select Subject--'));
                         $("#ddlteacher").append($("<option></option>").val('0').html('--Select Teacher--'));
                         $.each(data.d, function (key, value) {
                             //$("#ddlsubject").append($("<option></option>").val(value.cwsid).html(value.sectionname));
                             $("#ddlteacher").append($("<option></option>").val(value.eid).html(value.fname));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                     }
                 });
        }
        function fillClassScheduleList() {
            $('.DaynameList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-timetable-schedule.aspx/fillClassScheduleList",
                data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "','sectionid':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].dayname + '</td>' +
                                    '<td><input class="SetSchedule" type="image"  src="../../images/schedule.png" title="Click Here For Schedule ." style="width:20px" /><input type="hidden" value="' + data.d[i].did + '" /></td>' +
                                     '<td>'+ data.d[i].Status +'</td>'+
                                     '<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].dayname + '</td>' +
                                    '<td><input class="SetSchedule" type="image"  src="../../images/schedule.png" title="Click Here For Schedule ." style="width:20px" /><input type="hidden" value="' + data.d[i].did + '" /></td>' +
                                     '<td>' + data.d[i].Status + '</td>' +
                                     '<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td></tr>';
                            $('.DaynameList').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found.");
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                    alertify.error("Some error");
                }
            });
        }
        function FillField() {
            subjectid = $('#ddlsubject').val();
            subjectname = $('#ddlsubject option:selected').text();
            teacherid = $('#ddlteacher').val();
            teachername = $('#ddlteacher option:selected').text();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            fromdate = $('#txtfromdate').val();
            todate = $('#txttodate').val();
            //sectionid = $('#ctl00_ContentPlaceHolder1_ddlsection').val();
            remark = $('#txta').val();
        }
        function SaveTimetableSchedule() {
            call_progressbar("start");
            $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-timetable-schedule.aspx/savetimetable",
                     data: "{'classid':'" + classid + "','dayid':'" + dayid + "','Periodid':'" + Periodid + "','subjectid':'" + subjectid + "','teacherid':'" + teacherid + "','fyid':'" + fyid + "','fromdate':'" + fromdate + "','todate':'" + todate + "','sectionid':'" + sectionid + "','remark':'" + remark + "','subjectname':'" + subjectname + "','teachername':'" + teachername + "','starttime':'" + starttime + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         if (data.d == 1) {
                             alertify.success("Time Table schedule saved successfully.");
                         }
                         else if (data.d == 2) {
                             alertify.success("Time Table schedule Updated successfully.");
                         }
                         else if (data.d == 3) {
                             alertify.error("Teacher is already Scheduled For This Time");
                         }
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                     }
                 });
        }
        function ViewScheduleDetail() {
            $('.ViewSchedulelist tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "course-session-scheduled.aspx/ViewScheduleDetail",
                data: "{'Courseid':'" + Courseid + "','Brid':'" + Brid + "','dayid':'" + dayid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].csid + '" /></td>' +
                                    '<td>' + data.d[i].CourseFromTime + '</td>' +
                                    '<td>' + data.d[i].CourseToTime + '</td>' +
                                    '<td><input class="imgbtnedit" type="image"  src="../images/edit.png" title="Click Here For Edit ." /></td>' +
                                     '<td><input class="imgbtndelete" type="image"  src="../images/ic.png" title="Click Here For Edit ." /></td></tr>';
                            else
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].csid + '" /></td>' +
                                   '<td>' + data.d[i].CourseFromTime + '</td>' +
                                   '<td>' + data.d[i].CourseToTime + '</td>' +
                                   '<td><input class="imgbtnedit" type="image"  src="../images/edit.png" title="Click Here For Edit ." /></td>' +
                                    '<td><input class="imgbtndelete" type="image"  src="../images/ic.png" title="Click Here For Edit ." /></td></tr>';
                            $('.ViewSchedulelist').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found.");
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                }
            });
        }
        function DeleteCourseSchedule() {
            call_progressbar("start");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "course-session-scheduled.aspx/DeleteCourseSchedule",
                     data: "{'Mode':'" + Mode + "','csid':'" + csid + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         if (data.d == 1) {
                             alertify.error("Course schedule Delete successfully.");
                             ViewScheduleDetail();
                         }
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                     }
                 });
        }
        function showperiod() {
            $('.ViewPeriodList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "timetable-settings.aspx/showPeriodDetail",
                data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                    '<td>' + data.d[i].Periodname + '</td>' +
                                    '<td>' + data.d[i].StartTime + '</td>' +
                                    '<td>' + data.d[i].EndTime + '</td>' +
                                     '<td><input class="imgbtnset" type="image"  src="../../images/schedule.png" title="Click Here For Schedule ." style="width:20px" /></td></tr>';
                            else
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                    '<td>' + data.d[i].Periodname + '</td>' +
                                    '<td>' + data.d[i].StartTime + '</td>' +
                                    '<td>' + data.d[i].EndTime + '</td>' +
                                     '<td><input class="imgbtnset" type="image"  src="../../images/schedule.png" title="Click Here For Schedule ." style="width:20px" /></td></tr>';
                            $('.ViewPeriodList').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found");
                    }
                },
                error: function (result) {
                    alertify.error('Some Error');
                }
            });
        }

        function checkschedule() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-timetable-schedule.aspx/CheckSchedule",
                data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "','dayid':'" + dayid + "','Periodid':'" + Periodid + "','sectionid':'" + $('#ctl00_ContentPlaceHolder1_ddlsection').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.error("This Period Already Scheduled.");
                        valid = 0;
                        $('#divforsetperiod').hide(500);
                    }
                    else {
                        valid = 2;
                    }
                }
            });
        }

        function showDetails() {
            $('.showdetail tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-timetable-schedule.aspx/PeriodDetail",
                data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "','sectionid':'" + sectionid + "','dayid':'" + dayid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                    '<td>' + data.d[i].Periodname + '</td>' +
                                    '<td>' + data.d[i].StartTime + '</td>' +
                                    '<td>' + data.d[i].EndTime + '</td>' +
                                    '<td>' + data.d[i].Subjectname + '</td>' +
                                    '<td>' + data.d[i].Facultyname + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                    '<td>' + data.d[i].Periodname + '</td>' +
                                    '<td>' + data.d[i].StartTime + '</td>' +
                                    '<td>' + data.d[i].EndTime + '</td>' +
                                    '<td>' + data.d[i].Subjectname + '</td>' +
                                      '<td>' + data.d[i].Facultyname + '</td></tr>';
                            $('.showdetail').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found");
                    }
                },
                error: function (result) {
                    alertify.error('Some Error');
                }
            });
        }
    </script>
</asp:Content>

