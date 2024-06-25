<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="default-view-timetable.aspx.cs" Inherits="BranchPanel_default_view_timetable" %>

<%@ Register Src="~/BranchPanel/view-time-table.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
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

        #loader {
            position: relative;
            top: 10%;
        }

        table td {
            text-align: center;
            color: black;
        }

        #ctl00_ContentPlaceHolder1_gridtimetabledetails_ctl09_lblrownumber {
            padding: 10.2px;
        }

        #ctl00_ContentPlaceHolder1_gridtimetabledetails_ctl09_lbllecture {
            padding: 11.5px;
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

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 14px !important;
            padding-left: 10px;
            text-align: left !important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }
    </style>

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <script type="text/javascript">

        var dayid = "0", classid = "0", sectionid = "0", subjectid = "0", mode = "1", lectureid = "0", teacherid = "0", attendstatus = "0", updatemode = "0", temp = "0", daystatus = "1";

        $(document).ready(function () {
            document.title = "View Time Table"
            $('#ctl00_ContentPlaceHolder1_gridtimetabledetails a').click(function () {
                $('#maindivpopup').css("display", "block");
                $('.maindivpopup').fadeIn(500);

                dayid = document.getElementById("ctl00_ContentPlaceHolder1_ddlday").value;
                $("#ctl00_ContentPlaceHolder1_lblday").text($("#ctl00_ContentPlaceHolder1_ddlday option:selected").text());

                $('#ctl00_ContentPlaceHolder1_lblclass').html($(this).parent('div').find('.classname').text());
                classid = $(this).parent('div').find('.classid').text();

                $('#ctl00_ContentPlaceHolder1_lblsection').html($(this).parent('div').find('.sectionname').text());
                sectionid = $(this).parent('div').find('.sectionid').text();

                $('#ctl00_ContentPlaceHolder1_lblperiod').html($(this).parent('div').find('.lecname').text());

                lectureid = $(this).parent('div').find('.lecid').text();

                fillsubjectdropdown();

                if ($(this).text().trim() == "Set Subject" || $(this).text().trim() == "Set Teacher") {
                    $('#ctl00_ContentPlaceHolder1_lbltext').html('Create Time Table');
                    mode = "1";
                    temp = "0"
                }
                else {
                    temp = "1"
                    mode = "2"
                    $('#ctl00_ContentPlaceHolder1_lbltext').html('Update Time Table');
                    BindSelectedSubjectAndTeacher();
                }

                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlsubject").change(function () {
                subjectid = document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value;
                fillteacherdropdown();

            });

            $("#ctl00_ContentPlaceHolder1_btnclosepopup").click(function () {
                $("#maindivpopup").fadeOut(500);
                $('.maindivpopup').fadeOut(500);
                classid = "0", sectionid = "0", subjectid = "0", mode = "0", lectureid = "0", teacherid = "0", attendstatus = "0", updatemode = "0", temp = "0";
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlday").change(function () {
                dayid = document.getElementById("ctl00_ContentPlaceHolder1_ddlday").value;
                if (dayid != "0") {
                    BindDefaultTimeTableGrid();
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_setscrollingridview").css("display", "none");
                }
                var d = new Date();
                var n = d.getDay()
                if (n == dayid) {
                    daystatus = "1";
                }
                else {
                    daystatus = "0";
                }

            });
            $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").change(function () {
                teacherid = document.getElementById("ctl00_ContentPlaceHolder1_ddlselectedteacher").value;
            });
            $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {

                inserttimetable();
                return false;
            });
        });

        function BindDefaultTimeTableGrid() {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/progressjqury.gif"  />');
            $("#divProgressBar").addClass("progressAdd");

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "default-view-timetable.aspx/BindDefaultGrid",
                data: "{'dayid':'" + dayid + "'}",
                dataType: "json",
                success: function (data) {

                    $("#ctl00_ContentPlaceHolder1_setscrollingridview").css("display", "block");
                    if (data.d.length > 0) {

                        var row = $("[id*=gridtimetabledetails] tr:last-child").clone(true);
                        $("[id*=gridtimetabledetails] tr").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=gridtimetabledetails] tr:last-child").clone(true);
                            }
                            $("[id$=gridtimetabledetails]").append(row);
                            $(row).find('.Rownumber').html(data.d[i].Rownumber);
                            $(row).find('.LectureName').html(data.d[i].LectureName);

                            $(row).find('.lecid').html(data.d[i].Lectureid);
                            $(row).find('.lecname').html(data.d[i].LectureName);

                            $(row).find('.Fromtime').html(data.d[i].Fromtime);
                            $(row).find('.Totime').html(data.d[i].Totime);

                            $(row).find('.Lkgsubjectseca').html(data.d[i].Lkgsubjectseca);
                            $(row).find('.Lkgteacherseca').html(data.d[i].Lkgteacherseca);
                            $(row).find('.Lkgsubjectsecb').html(data.d[i].Lkgsubjectsecb);
                            $(row).find('.Lkgteachersecb').html(data.d[i].Lkgteachersecb);
                            $(row).find('.Lkgsubjectsecc').html(data.d[i].Lkgsubjectsecc);
                            $(row).find('.Lkgteachersecc').html(data.d[i].Lkgteachersecc);

                            $(row).find('.Ukgsubjectseca').html(data.d[i].Ukgsubjectseca);
                            $(row).find('.Ukgteacherseca').html(data.d[i].Ukgteacherseca);
                            $(row).find('.Ukgsubjectsecb').html(data.d[i].Ukgsubjectsecb);
                            $(row).find('.Ukgteachersecb').html(data.d[i].Ukgteachersecb);
                            $(row).find('.Ukgsubjectsecc').html(data.d[i].Ukgsubjectsecc);
                            $(row).find('.Ukgteachersecc').html(data.d[i].Ukgteachersecc);

                            $(row).find('.firstsubjectseca').html(data.d[i].firstsubjectseca);
                            $(row).find('.firstteacherseca').html(data.d[i].firstteacherseca);
                            $(row).find('.firstsubjectsecb').html(data.d[i].firstsubjectsecb);
                            $(row).find('.firstteachersecb').html(data.d[i].firstteachersecb);
                            $(row).find('.firstsubjectsecc').html(data.d[i].firstsubjectsecc);
                            $(row).find('.firstteachersecc').html(data.d[i].firstteachersecc);

                            $(row).find('.secondsubjectseca').html(data.d[i].secondsubjectseca);
                            $(row).find('.secondteacherseca').html(data.d[i].secondteacherseca);
                            $(row).find('.secondsubjectsecb').html(data.d[i].secondsubjectsecb);
                            $(row).find('.secondteachersecb').html(data.d[i].secondteachersecb);
                            $(row).find('.secondsubjectsecc').html(data.d[i].secondsubjectsecc);
                            $(row).find('.secondteachersecc').html(data.d[i].secondteachersecc);

                            $(row).find('.thirdsubjectseca').html(data.d[i].thirdsubjectseca);
                            $(row).find('.thirdteacherseca').html(data.d[i].thirdteacherseca);
                            $(row).find('.thirdsubjectsecb').html(data.d[i].thirdsubjectsecb);
                            $(row).find('.thirdteachersecb').html(data.d[i].thirdteachersecb);
                            $(row).find('.thirdsubjectsecc').html(data.d[i].thirdsubjectsecc);
                            $(row).find('.thirdteachersecc').html(data.d[i].thirdteachersecc);

                            $(row).find('.forthsubjectseca').html(data.d[i].forthsubjectseca);
                            $(row).find('.forthteacherseca').html(data.d[i].forthteacherseca);
                            $(row).find('.forthsubjectsecb').html(data.d[i].forthsubjectsecb);
                            $(row).find('.forthteachersecb').html(data.d[i].forthteachersecb);
                            $(row).find('.forthsubjectsecc').html(data.d[i].forthsubjectsecc);
                            $(row).find('.forthteachersecc').html(data.d[i].forthteachersecc);

                            $(row).find('.fifthsubjectseca').html(data.d[i].fifthsubjectseca);
                            $(row).find('.fifthteacherseca').html(data.d[i].fifthteacherseca);
                            $(row).find('.fifthsubjectsecb').html(data.d[i].fifthsubjectsecb);
                            $(row).find('.fifthteachersecb').html(data.d[i].fifthteachersecb);
                            $(row).find('.fifthsubjectsecc').html(data.d[i].fifthsubjectsecc);
                            $(row).find('.fifthteachersecc').html(data.d[i].fifthteachersecc);

                            $(row).find('.sixsubjectseca').html(data.d[i].sixsubjectseca);
                            $(row).find('.sixteacherseca').html(data.d[i].sixteacherseca);
                            $(row).find('.sixsubjectsecb').html(data.d[i].sixsubjectsecb);
                            $(row).find('.sixteachersecb').html(data.d[i].sixteachersecb);
                            $(row).find('.sixsubjectsecc').html(data.d[i].sixsubjectsecc);
                            $(row).find('.sixteachersecc').html(data.d[i].sixteachersecc);

                            $(row).find('.sevensubjectseca').html(data.d[i].sevensubjectseca);
                            $(row).find('.seventeacherseca').html(data.d[i].seventeacherseca);
                            $(row).find('.sevensubjectsecb').html(data.d[i].sevensubjectsecb);
                            $(row).find('.seventeachersecb').html(data.d[i].seventeachersecb);
                            $(row).find('.sevensubjectsecc').html(data.d[i].sevensubjectsecc);
                            $(row).find('.seventeachersecc').html(data.d[i].seventeachersecc);

                            $(row).find('.eightsubjectseca').html(data.d[i].eightsubjectseca);
                            $(row).find('.eightteacherseca').html(data.d[i].eightteacherseca);
                            $(row).find('.eightsubjectsecb').html(data.d[i].eightsubjectsecb);
                            $(row).find('.eightteachersecb').html(data.d[i].eightteachersecb);
                            $(row).find('.eightsubjectsecc').html(data.d[i].eightsubjectsecc);
                            $(row).find('.eightteachersecc').html(data.d[i].eightteachersecc);

                            $(row).find('.ninesubjectseca').html(data.d[i].ninesubjectseca);
                            $(row).find('.nineteacherseca').html(data.d[i].nineteacherseca);
                            $(row).find('.ninesubjectsecb').html(data.d[i].ninesubjectsecb);
                            $(row).find('.nineteachersecb').html(data.d[i].nineteachersecb);
                            $(row).find('.ninesubjectsecc').html(data.d[i].ninesubjectsecc);
                            $(row).find('.nineteachersecc').html(data.d[i].nineteachersecc);

                            $(row).find('.tensubjectseca').html(data.d[i].tensubjectseca);
                            $(row).find('.tenteacherseca').html(data.d[i].tenteacherseca);
                            $(row).find('.tensubjectsecb').html(data.d[i].tensubjectsecb);
                            $(row).find('.tenteachersecb').html(data.d[i].tenteachersecb);
                            $(row).find('.tensubjectsecc').html(data.d[i].tensubjectsecc);
                            $(row).find('.tenteachersecc').html(data.d[i].tenteachersecc);
                        }

                        $("[id*=gridtimetabledetails] tr").show();
                        $("[id*=gridtimetabledetails] tr:first-child").show();

                    }
                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                },
                error: function (result) {
                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                }

            });
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
                             $("#ctl00_ContentPlaceHolder1_ddlsubject").val(subjectid);
                             $("#ctl00_ContentPlaceHolder1_ddlselectedteacher").val(teacherid);

                         }
                     },
                     error: function (result) {

                     }
                 });

        }
        function BindSelectedSubjectAndTeacher() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "default-view-timetable.aspx/Bindselectedsubjectteacher",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','lectureid':'" + lectureid + "','Dayid':'" + dayid + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {

                        attendstatus = data.d[0].attendstatus;

                        if (daystatus == "1") {
                            if (attendstatus == 0) {
                                var r = confirm("Do You Want To Change  The Faculty Permanently.?");
                                if (r == true) {
                                    updatemode = 0;
                                }
                                else {
                                    updatemode = 1;
                                }

                            }
                        }
                        subjectid = data.d[0].subjectid;
                        teacherid = data.d[0].teacherid;
                        document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = data.d[0].subjectid;
                        fillteacherdropdown();

                    }
                },
                error: function (result) {

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
                    url: "default-view-timetable.aspx/InsertTimeTable",
                    data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','subjectid':'" + subjectid + "','teacherid':'" + teacherid + "','dayid':'" + dayid + "','lectureid':'" + lectureid + "','mode':'" + mode + "','updatemode':'" + updatemode + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alert("Time table of " + $("#ctl00_ContentPlaceHolder1_ddlselectedteacher option:selected").text() + " has been created successfully");
                            $("#popup").css("display", "none");
                            $('.maindivpopup').css("display", "none");
                            BindDefaultTimeTableGrid();
                            classid = "0", sectionid = "0", subjectid = "0", mode = "0", lectureid = "0", teacherid = "0", attendstatus = "0", updatemode = "0", temp = "0";
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

                    }

                });
            }
        }
    </script>

    <style type="text/css">
        .activedefaulttimetable {
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

        .setscrollingridviewclass {
            /*background-color: Gray;*/
            overflow-y: scroll;
            min-width: 1000px !important;
            min-width: 1000px !important;
            min-height: 200px !important;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Time Table</a></li>
            <li style="background: none;"><a class="active" href="#">Default TimeTable</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div class="for_sigle_row_form boxti shadow1" style="background-color: #F1F1F1; margin-left: 227px; width: 563px; min-height: 50px; box-shadow: 0 0 5px rgba(152, 150, 150, 0.65); margin-top: 10px !important; margin-bottom: 7px !important">
            <div class="for_sigle_row_form" style="margin-left: -100px">
                <label>
                    Select Day<span style="color: Red">*</span>
                </label>
                <asp:DropDownList ID="ddlday" runat="server">
                </asp:DropDownList>
            </div>
        </div>
        <div class="clear"></div>
        <div id="setscrollingridview" runat="server" class="setscrollingridviewclass" style="display: block; margin-top: 38px; margin-right: 8px; background: none repeat scroll 0 0 #DDDDDD; border: 1px solid #DDDDDD; border-radius: 4px; margin-left: 8px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" style="display: block; border: 1px solid #ddd; margin: 4px 4px !important" runat="server">
                <tr class="stm_head">
                    <td rowspan="3" align="center" style="width: 100px; font-size: 11px; border-right: 1px solid #ddd; padding-left: 1px; border-bottom: 1px solid #ddd; color: black">S.No.
                    </td>
                    <td rowspan="3" align="center" style="width: 100px; padding-left: 2px; font-size: 11px; border-right: 1px solid #ddd; padding-left: 1px; border-bottom: 1px solid #ddd;">Lecture
                    </td>

                    <td rowspan="2" colspan="2" align="center" style="width: 100px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Time
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">L.K.G
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">U.K.G
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Ist
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">IInd
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">IIIrd
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">IVth
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Vth
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">VIth
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">VIIth
                    </td>
                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">VIIIth
                    </td>

                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">IXth
                    </td>
                    <td colspan="6" align="center" style="width: 210px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Xth
                    </td>
                </tr>

                <tr class="stm_head">
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section A
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section B
                    </td>
                    <td width="100px" colspan="2" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Section C
                    </td>
                </tr>

                <tr class="stm_head">

                    <td width="100px" align="center" style="font-size: 11px; padding: 4px 6px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">From
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">To
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Subject
                    </td>
                    <td width="100px" align="center" style="font-size: 11px; padding: 4px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; color: black">Teacher
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="100" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView ID="gridtimetabledetails" AutoGenerateColumns="false" ShowHeader="false" EmptyDataText="No Exam Sechudle Generated"
                            Width="100%" CssClass="stm" GridLines="None" runat="server">
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrownumber" runat="server" Text='<%# Bind("Rownumber") %>' CssClass="Rownumber"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbllecture" runat="server" Text='<%# Bind("LectureName") %>' CssClass="LectureName">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfromtime" runat="server" Text='<%# Bind("Fromtime") %>' CssClass="Fromtime">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltotime" runat="server" Text='<%# Bind("Totime") %>' CssClass="Totime">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforlkgseca" runat="server" Text='<%# Bind("Lkgsubjectseca") %>' CssClass="Lkgsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgsecaclassid" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecaclassname" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecasecid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecasecname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforlkgseca" runat="server" Text='<%# Bind("Lkgteacherseca") %>' CssClass="Lkgteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgsecaclassid2" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecaclassname2" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecasecid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecasecname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforlkgsecb" runat="server" Text='<%# Bind("Lkgsubjectsecb") %>' CssClass="Lkgsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgsecbclassid" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbclassname" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbsectioname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforlkgsecb" runat="server" Text='<%# Bind("Lkgteachersecb") %>' CssClass="Lkgteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgsecbclassid2" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbclassname2" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecbsectioname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforlkgsecc" runat="server" Text='<%# Bind("Lkgsubjectsecc") %>' CssClass="Lkgsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgseccclassid" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccclassname" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforlkgsecc" runat="server" Text='<%# Bind("Lkgteachersecc") %>' CssClass="Lkgteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllkgsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbllkgseccclassid2" runat="server" Text="1" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccclassname2" runat="server" Text="L.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllkgseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforukgseca" runat="server" Text='<%# Bind("Ukgsubjectseca") %>' CssClass="Ukgsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgsecaclassid" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecaclassname" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforukgseca" runat="server" Text='<%# Bind("Ukgteacherseca") %>' CssClass="Ukgteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgsecaclassid2" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecaclassname2" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforukgsecb" runat="server" Text='<%# Bind("Ukgsubjectsecb") %>' CssClass="Ukgsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgsecbclassid" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbclassname" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforukgsecb" runat="server" Text='<%# Bind("Ukgteachersecb") %>' CssClass="Ukgteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgsecbclassid2" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbclassname2" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectforukgsecc" runat="server" Text='<%# Bind("Ukgsubjectsecc") %>' CssClass="Ukgsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgseccclassid" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccclassname" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherforukgsecc" runat="server" Text='<%# Bind("Ukgteachersecc") %>' CssClass="Ukgteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblukgsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblukgseccclassid2" runat="server" Text="2" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccclassname" runat="server" Text="U.K.G" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblukgseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor1stseca" runat="server" Text='<%# Bind("firstsubjectseca") %>' CssClass="firstsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstsecaclassid" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecaclassname" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor1stseca" runat="server" Text='<%# Bind("firstteacherseca") %>' CssClass="firstteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstsecaclassid2" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecaclassname2" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor1stsecb" runat="server" Text='<%# Bind("firstsubjectsecb") %>' CssClass="firstsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstsecbclassid" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbclassname" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor1stsecb" runat="server" Text='<%# Bind("firstteachersecb") %>' CssClass="firstteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstsecbclassid2" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbclassname2" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor1stsecc" runat="server" Text='<%# Bind("firstsubjectsecc") %>' CssClass="firstsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstseccclassid" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccclassname" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor1stsecc" runat="server" Text='<%# Bind("firstteachersecc") %>' CssClass="firstteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfirstsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfirstseccclassid2" runat="server" Text="3" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccclassname2" runat="server" Text="Ist" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfirstseccsectionname2" runat="server" Text="C " CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor2ndseca" runat="server" Text='<%# Bind("secondsubjectaseca") %>' CssClass="secondsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondsecaclassid" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecaclassname" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor2ndseca" runat="server" Text='<%# Bind("secondteacheraseca") %>' CssClass="secondteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondsecaclassid2" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecaclassname2" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor2ndsecb" runat="server" Text='<%# Bind("secondsubjectsecb") %>' CssClass="secondsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondsecbclassid" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbclassname" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor2ndsecb" runat="server" Text='<%# Bind("secondteachersecb") %>' CssClass="secondteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondsecbclassid2" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbclassname2" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor2ndsecc" runat="server" Text='<%# Bind("secondsubjectsecc") %>' CssClass="secondsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondseccclassid" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccclassname" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor2ndsecc" runat="server" Text='<%# Bind("secondteachersecc") %>' CssClass="secondteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsecondsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsecondseccclassid2" runat="server" Text="4" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccclassname2" runat="server" Text="IInd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsecondseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor3rdseca" runat="server" Text='<%# Bind("thirdsubjectseca") %>' CssClass="thirdsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdsecaclassid" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecaclassname" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor3rdseca" runat="server" Text='<%# Bind("thirdteacherseca") %>' CssClass="thirdteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdsecaclassid2" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecaclassname2" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor3rdsecb" runat="server" Text='<%# Bind("thirdsubjectsecb") %>' CssClass="thirdsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdsecbclassid" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbclassname" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor3rdsecb" runat="server" Text='<%# Bind("thirdteachersecb") %>' CssClass="thirdteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdsecbclassid2" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbclassname2" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor3rdsecc" runat="server" Text='<%# Bind("thirdsubjectsecc") %>' CssClass="thirdsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdseccclassid" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccclassname" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor3rdsecc" runat="server" Text='<%# Bind("thirdteachersecc") %>' CssClass="thirdteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblthirdsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblthirdseccclassid2" runat="server" Text="5" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccclassname2" runat="server" Text="IIIrd" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblthirdseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor4thseca" runat="server" Text='<%# Bind("forthsubjectseca") %>' CssClass="forthsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthsecaclassid" runat="server" Text="6" CssClass="classid" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthsecaclassname" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor4thseca" runat="server" Text='<%# Bind("forthteacherseca") %>' CssClass="forthteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthsecaclassid2" runat="server" Text="6" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecaclassname2" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor4thsecb" runat="server" Text='<%# Bind("forthsubjectsecb") %>' CssClass="forthsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthsecbclassid" runat="server" Text="6" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbclassname" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor4thsecb" runat="server" Text='<%# Bind("forthteachersecb") %>' CssClass="forthteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthsecbclassid2" runat="server" Text="6" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbclassname2" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor4thsecc" runat="server" Text='<%# Bind("forthsubjectsecc") %>' CssClass="forthsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthseccclassid" runat="server" Text="6" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccclassname" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor4thsecc" runat="server" Text='<%# Bind("forthteachersecc") %>' CssClass="forthteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblforthsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblforthseccclassid2" runat="server" Text="6" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccclassname2" runat="server" Text="IVth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblforthseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsujectfor5thseca" runat="server" Text='<%# Bind("fifthsubjectseca") %>' CssClass="fifthsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthsecaclassid" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecaclassname" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor5thseca" runat="server" Text='<%# Bind("fifthteacherseca") %>' CssClass="fifthteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthsecaclassid2" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecaclassname2" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsujectfor5thsecb" runat="server" Text='<%# Bind("fifthsubjectsecb") %>' CssClass="fifthsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthsecbclassid" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbclassname" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor5thsecb" runat="server" Text='<%# Bind("fifthteachersecb") %>' CssClass="fifthteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthsecbclassid2" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbclassname2" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsujectfor5thsecc" runat="server" Text='<%# Bind("fifthsubjectsecc") %>' CssClass="fifthsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthseccclassid" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccclassname" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor5thsecc" runat="server" Text='<%# Bind("fifthteachersecc") %>' CssClass="fifthteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblfifthsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblfifthseccclassid2" runat="server" Text="7" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccclassname2" runat="server" Text="Vth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblfifthseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor6thseca" runat="server" Text='<%# Bind("sixsubjectseca") %>' CssClass="sixsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthsecaclassid" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecaclassname" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor6thseca" runat="server" Text='<%# Bind("sixteacherseca") %>' CssClass="sixteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthsecaclassid2" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecaclassname2" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor6thsecb" runat="server" Text='<%# Bind("sixsubjectsecb") %>' CssClass="sixsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthsecbclassid" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbclassname" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor6thsecb" runat="server" Text='<%# Bind("sixteachersecb") %>' CssClass="sixteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthsecbclassid2" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbclassname2" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor6thsecc" runat="server" Text='<%# Bind("sixsubjectsecc") %>' CssClass="sixsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthseccclassid" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccclassname" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor6thsecc" runat="server" Text='<%# Bind("sixteachersecc") %>' CssClass="sixteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblsixthsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblsixthseccclassid2" runat="server" Text="8" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccclassname2" runat="server" Text="VIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblsixthseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor7thseca" runat="server" Text='<%# Bind("sevensubjectseca") %>' CssClass="sevensubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhsecaclassid" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecaclassname" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor7thseca" runat="server" Text='<%# Bind("seventeacherseca") %>' CssClass="seventeacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhsecaclassid2" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecaclassname2" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor7thseb" runat="server" Text='<%# Bind("sevensubjectsecb") %>' CssClass="sevensubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhsecbclassid" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbclassname" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor7thsecb" runat="server" Text='<%# Bind("seventeachersecb") %>' CssClass="seventeachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhsecbclassid2" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbclassname2" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor7thsecc" runat="server" Text='<%# Bind("sevensubjectsecc") %>' CssClass="sevensubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhseccclassid" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccclassname" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor7thsecc" runat="server" Text='<%# Bind("seventeachersecc") %>' CssClass="seventeachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblseventhsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblseventhseccclassid2" runat="server" Text="9" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccclassname2" runat="server" Text="VIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblseventhseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor8thseca" runat="server" Text='<%# Bind("eightsubjectseca") %>' CssClass="eightsubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightsecaclassid" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecaclassname" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor8thseca" runat="server" Text='<%# Bind("eightteacherseca") %>' CssClass="eightteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightsecaclassid2" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecaclassname2" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor8thsecb" runat="server" Text='<%# Bind("eightsubjectsecb") %>' CssClass="eightsubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightsecbclassid" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbclassname" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor8thsecb" runat="server" Text='<%# Bind("eightteachersecb") %>' CssClass="eightteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightsecbclassid2" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbclassname2" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor8thsecc" runat="server" Text='<%# Bind("eightsubjectsecc") %>' CssClass="eightsubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightseccclassid" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccclassname" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor8thsecc" runat="server" Text='<%# Bind("eightteachersecc") %>' CssClass="eightteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbleightsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbleightseccclassid2" runat="server" Text="10" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccclassname2" runat="server" Text="VIIIth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbleightseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor9thseca" runat="server" Text='<%# Bind("ninesubjectseca") %>' CssClass="ninesubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthsecaclassid" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecaclassname" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor9thseca" runat="server" Text='<%# Bind("nineteacherseca") %>' CssClass="nineteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthsecaclassid2" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecaclassname2" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor9thsecb" runat="server" Text='<%# Bind("ninesubjectsecb") %>' CssClass="ninesubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthsecbclassid" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbclassname" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor9thsecb" runat="server" Text='<%# Bind("nineteachersecb") %>' CssClass="nineteacherseccb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthsecbclassid2" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbclassname2" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor9thsecc" runat="server" Text='<%# Bind("ninesubjectsecc") %>' CssClass="ninesubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthseccclassid" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccclassname" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor9thsecc" runat="server" Text='<%# Bind("nineteachersecc") %>' CssClass="nineteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lblninthsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lblninthseccclassid2" runat="server" Text="11" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccclassname2" runat="server" Text="IXth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblninthseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor10thseca" runat="server" Text='<%# Bind("tensubjectseca") %>' CssClass="tensubjectseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecalectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecalecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthsecaclassid" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecaclassname" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecasectionid" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecasectionname" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor10thseca" runat="server" Text='<%# Bind("tenteacherseca") %>' CssClass="tenteacherseca" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecalectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecalecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthsecaclassid2" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecaclassname2" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecasectionid2" runat="server" Text="1" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecasectionname2" runat="server" Text="A" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor10thsecb" runat="server" Text='<%# Bind("tensubjectsecb") %>' CssClass="tensubjectsecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecblectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecblecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthsecbclassid" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbclassname" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbsectionid" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbsectionname" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor10thsecb" runat="server" Text='<%# Bind("tenteachersecb") %>' CssClass="tenteachersecb" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecblectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecblecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthsecbclassid2" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbclassname2" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbsectionid2" runat="server" Text="2" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecbsectionname2" runat="server" Text="B" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblsubjectfor10thsecc" runat="server" Text='<%# Bind("tensubjectsecc") %>' CssClass="tensubjectsecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecclectureid" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecclecturename" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthseccclassid" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccclassname" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccsectionid" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccsectionname" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lblteacherfor10thsecc" runat="server" Text='<%# Bind("tenteachersecc") %>' CssClass="tenteachersecc" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbltenthsecclectureid2" runat="server" Text='<%#Eval("Lectureid ")%>' CssClass="lecid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthsecclecturename2" runat="server" Text='<%#Eval("LectureName") %>' CssClass="lecname" Style="display: none"> </asp:Label>
                                            <asp:Label ID="lbltenthseccclassid2" runat="server" Text="12" CssClass="classid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccclassname2" runat="server" Text="Xth" CssClass="classname" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccsectionid2" runat="server" Text="3" CssClass="sectionid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbltenthseccsectionname2" runat="server" Text="C" CssClass="sectionname" Style="display: none"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>

            <div id="maindivpopup" style="text-align: center; display: none;">
                <div style="width: 95%; margin: 10px;">
                    <table class="maindivpopup" style="background-color: white; vertical-align: top">

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
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>