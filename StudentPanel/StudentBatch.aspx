<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="StudentBatch.aspx.cs" Inherits="StudentPanel_StudentBatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
       
           .batchactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
        }
        .side-bar-wrapper .side-menu > li .batchactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }
        
        .ISheighlight {
            background-color:green;
        }

    </style>
    <link href="css/exam.css" rel="stylesheet" />
        <div class="content_pane_cont input_content" id="contentPane">

    <div id="Batchdetail">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                   
                    <h1>
                        <i class="fa fa-archive" style="color: white"></i>
                        Batch 
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                    <div  id="Divforbatchdetails">
                        </div>

<div class="clearfix"></div>




                         <div id="divforschedule">
       
                <div class="page-header">
                   
                    <h1>
                        <i class="icon-user" style="color: white"></i>
                        Lecture Schedules
                    </h1>
                </div>
                <div class="clearfix"></div>
              
                      <div class="student-panel-tbl">
                    <table style="width:100%" class="stm1">
                        <tr class="stm_head">
                            <th >Lecture No.
                            </th>
                            <th >Date
                            </th>
                            <th >Timing
                            </th>
                            <th >Subject
                            </th>
                            <th>Topic
                            </th>
                            <th >Faculty
                            </th>
                            <th >Status
                            </th>
                        </tr>
                    </table>
                          </div>
                    <label id="lblmsg"></label>
               
       
    </div>
                </div>


            

            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>

   

    <div id="div1" class="progress"></div>
            </div>
    <script type="text/javascript">
        var msg = '';
        $(document).ready(function () {
           
            BindGrid();
            BindLectureGrid();
        });

        function BindGrid() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentBatch.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#Divforbatchdetails').append('<div style="border: 1px solid #41E1E6;" id="Divforbatchdetails" class="conductedlecture234 thirdbox">'+
                          '<dd>Batch Detail:</dd><div class="clear"></div><span id="Span5">Batch Name=</span><span  id="lblbatchname">' + data.d[i].batchname + '</span>' +
                          '<div class="clear"></div><span id="Span3">Joining Date</span><span  id="lbljoindate">' + data.d[i].joindate + '</span><div class="clear"></div>' +
                          '<span id="Span7">Status</span><span  id="lblstatus">' + data.d[i].status + '</span><div class="clear"></div>' +
                          '<span id="Span1">Lecture Name:</span><span  id="lbllecture">' + data.d[i].LectureName + '</span><div class="clear"></div>' +
                          '<span id="Span9">Schedules</span><span  id="lblschedule">' + data.d[i].totalschedule + '</span><div class="clear"></div>' +
                          '<span id="Span11">Conducted Lectures</span><span  id="lblnooflecture">' + data.d[i].conducted + '</span><div class="clear"></div>' +
                          '<span id="Span13">Attended Lecture</span><span  id="lblattenlec">' + data.d[i].attended + '</span><div class="clear"></div></div>')
                        }

                    }
                    else {
                        alertify.error("No Record Found");
                    }
                },
                error: function (response) {
                    alertify.error("Some Error");
                }
            });
        }

        function BindLectureGrid() {
            var Dateheightlight = '';
            $('.stm1').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "StudentBatch.aspx/BindLectureSchedule",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length == 1) {
                        msg = data.d[0].mesg;
                        $('.stm1').hide();
                        $('#lblmsg').html(msg);
                    }
                    else {
                        for (var i = 0; i < data.d.length; i++) {
                            Dateheightlight = '';
                            if (data.d[i].status == 'Conducted')
                                Dateheightlight = 'ISheighlight';
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td align="center"><span class=' + Dateheightlight + '>' + data.d[i].date + '</span></td>' +
                                            '<td>' + data.d[i].time + '</td>' +
                                            '<td>' + data.d[i].SubName + '</td>' +
                                            '<td>' + data.d[i].topicname + '</td>' +
                                            '<td>' + data.d[i].facultyname + '</td>' +
                                            '<td>' + data.d[i].status + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                           '<td align="center"><span class=' + Dateheightlight + '>' + data.d[i].date + '</span></td>' +
                                            '<td>' + data.d[i].time + '</td>' +
                                            '<td>' + data.d[i].SubName + '</td>' +
                                            '<td>' + data.d[i].topicname + '</td>' +
                                            '<td>' + data.d[i].facultyname + '</td>' +
                                            '<td>' + data.d[i].status + '</td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                    }
                },
                error: function (response) {
                }
            });
        }
    </script>
</asp:Content>