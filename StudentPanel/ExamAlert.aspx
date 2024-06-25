<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="ExamAlert.aspx.cs" Inherits="StudentPanel_ExamAlert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
      
         .alertactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .alertactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }



    </style>
    <link href="css/exam.css" rel="stylesheet" />
    <div id="divforattendence" class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                   
                    <h1>
                        <i class="fa fa-bell" style="color: white"></i>
                        Offline Exam Alert
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                       <div class="student-panel-tbl">
                    <table style="width: 100%" class="stm1">
                        <tr class="stm_head">
                            <th>S.No.
                            </th>
                            <th>Test Name
                            </th>
                            <th>Test Date
                            </th>
                            <th>Subject Name
                            </th>
                            <th>Topic Name
                            </th>
                            <th>Start Time
                            </th>
                            <th>End Time
                            </th>
                        </tr>
                    </table>

   <div class="student-panel-tbl">

                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindExamDetail();
        });
        function BindExamDetail() {
            $('.stm1').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ExamAlert.aspx/BindExamList",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Testname + '</td>' +
                                            '<td>' + data.d[i].testdate + '</td>' +
                                            '<td>' + data.d[i].subname + '</td>' +
                                            '<td>' + data.d[i].topic + '</td>' +
                                            '<td>' + data.d[i].testtime1 + '</td>' +
                                            '<td>' + data.d[i].testtime2 + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                           '<td>' + data.d[i].Testname + '</td>' +
                                            '<td>' + data.d[i].testdate + '</td>' +
                                            '<td>' + data.d[i].subname + '</td>' +
                                            '<td>' + data.d[i].topic + '</td>' +
                                            '<td>' + data.d[i].testtime1 + '</td>' +
                                            '<td>' + data.d[i].testtime2 + '</td></tr>';
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