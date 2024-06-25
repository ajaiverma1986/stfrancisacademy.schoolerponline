<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="new-admissionlist.aspx.cs" Inherits="StudentPanel_new_admissionlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>

    <style type="text/css">
        .admissionactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .admissionactive i {
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
                        <i class="fa fa-edit" style="color: white"></i>
                        Admission
                    </h1>
                </div>
                <div class="clearfix"></div>
                <div class="main-content" style="width: 100%;">

                    <div class="student-panel-tbl">
                        <table style="width: 100%" class="stm1">
                            <tr class="stm_head">
                                <th style="width: 200px">S.No
                                .</th>
                                <th style="width: 200px">Courses
                                </th>
                                <th style="width: 200px">Date
                                </th>
                                <th style="width: 200px">Academic Year
                                </th>
                                <th style="width: 200px">Total Fee
                                </th>
                                <th style="width: 200px">Paid Fee
                                </th>
                                <th style="width: 200px">Balance Fee
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
            BindGrid();
        });

        function BindGrid() {
            $('.stm1').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "new-admissionlist.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td>' + data.d[i].Coursename + '</td>' +
                                            '<td>' + data.d[i].Joindate + '</td>' +
                                            '<td>' + data.d[i].FYName + '</td>' +
                                            '<td>' + (parseInt(data.d[i].Paid) + parseInt(data.d[i].Balanceamount)) + '</td>' +
                                            '<td>' + data.d[i].Paid + '</td>' +
                                            '<td>' + data.d[i].Balanceamount + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                             '<td>' + data.d[i].Coursename + '</td>' +
                                             '<td>' + data.d[i].Joindate + '</td>' +
                                             '<td>' + data.d[i].FYName + '</td>' +
                                             '<td>' + (parseInt(data.d[i].Paid) + parseInt(data.d[i].Balanceamount)) + '</td>' +
                                             '<td>' + data.d[i].Paid + '</td>' +
                                             '<td>' + data.d[i].Balanceamount + '</td></tr>';
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