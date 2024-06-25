<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="StudentAttendance.aspx.cs" Inherits="StudentPanel_StudentAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        .attendenceactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .attendenceactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }
    </style>
    <link href="css/exam.css" rel="stylesheet" />
     <div class="content_pane_cont input_content" id="contentPane">
    <div id="divforattendence" class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">

                    <h1>
                        <i class="fa fa-list-ul" style="color: white"></i>
                        Attendance
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                    <div class="student-panel-tbl">
                        <table style="width: 100%" class="stm">
                            <tr class="stm_head">
                                <th>S.No.</th>
                                <th>Subject
                                </th>
                                <th>Total
                                </th>
                                <th>Present
                                </th>
                                <th>Absent
                                </th>
                                <th>% Attendance
                                </th>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divforsubject" class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">

                    <h1>
                        <i class="icon-user" style="color: white"></i>
                        Subject Lecture Details
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                   
                    <table style="width: 100%" class="stm1">
                        <tr class="stm_head">
                            <th>S.No.</th>
                            <th>Date
                            </th>
                            <th>Time
                            </th>
                            <th>Topics Covered
                            </th>
                            <th>Status
                            </th>
                        </tr>
                    </table>
                     <button id="btnback" class="button_save" style="margin-left: 600">Back</button>
                </div>
            </div>
        </div>
    </div>
          <div id="divProgressBar" class="progress"></div>
         </div>
    <script type="text/javascript">
        var subid = 0;
        $(document).ready(function () {
            $('#divforsubject').hide();
            BindLectureAttendenceGrid();

            $('.inputname').click(function () {
                $('#divforattendence').hide(500);
                $('#divforsubject').show(500);
                subid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                BindSubjectDetail();
                return false;
            });

            $('#btnback').click(function () {
                $('#divforattendence').show(500);
                $('#divforsubject').hide(500);
                return false;
            });
        });
        function BindLectureAttendenceGrid() {
            $('.stm').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentAttendance.aspx/BindLectureAttendence",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td><input type="hidden" value=' + data.d[i].sbid + '><a class="inputname" style="cursor:pointer;color:red;text-decoration: underline;">' + data.d[i].sbName + '</a></td>' +
                                            '<td>' + data.d[i].total + '</td>' +
                                            '<td>' + data.d[i].present + '</td>' +
                                            '<td>' + data.d[i].absent + '</td>' +
                                            '<td>' + data.d[i].percentage + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                             '<td><input type="hidden" value=' + data.d[i].sbid + '><a class="inputname" style="cursor:pointer;color:red;text-decoration: underline;">' + data.d[i].sbName + '</a></td>' +
                                            '<td>' + data.d[i].total + '</td>' +
                                            '<td>' + data.d[i].present + '</td>' +
                                            '<td>' + data.d[i].absent + '</td>' +
                                            '<td>' + data.d[i].percentage + '</td></tr>';
                            }
                            $('.stm').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found");
                    }
                },
                error: function (response) {
                }
            });
        }

        function BindSubjectDetail() {
            $('.stm1').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentAttendance.aspx/BindSujectDetail",
                data: "{'subid':'" + subid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Data + '</td>' +
                                            '<td>' + data.d[i].Time + '</td>' +
                                            '<td>' + data.d[i].Topic + '</td>' +
                                            '<td>' + data.d[i].status + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Data + '</td>' +
                                            '<td>' + data.d[i].Time + '</td>' +
                                            '<td>' + data.d[i].Topic + '</td>' +
                                            '<td>' + data.d[i].status + '</td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("No Record Found");
                    }
                },
                error: function (response) {
                }
            });
        }
    </script>
</asp:Content>