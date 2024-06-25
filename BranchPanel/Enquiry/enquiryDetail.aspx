<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="enquiryDetail.aspx.cs" Inherits="branchpanel_enquiry_details_contact_enquiry" %>

<%@ Register Src="~/BranchPanel/Enquiry/enquiryDistribution.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <%-- Script for Alert--%>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <%-- Script for Alert--%>

    <%--JS for Pi Chart--%>
    <script type="text/javascript" src="../employee/performancegraph/fusioncharts.js"></script>
    <script type="text/javascript" src="../employee/performancegraph/fusioncharts.theme.fint.js"></script>
    <%--JS for Pi Chart--%>

    <style type="text/css">
        #tooltip {
            position: absolute;
            display: inline-block;
            line-height: 30px;
            padding: 0px 16px 0px 8px;
            font-size: 15px;
            text-align: center;
            color: rgb(52,96,171);
            background: rgb(242,239,230);
            border: 0px 0px 0px 0px none none none none rgb(231,230,231) rgb(231,230,231) rgb(231,230,231) rgb(231,230,231);
            border-color: #a0c7ff transparent transparent transparent;
            border-radius: 20px;
            text-shadow: rgba(0, 0, 0, 0.6) 1px 1px 1px;
            box-shadow: rgb(231,230,231) -4px 0px 4px 0px inset;
        }

            #tooltip h3, #tooltip div {
                margin: 0;
            }

        #CustomerTable {
            border: 1px solid #666;
            width: 100%;
            font-size: 12pt;
        }

        #griddate td {
            border: none;
        }

        .alertify {
            z-index: 222222222222222;
        }

        #CustomerTable th {
            font-size: 12pt;
            background: #f8f8f8;
            font-weight: bold;
            padding: 2px;
            width: 150px !important;
        }

        #CustomerTable td {
            text-align: center !important;
            font-size: 11pt;
        }

        .containerHeadline select {
            padding: 3px !important;
        }

        #ui-datepicker-div {
            width: 167px !important;
        }

        .active2 {
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


        .ui-dialog-content {
            z-index: 2000 !important;
        }

        .ui-widget-content {
            z-index: 2000 !important;
        }

        .ui-dialog-titlebar {
            height: 30px;
            text-align: center;
            font-size: 15pt;
            background-color: darkgray;
        }

        .ui-dialog .ui-dialog-title {
            margin: 0.1em 0 0.2em;
        }

        .ui-dialog .ui-dialog-titlebar-close {
            display: none !important;
        }

        .ui-dialog-buttonset {
            background-color: darkgray !important;
            z-index: 2000;
        }

        .ui-button {
            height: 30px;
            width: 100px;
            background-color: darkgrey !important;
            color: white !important;
            border-color: #646464 !important;
            float: right;
            box-shadow: none !important;
            box-shadow: #646464 !important;
            margin-left: 1139px !important;
        }

        .ui-dialog .ui-dialog-buttonpane button {
            cursor: pointer;
            margin-left: 500px !important;
        }

        .ui-dialog .ui-widget-overlay {
            background-color: #000000 !important;
            opacity: 0.5 !important;
            -moz-opacity: 0.50 !important;
            filter: alpha(opacity=50) !important;
            width: 100% !important;
            height: 100% !important;
            z-index: 1001 !important;
        }

        .ui-widget-overlay {
            background-color: black !important;
            opacity: 1 !important;
            height: 1200px !important;
        }

        .ui-dialog-buttonpane {
            border: none !important;
            margin-left: 10px !important;
        }

        .showpopup {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #8cbf26;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 25%;
            opacity: 1;
            padding: 20px;
            position: fixed;
            top: 20%;
            width: 45%;
            z-index: 100000000000;
        }

       

        #ContentPlaceHolder1_grdemplist {
            border-left: 1px solid #dddddd;
        }
        #ContentPlaceHolder1_grdtrasferdetails {
             border-left: 1px solid #dddddd;
        }
        input[type="checkbox"] + label {
            margin-left: 5px;
            font-size: 12px;
        }
    </style>
    <script type="text/javascript">
        var mobile = ''; var message = '', pagecount = 1, pagesize = 15, pageno = 1, productid = "";
        var ddlsearchbydate = "", ddlfromdate = "", ddltodate = "", ddlsearchbyproduct = "", ddlsearchbyenquirysource = "", ddlsearchbystatus = "";
        var ddlsearchby = "", txtsearchtext = "", startindex = 1, endindex = 100, identifylastpage = "", totalenquiry = "", allstatus = "", mode = 2; userid = 0;
        var totalenq = "", newtotal = 0,checklead = "", checkraw = "", leadtotalenq = 0;
        function pageLoad() {
            $('#ContentPlaceHolder1_ddlenquirysource').live('change', function () {

                var productText = '<%= Session["product"] %>'
                startindex = parseInt(1);
                endindex = parseInt(startindex) + parseInt(99);

                if (this.value != "0") {
                    ddlsearchbyenquirysource = $.trim(this.value);
                    ddlsearchbyproduct = productText;

                    BindGridAfterSearching();
                }
                else {
                    ddlsearchbyproduct = productText;
                    ddlsearchbyenquirysource = "";
                    BindGridAfterSearching();
                }

            });
            $('#ContentPlaceHolder1_Button1').click(function () {

                startindex = parseInt(1);
                endindex = parseInt(startindex) + parseInt(99);

                if (ddlsearchby != "" && txtsearchtext != "") {
                    BindGridAfterSearching();
                    return false;
                }
                if (ddlsearchby == "" && txtsearchtext == "") {
                    BindGridAfterSearching();
                    return false;
                }
                if (ddlsearchby != "" && txtsearchtext == "") {
                    alert('Please Enter The Search Value Before Go.');
                    return false;
                }
            });

            function BindGridAfterSearching() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Comman.aspx/BindDatatable",
                    data: "{'identifylastpage':'" + identifylastpage + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                            $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();

                            for (var i = 0; i < data.d.length; i++) {
                                $("[id$=gridenquiry]").append(row);

                                $(row).find('.sno').html(data.d[i].RowNumber);
                                $(row).find('.realenquiryno').html(data.d[i].real_Enqiry_Id);
                                $(row).find('.enqdate').html(data.d[i].enquirydate);
                                $(row).find('.enqsource').html(data.d[i].enquirysource);
                                $(row).find('.enqtype').html(data.d[i].enqtype);
                                $(row).find('.nameforjquery').html(data.d[i].name);
                                $(row).find('.mobile').html(data.d[i].mobile);
                                $(row).find('.statusname').html(data.d[i].statusname);
                                $(row).find('.followupdate').html(data.d[i].followupdate);
                                $(row).find('.gridViewToolTip').html('View');
                                $(row).find('.forsmcid').html(data.d[i].enquiryid);
                                $(row).find('.cityofenquiry').html(data.d[i].City);
                            }
                            $("[id*=gridenquiry] tr").show();
                            $("[id*=gridenquiry] tr:first-child").show();

                        }
                        else {
                            var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                            $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();
                            $("[id$=gridenquiry]").append(row);

                        }
                        $("[id*=gridenquiry] tr").show();
                        $("[id*=gridenquiry] tr:first-child").show();
                    },
                    error: function (result) {

                    }
                });
            }
        }
        $(document).ready(function () {
            $(".notAttenNotDis").click(function () {
                $("#ContentPlaceHolder1_chkautomatic").prop("checked", false);
                $(".getall").find("input[type='checkbox']").prop("checked", false);
                mode = 2;
                $("#ContentPlaceHolder1_btntranferenquiry").css("display", "block");
                $("#ContentPlaceHolder1_btnleadtransfer").css("display", "none");
                totalenq = $(this).html();
                if (totalenq != 0) {
                    productid = $(this).parents("table").parents("table tr").find("input[type='Hidden']").val();
                    totalenquiry = $(this).html();
                    getemplist();
                }
            });
            $(".subgrid").click(function () {
               
                productid = $(this).parents("tr").children("td:eq(1)").find("input[type='Hidden']").val();
               
                gettransferemplist();
                return false;
            });
            $("#btnclosetransfer").click(function () {
                $("#divtransferlist").hide(500);
            });
            $("#rowenquiry").click(function () {
                var a = $(this).html();
                alertify.success(a)
            });

            $("#tdClosepopup").click(function () {
                $("#popupdiv").hide(500);
            });

            $(".txtinputenquiry").click(function () {
                $(this).css("border", "1px solid #99cc00");
            });
            $(".txtinputenquiry").blur(function () {
                $(this).css("border", "1px solid #d7d7d7");
                var enternoofenq = 0;
                var getgrd = document.getElementById("<%=grdemplist.ClientID %>");
                for (i = 1; i < getgrd.rows.length; i++) {
                    enternoofenq = parseInt($(this).val());
                }
                checklead = $("#ContentPlaceHolder1_btnleadtransfer").css("display");
                checkraw = $("#ContentPlaceHolder1_btntranferenquiry").css("display");
                if (checklead == "block") {
                    newtotal = parseInt(enternoofenq) + newtotal;
                    if (newtotal > parseInt(leadtotalenq)) {
                        alertify.error("Number of enquiry can't be grater then un-distributed enquiry");
                        newtotal = newtotal - parseInt($(this).val());
                        $(this).val('');
                    }
                }
                if (checkraw == "block") {
                    newtotal = parseInt(enternoofenq) + parseInt(newtotal);
                    if (newtotal > parseInt(totalenq)) {
                        alertify.error("Number of enquiry can't be grater then un-distributed enquiry");
                        newtotal = newtotal - parseInt($(this).val());
                        $(this).val('');
                    }
                }

            });

            $("#ContentPlaceHolder1_btntranferenquiry").click(function () {
                checkanddistributeenquiry();
                return false;
            });

            $(".notleadNotDis").click(function () {
                mode = 3;
                $("#ContentPlaceHolder1_btntranferenquiry").css("display", "none");
                $("#ContentPlaceHolder1_btnleadtransfer").css("display", "block");
                leadtotalenq = $(this).html();
                if (leadtotalenq != 0) {
                    productid = $(this).parents("table").parents("table tr").find("input[type='Hidden']").val();
                    getemplist();
                }
            });
            $("#ContentPlaceHolder1_btnleadtransfer").click(function () {
                checkanddistributeenquiry();
                return false;
            });

            $(".getall").change(function () {
                checklead = $("#ContentPlaceHolder1_btnleadtransfer").css("display");
                checkraw = $("#ContentPlaceHolder1_btntranferenquiry").css("display");
                if (checklead == "block") {
                    mode = 4;
                }
            });

            $("#ContentPlaceHolder1_chkautomatic").change(function () {

                allstatus = $("#ContentPlaceHolder1_chkautomatic").attr("checked");
                checklead = $("#ContentPlaceHolder1_btnleadtransfer").css("display");
                checkraw = $("#ContentPlaceHolder1_btntranferenquiry").css("display");
                if (allstatus == "checked") {
                    getautodistlist();
                    if (checklead == "block") {
                        mode = 3;
                    }
                    if (checkraw == "block") {
                        mode = 1;
                    }
                    userid = 0;
                    $("#ContentPlaceHolder1_grdemplist_chkchkecked_0").prop("checked", true);
                    $(".getall").find("input[type='checkbox']").prop("checked", true);
                    $(".txtinputenquiry").prop("disabled", true);
                }
                if (allstatus == undefined) {
                    getemplist();
                    if (checklead == "block") {
                        mode = 4;
                    }
                    if (checkraw == "block") {
                        mode = 2;
                    }
                    $(".getall").find("input[type='checkbox']").prop("checked", false);
                    $(".txtinputenquiry").prop("disabled", false);
                }

            });
        });

        function checkanddistributeenquiry() {
            alertify.confirm("Are you sure want to distribute enquiry?", function (e) {
                if (e) {
                    debugger;
                    if (mode == 2 || mode == 4) {
                        var getgrd = document.getElementById("<%=grdemplist.ClientID %>");
                        var checkcount = 0, chektotalenquiry = 0;
                        for (i = 1; i < getgrd.rows.length; i++) {
                            var checkfordist = $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(4)").find("input[type='checkbox']").attr("checked");
                            var checkforenquiry = $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(3)").find("input[type='text']").val();
                            var empname = $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(2)").find("span").text();
                            if (checkforenquiry != "") {
                                if (checkfordist == undefined) {
                                    alertify.error("Please select if you want to give enquiry to " + empname);
                                    return false;
                                }
                            }
                            if (checkfordist == "checked") {
                                userid = $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(4)").find("input[type='hidden']").val();
                                totalenquiry = $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(3)").find("input").val();
                                if (totalenquiry == "") {
                                    alertify.error("Please enter number of enquiry for " + empname);
                                    $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(3)").find("input").css("border", "1px solid #ff0000");
                                    $("#ContentPlaceHolder1_grdemplist tr:eq(" + i + ") td:eq(3)").find("input").focus();
                                    return false;
                                }
                                checkcount = checkcount + 1;

                                chektotalenquiry = parseInt(chektotalenquiry) + parseInt(totalenquiry);
                                if (mode == 4) {
                                    if (checkcount != 0 && chektotalenquiry <= parseInt(leadtotalenq)) {
                                        distributeenquiry();
                                    }
                                }
                                else {
                                    if (checkcount != 0 && chektotalenquiry <= parseInt(totalenq)) {
                                        distributeenquiry();
                                    }
                                }
                            }
                        }
                        if (chektotalenquiry > parseInt(totalenq)) {
                            alertify.error("Number of enquiry can't be grater then un-distributed enquiry");
                            return false;
                        }
                        if (checkcount == 0) {
                            alertify.error("Please select at least one employee to distribute enquiry");
                            return false;
                        }
                    }
                    if (mode == 1 || mode == 3) {
                        distributeenquiry();
                    }

                } else {
                    alertify.error("You've clicked Cancel");
                }
            });
            return false;
        }
        function getemplist() {
            call_progressbar("Start");
            $(".txtinputenquiry").prop("disabled", false);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "enquiryDetail.aspx/BindDatatable",
                data: "{'catid':'" + productid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=grdemplist] tr:last-child").clone(true);
                        $("[id*=grdemplist] tr").not($("[id*=grdemplist] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=grdemplist] tr:last-child").clone(true);
                            }
                            $("[id$=grdemplist]").append(row);
                            $(row).find('.refno').html(data.d[i].refno);
                            $(row).find('.name').html(data.d[i].name);
                            $(row).find("input[type=hidden][id*=hfeid]").val(data.d[i].eid);

                        }
                        $("[id*=grdemplist] tr").show();
                        $("[id*=grdemplist] tr:first-child").show();
                        $("#popupdiv").show(500);
                        call_progressbar("end")
                    }
                    else {
                        var row = $("[id*=grdemplist] tr:last-child").clone(true);
                        $("[id*=grdemplist] tr").not($("[id*=grdemplist] tr:first-child")).remove();
                        $("[id$=grdemplist]").append(row);
                        $('#ContentPlaceHolder1_grdemplist').hide(500);
                        alertify.error("There is not any employee for this category.");
                        $("#popupdiv").hide(500);

                    }
                    $("[id*=grdemplist] tr").show();
                    $("[id*=grdemplist] tr:first-child").show();


                },
                error: function (result) {
                    alert("Sorry! There is some technical issue.");
                    call_progressbar("end")
                }

            });
        }
        function distributeenquiry() {
            if (mode == 4 || mode == 3) {
                totalenquiry = totalenquiry;
            }
            else {
                totalenquiry = totalenquiry;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "enquiryDetail.aspx/distribute",
                data: "{'totalenquiry':'" + totalenquiry + "','productid':'" + productid + "','mode':'" + mode + "','userid':'" + userid + "'}",
                dataType: "json",
                success: function (data) {
                    alertify.success("Enquiry distributed successfully.");
                    $("#popupdiv").hide(500);
                },
                error: function (result) {
                    alertify.error("There is some technical issue");
                }

            });
        }


        function getautodistlist() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "enquiryDetail.aspx/BindDatatableauto",
                data: "{'catid':'" + productid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=grdemplist] tr:last-child").clone(true);
                        $("[id*=grdemplist] tr").not($("[id*=grdemplist] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=grdemplist] tr:last-child").clone(true);
                            }
                            $("[id$=grdemplist]").append(row);
                            $(row).find('.refno').html(data.d[i].refno);
                            $(row).find('.name').html(data.d[i].name);
                            $(row).find("input[type=hidden][id*=hfeid]").val(data.d[i].eid);

                        }
                        $("[id*=grdemplist] tr").show();
                        $("[id*=grdemplist] tr:first-child").show();
                        $("#popupdiv").show(500);
                    }
                    else {
                        var row = $("[id*=grdemplist] tr:last-child").clone(true);
                        $("[id*=grdemplist] tr").not($("[id*=grdemplist] tr:first-child")).remove();
                        $("[id$=grdemplist]").append(row);

                        $(row).find('.refno').html('N/A');
                        $(row).find('.name').html('N/A');
                        $(row).find("input[type=hidden][id*=hfeid]").val('N/A');
                        //$('#ContentPlaceHolder1_grdemplist').hide(500);
                        alertify.error("There is not any employee for Auto distribution.");
                        $("#popupdiv").hide(500);

                    }
                    $("[id*=grdemplist] tr").show();
                    $("[id*=grdemplist] tr:first-child").show();


                },
                error: function (result) {
                    alertify.error("Sorry! There is some technical issue.");
                }

            });
        }

        function gettransferemplist() {
            var j = 1;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "enquiryDetail.aspx/getEnqtransferlist",
                data: "{'catid':'" + productid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=grdtrasferdetails] tr:last-child").clone(true);
                        $("[id*=grdtrasferdetails] tr").not($("[id*=grdtrasferdetails] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=grdtrasferdetails] tr:last-child").clone(true);
                            }
                            $("[id$=grdtrasferdetails]").append(row);
                            $(row).find('.sno').html(j);
                            $(row).find('.empname').html(data.d[i].empname);
                            $(row).find('.empcode').html(data.d[i].empcode);
                            $(row).find('.rowenquiry').html(data.d[i].rowenquiry);
                            $(row).find('.leadnequiry').html(data.d[i].leadnequiry);
                            $(row).find('.archive').html(data.d[i].archive);
                            $(row).find("input[type=hidden][id*=eid]").val(data.d[i].eid);
                            j = j + 1;

                        }
                        $("[id*=grdtrasferdetails] tr").show();
                        $("[id*=grdtrasferdetails] tr:first-child").show();
                        $("#divtransferlist").show(500);
                       
                    }
                    else {
                        var row = $("[id*=grdtrasferdetails] tr:last-child").clone(true);
                        $("[id*=grdtrasferdetails] tr").not($("[id*=grdtrasferdetails] tr:first-child")).remove();
                        $("[id$=grdtrasferdetails]").append(row);
                        alertify.error("All are undistributed");

                    }
                    $("[id*=grdtrasferdetails] tr").show();
                    $("[id*=grdtrasferdetails] tr:first-child").show();


                },
                error: function (result) {
                    alertify.error("Sorry! There is some technical issue.");
                }

            });
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
            $(document).ready(function () {
                //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
                $(".btnfirst").click(function () {
                    pageno = 1;
                    $(".lblpage").html(pageno);
                    BindGridAfterSearching();
                });
                $(".btnprev").click(function () {
                    if (parseInt(pageno) > 1) {
                        pageno = parseInt(pageno) - 1;
                        $(".lblpage").html(pageno);
                        BindGridAfterSearching();
                    }
                });
                $(".btnnext").click(function () {
                    if (parseInt(pageno) < parseInt(pagecount)) {
                        pageno = parseInt(pageno) + 1;
                        $(".lblpage").html(pageno);
                        BindGridAfterSearching();
                    }
                });
                $(".btnlast").click(function () {
                    pageno = pagecount;
                    $(".lblpage").html(pageno);
                    BindGridAfterSearching();
                });
            });
        }
    </script>
    <script type="text/javascript">
        $(function () {
            InitializeToolTip();
        })
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="viewenquiry.aspx">Enquiry</a></li>
            <li style="background: none;"><a class="active">Overall Enquiry</a></li>
        </ul>
    </div>
    <My:stu runat="server" ID="MyUserInfoBoxControl" />
    <script type="text/javascript" language="javascript">
        Sys.Application.add_load(forshow);
    </script>
    <div class="content_pane_cont input_content" id="contentPane">

        <div id="popupdiv" class="showpopup" style="text-align: center; margin-left: -24px !important; display: none">
            <div style="text-align: right;">
                <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>
            <div id="content">
                <asp:GridView ID="grdemplist" AutoGenerateColumns="false" EmptyDataText="No data found !"
                    Width="100%" CssClass="stm" GridLines="None" runat="server">
                    <Columns>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="S.No">

                            <ItemTemplate>
                                <asp:Label CssClass="sno" ID="lblroeno" Text='<%#Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Emp Code">
                            <ItemTemplate>
                                <asp:Label CssClass="refno" ID="lblempcode" Text='<%#Eval("refno") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Employee Name">
                            <ItemTemplate>
                                <asp:Label CssClass="name" ID="name" Text='<%#Eval("name") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="No. Of Enquiry">
                            <ItemTemplate>
                                <asp:TextBox ID="txtnoofenquiry" CssClass="txtinputenquiry" Width="30px" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkchkecked" CssClass="getall" />
                                <asp:HiddenField runat="server" ID="hfeid" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>

                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
                <asp:CheckBox runat="server" ID="chkautomatic" Text="Send Automatic To All" Style="float: right; margin-top: 18px;" />
                <asp:Button runat="server" ID="btntranferenquiry" Text="Raw Transfer" CssClass="button_save" Style="float: right; margin-top: 10px" />
                <asp:Button runat="server" ID="btnleadtransfer" Text="Lead Transfer" CssClass="button_save" Style="float: right; margin-top: 10px" />

            </div>
        </div>
        <table width="100%" id="divFirst" runat="server">
            <tr>
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridenquirylist" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        Width="100%" CssClass="stm" GridLines="None" runat="server" OnRowCommand="gridenquirylist_RowCommand">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="S.NO.">

                                <ItemTemplate>
                                    <asp:Label CssClass="sno" ID="lblroeno" runat="server" Text='<%# Container.DataItemIndex +1 %>'></asp:Label>
                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product">
                                <ItemTemplate>
                                    <asp:Label CssClass="realenquiryno" ID="lblenquiryno" Text='<%#Eval("product") %>' runat="server"></asp:Label>
                                    <asp:HiddenField runat="server" ID="hfproductid" Value='<%# Eval("productId") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="left" Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="No. Of Enquiry">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnknoOfEnq" Text='<%#Eval("noOfEnq") %>' runat="server" CssClass="subgrid"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lblnotAttenDis" runat="server">Raw Enquiry</asp:Label>
                                    <table id="griddate" style="border-top: 1px solid #333333" width="100%">
                                        <tr>
                                            <td width="50%" style="text-align: center; font-weight: 500; color: green; border-right: 1px solid #333">Dist.
                                            </td>
                                            <td width="47%" style="text-align: center; font-weight: 500; color: red">Un Dist.
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table cellspacing="0" cellpadding="0" style="width: 100%;" id="griddate">
                                        <tr>
                                            <td width="50%" style="border-right: 1px solid #ddd!important">
                                                <asp:Label ID="lblnotAttenDis" CssClass="enqsource" Text='<%#Eval("notAttenDis") %>'
                                                    runat="server"></asp:Label>
                                            </td>
                                            <td width="50%">
                                                <a id="lblnotAttenNotDis" class="notAttenNotDis" runat="server" style="cursor: pointer"><%#Eval("notAttenNotDis") %></a>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="18%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblname" runat="server">Lead Enquiry</asp:Label>
                                    <table id="griddate" style="border-top: 1px solid #333333" width="100%">
                                        <tr>
                                            <td width="50%" style="text-align: center; font-weight: 500; color: green; border-right: 1px solid #333">Dist.
                                            </td>
                                            <td width="47%" style="text-align: center; font-weight: 500; color: red">Un Dist
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table cellspacing="0" cellpadding="0" style="width: 100%;" id="griddate">
                                        <tr>
                                            <td width="50%" style="border-right: 1px solid #ddd!important">
                                                <asp:Label ID="lblleadDis" CssClass="enqsource" Text='<%#Eval("leadDis") %>'
                                                    runat="server"></asp:Label>
                                            </td>
                                            <td width="50%">
                                                <a id="lblleadNotDis" class="notleadNotDis" runat="server" style="cursor: pointer"><%#Eval("leadNotDis") %></a>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="18%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Approve">
                                <ItemTemplate>
                                    <asp:Label ID="lblcontactedate1" CssClass="contactdate" Text='<%#Eval("approve") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblcontactedby" runat="server">Archive</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblcontactedby1" runat="server" Text='<%#Eval("archive") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                    <div style="float: left; width: 39%; text-align: center;">
                        <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total:" Style="font-size: 20px; color: green"></asp:Label>
                    </div>
                    <div style="float: left; width: 8%;">
                        <asp:Label ID="lblNoofEnquiury" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 8%;">
                        <asp:Label ID="lblRawenqdis" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 10%;">
                        <asp:Label ID="lblRawenqnotdis" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 8%;">
                        <asp:Label ID="lblleaddis" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 13%;">
                        <asp:Label ID="lblleadnotdis" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 9%;">
                        <asp:Label ID="lblApprove" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                    <div style="float: left; width: 4%;">
                        <asp:Label ID="lblArchive" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div id="divaftersearching" runat="server">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <asp:Button ID="btnBack" runat="server" CssClass="button" Style="float: right;" Text="Back"
                        OnClick="btnBack_Click1" />
                </td>
            </tr>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="display: none; margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                class="stm">
                <tr>
                    <td colspan="10" class="containerHeadline">
                        <div style="float: left; width: 700px;">
                            <asp:TextBox ID="txtfromdateforsearch" runat="server" Width="166px" Height="23px"
                                placeholder="Date From"> </asp:TextBox>
                            <asp:TextBox ID="txttodateforsearch" runat="server" Width="166px" Height="23px" placeholder="Date To"> </asp:TextBox>
                        </div>
                        <div class="clear">
                        </div>
                        <div style="float: right; margin-top: 8px !important; width: 1000px;">
                            <asp:DropDownList ID="ddlenquirysource" runat="server" Width="200px">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlsearchoption" runat="server" Width="100px">
                                <asp:ListItem Value="0">Search By</asp:ListItem>
                                <asp:ListItem Value="Enquiry No">Enquiry No</asp:ListItem>
                                <asp:ListItem Value="Name">Name</asp:ListItem>
                                <asp:ListItem Value="Mobile">Mobile</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Panel ID="pa1" DefaultButton="Button1" runat="server">
                                <asp:TextBox ID="txtnamesearch" runat="server" Width="117px" Height="23px" placeholder="Make Your Search"> </asp:TextBox>
                            </asp:Panel>
                            <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                CssClass="view-enquiry" Height="23px" />
                            <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                                BackColor="#E2E2E2" CausesValidation="false" Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />
                            <asp:ImageButton ID="img_pdffile" ImageUrl="../../images/download.jpg" Height="20px"
                                runat="server" CssClass="excel" Style="right: 0px" />
                        </div>
                    </td>
                </tr>
            </table>
            <tr>
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridenquiry" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        Width="100%" CssClass="stm" GridLines="None" runat="server">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    S.No
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="sno" ID="lblroeno" Text='<%#Eval("RowNumber") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lblheaderenquiryno" runat="server">Enquiry No.</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="realenquiryno" ID="lblenquiryno" Text='<%#Eval("real_Enqiry_Id") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Enquiry Date</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblenqdate1" CssClass="enqdate" Text='<%#Eval("enquirydate","{0:MMM dd yyyy}") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblname" runat="server">Name</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblname1" CssClass="nameforjquery" Text='<%#Eval("name") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lblphone" runat="server">Mobile No</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblmob" Text='<%# Eval("mobile") %>' runat="server" CssClass="mobile"
                                        ToolTip="click here for send sms."></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lbldateofenquiry" runat="server">Enquiry Source</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblenqdate222" CssClass="enqsource" Text='<%#Eval("enquirysource") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <HeaderTemplate>
                                    <asp:Label ID="lblcityheader" runat="server">City</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblcitytemplate" CssClass="cityofenquiry" Text='<%#Eval("city") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="11%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblstatus" runat="server">Status</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus1" CssClass="statusname" Text='<%#Eval("statusname") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
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
                <td style="width: 100%; padding: 4px 10px 10px 10px;">
                    <asp:Label ID="lblmessage" runat="server" Text="No enquiry list according to your searching."
                        Style="display: none; color: red; font-size: 15px; margin-left: 100px !important;"></asp:Label>
                </td>
            </tr>
            <tr id="trforimagepagging" runat="server" style="display: none">
                <td align="left" style="width: 1070px" class="containerHeadline">
                    <div style="margin-left: 0px; float: left; width: 500px;">
                        <asp:Label ID="lblpage" CssClass="lblpage" Style="color: green; font-size: 11pt; font-weight: bold"
                            runat="server"></asp:Label>
                        Of
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage" Style="margin-left: 0px; font-size: 11pt; font-weight: bold"
                            runat="server"></asp:Label>
                        <span style="font-size: 11pt">Page</span>
                    </div>
                    <div style="margin-left: 0px; float: left; width: 500px; display: none">
                        <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; width: 22px; height: 22px"
                            alt="" />
                        <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; width: 22px; height: 22px"
                            alt="" />
                        <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; width: 22px; height: 22px"
                            alt="" />
                        <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; width: 22px; height: 22px"
                            alt="" />
                    </div>
                </td>
            </tr>
        </table>

    </div>
    <div id="divtransferlist" class="showpopup" style="text-align: center; margin-left: -24px !important; display: none">
        <div style="text-align: right;">
            <a id="btnclosetransfer" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
        </div>
        <asp:GridView ID="grdtrasferdetails" AutoGenerateColumns="false" EmptyDataText="No data found !"
            Width="100%" CssClass="stm" GridLines="None" runat="server">
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="S.No">

                    <ItemTemplate>
                        <asp:Label CssClass="sno" ID="lblroeno" Text='<%#Container.DataItemIndex + 1%>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Emp Code">
                    <ItemTemplate>
                        <asp:Label CssClass="empcode" ID="lblempcode" Text='<%#Eval("empcode") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                    <ItemTemplate>
                        <asp:Label CssClass="empname" ID="name" Text='<%#Eval("empname") %>' runat="server"></asp:Label>
                        <asp:HiddenField runat="server" ID="eid" Value='<%#Eval("eid") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Raw">
                    <ItemTemplate>
                        <a class="rowenquiry" id="rowenquiry" style="cursor:pointer"><%#Eval("rowenquiry") %></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Lead">
                    <ItemTemplate>
                        <a class="leadnequiry" id="leadnequiry" style="cursor:pointer"> <%#Eval("leadnequiry") %></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Archive">
                    <ItemTemplate>
                        <a class="archive" id="archive" style="cursor:pointer"><%#Eval("archive") %></a>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                </asp:TemplateField>

            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
        </asp:GridView>
       

    </div>
</asp:Content>
