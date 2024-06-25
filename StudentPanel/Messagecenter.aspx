<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="Messagecenter.aspx.cs" Inherits="StudentPanel_Messagecenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        
           .noticeactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .noticeactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }



    </style>
    <link href="css/exam.css" rel="stylesheet" />
    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                   
                    <h1>
                        <i class="fa fa-sticky-note" style="color: white"></i>
                        Notice Board
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">
                       <div class="student-panel-tbl">
                    <table style="width: 100%" class="stm1">
                        <tr class="stm_head">
                            <th style="width:5%;">S.No.
                            </th>
                            <th>Notice
                            </th>
                            <th style="width:15%;">Date
                            </th>
                        </tr>
                    </table>
                           </div>
                    <asp:HiddenField ID="hfpages" runat="server" />
                    <br />
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindStudentMessage();
            var year = 2020;
            $("#txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + year
            });
        });

        $('#txtchannel').on('change paste', function () {
            FilField();
            BindStudentMessage();
            return false;
        });

        $('#txtsender').on('change paste', function () {
            FilField();
            BindStudentMessage();
            return false;
        });

        $("#txtdate").on('change paste', function () {
            FilField();
            BindStudentMessage();
            return false;
        });

        $('#txtsubject').on('change paste', function () {
            FilField();
            BindStudentMessage();
            return false;
        });

        $('#ctl00_head_btnclear').live('click', function () {
            $('#txtchannel').val('');
            $('#txtsender').val('');
            $('#txtdate').val('');
            $('#txtsubject').val('');
            FilField();
            BindStudentMessage();
            return false;
        });
        function FilField() {
            channel = $('#txtchannel').val();
            sender = $('#txtsender').val();
            date = $('#txtdate').val();
            subject = $('#txtsubject').val();
        }
        function BindStudentMessage() {
            $('.stm1').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Messagecenter.aspx/BindStudentMessage",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td><input type="hidden" value=' + data.d[i].SnId + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Message + '</td>' +
                                            '<td>' + data.d[i].ActiveFrom + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark"><td><input type="hidden" value=' + data.d[i].SnId + '>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Message + '</td>' +
                                            '<td>' + data.d[i].ActiveFrom + '</td></tr>';
                            }
                            $('.stm1').append(trforappend);
                        }
                    }
                    else {
                        alertify.error('No Record Found');
                    }
                },
                error: function (response) {
                    alert(" Some Network Isues");
                }
            });
        }
    </script>
</asp:Content>