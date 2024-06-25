<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="my-test.aspx.cs" Inherits="StudentPanel_my_test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>

    <style type="text/css">
        .student-panel-tbl {
             width: 100%;           
        }
        .testactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .testactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .stmforpast tr td {
            height: 30px !important;
        }

        .QuestionPreviewShow {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            left: 33%;
            opacity: 1;
            display: block;
            overflow: auto;
            padding-bottom: 8px !important;
            top: 20%;
            width: 50% !important;
            max-height: 500px;
            background: #F6F6F6 !important;
        }

        .pop-headng-sty {
            background: #3cb8ea none repeat scroll 0 0;
            color: #fff;
            font-size: 16px;
            margin-bottom: 10px;
            padding: 8px 10px;
            text-align: left;
        }

        .btnClose, .btnClosesub {
            cursor: pointer;
            float: right;
        }
    </style>
    <link href="css/exam.css" rel="stylesheet" />
    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">

                    <h1>
                        <i class="fa fa-pencil" style="color: white"></i>
                        My Test
                    </h1>
                </div>

                <div class="main-content" style="width: 100%;">
                    <div class="clearfix"></div>
                    <div class="divforactivetest inner-heading2-stp">Your Active/Coming Test List</div>

                    <div class="student-panel-tbl">
                        <table class="stm stmpresent" style="width: 100%;">
                            <tr class="stm_head">
                                <th style="width: 5%;">S.No.
                                </th>
                                <th>Exam Name
                                </th>
                                <th>Module Name
                                </th>
                                <th>Conduct between Date & Time
                                </th>
                                <th style="width: 70px">Start
                                </th>
                                <th style="width: 70px">Details
                                </th>
                            </tr>
                        </table>
                    </div>

                    <div class="clearfix"></div>
                    <div class="divforpasttest inner-heading2-stp">Your Given/Missed Test List</div>

                    <div class="student-panel-tbl">
                        <table style="width: 100%" class="stm stmforpast">
                            <tr class="stm_head">
                                <th>S.No.
                                </th>
                                <th>Exam Name
                                </th>
                                <th>Module Name
                                </th>
                                <th>Scheduled Date & Time
                                </th>
                                <th>Result
                                </th>
                                <th>Answer Key
                                </th>
                                <th style="width: 70px">Details
                                </th>
                            </tr>
                        </table>
                    </div>

                    <div class="studentlist" style="display: none">

                        <div class="student-panel-tbl">
                            <table class="stm stmappearedstudentlist" style="width: 100%">
                                <tr class="stm_head">
                                    <th scope="col">SNo.</th>
                                    <th scope="col">Course</th>
                                    <th scope="col">Total Question</th>
                                    <th scope="col">Total Right</th>
                                    <th scope="col">Total Wrong</th>
                                    <th scope="col">Total Blank</th>
                                    <th scope="col">Total Marks</th>
                                    <th scope="col">Per %</th>
                                    <th scope="col">Rank</th>
                                    <th scope="col">Get Details</th>
                                </tr>
                            </table>

                            <asp:Button ID="btnbackforstudentlist" CssClass="back-button" runat="server" Text="Back" />
                        </div>
                    </div>

                    <div class="studentexammodulelist" style="display: none">
                        <div class="student-panel-tbl">
                            <table class="stm stmmoduledetails" style="width: 100%">
                                <tr class="stm_head">
                                    <th scope="col">SNo.</th>
                                    <th scope="col">Module</th>
                                    <th scope="col">Total Question</th>
                                    <th scope="col">Total Right</th>
                                    <th scope="col">Total Wrong</th>
                                    <th scope="col">Total Blank</th>
                                    <th scope="col">Total Marks</th>
                                    <th scope="col">Per %</th>
                                    <th scope="col">Rank</th>
                                </tr>
                            </table>
                            <asp:Button ID="btnbackformodule" CssClass="back-button" runat="server" Text="Back" />
                        </div>
                    </div>

                    <div class="answerkeyofexam" style="display: none">
                        <div class="student-panel-tbl">
                            <table class="stm stmanswerkey" style="width: 100%">
                                <tr class="stm_head">
                                    <th scope="col">SNo.</th>
                                    <th scope="col">Module</th>
                                    <th scope="col">Question Code</th>
                                    <th scope="col">Class</th>
                                    <th scope="col">Subject</th>
                                    <th scope="col">Topic</th>
                                    <th scope="col">Answer</th>
                                    <th scope="col">Given Answer</th>
                                    <th scope="col">Staus</th>
                                    <th scope="col">Details</th>
                                </tr>
                            </table>
                        </div>
                        <table class="stm" style="width: 100%">
                            <tr class="stm_head">
                                <td>
                                    <asp:Button ID="Btnbackanswerkey" runat="server" Text="Back" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="display: none" class="exammodule">
                    <div class="pop-headng-sty">
                        Module Details Of Exam(<span class="examnameforpopup" style="font-weight: bold;"></span>)
                    <a id="A1" title="Close this from here" class="btnClose">
                        <img src="../images/no.png" alt="No Image" class="ImgClose" /></a>
                    </div>
                    <table class="stm stmmoduledetails" style="width: 100%" cellpadding="0" cellspacing="0">
                        <tr class="stm_head" align="center">
                            <th align="center" scope="col">S.No.</th>
                            <th align="center" scope="col">Module</th>
                            <th align="center" scope="col">No. Of Question</th>
                            <th align="center" scope="col">Marks Per Right Answer</th>
                            <th align="center" scope="col">Total Marks</th>
                            <th align="center" scope="col">Negative Marking Apply</th>
                            <th align="center" scope="col">Marks Deduction Per Wrong Answer</th>
                        </tr>
                    </table>
                </div>
                    <div class="QuestionPreviewShow" style="display: none">
                        <div class="pop-headng-sty">
                            View Detail Of [Question Code:<span class="spanquestioncode" style="font-weight: bold;"></span>]
                     <a id="BtnCancelTopic" title="Close this from here" class="btnClose">
                         <img src="../images/no.png" alt="No Image" class="ImgClose" /></a>
                        </div>
                        <div class="ShowQuestionPreview" style="margin: 10px !important;">
                            <span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">Which of the following computer language is used for artificial intelligence?</span><br />
                            <div class="pop-headng-sty">All Option</div>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>A.
                                            <input id="RadioButtonForQuestionOptioninput_1" type="radio" value="1" />
                                            <label for="RadioButtonForQuestionOptionlabel_1"></label>
                                            Ans 1</td>
                                    </tr>
                                    <tr>
                                        <td>B.
                                            <input id="RadioButtonForQuestionOptioninput_2" type="radio" value="2" />
                                            <label for="RadioButtonForQuestionOptionlabel_2"></label>
                                            Ans 2</td>
                                    </tr>
                                    <tr>
                                        <td>C.
                                            <input id="RadioButtonForQuestionOptioninput_3" type="radio" value="3" />
                                            <label for="RadioButtonForQuestionOptionlabel_3"></label>
                                            Ans 3</td>
                                    </tr>
                                    <tr>
                                        <td>D.
                                            <input id="RadioButtonForQuestionOptioninput_4" type="radio" value="4" />
                                            <label for="RadioButtonForQuestionOptionlabel_4"></label>
                                            Ans 4</td>
                                    </tr>
                                </tbody>
                            </table>
                            <br />
                            <div class="pop-headng-sty">Answer</div>
                            A.Ans 1D.<span style="color: #000000; font-family: Verdana, Tahoma; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">PASCAL</span>D.<span style="color: #000000; font-family: Verdana, Tahoma; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">Data processing</span>D.<span style="color: #000000; font-family: Verdana, Tahoma; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">CPU</span>D.<span style="color: #000000; font-family: Verdana, Tahoma; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">Technological advancement</span>D.<span style="color: #000000; font-family: Verdana, Tahoma; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">PROLOG</span><br />
                            <div class="pop-headng-sty">Answer Explanation</div>
                            No Explanation<span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">No answer description available for this question.</span><span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">No answer description available for this question</span><span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">No answer description available for this question</span><span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">No answer description available for this question</span><span style="color: #000000; font-family: Verdana, Tahoma, Arial, sans-serif; font-size: 12px; font-style: normal; normal; font-weight: normal; normal; 17px; orphans: auto; text-align: start; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke- 0px; display: inline !important; float: none; background-color: #ffffff;">Prolog is a general purpose logic programming language associated with artificial intelligence and computational linguistics.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var trforappend = "";

        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/check_Online",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 0 || data.d == 2) {
                        alertify.error('Your Exam Mode is Offline.or not Registered');
                        location.href = "RegExam.aspx";
                        return false;
                    }
                }
            });

            $('.imgforstarttest').live('click', function () {
                var Examid = 0;
                var status = confirm('Are You Sure You Want To Attend/Start The Test.?');
                if (status == true) {
                    Examid = $(this).parent('td').find('input').val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "my-test.aspx/FillSession",
                        data: "{'Examid':'" + Examid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 0) {
                                alertify.error('You can not start the test.you can start the test only between conduct date & time.');
                                return false;
                            }
                            else if (data.d == 1) {
                                window.location.href = "instruction.aspx";
                                return false;
                            }
                        }
                    });
                }
                else {
                    alertify.error('You Clicked Cancel.')
                }
            });
            $('.GetResult').live('click', function () {
                $('.answerkeyofexam').css("display", "none");
                var Examid = $(this).parent('td').find('input').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "my-test.aspx/CheckExamGivenOrNot",
                    data: "{'Examid':'" + Examid + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d == 0) {
                            alertify.error('You can not see the result because you missed the test.');
                            return false;
                        }
                        else if (data.d == 1) {
                            BindGridMain(Examid);
                            return false;
                        }
                    }
                });
                return false;
            });
            $('.imgexamdetails').live('click', function () {
                var trindex = $(this).parent('td').parent('tr').index();
                var trdata = '<tr>' + $('.stmappearedstudentlist').find('tr:eq(' + (parseInt(trindex)) + ')').html() + '</tr>'
                $('.stmappearedstudentlist').find('tr:gt(0)').remove();
                $('.stmappearedstudentlist').append(trdata);
                Examid = $(this).parent('td').find('input[type=hidden]').val();
                Sturegno = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type=hidden]').val();
                BindDetilGrid();
                return false;
            });
            $('#ctl00_head_btnbackformodule').click(function () {
                $('.studentexammodulelist').css('display', 'none');
                return false;
            });
            $('#ctl00_head_btnbackforstudentlist').click(function () {
                BindPastGrid();
                $('.studentlist').css('display', 'none');
                return false;
            });
            $('.imganswerkeyofexam').live('click', function () {
                BindAnswerKey($(this).parent('td').parent('tr').find('td:eq(4)').find('input').val());
                return false;
            });
            $('#ctl00_head_Btnbackanswerkey').click(function () {
                $('.answerkeyofexam').css("display", "none");
                return false;
            });
            $('.imganserkeyview').live('click', function () {
                $('.QuestionPreviewShow').css("display", "block");
                $('.spanquestioncode').html($(this).parent('td').parent('tr').find('td:eq(2)').html());
                BindAnswerDetails($(this).parent('td').find('input[type=hidden]').val())
                return false;
            });
            $('.ImgClose').click(function () {
                $('.QuestionPreviewShow').css("display", "none");
            });
            $('.viewexam,.viewexamcurrent').live('click', function () {
                var ExamidTemp = $(this).parent('td').parent('tr').find('td:eq(4)').find('input[type=hidden]').val();
                $('.examnameforpopup').html($(this).parent('td').parent('tr').find('td:eq(1)').html());
                Mode = 2;
                BindModuleMarkingGrid(ExamidTemp);
                $('.exammodule').css("display", "block");
                return false;
            });           
            $('.ImgClose').click(function () {
                $('.exammodule').css("display", "none");
                return false;
            });
            BindGrid();
            BindPastGrid();
        });
        function BindModuleMarkingGrid(ExamidTemp) {
            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "my-test.aspx/GetGridData",
                     data: "{'Examid':'" + ExamidTemp + "','Mode':'6'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         if (Mode == 2) {
                             $('.stmmoduledetails').find('tr:gt(0)').remove();
                             $('.stmmoduledetails').append(data.d);
                         }
                     },
                     error: function (result) {
                         alertify.error('Some Network Error.');
                     }
                 });
        }
        function BindAnswerDetails(Questionid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindAnswerKeyForBind",
                data: "{'Questionid':'" + Questionid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.ShowQuestionPreview').html(data.d);
                }
            });
        }
        function BindAnswerKey(Examid) {
            $('.studentlist').css("display", "none");
            $('.stmanswerkey tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindGridOfAnswerKey",
                data: "{'Examid':'" + Examid + "','ModuleId':'0'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('.answerkeyofexam').css("display", "block");
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '</td>' +
                                            '<td>' + data.d[i].Module_Name + '</td>' +
                                            '<td>' + data.d[i].Question_Code + '</td>' +
                                            '<td>' + data.d[i].Classname + '</td>' +
                                            '<td>' + data.d[i].SubjectName + '</td>' +
                                            '<td>' + data.d[i].TopicName + '</td>' +
                                            '<td>' + data.d[i].ActualAnswer + '</td>' +
                                            '<td>' + data.d[i].GivenAnswer + '</td>' +
                                            '<td><img  src="' + data.d[i].AttemtedStatus + '" style="width:15px !important" disabled="disabled" alt="N/A" /></td>' +
                                '<td><input type="image"  class="imganserkeyview" src="../images/viewquestion.png" style="width:15px !important" /><input type="hidden" value=' + data.d[i].Question_Id + ' /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '</td>' +
                                '<td>' + data.d[i].Module_Name + '</td>' +
                                '<td>' + data.d[i].Question_Code + '</td>' +
                                '<td>' + data.d[i].Classname + '</td>' +
                                '<td>' + data.d[i].SubjectName + '</td>' +
                                '<td>' + data.d[i].TopicName + '</td>' +
                                '<td>' + data.d[i].ActualAnswer + '</td>' +
                                '<td>' + data.d[i].GivenAnswer + '</td>' +
                                '<td><img   src="' + data.d[i].AttemtedStatus + '" style="width:15px !important" disabled="disabled" alt="N/A" /></td>' +
                                '<td><input type="image"  class="imganserkeyview" src="../images/viewquestion.png" style="width:15px !important" /><input type="hidden" value=' + data.d[i].Question_Id + ' /></td></tr>';
                            }
                            $('.stmanswerkey').append(trforappend);
                        }
                    }
                }
            });
        }

        function BindGrid() {
            $('.stmpresent tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].exam_name + '</td><td>' + data.d[i].ModuleName + '</td><td>' + data.d[i].DateAndTime + '</td><td style="text-align:right"><img class="imgforstarttest" alt="No Image" style="width: 25px; cursor: pointer;margin-right:30px" src="../images/starttest.png"><input type="hidden" value="' + data.d[i].exam_id + '" /></td><td><img class="viewexamcurrent" style="cursor: pointer !important;width:25px !important " src="../images/viewquestion.png"  title="Click here for get details"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].exam_name + '</td><td>' + data.d[i].ModuleName + '</td><td>' + data.d[i].DateAndTime + '</td><td style="text-align:right"><img class="imgforstarttest" alt="No Image" style="width: 25px; cursor: pointer;margin-right:30px" src="../images/starttest.png"><input type="hidden" value="' + data.d[i].exam_id + '" /></td><td><img class="viewexamcurrent" style="cursor: pointer !important;width:25px !important " src="../images/viewquestion.png"  title="Click here for get details"></td></tr>';
                            $('.stmpresent').append(trforappend);
                        }
                    }
                    else {
                        alertify.error("There is no any active exam.");
                    }
                },
                error: function (response) {
                }
            });
        }

        function BindPastGrid() {
            $('.stmforpast tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindPastGridByJs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].exam_name + '</td><td>' + data.d[i].ModuleName + '</td><td>' + data.d[i].DateAndTime + '</td><td style="text-align:right"><input type="hidden" value="' + data.d[i].exam_id + '" /><input class="GetResult" type="image" style="width:15px;border-width:0px;margin-right:30px" alt="No Image" src="../images/Exam_Result.png"></td><td><img class="imganswerkeyofexam" style="cursor: pointer !important;width:25px !important " src="../images/answerkey.png"  title="Click here for get answer key"></td><td><img class="viewexam" style="cursor: pointer !important;width:25px !important " src="../images/viewquestion.png"  title="Click here for get details"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].exam_name + '</td><td>' + data.d[i].ModuleName + '</td><td>' + data.d[i].DateAndTime + '</td><td style="text-align:right"><input type="hidden" value="' + data.d[i].exam_id + '" /><input class="GetResult" type="image" style="width:15px;border-width:0px;margin-right:30px" alt="No Image" src="../images/Exam_Result.png"></td><td><img class="imganswerkeyofexam" style="cursor: pointer !important;width:25px !important " src="../images/answerkey.png"  title="Click here for get answer key"></td><td><img class="viewexam" style="cursor: pointer !important;width:25px !important " src="../images/viewquestion.png"  title="Click here for get details"></td></tr>';
                            $('.stmforpast').append(trforappend);
                        }
                    }
                },
                error: function (response) {
                }
            });
        }

        function BindGridMain(Examid) {
            $('.studentlist').css("display", "block");
            $('.stmappearedstudentlist').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindGrid",
                data: "{'Examid':'" + Examid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '<input type="hidden" value=' + data.d[i].Sturegno + ' /></td>' +
                                            '<td>' + data.d[i].Course + '</td>' +
                                            '<td>' + data.d[i].TotalQuestion + '</td>' +
                                            '<td>' + data.d[i].TotalRight + '</td>' +
                                            '<td>' + data.d[i].TotalWrong + '</td>' +
                                            '<td>' + data.d[i].TotalBlank + '</td>' +
                                            '<td>' + data.d[i].TotalMarks + '</td>' +
                                            '<td>' + data.d[i].Percentage + '</td>' +
                                            '<td>' + data.d[i].Rank + '</td>' +
                                            '<td><input type="image"  class="imgexamdetails" src="../images/Exam_Result.png" style="width:15px !important" /><input type="hidden" value=' + data.d[i].ExamId + ' /></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '<input type="hidden" value=' + data.d[i].Sturegno + ' /></td>' +
                                            '<td>' + data.d[i].Course + '</td>' +
                                            '<td>' + data.d[i].TotalQuestion + '</td>' +
                                            '<td>' + data.d[i].TotalRight + '</td>' +
                                            '<td>' + data.d[i].TotalWrong + '</td>' +
                                            '<td>' + data.d[i].TotalBlank + '</td>' +
                                            '<td>' + data.d[i].TotalMarks + '</td>' +
                                            '<td>' + data.d[i].Percentage + '</td>' +
                                            '<td>' + data.d[i].Rank + '</td>' +
                                            '<td><input type="image"  class="imgexamdetails" src="../images/Exam_Result.png" style="width:15px !important" /><input type="hidden" value=' + data.d[i].ExamId + ' /></td></tr>';
                            }
                            $('.stmappearedstudentlist').append(trforappend);
                        }
                    }
                },
                error: function (response) {
                }
            });
        }

        function BindDetilGrid() {
            $('.studentexammodulelist').css('display', 'block');
            $('.stmmoduledetails').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "my-test.aspx/BindGridForDetails",
                data: "{'Sturegno':'" + Sturegno + "','Examid':'" + Examid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '</td>' +
                                            '<td>' + data.d[i].ModuleName + '</td>' +
                                            '<td>' + data.d[i].TotalQuestion + '</td>' +
                                            '<td>' + data.d[i].TotalRight + '</td>' +
                                            '<td>' + data.d[i].TotalWrong + '</td>' +
                                            '<td>' + data.d[i].TotalBlank + '</td>' +
                                            '<td>' + data.d[i].TotalMarks + '</td>' +
                                            '<td>' + data.d[i].Percentage + '</td>' +
                                            '<td>' + data.d[i].Rank + '</td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '</td>' +
                                            '<td>' + data.d[i].ModuleName + '</td>' +
                                            '<td>' + data.d[i].TotalQuestion + '</td>' +
                                            '<td>' + data.d[i].TotalRight + '</td>' +
                                            '<td>' + data.d[i].TotalWrong + '</td>' +
                                            '<td>' + data.d[i].TotalBlank + '</td>' +
                                            '<td>' + data.d[i].TotalMarks + '</td>' +
                                            '<td>' + data.d[i].Percentage + '</td>' +
                                            '<td>' + data.d[i].Rank + '</td></tr>';
                            }
                            $('.stmmoduledetails').append(trforappend);
                        }
                    }
                },
                error: function (response) {
                }
            });
        }
    </script>
</asp:Content>