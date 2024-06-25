<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="create-time-table.aspx.cs" Inherits="BranchPanel_create_time_table" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <style type="text/css">
        a {
            text-decoration: none !important;
        }

        .divclass {
            width: 370px;
            height: 365px;
            display: none;
            background-color: white;
            position: fixed;
            top: 25%;
            left: 45%;
            border: 1px solid;
            border-color: black;
        }

        .clasfortd1 {
            color: #249cdd;
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
            color: #404141;
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

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 313px;
        }

        .maindivpopup {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
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
    <script type="text/javascript">
        var classid = "0", sectionid = "0", wdid = "0", lectureid = "0", subjectid = "0", teacherid = "0", classname = "", mode = "0", temp = "0";

        $(document).ready(function () {
            document.title = "Create Time Table"
            $("#ctl00_ContentPlaceHolder1_ddlSection").change(function () {
                
                sectionid = document.getElementById("ctl00_ContentPlaceHolder1_ddlSection").value;
                $('#ctl00_ContentPlaceHolder1_tablemaingridview').css("display", "block");
                BindMainGrid(classid, sectionid);
                Bindtimetablegrid();
                $("#ctl00_ContentPlaceHolder1_tablecreatetimetable").css("display", "block");
            });

            $("#ctl00_ContentPlaceHolder1_ddlClass").change(function () {
                $('#ctl00_ContentPlaceHolder1_divsection').css("display", "block");
                classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                if (classid == "0") {
                    $('#ctl00_ContentPlaceHolder1_divsection').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_ddlSection').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_ddlSection').children().remove();
                }

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
            });

            $("#btclose").click(function () {
                $('#maindivpopup').css("display", "none");
                $('.maindivpopup').fadeOut(500);
            });
            $("#ctl00_ContentPlaceHolder1_gridcreatetimetable a").click(function () {
                mode = "1";
                $('#ctl00_ContentPlaceHolder1_lbltext').html('Create Time Table');
                $('#maindivpopup').css("display", "block");
                $('.maindivpopup').fadeIn(500);
                $(this).parent('div').find('.update').css("display", "block");
                wdid = $(this).parent('div').find('.RowNumber').text();
                lectureid = $(this).parent('div').find('.lectureid').text();
                var lecturename = $(this).parent('div').find('.lecturename').text();
                var day = $(this).parent('div').find('.Day').html();
                fillsubjectdropdown();

                classname = $("#ctl00_ContentPlaceHolder1_ddlClass option:selected").text();
                $("#ctl00_ContentPlaceHolder1_lblclass").text(classname)
                $("#ctl00_ContentPlaceHolder1_lblday").text(day);
                $("#ctl00_ContentPlaceHolder1_lblperiod").text(lecturename);
                if ($(this).text().trim() == "Update") {
                    $('#ctl00_ContentPlaceHolder1_lbltext').html('Update Time Table');
                    mode = "2";
                    BindSelectedSubjectAndTeacher();
                }
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnclosepopup").click(function () {
                subjectid = "0";
                teacherid = "0";
                document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = "0";
                document.getElementById("ctl00_ContentPlaceHolder1_ddlselectedteacher").value = "0";
                $('#maindivpopup').css("display", "none");
                $('.maindivpopup').fadeOut(500);
                return false;
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
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','lectureid':'" + lectureid + "','Dayid':'" + wdid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        document.getElementById("ctl00_ContentPlaceHolder1_ddlsubject").value = data.d[0].subjectid;
                        subjectid = data.d[0].subjectid;
                        teacherid = data.d[0].teacherid;
                        fillteacherdropdown();
                    }
                },
                error: function (result) {
                    return false;
                }
            });
        }

        function BindMainGrid(classid, sectionid) {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/progressjqury.gif"  />');
            $("#divProgressBar").addClass("progressAdd");
            $('#ctl00_ContentPlaceHolder1_tablemaingridview').css("display", "block");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-time-table.aspx/BindDatatable",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=getfacultydetailswithclassandsubject] tr:last-child").clone(true);
                        $("[id*=getfacultydetailswithclassandsubject] tr").not($("[id*=getfacultydetailswithclassandsubject] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=getfacultydetailswithclassandsubject] tr:last-child").clone(true);
                            }
                            $("[id$=getfacultydetailswithclassandsubject]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.Classname').html(data.d[i].Classname);
                            $(row).find('.subjectname').html(data.d[i].subjectname);
                            $(row).find('.teachername').html(data.d[i].teachername);
                            //$("[id$=getfacultydetailswithclassandsubject]").append(row);
                        }
                        $("[id*=getfacultydetailswithclassandsubject] tr").show();
                        $("[id*=getfacultydetailswithclassandsubject] tr:first-child").show();
                    }
                    else {
                        var row = $("[id*=getfacultydetailswithclassandsubject] tr:last-child").clone(true);
                        $("[id*=getfacultydetailswithclassandsubject] tr").not($("[id*=getfacultydetailswithclassandsubject] tr:first-child")).remove();
                        $("[id$=getfacultydetailswithclassandsubject]").append(row);
                        $(row).find('.RowNumber').html('No Record Found');
                        $(row).find('.Classname').html('No Record Found');
                        $(row).find('.subjectname').html('No Record Found');
                        $(row).find('.teachername').html('No Record Found');
                    }
                    $("[id*=getfacultydetailswithclassandsubject] tr").show();
                    $("[id*=getfacultydetailswithclassandsubject] tr:first-child").show();

                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                    $('.maindivpopup').css("display", "none");
                },
                error: function (result) {
                    return false;
                }

            });
        }

        function Bindtimetablegrid() {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/progressjqury.gif"  />');
            $("#divProgressBar").addClass("progressAdd");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-time-table.aspx/timetablegrid",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=gridcreatetimetable] tr:last-child").clone(true);
                        $("[id*=gridcreatetimetable] tr").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=gridcreatetimetable] tr:last-child").clone(true);
                            }
                            $("[id$=gridcreatetimetable]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].Dayid);
                            $(row).find('.Day').html(data.d[i].Day);
                            $(row).find('.Assembly').html(data.d[i].Assembly);
                            $(row).find('.FirstLecture').html(data.d[i].FirstLecture);
                            $(row).find('.SecondLecture').html(data.d[i].SecondLecture);
                            $(row).find('.ThirdLecture').html(data.d[i].ThirdLecture);
                            $(row).find('.FourthLecture').html(data.d[i].FourthLecture);
                            $(row).find('.Lunch').html(data.d[i].Lunch);
                            $(row).find('.FifthLecture').html(data.d[i].FifthLecture);
                            $(row).find('.SixthLecture').html(data.d[i].SixthLecture);
                            $(row).find('.SeventhLecture').html(data.d[i].SeventhLecture);
                            $(row).find('.EightthLecture').html(data.d[i].EightthLecture);
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
                    return false;
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
                         return false;
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
                   return false;
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
                    data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','subjectid':'" + subjectid + "','teacherid':'" + teacherid + "','wdid':'" + wdid + "','lectureid':'" + lectureid + "','mode':'" + mode + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alert("Time table of " + $("#ctl00_ContentPlaceHolder1_ddlselectedteacher option:selected").text() + " has been created successfully");
                            Bindtimetablegrid();
                            $("#popup").css("display", "none");
                            $('.maindivpopup').css("display", "none");
                            subjectid = "0";
                            teacherid = "0";

                            return;
                        }
                        if (data.d == 2) {
                            alert(" " + $("#ctl00_ContentPlaceHolder1_ddlselectedteacher option:selected").text() + " is already engaged.");
                            return;
                        }
                    },
                    error: function (result) {
                        return false;
                    }

                });
            }
        }
    </script>

    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Create TimeTable</h2>
        </div>
        <div class="for_sigle_row_form" style=" margin-left: 227px; width: 563px; min-height: 50px; margin-top: 10px !important; margin-bottom: 7px !important">
            <div class="for_sigle_row_form" style="margin-left: -68px">
                <label>
                    Select Class<span style="color: Red">*</span>
                </label>
                <asp:DropDownList ID="ddlClass" runat="server">
                </asp:DropDownList>
            </div>

            <div class="for_sigle_row_form" id="divsection" runat="server" style="display: none; margin-left: -68px">
                <label>
                    Select Section<span style="color: Red">*</span></label>
                <asp:DropDownList ID="ddlSection" runat="server">
                </asp:DropDownList>
            </div>
        </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablemaingridview" style="display: none; margin: 20px 0px -7px 143px !important; width: 69%;" runat="server">

            <tr>
                <td>
                    <asp:GridView ID="getfacultydetailswithclassandsubject" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                        runat="server" CssClass="stm" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%# Bind("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Subjects">
                                <ItemTemplate>
                                    <asp:Label ID="lblsubject" runat="server" Text='<%# Eval("subjectname") %>' CssClass="subjectname"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teachers Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblsubject" runat="server" Text='<%# Eval("teachername") %>' CssClass="teachername"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="700px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
            </tr>
        </table>

        <div style="padding: 4px;">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" style="display: none; margin: 20px 0px 0px 0px !important;" runat="server">
                <tr class="stm_head">
                    <td rowspan="3" align="center" style="width: 70px; font-size: 11px; border: 1px solid #ddd;">S. No.
                    </td>
                    <td rowspan="3" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">Day
                    </td>

                    <td colspan="2" align="center" style="width: 105px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">Assembly
                    </td>
                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">1st Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">2nd Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">3rd Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">4th Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 100px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">Lunch
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">5th Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">6th Lecture
                    </td>

                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">7th Lecture
                    </td>
                    <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-top: 1px solid #ddd;">8th Lecture
                    </td>
                </tr>

                <tr class="stm_head">

                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                    <td width="50px" align="center" class="classfortd2">From
                    </td>
                    <td width="50px" align="center" class="classfortd2">To
                    </td>
                </tr>

                <tr id="tr3" class="stm_head">

                    <td width="50px" align="center" class="clasfortd1">8:00 AM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">9:35 AM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">9:35 AM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">10:30 AM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">10:30 AM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">11:30 AM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">11:30 AM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">12:30 PM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">12:30 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">12:55 PM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">12:55 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">1:25 PM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">1:25 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">2:00 PM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">2:00 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">2:15 PM
                    </td>

                    <td width="50px" align="center" class="clasfortd1">2:15 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">2:45 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">2:45 PM
                    </td>
                    <td width="50px" align="center" class="clasfortd1">3:00 PM
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="22" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView ID="gridcreatetimetable" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                            runat="server" CssClass="stm" GridLines="None" ShowHeader="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblSNo" Text='<%# Bind("Dayid") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="110px" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblclass" runat="server" Text='<%# Bind("Day") %>' CssClass="Day"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblassembly" runat="server" CssClass="Assembly"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="8.4%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnFirstLecture" runat="server" class="FirstLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid1" runat="server" Text="2" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname1" runat="server" Text="1st Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec1" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday1" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnSecondLecture" runat="server" class="SecondLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid2" runat="server" Text="3" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname2" runat="server" Text="2nd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec2" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday2" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnThirdLecture" runat="server" class="ThirdLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid3" runat="server" Text="4" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname3" runat="server" Text="3rd Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec3" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday3" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnFourthLecture" runat="server" class="FourthLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid4" runat="server" Text="5" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname4" runat="server" Text="4th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec4" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday4" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lbllunch" runat="server" CssClass="Lunch"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="160px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnFifthLecture" runat="server" class="FifthLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid5" runat="server" Text="7" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname5" runat="server" Text="5th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec5" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday5" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnSixthLecture" runat="server" class="SixthLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid6" runat="server" Text="8" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname6" runat="server" Text="6th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec6" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday6" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="8.7%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnSeventhLecture" runat="server" class="SeventhLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid7" runat="server" Text="9" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname7" runat="server" Text="7th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec7" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday7" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="8.7%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton ID="lbtnEightthLecture" runat="server" class="EightthLecture" Style="text-decoration: none"></asp:LinkButton>
                                            <asp:Label ID="lbllectureid8" runat="server" Text="10" CssClass="lectureid" Style="display: none"></asp:Label>
                                            <asp:Label ID="lbllecturname8" runat="server" Text="8th Lecture" CssClass="lecturename" Style="display: none"></asp:Label>
                                            <asp:Label ID="lblwdidforlec8" Text='<%# Bind("Dayid") %>' Style="display: none" runat="server" CssClass="RowNumber"></asp:Label>
                                            <asp:Label ID="lblday8" runat="server" Text='<%# Bind("Day") %>' Style="display: none" CssClass="Day"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle Width="8.7%" HorizontalAlign="Center" />
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
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>