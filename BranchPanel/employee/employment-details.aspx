<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="employment-details.aspx.cs" Inherits="branchpanel_employee_employment_details" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

  <%--  <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script src="../../js/jquery.com-ui-1.10.0-jquery-ui.js" type="text/javascript"></script>
    <script src="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <%--libraries for content editor

    <link href="../../js/html-editor/editor-style.css" rel="stylesheet" />
   <script src="../../js/MyCustomJS.js" type="text/javascript"></script>
    <script src="../../js/html-editor/ckeditor.js" type="text/javascript"></script>--%>

    <style type="text/css">
        .stm_head {
            background-color: #56CCBC !important;
            color: white !important;
        }

        .alertify {
            z-index: 2147483647 !important;
        }

        .employmentdetail {
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

        #ctl00_ContentPlaceHolder1_lbtnchnagestatus {
            margin-left: 30px !important;
            color: red !important;
            font-size: 15px !important;
            font-family: arial !important;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_lbtnedit {
            color: blue !important;
            font-size: 15px !important;
            font-family: arial !important;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_lbtnappraisal {
            margin-left: 30px !important;
            color: green !important;
            font-size: 15px !important;
            font-family: arial !important;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_lbtnprevioushistory {
            margin-left: 30px !important;
            color: blue !important;
            font-size: 15px !important;
            font-family: arial !important;
            font-weight: bold;
        }

        .textfocus {
            border: solid 1px #99cc00 !important;
            box-shadow: 0 0 5px 1px #bce0fe !important;
        }

        .texthover {
            border: solid 1px red !important;
        }

        .separator {
            display: block;
            height: 2px;
            background-color: #E6E6E6;
            margin: 10px 0 15px;
        }

        .t1 {
            height: 30px!important;
            padding-top: 15px!important;
            font-size: 12px !important;
            font-weight: bold!important;
            padding-left: 25px!important;
            text-align: left !important;
        }

        .t2 {
            height: 30px!important;
            padding-top: 5px!important;
            font-size: 12px !important;
            text-align: left !important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 40px!important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
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

        .showpopup td {
            vertical-align: top;
            color: #666666;
        }

        .showpopup2 {
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
            width: 40%;
            z-index: 2147483647;
        }

        .showpopup3 {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 20%;
            left: 15%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 70%;
            z-index: 21474836475544554;
        }

        .forlabel label {
            float: none;
    margin-left: -32px !important;
    margin-top: -15px;

        }

        .changecolor {
            border: solid 2px #008060 !important;
        }

        .changecolor2 {
            border: solid 2px #0032FB !important;
        }

        .removeclass {
            border: solid 1px #CCCCCC !important;
        }

        .runtimediv {
            background-color: #F7F7F7;
            width: 100%;
            margin-top: 10px;
            padding-bottom: 50px;
            height: 15px!important;
        }

        .runtimelnkbtn {
            color: #006eb8 !important;
            font-size: 13pt;
            font-weight: bold;
            margin-left: 3px;
            padding-bottom: 50px;
            height: 15px!important;
            pointer-events: none;
        }

        .runtimelable {
            display: none;
            height: 25px;
        }

        .runtimelable1 {
            display: none;
            height: 25px;
        }

        .cke_path_item {
            display: none!important;
        }

        .cke_path cke_1_toolbox {
            display: none!important;
        }

        .cke_1_toolbox {
            display: none!important;
        }
    </style>

    <script type="text/javascript">
        var status = "", comment = "", suspensiondate = "", resumptiondate = "", terminationdate = "", noticePeriodDate = "", noofdaysinnoticeperiod = "", workingDate = "", leavedate = "";
        var cid = "0", sid = "0", bindcountryfrom = 0, annualctc = 0, roll = 0, currentstatus = "", isvalidate = "0", deptid = 0, designationid = 0, branchid = 0, typeofemployement = 0,
            probationperiod = 0, annual_ctc = 0, inhandsalary = 0, Datefrom = "", DateTo = "", methodtype = 0, pancardno = "",
            doi = "", doj = "", ctcappliedfrom = "", tdsaccountno = "", officeemailid = "", hrname = "", deptname = "", did = "", subject = "", msg = "";

        function IsValidate() {
            if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == "0") {
                alertify.error("Select Status please.");
                return false;
                isvalidate = "1";
            }

            if ($('#ctl00_ContentPlaceHolder1_txtyourcomment').val() == "") {
                alertify.error("Comment please.");
                return false;
                isvalidate = "1";
            }

            if (parseInt(currentstatus) == 2) {
                if ($('#ctl00_ContentPlaceHolder1_txtsuspensiondate').val() == "") {
                    alertify.error("Select suspensiondate please.");
                    return false;
                    isvalidate = "1";
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtresumptiondate').val() == "") {
                    alertify.error("Select resumptiondate please.");
                    return false;
                    isvalidate = "1";
                }
            }
            if (parseInt(currentstatus) == 3) {
                if ($('#ctl00_ContentPlaceHolder1_txtterminationdate').val() == "") {
                    alertify.error("Select terminationdate please.");
                    return false;
                    isvalidate = "1";
                }
            }

            if (parseInt(currentstatus) == 5) {
                if ($('#ctl00_ContentPlaceHolder1_txtonleavedate').val() == "") {
                    alertify.error("Select leavedate please.");
                    return false;
                    isvalidate = "1";
                }
            }

            if (parseInt(currentstatus) == 11) {
                if ($('#ctl00_ContentPlaceHolder1_txtnoticeperiodday').val() == "") {
                    alertify.error("Select noticeperiod start date please.");
                    return false;
                    isvalidate = "1";
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtnoofnoticeperioddays').val() == "") {
                    alertify.error("Enter no of days.");
                    return false;
                    isvalidate = "1";
                }
            }

            if (isvalidate == "1") {
                return false;
            }
            else {
                return true;
            }

        }

        function FillAllField() {
            status = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
            comment = $('#ctl00_ContentPlaceHolder1_txtyourcomment').val();
            suspensiondate = $('#ctl00_ContentPlaceHolder1_txtsuspensiondate').val();
            resumptiondate = $('#ctl00_ContentPlaceHolder1_txtresumptiondate').val();
            terminationdate = $('#ctl00_ContentPlaceHolder1_txtterminationdate').val();
            noticePeriodDate = $('#ctl00_ContentPlaceHolder1_txtnoticeperiodday').val();
            noofdaysinnoticeperiod = $('#ctl00_ContentPlaceHolder1_txtnoofnoticeperioddays').val();
            workingDate = $('#ctl00_ContentPlaceHolder1_txtwokingdate').val();
            leave = $('#ctl00_ContentPlaceHolder1_txtonleavedate').val();
            return false;
        }

        function DateDefault() {
            $('#ctl00_ContentPlaceHolder1_gridemploymentdetails .ToDate').each(function () {
                if ($(this).html() == "01 Jan 1900") {
                    $(this).html("---------");
                }

            });
        }

        function BindGridAfterOperation() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "employment-details.aspx/BindGridByJs",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gridemploymentdetails] tr").show();
                        $("[id*=gridemploymentdetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gridemploymentdetails] tr:eq(1)").clone(true);
                            $("[id$=gridemploymentdetails]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.FromDate').html(data.d[i].FromDate);
                            $(row).find('.ToDate').html(data.d[i].ToDate);
                            $(row).find('.Inhand_Salary').html(data.d[i].Inhand_Salary);
                            $(row).find('.Designation').html(data.d[i].Designation);
                            $(row).find('.Department').html(data.d[i].Department);
                            $(row).find('.Employment_Type').html(data.d[i].Employment_Type);
                            $(row).find('.Probation_Period_In_Month').html(data.d[i].Probation_Period_In_Month);
                            $(row).find('.Branch_Name').html(data.d[i].Branch_Name);
                        }
                        $("[id*=gridemploymentdetails] tr").show();
                        $("[id*=gridemploymentdetails] tr:eq(1)").hide();

                    }
                    DateDefault();
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }

        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtdatefromforprevioushistory").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd/mm/yy",
                maxDate: new Date()

            });
            document.title = 'Employment Details';

            DateDefault();

            $("#ctl00_ContentPlaceHolder1_ddlBranch").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlBranch").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtannualctc").focus(function () { $("#ctl00_ContentPlaceHolder1_txtannualctc").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").focus(function () { $("#ctl00_ContentPlaceHolder1_txtDatejoining").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").focus(function () { $("#ctl00_ContentPlaceHolder1_ddl_dept").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlDesigNation").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").focus(function () { $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtannualctc").focus(function () { $("#ctl00_ContentPlaceHolder1_txtannualctc").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").focus(function () { $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtHrName").focus(function () { $("#ctl00_ContentPlaceHolder1_txtHrName").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtdoi").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdoi").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").focus(function () { $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").removeClass("texthover"); });
            $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").focus(function () { $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").removeClass("texthover"); });

            $('#ctl00_ContentPlaceHolder1_txtappraisaldate').change(function () {
                alertify.alert("Appraisal will applied from first day of selected month.");
            });

            $('#ctl00_ContentPlaceHolder1_ddlstatus').change(function () {
                currentstatus = $(this).val();
                if (currentstatus > 0) {
                    $("#divforwork").css("margin-left", "-360px");
                    $("#divforddl").css("margin-left", "-360px");
                }
                else {
                    $("#divforwork").css("margin-left", "30px");
                    $("#divforddl").css("margin-left", "30px");
                }

                if (parseInt(currentstatus) == parseInt(0)) {
                    $('.comment').css("display", "none");
                    $('.working').css("display", "none");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "none");
                    $('.checkmail').css("display", "none");

                }
                else if (parseInt(currentstatus) == parseInt(1)) {
                    $('.comment').css("display", "block");
                    $('.working').css("display", "block");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "none");
                    $('.checkmail').css("display", "block");
                }
                else if (parseInt(currentstatus) == parseInt(2)) {
                    $('.comment').css("display", "block");
                    $('.suspend').css("display", "block");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "none");
                    $('.working').css("display", "none");
                    $('.checkmail').css("display", "block");
                    subject = "Suspension Letter";
                }
                else if (parseInt(currentstatus) == parseInt(3)) {
                    $('.comment').css("display", "block");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "block");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "none");
                    $('.working').css("display", "none");
                    $('.checkmail').css("display", "block");
                    subject = "Termination Letter";
                }
                else if (parseInt(currentstatus) == parseInt(5)) {
                    $('.comment').css("display", "block");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "block");
                    $('.noticeperiod').css("display", "none");
                    $('.working').css("display", "none");
                    $('.checkmail').css("display", "block");
                }
                else if (parseInt(currentstatus) == parseInt(11)) {
                    $('.comment').css("display", "block");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "block");
                    $('.working').css("display", "none");
                    $('.checkmail').css("display", "block");
                }

                return false;

            });

            $("#ctl00_ContentPlaceHolder1_chkformailsend").click(function () {
                alertify.confirm("Are you sure you want to send the E-mail?", function (e) {
                    if (e) {
                        if (document.getElementById("ctl00_ContentPlaceHolder1_chkformailsend").checked == true) {
                            $("#div1").show();
                        }
                    }
                    else {
                        document.getElementById("ctl00_ContentPlaceHolder1_chkformailsend").checked = false;
                        $(".cke_wysiwyg_frame").contents().find("body").text("");
                        return false;
                    }
                });

            });

            $("#ctl00_ContentPlaceHolder1_btnclose2").click(function () {
                $("#div1").hide(600);
                $(".cke_wysiwyg_frame").contents().find("body").text("");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnclear").click(function () {
                $(".cke_wysiwyg_frame").contents().find("body").text("");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnsave").click(function () {
                if ($(".cke_wysiwyg_frame").contents().find("body").text().trim() != "") {
                    msg = $(".cke_wysiwyg_frame").contents().find("body").text().trim();
                }
                else {
                    alertify.error("Please provide your text message.");
                    return false;
                }
                $("#div1").hide(600);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_btnsendformobile').click(function () {
                alertify.confirm("Are you sure you want to change the status?", function (e) {
                    if (e) {

                        var isvalidreturn = IsValidate();

                        if (isvalidreturn == true) {
                            if (currentstatus != "0") {
                                FillAllField();
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "employment-details.aspx/Chnage_Emp_Status",
                                    data: "{'status':'" + currentstatus + "','comment':'" + comment + "','suspensiondate':'" + suspensiondate + "','resumptiondate':'" + resumptiondate + "','terminationdate':'" + terminationdate + "','noticePeriodDate':'" + noticePeriodDate + "','noofdaysinnoticeperiod':'" + noofdaysinnoticeperiod + "','workingDate':'" + workingDate + "','leavedate':'" + leave + "'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d == 1) {
                                            $("#divforchangestatus").hide(600);

                                            if (document.getElementById("ctl00_ContentPlaceHolder1_chkformailsend").checked == true) {
                                                var stformail = SendingEmail();
                                                if (stformail != false) {
                                                    window.location.href = "employee-list.aspx";
                                                }
                                                else {
                                                    return false;
                                                }
                                            }

                                            return false;
                                        }
                                    },
                                    error: function (result) {
                                        alertify.error("Some Error occured.");
                                    }
                                });
                            }
                        }
                    }
                    else {
                        alertify.error("You've clicked Cancel");
                    }
                });
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_lbtnchnagestatus').click(function () {
                var hfvalue = $('#ctl00_ContentPlaceHolder1_hfchangestatus').val();
                if (hfvalue == 3 || hfvalue == 4 || hfvalue == 11) {
                    alertify.alert("You can not change the status.");
                }
                else {
                    $("#divforchangestatus").show(500);
                    $('.comment').css("display", "none");
                    $('.working').css("display", "none");
                    $('.suspend').css("display", "none");
                    $('.termination').css("display", "none");
                    $('.onleave').css("display", "none");
                    $('.noticeperiod').css("display", "none");
                }
                return false;
            });

            $("#btclose1").click(function () {
                $("#divforchangestatus").hide(600);
                $('#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
                $('#ctl00_ContentPlaceHolder1_txtyourcomment').val('');
                $('#ctl00_ContentPlaceHolder1_txtsuspensiondate').val('');
                $('#ctl00_ContentPlaceHolder1_txtresumptiondate').val('');
                $('#ctl00_ContentPlaceHolder1_txtterminationdate').val('');
                $('#ctl00_ContentPlaceHolder1_txtnoticeperiodday').val('');
                $('#ctl00_ContentPlaceHolder1_txtnoofnoticeperioddays').val('');
                $('#ctl00_ContentPlaceHolder1_txtwokingdate').val('');
                $('#ctl00_ContentPlaceHolder1_txtonleavedate').val('');
                $('.checkmail').css("display", "none");
                document.getElementById("ctl00_ContentPlaceHolder1_chkformailsend").checked = false;

                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddl_dept").change(function () {
                did = $(this).val();
                filldisig();

            });

            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").keyup(function () {
                var slr = document.getElementById('ctl00_ContentPlaceHolder1_txtmonthlysalary').value;
                if (!slr.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {
                    document.getElementById('ctl00_ContentPlaceHolder1_txtmonthlysalary').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_rdblistforemployee").on("change", function () {
                var statusofemptype = checkemployetype();
                if (statusofemptype != false) {
                    roll = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
                        if (annualctc == 0) {
                            if ($("#ctl00_ContentPlaceHolder1_txtannualctc").val() == "") {
                                annualctc = 0;
                            }
                            else {
                                annualctc = $("#ctl00_ContentPlaceHolder1_txtannualctc").val();
                            }
                        }
                        if (roll == 1) {
                            $("#ctl00_ContentPlaceHolder1_tds").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "none");
                            $("#divforpfno").css("display", "block");
                            $("#divforesino").css("display", "block");
                        }
                        else {
                            $("#ctl00_ContentPlaceHolder1_tds").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "block");
                            $("#divforpfno").css("display", "none");
                            $("#divforesino").css("display", "none");
                        }
                        getting_inhand_monthly_salary();
                    }
            });

            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").on("change blur", function () {
                $('#divmainforsalary').css("display", "block");
                roll = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
                var ctcperenum = 0.00;
                ctcperenum = $(this).val();
                ctcperenum = (ctcperenum * 12).toFixed(2);
                $("#ctl00_ContentPlaceHolder1_txtannualctc").val(ctcperenum)
                if (annualctc == 0) {
                    if ($("#ctl00_ContentPlaceHolder1_txtannualctc").val() == "") {
                        annualctc = 0;
                    }
                    else {
                        annualctc = $("#ctl00_ContentPlaceHolder1_txtannualctc").val();
                    }
                }

                if (roll == 1) {
                    $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_tds").css("display", "none");
                    $("#divforpfno").css("display", "block");
                    $("#divforesino").css("display", "block");
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_tds").css("display", "block");
                    $("#divforpfno").css("display", "none");
                    $("#divforesino").css("display", "none");
                }
                getting_inhand_monthly_salary();

            });

            $("#ctl00_ContentPlaceHolder1_txtannualctc").keyup(function () {
                var annualctc = document.getElementById('ctl00_ContentPlaceHolder1_txtannualctc').value;
                if (!annualctc.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {

                    document.getElementById('ctl00_ContentPlaceHolder1_txtannualctc').value = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").blur(function () {
                if ($("#ctl00_ContentPlaceHolder1_txtEmailAlloted").val() != "") {
                    var z = document.getElementById('<%= txtEmailAlloted.ClientID %>').value;
                    if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        document.getElementById('<%= txtEmailAlloted.ClientID %>').className = "texthover";

                        status = 0;
                    }
                }
            });

            $("#ctl00_ContentPlaceHolder1_lbtnappraisal").click(function () {
                if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_0').checked = true;
                }
                else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_1').checked = true;
                }
                if (methodtype == 0) {
                    alertify.confirm("Are you sure you want to Appraisal.", function (e) {
                        if (e) {
                            methodtype = 2;
                            changecolor("changecolor", false, true);
                            $("#divshowforappraisalorhistory").css("display", "block");
                            $("#divforappraisaldate").css("display", "block");
                            $("#divfordatefrom").css("display", "none");
                            $("#divfordateto").css("display", "none");
                            $("#divforctxtapplieddate").css("display", "none");
                        }
                        else {
                            changecolor("removeclass", false, false);
                            $("#divforctxtapplieddate").css("display", "block");
                            methodtype = 0;
                        }
                    });
                }
                else {
                    alertify.error("You are already updating the records.");
                }
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_lbtnprevioushistory").click(function () {
                if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_0').checked = true;
                }
                else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_1').checked = true;
                }

                if (methodtype == 0) {
                    alertify.confirm("Are you sure you want to insert previous employment history.", function (e) {
                        if (e) {
                            methodtype = 1;
                            changecolor("changecolor2", false, true);
                            $("#divshowforappraisalorhistory").css("display", "block");
                            $("#divforappraisaldate").css("display", "none");
                            $("#divfordatefrom").css("display", "block");
                            $("#divfordateto").css("display", "block");
                            $("#divforctxtapplieddate").css("display", "none");

                        }
                        else {
                            methodtype = 0;
                            changecolor("removeclass", false, false);
                            $("#divforctxtapplieddate").css("display", "block");
                        }
                    });
                }
                else {
                    alertify.error("You are already updating the records.");
                }
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {
                var recordtype = "";
                if (methodtype != 0) {
                    if (methodtype == 1) {
                        recordtype = "previous employment history";
                    }
                    else {
                        recordtype = "appraisal";
                    }
                    alertify.confirm("Are you sure you want to update " + recordtype + " records.", function (e) {
                        if (e) {
                            insert_appraisal(methodtype);
                        }
                        else {
                            changecolor("removeclass", false, true);
                            if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                                document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_0').checked = true;
                            }
                            else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                                document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_1').checked = true;
                            }
                            $("#divforappraisaldate").css("display", "none");
                            $("#divfordatefrom").css("display", "none");
                            $("#divfordateto").css("display", "none");
                            $("#divforctxtapplieddate").css("display", "block");
                            $("#divshowforappraisalorhistory").css("display", "none");
                            $('#divmainforsalary').css("display", "none");
                            methodtype = 0;
                            return false;
                        }
                    });
                }
                else {
                    update_emp_master();
                }
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtdatetoforprevioushistory').change(function () {
                alertify.alert("CTC till date will be last day of previous month.")
            });

            $('#ctl00_ContentPlaceHolder1_lbtnedit').click(function () {

                if ($(this).html() == "[ Update ]") {
                    update_emp_master();
                }
                $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").attr('disabled', false);
                $("#ctl00_ContentPlaceHolder1_txtPanNo").attr('disabled', false);
                $("#ctl00_ContentPlaceHolder1_txttdsaccntno").attr('disabled', false);
                $("#ctl00_ContentPlaceHolder1_pf").attr('disabled', false);
                $("#ctl00_ContentPlaceHolder1_esi").attr('disabled', false);
                $("#ctl00_ContentPlaceHolder1_txtPanNo").focus();
                $(this).html("[ Update ]");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btncancel").click(function () {
                changecolor("removeclass", false, true);
                if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_0').checked = true;
                }
                else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_1').checked = true;
                }
                $("#divforappraisaldate").css("display", "none");
                $("#divfordatefrom").css("display", "none");
                $("#divfordateto").css("display", "none");
                $("#divforctxtapplieddate").css("display", "block");
                $("#divshowforappraisalorhistory").css("display", "none");
                $('#divmainforsalary').css("display", "none");
                methodtype = 0;
                return false;
            });

        });//end of $(document).ready() function
    </script>
    <script type="text/javascript">
        //=====this part for only for functions==========
        function SendingEmail() {
            call_progressbar("start");
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "employment-details.aspx/SendMail",
                data: "{'subject':'" + subject + "','msg':'" + msg + "','currentstatus':'" + currentstatus + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        alertify.success("Mail has been sent successfully.");

                    }
                    else {
                        alertify.error("Some internal error has been occured by host.");

                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (response) {
                    call_progressbar("end");
                    return false;

                }
            });

            return false;
        }

        function checkemployetype() {
            if (methodtype == 1) {
                if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                }
                else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_1').checked = true;
                    alertify.error("You can not change the status of this employee as on roll while updating the previous history records.");

                    return false;
                }
            }
            if (methodtype == 2) {
                if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                    document.getElementById('ctl00_ContentPlaceHolder1_rdblistforemployee_0').checked = true;
                    alertify.error("You can not change the status of this employee as off roll while updating the appraisal records.");

                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "2") {
                }
            }

        }

        function disablecontrols(typeofenable) {
            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_ddlBranch").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtannualctc").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_ddl_dept").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_rdblistforemployee input:radio").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txttdsaccntno").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtHrName").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtPanNo").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtdoi").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtdatefromforprevioushistory").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtdatetoforprevioushistory").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtyearforpreviousmonth").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtappraisaldate").attr('disabled', typeofenable);
            $("#ctl00_ContentPlaceHolder1_txtyearappraisal").attr('disabled', typeofenable);
        }

        function changecolor(classname, enabletype, secondenabletype) {
            if ($('#ctl00_ContentPlaceHolder1_hfvforcheckemptype').val() == "1") {
                $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_tds").css("display", "none");
                $("#divforpfno").css("display", "block");
                $("#divforesino").css("display", "block");
            }
            else {
                $("#ctl00_ContentPlaceHolder1_divforprobationperiod").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_tds").css("display", "block");
                $("#divforpfno").css("display", "none");
                $("#divforesino").css("display", "none");
            }

            $("#ctl00_ContentPlaceHolder1_txtannualctc").val("");
            $("#ctl00_ContentPlaceHolder1_txtinhandsalary").val("");
            $("#ctl00_ContentPlaceHolder1_txtappraisaldate").val("0");
            $("#ctl00_ContentPlaceHolder1_txtyearappraisal").val("0");
            $("#ctl00_ContentPlaceHolder1_ddl_dept").val("0");
            $("#ctl00_ContentPlaceHolder1_txtpfno").val("");
            $("#ctl00_ContentPlaceHolder1_txtesino").val("");
            $("#ctl00_ContentPlaceHolder1_txtmonthlysalary").val("");

            $("#ctl00_ContentPlaceHolder1_ddlDesigNation").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_ddlBranch").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_ddlProbationPeriod").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_txtannualctc").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_ddl_dept").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_rdblistforemployee input:radio").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_txttdsaccntno").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtHrName").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtPanNo").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtdoi").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtDatejoining").attr('disabled', secondenabletype);
            $("#ctl00_ContentPlaceHolder1_txtpfno").attr('disabled', enabletype);
            $("#ctl00_ContentPlaceHolder1_txtesino").attr('disabled', enabletype);

            document.getElementById('<%=ddl_dept.ClientID %>').className = classname;
            document.getElementById('<%=ddlDesigNation.ClientID %>').className = classname;
            document.getElementById('<%=ddlBranch.ClientID %>').className = classname;
            document.getElementById('<%=ddlProbationPeriod.ClientID %>').className = classname;
            document.getElementById('<%=txtannualctc.ClientID %>').className = classname;
            document.getElementById('<%=txtinhandsalary.ClientID %>').className = classname;
            document.getElementById('<%=txtappraisaldate.ClientID %>').className = classname;
            document.getElementById('<%=txtyearappraisal.ClientID %>').className = classname;
            document.getElementById('divforemployeeype').className = classname;
            document.getElementById('<%=txtdatefromforprevioushistory.ClientID %>').className = classname;
            document.getElementById('<%=txtdatetoforprevioushistory.ClientID %>').className = classname;
            document.getElementById('<%=txtyearforpreviousmonth.ClientID %>').className = classname;
            document.getElementById('<%=txtpfno.ClientID %>').className = classname;
            document.getElementById('<%=txtesino.ClientID %>').className = classname;
            document.getElementById('<%=txtmonthlysalary.ClientID %>').className = classname;

        }

        function fill_variables() {
            deptid = document.getElementById('<%=ddl_dept.ClientID %>').value;
            designationid = document.getElementById('<%=ddlDesigNation.ClientID %>').value;
            branchid = document.getElementById('<%=ddlBranch.ClientID %>').value;
            typeofemployement = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();
            if (typeofemployement == 1) {
                probationperiod = 0;
                tdsaccountno = "";
            }
            else {
                probationperiod = document.getElementById('<%=ddlProbationPeriod.ClientID %>').value;
                tdsaccountno = document.getElementById('<%=txttdsaccntno.ClientID %>').value;
            }
            annual_ctc = document.getElementById('<%=txtannualctc.ClientID %>').value;
            inhandsalary = document.getElementById('<%=txtinhandsalary.ClientID %>').value;
            pancardno = document.getElementById('<%=txtPanNo.ClientID %>').value;
            doi = document.getElementById('<%=txtdoi.ClientID %>').value;
            doj = document.getElementById('<%=txtDatejoining.ClientID %>').value;
            ctcappliedfrom = document.getElementById('<%=txtctcappliedfrom.ClientID %>').value;
            officeemailid = document.getElementById('<%=txtEmailAlloted.ClientID %>').value;
            hrname = document.getElementById('<%=txtHrName.ClientID %>').value;
            deptname = $("#ctl00_ContentPlaceHolder1_ddl_dept option:selected").text();
        }

        function insert_appraisal(mode) {
            if (document.getElementById('<%=ddl_dept.ClientID %>').value == 0) {
                alertify.error("Please select employee department.");

                return false;
            }

            if (document.getElementById('<%=ddlDesigNation.ClientID %>').value == 0) {
                alertify.error("Please select employee designation.");
                return false;
            }
            if (document.getElementById('<%=ddlBranch.ClientID %>').value == 0) {
                alertify.error("Please select the branch.");
                return false;
            }

            var emptyp = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();

            if (emptyp == 2) {
                if (document.getElementById('<%=ddlProbationPeriod.ClientID %>').value == 5) {
                    alertify.error("Please select employee probation period.");
                    return false;
                }
            }

            if (document.getElementById('<%=txtannualctc.ClientID %>').value == "") {
                alertify.error("Please enter the annual CTC amount.");
                return false;
            }
            if (mode == 2) {
                if (document.getElementById('<%=txtappraisaldate.ClientID %>').value == "0") {
                    alertify.error("Please choose the appraisal applied month.");
                    return false;
                }
                if (document.getElementById('<%=txtyearappraisal.ClientID %>').value == "0") {
                    alertify.error("Please choose the appraisal year.");
                    return false;
                }
            }
            if (mode == 1) {
                if (document.getElementById('<%=txtdatefromforprevioushistory.ClientID %>').value == "") {
                    alertify.error("Please choose CTC from date.");
                    return false;
                }
                if (document.getElementById('<%=txtdatetoforprevioushistory.ClientID %>').value == "0") {
                    alertify.error("Please choose CTC till date Month.");
                    return false;
                }
                if (document.getElementById('<%=txtyearforpreviousmonth.ClientID %>').value == "0") {
                    alertify.error("Please choose CTC till date Year.");
                    return false;
                }
            }

            fill_variables();

            if (mode == 2) {
                Datefrom = document.getElementById('<%=txtappraisaldate.ClientID %>').value;
                var tempyear = "0", tempmonth = "0";
                tempmonth = document.getElementById('<%=txtappraisaldate.ClientID %>').value;
                tempyear = document.getElementById('<%=txtyearappraisal.ClientID %>').value;
                Datefrom = ("01" + "/" + tempmonth + "/" + tempyear);
            }
            else {
                Datefrom = document.getElementById('<%=txtdatefromforprevioushistory.ClientID %>').value;
                var tempyear = "0", tempmonth = "0";
                tempmonth = document.getElementById('<%=txtdatetoforprevioushistory.ClientID %>').value;
                tempyear = document.getElementById('<%=txtyearforpreviousmonth.ClientID %>').value;
                DateTo = ("1" + "/" + tempmonth + "/" + tempyear);
            }

            call_progressbar("start");

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "employment-details.aspx/Maintain_appraisal_prevHistory",
                data: "{'deptid':'" + deptid + "','designationid':'" + designationid + "','branchid':'" + branchid + "','typeofemployement':'" + typeofemployement + "','probationperiod':'" + probationperiod + "','annual_ctc':'" + annual_ctc + "','inhandsalary':'" + inhandsalary + "','Datefrom':'" + Datefrom + "','DateTo':'" + DateTo + "','mode':'" + mode + "'}",
                dataType: "json",
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        alertify.success("Previous history has been submitted successfully.");
                        BindGridAfterOperation();
                        changecolor("removeclass", false, false);
                        $("#ctl00_ContentPlaceHolder1_lbtnprevioushistory").text("[ Insert Previous History ]");
                        $("#divforctxtapplieddate").css("display", "block");
                        $("#divshowforappraisalorhistory").css("display", "none");
                    }
                    else if (parseInt(data.d) == 2) {
                        alertify.success("Appraisal record has been submitted successfully.");
                        BindGridAfterOperation();
                        changecolor("removeclass", false, false);
                        $("#ctl00_ContentPlaceHolder1_lbtnappraisal").text("[ Appraisal ]");
                        $("#divforctxtapplieddate").css("display", "block");
                        $("#divshowforappraisalorhistory").css("display", "none");
                    }
                    else if (parseInt(data.d) == 3) {
                        alertify.success("Mode has not been sent correctly.");
                    }
                    else if (parseInt(data.d) == 5) {
                        alertify.alert("Appraisal already done. You can not do this again until previous appraisal will not implement.");
                        $("#ctl00_ContentPlaceHolder1_lbtnappraisal").text("[ Appraisal ]");
                        changecolor("removeclass", false, false);
                        $("#divforctxtapplieddate").css("display", "block");
                        $("#divshowforappraisalorhistory").css("display", "none");
                    }
                    else if (parseInt(data.d) == 6) {
                        alertify.alert("CTC from date should be less then CTC till date.");
                        call_progressbar("end");
                        return false;
                    }
                    else if (parseInt(data.d) == 7) {
                        alertify.alert("CTC from date should not less than DOJ.");
                        call_progressbar("end");
                        return false;
                    }
                    else if (parseInt(data.d) == 8) {
                        alertify.alert("Ctc till date should be in between missing history Date.");
                        call_progressbar("end");
                        return false;
                    }
                    else if (parseInt(data.d) == 9) {
                        alertify.alert("You have already inserted the history between the selected date.");
                        call_progressbar("end");
                        return false;
                    }
                    else if (parseInt(data.d) == 10) {
                        alertify.alert("CTC from date should not greater than current ctc applied from.");
                        call_progressbar("end");
                        return false;
                    }

                    else if (parseInt(data.d) == 11) {
                        alertify.alert("Appraisal date must be greater than current date.");
                        call_progressbar("end");
                        return false;
                    }

                    methodtype = 0;

                    $("#divforappraisaldate").css("display", "none");
                    $("#divfordatefrom").css("display", "none");
                    $("#divfordateto").css("display", "none");
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error("Some Error occured.");
                }
            });

        }

        function getting_inhand_monthly_salary() {
            call_progressbar("start");
            $.ajax(
              {
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "create-new-offer-letter.aspx/getmonthlysalary",
                  data: "{'annualctc':'" + annualctc + "','roll':'" + roll + "'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d.length > 0) {
                          $("#divforsalarydetails").css("display", "block");
                          for (var i = 0; i < data.d.length; i++) {
                              $("#<%=hidden.ClientID %>").val(data.d[i].net_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_txtinhandsalary").val(data.d[i].net_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_lblgrossannualctc").text(data.d[i].gross_annual_ctc);
                              $("#ctl00_ContentPlaceHolder1_lblnetannualctc").text(data.d[i].net_annual_ctc);
                              $("#ctl00_ContentPlaceHolder1_lblgrossmonthlysalary").text(data.d[i].gross_monthly_salary);
                              $("#ctl00_ContentPlaceHolder1_lblnetmonthlysalary").text(data.d[i].net_monthly_salary);

                              if (parseInt(data.d[i].roll) == 1) {
                                  $("#ctl00_ContentPlaceHolder1_trfortds").css("display", "none");
                                  $("#ctl00_ContentPlaceHolder1_trfortdspercent").css("display", "none");

                                  $("#ctl00_ContentPlaceHolder1_trforpf").css("display", "block");
                                  $("#ctl00_ContentPlaceHolder1_trforesi").css("display", "block");
                                  $("#ctl00_ContentPlaceHolder1_trforpfpercent").css("display", "block");
                                  $("#ctl00_ContentPlaceHolder1_trforesipercent").css("display", "block");

                                  $("#ctl00_ContentPlaceHolder1_lblmonthlyesi").text(data.d[i].monthly_esi_amount);
                                  $("#ctl00_ContentPlaceHolder1_lblmonthlypf").text(data.d[i].monthly_pf_amount);

                                  $("#ctl00_ContentPlaceHolder1_lblpfpercent").text(data.d[i].pf_percent + "%");
                                  $("#ctl00_ContentPlaceHolder1_lblesipercent").text(data.d[i].esi_percent + "%");

                              }
                              if (parseInt(data.d[i].roll) == 2) {

                                  $("#ctl00_ContentPlaceHolder1_lblmonthlytds").text(data.d[i].monthly_tds_amount);
                                  $("#ctl00_ContentPlaceHolder1_lbltdspercent").text(data.d[i].tds_percent + "%");

                                  $("#ctl00_ContentPlaceHolder1_trfortds").css("display", "block");
                                  $("#ctl00_ContentPlaceHolder1_trfortdspercent").css("display", "block");

                                  $("#ctl00_ContentPlaceHolder1_trforpf").css("display", "none");
                                  $("#ctl00_ContentPlaceHolder1_trforesi").css("display", "none");
                                  $("#ctl00_ContentPlaceHolder1_trforpfpercent").css("display", "none");
                                  $("#ctl00_ContentPlaceHolder1_trforesipercent").css("display", "none");

                              }
                          }

                          roll = 0;
                      }
                      else {
                          $("#divforsalarydetails").css("display", "none");
                      }
                      call_progressbar("end");
                  },
                  error: function (result) {
                      call_progressbar("end");
                      return false;
                  }
              });

          }

          function filldisig() {

              call_progressbar("start");
              $.ajax(
                   {
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "create-new-offer-letter.aspx/binddesignation",
                       data: "{'did':'" + did + "'}",
                       dataType: "json",
                       success: function (data) {

                           $("#ctl00_ContentPlaceHolder1_ddlDesigNation").html("");

                           $.each(data.d, function (key, value) {
                               $("#ctl00_ContentPlaceHolder1_ddlDesigNation").append($("<option></option>").val(value.desigid).html(value.designame));

                           });
                           call_progressbar("end");
                       },
                       error: function (result) {
                           call_progressbar("end");
                           return false;
                       }
                   });

          }

          function toggle5(showHideDiv, switchImgTag) {
              var ele = document.getElementById(showHideDiv);
              var imageEle = document.getElementById(switchImgTag);
              if (ele.style.display == "block") {
                  ele.style.display = "none";
                  imageEle.innerHTML = '<img src="../../images/addd11.png" style=" margin-left:0px;" />';
              }
              else {
                  ele.style.display = "block";
                  imageEle.innerHTML = '<img src="../../images/Green_Minus.gif" style=" margin-left:0px;">';
              }
          }

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
    </script>
    <script type="text/javascript">
        function validate() {
            var status = 1;

            if (document.getElementById('<%=ddl_dept.ClientID %>').value == 0) {
                document.getElementById('<%=ddl_dept.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%=ddlDesigNation.ClientID %>').value == 0) {
                document.getElementById('<%=ddlDesigNation.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=ddlBranch.ClientID %>').value == 0) {
                document.getElementById('<%=ddlBranch.ClientID %>').className = "texthover";

                status = 0;
            }
            var emptype = $('#<%=rdblistforemployee.ClientID %> input[type=radio]:checked').val();

            if (emptype == 2) {
                if (document.getElementById('<%=ddlProbationPeriod.ClientID %>').value == 5) {
                    document.getElementById('<%=ddlProbationPeriod.ClientID %>').className = "texthover";

                    status = 0;
                }
            }

            if (document.getElementById('<%=txtannualctc.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtannualctc.ClientID %>').className = "texthover";

                status = 0;
            }

            var z = document.getElementById('<%= txtannualctc.ClientID %>').value;
            if (!z.match(/^[0-9]\d*(?:\.\d{0,2})?$/)) {
                document.getElementById('<%= txtannualctc.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%=txtctcappliedfrom.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtctcappliedfrom.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%=txtinhandsalary.ClientID %>').value.trim() == "") {
                document.getElementById('<%=txtinhandsalary.ClientID %>').className = "texthover";
                status = 0;
            }

            if (document.getElementById('<%=txtEmailAlloted.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtEmailAlloted.ClientID %>').className = "texthover";

                status = 0;
            }

            if (document.getElementById('<%=txtEmailAlloted.ClientID %>').value.trim() != "") {
                var z = document.getElementById('<%= txtEmailAlloted.ClientID %>').value;
                if (!z.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                    document.getElementById('<%= txtEmailAlloted.ClientID %>').className = "texthover";
                    status = 0;
                }
            }

            if (document.getElementById('<%=txtHrName.ClientID %>').value.trim() == 0) {
                document.getElementById('<%=txtHrName.ClientID %>').className = "texthover";

                status = 0;
            }
            if (status == 0) {
                alertify.error("Correct all above red marked fields.");
                $("html, body").animate({ scrollTop: 0 }, 500);
                return false;
            }

        }
        function update_emp_master() {
            alertify.confirm("Are you sure you want to update the employment details.", function (e) {
                if (e) {
                    var pancard = "", tds = "", email = "", esi = "", pf = "";

                    pancard = document.getElementById('<%=txtPanNo.ClientID %>').value;
                    tds = document.getElementById('<%=txttdsaccntno.ClientID %>').value;
                    email = document.getElementById('<%=txtEmailAlloted.ClientID %>').value;
                    esi = document.getElementById('<%=txtesino.ClientID %>').value;
                    pf = document.getElementById('<%=txtpfno.ClientID %>').value;

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "employment-details.aspx/update_emp_master_record",
                        data: "{'pancard':'" + pancard + "','tds':'" + tds + "','email':'" + email + "','esi':'" + esi + "','pf':'" + pf + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (parseInt(data.d) == 1) {
                                alertify.success("Employee record has been successfully updated.");
                                $("#ctl00_ContentPlaceHolder1_txtPanNo").attr('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_txttdsaccntno").attr('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_pf").attr('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_esi").attr('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").attr('disabled', true);
                                $('#ctl00_ContentPlaceHolder1_lbtnedit').html("[ Edit ]");
                            }
                        },
                        error: function (result) {
                            call_progressbar("end");
                            return false;
                        }
                    });
                }
                else {
                    $("#ctl00_ContentPlaceHolder1_txtPanNo").attr('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_txttdsaccntno").attr('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_pf").attr('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_esi").attr('disabled', true);
                    $("#ctl00_ContentPlaceHolder1_txtEmailAlloted").attr('disabled', true);
                    $('#ctl00_ContentPlaceHolder1_lbtnedit').html("[ Edit ]");
                    return false;
                }
            });
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Employment Details</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div id="divAppoinmentLetter" runat="server">
            <div id="headerDivImg">
                <div style="margin-left: 10px; color: red; font-weight: bold; font-size: 15px">
                    Caution: If you <span style="color: black">[ Change Status ]</span> OR <span style="color: blue">[ Insert Previous History ] </span>OR <span style="color: green">[ Appraisal ]</span> then you can't edit/update : [ So be careful ].
                </div>
            </div>

            <div id="missinghistory" runat="server">
                <div class="separator bg-blue"></div>
                <h4 class="page-title txtblue ">
                    <span id="Span2" runat="server" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important;">Missing History Details</span>
                </h4>
                <div class="separator bg-blue"></div>
                <table width="50%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 100px !important;">
                    <tr id="trmissinghistory" runat="server">
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gridviewmissinghistory" ShowHeader="true" AutoGenerateColumns="false"
                                GridLines="None" Width="100%" CssClass="stm" Style="margin-left: 120px!important">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("Rownumber") %>' CssClass="RowNumber"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="80px" HeaderText="From Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblhistorymissingfromdate" runat="server" Text='<%# Eval("History_Missing_From_Date") %>' CssClass="FromDate"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="80px" HeaderText="To Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblhistorymissingtodate" runat="server" Text='<%# Eval("History_Missing_To_Date") %>' CssClass="ToDate"></asp:Label>
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
            </div>
            <div class="separator bg-blue"></div>
            <h4 class="page-title txtblue ">
                <span id="Span3" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Employment Details</span>
            </h4>
            <div class="separator bg-blue"></div>
            <div id="divalwaysshow">
                <div class="for_sigle_row_form">
                    <label>
                        Date Of Interview</label>
                    <asp:TextBox ID="txtdoi" PlaceHolder="Date of Interview" runat="server" Enabled="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Date Of Joining</label>
                    <asp:TextBox ID="txtDatejoining" PlaceHolder="Date of Joining" runat="server" Enabled="false"></asp:TextBox>&nbsp&nbsp&nbsp
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        PAN Card No.</label>
                    <asp:TextBox ID="txtPanNo" PlaceHolder="Pan Card No" runat="server" MaxLength="10" Style="text-transform: uppercase !important" Enabled="false"></asp:TextBox>
                </div>
                <div id="tds" runat="server" class="for_sigle_row_form">
                    <label>
                        TDS A/C No.</label>
                    <asp:TextBox ID="txttdsaccntno" PlaceHolder="TDS A/C No." runat="server" MaxLength="20" Style="text-transform: uppercase !important" Enabled="false"></asp:TextBox>
                </div>
                <div id="pf" class="for_sigle_row_form" runat="server">
                    <label>
                        PF A/C No.</label>
                    <asp:TextBox ID="txtmainpfno" PlaceHolder="PF A/C No." runat="server" MaxLength="20" Style="text-transform: none !important" Enabled="false"></asp:TextBox>
                </div>
                <div id="esi" class="for_sigle_row_form" runat="server">
                    <label>
                        Esi A/C No.</label>
                    <asp:TextBox ID="txtmainesino" PlaceHolder="Esi A/C No." runat="server" MaxLength="20" Style="text-transform: none !important" Enabled="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Office E-mail ID
                    </label>
                    <asp:TextBox ID="txtEmailAlloted" PlaceHolder="Office Email ID" runat="server" MaxLength="50" Style="text-transform: none !important" Enabled="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Managing Director</label>
                    <asp:TextBox ID="txtHrName" PlaceHolder="Managing Director" runat="server" MaxLength="50" Enabled="false"></asp:TextBox>
                    <asp:LinkButton ID="lbtnedit" runat="server" Text="[ Edit ]"></asp:LinkButton>
                    <asp:LinkButton ID="lbtnchnagestatus" runat="server" Text="[ Change Status ]"></asp:LinkButton>
                    <asp:LinkButton ID="lbtnappraisal" runat="server" Text="[ Appraisal ]"></asp:LinkButton>
                    <asp:HiddenField ID="hfchangestatus" runat="server" />
                </div>
            </div>
            <div id="divshowforappraisalorhistory" style="display: none !important;">
                <div class="separator bg-blue"></div>
                <h4 class="page-title txtblue ">
                    <span id="Span1" style="margin-left: 10px; font-size: 13pt; color: #006EB8!important">Required Employment Detail</span>
                </h4>
                <div class="separator bg-blue"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Department<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddl_dept" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Designation<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlDesigNation" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Branch<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlBranch" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div id="divmainforsalary" style="display: none !important; width: 285px; float: right; margin-right: 195px; border: 2px solid; border-color: #306b33; padding: 10px 10px 10px 10px">
                    <table>
                        <tr>
                            <td style="width: 150px; padding: 5px 0px 4px 4px">Gross Annual CTC:</td>
                            <td style="width: 150px;">
                                <asp:Label ID="lblgrossannualctc" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; padding: 5px 0px 4px 4px">Net Annual CTC: </td>
                            <td style="width: 150px;">
                                <asp:Label ID="lblnetannualctc" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; padding: 5px 0px 4px 4px">Gross Monthly Salary:</td>
                            <td>
                                <asp:Label ID="lblgrossmonthlysalary" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                            </td>
                        </tr>

                        <tr id="trfortds" runat="server" style="width: 145% !important;">
                            <td style="padding: 5px 0px 4px 4px">Monthly TDS Amount:</td>
                            <td>
                                <asp:Label ID="lblmonthlytds" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 14px"></asp:Label>
                            </td>
                        </tr>

                        <tr id="trfortdspercent" runat="server" style="width: 145% !important;">
                            <td style="width: 103px; padding: 5px 0px 4px 4px">TDS:</td>
                            <td style="width: 70px;">
                                <asp:Label ID="lbltdspercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 45px"></asp:Label>
                            </td>
                        </tr>

                        <tr id="trforpf" runat="server" style="width: 145% !important;">
                            <td style="padding: 5px 0px 4px 4px; width: 140px !important;">Monthly PF Amount:</td>
                            <td>
                                <asp:Label ID="lblmonthlypf" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trforesi" runat="server" style="width: 145% !important;">
                            <td style="width: 150px; padding: 5px 0px 4px 4px">Monthly ESI Amount:</td>
                            <td>
                                <asp:Label ID="lblmonthlyesi" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 0px"></asp:Label>
                            </td>
                        </tr>

                        <tr id="trforpfpercent" runat="server" style="width: 145% !important;">
                            <td style="width: 150px; padding: 5px 0px 4px 4px">PF:</td>
                            <td>
                                <asp:Label ID="lblpfpercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 3px"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trforesipercent" runat="server" style="display: none; width: 145% !important;">
                            <td style="width: 150px; padding: 5px 0px 4px 4px">ESI:</td>
                            <td>
                                <asp:Label ID="lblesipercent" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 3px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height: 2px; width: 100%; background-color: #006EB8"></td>
                        </tr>
                        <tr>
                            <td style="width: 150px; padding: 5px 0px 4px 4px">Inhand/Net Monthly Salary:</td>
                            <td>
                                <asp:Label ID="lblnetmonthlysalary" runat="server" ForeColor="Red" Style="font-size: 10pt; margin-left: 10px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Type of Employment
                    </label>
                    <div id="divforemployeeype" style="    width: 290px;
    border: 1px solid;
    border-color: #ccc;
    margin-left: 169px;
    height: 24px;
    padding-top: 3px;
    padding-bottom: 3px;
    padding-left: 10px;">
                        <asp:RadioButtonList ID="rdblistforemployee" runat="server" CssClass="forlabel" RepeatDirection="Horizontal">
                            <asp:ListItem Value="1">On Roll</asp:ListItem>
                            <asp:ListItem Value="2" Selected="True">Off Roll</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:HiddenField ID="hfvforcheckemptype" runat="server" />
                    </div>
                </div>

                <div id="divforpfno" class="for_sigle_row_form" style="display: none">
                    <label>
                        PF A/C No.</label>
                    <asp:TextBox ID="txtpfno" PlaceHolder="PF A/C No" runat="server" MaxLength="20" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div id="divforesino" class="for_sigle_row_form" style="display: none">
                    <label>
                        Esi A/C No.</label>
                    <asp:TextBox ID="txtesino" PlaceHolder="ESI A/C No" runat="server" MaxLength="20" Style="text-transform: none !important"></asp:TextBox>
                </div>

                <div id="divforprobationperiod" runat="server" class="for_sigle_row_form" style="display: block">
                    <label>
                        Probation Period(In Month)<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlProbationPeriod" runat="server" AppendDataBoundItems="True">
                        <asp:ListItem Selected="True" Text="---Select Probation Period---" Value="5"></asp:ListItem>
                        <asp:ListItem Value="0" Text="0"></asp:ListItem>
                        <asp:ListItem Value="1" Text="3"></asp:ListItem>
                        <asp:ListItem Value="2" Text="6"></asp:ListItem>
                        <asp:ListItem Value="3" Text="9"></asp:ListItem>
                        <asp:ListItem Value="4" Text="12"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Monthly Salary:<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtmonthlysalary" PlaceHolder="Monthly Salary" runat="server" MaxLength="5"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Inhand Salary (Per Month):<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtinhandsalary" Enabled="false" PlaceHolder="Inhand salary" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        CTC (Per Annum):<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtannualctc" PlaceHolder="CTC (Per Annum)" runat="server" MaxLength="7" ReadOnly="true"></asp:TextBox>
                    <asp:HiddenField ID="hidden" runat="server" />
                </div>
                <div id="divforctxtapplieddate" class="for_sigle_row_form">
                    <label>
                        Above CTC Applied From:<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtctcappliedfrom" PlaceHolder="Above CTC Applied From" runat="server" ReadOnly="true" MaxLength="20"></asp:TextBox>
                </div>
                <div id="divforappraisaldate" style="display: none" class="for_sigle_row_form">
                    <label>
                        Appraisal Applied Month:<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="txtappraisaldate" runat="server" Style="width: 157px !important;">
                        <asp:ListItem Value="0" Selected="True">---Select Month---</asp:ListItem>
                        <asp:ListItem Value="04">April</asp:ListItem>
                        <asp:ListItem Value="05">May</asp:ListItem>
                        <asp:ListItem Value="06">June</asp:ListItem>
                        <asp:ListItem Value="07">July</asp:ListItem>
                        <asp:ListItem Value="08">August</asp:ListItem>
                        <asp:ListItem Value="09">September</asp:ListItem>
                        <asp:ListItem Value="10">October</asp:ListItem>
                        <asp:ListItem Value="11">November</asp:ListItem>
                        <asp:ListItem Value="12">December</asp:ListItem>
                        <asp:ListItem Value="01">January</asp:ListItem>
                        <asp:ListItem Value="02">February</asp:ListItem>
                        <asp:ListItem Value="03">March</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="txtyearappraisal" runat="server" Style="width: 157px !important;">
                        <asp:ListItem Value="0" Selected="True">---Select Year---</asp:ListItem>
                        <asp:ListItem Value="2015">2015</asp:ListItem>
                        <asp:ListItem Value="2016">2016</asp:ListItem>
                        <asp:ListItem Value="2017">2017</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="divfordatefrom" style="display: none" class="for_sigle_row_form">
                    <label>
                        CTC From Date:<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtdatefromforprevioushistory" PlaceHolder="Date From" ReadOnly="true" runat="server"></asp:TextBox>
                </div>
                <div id="divfordateto" style="display: none" class="for_sigle_row_form">
                    <label>
                        CTC Till Date:<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="txtdatetoforprevioushistory" runat="server" Style="width: 157px !important;">
                        <asp:ListItem Value="0" Selected="True">---Select Month---</asp:ListItem>
                        <asp:ListItem Value="04">April</asp:ListItem>
                        <asp:ListItem Value="05">May</asp:ListItem>
                        <asp:ListItem Value="06">June</asp:ListItem>
                        <asp:ListItem Value="07">July</asp:ListItem>
                        <asp:ListItem Value="08">August</asp:ListItem>
                        <asp:ListItem Value="09">September</asp:ListItem>
                        <asp:ListItem Value="10">October</asp:ListItem>
                        <asp:ListItem Value="11">November</asp:ListItem>
                        <asp:ListItem Value="12">December</asp:ListItem>
                        <asp:ListItem Value="01">January</asp:ListItem>
                        <asp:ListItem Value="02">February</asp:ListItem>
                        <asp:ListItem Value="03">March</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="txtyearforpreviousmonth" runat="server" Style="width: 157px !important;">
                        <asp:ListItem Value="0" Selected="True">---Select Year---</asp:ListItem>
                        <asp:ListItem Value="2012">2012</asp:ListItem>
                        <asp:ListItem Value="2013">2013</asp:ListItem>
                        <asp:ListItem Value="2014">2014</asp:ListItem>
                        <asp:ListItem Value="2015">2015</asp:ListItem>
                        <asp:ListItem Value="2016">2016</asp:ListItem>
                        <asp:ListItem Value="2017">2017</asp:ListItem>
                        <asp:ListItem Value="2018">2018</asp:ListItem>
                        <asp:ListItem Value="2019">2019</asp:ListItem>
                        <asp:ListItem Value="2020">2020</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button_save" />
                    <asp:Button ID="btncancel" runat="server" Text="Cancel" Style="height: 34px!important" CssClass="button2" />
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfvforruntimedivcount" runat="server" />

        <div id="divforchangestatus" style="text-align: center; display: none;">
            <div style="width: 100%; margin: 10px;">
                <table class="showpopup2" style="background-color: white; vertical-align: top;">
                    <tr>
                        <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 0px;" id="td2"><a id="btclose1">Close</a></td>
                    </tr>

                    <tr>
                        <td class="t1" valign="top"><span>Current Status:</span></td>
                        <td class="t2">
                            <div id="divforwork" style="margin-left: 30px!important">
                                <asp:Label ID="lblformobile" Style="height: 24px; width: 250px; padding-top: 20px !important; color: #007ACC; font-size: 18px; font-family: Arial" runat="server" Text="Working"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="t1" valign="top"><span>Change Status:</span></td>
                        <td class="t2">
                            <div id="divforddl" style="margin-left: 30px!important">
                                <asp:DropDownList ID="ddlstatus" runat="server" Style="width: 251px; height: 22px !important;"></asp:DropDownList>
                            </div>
                        </td>
                    </tr>

                    <tr class="comment" style="display: none !important;">

                        <td class="t1" valign="top"><span>Your Comment:</span></td>
                        <td class="t2">
                            <div id="divforcomment" style="margin-left: 20px!important">
                                <asp:TextBox ID="txtyourcomment" runat="server" TextMode="MultiLine" Style="width: 251px; height: 100px !important;"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="suspend" style="display: none !important;">
                        <td class="t1" valign="top"><span>Suspension Date:</span></td>
                        <td class="t2">
                            <div id="divforsuspension" style="margin-left: 8px!important">
                                <asp:TextBox ID="txtsuspensiondate" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="suspend" style="display: none !important;">
                        <td class="t1" valign="top"><span>Resumption Date:</span></td>
                        <td class="t2">
                            <div id="divresumptiondate" style="margin-left: 7px!important">
                                <asp:TextBox ID="txtresumptiondate" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="termination" style="display: none !important;">
                        <td class="t1" valign="top"><span>Termination Date:</span></td>
                        <td class="t2">
                            <div id="divforterminatedate" style="margin-left: 4px!important">
                                <asp:TextBox ID="txtterminationdate" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="onleave" style="display: none !important;">
                        <td class="t1" valign="top"><span>Leave Date:</span></td>
                        <td class="t2">
                            <div id="divforleave" style="margin-left: 42px!important">
                                <asp:TextBox ID="txtonleavedate" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="noticeperiod" style="display: none !important;">
                        <td class="t1" valign="top"><span>Start Date:</span></td>
                        <td class="t2">
                            <div id="divfornotice1" style="margin-left: 48px!important">
                                <asp:TextBox ID="txtnoticeperiodday" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="noticeperiod" style="display: none !important;">
                        <td class="t1" valign="top"><span>No Of Days:</span></td>
                        <td class="t2">
                            <div id="divfornotice2" style="margin-left: 41px!important">
                                <asp:TextBox ID="txtnoofnoticeperioddays" runat="server" Style="width: 251px; height: 22px !important;"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="working" style="display: none !important;">
                        <td class="t1" valign="top"><span>Date:</span></td>
                        <td class="t2">
                            <div id="div2" style="margin-left: 41px!important">
                                <asp:TextBox ID="txtwokingdate" runat="server" Style="width: 251px; height: 22px !important;" ReadOnly="true"></asp:TextBox>
                            </div>
                        </td>
                    </tr>

                    <tr class="checkmail" style="display: none !important;">
                        <td class="t1"><span>Send Mail:</span></td>
                        <td class="t2">
                            <asp:CheckBox ID="chkformailsend" runat="server" Style="width: 251px; height: 22px !important; margin-left: 55px!important"></asp:CheckBox>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" style="padding-top: 10px!important">
                            <asp:Button ID="btnsendformobile" runat="server" Text="Submit" CssClass="button_save" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="div1" style="text-align: center; display: none;">
            <div style="width: 100%; margin: 10px;">
                <table class="showpopup3" style="background-color: white; vertical-align: top;">
                    <tr>
                        <td>
                            <div id="divforeditor" style="display: block; color: #393434; font-size: 13px;">
                                Mail Message <span style="color: red">*</span><br />
                                <textarea class="ckeditor" cols="80" id="editor1" name="editor" rows="10"></textarea>
                            </div>
                        </td>
                    </tr>
                    <tr style="height: 30px;">

                        <td colspan="4" style="text-align: center; cursor: pointer; color: red; padding-right: 13px; padding-top: 8px;" id="td1">
                            <asp:Button ID="btnsave" class="button" runat="server" Text="Save Message"></asp:Button>
                            <asp:Button ID="btnclear" class="button" runat="server" Text="Clear"></asp:Button>
                            <asp:Button ID="btnclose2" class="button" runat="server" Text="Close"></asp:Button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="separator bg-blue"></div>
        <div id="divgrid" runat="server">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr id="trgrid" runat="server">
                    <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView runat="server" ID="gridemploymentdetails" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" Width="100%" CssClass="stm">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="30px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="From Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfromdate" runat="server" Text='<%# Eval("FromDate") %>' CssClass="FromDate"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="80px" HeaderText="To Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltodate" runat="server" Text='<%# Eval("ToDate") %>' CssClass="ToDate"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Salary(Per Month)" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldesignationdepartment" runat="server" Text='<%# Eval("Inhand_Salary") %>' CssClass="Inhand_Salary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Designation" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldesignation" ReadOnly="true" runat="server" Text='<%# Eval("Designation") %>' CssClass="Designation"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Department" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldepartment" ReadOnly="true" runat="server" Text='<%# Eval("Department") %>' CssClass="Department"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="90px" HeaderText="Employement Type" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemptype" ReadOnly="true" runat="server" Text='<%# Eval("Employment_Type") %>' CssClass="Employment_Type"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="90px" HeaderText="Probation Period" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblprobationperiod" ReadOnly="true" runat="server" Text='<%# Eval("Probation_Period_In_Month") %>' CssClass="Probation_Period_In_Month"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Branch" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblbranchname" ReadOnly="true" runat="server" Text='<%# Eval("Branch_Name") %>' CssClass="Branch_Name"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatustype" ReadOnly="true" runat="server" Text='<%# Eval("StatusType") %>' CssClass="Branch_Name"></asp:Label>
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
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:LinkButton ID="lbtnprevioushistory" runat="server" Text="[ Insert Previous History ]" Style="float: right !important; margin-right: 140px"></asp:LinkButton>
        </div>
    </div>
    <script type="text/javascript">
        var j = jQuery.noConflict();
        $(function () {
            var d = new Date();
            var y = d.getFullYear() + 1;
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                j("#ctl00_ContentPlaceHolder1_txtsuspensiondate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });
                j("#ctl00_ContentPlaceHolder1_txtresumptiondate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });
                j("#ctl00_ContentPlaceHolder1_txtterminationdate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });

                j("#ctl00_ContentPlaceHolder1_txtonleavedate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });
                j("#ctl00_ContentPlaceHolder1_txtnoticeperiodday").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });
                j("#ctl00_ContentPlaceHolder1_txtnoofnoticeperioddays").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });              
                $("#ctl00_ContentPlaceHolder1_txtdoi").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });

                $("#ctl00_ContentPlaceHolder1_txtDatejoining").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",m
                });
                $("#ctl00_ContentPlaceHolder1_txtctcappliedfrom").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2012:' + y,
                    dateFormat: "dd/mm/yy",
                });
            });
        });
    </script>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>