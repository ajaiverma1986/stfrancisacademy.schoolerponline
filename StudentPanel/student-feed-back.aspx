<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="student-feed-back.aspx.cs" Inherits="StudentPanel_student_feed_back" EnableEventValidation="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">

    <style>
        .feedbackactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .feedbackactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .clsstarscolored {
            color: #e65124 !important;
        }

        *, *::before, *::after {
            box-sizing: border-box;
        }

        .rating > span:hover:before,
        .rating > span:hover ~ span:before {
            content: "☆" !important;
            position: absolute;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px!important;
            font-weight: normal!important;
        }

        .for_sigle_row_form label {
            width: 20%;
            text-align: right;
            font-size: 14px;
            font-weight: 500;
            font-family: Arial;
            margin-right: 20px;
        }

        .for_sigle_row_form textarea {
            width: 33%;
            height: 80px;
            border: 1px solid #ccc;
            color: #454545;
            font-family: Arial;
            padding: 5px;
            font-size: 12px;
        }

        .for_sigle_row_form select {
            background: #fff none repeat scroll 0 0;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            margin-bottom: 0;
            outline: medium none;
            padding: 6px 5px;
            width: 33%;
        }

        .btnClrStars {
            background-color: #49c0f0;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #15aeec;
            color: #ffffff;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 11px;
            font-weight: bold;
            padding: 3px 9px 4px;
            text-decoration: none;
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }
    </style>
    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">

                    <div class="clearfix"></div>
                    <h1>
                        <i class="fa fa-envelope"></i>
                        FEEDBACK
                    </h1>
                    <div style="height: 25px; width: 230px; text-align: center; margin-top: -26px; margin-left: 10Px; padding: 5px; float: right">
                        <label>Total Submitted Feedback</label>:
                    <span id="spanatotalsubmitedfeedback" runat="server">0</span>
                    </div>
                </div>
            </div>
            <div class="main-content" style="width: 100%;">
                <div class="for_sigle_row_form">
                    <label>
                        Select Feedback Type: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlfeedbacktypes" runat="server">
                        <asp:ListItem Value="0" Text="---Select Feedback Type---"></asp:ListItem>
                        <asp:ListItem Value="1" Text="General Feedback"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Faculty Feedback"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Other Feedback"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div id="selectteacher" class="for_sigle_row_form" style="display: none">
                    <label>
                        Select Teacher: <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="teacherlist" runat="server"></asp:DropDownList>
                </div>
                <div class="clear"></div>
                <div id="bindfeedbacksubject" class="for_sigle_row_form" style="padding-right: 50px; display: none; width: 100%; margin-left: 0px !important;">
                    <table style="width: 850px; margin: 0 auto;" class="stm">
                        <tr>
                            <th>Feedback Subject</th>
                        </tr>
                    </table>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Button ID="btnSaveFeddback" runat="server" Text="Submit" CssClass="button_save" Style="padding-top: 4px; padding-bottom: 4px;" />

                    <asp:Button ID="btnclear" runat="server" Text="cancel" ToolTip="Click here for cancel" CssClass="button_save" Style="padding-top: 4px; padding-bottom: 4px;" Visible="false"></asp:Button>
                </div>
            </div>
        </div>
    </div>
    <link href="../css/stylesheet.css" rel="stylesheet" />
    <link href="../css/product-listing.css" rel="stylesheet" />
    <script type="text/javascript">
        var rate = 0;
        var Feedback_typeid = '', Feedback = 0, feedbackSubject = "", TeacherName = "", TeacherId = 0, FeedbackDescription = "", Status = 1, TeacherScore = '', StuRegNo = 0;
        $(document).ready(function () {
            //For Finding The Student Id From QueryString Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    StuRegNo = urlparam[1];
                }
            }
            //For Finding The Student Id From QueryString End Here
            $('#ctl00_head_ddlfeedbacktypes').val("0");
            $('#ctl00_head_txtdescription').val("");
            $('#ctl00_head_ddlfeedbacktypes').change(function () {
                var ddlvalue = 0;
                ddlvalue = $('#ctl00_head_ddlfeedbacktypes').val();

                if (ddlvalue > 0) {
                    BindFeedbackTypeGrid(ddlvalue);
                    $('#bindfeedbacksubject').css("display", "block");

                    if (ddlvalue == 2) {

                        BindTeacher();
                        $('#selectteacher').css("display", "block");
                    }
                    else {
                        $('#selectteacher').css("display", "none");
                    }
                }

                else {
                    $('#bindfeedbacksubject').css("display", "none");
                    $('#selectteacher').css("display", "none");
                }

                return false;

            });
            $('#ctl00_head_btnSaveFeddback').live('click', function () {

                if ($("#ctl00_head_ddlfeedbacktypes").val() == "0") {
                    alertify.error("Please Select feedback types.");
                    return false;
                }

                var ddlid = $('#ctl00_head_ddlfeedbacktypes option:selected').val();
                if (ddlid == 2) {
                    if ($("#ctl00_head_teacherlist").val() == "0") {
                        alertify.error("Please Select teacher name .");
                        return false;
                    }
                }
                FillField();
                SubmitFeedbackStudentDetails();

                return false;
            });
            $(".rating span").live('click', function () {
                Feedback = $(this).parent('div').parent('td').parent('tr').find('input[type=hidden]').val();
                rate = 0;
                $(this).parent("div").find("rating").find("span").html("☆");
                $(this).parent("div").find("rated").find("span").html("☆");
                $(this).parent("div span").attr("class", "clsstarsblank");
                $(this).parent("div").find("span").removeClass("clsstarscolored");
                $(this).parent("div").find("span").addClass("rating");
                $(this).parent("div").removeClass('rated');

                $(this).parent("div").addClass('rating');
                if (rate == 0) {
                    rate = $(this).attr("id");
                }
                for (var i = 5 ; i >= (5 - parseInt(rate)) ; i--) {
                    $(this).parent("div").find("span:eq(" + i + ")").html("☆");
                    $(this).parent("div").find("span:eq(" + i + ")").attr("class", "clsstarscolored");
                    if (rate == 0) {
                        rate = $(this).attr("id");

                        $(this).parent("div").find("label").text("Rate It");
                    }
                    if (rate == "1") {
                        $(this).parent("div").find("label").text("Poor");
                    }
                    if (rate == "2") {
                        $(this).parent("div").find("label").text("Average");
                    }
                    if (rate == "3") {
                        $(this).parent("div").find("label").text("Good");
                    }
                    if (rate == "4") {
                        $(this).parent("div").find("label").text("Very Good");
                    }
                    if (rate == "5") {
                        $(this).parent("div").find(".RateMsg").text("Excellent");
                    }
                }
                $(this).parent("div").removeClass('rating');
                $(this).parent("div").addClass('rated');
            });
            $(".clsclrstars").live('click', function () {
                Feedback = $(this).parent('div').parent('td').parent('tr').find('input[type=hidden]').val();
                rate = 0;
                $(this).parent("div").find("rating").find("span").html("☆");
                $(this).parent("div").find("rated").find("span").html("☆");
                $(this).find("div").removeClass('rated');
                $(this).find("div").removeClass('rating');
                $(this).siblings("span").removeClass('clsstarscolored');
                $(this).parent("div").addClass('rating');
                $(this).parent("div").find("label").text("Rating");
            });
        });
        function FillField() {
            var i = 0;
            Feedback_typeid = '', feedbackSubject = "", TeacherName = "", TeacherId = 0, FeedbackDescription = "", TeacherScore = '';
            Feedback_typeid = $('#ctl00_head_ddlfeedbacktypes').val();
            feedbackSubject = "";
            if ($('#ctl00_head_teacherlist').val() == null) {

                TeacherId = 0;
                TeacherName = "";
            }
            else {
                TeacherId = $('#ctl00_head_teacherlist option:selected').val();
                TeacherName = $('#ctl00_head_teacherlist option:selected').text();
            }
            var trlength = $('#bindfeedbacksubject').find('tr').length;
            for (var j = 1; j <= trlength;) {
                if ($('#bindfeedbacksubject').find('tr:eq(' + j + ')').find('.spansubject').text() != '')
                    feedbackSubject = feedbackSubject + '~' + $('#bindfeedbacksubject').find('tr:eq(' + j + ')').find('.spansubject').text().replace("'", ">");
                j = j + 1;
                if (j == trlength)
                    break;
                if ($('#bindfeedbacksubject').find('tr:eq(' + j + ')').find('textarea ').val() != '')
                    FeedbackDescription = FeedbackDescription + '~' + $('#bindfeedbacksubject').find('tr:eq(' + j + ')').find('textarea ').val().replace("'", ">");
                else
                    FeedbackDescription = FeedbackDescription + '~' + 'N/A'
                j = j + 1;
                if (j == trlength)
                    break;
                TeacherScore = TeacherScore + '~' + $('#bindfeedbacksubject').find('tr:eq(' + j + ') .clsstarscolored').length;
                j = j + 1;
                if (j == trlength)
                    break;
            }

            feedbackSubject = feedbackSubject.slice(1, feedbackSubject.length);
            FeedbackDescription = FeedbackDescription.slice(1, FeedbackDescription.length);
            TeacherScore = TeacherScore.slice(1, TeacherScore.length);
        }
        function SubmitFeedbackStudentDetails() {
            //alert(Feedback_typeid + '-' + feedbackSubject + '-' + TeacherId + '-' + TeacherName + '-' + FeedbackDescription + '-' + Status + '-' + TeacherScore+'-'+StuRegNo);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-feed-back.aspx/SubmitFeedbackStudentDetails",
                data: "{'Feedback_typeid':'" + Feedback_typeid + "','feedbackSubject':'" + feedbackSubject + "','TeacherId':'" + TeacherId + "','TeacherName':'" + TeacherName + "','FeedbackDescription':'" + FeedbackDescription + "','Status':'" + Status + "','TeacherScore':'" + TeacherScore + "','StuRegNo':'" + StuRegNo + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Feedback Added Sucessfully.');
                        if (parseInt(StuRegNo) != 0)
                            window.location.href = "../user-login.aspx";
                    }
                    else if (data.d == 2) {
                        alertify.success('Some Error Occured. While Feedback Adding.');
                    }
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                },
            });
        }
        function BindFeedbackTypeGrid(ddlvalue) {
            $('.stm tr:gt(0)').remove();
            var trforappend = '', classfortr = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-feed-back.aspx/BindGridByJs",
                data: "{'ddlvalue':'" + ddlvalue + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                classfortr = 'stm_dark'
                            else
                                classfortr = 'stm_light'

                            trforappend = '<tr class="' + classfortr + '"><td><input type="hidden" value="' + data.d[i].FeedbackTypeid + '" />' + (i + 1) + '):<span class="spansubject">' + data.d[i].FeedbackTypeName + '</span></td></tr>' +
                            '<tr class="' + classfortr + '"><td><input type="hidden" value="' + data.d[i].FeedbackTypeid + '" /><textarea class="txtdesciption"  placeholder="Enter Suggestion" style="width:310px; height:100px;"></textarea></td></tr>' +
                            '<tr class="' + classfortr + '"><td><input type="hidden" value="' + data.d[i].FeedbackTypeid + '" />' +

                            '<div class="rating for_sigle_row_form">' +

                           ' <label class="RateMsg" style=" margin-left:-45px;float:left ; color:blue">Rating</label>' +

                            ' <span id="5">☆</span>' +

                            ' <span id="4">☆</span>' +

                            ' <span id="3">☆</span>' +

                             ' <span id="2">☆</span>' +

                              ' <span id="1">☆</span>' +

                               '<a class="clsclrstars  cancel_btn" style="margin-right:175px; float:right">Clear</a>' +

                            '</div></td></tr>';

                            $('.stm').append(trforappend);
                        }
                    }
                    else {

                        alertify.error('Sorry ! No Record Found..');
                    }
                },
                error: function (response) {
                    alertify.error('Some Internal Error Occured Data Is Binding.')
                }
            });
        }
        function BindTeacher() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-feed-back.aspx/bindTeacher",
                data: "{'StuRegNo':'" + StuRegNo + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_head_teacherlist").html("");
                    $("#ctl00_head_teacherlist").append($("<option></option>").val('0').html('--Select Teacher--'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_head_teacherlist").append($("<option></option>").val(value.facultyid).html(value.name));
                    });
                    ;
                },
                error: function (result) {

                    alertify.error('Some Network Issue Occur.');
                },
            });
        }
    </script>
</asp:Content>