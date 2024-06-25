<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="time-table-report.aspx.cs" Inherits="EmployeePanel_time_table_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            BindTeacherTimeTableGrid();
        });
        function BindTeacherTimeTableGrid() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "time-table-report.aspx/BindTeacherTimeTable",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_head_tablecreatetimetable").css("display", "block");
                    if (data.d.length > 0) {

                        var row = $("[id*=gridcreatetimetable] tr:last-child").clone(true);
                        $("[id*=gridcreatetimetable] tr").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=gridcreatetimetable] tr:last-child").clone(true);
                            }
                            $("[id$=gridcreatetimetable]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.Day').html(data.d[i].Day);
                            $(row).find('.Dayid').html(data.d[i].RowNumber);
                            $(row).find('.DayForCheck').html(data.d[i].Day);
                            $(row).find('.FirstLectureClass').html(data.d[i].FirstLectureClass);
                            $(row).find('.FirstLectureSubject').html(data.d[i].FirstLectureSubject);
                            $(row).find('.SecondLectureClass').html(data.d[i].SecondLectureClass);
                            $(row).find('.SecondLectureSubject').html(data.d[i].SecondLectureSubject);
                            $(row).find('.ThirdLectureClass').html(data.d[i].ThirdLectureClass);
                            $(row).find('.ThirdLectureSubject').html(data.d[i].ThirdLectureSubject);
                            $(row).find('.FourthLectureClass').html(data.d[i].FourthLectureClass);
                            $(row).find('.FourthLectureSubject').html(data.d[i].FourthLectureSubject);
                            $(row).find('.FifthLectureClass').html(data.d[i].FifthLectureClass);
                            $(row).find('.FifthLectureSubject').html(data.d[i].FifthLectureSubject);
                            $(row).find('.SixthLectureClass').html(data.d[i].SixthLectureClass);
                            $(row).find('.SixthLectureSubject').html(data.d[i].SixthLectureSubject);
                            $(row).find('.SeventhLectureClass').html(data.d[i].SeventhLectureClass);
                            $(row).find('.SeventhLectureSubject').html(data.d[i].SeventhLectureSubject);
                            $(row).find('.EightthLectureClass').html(data.d[i].EightthLectureClass);
                            $(row).find('.EightthLectureSubject').html(data.d[i].EightthLectureSubject);
                        }
                        $("[id*=gridcreatetimetable] tr").show();
                        $("[id*=gridcreatetimetable] tr:first-child").show();
                    }
                },
                error: function (result) {
                    alert("Some Internal Error...Try Again.");
                }
            });

        }
    </script>
    <style>
        .timetableactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        td {
            border-bottom: 1px solid black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }

        .overflow {
            overflow: auto !important;
            border-radius: 10px;
            border: 3px solid #82403B;
        }

        .pd40 {
            padding: 0 55px;
        }

        .pd30 {
            padding: 0 36px;
        }

        #ctl00_head_tablecreatetimetable tr td span {
            font-size: 13px !important;
        }
    </style>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Time Table
                    </h1>
                </div>
                <div class="main-content">
                    <div class="overflow">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" runat="server">
                            <tr class="stm_head">
                                <td rowspan="4" align="center" class="pd30" style="width: 300px; font-size: 11px; border-right: 1px solid none; border-bottom: 1px solid none;">S.No.
                                </td>
                                <td rowspan="4" align="center" class="pd30" style="width: 550px; font-size: 11px; border-right: 1px solid none; border-bottom: 1px solid none;">Day
                                </td>
                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-right: 1px solid none; border-bottom: 1px solid none;">1st Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-right: 1px solid none; border-bottom: 1px solid none;">2nd Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">3rd Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">4th Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">5th Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">6th Lecture
                                </td>

                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">7th Lecture
                                </td>
                                <td colspan="2" align="center" style="width: 500px; font-size: 11px; border-bottom: 1px solid none; border-right: 1px solid none;">8th Lecture
                                </td>
                            </tr>

                            <tr class="stm_head">

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>

                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">From
                                </td>
                                <td width="50px" align="center" class="pd40" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">To
                                </td>
                            </tr>

                            <tr class="stm_head">

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">9:35 AM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">10:30 AM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">10:30 AM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">11:30 AM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">11:30 AM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">12:30 PM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">12:30 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">12:55 PM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">1:25 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:00 PM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:00 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:15 PM
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:15 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:45 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">2:45 PM
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">3:00 PM
                                </td>
                            </tr>

                            <tr class="stm_head">

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>

                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Class
                                </td>
                                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid none; border-right: 1px solid none;">Subject
                                </td>
                            </tr>

                            <tr>
                                <td align="left" colspan="22" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                                    <asp:GridView ID="gridcreatetimetable" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                        runat="server" CssClass="stm0" ShowHeader="false">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblSNo" Text='<%# Bind("eid") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="110px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblday" runat="server" CssClass="Day"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="100px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof1stlecture" runat="server" CssClass="FirstLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof1stlecture" runat="server" CssClass="FirstLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof2ndlecture" runat="server" CssClass="SecondLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof2ndlecture" runat="server" CssClass="SecondLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof3rdlecture" runat="server" CssClass="ThirdLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof3rdlecture" runat="server" CssClass="ThirdLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof4thlecture" runat="server" CssClass="FourthLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof4thlecture" runat="server" CssClass="FourthLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof5thlecture" runat="server" CssClass="FifthLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof5thlecture" runat="server" CssClass="FifthLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof6thlecture" runat="server" CssClass="SixthLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof6thlecture" runat="server" CssClass="SixthLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof7thlecture" runat="server" CssClass="SeventhLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof7thlecture" runat="server" CssClass="SeventhLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclassof8thlecture" runat="server" CssClass="EightthLectureClass" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="lblsubjectof8thlecture" runat="server" CssClass="EightthLectureSubject" Style="text-decoration: none"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                        <RowStyle CssClass="stm_light" />
                                        <AlternatingRowStyle CssClass="stm_dark" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>