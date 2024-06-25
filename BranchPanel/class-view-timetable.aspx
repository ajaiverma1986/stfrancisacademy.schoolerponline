<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="class-view-timetable.aspx.cs" Inherits="BranchPanel_class_view_timetable" %>

<%@ Register Src="~/BranchPanel/view-time-table.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <style type="text/css">
        a {
            text-decoration: none !important;
        }

        table td {
            color: black!important;
        }

        .clasfortd1 {
            color: #bd0606;
            font-size: 11px;
            font-weight: normal;
            height: 20px;
            line-height: 20px;
            background: #F5F5F5;
            border-bottom: 1px solid #ddd;
            border-right: 1px solid #ddd;
            font-weight: bold;
        }

        .classfortd2 {
            color: blue;
            font-size: 11px;
            font-weight: bold;
            height: 20px;
            line-height: 20px;
            background: #F5F5F5;
            border-bottom: 1px solid #ddd;
            border-right: 1px solid #ddd;
        }

        .classfortd3 {
            width: 67px;
            font-size: 11px;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }

        .activeclasstimetable {
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

        var classid = "0", sectionid = "0", subjectid = "0", teacherid = "0", dayid = "", lectureid = "", classname = "", sectionname = "", mode = "0", temp = "0";
        $(document).ready(function () {
            document.title = "View Class Time Table"
            $('#ctl00_ContentPlaceHolder1_gridcreatetimetable a').click(function () {
                mode = "2";
                temp = "1"
                $('#ctl00_ContentPlaceHolder1_lbltext').html('Update Time Table');
                $('#maindivpopup').css("display", "block");
                $('.maindivpopup').fadeIn(1000);
                classname = $("#ctl00_ContentPlaceHolder1_ddlClass option:selected").text();
                sectionname = $("#ctl00_ContentPlaceHolder1_ddlSection option:selected").text();
                dayid = $(this).parent('div').find('.Dayid').text();
                lectureid = $(this).parent('div').find('.lectureid').text();
                var lecturename = $(this).parent('div').find('.lecturename').text();
                var day = $(this).parent('div').find('.DayForCheck').html();
                $('#ctl00_ContentPlaceHolder1_lblclass').html(classname);
                $('#ctl00_ContentPlaceHolder1_lblsection').html(sectionname);
                $('#ctl00_ContentPlaceHolder1_lblday').html(day);
                $('#ctl00_ContentPlaceHolder1_lblperiod').html(lecturename);
                fillsubjectdropdown();

                if ($(this).text().trim() == "Set Subject" || $(this).text().trim() == "Set Teacher") {
                    $('#ctl00_ContentPlaceHolder1_lbltext').html('Create Time Table');
                    mode = "1";
                    temp = "0"
                }
                else {
                    BindSelectedSubjectAndTeacher();
                }
                return false;
            });
            $("#btclose").click(function () {
                subjectid = "0";
                teacherid = "0";
                $("#maindivpopup").fadeOut(500);
                $('.maindivpopup').fadeOut(500);
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_btnclosepopup").click(function () {
                subjectid = "0";
                teacherid = "0";
                $("#maindivpopup").fadeOut(500);
                $('.maindivpopup').fadeOut(500);
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlSection").change(function () {
                sectionid = document.getElementById("ctl00_ContentPlaceHolder1_ddlSection").value;
                if (sectionid != "0") {
                    BindClasstimetablegrid();
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_tablecreatetimetable").css("display", "none");
                }

            });

            $("#ctl00_ContentPlaceHolder1_ddlClass").change(function () {
                classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                if (classid != "0") {
                    BindSection();
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_tablecreatetimetable").css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_divsection').css("display", "none");
                }

            });

            $("#ctl00_ContentPlaceHolder1_ddlsubject").change(function () {
                subjectid = document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value;
                fillteacherdropdown();

            });

            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").change(function () {
                teacherid = document.getElementById("ctl00_ContentPlaceHolder1_ddlselectedteacher").value;
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
                url: "create-time-table.aspx/Bindselectedsubjectteacher",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','lectureid':'" + lectureid + "','Dayid':'" + dayid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_ddlsubject").val(data.d[0].subjectid);
                        subjectid = data.d[0].subjectid;
                        teacherid = data.d[0].teacherid;
                        fillteacherdropdown();
                    }
                },
                error: function (result) {
                    alert("Some Internal Error");
                }
            });
        }

        function inserttimetable() {
            if (subjectid == "0") {
                alert("Please Select Subject Name.");
                return false;
            }
            else if (teacherid == "0") {
                alert("Please Select Teacher Name.");
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
                            alert("Time table of " + $("#ctl00_ContentPlaceHolder1_ddlselectedteacher option:selected").text() + " has been created successfully");
                            BindClasstimetablegrid();
                            $("#popup").css("display", "none");
                            $('.maindivpopup').css("display", "none");
                            subjectid = "0";
                            teacherid = "0";
                            document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = "0";
                            document.getElementById("ctl00_ContentPlaceHolder1_ddlselectedteacher").value = "0";
                            return;
                        }
                        if (data.d == 2) {
                            alert(" " + $("#ctl00_ContentPlaceHolder1_ddlselectedteacher option:selected").text() + " is already engaged.");
                            return;
                        }
                    },
                    error: function (result) {
                        alert("Some Internal Error");
                    }

                });
            }
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

                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });
            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").html("");
            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").append($("<option></option>").val("0").html("Select Teacher"));
        }
        function fillteacherdropdown() {

            $.ajax(
                 {

                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-time-table.aspx/BindTeacher",
                     data: "{'subjectid':'" + subjectid + "','classid':'" + classid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").append($("<option></option>").val(value.eid).html(value.fName));
                         });
                         if (temp == "1") {
                             $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").val(teacherid);
                         }
                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });

        }

        function BindSection() {
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "create-time-table.aspx/BindSection",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.sectionid).html(value.sectionname));
                         });
                         $('#ctl00_ContentPlaceHolder1_divsection').css("display", "block");
                     },
                     error: function (result) {
                         alert("Some Internal Error");
                     }
                 });
        }

        function BindClasstimetablegrid() {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/progressjqury.gif"  />');
            $("#divProgressBar").addClass("progressAdd");

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "class-view-timetable.aspx/BindClassGrid",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "'}",
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
                            $(row).find('.DayForCheck').html(data.d[i].Day);
                            $(row).find('.RowNumber2').html(data.d[i].RowNumber);
                            $(row).find('.Dayid').html(data.d[i].RowNumber);
                            $(row).find('.day').html(data.d[i].Day);
                            $(row).find('.FirstLectureSubject').html(data.d[i].FirstLectureSubject);
                            $(row).find('.FirstLectureTeacher').html(data.d[i].FirstLectureTeacher);
                            $(row).find('.SecondLectureSubject').html(data.d[i].SecondLectureSubject);
                            $(row).find('.SecondLectureTeacher').html(data.d[i].SecondLectureTeacher);
                            $(row).find('.ThirdLectureSubject').html(data.d[i].ThirdLectureSubject);
                            $(row).find('.ThirdLectureTeacher').html(data.d[i].ThirdLectureTeacher);
                            $(row).find('.FourthLectureSubject').html(data.d[i].FourthLectureSubject);
                            $(row).find('.FourthLectureTeacher').html(data.d[i].FourthLectureTeacher);
                            $(row).find('.FifthLectureSubject').html(data.d[i].FifthLectureSubject);
                            $(row).find('.FifthLectureTeacher').html(data.d[i].FifthLectureTeacher);
                            $(row).find('.SixthLectureSubject').html(data.d[i].SixthLectureSubject);
                            $(row).find('.SixthLectureTeacher').html(data.d[i].SixthLectureTeacher);
                            $(row).find('.SeventhLectureSubject').html(data.d[i].SeventhLectureSubject);
                            $(row).find('.SeventhLectureTeacher').html(data.d[i].SeventhLectureTeacher);
                            $(row).find('.EightthLectureSubject').html(data.d[i].EightthLectureSubject);
                            $(row).find('.EightthLectureTeacher').html(data.d[i].EightthLectureTeacher);
                        }

                        $("[id*=gridcreatetimetable] tr").show();
                        $("[id*=gridcreatetimetable] tr:first-child").show();
                    }

                    else {

                    }
                    $("[id*=gridcreatetimetable] tr").show();
                    $("[id*=gridcreatetimetable] tr:first-child").show();

                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                    $('.maindivpopup').css("display", "none");
                },
                error: function (result) {
                    alert("Some Internal Error");
                }

            });
        }
    </script>
   
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    <div class="for_sigle_row_form">
        <div class="for_sigle_row_form">
            <label>
                Select Class<span style="color: Red">*</span>
            </label>
            <asp:DropDownList ID="ddlClass" runat="server">
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form" id="divsection" runat="server" style="display: none; ">
            <label>
                Select Section<span style="color: Red">*</span></label>
            <asp:DropDownList ID="ddlSection" runat="server">
            </asp:DropDownList>
        </div>
    </div>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" style="display: none; margin: 20px 0px 0px 0px !important" runat="server">
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

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>

            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
            </td>
            <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Teacher
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
                                    <asp:Label ID="lblSNo" Text='<%# Bind("eid") %>' runat="server" CssClass="RowNumber2"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="110px" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="lblday" runat="server" CssClass="day"></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle Width="100px" HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof1stlecture" runat="server" CssClass="FirstLectureSubject" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblsubjectof1stlecture" runat="server" CssClass="FirstLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblclassof2ndlecture" runat="server" CssClass="SecondLectureSubject" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblsubjectof2ndlecture" runat="server" CssClass="SecondLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid22" runat="server" Text="3" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname22" runat="server" Text="2nd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday22" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid22" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="3rd Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof3rdlecture" runat="server" CssClass="ThirdLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid3" runat="server" Text="4" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname3" runat="server" Text="3rd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday3" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid3" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="3rd Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof3rdlecture" runat="server" CssClass="ThirdLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid33" runat="server" Text="4" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname33" runat="server" Text="3rd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday33" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid33" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="4th Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof4thlecture" runat="server" CssClass="FourthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid4" runat="server" Text="5" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname4" runat="server" Text="4th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday4" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid4" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="4th Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof4thlecture" runat="server" CssClass="FourthLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid44" runat="server" Text="5" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname44" runat="server" Text="4th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday44" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid44" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="5th Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblclassof5thlecture" runat="server" CssClass="FifthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
                                    <asp:Label ID="lbllectureid5" runat="server" Text="7" CssClass="lectureid" Style="display: none"></asp:Label>
                                    <asp:Label ID="lbllecturname5" runat="server" Text="5th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                    <asp:Label ID="lblday5" runat="server" Style="display: none" CssClass="DayForCheck"></asp:Label>
                                    <asp:Label ID="lbldayid5" runat="server" Style="display: none" CssClass="Dayid"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="5th Lecture">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lblsubjectof5thlecture" runat="server" CssClass="FifthLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblclassof6thlecture" runat="server" CssClass="SixthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblsubjectof6thlecture" runat="server" CssClass="SixthLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblclassof7thlecture" runat="server" CssClass="SeventhLectureSubject" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblsubjectof7thlecture" runat="server" CssClass="SeventhLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblclassof8thlecture" runat="server" CssClass="EightthLectureSubject" Style="text-decoration: none"></asp:LinkButton>
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
                                    <asp:LinkButton ID="lblsubjectof8thlecture" runat="server" CssClass="EightthLectureTeacher" Style="text-decoration: none"></asp:LinkButton>
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
        <tr>
            <td>
                <div id="maindivpopup" style="text-align: center; display: none;">
                    <div style="width: 95%; margin: 10px;">
                        <table class="maindivpopup" style="background-color: white; vertical-align: top">
                            <tr>
                                <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td1"><a id="btclose">Close</a></td>
                            </tr>
                            <tr>
                                <td class="t1"><span>Class:</span></td>
                                <td class="t2">
                                    <div style="padding-left: 10px; height: 30px">
                                        <asp:Label ID="lblclass" runat="server" Text="Class II"></asp:Label>
                                    </div>
                                </td>
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
                                <td class="t1" valign="top"><span>Select Subject:</span></td>
                                <td class="t2">
                                    <div style="padding-left: 10px; height: 30px">
                                        <asp:DropDownList ID="ddlsubject" Style="height: 25px; width: 127px" runat="server">
                                            <asp:ListItem Selected="True" Value="0">Select Subject</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1" valign="top"><span>Select Teacher:</span></td>
                                <td class="t2">
                                    <div style="padding-left: 10px; height: 30px">
                                        <asp:DropDownList ID="ddlselectedteacher" Style="height: 25px; width: 127px" runat="server">
                                            <asp:ListItem Selected="True">Select Teacher</asp:ListItem>
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
            </td>
        </tr>
    </table>
    <div id="divProgressBar" class="progress"></div>
        </div>
</asp:Content>