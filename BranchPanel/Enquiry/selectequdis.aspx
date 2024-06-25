<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="selectequdis.aspx.cs" Inherits="BranchPanel_enquiry_details_selectequdis" %>

<%@ Register Src="~/BranchPanel/Enquiry/enquiryDistribution.ascx" TagName="stu"
    TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../../js/jquery-ui-1.8.19.custom.min.js" type="text/css" />

    <%-- Script for Alert--%>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <%-- Script for Close--%>

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

        .ui-dialog {
            position: fixed !important;
        }

        .active22 {
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
            left: 23%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 14%;
            width: 60%;
            z-index: 100;
        }

        .showpopup1 {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #8cbf26;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 23%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 14%;
            width: 60%;
            z-index: 100;
        }

        .showpopup2 {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #8cbf26;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 35%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 30%;
            width: 36%;
            z-index: 100;
        }
        .showpopup3 {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #8cbf26;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: auto;
            left: 7%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 15%;
            width: 90%;
            z-index: 100;
        }

        #ctl00_ContentPlaceHolder1_GridView1 {
            border-left: 1px solid #dddddd !important;
        }

        #ctl00_ContentPlaceHolder1_grd1 {
            border-left: 1px solid #dddddd !important;
        }

        .for_sigle_row_form {
            border-bottom: none !important;
        }

        #ctl00_ContentPlaceHolder1_grdactdeactuser {
            border-left: 1px solid #dddddd;
        }

        #ctl00_ContentPlaceHolder1_grdforfitenquiry {
            border-left: 1px solid #dddddd;
        }

        input[type="checkbox"] + label {
            margin-left: 5px !important;
            font-size: 12px !important;
            float: right!important;
            width: 178px;
        }

        .ddlIndxO {
            font-weight: bold;
            color: #33AE0D;
        }
        #CustomerTable td {
            color: #333;
            line-height: 27px;
            font-family: Verdana;
            font-size: 9pt;
        }
        #CustomerTable tr {
            border-left:1px solid #666!important
        }
        #CustomerTable {
            
            font-size: 12pt;
            padding: 1%;
            width: 98%;
        }
        #CustomerTable th {
            background: none repeat scroll 0 0 #f8f8f8;
            font-size: 9pt;
            font-weight: bold;
            padding: 2px;
        }
        .statusname {
        cursor:pointer;
        color:#d2691e
        }
    </style>
    <script type="text/javascript">
        var startindex = 1, endindex = 100, identifylastpage = ""; var mode = 3, ddluservalue = "", empid = 0, productid = 0, empcode = "", getcatid, ddlsearchbyproduct = 0;
        var pagecount = 1, pagesize = 50, pageno = 1, fromdate = "", todate="";

        function pageLoad() {
            $("#totalproducts").hide();
            $("#goback").hide();
            $("#getsungrid").hide();

            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);

            BindGrid(mode);
            $("#ctl00_ContentPlaceHolder1_ddluser").change(function () {
                ddluservalue = $("#ctl00_ContentPlaceHolder1_ddluser").val();
                if (ddluservalue != "0") {
                    ddluservalue = $(this).val();
                    fillProduct(ddluservalue)
                }
                else {
                    alert("Please Select atleast one user !.");
                    return;
                }
            });
            $("#ctl00_ContentPlaceHolder1_ddlreporttype").change(function () {

                var ddltext = $("#ctl00_ContentPlaceHolder1_ddlreporttype option:selected").text();
                if (ddltext == "All") {
                    BindGrid(3);
                }
                if (ddltext == "Activated") {
                    BindGrid(1);
                }
                if (ddltext == "Deactivated") {
                    BindGrid(2);
                }
            });
            $("#adduserpop").click(function () {
                $("#popupdiv").show(500);
                $("#goback").hide(500);
                $("#ctl00_ContentPlaceHolder1_grdNoRight").show(500);
                $("#ctl00_ContentPlaceHolder1_ddlreporttype").show(500);
                $("#getsungrid").hide(500);
                //$("#ctl00_ContentPlaceHolder1_gridsubenquiry").hide(500);
            });
            $("#tdClosepopup").click(function () {
                $("#popupdiv").hide(500);
            });
            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {
                addnewuser();
                return false;
            });
            $(".userid").click(function () {
                empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                var activestatus = $(this).html();
                if (activestatus == "Stop") {
                    alertify.confirm("Are you sure want to Deactive this user?", function (e) {
                        if (e) {
                            deactiveuser();
                        }
                        else {
                            alertify.error("You've clicked Cancel");
                        }
                    });
                    return false;
                }
                else {
                    actdeactmem();
                    $("#actdeactdiv").show(500);
                    return false;
                }
            });
            $("#closeactdeact").click(function () {
                $("#actdeactdiv").hide(500);
            });
            $("#ctl00_ContentPlaceHolder1_btnactivemember").click(function () {
                activeuser();
                return false;
            });
            $("#forfitclose").click(function () {
                $("#forfit").hide(500);
            });
            $("#ctl00_ContentPlaceHolder1_btndeactiveuser").click(function () {
                changepermission();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnforfeit").click(function () {
                forefitenquiry();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_chekboth").change(function () {
                if ($(this).is(":checked") == true) {
                    $(".activestatus").find("input[type='checkbox']").prop("checked", false);
                }
            });
            $("#goback").click(function () {
                $(this).hide(500);
                $("#ctl00_ContentPlaceHolder1_grdNoRight").show(500);
                $("#ctl00_ContentPlaceHolder1_ddlreporttype").show(500);
                $("#getsungrid").hide(500);
                //$("#ctl00_ContentPlaceHolder1_gridsubenquiry").hide(500);
            });

            $("#ctl00_ContentPlaceHolder1_ddlproduct").change(function () {
                ddlsearchbyproduct = $.trim(this.value);
                BindsubGrid();
            });

            $(".statusname").click(function () {
                var a = $(this).html();
               
                if (a != "NOT ATTENDED") {
                    var enquiryid = $(this).parents("tr").children("td:eq(1)").find("input[type='hidden']").val();
                    showpreviousdata(enquiryid)
                    $("#followuphistory").show(500);
                }
                else {
                    alertify.error("There is not any followup for this enquiry");
                }

            });

            $(".statusname").attr('title', 'Click Here to get followup details');
            $("#followhistoryclose").click(function () {

                $("#followuphistory").hide(500);
            });

            $("#ctl00_ContentPlaceHolder1_txtfromdateforsearch").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'mm/dd/yy'
            });

            $("#ctl00_ContentPlaceHolder1_txttodateforsearch").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'mm/dd/yy'
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdateforsearch").on('keyup paste blur', function () {
                fromdate = $.trim($(this).val());
                BindsubGrid();
            });

            $("#ctl00_ContentPlaceHolder1_txttodateforsearch").on('keyup paste blur', function () {
                todate = $.trim($(this).val());
                BindsubGrid();
            });

            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
            $(".btnfirst").click(function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                BindsubGrid()
            });
            $(".btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    BindsubGrid()
                }
            });
            $(".btnnext").click(function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $(".lblpage").html(pageno);
                    BindsubGrid()
                }
            });
            $(".btnlast").click(function () {
                pageno = pagecount;
                $(".lblpage").html(pageno);
                BindsubGrid();
            });


            $("#<%=ddluser.ClientID%> option[value=0]").addClass('ddlIndxO');
        }
        function showpreviousdata(enquiryid) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Comman.aspx/GetFollowupdata",
                data: "{'eid':'" + enquiryid + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        var row = $("[id*=CustomerTable] tr:last-child").clone(true);
                        $("[id*=CustomerTable] tr").not($("[id*=CustomerTable] tr:first-child")).remove();

                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("<tr class='stm_light' />");

                            $("#CustomerTable").append(row); //this will append tr element to table... keep its reference for a while since we will add cels into it

                            row.append($("<td>" + data.d[i].rownumber + "</td>"));

                            row.append($("<td>" + data.d[i].contacteddate + "</td>"));
                            row.append($("<td>" + data.d[i].contactedtime + "</td>"));
                            row.append($("<td>" + data.d[i].followdate + "</td>"));
                            row.append($("<td>" + data.d[i].followtime + "</td>"));
                            row.append($("<td style='width:40%; text-align:justify'>" + data.d[i].remarks + "</td>"));
                            row.append($("<td>" + data.d[i].contactedby + "</td>"));
                            row.append($("<td>" + data.d[i].statusname + "</td>"));
                        }
                    }
                    else {
                        var row = $("[id*=CustomerTable] tr:last-child").clone(true);
                        $("[id*=CustomerTable] tr").not($("[id*=CustomerTable] tr:first-child")).remove();

                        var row = $("<tr />");
                        $("#CustomerTable").append(row); //this will append tr element to table... keep its reference for a while since we will add cels into it
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                        row.append($("<td>" + "No Record Found" + "</td>"));
                    }

                },
                error: function (result) {
                    alert("Unable to show record");
                }
            });
            return false;
        }
        function actdeactmem() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/getcategory",
                data: "{'eid':'" + empcode + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_grdactdeactuser").show(500);
                        $("[id*=grdactdeactuser] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=grdactdeactuser] tr:eq(1)").clone(true);

                            $("[id$=grdactdeactuser]").append(row);
                            $(row).find('.actecatname').html(data.d[i].ecatname);
                            $(row).find("input[type=hidden][id*=actuserid]").val(data.d[i].userid);
                            $(row).find("input[type=hidden][id*=productid]").val(data.d[i].productid);
                        }
                        $("[id*=grdactdeactuser] tr").show();
                        $("[id*=grdactdeactuser] tr:eq(1)").hide();
                    }
                    else {
                        alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_grdactdeactuser").hide(500);

                    }
                    gettotalenquiry();
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function removeuser() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/gerremovecatnames",
                data: "{'eid':'" + empcode + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_grdforfitenquiry").show(500);
                        $("[id*=grdforfitenquiry] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=grdforfitenquiry] tr:eq(1)").clone(true);

                            $("[id$=grdforfitenquiry]").append(row);
                            $(row).find('.removecatname').html(data.d[i].product);
                            $(row).find('.enqtotal').html(data.d[i].totalcount);
                            $(row).find("input[type=hidden][id*=catid]").val(data.d[i].catid);

                        }
                        $("[id*=grdforfitenquiry] tr").show();
                        $("[id*=grdforfitenquiry] tr:eq(1)").hide();
                    }
                    else {
                        //alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_grdforfitenquiry").hide(500);

                    }
                    gettotalenquiry();
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function deactiveuser() {
            $("#deactivecatlist").show(500);
            var chekstatus;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/deactiveusercategory",
                data: "{'eid':'" + empcode + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_grddeactivecatlist").show(500);
                        $("[id*=grddeactivecatlist] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=grddeactivecatlist] tr:eq(1)").clone(true);

                            $("[id$=grddeactivecatlist]").append(row);
                            $(row).find('.deactivecatname').html(data.d[i].deactivecatname);
                            $(row).find("input[type=hidden][id*=deacatid]").val(data.d[i].deacatid);
                            chekstatus = data.d[i].activestatus;

                            if (chekstatus == 1) {
                                $(row).find("input[type=checkbox][id*=chkstatus]").attr('checked', true);
                            }
                            else {
                                $(row).find("input[type=checkbox][id*=chkstatus]").attr('checked', false);
                            }

                        }
                        $("[id*=grddeactivecatlist] tr").show();
                        $("[id*=grddeactivecatlist] tr:eq(1)").hide();
                        $("#forfit").show(500);
                        $("#forfeit").hide();
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_grddeactivecatlist").hide(500);
                    }
                },
                error: function (result) {
                    alertify.error("There is some technical issue");
                }
            });
        }

        function changepermission() {
            var getgrd = document.getElementById("<%=grddeactivecatlist.ClientID %>");

            var ischangepermission, enquiryque = 0, ischange = 0, isboth;
            isboth = $("#ctl00_ContentPlaceHolder1_chekboth").is(":checked");
            if (isboth == true) {
                isboth = 1
            }
            else {
                isboth = 0
            }

            for (i = 1; i < getgrd.rows.length; i++) {
                ischangepermission = $("#ctl00_ContentPlaceHolder1_grddeactivecatlist tr:eq(" + i + ") td:eq(1)").find("input[type='checkbox']").is(":checked");
                enquiryque = $("#ctl00_ContentPlaceHolder1_grddeactivecatlist tr:eq(" + i + ") td:eq(1)").find("input[type='hidden']").val();
                if (ischangepermission == false) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "selectequdis.aspx/changepermission",
                        data: "{'enquiryque':'" + enquiryque + "','isboth':'" + isboth + "'}",
                        dataType: "json",
                        success: function (data) {
                            BindGrid(3);

                        },
                        error: function (result) {
                            alertify.error("There is some technical issue");
                        }
                    });
                    ischange = ischange + 1;
                }
            }

            if (ischange == 0) {
                alertify.error("Please remove least one Product");
            }
            else {
                alertify.success("User Deactivated");
                alertify.confirm("Do you want to Forfeit enquiries from this user?", function (e) {
                    if (e) {
                        removeuser();

                        $("#deactivecatlist").hide(500);
                        $("#forfeit").show(500);

                    } else {
                        $("#forfit").hide(500);
                        alertify.error("You've clicked Cancel");
                    }
                });
            }
        }

        function forefitenquiry() {
            var getgrd = document.getElementById("<%=grdforfitenquiry.ClientID %>");
            var isforefitenquiry, categoryid = 0, countforefit = 0;
            for (i = 1; i < getgrd.rows.length; i++) {
                isforefitenquiry = $("#ctl00_ContentPlaceHolder1_grdforfitenquiry tr:eq(" + i + ") td:eq(2)").find("input[type='checkbox']").is(":checked");
                categoryid = $("#ctl00_ContentPlaceHolder1_grdforfitenquiry tr:eq(" + i + ") td:eq(1)").find("input[type='hidden']").val();
                if (isforefitenquiry == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "selectequdis.aspx/forefitenquiry",
                        data: "{'enquiryque':'" + categoryid + "','eid':'" + empcode + "'}",
                        dataType: "json",
                        success: function (data) {
                            BindGrid(3);
                        },
                        error: function (result) {
                            alertify.error("There is some technical issue");
                        }
                    });
                    countforefit = countforefit + 1;
                }
            }
            if (countforefit == 0) {
                alertify.error("Please uncheck at least one product to forfeit");
            }
            if (countforefit > 0) {
                alertify.success("All Enquiries Forefited");
                $("#forfit").hide(500);
            }
        }

        function activeuser() {
            debugger;
            var getgrd = document.getElementById("<%=grdactdeactuser.ClientID %>");
            var isactivatecategory, categoryid = 0, enquiryque;
            for (i = 1; i < getgrd.rows.length; i++) {
                isactivatecategory = $("#ctl00_ContentPlaceHolder1_grdactdeactuser tr:eq(" + i + ") td:eq(1)").find("input[type='checkbox']").is(":checked");
                categoryid = $("#ctl00_ContentPlaceHolder1_grdactdeactuser tr:eq(" + i + ") td:eq(1)").find("input[type='hidden']").val();
                enquiryque = $("#ctl00_ContentPlaceHolder1_grdactdeactuser tr:eq(" + i + ") td:eq(0)").find("input[type='hidden']").val();

                if (isactivatecategory == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "selectequdis.aspx/activeusercategory",
                        data: "{'enquiryque':'" + enquiryque + "','productid':'" + categoryid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#actdeactdiv").hide(500);
                            BindGrid(3);

                        },
                        error: function (result) {
                            alertify.error("There is some technical issue");
                        }
                    });
                }

            }
            alertify.success("User Activated");
        }

        function addnewuser() {
            empid = $("#ctl00_ContentPlaceHolder1_ddluser").val();
            var getgrd = document.getElementById("<%=grd1.ClientID %>");
            var isaddproduct;
            for (i = 1; i < getgrd.rows.length; i++) {
                //alert(isaddproduct = $("#ctl00_ContentPlaceHolder1_grd1 tr:eq(" + i + ") td:eq(1)").find(".status").html());
                isaddproduct = $("#ctl00_ContentPlaceHolder1_grd1 tr:eq(" + i + ") td:eq(1)").find("input[type=checkbox]").is(":checked");
                productid = $("#ctl00_ContentPlaceHolder1_grd1 tr:eq(" + i + ") td:eq(0)").find("input[type=hidden]").val();
                if (isaddproduct == true) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "selectequdis.aspx/addremoveuser",
                        data: "{'userid':'" + empid + "','productid':'" + productid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#popupdiv").hide(500);
                            BindGrid(3);
                        },
                        error: function (result) {
                            alertify.error("There is some technical issue");
                        }
                    });
                }
            }
            alertify.success("User Added successfully.");
        }

        function fillProduct() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/getproductslist",
                data: "{'eid':'" + ddluservalue + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_grd1").show(500);
                        $("[id*=grd1] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=grd1] tr:eq(1)").clone(true);

                            $("[id$=grd1]").append(row);
                            $(row).find('.ecatname').html(data.d[i].ecatname);
                            $(row).find('.refNo').html(data.d[i].refNo);
                            $(row).find("input[type=hidden][id*=hd1]").val(data.d[i].id);
                            if (data.d[i].status == 1) {
                                $(row).find("input[type=checkbox][id*=chk1]").attr('checked', true);
                            }
                            if (data.d[i].status == 0) {
                                $(row).find("input[type=checkbox][id*=chk1]").attr('checked', false);
                            }
                        }
                        $("[id*=grd1] tr").show();
                        $("[id*=grd1] tr:eq(1)").hide();
                    }
                    else {
                        alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_grd1").hide(500);

                    }
                    gettotalenquiry();
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function gettotalenquiry() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/gettotalenquiry",
                data: "{'eid':'" + ddluservalue + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_GridView1").show(500);
                        $("[id*=GridView1] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                row = $("[id*=GridView1] tr:eq(1)").clone(true);
                            }
                            $("[id$=GridView1]").append(row);
                            $(row).find('.ecatid').html(data.d[i].ecatid);
                            $(row).find(".noofenquiry").html(data.d[i].noofenquiry);
                            $(row).find("input[type=hidden][id*=p1]").val(data.d[i].ecatid);
                        }
                        $("[id*=GridView1] tr").show();
                        $("[id*=GridView1] tr:eq(1)").hide();
                        $("#totalproducts").show(500);
                    }
                    else {
                        $("#totalproducts").hide(500);
                    }

                },
                error: function (result) {
                    alertify.error("There is some technical issue");
                },
            });
        }
        function BindGrid(mode) {
            var row, count = 0;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/BindDatatable",
                data: "{'mode':'" + mode + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=grdNoRight] tr:last-child").clone(true);
                        $("[id*=grdNoRight] tr").not($("[id*=grdNoRight] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=grdNoRight] tr:last-child").clone(true);
                            }
                            $("[id$=grdNoRight]").append(row);
                            $(row).find('.demo').html(data.d[i].refno);
                            $(row).find('.username').html(data.d[i].username);
                            $(row).find('.department').html(data.d[i].department);
                            $(row).find(".MLM1").attr("src", data.d[i].MLM);
                            $(row).find('.MLMcount').html(data.d[i].MLMcount);
                            $(row).find(".ERP").attr("src", data.d[i].ERP);
                            $(row).find('.ERPcount1').html(data.d[i].ERPcount);
                            $(row).find('.WEbportal').attr("src", data.d[i].WebPortal);
                            $(row).find('.Webcount').html(data.d[i].Webcount);
                            $(row).find('.onlinemarket').attr("src", data.d[i].onlinemarket);
                            $(row).find('.onlincount').html(data.d[i].onlincount);
                            $(row).find('.Otherstatus').attr("src", data.d[i].Otherstatus);
                            $(row).find('.Othercount').html(data.d[i].Othercount);
                            $(row).find('.userid').html(data.d[i].status);
                        }
                        $("[id*=grdNoRight] tr").show();
                        $("[id*=grdNoRight] tr:first-child").show();
                    }
                    else {
                        var row = $("[id*=grdNoRight] tr:last-child").clone(true);
                        $("[id*=grdNoRight] tr").not($("[id*=grdNoRight] tr:first-child")).remove();
                        $("[id$=grdNoRight]").append(row);
                        $('#ctl00_ContentPlaceHolder1_grdNoRight').hide(500);
                        $("#ctl00_ContentPlaceHolder1_ddlreporttype").hide(500);

                    }
                    $("[id*=grdNoRight] tr").show();
                    $("[id*=grdNoRight] tr:first-child").show();
                },
                error: function (result) {
                    alertify.error("There is some technical issue");
                }

            });
        }
        function BindsubGrid() {
            var j = 1;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/getsubenquiry",
                data: "{'eid':'" + empcode + "','catid':'" + getcatid + "','productid':'" + ddlsearchbyproduct + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=gridsubenquiry] tr:last-child").clone(true);
                        $("[id*=gridsubenquiry] tr").not($("[id*=gridsubenquiry] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                var row = $("[id*=gridsubenquiry] tr:last-child").clone(true);
                            }
                            $("[id$=gridsubenquiry]").append(row);
                            $(row).find('.sno').html(j);
                            $(row).find('.real_Enqiry_Id').html(data.d[i].Real_Enqiry_Id);
                            $(row).find('.enquirydate').html(data.d[i].enquirydate);
                            $(row).find(".name").html(data.d[i].name);
                            $(row).find('.mobile').html(data.d[i].mobile);
                            $(row).find(".enquirysource").html(data.d[i].enquirysource);
                            $(row).find('.statusname').html(data.d[i].statusname);
                            $(row).find('.assigndate').html(data.d[i].assigndate);
                            $(row).find('.city').html(data.d[i].city);
                            $(row).find("input[type=hidden][id*=enquiryid]").val(data.d[i].enquiryid);

                            pagecount = parseInt(data.d[i].pagecount);

                            if (parseInt(pagecount) == 1) {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                            }

                            j = j + 1;


                            $("#ctl00_ContentPlaceHolder1_grdNoRight").hide(500);
                            $("#ctl00_ContentPlaceHolder1_ddlreporttype").hide(500);
                            $("#ctl00_ContentPlaceHolder1_ddlreporttype").hide(500)
                            $("#goback").show(500);
                            $("#getsungrid").show(500);
                            //$("#ctl00_ContentPlaceHolder1_gridsubenquiry").show(500);

                        }

                        $("[id*=gridsubenquiry] tr").show();
                        $("[id*=gridsubenquiry] tr:first-child").show();
                    }
                    else {
                        var row = $("[id*=gridsubenquiry] tr:last-child").clone(true);
                        $("[id*=gridsubenquiry] tr").not($("[id*=gridsubenquiry] tr:first-child")).remove();
                        $("[id$=gridsubenquiry]").append(row);
                        $(row).find('.sno').html("");
                        $(row).find('.real_Enqiry_Id').html("");
                        $(row).find('.enquirydate').html("");
                        $(row).find(".name").html("");
                        $(row).find('.mobile').html("");
                        $(row).find(".enquirysource").html("");
                        $(row).find('.statusname').html("");
                        $(row).find('.assigndate').html("");
                        $(row).find('.city').html("");
                        alertify.error("These is not any enquiry for this product")

                    }
                    $("[id*=gridsubenquiry] tr").show();
                    $("[id*=gridsubenquiry] tr:first-child").show();
                    getproductname();
                },
                error: function (result) {
                    alertify.error("There is some technical issue");
                }

            });
        }

        function getproductname() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "selectequdis.aspx/getproductname",
                data: "{ 'catid':'" + getcatid + "'}",
                dataType: "json",
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlproduct").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlproduct").append($("<option></option>").val(value.productid).html(value.productname));
                    });
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        //Ready Function for Chart Work
        $(document).ready(function () {
            var Raw = 10; Archive = 50; Approved = 80, Leads = 100, empname = "", chart = "pie2d";
            function Bindgraph() {
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "selectequdis.aspx/getperformance",
                    data: "{ 'eid':'" + empcode + "','catid':'" + getcatid + "'}",
                    dataType: "json",
                    success: function (data) {
                        Raw = data.d[0].rowEnquiry;
                        Archive = data.d[0].archiveEnquiry;
                        Approved = data.d[0].approveEnquiry;
                        Leads = data.d[0].leadEnquiry;
                        empname = data.d[0].empname;
                        Bindchart();
                    },
                    error: function (result) {
                        alert('error');
                    },
                });
            }
            function Bindchart() {
                FusionCharts.ready(function () {
                    var revenueChart = new FusionCharts({
                        "type": chart,
                        "renderAt": "chartContainer",
                        "width": "100%",
                        "height": "500",
                        "dataFormat": "json",
                        "dataSource": {
                            "chart": {
                                "caption": "Total Enquiries Status For",
                                "subCaption": empname,
                                "xAxisName": "Enquiry Status",
                                "yAxisName": "Total Enquiries Status",
                                "theme": "fint"
                            },
                            "data": [
                                      { "label": "Raw", "value": Raw },
                                      { "label": "Leads", "value": Leads },
                                      { "label": "Approved", "value": Approved },
                                      { "label": "Archive", "value": Archive }
                            ]
                        }

                    });
                    revenueChart.render();
                    $('#chartContainer tspan').each(function () {
                        if ($(this).text() == 'FusionCharts XT Trial')
                            $(this).text('');
                    });

                });
            }
            $(".lbtnmlm").click(function () {
                if ($(this).html() != 0) {
                    empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                    getcatid = 1;
                    BindsubGrid();
                    Bindgraph();
                }
                else {
                    alertify.error("There is not any enquiry for this category");
                }
                return false
            });
            $(".lbtnerp ").click(function () {
                if ($(this).html() != 0) {
                    empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                    getcatid = 2;
                    BindsubGrid();
                    Bindgraph();
                }
                else {
                    alertify.error("There is not any enquiry for this category");
                }
                return false
            });
            $(".lbtnwp ").click(function () {
                if ($(this).html() != 0) {
                    empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                    getcatid = 3;
                    BindsubGrid();
                    Bindgraph();

                }
                else {
                    alertify.error("There is not any enquiry for this category");
                }
                return false
            });
            $(".lbtnonlinemarketing ").click(function () {
                if ($(this).html() != 0) {
                    empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                    getcatid = 4;
                    BindsubGrid();
                    Bindgraph();

                }
                else {
                    alertify.error("There is not any enquiry for this category");
                }
                return false
            });
            $(".lbtnother").click(function () {
                if ($(this).html() != 0) {
                    empcode = $(this).parents("tr").children("td:eq(0)").find("span").text();
                    getcatid = 5;
                    BindsubGrid();
                    Bindgraph();
                }
                else {
                    alertify.error("There is not any enquiry for this category");
                }
                return false
            });
            $("#ctl00_ContentPlaceHolder1_ddlsearchoption").change(function () {
                chart = $(this).val();
                Bindchart();
            });
            
        });




    </script>
    <div id="Div1" class="content_top" runat="server">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="viewenquiry.aspx">Enquiry</a></li>
            <%--<li><a href="#">/a></li>--%>
            <li style="background: none;"><a class="active">Enquiry Report</a></li>
        </ul>
        <div class="arrowt">
            <a href="viewenquiry.aspx">
                <img src="../../images/back-button.png" src="selectequdis.aspx" /></a>
        </div>
    </div>
    <My:stu runat="server" ID="MyUserInfoBoxControl" />
    <asp:HiddenField ID="hfpages" runat="server" />
    <div class="content_pane_cont input_content" id="contentPane">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
            class="stm">
            <tr>

                <td colspan="10" class="containerHeadline">
                    <div style="float: left; width: 100%">
                        <asp:DropDownList ID="ddlreporttype" Style="float: right; width: 200px;" runat="server">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="Activated">Activated</asp:ListItem>
                            <asp:ListItem Value="Deactivated">Deactivated</asp:ListItem>
                        </asp:DropDownList>
                        <a style="float: right; margin-right: 10px; font-size: 12px; cursor: pointer" id="adduserpop">Add/Modify User</a>
                        <a style="float: right; margin-right: 10px; font-size: 12px; cursor: pointer" id="goback">Go Back</a>
                    </div>
                </td>
            </tr>
        </table>
        <div class="clear"></div>
        <div>

            <asp:GridView ID="grdNoRight" runat="server" BorderWidth="0px" BorderColor="White"
                AutoGenerateColumns="false" GridLines="none" CssClass="stm" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Emp Code" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblrefno1" CssClass="demo" runat="server" Text='<% #Bind("refno")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbl1" runat="server" CssClass="username" Text='<% #Bind("username")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Department / Designation" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblDepartment1" runat="server" CssClass="department" Text='<% #Bind("department")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MLM" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="lblmlm4" runat="server" Width="16px" ImageUrl='<%# Eval("MLM") %>'
                                CssClass="present MLM1"></asp:Image>
                            [<asp:LinkButton ID="lbtnmlm12" runat="server" Text='<% #Bind("MLMcount")%>' CssClass="lbtnmlm MLMcount"></asp:LinkButton>]
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ERP" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="lblerp1" runat="server" Width="16px" ImageUrl='<%# Eval("ERP") %>'
                                CssClass="present ERP"></asp:Image>
                            [<asp:LinkButton ID="lbtnerp" runat="server" Text='<% #Bind("ERPcount")%>' CssClass="lbtnerp ERPcount1"></asp:LinkButton>]
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Web Development" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="lblwp1" runat="server" Width="16px" ImageUrl='<%# Eval("WEbportal") %>'
                                CssClass="present WEbportal"></asp:Image>
                            [<asp:LinkButton ID="lbtnwp" runat="server" Text='<% #Bind("Webcount")%>' CssClass="lbtnwp Webcount"></asp:LinkButton>]
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ONLINE MARKETING" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="lblmarket1" runat="server" Width="16px" ImageUrl='<%# Eval("onlinemarket") %>'
                                CssClass="present onlinemarket"></asp:Image>
                            [<asp:LinkButton ID="lbtnonlinemarketing" runat="server" Text='<% #Bind("onlincount")%>' CssClass="lbtnonlinemarketing onlincount"></asp:LinkButton>]
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OTHER" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="lblother" runat="server" Width="16px" ImageUrl='<%# Eval("Otherstatus") %>'
                                CssClass="present Otherstatus"></asp:Image>
                            [<asp:LinkButton ID="lbtnother" runat="server" Text='<% #Bind("Othercount")%>' CssClass="lbtnother Othercount"></asp:LinkButton>]
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbledit" Text='<%#Eval("status") %>' runat="server" class="focus1 userid"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
            <div id="getsungrid">
                <br />
                <div >
                    <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px" style="background: none repeat scroll 0 0 #f7f7f7; border: 1px solid #cccccc; color: #333333; float: left; font-size: 13px; height: 25px; margin-left: 1%; margin-bottom: 5px; padding: 3px;">
                        <asp:ListItem Value="pie2d">Select Chart Type</asp:ListItem>
                        <asp:ListItem Value="column2d">Graph Chart 2D </asp:ListItem>
                        <asp:ListItem Value="column3d">Graph Chart 3D </asp:ListItem>
                        <asp:ListItem Value="pie2d">PI Chart 2D </asp:ListItem>
                        <asp:ListItem Value="pie3d">PI Chart 3D</asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div id="chartContainer"></div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadline">
                            <div style="float: left; width: 1200px">
                                  <asp:TextBox ID="txtfromdateforsearch" runat="server" Width="150px" Height="23px"
                                    placeholder="Assign Date From"> </asp:TextBox>
                                <asp:TextBox ID="txttodateforsearch" runat="server" Width="150px" Height="23px" placeholder="Assign Date To"> </asp:TextBox>
                                <%--<asp:DropDownList ID="ddlcategory" runat="server" Width="145px"></asp:DropDownList>--%>
                                <asp:DropDownList ID="ddlproduct" runat="server" Width="150px"></asp:DropDownList>
                                <%-- <asp:DropDownList ID="ddlenquirysource" runat="server" Width="133px">
                                </asp:DropDownList>--%>

                                <%-- <asp:TextBox ID="txtnamesearch" runat="server" Width="117px" Height="23px" placeholder="Make Your Search"> </asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" Height="23px"/>
                               <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" 
                                    BackColor="#E2E2E2" Height="20px"
                                    CssClass="btnExcel" ToolTip="Click here to download Excel sheet" OnClientClick="return false;"  />--%>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="gridsubenquiry" AutoGenerateColumns="false" EmptyDataText="No data found !"
                    Width="100%" CssClass="stm" GridLines="None" runat="server">
                    <Columns>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="S.No">
                            <ItemTemplate>
                                <asp:Label CssClass="sno" ID="lblroeno" Text="1" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="3%" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Enquiry No.">
                            <ItemTemplate>
                                <asp:Label CssClass="real_Enqiry_Id" ID="lblenquiryno" Text='<%#Eval("real_Enqiry_Id") %>'
                                    runat="server"></asp:Label>
                                <asp:HiddenField runat="server" ID="enquiryid" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Enquiry Date">
                            <ItemTemplate>
                                <asp:Label ID="lblenqdate1" CssClass="enquirydate" Text='<%#Eval("enquirydate","{0:MMM dd yyyy}") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Assign Date">
                            <ItemTemplate>
                                <asp:Label ID="assigndate" CssClass="assigndate" Text='<%#Eval("assigndate","{0:MMM dd yyyy}") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname1" CssClass="name" Text='<%#Eval("name") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Mobile No">
                            <ItemTemplate>
                                <asp:Label ID="lblmob" Text='<%# Eval("mobile") %>' runat="server" CssClass="mobile"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>
                        <%--     <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Enquiry Source">
                                <ItemTemplate>
                                    <asp:Label ID="lblenqdate222" CssClass="enquirysource" Text='<%#Eval("enquirysource") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                            </asp:TemplateField>--%>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product">
                            <ItemTemplate>
                                <asp:Label ID="lblcitytemplate" CssClass="city" Text='<%#Eval("city") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblstatus1" CssClass="statusname" Text='<%#Eval("statusname") %>' runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>

                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>

                  <div style="width: 1070px" class="containerHeadline">
                                <div style="margin-left: 0px; float: left; width: 500px;">
                                    <asp:Label ID="lblpage" CssClass="lblpage" Style="color: green; font-size: 11pt; font-weight: bold"
                                        runat="server"></asp:Label>
                                    of
                                <asp:Label ID="lblTotalPages" CssClass="lbltotalpage" Style="margin-left: 0px; font-size: 11pt; font-weight: bold"
                                    runat="server"></asp:Label>
                                    <span style="font-size: 11pt">Page</span>
                                </div>
                                <div style="margin-left: 0px; float: left; width: 500px;">
                                    <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; width: 22px; height: 22px"
                                        alt="" />
                                    <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; width: 22px; height: 22px"
                                        alt="" />
                                    <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; width: 22px; height: 22px"
                                        alt="" />
                                    <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; width: 22px; height: 22px"
                                        alt="" />
                                </div>
                            </div>
                
            </div>

        </div>
        <div id="popupdiv" class="showpopup" style="text-align: center; margin-left: -24px !important; display: none">
            <div style="text-align: right;">
                <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>
            <div id="content">

                <table id="tbl1" class="file_border bkrt" style="width: 100%">
                    <tr>
                        <td>
                            <div class="for_sigle_row_form">
                                <label>Select User:<span style="color: Red">*</span></label>
                                <asp:DropDownList ID="ddluser" runat="server" Style="margin-right: 294px;"></asp:DropDownList>
                            </div>
                            <hr />
                            <div class="for_sigle_row_form" id="totalproducts">
                                <label>No of Enquiries</label>
                                <asp:GridView ID="GridView1" AutoGenerateColumns="false" EmptyDataText="No data found !"
                                    Width="60%" CssClass="stm" GridLines="None" runat="server">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl" runat="server" CssClass="ecatid" Text='<% #Bind("ecatid")%> '></asp:Label>
                                                <asp:HiddenField ID="p1" runat="server" Value='<% #Bind("pid")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Enquiry">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcourse" runat="server" class="noofenquiry" Text='<% #Bind("noofenquiry")%>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                </asp:GridView>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>Select Product<span style="color: Red">*</span></label>
                                <asp:GridView ID="grd1" AutoGenerateColumns="false" EmptyDataText="No data found !"
                                    Width="60%" CssClass="stm" GridLines="None" runat="server">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcourse" runat="server" class="ecatname" Text='<% #Bind("ecatname")%>'></asp:Label>
                                                <asp:HiddenField ID="hd1" runat="server" Value='<% #Bind("id")%>' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="70%" />
                                        </asp:TemplateField>

                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                            <ItemTemplate>
                                                <input type="checkbox" id="chk1" class="status" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                </asp:GridView>
                                <div class="clear">
                                </div>
                                <div class="clear">
                                </div>
                                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" ToolTip="Click here to submit details."
                                    Style="float: right; margin-right: 124px; margin-top: 10px;" />

                            </div>
                            <br />
                        </td>
                    </tr>
                </table>

                <div id="tab1">
                </div>
            </div>
        </div>

        <div id="actdeactdiv" class="showpopup1" style="text-align: center; margin-left: -24px !important; display: none">
            <div style="text-align: right;">
                <a id="closeactdeact" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>
            <div>
                <div class="for_sigle_row_form">
                    <label>Select Product<span style="color: Red">*</span></label>
                    <asp:GridView ID="grdactdeactuser" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        Width="60%" CssClass="stm" GridLines="None" runat="server">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblcourse" runat="server" class="actecatname" Text='<% #Bind("ecatname")%>'></asp:Label>
                                    <asp:HiddenField ID="actuserid" runat="server" Value='<% #Bind("eqid")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="70%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                <ItemTemplate>

                                    <input type="checkbox" id="chk1" class="status" runat="server" />
                                    <asp:HiddenField ID="productid" runat="server" Value='<% #Bind("productid")%>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                    <div class="clear">
                    </div>
                    <div class="clear">
                    </div>
                    <asp:Button runat="server" ID="btnactivemember" Text="Submit" CssClass="button_save" ToolTip="Click here to submit details."
                        Style="float: right; margin-right: 83px; margin-top: 10px;" />

                </div>
            </div>
        </div>

        <div id="forfit" class="showpopup2" style="text-align: center; margin-left: -24px !important; display: none">
            <div style="text-align: right;">
                <a id="forfitclose" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>
            <div id="forfeit" style="padding: 1%">
                <div class="for_sigle_row_form">

                    <asp:GridView ID="grdforfitenquiry" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        Width="100%" CssClass="stm" GridLines="None" runat="server">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblcourse" runat="server" class="removecatname" Text='<% #Bind("catname")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Total">
                                <ItemTemplate>
                                    <asp:Label ID="lbltotalenq" runat="server" class="enqtotal" Text='<% #Bind("totalcount")%>'></asp:Label>
                                    <asp:HiddenField runat="server" ID="catid" Value='<%#Eval("catid") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                <ItemTemplate>
                                    <input type="checkbox" id="chk1" class="status" runat="server" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                    <div class="clear">
                    </div>
                    <div class="clear">
                    </div>
                    <asp:Button runat="server" ID="btnforfeit" Text="Forfeit" CssClass="button_save" ToolTip="Click here to submit details."
                        Style="float: right; margin-top: 10px;" />

                </div>
            </div>
            <div id="deactivecatlist" style="padding: 1%">
                <div class="for_sigle_row_form">

                    <asp:GridView ID="grddeactivecatlist" AutoGenerateColumns="false" EmptyDataText="No data found !"
                        Width="100%" CssClass="stm" GridLines="None" runat="server">
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbldeactivecatname" runat="server" class="deactivecatname" Text='<% #Bind("catname")%>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkstatus" CssClass="activestatus" Checked="true" />
                                    <asp:HiddenField runat="server" ID="deacatid" Value='<%#Eval("deacatid") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                    <div class="clear">
                    </div>
                    <div class="clear">
                    </div>
                    <asp:CheckBox runat="server" ID="chekboth" Style="float: right; margin-top: 18px;" Text="Remove Both Auto and Mannual Distribution" />
                    <asp:Button runat="server" ID="btndeactiveuser" Text="Deactive" CssClass="button_save" ToolTip="Click here to submit details."
                        Style="float: right; margin-top: 10px;" />


                </div>

            </div>

        </div>

        <div id="followuphistory" class="showpopup3" style="text-align: center; margin-left: -24px !important; display: none">
             <div style="text-align: right;">
                <a id="followhistoryclose" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
            </div>
            <table id="CustomerTable" class="stm">
                            <tr class="stm_head" >
                                <th scope="col"> S. No.</th>
                                <th scope="col"> Contacted Date</th>
                                <th scope="col"> Contacted Time</th>
                                <th scope="col">Follow Up Date</th>
                                <th scope="col">Follow Up Time</th>
                                <th scope="col" style="width:40%;">Remarks</th>
                                <th scope="col">Contacted By</th>
                                <th scope="col">Status</th>
                            </tr>
                        </table>
        </div>
    </div>
</asp:Content>
