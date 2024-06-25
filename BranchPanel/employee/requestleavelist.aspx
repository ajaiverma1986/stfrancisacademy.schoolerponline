<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="requestleavelist.aspx.cs" Inherits="branchpanel_employee_requestleavelist" %>

<%@ Register Src="~/BranchPanel/employee/empdetails.ascx" TagName="employee" TagPrefix="UC" %>
<%@ Register Src="~/BranchPanel/employee/leave-managment.ascx" TagName="emp" TagPrefix="UC1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.7.1.min.js" type="text/javascript"></script>

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <script src="../../Calender/js/jquery-ui-1.8.19.custom.min.js"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style>
        #loader {
            position: relative;
            top: 10%;
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

        .oldleave {
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

        .activeleavereport {
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

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }

        .weakoff {
            background: #ffff00!important;
        }

            .weakoff td {
                color: #ff0000 !important;
                font-weight: bold;
            }

        #ctl00_ContentPlaceHolder1_chsendmail {
            float: left!important;
        }

        #forlabel label {
            color: #616161 !important;
            float: none !important;
            font-size: 12px !important;
            margin-right: 252px !important;
            width: 70px !important;
            padding: 5px;
        }

        #ctl00_ContentPlaceHolder1_gvempleavedetails {
            border-left: 1px solid #dddddd;
        }

        #ctl00_ContentPlaceHolder1_gvtlcomments {
            border-left: 1px solid #dddddd;
        }

        #ctl00_ContentPlaceHolder1_gvleavedetails th {
            text-align: center!important;
        }
    </style>
    <script type="text/javascript">
        //function pageLoad() {

        //}

        var fname = "", datefirst = "", datesecond = "", leavetype = "", earnpaid = "", totaltaklenleave = "", earnedpaid = "", available = "", totalunpaid = "", lblreject = "", stat = "", appliedleavetype = "", pageno = 1, leavefrom = "", leavetp = "", eid = "", empcode = "", MobileNo = "";
        //Function For Update Progress

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

        //Function for get value from Query String
        function GetParameterValues(param) {
            var isFind = "no";
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');

            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (urlparam[0] == param) {
                    isFind = "yes";
                    if (urlparam[1] > 0) {
                        $(".emp").show(500);
                        $(".student-photo_frame").hide(500);
                        $("#search").hide(500);
                        $(".containerHeadline").hide(500);
                    }
                    return urlparam[1];
                }
            }
            if (isFind == "no") {
                return " ";
            }

        }
        //Ready function for call functions on pageload
        $(document).ready(function () {

            document.title = 'Applied Leaves';

            $("#ctl00_ContentPlaceHolder1_txtreferenceno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
            });
            $("#ctl00_ContentPlaceHolder1_txtcontactno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
            });

            var getleaveid = GetParameterValues("leaveid");
            $("#ctl00_ContentPlaceHolder1_leaveid").val(getleaveid);
            getleavesdetails(getleaveid);
            $(".getdetails").live("click", function () {

                call_progressbar("start");
                $(".emp").show(500);
                $(".student-photo_frame").hide(500);
                $("#search").hide(500);
                $(".containerHeadline").hide(500);
                var getempid = $(this).parents("tr").children("td:eq(0)").find("input[type='hidden']").val();
                eid = getempid.trim();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "requestleavelist.aspx/setvalue",
                    data: "{ 'eid':'" + eid + "'}",
                    dataType: "json",
                    success: function (data) {

                    },
                    error: function (result) {
                        alert('error');
                    }
                });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "requestleavelist.aspx/getempcutomsontrol",
                    data: "{ 'eid':'" + eid + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_userctl_lblname').text(data.d[0].name);
                        $('#ctl00_ContentPlaceHolder1_userctl_lblmobile').text(data.d[0].mobile);
                        $('#ctl00_ContentPlaceHolder1_userctl_lbldepartment').text(data.d[0].department);
                        $('#ctl00_ContentPlaceHolder1_userctl_lbldesignation').text(data.d[0].designation);
                        MobileNo = data.d[0].mobile;
                    },
                    error: function (result) {
                        alert('error');
                        call_progressbar("end");
                    }
                });
                var leaveid = $(this).parent("td").find("input").val();
                getleavesdetails(leaveid);
                $("#ctl00_ContentPlaceHolder1_leaveid").val(leaveid);
            });
            $("#getleavesgrid").click(function () {
                $("#griddetails").show(500);
                $("#search").show(500);
                $(".containerHeadline").show(500);
                $("#divpostreview").hide(500);
                $("#getleavesgrid").hide(500);
                $("#getindicators").hide(500);
                $("#ctl00_ContentPlaceHolder1_gvempleavedetails").hide(500);

                BindGridMain();

            });

            $("#linkleave").attr("href", "requestleavelist.aspx"); //set url for webmethod in applied leave
            $("#imgheaderlogo").attr('src', '../../images/logo.png');//set path for logo
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');//call webmethod from page to leave new applied leave

            //Searching form empname
            $('#ctl00_ContentPlaceHolder1_txtempname').on('change keyup paste', function () {
                fname = $(this).val();
                call_progressbar("start");
                BindGridMain();
                call_progressbar("end");
            });
            //serching from Leave From date
            $('#ctl00_ContentPlaceHolder1_txtreferenceno').on('change keyup paste', function () {
                datefirst = $(this).val();
                call_progressbar("start");
                BindGridMain();
                call_progressbar("end");
            });
            //Serching from Applyed Date
            $('#ctl00_ContentPlaceHolder1_txtcontactno').on('change keyup paste', function () {
                datesecond = $(this).val();
                call_progressbar("start");
                BindGridMain();
                call_progressbar("end");
            });
            //Seraching from Leave Type
            $('#ctl00_ContentPlaceHolder1_ddlleavetype').on('change', function () {
                leavetype = $(this).val();
                call_progressbar("start");
                BindGridMain();
                call_progressbar("end");
            });
        });

        //This is call when Paid check box checked
        $(".chkpaid").live("click", function () {

            var chkpaid = $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").attr('checked');
            earnpaid = $("#lblearnpaid").html();
            totaltaklenleave = $("#totaltaklenleave").html();
            available = $("#available").html();
            totalpaid = $("#totalpaid").html();
            if (chkpaid == "checked") {
                $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").children("td:eq(4)").find("input[type='checkbox']").attr('checked', 'checked');
                $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").children("td:eq(6)").find("select").append($("<option value='1'>Annual</option>"));
                $(this).parents("tr").children("td:eq(6)").find("select").val(1);
                $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', true);
                $(this).parents("tr").css("background", "#46B525");
                $(this).parents("tr").children("td").addClass("important");

                earnpaid = earnpaid - 1;
                $("#lblearnpaid").html(earnpaid);

                totalpaid = parseInt(totalpaid) + 1
                $("#totalpaid").html(totalpaid);

                if (parseInt(earnpaid) <= -1) {
                    if (confirm("This Employee don't have more paid leave. You Want to give advance paid leave? ") == true) {
                        if (parseInt(totalpaid) > parseInt(available)) {
                            $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").attr('checked', false);
                            $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', false);
                            $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', false);
                            $(this).parents("tr").css("background", "#F7F7F7");
                            $(this).parents("tr").children("td").removeClass("important");
                            $(this).parents("tr").children("td:eq(6)").find("select").val(appliedleavetype);
                            $(this).parents("tr").children("td:eq(6)").find("select option[value='1'] ").remove();
                            $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', false);
                            alertify.error("Sorry! There is not sufficient paid leave in leave account for this employee");
                            getweakend();
                            return false;
                        }
                        else {
                            earnpaid = parseInt(earnpaid) + 1;
                            $("#lblearnpaid").html(earnpaid);
                            getweakend();
                            return true;
                        }
                    }
                    else {
                        $("#lblearnpaid").html(0);
                        $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").attr('checked', false);
                        $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', false);
                        $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', false);
                        $(this).parents("tr").children("td:eq(6)").find("select").val(appliedleavetype);
                        $(this).parents("tr").children("td:eq(6)").find("select option[value='1'] ").remove();
                        $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', false);
                        $(this).parents("tr").css("background", "#F7F7F7");
                        $(this).parents("tr").children("td").removeClass("important");
                        getweakend();
                        totalpaid = parseInt(totalpaid) - 1
                        $("#totalpaid").html(totalpaid);

                        if (parseInt(totalpaid) > parseInt(available)) {
                            alertify.error("Sorry! There is not sufficient paid leave in leave account for this employee");
                            getweakend();
                            return false;
                        }
                        return false;
                    }
                }
                totaltaklenleave = parseInt(totaltaklenleave) + 1;
                $("#totaltaklenleave").html(totaltaklenleave);
            }
            if (chkpaid == undefined) {

                $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").children("td:eq(4)").find("input[type='checkbox']").prop('checked', false);
                $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").children("td:eq(6)").find("select").val(appliedleavetype);
                $(this).parents("tr").children("td:eq(6)").find("select option[value='1'] ").remove();
                $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', false);
                $(this).parents("tr").css("background", "none");
                $(this).parents("tr").children("td").removeClass("important");
                earnpaid = parseInt(earnpaid) + 1;
                $("#lblearnpaid").html(earnpaid);

                totaltaklenleave = parseInt(totaltaklenleave) - 1;
                $("#totaltaklenleave").html(totaltaklenleave);

                totalpaid = parseInt(totalpaid) - 1
                $("#totalpaid").html(totalpaid);

                getweakend();//Function to cound weakoff or sunday
            }
        });

        //This is call when Unpaid check box checked
        $(".chkunpaid").live("click", function () {

            var chkunpaid = $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").attr('checked');
            earnpaid = $("#lblearnpaid").html();
            totaltaklenleave = $("#totaltaklenleave").html();
            totalunpaid = $("#totalunpaid").html();

            if (chkunpaid == "checked") {
                $(this).parents("tr").children("td:eq(6)").find("select option[value='1'] ").remove();
                $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").children("td:eq(4)").find("input[type='checkbox']").prop('checked', false);
                $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").css("background", "#607B8B");
                $(this).parents("tr").children("td:eq(6)").find("select").val(2);
                $(this).parents("tr").children("td").addClass("important");
                totaltaklenleave = parseInt(totaltaklenleave) + 1;
                $("#totaltaklenleave").html(totaltaklenleave);
                totalunpaid = parseInt(totalunpaid) + 1;
                $("#totalunpaid").html(totalunpaid);
                getweakend();
            }
            if (chkunpaid == undefined) {
                $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").children("td:eq(4)").find("input[type='checkbox']").prop('checked', false);
                $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").css("background", "none");
                $(this).parents("tr").children("td:eq(6)").find("select").val(appliedleavetype);
                $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', false);
                $(this).parents("tr").children("td").removeClass("important");
                totaltaklenleave = parseInt(totaltaklenleave) - 1;
                $("#totaltaklenleave").html(totaltaklenleave);
                totalunpaid = parseInt(totalunpaid) - 1;
                $("#totalunpaid").html(totalunpaid);
                getweakend();
            }

        });

        //This is call when Reject check box checked
        $(".chkreject").live("click", function () {
            var reject = $(this).parents("tr").children("td:eq(5)").find("input[type='checkbox']").attr('checked');
            lblreject = $("#lblreject").html()
            if (reject == "checked") {
                $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', true);
                $(this).parents("tr").css("background", "red");
                $(this).parents("tr").children("td:eq(6)").find("select").append($("<option value='0'>Reject</option>"));
                $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', true).val(0);
                $(this).parents("tr").children("td").addClass("important");
                lblreject = parseInt(lblreject) + 1;
                $("#lblreject").html(lblreject);
                getweakend();
            }
            if (reject == undefined) {
                $(this).parents("tr").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', false);
                $(this).parents("tr").css("background", "none");
                $(this).parents("tr").children("td:eq(6)").find("select").attr('disabled', false);
                $(this).parents("tr").children("td:eq(6)").find("select").val(appliedleavetype);
                $(this).parents("tr").children("td:eq(6)").find("select option[value='0'] ").remove();
                $(this).parents("tr").children("td").removeClass("important");
                lblreject = parseInt(lblreject) - 1;
                $("#lblreject").html(lblreject);
                getweakend();
            }
        });

        function pageLoad() {
            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {
                chkleaveaction();
                return false;
            });
        }

        //Function for validation to check all the leave type is seleted or not
        function chkleaveaction() {

            var gvleavedetails = document.getElementById("<%=gvempleavedetails.ClientID %>");
            var checkchk = 0;
            var paidleave;
            var unpaidleave;
            var reject;
            var leavetype;
            var reject = "";
            for (i = 1; i < gvleavedetails.rows.length; i++) {
                paidleave = $("#chkpaid" + i).attr("checked");
                unpaidleave = $("#chkunpaid" + i).attr("checked");
                reject = $("#reject" + i).attr("checked");
                leavetype = $("#ddlleavetype" + i).val();
                var reject = $("#reject" + i).attr("checked");
                if (reject == "checked") {
                    leavetype = -1;
                }
                if (leavetype == 0) {
                    alertify.error("Select Leave Type For All");
                    return false;
                }

                if (paidleave == "checked" || unpaidleave == "checked" || reject == "checked") {
                    checkchk = checkchk + 1;

                }
                else {
                    checkchk = 0;
                }

            }

            if (checkchk == 0) {
                alertify.error("Please check at least one checkbox for all dates");
                return false;
            }

            else {
                addleave();
            }

        }
        //Function for get details after set levae like how many leave employee applied, in that how many paid,unpaid ,reject
        function getapproveleave(leaveid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/getapprovedleavedetails",
                data: "{ 'leaveid':'" + leaveid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#applyedleave").html(data.d[0].appyleave);
                    $("#approveleave").html(data.d[0].approve);
                    $("#unpaidleave").html(data.d[0].unpaid);
                    $("#paidleave").html(data.d[0].paid);
                },
                error: function (result) {
                    alertify.alert('error');

                }

            });
            call_progressbar("end");
        }
        // Funtion for calling adding function according seleted like paid, unpaid or reject
        function addleave() {

            var gvleavedetails = document.getElementById("<%=gvempleavedetails.ClientID %>");
            empcode = $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(1) td:eq(1)").text();
            var ispaid = 0;
            var totalpaid = 0;
            var totalconfirm = 0;
            var totalunpaid = 0
            var chkleavedate = 0;
            var leavestatus = 0;
            var checkstatus = 0;
            var leavetype = 0;

            for (i = 1; i < gvleavedetails.rows.length; i++) {
                leavetype = $("#ddlleavetype" + i).val();
                var paidleave = $("#chkpaid" + i).attr("checked");
                if (paidleave == undefined) {
                    ispaid = 0;
                }
                var date = $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td:eq(1)").text();
                if (paidleave == "checked") {
                    ispaid = 1;
                    totalpaid = totalpaid + 1;
                    chkleavedate = chkleavedate + 1;
                }

                var confirm = $("#chkconfirm" + i).attr("checked");
                if (confirm == "checked") {
                    saveleave(date, ispaid, empcode, 1, leavetype);
                    totalconfirm = totalconfirm + 1;
                    chkleavedate = chkleavedate + 1;
                    leavestatus = 2;
                    checkstatus = 1;
                }
                var unpaidleave = $("#chkunpaid" + i).attr("checked");
                if (unpaidleave == undefined) {

                }
                if (unpaidleave == "checked") {
                    ispaid = 0;
                    saveleave(date, ispaid, empcode, 1, leavetype);
                    totalunpaid = totalunpaid + 1;
                    chkleavedate = chkleavedate + 1;
                }
                var reject = $("#reject" + i).attr("checked");
                if (reject == "checked") {
                    chkleavedate = chkleavedate + 1;
                    saveleave(date, 2, empcode, 0, 0); // 2 in place of ispaid when leave reject by admin
                }
                if (checkstatus == 0) {
                    leavestatus = 3;
                }
            }

            if (chkleavedate == "0") {
                alertify.error('Please select at least one date for action');
                return false
            }

            var adminremark = $("#ctl00_ContentPlaceHolder1_txtRemark").val();
            var leavesid = $("#ctl00_ContentPlaceHolder1_leaveid").val();
            saverequestlerave(totalpaid, totalconfirm, totalunpaid, leavestatus, adminremark, leavesid);
        }
        //Function to save leave in leave history table date by date.
        function saverequestlerave(totalpaid, totalconfirm, totalunpaid, leavestatus, adminremark, leavesid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/saveleaverequest",
                data: "{ 'totalpaid':'" + totalpaid + "', 'totalconfirm':'" + totalconfirm + "', 'totalunpaid':'" + totalunpaid + "', 'leavestatus':'" + leavestatus + "', 'adminremark':'" + adminremark + "', 'leaveid':'" + leavesid + "'}",
                dataType: "json",
                success: function (data) {
                    alertify.success('Leave updated Successfully');
                    $("#divgetleavedetails").show(500);
                    $("#ctl00_ContentPlaceHolder1_gvempleavedetails").hide(500);
                    $("#divpostreview").hide(500);
                    $("#getindicators").hide(500);
                    $("#ctl00_ContentPlaceHolder1_gvtlcomments").hide(500);
                    getapproveleave(leavesid);
                    var email = $("#emailid").html();
                    if (leavestatus == 1 || leavestatus == 2) {
                        leavestatus = "Your leave has been Approved"
                    }
                    else {
                        leavestatus == "Your leave has been Rejected";
                    }
                    call_progressbar("end");
                    sendleaveupdate(email, leavestatus);

                },
                error: function (result) {
                }
            });
        }
        //Function to update leave status from Admin like the leave is reject or approve.
        function saveleave(date, ispaid, empcode, approve, leavetype) {
            var lid = $("#ctl00_ContentPlaceHolder1_leaveid").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/saveleave",
                data: "{ 'date':'" + date + "', 'empcode':'" + empcode + "', 'ispaid':'" + ispaid + "', 'approve':'" + approve + "', 'leaveid':'" + lid + "', 'leavetype':'" + leavetype + "'}",
                dataType: "json",
                success: function (data) {

                },
                error: function (result) {
                }
            });
        }
        function getsunday() {

            var getgrd = document.getElementById("<%=gvempleavedetails.ClientID %>");
            var currentdate = new Date();
            var dayname = currentdate.getDay();
            for (i = 1; i < getgrd.rows.length; i++) {
                var a = $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq('" + i + "') td:eq(1)").html();
                var leavedate = new Date(a);
                var leaveday = leavedate.getDay();

                if (leaveday == "0") {
                    $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq('" + i + "')").addClass("weakoff");
                }
            }
        }
        //Function to checkweakendoroff
        function getweakend() {
            getsunday();
            var getleavedate = "";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/getsandwichleave",
                data: "{'fromdate':'" + leavefrom + "','todate':'" + leavetp + "'}",
                datatype: "json",
                success: function (data) {

                    for (i = 0; i < data.d.length; i++) {
                        var j = 1;
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr").each(function () {
                            getleavedate = $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq('" + j + "') td:eq(1)").html();
                            if (getleavedate == data.d[i].holidaydate) {
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq('" + j + "')").addClass("weakoff");
                            }
                            j = j + 1;
                        });

                    }

                },
                error: function (result) {
                    alertify.error('some error');
                }
            });

        }
        //Bind all the list of holiday
        function Gethollydays() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/getholidaysdate",
                data: "{}",
                datatype: "json",
                success: function (data) {
                    var currentdate = new Date();
                    var date = currentdate.getDate();
                    var month = currentdate.getMonth() + 1;
                    var year = currentdate.getFullYear();
                    currentdate = date + "/" + month + "/" + year;
                    for (var i = 0; i < data.d.length; i++) {
                        var holidaydate = data.d[i].holidaydate;
                    }
                },
                error: function (result) {

                }
            });
        }
        //Function to fill all details about specific leave
        function getleavesdetails(leaveid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/getleavesdetailss",
                data: "{'leaveid':'" + leaveid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_gvleavedetails").empty();
                    $("#getindicators").show(500);
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_gvleavedetails").append("<tr class='stm_head'><th>S No.</th><th>Last Leave</th><th>Leave Applied</th><th>Leave From</th><th>Leave To</th><th>Leave Type</th></tr>");
                        for (var i = 0; i < data.d.length; i++) {
                            var latleave = data.d[i].lastleave;

                            if (latleave == "01 Jan 1900") {
                                latleave = "N/A"
                            }
                            $("#ctl00_ContentPlaceHolder1_gvleavedetails").append("<tr><td>" +
                                 1 + "</td><td style='display:none'>" +
                                data.d[i].empid + "</td><td style='display:none'>" +
                                data.d[i].name + "</td><td>" +
                                latleave + "</td><td>" +
                                data.d[i].leaveapplydate + "</td><td>" +
                                data.d[i].leavefrom + "</td><td>" +
                                data.d[i].leaveto + "</td><td>" +
                                data.d[i].leavetype + " </td></tr>");

                            $("#ctl00_ContentPlaceHolder1_txtreson").text(data.d[i].leavereson);

                            leavefrom = data.d[i].leavefrom;
                            leavetp = data.d[i].leaveto;
                            getempleavedetails(leavefrom, leavetp);
                            gettotalleave(data.d[i].empid);
                        }
                        gettlcomments(leaveid);

                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        // Function for get leave date by date
        function getempleavedetails(fromdate, todate) {
            call_progressbar("start");
            $("#ctl00_ContentPlaceHolder1_gvempleavedetails").show(500);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/getempleavedetails",
                data: "{ 'fromdate':'" + fromdate + "', 'todate':'" + todate + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_gvempleavedetails").empty();
                    stat = $("#ctl00_ContentPlaceHolder1_gvleavedetails tr td:eq(7)").html();
                    if (data.d.length > 0) {
                        var j = 1;
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails").append("<tr class='stm_head' style='width:100%; text-align:center'><th style='width:10%'>S No.</th><th  style='width:30%' >Date </th><th style='width:10%'>Paid</th><th style='width:10%'>Unpaid</th><th style='width:10%; display:none'>Confirm</th><th style='width:10%'>Reject</th><th style='width:20%'>Type</th></tr>");
                        for (var i = 0; i < data.d.length; i++) {

                            $("#ctl00_ContentPlaceHolder1_gvempleavedetails").append("<tr><td>" +
                                 j + "</td><td>" +
                                 data.d[i].date + "</td><td>" +
                                 '<input type="checkbox" class="chkpaid" id="chkpaid' + j + '" name="chkpaid" />' + "</td><td>" +
                                 '<input type="checkbox"  class="chkunpaid" id="chkunpaid' + j + '" name="chkunpaid" />' + "</td><td style='display:none'>" +
                                 '<input type="checkbox" disabled ="disabled" class="chkconfirm" id="chkconfirm' + j + '" name="chkconfirm" />' + "</td><td>" +
                                 '<input type="checkbox" class="chkreject" id="reject' + j + '" name="chkreject" />' + "</td><td>" +
                                 '<Select id="ddlleavetype' + j + '" name="ddlleave"><option value="0">-Select Type-</option>' +
                                 '<option value="1">Annual</option>' +
                                 '<option value="2">Casual</option>' +
                                 '<option value="3">Emergency  </option>' +
                                 '<option value="5">Sick </option></select> ' + "</td></tr>");
                            $("#divpostreview").show(500);

                            if (stat.trim() == "Annual") {
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ") td:eq(6)").find("select").val(1);
                                $("#chkpaid" + j).prop("checked", true);
                                $("#chkconfirm" + j).prop("checked", true);
                                $("#ddlleavetype" + j).attr('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").css("background", "#46B525");
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(3)").find("input[type='checkbox']").prop('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                                appliedleavetype = 1;
                            }
                            if (stat.trim() == "Casual") {
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ") td:eq(6)").find("select").val(2);
                                $("#chkunpaid" + j).prop("checked", true);
                                $("#chkconfirm" + j).prop("checked", true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").css("background", "#607B8B");
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                                appliedleavetype = 2
                            }
                            if (stat.trim() == "Emergency") {
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ") td:eq(6)").find("select").val(3);
                                $("#chkunpaid" + j).prop("checked", true);
                                $("#chkconfirm" + j).prop("checked", true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").css("background", "#607B8B");
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                                appliedleavetype = 3
                            }
                            if (stat.trim() == "Sick") {
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ") td:eq(6)").find("select").val(5);
                                $("#chkunpaid" + j).prop("checked", true);
                                $("#chkconfirm" + j).prop("checked", true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").css("background", "#607B8B");
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(2)").find("input[type='checkbox']").prop('disabled', true);
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + j + ")").children("td:eq(5)").find("input[type='checkbox']").prop('disabled', true);
                                appliedleavetype = 5
                            }
                            j++;
                        }
                        getweakend();
                        call_progressbar("end");
                    }

                },
                error: function (result) {
                    call_progressbar("end");
                },

            });
        }
        //Function for get leave history like employee's total paid, Earn paid, Reject etc.
        function gettotalleave() {
            var employeecode = $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(1) td:eq(1)").html();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/gettotalleave",
                data: "{ 'empcode':'" + employeecode + "'}",
                dataType: "json",
                success: function (data) {
                    $("#totaltaklenleave").html(data.d[0].totalleave);
                    $("#totalpaid").html(data.d[0].totalpaid);
                    $("#totalunpaid").html(data.d[0].totalunpaid);
                    $("#lblreject").html(data.d[0].totalreject);
                    $("#available").html(data.d[0].Available);
                    $("#lblearnpaid").html(data.d[0].Earnpaid);
                    $("#emailid").html(data.d[0].emailid);
                    earnedpaid = $("#lblearnpaid").html();
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        // Funtion for bind grid for all comments from TL related to that leave
        //function gettlcomments(leaveid) {
        //    $("#ctl00_ContentPlaceHolder1_gvtlcomments").show(500);
        //    $.ajax({
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        url: "requestleavelist.aspx/tlcomment",
        //        data: "{ 'leaveid':'" + leaveid + "'}",
        //        dataType: "json",
        //        success: function (data) {
        //            $("#ctl00_ContentPlaceHolder1_gvtlcomments").empty();
        //            if (data.d.length > 0) {
        //                var j = 1;
        //                $("#ctl00_ContentPlaceHolder1_gvtlcomments").append("<tr class='stm_head' style='width:100%'><th style='width:10%; text-align:center'>S No.</th><th style='width:30%; text-align:center'>TL Name</th><th style='width:30%; text-align:center'>TL Comment </th><th style='width:30%; text-align:center'>Project Name </th></tr>");
        //                for (var i = 0; i < data.d.length; i++) {

        //                    $("#ctl00_ContentPlaceHolder1_gvtlcomments").append("<tr><td>" +
        //                         j + "</td><td>" +
        //                         data.d[i].tlname + "</td><td>" +
        //                         data.d[i].comment + "</td><td>" +
        //                         data.d[i].projname + "</td></tr>");
        //                    j++;
        //                }
        //            }
        //        },
        //        error: function (result) {
        //        },
        //    });
        //}
        //Function for send email to Employee after confirmation or rejection of that leave
        function sendleaveupdate(email, levaeupdate) {
            debugger;
            var chkmail = $("#ctl00_ContentPlaceHolder1_chsendmail").attr("checked");
            if (chkmail == "checked") {
                var subject = "Leave Update by Admin";
                call_progressbar("start");
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "requestleavelist.aspx/SendMailemp",
                    data: "{'emailid':'" + email + "','subject':'" + subject + "','msg':'" + levaeupdate + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (parseInt(data.d) == 1) {
                            var mode = 2, MessageModule = "Leave Management", shortlist_id = 0;
                            insert_email_history(eid, empcode, MobileNo, email, levaeupdate, subject, MessageModule, mode, shortlist_id)
                            call_progressbar("end");
                        }
                        return false;
                    },
                    error: function (response) {
                        call_progressbar("end");
                    }

                });
            }

        }

        //Function To save email history
        function insert_email_history(eid, empcode, MobileNo, email, levaeupdate, subject, MessageModule, mode, shortlist_id) {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../Comman.aspx/Maintain_Sms_Email_Log",
                data: "{'eid':'" + eid + "','Refno':'" + empcode + "','MobileNo':'" + MobileNo + "','email_id':'" + email + "','msg':'" + levaeupdate + "','subject':'" + subject + "','MessageModule':'" + MessageModule + "','mode':'" + mode + "','shortlist_id':'" + shortlist_id + "'}",
                dataType: "json",
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        alertify.success("This SMS history has been maintained");

                    }
                    if (parseInt(data.d) == 2) {
                        alertify.success("This mail history has been maintained");
                    }
                }
            });

        }

        //Function for fil grid after According search Feild.
        function BindGridMain() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleavelist.aspx/BindDatatable",
                data: "{'fname':'" + fname + "','datefirst':'" + datefirst + "','datesecond':'" + datesecond + "','leavetype':'" + leavetype + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_gvleavedetails").show(500);
                        $("[id*=gvleavedetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvleavedetails] tr:eq(1)").clone(true);
                            $("[id$=gvleavedetails]").append(row);
                            $(row).find('.index').html(j);
                            $(row).find('.refNo').html(data.d[i].refNo);
                            $(row).find('.name').html(data.d[i].name);
                            $(row).find('.Leave_Start_From').html(data.d[i].Leave_Start_From);
                            $(row).find('.Leave_Apply_Date').html(data.d[i].Leave_Apply_Date);
                            $(row).find('.Leave_Type').html(data.d[i].Leave_Type);
                            $(row).find('.leave_status').html(data.d[i].leave_status);
                            $(row).find("input[type=hidden][id*=hfid]").val(data.d[i].leaveid);
                            $(row).find("input[type=hidden][id*=userid]").val(data.d[i].eid);
                            j = j + 1;
                        }
                        $("[id*=gvleavedetails] tr").show();
                        $("[id*=gvleavedetails] tr:eq(1)").hide();
                    }
                    else {
                        alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_gvleavedetails").hide(500);
                    }
                    call_progressbar("end");
                },

                error: function (result) {
                    call_progressbar("start");
                }
            });
        }
    </script>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Leave Managment</a></li>
            <li style="background: none;"><a class="active" href="requestleavelist.aspx">Applied Leaves</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div id="usercontrol">
            <UC1:emp runat="server" ID="empuser" />
            <UC:employee runat="server" ID="userctl" />
        </div>

        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">New Leaves </label>
            <label id="applynewleave" style="display: none">Apply For Leave </label>
            <a id="getleavesgrid" title="Get Leave List" style="cursor: pointer; display: none; color: #fff; float: right; margin-right: 20px;">Back</a>
        </div>
        <div id="griddetails" style="float: left; width: 100%;">
            <div class="containerHeadline" style="width: 100%">

                <div style="float: right; width: 1000px;" id="search">

                    <asp:DropDownList ID="ddlleavetype" runat="server" Width="95px" Style="float: right" Font-Size="12px">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtcontactno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave Applied"> </asp:TextBox>
                    <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave From" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtempname" runat="server" Width="120px" Font-Size="12px" placeholder="Emp Name" Style="float: right" Height="23px"> </asp:TextBox>
                </div>
            </div>
            <asp:TextBox runat="server" ID="leaveid" Style="display: none"></asp:TextBox>
            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leaves taken yet."
                PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnPageIndexChanging="gvleavedetails_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:HiddenField runat="server" ID="userid" Value='<%# Eval("eid") %>' />
                            <asp:Label ID="sno" runat="server" CssClass="index" Text="<%#Container.DataItemIndex+1 %>">  </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp ID">
                        <ItemTemplate>
                            <asp:Label ID="sno2" runat="server" Text='<%#Eval("refNo") %>' CssClass="refNo"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                        <ItemTemplate>
                            <asp:Label ID="sno1" runat="server" Text='<%#Eval("name") %>' CssClass="name"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Applied">
                        <ItemTemplate>
                            <asp:Label ID="sno4" runat="server" Text='<%#Eval("Leave_Apply_Date","{0:dd/MM/yyyy}") %>' CssClass="Leave_Apply_Date"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                        <ItemTemplate>
                            <asp:Label ID="sno3" runat="server" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>' CssClass="Leave_Start_From"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Type">
                        <ItemTemplate>
                            <asp:Label ID="sno5" runat="server" Text='<%#Eval("Leave_Type") %>' CssClass="Leave_Type"> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Action">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfid" runat="server" Value='<%#Eval("Leaveid")%>' />
                            <a class="getdetails" title="Click here to get details" style="cursor: pointer; color: #000;">Get Details</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>

            <%--<div align="left" style="width: 1070px" class="containerHeadline">
                <div style="margin-left: 0px; float: left; width: 500px;">
                    <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <asp:Label ID="Label1" runat="server" Text="1" Style="color: green; font-size: 11pt"></asp:Label>
                    Of
                <asp:Label ID="lblTotalPages" Text="1" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <span style="font-size: 11pt">Page</span>
                </div>

                <div style="margin-left: 0px; float: left; width: 500px;">
                    <img src="../../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                </div>
            </div>--%>
            <br />
            <br />
            <div style="float: left; width: 50%; margin-left: 20%; margin-bottom: 20px; display: none" id="divgetleavedetails">
                <div style="height: 15px; width: 106px; background: #2B81EE; float: left; margin-left: 10Px; color: white; padding: 5px">
                    Applied Leave:
                    <label id="applyedleave"></label>
                </div>
                <div style="height: 15px; width: 114px; background: #DA542D; float: left; margin-left: 10Px; color: white; padding: 5px">
                    Approved Leave:
                    <label id="approveleave"></label>
                </div>
                <div style="height: 15px; width: 115px; background: #607B8B; float: left; margin-left: 10Px; color: white; padding: 5px">
                    Unpaid Leave:
                    <label id="unpaidleave"></label>
                </div>
                <div style="height: 15px; width: 88px; background: #46B525; float: left; margin-left: 10Px; color: #333; padding: 5px">
                    Paid Leave:
                    <label id="paidleave"></label>
                </div>
                <div class="for_sigle_row_form" style="margin-top: 40px; margin-left: -40px;">
                    <label>
                    </label>
                    <asp:Button runat="server" ID="btnback" Text="Go Back" OnClick="btnback_Click" CssClass="button_save" />
                </div>
            </div>
            <div style="float: left; display: none" id="getindicators">

                <div style="height: 15px; text-align: center; width: 140px; background: #F0953F; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                    Max Paid/Year:<label id="available"></label>
                    <label id="emailid" style="display: none"></label>
                </div>
                <br />

                <div style="height: 15px; text-align: center; width: 140px; background: #433DAA; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">Earned  Paid:<label id="lblearnpaid"></label></div>
                <br />
                <div style="text-align: center; height: 15px; width: 140px; background: #0DB3BD; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                    Total Leave Taken:
                    <label id="totaltaklenleave"></label>
                </div>
                <br />
                <div style="height: 15px; text-align: center; width: 140px; background: #46B525; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                    Total Paid Taken:
                    <label id="totalpaid"></label>
                </div>
                <br />
                <div style="height: 15px; text-align: center; width: 140px; background: #607B8B; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                    Total Unpaid:
                    <label id="totalunpaid"></label>
                </div>
                <br />
                <div style="height: 15px; text-align: center; width: 140px; background: #FF0000; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">
                    Total Reject:
                    <label id="lblreject"></label>
                </div>
            </div>
            <div style="width: 50%; margin-left: 25%">

                <asp:GridView runat="server" ID="gvempleavedetails" AllowPaging="true" Style="display: none" EmptyDataText="No Leaves Deatils."
                    PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                            <ItemTemplate>
                                <asp:Label ID="sno3" runat="server" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>'> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
                <br />
                <br />
                <asp:GridView runat="server" ID="gvtlcomments" AllowPaging="true" Style="display: none" EmptyDataText="No Leaves Deatils."
                    PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                            <ItemTemplate>
                                <asp:Label ID="sno3" runat="server" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>'> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
            </div>
        </div>
        <div class="clear"></div>
        <div id="divpostreview" style="display: none">
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Emp Name</label>
                <asp:TextBox ID="txtname" runat="server" ReadOnly="true"></asp:TextBox>
                <asp:HiddenField runat="server" ID="hfleaveid" />
            </div>
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Employee ID</label>
                <asp:TextBox ID="txtempid" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Last Leave Date</label>
                <asp:TextBox ID="txtlastapply" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Start Date</label>
                <asp:TextBox ID="txtstartdate" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Resume Date</label>
                <asp:TextBox ID="txtenddate" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Apply Date</label>
                <asp:TextBox ID="txtapplydate" runat="server" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form" style="display: none">
                <label>
                    Leave Type</label>
                <asp:TextBox ID="txtleavetype" runat="server" ReadOnly="true"></asp:TextBox>
            </div>

            <div runat="server" id="divReply">
                <br />
                <br />
                <div class="for_sigle_row_form" style="width: 75%">
                    <label>
                        Reason</label>
                    <asp:TextBox ID="txtreson" runat="server" TextMode="MultiLine" Style="width: 299px; height: 72px;"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form" style="width: 75%; display: none">
                    <label>
                        Leave Status<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlleavesatus">
                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                        <asp:ListItem Value="2">Approved</asp:ListItem>
                        <asp:ListItem Value="3">Reject</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form" style="width: 75%">
                    <label>
                        Remarks</label>
                    <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Style="width: 299px; height: 72px;"></asp:TextBox>
                </div>
            </div>
            <div class="for_sigle_row_form" id="forlabel" style="width: 75%">
                <label>
                </label>
                <asp:Button runat="server" ID="btnSubmit" Text="Set Leave" CssClass="button_save" />
                <asp:CheckBox runat="server" ID="chsendmail" Checked="true" Text="Send Mail" Style="float: right" />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Label runat="server" ID="lblmsg" ForeColor="Chocolate" Font-Size="21px"></asp:Label>
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>