<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="leave-report.aspx.cs" Inherits="branchpanel_employee_leave_report" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />

    <style type="text/css">
        .activeleavereport {
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            -moz-border-right-colors: none;
            -moz-border-top-colors: none;
            background: none repeat scroll 0 0 #f7f7f7;
            border-color: #2d9fdd !important;
            border-image: none;
            border-radius: 3px 3px 0 0;
            border-style: solid solid none;
            border-width: 1px 1px medium;
            color: #2d9fdd !important;
            font-size: 12px;
            height: auto;
            margin-left: 10px;
            margin-top: 3px;
            padding: 5px 13px;
        }

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }
    </style>
    <script type="text/javascript">
        var lastleave = "", datefirst = '', datesecond = '', leavetype = '';
        function pageLoad() {
            document.title = 'Leave';
        }

        $(document).ready(function () {

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

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
            $("#ctl00_ContentPlaceHolder1_txtlast").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
            });

            $('#ctl00_ContentPlaceHolder1_txtlast').on('change keyup paste', function () {
                lastleave = $(this).val();
                BindGridMain();
                setleavestatus();
            });
            $('#ctl00_ContentPlaceHolder1_txtreferenceno').on('change keyup paste', function () {
                datefirst = $(this).val();
                BindGridMain();
                setleavestatus();

            });
            $('#ctl00_ContentPlaceHolder1_txtcontactno').on('change keyup paste', function () {
                datesecond = $(this).val();
                BindGridMain();
                setleavestatus();

            });
            $('#ctl00_ContentPlaceHolder1_ddlleavetypes').on('change', function () {
                leavetype = $(this).val();
                BindGridMain();
                setleavestatus();

            });

            chkapplyedleave();
            gettotalleave();

            $("#ctl00_ContentPlaceHolder1_txtleavestart").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
                numberOfMonths: 2,
                minDate: new Date($('#ctl00_ContentPlaceHolder1_txtlastleave').val()),
                onClose: function (selectedDate) {
                    $("#ctl00_ContentPlaceHolder1_txtresume").datepicker("option", "minDate", selectedDate);
                    $("#resumd").css("display", "block");
                    $("#divrescon").css("margin-left", "160px");

                }

            });

            $("#ctl00_ContentPlaceHolder1_txtresume").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2014:2016',
                dateFormat: "d MM yy",
                numberOfMonths: 2,

                onClose: function (selectedDate) {
                    $("#ctl00_ContentPlaceHolder1_txtleavestart").datepicker("option", "maxDate", selectedDate);
                }

            });
            $("#ctl00_ContentPlaceHolder1_ddlleavetype").click(function () {

                var str1 = $("#ctl00_ContentPlaceHolder1_txtleavestart").val();
                var str2 = $("#ctl00_ContentPlaceHolder1_txtresume").val();
                var diff = Math.floor((Date.parse(str2) - Date.parse(str1)) / 86400000);
                if (diff > 7) {
                    alert("You can't apply more then 7 days");
                    //$("#ctl00_ContentPlaceHolder1_txtleavestart").val('');
                    $("#ctl00_ContentPlaceHolder1_txtresume").val('');
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "d MM yy",
            });

            var empName = $("#ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname").html();
            var contact = $("#ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblmobile").html();
            $("#ctl00_ContentPlaceHolder1_txtname").val(empName);
            $("#ctl00_ContentPlaceHolder1_txtmobile").val(contact);

            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {

                var status = validationforgo();
                if (status == false) {
                    return false;
                }

            });

            $("#ctl00_ContentPlaceHolder1_btnupdate").click(function () {
                var status = validationforgo();
                if (status == false) {
                    return false;
                }
            });

            $("#applyleave").click(function () {

                var chkstatus = $("#chkapplyedleave").html();
                if (chkstatus == "0") {

                    $("#griddetails").css("display", "none");
                    $("#divapplyleave").css("display", "block");
                    $("#getlist").css("display", "block");
                    $("#applyleave").css("display", "none");
                    $("#leavdetailsbin").css("display", "none");
                    $("#applynewleave").css("display", "block");
                    $("#leavedet").css("display", "none");
                    $("#btninsert").css("display", "block");
                    $("#divupdate").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtleavestart").val("");
                    $("#resumd").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtreson").val("");
                    $("#ctl00_ContentPlaceHolder1_txtaddress").val("");
                    $("#ctl00_ContentPlaceHolder1_ddlleavetype").val("0");
                    gettotalleave(); //Function for get leave history
                }
                else {
                    alert("Your Last Request is Pending");
                }

            });

            $("#getlist").click(function () {
                $("#griddetails").css("display", "block");
                $("#divapplyleave").css("display", "none");
                $("#getlist").css("display", "none");
                $("#applyleave").css("display", "block");
                $("#leavdetailsbin").css("display", "block");
                $("#applynewleave").css("display", "none");

            });

            $(".getleavedetails").click(function () {

                $("#leavedet").css("display", "block");
                $("#griddetails").css("display", "none");

                var leaveid = $(this).parents("tr").children("td:eq(1)").find("input[type='hidden']").val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "leave-report.aspx/getleavesdetailss",
                    data: "{ 'leaveid':'" + leaveid + "'}",
                    dataType: "json",
                    success: function (data) {

                        $("#ctl00_ContentPlaceHolder1_txtleaveapplyed").val(data.d[0].leaveappy);
                        $("#applyedleave").html(data.d[0].noofleave);
                        $("#approveleave").html(data.d[0].noofapproveleave);
                        $("#paidleave").html(data.d[0].noofpl);
                        $("#unpaidleave").html(data.d[0].nooflwp);
                        $("#rejectleave").html(data.d[0].reject);
                        $("#ctl00_ContentPlaceHolder1_txtadmin").val(data.d[0].adminremark);

                        var getappleave = $("#approveleave").html();
                        var Paid = $("#paidleave").html();
                        var unpaid = $("#unpaidleave").html();
                        var admin = $("#ctl00_ContentPlaceHolder1_txtadmin").val();

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
                            $("#ctl00_ContentPlaceHolder1_txtadmin").val("Not view by Admin till now");
                        }

                        getdatewisedetails(leaveid);

                    },
                    error: function (result) {
                        alert('error');
                    },
                });

            });

            function getdatewisedetails(leaveid) {

                $("#divdatewiseleave").css("display", "block");
                $("#divgetleavedetailsonebyone").css("display", "block");
                var status;

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "leave-report.aspx/getempleavedetails",
                    data: "{ 'leaveid':'" + leaveid + "'}",
                    dataType: "json",
                    success: function (data) {
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails").empty();
                        if (data.d.length > 0) {
                            var j = 1;

                            $("#ctl00_ContentPlaceHolder1_gvempleavedetails").append("<tr class='stm_head'><th style='text-align:center'>S No.</th><th style='text-align:center'>Date </th><th style='text-align:center'>Status</th><th style='text-align:center'>Type</th></tr>");
                            for (var i = 0; i < data.d.length; i++) {
                                if (data.d[i].approve == "Reject") {
                                    data.d[i].ispaid = "";
                                }
                                $("#ctl00_ContentPlaceHolder1_gvempleavedetails").append("<tr><td>" +
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

                        alert('error');
                    },
                });
            }

            function getdatewiseleaves() {

                var gvDrv = document.getElementById("<%=gvempleavedetails.ClientID %>");

                for (i = 1; i < gvDrv.rows.length; i++) {
                    var leavestatus = $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td:eq(2)").html();
                    var paystatus = $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td:eq(3)").html();

                    if (leavestatus == "Approved") {
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") ").css("background", "#46B525");
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");
                    }
                    if (leavestatus == "Reject") {

                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") ").css("background", "red");
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");

                    }
                    if (paystatus == "Unpaid") {
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") ").css("background", "#607B8B");
                        $("#ctl00_ContentPlaceHolder1_gvempleavedetails tr:eq(" + i + ") td ").addClass("important");
                    }
                }
            }

            $("#ctl00_ContentPlaceHolder1_btnback").click(function () {
                $("#leavedet").css("display", "none");
                $("#griddetails").css("display", "block");
                return false;
            });

            $(".btedit").click(function () {
                var leaveid = $(this).parents("tr").find("input[type='hidden']").val();
                window.location = "requestleavelist.aspx?leaveid=" + leaveid;
                return false;
            });
            setleavestatus();

        });

        function gettotalleave() {
            var employeecode = $("#ctl00_ContentPlaceHolder1_hfempcode").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "leave-report.aspx/gettotalleave",
                data: "{ 'empcode':'" + employeecode + "'}",
                dataType: "json",
                success: function (data) {
                    $("#Label1").html(data.d[0].Available);
                    $("#Label2").html(data.d[0].Earnpaid);
                    $("#Label3").html(data.d[0].totalleave);
                    $("#Label4").html(data.d[0].totalpaid);
                    $("#Label5").html(data.d[0].totalunpaid);
                    $("#Label6").html(data.d[0].totalreject);
                },
                error: function (result) {
                    alert('error');
                }
            });
        }

        function chkapplyedleave() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "leave-report.aspx/getapplyedleavestatus",
                data: "",
                dataType: "json",
                success: function (data) {
                    var chkstatuss = $("#chkapplyedleave").html(data.d[0].chkleave);

                },
                error: function (result) {
                    alert('error');
                }
            });
        }

        function validationforgo() {

            var status = 1;
            var str1 = $("#ctl00_ContentPlaceHolder1_txtleavestart").val();
            var str2 = $("#ctl00_ContentPlaceHolder1_txtresume").val();
            var diff = Math.floor((Date.parse(str2) - Date.parse(str1)) / 86400000);
            if (diff > 7) {
                status = 0;
                alert("You can't apply more then 7 days");
                $("#ctl00_ContentPlaceHolder1_txtresume").val('');
            }
            var mobile = $("#ctl00_ContentPlaceHolder1_txtmobile").val();

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtname').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtname").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtname").removeClass = "texthover";
            }

            $("#ctl00_ContentPlaceHolder1_txtname").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtname").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_txtname").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtname").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtname").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtmobile').value.trim() == "") {

                document.getElementById("ctl00_ContentPlaceHolder1_txtmobile").className = "texthover";
                status = 0;
            }
            else {
                if (parseInt(mobile.length) != 10) {
                    document.getElementById("ctl00_ContentPlaceHolder1_txtmobile").className = "texthover";
                    $("#mobileval").css("display", "block");
                    status = 0;

                }
                else {
                    document.getElementById("ctl00_ContentPlaceHolder1_txtmobile").removeClass = "texthover";
                }
            }
            $("#ctl00_ContentPlaceHolder1_txtmobile").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtmobile").removeClass("textfocus");
                $("#mobileval").css("display", "none");

            });
            $("#ctl00_ContentPlaceHolder1_txtmobile").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtmobile").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtmobile").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtlastleave').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtlastleave").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtlastleave").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_txtlastleave").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtlastleave").removeClass("textfocus");
                $("#ctl00_ContentPlaceHolder1_txtlastleave").attr("disabled", "disabled");

            });
            $("#ctl00_ContentPlaceHolder1_txtlastleave").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtlastleave").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtlastleave").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtleavestart').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtleavestart").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtleavestart").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_txtleavestart").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtleavestart").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_txtleavestart").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtleavestart").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtleavestart").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtresume').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtresume").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtresume").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_txtresume").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtresume").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_txtresume").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtresume").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtresume").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_ddlleavetype').value == "0") {
                document.getElementById("ctl00_ContentPlaceHolder1_ddlleavetype").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_ddlleavetype").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_ddlleavetype").blur(function () {
                $("#ctl00_ContentPlaceHolder1_ddlleavetype").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_ddlleavetype").focus(function () {
                $("#ctl00_ContentPlaceHolder1_ddlleavetype").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_ddlleavetype").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtreson').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtreson").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtreson").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_txtreson").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtreson").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_txtreson").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtreson").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtreson").addClass("textfocus");

            });

            if (document.getElementById('ctl00_ContentPlaceHolder1_txtaddress').value.trim() == "") {
                document.getElementById("ctl00_ContentPlaceHolder1_txtaddress").className = "texthover";
                status = 0;
            }
            else {
                document.getElementById("ctl00_ContentPlaceHolder1_txtaddress").removeClass = "texthover";
            }
            $("#ctl00_ContentPlaceHolder1_txtaddress").blur(function () {
                $("#ctl00_ContentPlaceHolder1_txtaddress").removeClass("textfocus");

            });
            $("#ctl00_ContentPlaceHolder1_txtaddress").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtaddress").removeClass("texthover");
                $("#ctl00_ContentPlaceHolder1_txtaddress").addClass("textfocus");

            });

            if (status == 0) {
                alert('Please Correct All Red Mark Box');
                return false;
            }

        }

        function setleavestatus() {
            var gvDrv = document.getElementById("<%=gvleavedetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {
                var leavestatus = $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") td:eq(5)").find("span").text();
                if (leavestatus == "Approved") {
                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") ").css("background", "#46B525");

                }
                if (leavestatus == "Cancel") {

                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") ").css("background", "red");
                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") td ").addClass("important");

                }

            }
        }

        function BindGridMain() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "leave-report.aspx/BindDatatable",
                data: "{'lastleave':'" + lastleave + "','datefirst':'" + datefirst + "','datesecond':'" + datesecond + "','leavetype':'" + leavetype + "'}",
                dataType: "json",
                success: function (data) {
                    ;
                    var j = 1;
                    if (data.d.length > 0) {
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
                },
                error: function (result) {
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
            <li style="background: none;"><a class="active" href="#">Leave</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <a id="getlist" style="float: right; cursor: pointer; display: none; margin-right: 10px;">Get Leaves List</a>

        <div class="clear"></div>
        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">Leave  Details </label>
            <label id="applynewleave" style="display: none; margin-right: 10px;">Apply For Leave </label>
            <div runat="server" id="div2" style="float: right; width: 150px; position: relative; left: -19px; top: 8px;">
                <asp:TextBox runat="server" ID="txtDate" placeholder="Search By Date" onkeypress="return noAlphabets(event)"
                    AutoPostBack="true" Visible="false"></asp:TextBox>
            </div>
        </div>
        <div id="griddetails" style="float: left; width: 100%;">

            <div style="margin-bottom: 60px; margin-top: 15px; width: 100%;" id="div3">
                <div style="height: 15px; width: 15%; background: #F0953F; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Available Paid:
                    <label id="Label1"></label>
                </div>

                <div style="height: 15px; width: 15%; background: #433DAA; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Earned  Paid:
                    <label id="Label2"></label>
                </div>

                <div style="height: 15px; width: 15%; background: #0DB3BD; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Total Leave Taken:
                    <label id="Label3"></label>
                </div>

                <div style="height: 15px; width: 15%; background: #46B525; float: left; margin-left: .5%; text-align: center; color: #fff; padding: 5px">
                    Paid:
                    <label id="Label4"></label>
                </div>

                <div style="height: 15px; width: 15%; background: #607B8B; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                    UnPaid:
                    <label id="Label5"></label>
                </div>
                <div style="height: 15px; width: 16%; background: #FF0000; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                    Reject:
                    <label id="Label6"></label>
                </div>
            </div>

            <div class="containerHeadline" style="width: 100%">

                <div style="float: right; width: 1000px;">

                    <asp:DropDownList ID="ddlleavetypes" runat="server" Width="95px" Style="float: right" Font-Size="12px"></asp:DropDownList>
                    <asp:TextBox ID="txtcontactno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave Applied"> </asp:TextBox>
                    <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Leave From" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtlast" runat="server" Width="120px" Font-Size="12px" placeholder="Last Leave" Style="float: right" Height="23px"> </asp:TextBox>
                </div>
            </div>
            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leaves taken yet."
                PageSize="50" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnPageIndexChanging="gvleavedetails_PageIndexChanging" OnRowDataBound="gvleavedetails_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" CssClass="index" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Last Leave">
                        <ItemTemplate>
                            <asp:Label ID="lbllastdate" runat="server" CssClass="Last_Leave_Date" Text='<%#Eval("Last_Leave_Date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                            <asp:HiddenField runat="server" ID="hfgetvalue" Value='<%#Eval("leaveid") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave From">
                        <ItemTemplate>
                            <asp:Label ID="snlblfromdate" runat="server" CssClass="Leave_Start_From" Text='<%#Eval("Leave_Start_From","{0:dd/MM/yyyy}") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave To">
                        <ItemTemplate>
                            <asp:Label ID="leblenddate" runat="server" CssClass="Leave_End_date" Text='<%#Eval("Leave_End_date","{0:dd/MM/yyyy}") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Leave Applied">
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

                    <%--   <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Details">
                        <ItemTemplate>
                            <a style="cursor: pointer; color: #292929" title="Get All details about this leave" class="getleavedetails">Get Details</a>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Edit">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" ID="linkedit" CssClass="btedit" ImageUrl="~/images/edit-leave.png" Height="20" Width="20" ToolTip="Edit This Leave" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
            <div align="left" style="width: 1070px" class="containerHeadline">
                <div style="margin-left: 0px; float: left; width: 500px;">
                    <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                    <asp:Label ID="Label7" runat="server" Text="1" Style="color: green; font-size: 11pt"></asp:Label>
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
            </div>
            <br />
            <br />
            <div style="float: left; margin-bottom: 10px;" id="getindicators">
                <div style="height: 15px; width: 35px; background: #FF0000; float: left; margin-left: 10Px; color: white; border: 1px solid #000; padding: 5px">Reject</div>
                <div style="height: 15px; width: 53px; background: #46B525; float: left; margin-left: 10Px; color: #333; border: 1px solid #000; padding: 5px">Approved</div>
                <div style="height: 15px; width: 44px; background: #FCFCFC; float: left; margin-left: 10Px; color: #000; border: 1px solid #000; padding: 5px">Pending</div>
            </div>
        </div>

        <div class="clear"></div>
        <br />
        <br />

        <div id="leavedet" style="display: none">
            <div style="float: left; margin-bottom: 20px; width: 100%; display: none" id="divgetleavedetailsonebyone">
                <div style="height: 15px; width: 18%; background: #2B81EE; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Applied:
                    <label id="applyedleave"></label>
                </div>

                <div style="height: 15px; width: 19%; background: #DA542D; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Approved:
                    <label id="approveleave"></label>
                </div>

                <div style="height: 15px; width: 19%; background: #607B8B; float: left; margin-left: .5%; text-align: center; color: white; padding: 5px">
                    Unpaid:
                    <label id="unpaidleave"></label>
                </div>

                <div style="height: 15px; width: 18%; background: #46B525; float: left; margin-left: .5%; text-align: center; color: #fff; padding: 5px">
                    Paid:
                    <label id="paidleave"></label>
                </div>

                <div style="height: 15px; width: 18%; background: #FF0000; float: left; text-align: center; margin-left: .5%; color: #fff; padding: 5px">
                    Reject:
                    <label id="rejectleave"></label>
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
                <label>
                    Admin Remark</label>
                <asp:TextBox ID="txtadmin" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="float: left">
                <label>
                </label>
                <asp:Button runat="server" ID="btnback" Text="Back" CssClass="button_save" />
            </div>
        </div>

        <div id="divapplyleave" style="display: none">
            <div style="float: left;" id="Div1">

                <div style="height: 15px; width: 144px; font-size: 21px; float: left; margin-left: 10Px; padding: 5px; display: block">Leave Details</div>
                <br />
                <div style="height: 15px; width: 40px; background: #607B8B; float: left; margin-left: 10Px; color: white; padding: 5px; display: none">Unpaid</div>
                <div style="height: 15px; width: 26px; background: #46B525; float: left; margin-left: 10Px; color: #333; padding: 5px; display: none">Paid</div>

                <div style="text-align: center; height: 15px; width: 140px; background: #0DB3BD; float: left; margin-left: 10Px; margin-top: 20px; color: #fff; padding: 5px">
                    Total Leave Taken:
                    <label id="totaltaklenleave"></label>
                </div>
                <br />
                <div style="height: 15px; text-align: center; width: 140px; background: #F0953F; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">Available Paid:<label id="available"></label></div>
                <br />
                <br />
                <div style="height: 15px; text-align: center; width: 140px; background: #433DAA; float: left; margin-left: 10Px; margin-top: 10px; color: #fff; padding: 5px">Earned  Paid:<label id="lblearnpaid"></label></div>
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
            <div class="for_sigle_row_form">
                <label>
                    Name<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtname" runat="server" Enabled="false"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Contact Number<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtmobile" runat="server" MaxLength="10"></asp:TextBox>
                <span id="mobileval" style="display: none; float: right; margin-right: 382px;">Only 10 Digits</span>
            </div>
            <div class="for_sigle_row_form">
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
                <label>
                    Select Leave Type<span style="color: #ff0066">*</span></label>
                <asp:DropDownList ID="ddlleavetype" runat="server"></asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" id="divrescon">
                <label>
                    Reason<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtreson" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" style="margin-left: 164px;">
                <label>
                    Contact Address<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtaddress" TextMode="MultiLine" runat="server"></asp:TextBox>
                <asp:HiddenField runat="server" ID="hfleaveid" />
            </div>
            <div class="for_sigle_row_form" id="btninsert" style="margin-left: 164px;">
                <label>
                </label>
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" OnClick="btnSubmit_Click" />
            </div>
            <div class="for_sigle_row_form" id="divupdate">
                <label>
                </label>
                <asp:Button runat="server" ID="btnupdate" Text="Update" CssClass="button_save" OnClick="btnupdate_Click" />
            </div>
        </div>
    </div>
    <asp:HiddenField runat="server" ID="hfempcode" />
    <label id="chkapplyedleave" style="display: none"></label>
</asp:Content>