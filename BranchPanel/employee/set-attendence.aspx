﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="set-attendence.aspx.cs" Inherits="BranchPanel_set_attendence" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/BranchPanel/employee/attendance-management.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .drop-down-intime {
            box-shadow: 2px 2px 5px 0px rgba(50, 50, 50, 0.35);
            background: none repeat scroll 0 0 #F0F0F0;
            border: 1px solid #ddd;
            position: absolute;
            width: 140px;
            z-index: 2147483647;
            height: 140px !important;
            border: 2px solid;
            border-bottom-left-radius: 2em;
            border-bottom-right-radius: 2em;
            border-top-left-radius: 2em;
            border-top-right-radius: 2em;
        }

            .drop-down-intime input[type=image] {
                width: 40px !important;
            }

        .drop-down-minus-style-intime {
            display: block;
            position: absolute;
            z-index: 999999999999;
            margin-top: 8px !important;
            margin-bottom: 5px !important;
            margin-left: 8px !important;
        }

        .drop-down-outtime {
            box-shadow: 2px 2px 5px 0px rgba(50, 50, 50, 0.35);
            background: none repeat scroll 0 0 #F0F0F0;
            border: 1px solid #ddd;
            position: absolute;
            width: 140px;
            z-index: 2147483647;
            height: 140px !important;
            border: 2px solid;
            border-bottom-left-radius: 2em;
            border-bottom-right-radius: 2em;
            border-top-left-radius: 2em;
            border-top-right-radius: 2em;
        }

            .drop-down-outtime input[type=image] {
                width: 40px !important;
            }

        .drop-down-minus-style-outtime {
            display: block;
            position: absolute;
            z-index: 999999999999;
            margin-top: 8px !important;
            margin-bottom: 5px !important;
            margin-left: 7px !important;
        }

        .lblforclass {
            padding-left: 40px !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender a {
            cursor: pointer !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender th {
            background-color: #003d00;
            color: white !important;
            font-size: 20px !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender {
            border: 2px solid #CDCDCD !important;
        }

        .activesetattendance {
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

        #contentPane {
            min-height: 440px !important;
        }

        .timepickerintime, .timepickerouttime {
            padding-left: 5px !Important;
            padding-top: 2px !Important;
            padding-bottom: 2px !Important;
            width: 75px !important;
            border: 1px solid #ABADB3 !important;
        }

        .divhour {
            background: url(../../images/arrow.png) no-repeat;
        }

        .HOUR {
            float: left;
            margin-left: 5px !important;
            width: 30px !important;
            height: 22px !important;
            padding: 2px 2px 2px 5px;
            font-weight: bold;
            font-size: 25px !important;
        }

        .MINUTE {
            float: left;
            margin-left: 5px !important;
            width: 30px !important;
            height: 22px !important;
            padding: 2px 2px 2px 5px;
            font-weight: bold;
            font-size: 25px !important;
        }

        .AMPM {
            float: left;
            margin-left: 5px !important;
            width: 35px !important;
            height: 22px !important;
            padding: 2px 2px 2px 2px;
            font-weight: bold;
            font-size: 22px !important;
            text-transform: uppercase;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <script type="text/javascript" src="../../js/jquery.mousewheel.min.js"></script>
    <script type="text/javascript" src="../../js/increment.js"></script>
    <script type="text/javascript">
        var DateTxt = "", markasabsent = "0", intime = "", outtime = "", empno = "", year = "", month = "", Day = "", txtvalue = "", colorstatus = "";
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }

        function BindClassByJquery() {
            $(".divforappendintime").append("<div id='PnlCust' class='chklistboxID'><input type='text' class='HOUR' value='09'></input><input type='text' class='MINUTE' value='30'></input><input type='text' class='AMPM' value='AM'></input></div>")
            $(".divforappendouttime").append("<div id='PnlCust' class='chklistboxID'><input type='text' class='HOUR' value='07'></input><input type='text' class='MINUTE' value='30'></input><input type='text' class='AMPM' value='PM'></input></div>")
        }

        function pageLoad() {
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            ChangeCalenderColor();
            BindClassByJquery();

            document.title = 'Set Attendance Manually';
        }

        //For Change The Backgroud Color Of Every Tr According To The Condition
        function ChangeCalenderColor() {
            $('#ctl00_ContentPlaceHolder1_Grid_Calender td').each(function () {
                if ($(this).find('a span').attr('class') == "red") {
                    $(this).css("background-color", "#9D0000");
                    $(this).find('a span').css("font-size", "20px");
                    $(this).find('a span').css("color", "white");
                }
                else if ($(this).find('a span').attr('class') == "green") {
                    $(this).css("background-color", "#005600");
                    $(this).find('a span').css("font-size", "20px");
                    $(this).find('a span').css("color", "white");
                }
                else if ($(this).find('a span').attr('class') == "orange") {
                    $(this).css("background-color", "#D08700");
                    $(this).find('a span').css("font-size", "20px");
                    $(this).find('a span').css("color", "white");
                }
                else if ($(this).find('a span').attr('class') == "none") {
                    $(this).css("background-color", "white");
                    $(this).find('a span').css("font-size", "20px");
                    $(this).find('a span').css("color", "red");
                }
                else if ($(this).find('a span').attr('class') == "black") {
                    $(this).css("background-color", "white");
                    $(this).find('a span').css("font-size", "20px");
                    $(this).find('a span').css("color", "black");
                }
                else {
                    $(this).css("background-color", "white");
                }
            });
        }

        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_Grid_Calender a').click(function () {
                //For Mark Green Which is Currently Clicked
                ChangeCalenderColor();
                $(this).parent('td').css("background-color", "#005600");
                $(this).parent('td').find('span').css("color", "white");
                year = $('#ctl00_ContentPlaceHolder1_ddlyear').val();
                month = $('#ctl00_ContentPlaceHolder1_ddlmonth').val();
                Day = $(this).parent('td').find('input').val();
                var ClickedDate = new Date();
                ClickedDate.setFullYear(year, (month - 1), Day);
                var CurrentDate = new Date();
                if (ClickedDate > CurrentDate) {
                    alertify.error('You can not take attendance in advance.');
                    return false;
                }
                if (parseInt(month) <= 9) {
                    month = '0' + month;
                }
                DateTxt = year + '-' + month + '-' + Day
                alertify.confirm("Are you sure you want to take attendence of Date: " + (Day + '/' + month + '/' + year + ' .'), function (e) {
                    if (e) {
                        SetAttendance();
                    } else {
                        return false;
                    }
                });
            });

            $('#ctl00_ContentPlaceHolder1_ddlyear').change(function () {
                year = $(this).val();
                month = $('#ctl00_ContentPlaceHolder1_ddlmonth').val();
                DatePicker();
                ChangeCalenderColor();
            })

            $('#ctl00_ContentPlaceHolder1_ddlmonth').change(function () {
                year = $('#ctl00_ContentPlaceHolder1_ddlyear').val();
                month = $(this).val();
                DatePicker();
                ChangeCalenderColor();
            })
            $('.lbtnabsent').click(function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $(this).parent('td').parent('tr').css("background-color", "#9D0000");
                $(this).parent('td').css("background-color", "white");
                $(this).parent('td').parent('tr').find('span').css("color", "white");
                $(this).parent('td').parent('tr').find('a').css("color", "white");
                $(this).parent('td').parent('tr').find('input').css("color", "#9D0000");
                markasabsent = "1";
                intime = $(this).parents("tr").find(".timepickerintime").val()
                outtime = $(this).parents("tr").find(".timepickerouttime").val()
                empno = $(this).parent("td").find("input[type='hidden']").val();
                UpdateAttendance();
                return false;
            });

            $('.lbtnedit').click(function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $('.lbtnedit').css("display", "block");
                $('.lbtnupdate').css("display", "none");
                $('.lbtncancel').css("display", "none");
                $(this).parent('td').find('.lbtnedit').css("display", "none");
                $(this).parent('td').find('.lbtnupdate').css("display", "block");
                $(this).parent('td').find('.lbtncancel').css("display", "block");
                return false;
            });

            // Management Of Time Picker start here

            $('.timepickerintime').live("click", function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $(this).parent('td').find('div').css("display", "block");
            });
            $('.timepickerintime').live("focus", function () {
                $(this).css("border", "2px solid green");
            });
            $('.timepickerintime').live("blur", function () {
                $(this).css("border", "1px solid #ABADB3");
            });

            $('.timepickerouttime').live("click", function () {
                $('.drop-down-outtime').css("display", "none");
                $('.drop-down-intime').css("display", "none");
                $(this).parent('td').find('div').css("display", "block");
            });
            $('.timepickerouttime').live("focus", function () {
                $(this).css("border", "2px solid green");
            });
            $('.timepickerouttime').live("blur", function () {
                $(this).css("border", "1px solid #ABADB3");
            });

            //For Managing In Time Start Here
            var txttimefortextbox = "", txttimeclass = "";
            $('.imgplushourintime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val();
                if (parseInt(getintimehour) < 12) {
                    getintimehour = parseInt(getintimehour) + 1;
                }
                else if (parseInt(getintimehour) == 12) {
                    getintimehour = "1";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').find('.chklistboxID ').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusminutintime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val();
                if (parseInt(getintimeminute) < 59) {
                    getintimeminute = parseInt(getintimeminute) + 1;
                }
                else if (parseInt(getintimeminute) == 59) {
                    getintimeminute = "0";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusampmintime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').find('.chklistboxID ').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').find('.chklistboxID ').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });

            $('.imgsubhourintime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.HOUR').val();
                if (parseInt(getintimehour) >= 2) {
                    getintimehour = parseInt(getintimehour) - 1;
                }
                else if (parseInt(getintimehour) == 1) {
                    getintimehour = "12";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubminutintime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.MINUTE').val();
                if (parseInt(getintimeminute) > 0) {
                    getintimeminute = parseInt(getintimeminute) - 1;
                }
                else if (parseInt(getintimeminute) == 0) {
                    getintimeminute = "59";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubampmintime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').parent('div').find('.divforappendintime').find('div').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerintime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });

            $('.imgplushourouttime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val();
                if (parseInt(getintimehour) < 12) {
                    getintimehour = parseInt(getintimehour) + 1;
                }
                else if (parseInt(getintimehour) == 12) {
                    getintimehour = "1";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').find('.chklistboxID ').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusminutouttime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val();
                if (parseInt(getintimeminute) < 59) {
                    getintimeminute = parseInt(getintimeminute) + 1;
                }
                else if (parseInt(getintimeminute) == 59) {
                    getintimeminute = "0";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgplusampmouttime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').find('.chklistboxID ').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').find('.chklistboxID ').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });

            $('.imgsubhourouttime').live("click", function () {
                var getintimehour = 0;
                getintimehour = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.HOUR').val();
                if (parseInt(getintimehour) >= 2) {
                    getintimehour = parseInt(getintimehour) - 1;
                }
                else if (parseInt(getintimehour) == 1) {
                    getintimehour = "12";
                }
                if (parseInt(getintimehour) <= 9)
                    getintimehour = '0' + getintimehour;
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.HOUR').val(getintimehour);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubminutouttime').live("click", function () {
                var getintimeminute = 0;
                getintimeminute = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.MINUTE').val();
                if (parseInt(getintimeminute) > 0) {
                    getintimeminute = parseInt(getintimeminute) - 1;
                }
                else if (parseInt(getintimeminute) == 0) {
                    getintimeminute = "59";
                }
                if (parseInt(getintimeminute) <= 9)
                    getintimeminute = '0' + getintimeminute;
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.MINUTE').val(getintimeminute);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.imgsubampmouttime').live("click", function () {
                var getintimeampm = "";
                getintimeampm = $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.AMPM').val();
                if (getintimeampm == "PM") {
                    getintimeampm = "AM"
                }
                else if (getintimeampm == "AM") {
                    getintimeampm = "PM"
                }
                $(this).parent('div').parent('div').find('.divforappendouttime').find('div').find('.AMPM').val(getintimeampm);
                txttimefortextbox = $(this).parent('div').parent('div').find('.chklistboxID ').find('.HOUR').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.MINUTE').val() + ' : ' + $(this).parent('div').parent('div').find('.chklistboxID ').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('td').find('.timepickerouttime').val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });

            $('.HOUR').live("change", function () {
                var temphour = "";
                if ($.isNumeric($(this).parent('div').find('.HOUR').val()) == false) {
                    $(this).parent('div').find('.HOUR').val('09');
                }
                if (parseInt($(this).parent('div').find('.HOUR').val()) > 12) {
                    $(this).parent('div').find('.HOUR').val('09');
                    return false;
                }
                if (parseInt($(this).parent('div').find('.HOUR').val()) < 10) {
                    temphour = '0' + $(this).parent('div').find('.HOUR').val();
                    $(this).parent('div').find('.HOUR').val(temphour);
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.MINUTE').live("change", function () {
                var tempminute = "";
                if ($.isNumeric($(this).parent('div').find('.MINUTE').val()) == false) {
                    $(this).parent('div').find('.MINUTE').val('30');
                }
                if (parseInt($(this).parent('div').find('.MINUTE').val()) > 59) {
                    $(this).parent('div').find('.MINUTE').val('30');
                }
                if (parseInt($(this).parent('div').find('.MINUTE').val()) < 10) {
                    tempminute = '0' + $(this).parent('div').find('.MINUTE').val();
                    $(this).parent('div').find('.MINUTE').val(tempminute);
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });
            $('.AMPM').live("change", function () {
                if ($(this).parent('div').find('.AMPM').val() != "AM" || $(this).parent('div').find('.AMPM').val() != "PM") {
                    $(this).parent('div').find('.AMPM').val('AM');
                }
                if ($(this).parent('div').parent('div').attr('class') == "divforappendintime") {
                    txttimeclass = '.timepickerintime';
                }
                else {
                    txttimeclass = ".timepickerouttime";
                }
                txttimefortextbox = $(this).parent('div').find('.HOUR').val() + ' : ' + $(this).parent('div').find('.MINUTE').val() + ' : ' + $(this).parent('div').find('.AMPM').val().toUpperCase();
                $(this).parent('div').parent('div').parent('div').parent('td').find(txttimeclass).val(txttimefortextbox);
                txttimefortextbox = "";
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_gvdetails tr td:lt(4)').click(function () {
                $('.drop-down-outtime').css("display", "none");
                $('.drop-down-intime').css("display", "none");
            });
            $('#ctl00_ContentPlaceHolder1_gvdetails tr td:gt(5)').click(function () {
                $('.drop-down-outtime').css("display", "none");
                $('.drop-down-intime').css("display", "none");
            });

            //For Managing Out Time Start Here

            // Management Of Time Picker End Here

            $('.lbtnupdate').click(function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                markasabsent = "0", colorstatus = "";
                intime = $(this).parents("tr").find(".timepickerintime").val()
                outtime = $(this).parents("tr").find(".timepickerouttime").val()
                empno = $(this).parents("tr").find("input[type='hidden']").val();
                UpdateAttendance();
                if (colorstatus != "") {
                    if (colorstatus == "1") {
                        alertify.success("Your intime and outtime updated.");
                        $(this).parent('td').parent('tr').css("background-color", "green");
                        $(this).parent('td').parent('tr').find('input').css("color", "green");
                        call_progressbar("end");
                    }
                    if (colorstatus == "3") {
                        alertify.success("You marked as a half day.");
                        $(this).parent('td').parent('tr').css("background-color", "#FF9400");
                        $(this).parent('td').parent('tr').find('input').css("color", "#FF9400");
                        call_progressbar("end");
                    }
                    if (colorstatus == "4") {
                        alertify.success("You marked as a late.");
                        $(this).parent('td').parent('tr').css("background-color", "#006AFF");
                        $(this).parent('td').parent('tr').find('input').css("color", "#006AFF");
                        call_progressbar("end");
                    }
                    $(this).parent('td').parent('tr').find('span').css("color", "white");
                    $(this).parent('td').parent('tr').find('a').css("color", "white");
                    return false;
                }
            });
            $('.lbtncancel').click(function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                $('.lbtnedit').css("display", "block");
                $('.lbtnupdate').css("display", "none");
                $('.lbtncancel').css("display", "none");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnclose').click(function () {
                $('.drop-down-intime').css("display", "none");
                $('.drop-down-outtime').css("display", "none");
                alertify.confirm("Are you sure you want to take Close The Date: " + (Day + '/' + month + '/' + year + ' .If You Close Once You Can Not Edit It.So Watch Out Once Again.'), function (e) {
                    if (e) {
                        CloseDay();
                    } else {
                        return false;
                    }
                });
            });
        });

        function DatePicker() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/BindDbDatePicker",
                data: "{'month':'" + month + "','year':'" + year + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=Grid_Calender] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=Grid_Calender] tr:eq(1)").clone(true);
                            $("[id$=Grid_Calender]").append(row);
                            $(row).find('.Sun').html(data.d[i].sun);
                            $(row).find('.Mon').html(data.d[i].mon);
                            $(row).find('.Tue').html(data.d[i].tue);
                            $(row).find('.Wed').html(data.d[i].wed);
                            $(row).find('.Thu').html(data.d[i].thu);
                            $(row).find('.Fri').html(data.d[i].fri);
                            $(row).find('.Sat').html(data.d[i].sat);
                            //For Bind Hidden Field
                            $(row).find("input[type=hidden][id*=hfsunday]").val(data.d[i].hfsun);
                            $(row).find("input[type=hidden][id*=hfmonday]").val(data.d[i].hfmon);
                            $(row).find("input[type=hidden][id*=hftuesday]").val(data.d[i].hftue);
                            $(row).find("input[type=hidden][id*=hfwednesday]").val(data.d[i].hfwed);
                            $(row).find("input[type=hidden][id*=hfthrsday]").val(data.d[i].hfthu);
                            $(row).find("input[type=hidden][id*=hffriday]").val(data.d[i].hffri);
                            $(row).find("input[type=hidden][id*=hfsaturday]").val(data.d[i].hfsat);
                        }

                        $("[id*=Grid_Calender] tr").show();
                        $("[id*=Grid_Calender] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function CloseDay() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/CloseDay",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Attendance closed sucessfully.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        $('.lbtnabsent').css("display", "none");
                        $('.lbtncancel').css("display", "none");
                        $('.lbtnupdate').css("display", "none");
                        $('.lbtnedit').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'none');
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }

        function SetAttendance() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/InsertAttendance",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Attendance Taken Sucessfully.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        BindGrid();
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'block');
                    }

                    if (data.d == 2) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alertify.error("Attendance has already taken");
                    }

                    if (data.d == 3) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alertify.error("Today is weekly off.");
                    }

                    if (data.d == 4) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alertify.error("Today is holiday");
                    }

                    if (data.d == 5) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alertify.error("Today is holiday & as well weekly off.");
                    }

                    if (data.d == 6) {
                        alertify.error("Attendance has already taken but you did not close the day so please close day.");
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "block");
                        BindGrid();
                        $('#ctl00_ContentPlaceHolder1_btntakeattendance').css('display', 'none');
                        $('#ctl00_ContentPlaceHolder1_btnclose').css('display', 'block');
                    }
                    if (data.d == 7) {
                        $("#ctl00_ContentPlaceHolder1_trgrid").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid").css("display", "none");
                        alertify.error("Please First Register atleast One Teacher .");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }

        function UpdateAttendance() {
            call_progressbar("start");
            $(".chkabsent").prop('disabled', true);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/UpdateAttendance",
                async: false,
                data: "{'Date':'" + DateTxt + "','eid':'" + empno + "','intime':'" + intime + "','outtime':'" + outtime + "','absent':'" + markasabsent + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        call_progressbar("end");
                        markasabsent = "0", intime = "", outtime = "", empno = "";
                        colorstatus = "1";
                    }
                    if (data.d == 2) {
                        alertify.success("You marked as a absent.");
                        call_progressbar("end");
                    }
                    if (data.d == 3) {
                        call_progressbar("end");
                        markasabsent = "0", intime = "", outtime = "", empno = "";
                        colorstatus = "3";
                    }
                    if (data.d == 4) {
                        call_progressbar("end");
                        markasabsent = "0", intime = "", outtime = "", empno = "";
                        colorstatus = "4";
                    }
                    markasabsent = "0", intime = "", outtime = "", empno = "";
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }

        function BindGrid() {
            call_progressbar("start");
            $('.lbtnabsent').css("display", "block");
            $('.lbtnedit').css("display", "block");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "set-attendence.aspx/BindDatatable",
                data: "{'Date':'" + DateTxt + "'}",
                dataType: "json",
                success: function (data) {
                    $("[id*=gvdetails] tr:gt(1)").remove();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find(".Number").html(data.d[i].Number);
                            $(row).find(".DesignationDepartment").html(data.d[i].DesignationDepartment);
                            $(row).find(".EmpNo").html(data.d[i].Emp_No);
                            $(row).find(".EmpName").html(data.d[i].Name);
                            var intime = data.d[i].intime;
                            $(row).find(".timepickerintime").val(data.d[i].intime);
                            $(row).find(".timepickerouttime").val(data.d[i].outtime);
                            $(row).find("td input[type=hidden]").val(data.d[i].eid);
                        }
                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                }
            });
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Attendance Management</a></li>
            <li style="background: none;"><a class="active" href="#">Set Attendance Manually</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="margin-bottom: 50px ! important; margin-top: 30px !important; background-color: #F7F7F7; height: auto !important;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <div class="for_sigle_row_form" style="background-color: #CDCDCD !important; width: 300px !important; float: left !important; margin-left: 0px !important;">
                            <asp:DropDownList ID="ddlyear" runat="server" Style="width: 120px !important; height: 25px !important; padding: 2px 2px 2px 20px !important; border: 2px solid #007ACC !important; margin-left: 10px !important;">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlmonth" runat="server" Style="width: 120px !important; height: 25px !important; padding: 2px 2px 2px 20px !important; border: 2px solid #007ACC !important;">
                            </asp:DropDownList>
                        </div>
                        <div style="margin-left: 50px; margin-top: 4px !important;">
                            <div style="height: 15px; width: 80px; text-align: center; background-color: #CDCDCD; margin-left: 10Px; color: black; padding: 5px; font-weight: bold; float: left">Indicators</div>
                            <div style="height: 15px; width: 90px; text-align: center; background-color: #D08700; margin-left: 10Px; color: white; padding: 5px; float: left">Not Locked</div>
                            <div style="height: 15px; width: 80px; text-align: center; background-color: #9D0000; margin-left: 10Px; color: white; padding: 5px; float: left">Not Taken</div>
                            <div style="height: 15px; width: 100px; text-align: center; background-color: #005600; margin-left: 10Px; color: white; padding: 5px; float: left">Taken & Locked</div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:GridView runat="server" ID="Grid_Calender" ShowHeader="true" AutoGenerateColumns="false"
                            Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Sunday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblsunday" runat="server" Text='<%# Eval("Sun") %>' CssClass="Sun" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hfsunday" runat="server" Value='<%# Eval("HfSun") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblmonday" runat="server" Text='<%# Eval("Mon") %>' CssClass="Mon" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hfmonday" runat="server" Value='<%# Eval("HfMon") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Tuesday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbltuesday" runat="server" Text='<%# Eval("Tue") %>' CssClass="Tue" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hftuesday" runat="server" Value='<%# Eval("HfTue") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Wednesday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblwednesday" runat="server" Text='<%# Eval("Wed") %>' CssClass="Wed" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hfwednesday" runat="server" Value='<%# Eval("HfWed") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Thursday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblthrsday" runat="server" Text='<%# Eval("Thr") %>' CssClass="Thu" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hfthrsday" runat="server" Value='<%# Eval("HfThr") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Friday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblfriday" runat="server" Text='<%# Eval("Fri") %>' CssClass="Fri" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hffriday" runat="server" Value='<%# Eval("HfFri") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Saturday" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblsaturday" runat="server" Text='<%# Eval("Sat") %>' CssClass="Sat" Enabled="false"></asp:LinkButton>
                                        <asp:HiddenField ID="hfsaturday" runat="server" Value='<%# Eval("HfSat") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div id="divProgressBar" class="progress"></div>
                    </td>
                </tr>
            </table>
            <div id="divgrid" runat="server" style="display: block; margin-bottom: 150px !important;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">

                    <tr id="trgrid" runat="server" style="display: block">
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                                Width="100%" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="50px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("Number") %>' CssClass="Number"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="80px" HeaderText="emp-code" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdType" runat="server" Text='<%# Eval("Emp_No") %>' CssClass="EmpNo"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="270px" HeaderText="Emp Name" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNoOfClicks" runat="server" Text='<%# Eval("Name") %>' CssClass="EmpName"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="350px" HeaderText="Designation/Departmrnt" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldesignationdepartment" runat="server" Text='<%# Eval("DesignationDepartment") %>' CssClass="DesignationDepartment"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="70px" HeaderText="In Time" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtintimetimepicer" class="timepickerintime" Text='<%# Eval("intime") %>' runat="server" ReadOnly="true"></asp:TextBox>
                                            <div class="drop-down-intime" style="display: none">
                                                <div class="divforappendintime">
                                                    <asp:ImageButton ID="imgplushourintime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplushourintime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgplusminutintime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplusminutintime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgplusampmintime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplusampmintime"></asp:ImageButton>
                                                    <br />
                                                </div>
                                                <br />
                                                <div class="drop-down-minus-style-intime">
                                                    <asp:ImageButton ID="imgsubhourintime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubhourintime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgsubminutintime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubminutintime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgsubampmintime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubampmintime"></asp:ImageButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="70px" HeaderText="Out Time" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtouttimepicer" ReadOnly="true" runat="server" Text='<%# Eval("outtime") %>' CssClass="timepickerouttime"></asp:TextBox>
                                            <div class="drop-down-outtime" style="display: none">
                                                <div class="divforappendouttime">
                                                    <asp:ImageButton ID="imgplushourouttime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplushourouttime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgplusminutouttime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplusminutouttime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgplusampmouttime" runat="server" ImageUrl="~/images/add.png" CssClass="imgplusampmouttime"></asp:ImageButton>
                                                    <br />
                                                </div>
                                                <br />
                                                <div class="drop-down-minus-style-outtime">
                                                    <asp:ImageButton ID="imgsubhourouttime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubhourouttime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgsubminutouttime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubminutouttime"></asp:ImageButton>
                                                    <asp:ImageButton ID="imgsubampmouttime" runat="server" ImageUrl="~/images/subb.png" CssClass="imgsubampmouttime"></asp:ImageButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="80px" HeaderText="Absent" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Image ID="lbtnabsent" runat="server" Width="16px" ImageUrl="~/images/no.png" Style="cursor: pointer !important;" CssClass="lbtnabsent" OnClientClick="return false;"></asp:Image>
                                            <asp:HiddenField ID="hfidforupdate" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="120px" HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Image ID="lbtnedit" runat="server" Width="16px" ImageUrl="~/images/edit.gif" Style="cursor: pointer !important;" CssClass="lbtnedit" OnClientClick="return false;"></asp:Image>
                                            <asp:Image ID="lbtnupdate" runat="server" Width="16px" ImageUrl="~/images/update.png" Style="cursor: pointer !important; display: none; float: left; margin-left: 20px ! important; margin-right: 5px !important;" CssClass="lbtnupdate" OnClientClick="return false;"></asp:Image>
                                            <asp:Image ID="lbtncancel" runat="server" Width="16px" ImageUrl="~/images/ic.png" Style="cursor: pointer !important; display: none; float: left" CssClass="lbtncancel" OnClientClick="return false;"></asp:Image>
                                        </ItemTemplate>
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
                <div class="for_sigle_row_form" style="margin-bottom: 5px !important">
                    <label style="padding-top: 7px;">
                    </label>
                    <asp:Button ID="btnclose" runat="server" Text="Close Day" CssClass="button2" Style="width: 124px; cursor: pointer; display: none" OnClientClick="return false;" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>