<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="StudentPanel_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>

    <style type="text/css">
      
         .resultactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .resultactive i {
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
                        <i class="fa fa-list-alt" style="color: white"></i>
                        Offline Exam Result
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                       <div class="student-panel-tbl">
                    <table style="width: 100%" class="stm">
                        <tr class="stm_head">
                            <th style="width: 200px">S.No.</th>
                            <th style="width: 200px">Test Name
                            </th>
                            <th style="width: 200px">Test Date
                            </th>
                            <th style="width: 200px">Subject Name
                            </th>
                            <th style="width: 200px">Marks
                            </th>
                        </tr>
                    </table>
                           </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindExamResultDetail();
        });
        function BindExamResultDetail() {
            $('.stm').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Result.aspx/BindExamResultList",
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
                                            '<td>' + data.d[i].SubjectName + '</td>' +
                                            '<td>' + data.d[i].marks + '</td></tr>';

                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                           '<td>' + data.d[i].Testname + '</td>' +
                                            '<td>' + data.d[i].testdate + '</td>' +
                                            '<td>' + data.d[i].SubjectName + '</td>' +
                                            '<td>' + data.d[i].marks + '</td></tr>';
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
    </script>
</asp:Content>