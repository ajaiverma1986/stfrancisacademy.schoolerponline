<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <title>Online Speed Test
    </title>
    <link href="css/Site.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery-ui-1.7.0.smoothness.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .RadioButtonAnswer label {
            font-size: 17px !important;
        }
        input[type=radio] {
            transform: scale(1.3, 1.3);
            -moz-transform: scale(1.3, 1.3);
            -ms-transform: scale(1.3, 1.3);
            -webkit-transform: scale(1.3, 1.3);
            -o-transform: scale(1.3, 1.3);
        }
        .DivQuestionAnswerOption {
            float: right;
            font-size: 1.2em;
            margin-right: 30px;
            max-height: 350px;
            min-height: 350px;
            overflow-y: scroll;
            padding: 10px;
            width: 35%;
            margin-right:0px !important;
        }
        div.divPassage {
            width: 54% !important;
            max-height: 350px;
            min-height: 350px;
        }
        .main {
            min-height:0px !important;
            margin:0px !important;
        }
        .DivForBorder{
            border:1px solid black !important;
            height:370px  !important;
        }
        .DivForButton {
              border:1px solid black !important;
              height:40px !important;
        }
    </style>
</head>
<body style="-moz-user-select: none;">
    <div id="MathJax_Message" style="display: none; -moz-user-select: none;"></div>
    <form id="MainFormForExam" runat="server">
        <div class="page" style="-moz-user-select: none;">
            <div class="header" style="-moz-user-select: none;">
                <h1 style="-moz-user-select: none;"><span id="spantestname">Online Speed Test</span></h1>
            </div>
            <div class="main" style="-moz-user-select: none;">
                <div id="MainContentDiv" style="-moz-user-select: none;">
                    <div id="debug" style="-moz-user-select: none;"></div>
                    <div class="rightPanel" style="-moz-user-select: none;">
                        <div id="divTimePanel" style="-moz-user-select: none;">
                            <div id="remainingtime" style="-moz-user-select: none;">Time Remaining: <span id="spantimeremaining" style="color: red">40:39</span> Minutes</div>
                            <div id="currentuser" style="-moz-user-select: none;"><span id="candidatename">Amit Kumar Sharma</span></div>
                        </div>
                        <div id="divQuestionPalleteTitle" style="-moz-user-select: none;">
                            <div id="divQuestionPalleteSection" style="-moz-user-select: none;"></div>
                            <b style="-moz-user-select: none;">Question Palette:</b>
                        </div>
                        <div id="divQuestionPallete" style="-moz-user-select: none;">
                            <div class="PalleteButtons" style="-moz-user-select: none;">
                                <button id="btn0" class="ButtonNotAnswered" onclick="PalleteButtonClick(1);return false;" style="-moz-user-select: none;">1</button>
                            </div>
                        </div>
                        <div class="divLegend" style="-moz-user-select: none;">
                            <b style="-moz-user-select: none;">Legend:</b>
                            <br />
                            <table style="-moz-user-select: none;">
                                <tbody style="-moz-user-select: none;">
                                    <tr style="-moz-user-select: none;">
                                        <td style="-moz-user-select: none;">
                                            <button class="ButtonAnswered" style="-moz-user-select: none;" onclick="return false;"></button>
                                            Answered
                                        </td>
                                        <td style="-moz-user-select: none;">
                                            <button class="ButtonNotAnswered" style="-moz-user-select: none;" onclick="return false;"></button>
                                            Not Answered
                                        </td>
                                    </tr>
                                    <tr style="-moz-user-select: none;">
                                        <td style="-moz-user-select: none;">
                                            <button class="ButtonNotAnsweredMarked" style="-moz-user-select: none;" onclick="return false;"></button>
                                            Marked
                                        </td>
                                        <td style="-moz-user-select: none;">
                                            <button class="ButtonNotVisited" style="-moz-user-select: none;" onclick="return false;"></button>
                                            Not Visited
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="divQuestionFilter" style="-moz-user-select: none;">
                                Filter:
                                <select id="ddlQStatus">
                                    <option value="All" selected="selected" style="-moz-user-select: none;">All</option>
                                    <option value="ButtonNotVisited" style="-moz-user-select: none;">Not Visited</option>
                                    <option value="ButtonNotAnswered" style="-moz-user-select: none;">Not Answered</option>
                                    <option value="ButtonNotAnsweredMarked" style="-moz-user-select: none;">Marked For Review</option>
                                    <option value="ButtonAnswered" style="-moz-user-select: none;">Answered</option>
                                </select>
                            </div>
                        </div>
                        <div class="divRightpanelBottom" style="-moz-user-select: none;">
                            <button id="btnInstruction" class="RightPanelButton" >Instructions</button>
                            <button id="btnSubmit" class="RightPanelButton">Submit</button>
                        </div>
                    </div>
                    <div class="leftPanel" style="-moz-user-select: none;">
                        <div class="title" style="-moz-user-select: none;"><span id="spanrealtestname">ST-59 SBIPOPRE 2015</span></div>
                        <div id="Sections" class="Sections" style="display: block; -moz-user-select: none;">
                            <div id="divSections" style="-moz-user-select: none;">
                              
                            </div>
                        </div>
                        <div class="QuestionHeader" style="-moz-user-select: none; border: 1px solid">
                            <div class="QuestionNo" style="-moz-user-select: none;">
                                Question No.
                                <span id="lblQuestionNo" style="-moz-user-select: none;"></span>
                            </div>
                            <div class="Marks" style="-moz-user-select: none;">

                            </div>
                        </div>
                        <div class="clear"></div>
                        <br />
                        <br />
                        <div class="DivForBorder">
                        <div class="divPassage" style="-moz-user-select: none; display: block;">
                            <table class="Question">
                            </table>
                        </div>
                        <div class="DivQuestionAnswerOption">
                            <table class="QuestionAnswerOption">
                            </table>
                        </div>
                        </div>
                        <div class="clear"></div>
                        <div style="margin-bottom: 20px; margin-top: 10px" class="DivForButton">
                            <div style="padding: 10px; float: left; width: 70%">
                                <a id="btnMarkForReview" class="SecondaryButton" style="-moz-user-select: none;">Mark for Review & Next</a>
                                <a id="btnClearResponse" class="SecondaryButton" style="-moz-user-select: none;">Clear Response</a>
                                <span style="font-weight:bold;color:green">Version 1.0.0.0</span>
                            </div>
                            <div style="padding: 10px; float: right; width: 11%">
                                <a id="btnSaveAndNext" class="DefaultButton" style="-moz-user-select: none;">Save & Next</a>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div id="userInfo" class="hidden popup" style="-moz-user-select: none;">
                            <div id="instructionBlock" class="hidden popup" style="-moz-user-select: none;">
                                <div class="LangaugeSelection" style="-moz-user-select: none;">
                                    View In:
                                <select id="ddlLanguagesInst" name="ctl00$MainContent$ddlLanguagesInst">
                                    <option value="Eng" style="-moz-user-select: none;">English</option>
                                </select>
                                </div>
                            </div>
                            <div id="tsr" style="-moz-user-select: none;"></div>
                        </div>
                    </div>
                    <div class="clear" style="-moz-user-select: none;"></div>
                </div>
            </div>
            <div class="footer" style="-moz-user-select: none;"></div>
        </div>
        <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            var ActiveQid = 1, xmlDoc = '', xml = '', TableQuestion = '', CurrentQuestionRow = '', GivenAnserId = 0, GivenAnswerOfQuestionId = 0, Mode = 0, PreviousGivenAnswerId = 0, PreviouGivenAnserId = 1, TableModule = '', CurrentModuleRow = '';
            $(document).ready(function () {
                BindQuestinList();
                $('.PalleteButtons').find('button').click(function () {
                    GivenAnswerOfQuestionId = ActiveQid;
                    ActiveQid = $(this).attr('id');
                    TableQuestion.each(function () {
                        CurrentQuestionRow = $(this);
                        if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                            var TrForAppend = '', TrForAppendAnswer = '';
                            TrForAppend = '<tr><td>' + CurrentQuestionRow.find("Question").text() + '</td></tr>'
                            $(".Question").html(TrForAppend);
                            TrForAppendAnswer = '<tr><td>' + CurrentQuestionRow.find("AnswerOption").text() + '</td></tr>'
                            $(".QuestionAnswerOption").html(TrForAppendAnswer);
                            $('#lblQuestionNo').text(ActiveQid);
                            $('.Marks').html(CurrentQuestionRow.find("Marks").text());
                        }
                    });
                    if ($(this).attr('class') == 'ButtonAnswered' || $(this).attr('class') == 'ButtonNotAnsweredMarked') {
                        var TempQuestion = 0;
                        TableQuestion.each(function () {
                            CurrentQuestionRow = $(this);
                            if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                                TempQuestion = CurrentQuestionRow.find("QuestionId").text();
                            }
                        });
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "my-test.aspx/GetAnswer",
                            data: "{'Qid':'" + TempQuestion + "'}",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                $('#RadioButtonForQuestionOptioninput_' + data.d).prop('checked', true);
                            },
                            error: function (response) {
                                alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.'+ 
                                    'Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                            }
                        });
                    }
                    if (parseInt(ActiveQid) != parseInt(GivenAnswerOfQuestionId) && $('#' + GivenAnswerOfQuestionId + '').attr('class') != 'ButtonAnswered' && $('#' + GivenAnswerOfQuestionId + '').attr('class') != 'ButtonNotAnsweredMarked') {
                        if ($(this).attr('class') == 'ButtonNotVisited') {
                            $('#' + GivenAnswerOfQuestionId + '').removeClass();
                            $('#' + GivenAnswerOfQuestionId + '').addClass('ButtonNotAnswered');
                            SubmitAnswer();
                        }
                    }

                    return false;
                });
                $('.SubjectButton').click(function () {
                    $('.SubjectButton ').removeClass('subjectHilight');
                    $(this).addClass('subjectHilight');
                    var ModuleId, FirstQuestioIdfModuleId = 0;
                    GivenAnswerOfQuestionId = ActiveQid;
                    var ModuleId = $(this).attr('id');
                    TableQuestion.each(function () {
                        CurrentQuestionRow = $(this);
                        if (parseInt(ModuleId) == parseInt(CurrentQuestionRow.find("ModuleId").text())) {
                            var TrForAppend = '', TrForAppendAnswer = '';
                            TrForAppend = '<tr><td>' + CurrentQuestionRow.find("Question").text() + '</td></tr>'
                            $(".Question").html(TrForAppend);
                            TrForAppendAnswer = '<tr><td>' + CurrentQuestionRow.find("AnswerOption").text() + '</td></tr>'
                            $(".QuestionAnswerOption").html(TrForAppendAnswer);
                            FirstQuestioIdfModuleId = parseInt(CurrentQuestionRow.find("RowNumber").text());
                            $('#lblQuestionNo').text(FirstQuestioIdfModuleId);
                            $('.Marks').html(CurrentQuestionRow.find("Marks").text());
                            ActiveQid = FirstQuestioIdfModuleId;
                            var TempQuestion = 0;
                            TableQuestion.each(function () {
                                CurrentQuestionRow = $(this);
                                if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                                    TempQuestion = CurrentQuestionRow.find("QuestionId").text();
                                }
                            });
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "my-test.aspx/GetAnswer",
                                data: "{'Qid':'" + TempQuestion + "'}",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    $('#RadioButtonForQuestionOptioninput_' + data.d).prop('checked', true);
                                },
                                error: function (response) {
                                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.' +
                                        'Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                                }
                            });
                            return false;
                        }
                    });
                 return false;
                });
                $('input[type=radio]').live('change', function () {
                    $('input[type=radio]').prop('checked', false);
                    $(this).prop('checked', true);
                    GivenAnserId = $(this).val();
                });
                $('#btnClearResponse').click(function () {
                    $('input[type=radio]').prop('checked', false);
                    GivenAnserId = 0;
                    return false;
                });
                $('#btnMarkForReview').click(function () {
                    $('#' + ActiveQid + '').removeClass();
                    $('#' + ActiveQid + '').addClass('ButtonNotAnsweredMarked');
                    GivenAnswerOfQuestionId = ActiveQid;
                    ActiveQid = (parseInt(ActiveQid) + 1)
                    TableQuestion.each(function () {
                        CurrentQuestionRow = $(this);
                        if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                            var TrForAppend = '', TrForAppendAnswer = '';
                            TrForAppend = '<tr><td>' + CurrentQuestionRow.find("Question").text() + '</td></tr>'
                            $(".Question").html(TrForAppend);
                            TrForAppendAnswer = '<tr><td>' + CurrentQuestionRow.find("AnswerOption").text() + '</td></tr>'
                            $(".QuestionAnswerOption").html(TrForAppendAnswer);
                            $('.Marks').html(CurrentQuestionRow.find("Marks").text());
                            $('#lblQuestionNo').text(ActiveQid);
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "my-test.aspx/GetAnswer",
                                data: "{'Qid':'" + CurrentQuestionRow.find("QuestionId").text() + "'}",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    $('#RadioButtonForQuestionOptioninput_' + data.d).prop('checked', true);
                                },
                                error: function (response) {
                                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.' +
                                        'Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                                }
                            });
                        }
                    });
                    Mode = 3;
                    SubmitAnswer();
                    return false;
                });
                $('#btnSaveAndNext').click(function () {
                    GivenAnswerOfQuestionId = ActiveQid;
                    ActiveQid = (parseInt(ActiveQid) + 1)
                    TableQuestion.each(function () {
                        CurrentQuestionRow = $(this);
                        if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                            var TrForAppend = '', TrForAppendAnswer = '';
                            TrForAppend = '<tr><td>' + CurrentQuestionRow.find("Question").text() + '</td></tr>'
                            $(".Question").html(TrForAppend);
                            TrForAppendAnswer = '<tr><td>' + CurrentQuestionRow.find("AnswerOption").text() + '</td></tr>'
                            $(".QuestionAnswerOption").html(TrForAppendAnswer);
                            $('.Marks').html(CurrentQuestionRow.find("Marks").text());
                            $('#lblQuestionNo').text(ActiveQid);
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "my-test.aspx/GetAnswer",
                                data: "{'Qid':'" + CurrentQuestionRow.find("QuestionId").text() + "'}",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    $('#RadioButtonForQuestionOptioninput_' + data.d).prop('checked', true);
                                },
                                error: function (response) {
                                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.' +
                                        'Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                                }
                            });
                            return false;
                        }
                    });
                    if (parseInt(PreviouGivenAnserId) != 0 && parseInt(GivenAnserId) == 0 && $('#' + GivenAnswerOfQuestionId + '').attr('class') != 'ButtonAnswered' && $('#' + GivenAnswerOfQuestionId + '').attr('class') != 'ButtonNotAnsweredMarked') {
                        $('#' + GivenAnswerOfQuestionId + '').removeClass();
                        $('#' + GivenAnswerOfQuestionId + '').addClass('ButtonNotAnswered');
                        Mode = 2;
                        SubmitAnswer();
                    }
                    else if (parseInt(GivenAnserId) != 0) {
                        $('#' + GivenAnswerOfQuestionId + '').removeClass();
                        $('#' + GivenAnswerOfQuestionId + '').addClass('ButtonAnswered');
                        Mode = 1;
                        SubmitAnswer();
                    }
                });
                $('#ddlQStatus').change(function () {
                    $('#divQuestionPallete').find('button').css('display', 'block');
                    if ($(this).val() != 'All')
                    $('#divQuestionPallete').find('button').not('.'+$(this).val()+'').css('display', 'none');
                });
                $('#btnInstruction').click(function () {
                    alert('You Have Already Read All The Instruction Carefully.');
                    return false;
                });
                $('#btnSubmit').click(function () {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "my-test.aspx/SubmitExam",
                        data: "{}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 1) {
                                window.close();
                            }
                            else {
                                alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry. Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                            }
                        },
                        error: function (response) {
                            alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry. Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                        }
                    });
                });
                return false;
            });
            $(document).on('keydown', function (e) {
                e.preventDefault();
            });
            function BindQuestinList() {               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "my-test.aspx/BindQuestion",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        xmlDoc = $.parseXML(data.d);
                        xml = $(xmlDoc);
                        TableQuestion = xml.find("Table");
                        BindButton(parseInt(TableQuestion.length))
                        TableQuestion.each(function () {
                            CurrentQuestionRow = $(this);
                            if (parseInt(ActiveQid) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                                var TrForAppend = '', TrForAppendAnswer = '';
                                TrForAppend = '<tr><td>' + CurrentQuestionRow.find("Question").text() + '</td></tr>'
                                $(".Question").append(TrForAppend);
                                TrForAppendAnswer = '<tr><td>' + CurrentQuestionRow.find("AnswerOption").text() + '</td></tr>'
                                $(".QuestionAnswerOption").append(TrForAppendAnswer);
                                $('.Marks').html(CurrentQuestionRow.find("Marks").text());
                                $('#lblQuestionNo').text(ActiveQid);
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "my-test.aspx/GetAnswer",
                                    data: "{'Qid':'" + CurrentQuestionRow.find("QuestionId").text() + "'}",
                                    dataType: "json",
                                    async: false,
                                    success: function (data) {
                                        $('#RadioButtonForQuestionOptioninput_' + data.d).prop('checked', true);
                                    },
                                    error: function (response) {
                                        alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.' +
                                            'Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                                    }
                                });
                                BindGeneralDetails();
                                return false;
                            }
                        });
                        //For Bind Module Name Start Here
                        var ForAppendDiv=''
                        TableModule = xml.find("Table1");
                        TableModule.each(function () {
                            CurrentModuleRow = $(this);
                            ForAppendDiv = ForAppendDiv+'<a id="' + CurrentModuleRow.find("ModuleId").text() + '" class="SubjectButton">' + CurrentModuleRow.find("ModuleName").text() + '</a>';
                        });
                        $('#divSections').html(ForAppendDiv);
                        ForAppendDiv = '';
                        //For Bind Module Name End Here
                    },
                    error: function (response) {
                        alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry. Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                    }
                });
            }
            function BindButton(Length) {
                $('.PalleteButtons').html('');
                TableQuestion.each(function () {
                    CurrentQuestionRow = $(this);
                    $('.PalleteButtons').append('<button id="' + CurrentQuestionRow.find("RowNumber").text() + '" class="' + CurrentQuestionRow.find("ButtonClass").text() + '" style="-moz-user-select: none;">' + CurrentQuestionRow.find("RowNumber").text() + '</button>')
                });
            }
            function BindGeneralDetails() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "my-test.aspx/BindGeneralDetails",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var xmlDocGeneralDetails = $.parseXML(data.d);
                        var xmlGeneralDetails = $(xmlDocGeneralDetails);
                        var TableGeneralDetails = xmlGeneralDetails.find("Table");
                        TableGeneralDetails.each(function () {
                            var CurrentDeailsRow = $(this);
                            $('#spanrealtestname').text(CurrentDeailsRow.find("Examname").text());
                            $('#candidatename').text(CurrentDeailsRow.find("CandidateName").text());
                            $('#spantimeremaining').text(CurrentDeailsRow.find("TimeRemainning").text());
                            $('#spantestname').text(CurrentDeailsRow.find("Institutionname").text());
                        });
                        UpdateTimer();
                    },
                    error: function (response) {
                        alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry. Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                    }
                });
            }
            function SubmitAnswer() {
                var TempQuestion = 0, TempQuestionIdForBind = 0;
                    TableQuestion.each(function () {
                        CurrentQuestionRow = $(this);
                        if (parseInt(GivenAnswerOfQuestionId) == parseInt(CurrentQuestionRow.find("RowNumber").text())) {
                            TempQuestion = CurrentQuestionRow.find("QuestionId").text();
                        }
                    });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "my-test.aspx/SubmitAnswer",
                    data: "{'GivenAnserId':'" + GivenAnserId + "','GivenAnswerOfQuestionId':'" + TempQuestion + "','Mode':'" + Mode + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (parseInt(GivenAnserId) != 0) {
                            PreviouGivenAnserId = GivenAnserId;
                        }
                        GivenAnserId = 0;
                    },
                    error: function (response) {
                        if (parseInt(GivenAnserId) != 0) {
                            PreviouGivenAnserId = GivenAnserId;
                        }
                        GivenAnserId = 0;
                        alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry. Close This Window And Login Again, Questions You Have Answered Will Be Preserved.');
                    }
                });
            }
            function UpdateTimer() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "my-test.aspx/GetTimer",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var xmlTimer = $.parseXML(data.d);
                        var xmlDoc = $(xmlTimer);
                        var TableTimer = xmlDoc.find("Table");
                        TableTimer.each(function () {
                            var CurrentTmerRow = $(this);
                            if (CurrentTmerRow.find("TimeRemainning").text() == 'Time Over') {
                                alert('Your Time Over Your Test Will Automatically Submited.');
                                window.close();
                                return false;
                            }
                            $('#spantimeremaining').text(CurrentTmerRow.find("TimeRemainning").text());
                        });
                        setTimeout(
                        function () {
                        UpdateTimer();
                        }, 1000);
                    },
                    error: function (response) {
                        alert('Network Issue Occur Sorry For That.')
                    }
                });
            }
        </script>
    </form>
</body>
</html>