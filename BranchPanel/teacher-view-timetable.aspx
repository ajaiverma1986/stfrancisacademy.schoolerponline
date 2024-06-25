<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="teacher-view-timetable.aspx.cs" Inherits="BranchPanel_teacher_view_timetable" %>

<%@ Register Src="~/BranchPanel/view-time-table.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <style type="text/css">
        .activeteachertimetable {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        a {
            text-decoration: none !important;
        }

        .progress {
            display: none;
        }

        .progressAdd {
            display: block;
            position: absolute;
            background-color: #FAFAFA;
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }

        table td {
            color: black!important;
        }

        #loader {
            position: relative;
            top: 10%;
        }

        .maindivpopup {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 18px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 32%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 38%;
            z-index: 2147483647;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            width: 184px;
            height: 30px;
            padding-top: 5px;
            color: black;
            font-size: 14px !important;
            padding-left: 25px;
            text-align: left !important;
            border: 1px solid #ddd;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
            border: 1px solid #ddd;
        }
    </style>

    <script type="text/javascript">

        var classid = "0", sectionid = "0", subjectid = "0", teacherid = "0", dayid = "", lectureid = "", classname = "", sectionname = "", mode = "0", temp = "0", teachername = "";

        $(document).ready(function () {

            document.title = "View Teacher Time Table"

            $("#btclose").click(function () {

                $("#maindivpopup").fadeOut(500);
                $('.maindivpopup').fadeOut(500);
                return false;

            });

            $('#ctl00_ContentPlaceHolder1_gridcreatetimetable a').click(function () {
                mode = "2";
                temp = "1"
                $('#maindivpopup').fadeIn(500);
                $('.maindivpopup').fadeIn(500);
                teachername = $("#ctl00_ContentPlaceHolder1_ddlteacher option:selected").text();
                dayid = $(this).parent('div').find('.Dayid').text();
                lectureid = $(this).parent('div').find('.lectureid').text();
                var lecturename = $(this).parent('div').find('.lecturename').text();
                var day = $(this).parent('div').find('.DayForCheck').html();
                fillclassdropdown();
                $('#ctl00_ContentPlaceHolder1_lblday').html(day);
                $('#ctl00_ContentPlaceHolder1_lblperiod').html(lecturename);
                $('#ctl00_ContentPlaceHolder1_lblteachername').html(teachername);
                if ($(this).text().trim() == "Set Subject" || $(this).text().trim() == "Set Class") {
                    $('#ctl00_ContentPlaceHolder1_lbltext').html('Create Time Table');
                    mode = "1";
                    temp = "0"
                }
                else {
                    BindSelectedSubjectAndTeacher();
                }
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnclosepopup").click(function () {
                subjectid = "0";
                classid = "0";
                sectionid = "0";
                temp = "0";
                lectureid = "0";
                dayid = "0";
                $("#maindivpopup").fadeOut(500);
                $('.maindivpopup').fadeOut(500);
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlsection").change(function () {
                sectionid = document.getElementById("ctl00_ContentPlaceHolder1_ddlsection").value;
                fillsubjectdropdown();
            });

            $("#ctl00_ContentPlaceHolder1_ddlclass").change(function () {
                classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlclass").value;
                if (classid != "0") {
                    BindSection();
                    fillsubjectdropdown();
                    document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = "0";
                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlsubject").change(function () {
                subjectid = document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value;
            });

            $("#ctl00_ContentPlaceHolder1_ddlteacher").change(function () {
                teacherid = document.getElementById("ctl00_ContentPlaceHolder1_ddlteacher").value;

                if (teacherid != "0") {
                    BindTeacherTimeTableGrid();
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_tablecreatetimetable").css("display", "none");

                }

            });

            $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {
                inserttimetable();
                return false;
            });
        });

        function BindSelectedSubjectAndTeacher() {
            temp = "1";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "teacher-view-timetable.aspx/Bindselectedsubjectteacher",
                data: "{'teacherid':'" + teacherid + "','lectureid':'" + lectureid + "','Dayid':'" + dayid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_ddlsubject").val(data.d[0].subjectid);
                        subjectid = data.d[0].subjectid;
                        classid = data.d[0].classid;
                        sectionid = data.d[0].sectionid;
                        $('#ctl00_ContentPlaceHolder1_ddlclass').val(data.d[0].classid);
                        BindSection();
                        fillsubjectdropdown();
                    }
                },
                error: function (result) {
                    alert("Some Internal Error");
                }
            });
        }

        function inserttimetable() {
            if (classid == "0") {
                alert("Please Select Class.");
                return false;
            }
            else if (sectionid == "0") {
                alert("Please Select Section.");
                return false;
            }
            else if (subjectid == "0") {
                alert("Please Select Subject Name.");
                return false;
            }
            else {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "create-time-table.aspx/InsertTimeTable",
                    data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','subjectid':'" + subjectid + "','teacherid':'" + teacherid + "','wdid':'" + dayid + "','lectureid':'" + lectureid + "','mode':'" + mode + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alert("Time table of " + teachername + " has been created successfully");
                            BindTeacherTimeTableGrid();
                            $("#popup").css("display", "none");
                            $('.maindivpopup').css("display", "none");
                            subjectid = "0";
                            classid = "0";
                            sectionid = "0";
                            temp = "0";
                            lectureid = "0";
                            dayid = "0";
                            document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = "0";
                            document.getElementById("ctl00_ContentPlaceHolder1_ddlselectedteacher").value = "0";
                            return;
                        }
                        if (data.d == 2) {
                            alert(" " + teachername + " is already engaged.");
                            return;
                        }
                    },
                    error: function (result) {
                        alert("Some Internal Error");
                    }

                });
            }
        }

        function fillclassdropdown() {
            debugger;
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "teacher-view-timetable.aspx/BindClass",
                     data: "{}",
                     dataType: "json",
                     success: function (data) {
                         debugger;
                         $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.classid).html(value.classname));
                         });

                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });
            $("#ctl00_ContentPlaceHolder1_ddlsection").html("");
            $("#ctl00_ContentPlaceHolder1_ddlsection").append($("<option></option>").val("0").html("Select Section"));
            $("#ctl00_ContentPlaceHolder1_ddlsubject").html("");
            $("#ctl00_ContentPlaceHolder1_ddlsubject").append($("<option></option>").val("0").html("Select Subject"));
        }

        function fillsubjectdropdown() {
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-time-table.aspx/BindSubject",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlsubject").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlsubject").append($("<option></option>").val(value.subjectid).html(value.subjectname));
                         });

                         if (temp == "1") {
                             $('#ctl00_ContentPlaceHolder1_ddlsubject').val(subjectid);
                         }

                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });
            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").html("");
            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").append($("<option></option>").val("0").html("Select Teacher"));
        }

        function BindSection() {
            $('#ctl00_ContentPlaceHolder1_divsection').css("display", "block");
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-time-table.aspx/BindSection",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlsection").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlsection").append($("<option></option>").val(value.sectionid).html(value.sectionname));
                         });
                         if (temp == "1") {
                             $('#ctl00_ContentPlaceHolder1_ddlsection').val(sectionid);
                         }
                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });
        }

        function BindTeacherTimeTableGrid() {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/progressjqury.gif"  />');
            $("#divProgressBar").addClass("progressAdd");

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "teacher-view-timetable.aspx/BindTeacherTimeTable",
                data: "{'teacherid':'" + teacherid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_tablecreatetimetable").css("display", "block");
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
                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                    $('.maindivpopup').css("display", "none");
                },
                error: function (result) {
                    alert("Some Internal Error...Try Again.");
                }
            });

        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Time Table</a></li>

            <li style="background: none;"><a class="active" href="#">Teacher TimeTable</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>

    <div class="for_sigle_row_form boxti shadow1" style="background-color: #F1F1F1; margin-left: 227px; width: 563px; min-height: 50px; box-shadow: 0 0 5px rgba(152, 150, 150, 0.65); margin-top: 10px !important; margin-bottom: 7px !important">
        <div class="for_sigle_row_form" style="margin-left: -100px">
            <label>
                Select Teacher<span style="color: Red">*</span>
            </label>
            <asp:DropDownList ID="ddlteacher" runat="server">
            </asp:DropDownList>
        </div>
    </div>

    <div class="clear"></div>

    <div class="clear"></div>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" style="margin: 20px 0px 0px 0px !important" runat="server">
        <tr class="stm_head">
            <td rowspan="4" align="center" style="width: 67px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">S. No.
            </td>
            <td rowspan="4" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Day
            </td>
            <td colspan="2" align="center" style="width: 108px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">1st Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">2nd Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">3rd Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">4th Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">5th Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">6th Lecture
            </td>

            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">7th Lecture
            </td>
            <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">8th Lecture
            </td>
        </tr>

        <tr class="stm_head">

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
            </td>
        </tr>

        <tr class="stm_head">

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">9:35 AM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">10:30 AM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">10:30 AM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">11:30 AM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">11:30 AM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:30 PM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:30 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:55 PM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">1:25 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:00 PM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:00 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:15 PM
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:15 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:45 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:45 PM
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">3:00 PM
            </td>
        </tr>

        <tr class="stm_head">

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
        </tr>

        <tr>
            <td align="left" colspan="22" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                <asp:GridView ID="gridcreatetimetable" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                    runat="server" CssClass="stm0" GridLines="None" ShowHeader="false">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:Label ID="lblSNo" Text='<%# Bind("eid") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                </div>
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
                                <div>
                                    <asp:LinkButton ID="lblclassof1stlecture" runat="server" CssClass="FirstLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid1" runat="server" Text="2" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname1" runat="server" Text="1st Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday1" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid1" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof1stlecture" runat="server" CssClass="FirstLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid11" runat="server" Text="2" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname11" runat="server" Text="1st Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday11" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid11" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof2ndlecture" runat="server" CssClass="SecondLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid2" runat="server" Text="3" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname2" runat="server" Text="2nd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday2" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid2" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof2ndlecture" runat="server" CssClass="SecondLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid22" runat="server" Text="3" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname22" runat="server" Text="2nd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday22" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid22" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof3rdlecture" runat="server" CssClass="ThirdLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid3" runat="server" Text="4" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname3" runat="server" Text="3rd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday3" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid3" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof3rdlecture" runat="server" CssClass="ThirdLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid33" runat="server" Text="4" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname33" runat="server" Text="3rd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday33" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid33" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof4thlecture" runat="server" CssClass="FourthLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid4" runat="server" Text="5" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname4" runat="server" Text="4th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday4" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid4" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof4thlecture" runat="server" CssClass="FourthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid44" runat="server" Text="5" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname44" runat="server" Text="4th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday44" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid44" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof5thlecture" runat="server" CssClass="FifthLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid5" runat="server" Text="7" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname5" runat="server" Text="5th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday5" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid5" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof5thlecture" runat="server" CssClass="FifthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid55" runat="server" Text="7" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname55" runat="server" Text="5th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday55" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid55" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof6thlecture" runat="server" CssClass="SixthLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid6" runat="server" Text="8" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname6" runat="server" Text="6th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday6" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid6" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof6thlecture" runat="server" CssClass="SixthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid66" runat="server" Text="8" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname66" runat="server" Text="6th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday66" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid66" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof7thlecture" runat="server" CssClass="SeventhLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid7" runat="server" Text="9" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname7" runat="server" Text="7th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday7" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid7" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof7thlecture" runat="server" CssClass="SeventhLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid77" runat="server" Text="9" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname77" runat="server" Text="7th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday77" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid77" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof8thlecture" runat="server" CssClass="EightthLectureClass" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid8" runat="server" Text="10" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname8" runat="server" Text="8th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday8" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid8" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof8thlecture" runat="server" CssClass="EightthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid88" runat="server" Text="10" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname88" runat="server" Text="8th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday88" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid88" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
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

    <div id="maindivpopup" style="text-align: center; display: none;">
        <div style="width: 95%; margin: 10px;">
            <table class="maindivpopup" style="background-color: white; vertical-align: top">
                <tr>
                    <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td1"><a id="btclose">Close</a></td>
                </tr>

                <tr>
                    <td class="t1" id="tdforsubject"><span>Day:</span></td>
                    <td class="t2" id="tdforsubject1">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:Label ID="lblday" Text="Monday" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="t1" valign="top"><span>Period:</span></td>
                    <td class="t2">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:Label ID="lblperiod" Text="III" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="t1" valign="top"><span>Teacher:</span></td>
                    <td class="t2">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:Label ID="lblteachername" Text="III" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="t1" valign="top"><span>Class:</span></td>
                    <td class="t2">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:DropDownList ID="ddlclass" Style="height: 25px; width: 127px" runat="server">
                                <asp:ListItem Selected="True" Value="0">Select Class</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="t1" valign="top"><span>Section:</span></td>
                    <td class="t2">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:DropDownList ID="ddlsection" Style="height: 25px; width: 127px" runat="server">
                                <asp:ListItem Selected="True" Value="0">Select Section</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="t1" valign="top"><span>Subject:</span></td>
                    <td class="t2">
                        <div style="padding-left: 10px; height: 30px">
                            <asp:DropDownList ID="ddlsubject" Style="height: 25px; width: 127px" runat="server">
                                <asp:ListItem Selected="True">Select Subject</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="3" style="padding-top: 10px!important">
                        <asp:Button ID="btnsubmit" runat="server" CssClass="button_save" Style="height: 29px!important" Text="Submit" />
                        <asp:Button ID="btnclosepopup" runat="server" CssClass="button2" Text="Close" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <%--<div id="maindivpopup" runat="server" style="display: none" class="maindivpopup">
        <div id="popup" class="divclass">

            <div style="position: absolute; top: 50px; left: 49px">

                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Day:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:Label ID="lblday" Style="width: 155px!important; font-size: 15px; height: 27px!important" Text="" runat="server"></asp:Label>
                    </div>
                </div>
                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Period:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:Label ID="lblperiod" Style="width: 155px!important; font-size: 15px; height: 27px!important; float: right" Text="" runat="server"></asp:Label>
                    </div>
                </div>
                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Select Teacher:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:Label ID="lblteachername" Style="width: 155px!important; height: 27px!important; float: right" Text="" runat="server"></asp:Label>
                    </div>
                </div>

                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Select Class:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:DropDownList ID="ddlclass" Style="width: 155px!important; height: 23px!important; float: right; padding-top: 2px;" runat="server">
                            <asp:ListItem Selected="True" Value="0">Select Class</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Select Section:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:DropDownList ID="ddlsection" Style="width: 155px!important; height: 23px!important; float: right; padding-top: 2px;" runat="server">
                            <asp:ListItem Selected="True" Value="0">Select Section</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div style="width: 100%; margin-top: 13px; margin-left: 0px; height: 30px">
                    <label style="font-size: 11pt">
                        Select  Subject:  <span style="color: Red">*</span></label>
                    <div style="position: relative; float: right; width: 160px;">
                        <asp:DropDownList ID="ddlsubject" Style="width: 155px!important; height: 23px!important; float: right; padding-top: 2px;" runat="server">
                            <asp:ListItem Selected="True" Value="0">Select Subject</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <div style="width: 100%; margin-left: 0px; height: 42px; background-color: #808080; position: absolute; bottom: 0px;">
                <asp:Button ID="btnsubmit" runat="server" Style="position: absolute; bottom: -5px; right: 80px" CssClass="button2" Text="Submit" />
                <asp:Button ID="btnclosepopup" runat="server" Style="position: absolute; bottom: -5px; right: 0px" CssClass="button2" Text="Close" />
            </div>
        </div>
    </div>--%>

    <div id="divProgressBar" class="progress"></div>
</asp:Content>