<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="requestleave.aspx.cs" Inherits="EmployeePanel_requestleave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />

    <style type="text/css">
        .leaveactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .Highlighted a {
            background-color: #FFFF00 !important;
            pointer-events: none;
        }

            .Highlighted a:hover {
                color: #ff0000 !important;
                pointer-events: none;
            }

        .active6 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
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

        td {
            border-bottom: 1px black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }

        .ui-datepicker table {
            border-collapse: collapse;
            font-size: 0.7em;
            margin: 0 0 0.4em;
            width: 100%;
        }

        .ui-datepicker-multi-2 .ui-datepicker-group {
            width: 45%;
        }

        .col-md-9 select {
            border: 1px solid #ccc;
            border-radius: 0 !important;
            color: #676767;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 293px;
        }

        .col-md-9 textarea {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 64px;
            line-height: 20px;
            margin-bottom: 0;
            margin-top: 0;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 300px;
        }

        .col-md-9 label {
            color: #616161;
            float: left;
            font-size: 13px;
            margin-right: 20px;
            padding-top: 2px;
            text-align: right;
            width: 123px;
        }

        body {
            color: #333333;
            font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 13px;
            line-height: 1.42857;
        }

        .stm_head th {
            font-size: 13px;
        }

        .texthover {
            border: 1px solid red !important;
        }
    </style>
    <script type="text/javascript">
        var lastleave = "", datefirst = '', datesecond = '', leavetype = '', diff = "", Highlight;
        $(document).ready(function () {
            var getleavedate = "", leavefrom = "", leaveto = "";
            var SelectedDates = {};
            leavefrom = "01 Apr 2017";
            leaveto = "31 Mar 2018";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleave.aspx/gethalidays",
                data: "{'fromdate':'" + leavefrom + "','todate':'" + leaveto + "'}",
                datatype: "json",
                success: function (data) {
                    for (i = 0; i < data.d.length; i++) {
                        getleavedate = data.d[i].holidaydate;
                        SelectedDates[new Date(getleavedate)] = new Date(getleavedate);
                    }
                },
                error: function (result) {
                    alertify.error('There is some technical issue');
                }
            });

            $('#ctl00_head_txthddate').datepicker({
                beforeShowDay: function (date) {
                    Highlight = SelectedDates[date];
                    if (Highlight) {
                        return [true, "Highlighted", "Holiday"];
                    }
                    else {
                        return [true, '', ''];
                    }
                },
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 1,
                yearRange: '2017:2018',
                minDate: new Date(),
                dateFormat: "d MM yy",
            });
            $("#ctl00_head_txtreferenceno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2017:2018',
                dateFormat: "d MM yy",
            });
            $("#ctl00_head_txtcontactno").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2017:2018',
                dateFormat: "d MM yy",
            });
            $("#ctl00_head_txtlast").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2017:2018',
                dateFormat: "d MM yy",
            });

            $('#ctl00_head_txtlast').on('change keyup paste', function () {
                lastleave = $(this).val();
                BindGridMain();
                setleavestatus();
            });
            $('#ctl00_head_txtreferenceno').on('change keyup paste', function () {
                datefirst = $(this).val();
                BindGridMain();
                setleavestatus();

            });
            $('#ctl00_head_txtcontactno').on('change keyup paste', function () {
                datesecond = $(this).val();
                BindGridMain();
                setleavestatus();

            });
            $('#ctl00_head_ddlleavetypes').on('change', function () {
                leavetype = $(this).val();
                BindGridMain();
                setleavestatus();

            });

            chkapplyedleave();
            gettotalleave();

            var lastdate = $("#ctl00_head_txtlastleave").val();
            if (lastdate == "01 January 1900") {
                lastdate = new Date();
            }
            $("#ctl00_head_txtleavestart").datepicker({
                beforeShowDay: function (date) {
                    Highlight = SelectedDates[date];
                    if (Highlight) {
                        return [true, "Highlighted", "Holiday"];
                    }
                    else {
                        return [true, '', ''];
                    }
                },

                changeMonth: true,
                changeYear: true,
                yearRange: '2017:2018',
                dateFormat: "d MM yy",
                numberOfMonths: 1,
                maxDate: new Date('2018-03-31'),
                minDate: new Date(lastdate),
                onClose: function (selectedDate) {
                    $("#ctl00_head_txtresume").datepicker("option", "minDate", selectedDate);
                    $("#resumd").show(500);
                },

            });
            $("#ctl00_head_txtresume").datepicker({
                beforeShowDay: function (date) {
                    Highlight = SelectedDates[date];
                    if (Highlight) {
                        return [true, "Highlighted", "Holiday"];
                    }
                    else {
                        return [true, '', ''];
                    }
                },
                changeMonth: true,
                changeYear: true,
                yearRange: '2017:2018',
                dateFormat: "d MM yy",
                maxDate: new Date('2018-03-31'),
                onClose: function (selectedDate) {
                    $("#ctl00_head_txtleavestart").datepicker("option", "maxDate", selectedDate);
                }
            });

            $("#ctl00_head_txtresume").change(function () {
                checkresumedate();
                var resumedate = $(this).val();
                resumedate = new Date(resumedate);
                var dayname = resumedate.getDay();
                if (parseInt(dayname) == 0) {
                    alertify.error('This is weak off.Select another date');
                    $(this).val('');
                    return false;
                }
            });
            $("#ctl00_head_txtleavestart").change(function () {
                sandwich();
            })

            $("#ctl00_head_ddlleavetype").change(function () {
                var getdatediff = checkresumedate();
                if (getdatediff == false) {
                    return false;
                }
                if (getdatediff == true) {
                    var str1 = $("#ctl00_head_txtleavestart").val();
                    var str2 = $("#ctl00_head_txtresume").val();
                    if (str2 == "") {
                        alertify.error("Please select resume date");
                        $("#ctl00_head_ddlleavetype").val(0);
                        return false;
                    }
                    diff = Math.floor((Date.parse(str2) - Date.parse(str1)) / 86400000);
                    $("#noofleave").show(500);
                    $('#noofleave').html('Total number of leave ' + diff);
                    var type = $(this).val()
                    if (parseInt(type) == parseInt(1)) {

                        var checkpaid = checkearnleave(diff);
                        if (checkpaid == false) {
                            $("#ctl00_head_ddlleavetype").val(0);
                            return false
                        }
                        if (checkpaid == true) {
                            return true;
                        }
                    }
                    return true;
                }
            });

            $("#ctl00_head_txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "d MM yy",
            });

            $("#ctl00_head_btnSubmit").click(function () {

                var status = validationforgo();
                if (status == true) {
                    if (confirm("Are you sure want to apply this leave?\nNote: You can not do any change after apply.") == true) {

                    }
                    else {
                        return false;
                    }
                }
                if (status == false) {
                    return false;
                }

            });

            $("#ctl00_head_btnapplyhalfday").click(function () {

                var gethalfstatus = validatehalfday();

                if (gethalfstatus == false) {
                    return false;
                }
                else { return true; }
            });

            //This button to update the alredy applied leave
            $("#ctl00_head_btnupdate").click(function () {
                var status = validationforgo();
                if (status == false) {
                    return false;
                }
            });

            $("#applyleave").click(function () {

                var chkstatus = $("#chkapplyedleave").html();
                if (chkstatus == "0") {

                    $("#divapplyleave").show(500);
                    $("#getlist").show(500);
                    $("#btninsert").show(500);
                    $("#applynewleave").show(500);

                    $("#griddetails").hide(500);
                    $("#applyleave").hide(500);
                    $("#leavdetailsbin").hide(500);
                    $("#leavedet").hide(500);
                    $("#divupdate").hide(500);
                    $("#apllyfornewhalfday").hide(500);

                    $("#ctl00_head_txtleavestart").val("");
                    $("#resumd").css("display", "none");
                    $("#ctl00_head_txtreson").val("");
                    $("#ctl00_head_ddlleavetype").val("0");
                    gettotalleave(); //Function for get leave history
                }
                else {
                    alertify.error("Your Last Request is Pending");
                }

            });

            $("#getlist").click(function () {
                $("#griddetails").show(500);
                $("#applyleave").show(500);
                $("#leavdetailsbin").show(500);
                $("#applyhalfday").show(500);

                $("#divapplyleave").hide(500);
                $("#getlist").hide(500);
                $("#applynewleave").hide(500);
                $("#applyhalfdayleave").hide(500);
                $("#apllyfornewhalfday").hide(500);

            });

            //Set all the details about leave history
            $(".getleavedetails").click(function () {

                $("#leavedet").show(500);
                $("#griddetails").hide(500);

                var leaveid = $(this).parents("tr").children("td:eq(1)").find("input[type='hidden']").val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "requestleave.aspx/getleavesdetailss",
                    data: "{ 'leaveid':'" + leaveid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("#ctl00_head_txtleaveapplyed").val(data.d[0].leaveappy);
                        $("#applyedleave").html(data.d[0].noofleave);
                        $("#approveleave").html(data.d[0].noofapproveleave);
                        $("#paidleave").html(data.d[0].noofpl);
                        $("#unpaidleave").html(data.d[0].nooflwp);
                        $("#rejectleave").html(data.d[0].reject);
                        $("#ctl00_head_txtadmin").val(data.d[0].adminremark);

                        var getappleave = $("#approveleave").html();
                        var Paid = $("#paidleave").html();
                        var unpaid = $("#unpaidleave").html();
                        var admin = $("#ctl00_head_txtadmin").val();

                        if (getappleave == "") {
                            $("#applyedleave").html("N/A");
                        }
                        if (Paid == "") {
                            $("#approveleave").html("N/A");
                        }
                        if (unpaid == "") {
                            $("#unpaidleave").html("N/A");
                        }
                        if (admin == "") {
                            $("#ctl00_head_txtadmin").val("There is not any remark by Admin");
                        }

                        //getdatewisedetails(leaveid);

                    },
                    error: function (result) {
                        alertify.error('error');
                    },
                });

            });

            //Go Back after submit the leave
            $("#ctl00_head_btnback").click(function () {
                $("#leavedet").hide(500);
                $("#griddetails").show(500);
                return false;
            });

            //Edit for Applyed Leave. Do not remove this function. if client we can open this function according importance.
            $(".btedit").click(function () {
                var leaveid = $(this).parents("tr").find("input[type='hidden']").val();
                $("#griddetails").css("display", "none");
                $("#divapplyleave").css("display", "block");
                $("#getlist").css("display", "block");
                $("#applyleave").css("display", "none");
                $("#leavdetailsbin").css("display", "none");
                $("#applynewleave").css("display", "block");
                $("#leavedet").css("display", "none");
                $("#resumd").css("display", "block");
                $("#btninsert").css("display", "none");
                $("#divupdate").css("display", "block");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "requestleave.aspx/getleavesdetailss",
                    data: "{ 'leaveid':'" + leaveid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("#ctl00_head_txtleavestart").val(data.d[0].startdate);
                        $("#ctl00_head_txtresume").val(data.d[0].resumedate);
                        $("#ctl00_head_ddlleavetype").val(data.d[0].lttype);
                        $("#ctl00_head_txtreson").val(data.d[0].reson);
                        //$("#ctl00_head_txtaddress").val(data.d[0].contactaddress);
                        $("#ctl00_head_hfleaveid").val(data.d[0].leaveid);

                    },
                    error: function (result) {
                        alertify.error('error');
                    },
                });
                return false;
            });

            $("#applyhalfday").click(function () {

                $("#applyhalfdayleave").show(500);
                $("#apllyfornewhalfday").show(500);
                $("#griddetails").hide(500);
                $("#leavdetailsbin").hide(500);
                $("#leavedet").hide(500);
                $("#divupdate").hide(500);
                $("#divapplyleave").hide(500);
                $("#getlist").show(500);

                $(this).hide(500);
            });

            setleavestatus();

        });
        //function to add categories paid unpaid and reject leave
        function getdatewiseleaves() {

            var gvDrv = document.getElementById("<%=gvempleavedetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {
                var leavestatus = $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") td:eq(2)").html();
                var paystatus = $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") td:eq(3)").html();

                if (leavestatus == "Approved") {
                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") ").css("background", "#46B525");
                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");
                }
                if (leavestatus == "Reject") {

                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") ").css("background", "red");
                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");

                }
                if (paystatus == "Unpaid") {
                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") ").css("background", "#607B8B");
                    $("#ctl00_head_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");
                }
            }
        }
        //Function to check Resume date
        function checkresumedate() {
            var todate = $("#ctl00_head_txtresume").val();
            var fromdate = $("#ctl00_head_txtleavestart").val();
            if (todate != "" || fromdate != "") {
                if (todate == fromdate) {
                    alertify.error('Both Dates are same. Select any other date');
                    $("#ctl00_head_txtresume").val('');
                    return false;
                }
                else {
                    return true;
                }
            }
            else {
                alertify.error('Please select leave date.');
                $("#ctl00_head_ddlleavetype").val('');
                return false;
            }
        }
        //Function to check Earn Paid Leave
        function checkearnleave(diff) {

            var earnleave = $("#lblearnpaid").html();
            if (parseInt(earnleave) < parseInt(diff)) {
                alertify.error("You don't have sufficient Annual leave");
                $("#noofleave").hide(500);
                return false;
            }
            else {
                return true;
            }
        }
        //Function to add Sandwich Rule in Leave
        function sandwich() {
            var date = $("#ctl00_head_txtleavestart").val();
            var getdate = new Date(date);
            var day = getdate.getDay();
            if (parseInt(day) == parseInt(1)) {
                getdate = getdate.setDate(getdate.getDate() - 1)
                var newdate = new Date(getdate);
                var myText = $.datepicker.formatDate("d MM yy", newdate);
                alertify.confirm("Selected date is Monday so Sunday will be also mark as leave", function (e) {
                    if (e) {
                        $("#ctl00_head_txtleavestart").val(myText);
                    } else {
                        return false;
                    }
                });

            }
            if (parseInt(day) == parseInt(6)) {
                alertify.alert('Selected date is Saturday so Sunday will be also mark as leave');
            }
            if (parseInt(day) == parseInt(0)) {
                alertify.confirm("Selected date is Sunday", function (e) {
                    if (e) {
                        $("#ctl00_head_txtleavestart").val(myText);
                    } else {
                        $("#ctl00_head_txtleavestart").val('');
                    }
                });

            }
        }
        //Function To get leaves details one by one date
        function getdatewisedetails(leaveid) {

            $("#divdatewiseleave").css("display", "block");
            $("#divgetleavedetailsonebyone").css("display", "block");
            var status;

            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleave.aspx/getempleavedetails",
                data: "{ 'leaveid':'" + leaveid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_head_gvempleavedetails").empty();
                    if (data.d.length > 0) {
                        var j = 1;

                        $("#ctl00_head_gvempleavedetails").append("<tr class='stm_head'><th style='text-align:center'>S No.</th><th style='text-align:center'>Date </th><th style='text-align:center'>Status</th><th style='text-align:center'>Type</th></tr>");
                        for (var i = 0; i < data.d.length; i++) {
                            if (data.d[i].approve == "Reject") {
                                data.d[i].ispaid = "";
                            }
                            $("#ctl00_head_gvempleavedetails").append("<tr><td>" +
                                 j + "</td><td>" +
                                 data.d[i].date + "</td><td>" +
                                 data.d[i].approve + "</td><td>" +
                                 data.d[i].ispaid + "</td></tr>");
                            j++;
                        }
                    }
                    getdatewiseleaves();
                },
                error: function (result) {

                    alertify.error('error');
                },
            });
        }
        //Function to check alll leave history like total leave taken availble paid etc.
        function gettotalleave() {
            var employeecode = $("#ctl00_head_hfempcode").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleave.aspx/gettotalleave",
                data: "{ 'empcode':'" + employeecode + "'}",
                dataType: "json",
                success: function (data) {

                    $("#totaltaklenleave").html(data.d[0].totalleave);
                    $("#totalpaid").html(data.d[0].totalpaid);
                    $("#totalunpaid").html(data.d[0].totalunpaid);
                    $("#lblreject").html(data.d[0].totalreject);
                    $("#available").html(data.d[0].Available);
                    $("#lblearnpaid").html(data.d[0].Earnpaid);

                    $("#Label1").html($("#available").html());
                    $("#Label2").html($("#lblearnpaid").html());
                    $("#Label3").html($("#totaltaklenleave").html());
                    $("#Label4").html($("#totalpaid").html());
                    $("#Label5").html($("#totalunpaid").html());
                    $("#Label6").html($("#lblreject").html());
                },
                error: function (result) {
                    alertify.alert('error');
                }
            });
        }
        //function to check how many applyed leave
        function chkapplyedleave() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleave.aspx/getapplyedleavestatus",
                data: "",
                dataType: "json",
                success: function (data) {
                    var chkstatuss = $("#chkapplyedleave").html(data.d[0].chkleave);

                },
                error: function (result) {
                    alertify.alert('error');
                }
            });
        }
        //Function to validate the text Feild over the form
        function validationforgo() {

            var status = 1;
            var str1 = $("#ctl00_head_txtleavestart").val();
            var str2 = $("#ctl00_head_txtresume").val();
            var diff = Math.floor((Date.parse(str2) - Date.parse(str1)) / 86400000);
            if (diff > 15) {
                status = 0;
                alertify.alert("You can't apply more then 15 days");
                $("#ctl00_head_txtresume").val('');
                return false;
            }
            var mobile = $("#ctl00_head_txtmobile").val();

            if (document.getElementById('ctl00_head_txtmobile').value.trim() == "") {

                document.getElementById("ctl00_head_txtmobile").className = "texthover";
                status = 0;
            }
            else {
                if (parseInt(mobile.length) != 10) {
                    document.getElementById("ctl00_head_txtmobile").className = "texthover";
                    $("#mobileval").css("display", "block");
                    status = 0;

                }
                else {
                    document.getElementById("ctl00_head_txtmobile").removeClass = "texthover";
                }
            }
            $("#ctl00_head_txtmobile").blur(function () {
                $("#ctl00_head_txtmobile").removeClass("textfocus");
                $("#mobileval").css("display", "none");

            });
            $("#ctl00_head_txtmobile").focus(function () {
                $("#ctl00_head_txtmobile").removeClass("texthover");
                $("#ctl00_head_txtmobile").addClass("textfocus");

            });

            if (document.getElementById('ctl00_head_txtlastleave').value.trim() == "") {
                document.getElementById("ctl00_head_txtlastleave").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_head_txtlastleave").removeClass = "texthover";
            }
            $("#ctl00_head_txtlastleave").blur(function () {
                $("#ctl00_head_txtlastleave").removeClass("textfocus");
                $("#ctl00_head_txtlastleave").attr("disabled", "disabled");

            });
            $("#ctl00_head_txtlastleave").focus(function () {
                $("#ctl00_head_txtlastleave").removeClass("texthover");
                $("#ctl00_head_txtlastleave").addClass("textfocus");

            });

            if (document.getElementById('ctl00_head_txtleavestart').value.trim() == "") {
                document.getElementById("ctl00_head_txtleavestart").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_head_txtleavestart").removeClass = "texthover";
            }
            $("#ctl00_head_txtleavestart").blur(function () {
                $("#ctl00_head_txtleavestart").removeClass("textfocus");

            });
            $("#ctl00_head_txtleavestart").focus(function () {
                $("#ctl00_head_txtleavestart").removeClass("texthover");
                $("#ctl00_head_txtleavestart").addClass("textfocus");

            });

            if (document.getElementById('ctl00_head_txtresume').value.trim() == "") {
                document.getElementById("ctl00_head_txtresume").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_head_txtresume").removeClass = "texthover";
            }
            $("#ctl00_head_txtresume").blur(function () {
                $("#ctl00_head_txtresume").removeClass("textfocus");

            });
            $("#ctl00_head_txtresume").focus(function () {
                $("#ctl00_head_txtresume").removeClass("texthover");
                $("#ctl00_head_txtresume").addClass("textfocus");

            });

            if (document.getElementById('ctl00_head_ddlleavetype').value == "0") {
                document.getElementById("ctl00_head_ddlleavetype").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_head_ddlleavetype").removeClass = "texthover";
            }
            $("#ctl00_head_ddlleavetype").blur(function () {
                $("#ctl00_head_ddlleavetype").removeClass("textfocus");

            });
            $("#ctl00_head_ddlleavetype").focus(function () {
                $("#ctl00_head_ddlleavetype").removeClass("texthover");
                $("#ctl00_head_ddlleavetype").addClass("textfocus");

            });

            if (document.getElementById('ctl00_head_txtreson').value.trim() == "") {
                document.getElementById("ctl00_head_txtreson").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_head_txtreson").removeClass = "texthover";
            }
            $("#ctl00_head_txtreson").blur(function () {
                $("#ctl00_head_txtreson").removeClass("textfocus");

            });
            $("#ctl00_head_txtreson").focus(function () {
                $("#ctl00_head_txtreson").removeClass("texthover");
                $("#ctl00_head_txtreson").addClass("textfocus");

            });

            if (status == 0) {
                alertify.error("Please correct all red Textbox");
                return false;
            }
            else {
                return true;
            }

        }
        //Funtion to set colors in TR according to leave status just like Green for approve and Red for Reject
        function setleavestatus() {
            var gvDrv = document.getElementById("<%=gvleavedetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {
                var leavestatus = $("#ctl00_head_gvleavedetails tr:eq(" + i + ") td:eq(4)").find("span").text();
                if (leavestatus == "Approved") {
                    $("#ctl00_head_gvleavedetails tr:eq(" + i + ") ").css("background", "#46B525");
                    $("#ctl00_head_gvleavedetails tr:eq(" + i + ") td ").addClass("important");
                }
                if (leavestatus == "Cancel") {

                    $("#ctl00_head_gvleavedetails tr:eq(" + i + ") ").css("background", "red");
                    $("#ctl00_head_gvleavedetails tr:eq(" + i + ") td ").addClass("important");

                }

            }
        }
        function fixedlength(txtquantity, keyEvent, maxlength) {
            if (txtquantity.value.length > maxlength) {
                txtquantity.value = txtquantity.value.substr(0, maxlength);
            }
            else if (txtquantity.value.length < maxlength || txtquantity.value.length == maxlength) {

                txtquantity.value = txtquantity.value.replace(/[^\d]+/g, '');
                return true;
            }
            else {
                return false;
            }
        }
        //Function to get data after searching in gridview.
        function BindGridMain() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requestleave.aspx/BindDatatable",
                data: "{'lastleave':'" + lastleave + "','datefirst':'" + datefirst + "','datesecond':'" + datesecond + "','leavetype':'" + leavetype + "'}",
                dataType: "json",
                success: function (data) {
                    ;
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ctl00_head_gvleavedetails").show(500);
                        $("[id*=gvleavedetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvleavedetails] tr:eq(1)").clone(true);
                            $("[id$=gvleavedetails]").append(row);
                            $(row).find('.index').html(j);
                            $(row).find('.Last_Leave_Date').html(data.d[i].Last_Leave_Date);
                            $(row).find('.Leave_Start_From').html(data.d[i].Leave_Start_From);
                            $(row).find('.Leave_End_date').html(data.d[i].Leave_End_date);
                            $(row).find('.Leave_Apply_Date').html(data.d[i].Leave_Apply_Date);
                            $(row).find('.Leave_Type').html(data.d[i].Leave_Type);
                            $(row).find('.Leave_StatusDemo').html(data.d[i].leave_status);
                            $(row).find("input[type=hidden][id*=hfgetvalue]").val(data.d[i].leaveid);

                            var stat = data.d[i].leave_status
                            if (stat.trim() != "Pending") {
                                $(row).find(".btedit").css('display', 'none');
                            }
                            j = j + 1;
                        }

                        $("[id*=gvleavedetails] tr").show();
                        $("[id*=gvleavedetails] tr:eq(1)").hide();
                        setleavestatus();
                    }
                    else {
                        alertify.error("There not any record related this this keyword");
                        $("#ctl00_head_gvleavedetails").hide(500);

                    }
                },
                error: function (result) {
                }
            });
        }

        //Function to validate halfday
        function validatehalfday() {
            if ($("#ctl00_head_txthdcontact").val() == "") {

                alertify.error("Please enter contact number");
                return false;
            }
            if ($("#ctl00_head_ddlhd").val() == "0") {
                alertify.error("Please select half");
                return false;
            }
            if ($("#ctl00_head_txthddate").val() == "") {

                alertify.error("Please select date");
                return false;
            }
            if ($("#ctl00_head_txthdreason").val() == "") {

                alertify.error("Please enter reson");
                return false;
            }
            if (hvalidatestatus != 0) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                       <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Leave Details
                    </h1>
                </div>
                <div class="clearfix">
                </div>
                <div class="main-content">
                    <a id="getlist" style="float: right; cursor: pointer; display: none; margin-right: 10px;">Get Leaves List</a>
                    <a id="applyleave" title="Apply For New Leave" style="float: right; cursor: pointer; margin-right: 10px;">Apply For Leave</a>
                    <a id="applyhalfday" title="Apply For Half Day Leave" style="float: right; cursor: pointer; margin-right: 10px;">Apply For Half Day </a>
                    <br />
                    <br />
                    <div class="clearfix"></div>
                    <div style="width: 100%; background: #82403B; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
                        <span id="leavdetailsbin">Leave  Details </span>
                        <span id="applynewleave" style="display: none; margin-right: 10px;">Apply For Leave </span>
                        <span id="applyhalfdayleave" style="display: none; margin-right: 10px;">Apply For Half Day </span>
                    </div>
                    <div style="margin-bottom: 60px; margin-top: 15px; width: 100%;" id="div3">
                        <div style="height: 28px; width: 16%; background: #F0953F; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                            Max Paid/Year:<span id="available"></span>
                        </div>

                        <div style="height: 28px; width: 16%; background: #433DAA; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                            Earned  Paid:<span id="lblearnpaid"></span>
                        </div>

                        <div style="height: 28px; width: 16%; background: #0DB3BD; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                            Total Taken:<span id="totaltaklenleave"></span>
                        </div>

                        <div style="height: 28px; width: 16%; background: #46B525; float: left; margin-left: .5%; text-align: center; color: #fff; padding: 5px">
                            Paid:<span id="totalpaid"></span>
                        </div>

                        <div style="height: 28px; width: 16%; background: #607B8B; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                            Unpaid:<span id="totalunpaid"></span>
                        </div>
                        <div style="height: 28px; width: 16%; background: #FF0000; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                            Reject:<span id="lblreject"></span>
                        </div>
                        <div id="griddetails" style="float: left; width: 100%;">

                            <div class="containerHeadline" style="width: 100%">

                                <div style="float: right; width: 1000px;">

                                    <asp:DropDownList ID="ddlleavetypes" runat="server" Width="95px" Style="float: right" Font-Size="11px"></asp:DropDownList>
                                    <asp:TextBox ID="txtcontactno" runat="server" Width="120px" Font-Size="12px" Style="float: right; height: 26px;" Visible="false" placeholder="Leave Applied"> </asp:TextBox>
                                    <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" Font-Size="12px" Visible="false" Style="float: right;" placeholder="Leave From" Height="23px"> </asp:TextBox>
                                    <asp:TextBox ID="txtlast" runat="server" Width="120px" Font-Size="12px" Visible="false" placeholder="Last Leave" Style="float: right; display: none" Height="23px"> </asp:TextBox>
                                </div>
                            </div>
                            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leaves taken yet."
                                PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnPageIndexChanging="gvleavedetails_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" CssClass="index" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                                        <ItemTemplate>
                                            <asp:Label ID="snlblfromdate" runat="server" CssClass="Leave_Start_From" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>'> </asp:Label>
                                            <asp:HiddenField runat="server" ID="hfgetvalue" Value='<%#Eval("leaveid") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave To">
                                        <ItemTemplate>
                                            <asp:Label ID="leblenddate" runat="server" CssClass="Leave_End_date" Text='<%#Eval("Leave_End_date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Applied  Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lelapplydate" runat="server" CssClass="Leave_Apply_Date" Text='<%#Eval("Leave_Apply_Date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblleavestatus" runat="server" CssClass="Leave_StatusDemo" Text='<%#Eval("Leave_Status") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Type">
                                        <ItemTemplate>
                                            <asp:Label ID="lblleavetype" runat="server" CssClass="Leave_Type" Text='<%#Eval("Leave_Type") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Remarks">
                                        <ItemTemplate>
                                            <a style="cursor: pointer; color: #292929" title="Get All details about this leave" class="getleavedetails">Get Details</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                            <br />
                            <div class="clearfix"></div>
                            <div style="width: 100%; background: #82403B; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">Half Day List</div>
                            <asp:GridView runat="server" ID="grdhalfday" AllowPaging="true" EmptyDataText="No Half Day taken yet."
                                PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" CssClass="index" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Date">
                                        <ItemTemplate>
                                            <asp:Label ID="snlblfromdate" runat="server" CssClass="Leave_Start_From" Text='<%#Eval("hd_date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Half">
                                        <ItemTemplate>
                                            <asp:Label ID="leblenddate" runat="server" CssClass="Leave_End_date" Text='<%#Eval("hd_Half") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Paid/Unpaid">
                                        <ItemTemplate>
                                            <asp:Label ID="lelapplydate" runat="server" CssClass="Leave_Apply_Date" Text='<%#Eval("isannual") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblleavestatus" runat="server" CssClass="Leave_StatusDemo" Text='<%#Eval("isapprove") %>'> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>

                        <div class="clearfix"></div>
                        <br />
                        <br />

                        <div id="leavedet" style="display: none; float: left">
                            <div style="float: left; margin-bottom: 20px; width: 100%; display: none" id="divgetleavedetailsonebyone">
                                <div style="height: 28px; width: 19%; background: #2B81EE; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                                    Applied:<span id="applyedleave"></span>
                                </div>

                                <div style="height: 28px; width: 20%; background: #DA542D; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                                    Approved:<span id="approveleave"></span>
                                </div>

                                <div style="height: 28px; width: 20%; background: #607B8B; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                                    Unpaid:<span id="unpaidleave"></span>
                                </div>

                                <div style="height: 28px; width: 19%; background: #46B525; float: left; margin-left: .5%; text-align: center; color: #fff; padding: 5px">
                                    Paid:<span id="paidleave"></span>
                                </div>

                                <div style="height: 28px; width: 19%; background: #FF0000; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                                    Reject:<span id="rejectleave"></span>
                                </div>
                            </div>
                            <div style="width: 100%; float: left" id="divdatewiseleave">

                                <asp:GridView runat="server" ID="gvempleavedetails" AllowPaging="true" EmptyDataText="No Leaves Deatils."
                                    PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="6%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                                            <ItemTemplate>
                                                <asp:Label ID="sno3" runat="server" Text='<%#Eval("date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>

                            <div class="for_sigle_row_form" style="float: left">
                                <label>Admin Remark</label>
                                <asp:TextBox ID="txtadmin" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form" style="float: left">
                                <label></label>
                                <asp:Button runat="server" ID="btnback" Text="Back" CssClass="button_save" />
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <div id="divapplyleave" style="display: none; margin-left: 140px">
                            <p>Note: Apart from Annual leave all types of leave will be mark as unpiad leave</p>
                            <div class="for_sigle_row_form" style="display: none">
                                <label>Name<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtname" runat="server" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Contact Number<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtmobile" runat="server" onblur="return fixedlength(this, event, 10);"
                                    onkeypress="return fixedlength(this, event, 10);" onkeyup="return fixedlength(this, event, 10);"></asp:TextBox>
                                <span id="mobileval" style="display: none; float: right; margin-right: 220px;">Only 10 Digits</span>
                            </div>
                            <div class="for_sigle_row_form" style="display: none">
                                <label>
                                    Last Leave Taken<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtlastleave" runat="server" Style="cursor: pointer" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Leave Start Date<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtleavestart" runat="server" ReadOnly="true" Style="cursor: pointer"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form" id="resumd" style="display: none">
                                <label>
                                    Resume Date<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtresume" runat="server" ReadOnly="true" Style="cursor: pointer"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form" style="display: none">
                                <label>
                                    Resume Date<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtresumedate" runat="server" ReadOnly="true" Style="cursor: pointer"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Select Leave Type<span style="color: #ff0066">*</span></label>
                                <asp:DropDownList ID="ddlleavetype" runat="server"></asp:DropDownList>
                                <span id="noofleave" style="display: none; float: right; margin-right: 185px; margin-top: 5px;"></span>
                            </div>
                            <div class="for_sigle_row_form" id="divrescon">
                                <label>Reason<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtreson" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form" style="margin-left: 164px; display: none">
                                <label>Contact Address<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txtaddress" TextMode="MultiLine" runat="server"></asp:TextBox>
                                <asp:HiddenField runat="server" ID="hfleaveid" />
                            </div>
                            <div class="for_sigle_row_form" id="btninsert">
                                <label>
                                </label>
                                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" OnClick="btnSubmit_Click" /><br />
                            </div>
                            <div class="for_sigle_row_form" id="divupdate">
                                <label></label>
                                <asp:Button runat="server" ID="btnupdate" Text="Update" CssClass="button_save" OnClick="btnupdate_Click" />
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <div id="apllyfornewhalfday" style="display: none; margin-left: 140px">

                            <div class="for_sigle_row_form">
                                <label>Contact Number<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txthdcontact" runat="server" MaxLength="10" onblur="return fixedlength(this, event, 10);"
                                    onkeypress="return fixedlength(this, event, 10);" onkeyup="return fixedlength(this, event, 10);"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Select Half<span style="color: #ff0066">*</span></label>
                                <asp:DropDownList ID="ddlhd" runat="server">
                                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                                    <asp:ListItem Value="1">First Half (From 9:30 To 1:30)</asp:ListItem>
                                    <asp:ListItem Value="2">Second Half (From 1:30 To 6:30)</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Date<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txthddate" runat="server" ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Reason<span style="color: #ff0066">*</span></label>
                                <asp:TextBox ID="txthdreason" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </div>
                            <div class="for_sigle_row_form">
                                <label></label>
                                <asp:Button runat="server" Text="Submit" ID="btnapplyhalfday" OnClick="btnapplyhalfday_Click" CssClass="button_save" />
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfempcode" />
    <label id="chkapplyedleave" style="display: none"></label>
</asp:Content>