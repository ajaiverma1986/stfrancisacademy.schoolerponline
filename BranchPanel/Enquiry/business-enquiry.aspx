<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="business-enquiry.aspx.cs" EnableEventValidation="false" Inherits="branchpanel_business_enquiry" %>

<%@ Register Src="~/BranchPanel/Enquiry/enquiry.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />
    <%-- Script for Alert--%>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <%-- Script for Alert--%>
    <style type="text/css">
        #popupdiv {
            width: 95% !important;
            height: 90% !important;
        }

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

            #CustomerTable th {
                font-size: 12pt;
                background: #f8f8f8;
                font-weight: bold;
                padding: 2px;
                width: 150px!important;
            }

            #CustomerTable td {
                text-align: center!important;
                font-size: 11pt;
            }

        .containerHeadline select {
            padding: 3px !important;
        }

        .active2222 {
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

        .showpopup {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #8cbf26;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: 438px;
            left: 13%;
            opacity: 1;
            padding-bottom: 20px;
            position: fixed;
            top: 2%;
            width: 76%;
            z-index: 2147483647;
        }

            .showpopup td {
                vertical-align: top;
                color: #666666;
            }

        .for_sigle_row_form {
            border-bottom: 1px solid #f5f5f5;
            height: auto;
            margin-bottom: 0;
            margin-left: auto;
            margin-right: auto;
            min-height: auto;
            padding: 5px 0;
            width: 100%;
        }

            .for_sigle_row_form label {
                color: #616161;
                float: left;
                font-size: 13px;
                margin-right: 20px;
                padding-top: 2px;
                text-align: right;
                width: 220px;
            }

        .stm_head {
            background: none repeat scroll 0 0 #f1f1f1 !important;
            border-bottom: 1px solid #dddddd;
            border-right: 1px solid #dddddd;
            font-weight: bold;
            line-height: 27px;
            padding-left: 10px;
        }

        .stm td {
            border-bottom: 1px solid #dddddd;
            color: #333;
            line-height: 15px;
            border-left: 1px solid #ccc;
            text-align: center !important;
        }

        .stm_head th {
            border-right: 1px solid #dddddd;
            border-top: 1px solid #dddddd;
            color: #333 !important;
            font-size: 12px;
            padding-left: 0px;
            text-align: center !important;
        }
    </style>
    <script type="text/javascript">

        function pageLoad() {
            $("#<%=ddlproduct.ClientID%> option[value='Select MLM Product ']").addClass('ddlIndxO');
            $("#<%=ddlproduct.ClientID%> option[value='Select ERP Product ']").addClass('ddlIndxO');
            $("#<%=ddlproduct.ClientID%> option[value='Select WEB PORTAL Product ']").addClass('ddlIndxO');
            $("#<%=ddlproduct.ClientID%> option[value='Select ONLINE MARKETING Product ']").addClass('ddlIndxO');
            $("#<%=ddlproduct.ClientID%> option[value='Select OTHER Product ']").addClass('ddlIndxO');
            $("#<%=ddlenqtype.ClientID%> option[value='0']").addClass('ddlIndxO');

            $('#trfornorecord').css("display", "none");
            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);
            $('#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
            BindDatePicker();

            $("#tdClosepopup").click(function () {
                $('#popupdiv').dialog('close');
                $('.ui-widget').click();
                $("#tbl1").css("display", "block");
                $("#tbl2").css("display", "block");
                $("#CustomerTable").css("display", "none");
                $("#btnback").css("display", "none");

            });
        }

        function BindDatePicker() {
            $(document).ready(function () {
                $("#ctl00_ContentPlaceHolder1_txtfromdateforsearch").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'yy-mm-dd'
                });
                $("#ctl00_ContentPlaceHolder1_txttodateforsearch").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'yy-mm-dd'
                });

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

        var ddlsearchbydate = "", ddlfromdate = "", ddltodate = "", ddlsearchbyproduct = "", ddlsearchbyenquirysource = "", ddlsearchbystatus = "", ddlsearchby = "", txtsearchtext = "", pagecount = 1, pagesize = 15, pageno = 1;
        var startindex = 1, endindex = 100, identifylastpage = "";
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddlsearchbydate').live('change', function () {
                if (this.value != "0") {
                    ddlsearchbydate = $.trim(this.value);
                }
                else {
                    ddlsearchbydate = "";
                }
            });

            $("#ctl00_ContentPlaceHolder1_txtfromdateforsearch").on('change keyup paste blur', function () {
                if (ddlsearchbydate != "") {
                    ddlfromdate = $.trim($(this).val());
                    BindGridAfterSearching();
                }

            });

            $("#ctl00_ContentPlaceHolder1_txttodateforsearch").on('change keyup paste blur', function () {
                if (ddlsearchbydate != "") {
                    if (ddlfromdate != "") {
                        ddltodate = $.trim($(this).val());
                        BindGridAfterSearching();
                    }
                }
            });

            $('#ctl00_ContentPlaceHolder1_ddlproduct').live('change', function () {

                startindex = parseInt(1);
                endindex = parseInt(startindex) + parseInt(99);
                ddlsearchbyproduct = $.trim(this.value);

                BindGridAfterSearching();

            });

            $('#ctl00_ContentPlaceHolder1_ddlenquirysource').live('change', function () {

                if (this.value != "0") {
                    ddlsearchbyenquirysource = $.trim(this.value);
                    BindGridAfterSearching();
                }
                else {
                    ddlsearchbyenquirysource = "";
                    BindGridAfterSearching();
                }

            });

            $('#ctl00_ContentPlaceHolder1_ddlsearchingstatus').live('change', function () {

                if (this.value != "0") {
                    ddlsearchbystatus = $.trim(this.value);
                    BindGridAfterSearching();
                }
                else {
                    ddlsearchbystatus = "";
                    BindGridAfterSearching();
                }

            });

            $('#ctl00_ContentPlaceHolder1_ddlsearchoption').live('change', function () {
                if (this.value != "0") {
                    ddlsearchby = $.trim(this.value);
                }
                else {
                    ddlsearchby = "";
                }
            });

            $('#ctl00_ContentPlaceHolder1_txtnamesearch').blur(function () {
                if ($.trim($(this).val()) != "") {
                    txtsearchtext = $.trim($(this).val());
                }

                else {
                    txtsearchtext = "";
                }
            });

            $('#ctl00_ContentPlaceHolder1_Button1').click(function () {
                if (ddlsearchby != "" && txtsearchtext != "") {
                    BindGridAfterSearching();
                    return false;
                }
                if (ddlsearchby == "" && txtsearchtext == "") {
                    BindGridAfterSearching();
                    return false;
                }
                if (ddlsearchby != "" && txtsearchtext == "") {
                    alertify.error('Please Enter The Search Value Before Go.');
                    return false;
                }
            });

            $('#ctl00_ContentPlaceHolder1_firstpage').click(function () {
                identifylastpage = "";
                if (startindex == 1 && endindex == 100) {
                    alertify.error('You Are Already On The First Page.');
                }
                else {
                    startindex = 1;
                    endindex = 100;
                    BindGridAfterSearching();
                }
            });

            $('#ctl00_ContentPlaceHolder1_previous').click(function () {
                identifylastpage = "";
                if (startindex == 1 && endindex == 100) {
                    alertify.error('No Previous Page Is Available.');
                    return;
                }
                else {
                    identifylastpage = ""
                    startindex = parseInt(startindex) - 100
                    endindex = parseInt(endindex) - 100;
                    BindGridAfterSearching()
                }
            });

            $('#ctl00_ContentPlaceHolder1_next').click(function () {
                identifylastpage = "";
                startindex = parseInt(startindex) + 100
                endindex = parseInt(endindex) + 100;
                BindGridAfterSearching()
            });

            $('#ctl00_ContentPlaceHolder1_last').click(function () {
                if (identifylastpage == "yes") {
                    alertify.error('You Are Already On The Last Page.');
                }
                identifylastpage = "yes";
                startindex = 0;
                endindex = 0;
                BindGridAfterSearching()
            });
            $('#btnback').click(function () {
                $("#tbl1").show(500);
                $("#tbl2").show(500);
                $("#CustomerTable").hide(500);
                $('#btnback').hide(500);
                $(".ui-dialog-titlebar").text("Enquiry Details");
            });

        });

        function BindGridAfterSearching() {
            var row;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Comman.aspx/BindDatatable",
                data: "{'gridtype':'businessgrid','identifylastpage':'" + identifylastpage + "','startindex':'" + startindex + "','endindex':'" + endindex + "','ddlsearchbydate':'" + ddlsearchbydate + "','ddlfromdate':'" + ddlfromdate + "','ddltodate':'" + ddltodate + "','ddlsearchbyproduct':'" + ddlsearchbyproduct + "','ddlsearchbyenquirysource':'" + ddlsearchbyenquirysource + "','ddlsearchbystatus':'" + ddlsearchbystatus + "','ddlsearchby':'" + ddlsearchby + "','txtsearchtext':'" + txtsearchtext + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                        $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();
                        for (var i = 0; i < data.d.length; i++) {
                            if (i != 0) {
                                startindex = parseInt(data.d[0].RowNumber);
                                endindex = parseInt(data.d[i].RowNumber);
                                var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                            }
                            $("[id$=gridenquiry]").append(row);
                            $(row).find('.sno').html(data.d[i].RowNumber);
                            $(row).find('.realenquiryno').html(data.d[i].real_Enqiry_Id);
                            $(row).find('.enqdate').html(data.d[i].enquirydate);
                            $(row).find('.enqsource').html(data.d[i].enquirysource);
                            $(row).find('.enqtype').html(data.d[i].enqtype);
                            $(row).find('.nameforjquery').html(data.d[i].name);
                            $(row).find('.mobile').html(data.d[i].mobile);

                            $(row).find('.forcontactdate').html(data.d[i].contactdate);
                            $(row).find('.statusname').html(data.d[i].statusname);
                            $(row).find('.followupdate').html(data.d[i].followupdate);
                            $(row).find('.gridViewToolTip').html('View');
                            $(row).find('.forsmcid').html(data.d[i].enquiryid);

                            pagecount = parseInt(data.d[i].pagecount);

                            if (parseInt(pagecount) == 1) {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                            }
                        }
                        $("[id*=gridenquiry] tr").show();
                        $("[id*=gridenquiry] tr:first-child").show();
                    }

                    else {
                        var row = $("[id*=gridenquiry] tr:last-child").clone(true);
                        $("[id*=gridenquiry] tr").not($("[id*=gridenquiry] tr:first-child")).remove();
                        $("[id$=gridenquiry]").append(row);
                        $("[id*=gridenquiry] tr:eq(1)").hide();
                        $('#trfornorecord').show(500);
                    }

                },
                error: function (result) {
                    alert("Sorry");
                }

            });
        }

        function InitializeToolTip() {
            $(".gridViewToolTip").tooltip({

                track: true,

                delay: 0,

                showURL: false,

                fade: 100,

                bodyHandler: function () {

                    return $($(this).next().html());

                },

                showURL: false

            });

        }

        var enquirydate = '', source = '', sourceid = '', name = '', femail = '', fmobile = '', statustxt = '', statusid = '', contactdate = '',
               followuptime = '', followuptimeid = '', contactby = '', followupdate = '', contacttime = '', contacttimeid = '',
               remark = '', landlineno = '', city = '', msg = '', email2 = '', email3 = '', mob2 = '', mob3 = '', chk = '', enquirytypeid = '', enquirytypetxt = '';
        var eid = "";

        function forshow() {
            $('.gridViewToolTip').click(function () {

                eid = $(this).parent('dl').find('.forsmcid').text();
                window.location.replace("../add-new-registration.aspx?enqid="+eid);
                return false;
            });
        }

        function showmobilecontrol(e) {

            if (e == "ctl00_ContentPlaceHolder1_imgbtn1") {
                if (document.getElementById('ctl00_ContentPlaceHolder1_mob2').style.display == 'none') {
                    $('#ctl00_ContentPlaceHolder1_mob2').show(500);
                    return;
                }
                if (document.getElementById('ctl00_ContentPlaceHolder1_mob2').style.display == 'block') {
                    $('#ctl00_ContentPlaceHolder1_mob3').show(500);
                    return;
                }
            }
            else if (e == "ctl00_ContentPlaceHolder1_imge1") {
                if (document.getElementById('ctl00_ContentPlaceHolder1_divforemail2').style.display == 'none') {
                    $('#ctl00_ContentPlaceHolder1_divforemail2').show(500);
                    return;
                }
                if (document.getElementById('ctl00_ContentPlaceHolder1_divforemail2').style.display == 'block') {
                    $('#ctl00_ContentPlaceHolder1_divforemail3').show(500);
                    return;
                }
            }
            else if (e == "ctl00_ContentPlaceHolder1_Imgbtn3") {
                $('#ctl00_ContentPlaceHolder1_mob2').hide(500);
            }
            else if (e == "ctl00_ContentPlaceHolder1_Imgbtn4") {
                $('#ctl00_ContentPlaceHolder1_mob3').hide(500);
            }

            else if (e == "ctl00_ContentPlaceHolder1_ImageButton1") {
                $('#ctl00_ContentPlaceHolder1_divforemail2').hide(500);
            }
            else if (e == "ctl00_ContentPlaceHolder1_ImageButton2") {
                $('#ctl00_ContentPlaceHolder1_divforemail3').hide(500);
            }
            else if (e == "ctl00_ContentPlaceHolder1_chk") {
                if (document.getElementById('ctl00_ContentPlaceHolder1_chk').checked == true) {
                    $('#divfd').show(500);
                    $('#divft').show(500);
                }
                else {
                    $('#divfd').hide(500);
                    $('#divft').hide(500);
                }
            }
        }
        function showpreviousdata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Comman.aspx/GetFollowupdata",
                data: "{'eid':'" + eid + "'}",
                dataType: "json",
                success: function (data) {

                    $("#tbl1").hide(500);
                    $("#tbl2").hide(500);
                    $("#CustomerTable").show(500);
                    $("#btnback").show(500);
                    $(".ui-dialog-titlebar").text("Previous Contacted Details");
                    if (data.d.length > 0) {
                        var row = $("[id*=CustomerTable] tr:last-child").clone(true);
                        $("[id*=CustomerTable] tr").not($("[id*=CustomerTable] tr:first-child")).remove();

                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("<tr />");

                            $("#CustomerTable").append(row); //this will append tr element to table... keep its reference for a while since we will add cels into it

                            row.append($("<td>" + data.d[i].rownumber + "</td>"));
                            //row.append($("<td>" + data.d[i].enquiryid + "</td>"));
                            row.append($("<td>" + data.d[i].contacteddate + "</td>"));
                            row.append($("<td>" + data.d[i].contactedtime + "</td>"));
                            row.append($("<td>" + data.d[i].followdate + "</td>"));
                            row.append($("<td>" + data.d[i].followtime + "</td>"));
                            row.append($("<td>" + data.d[i].remarks + "</td>"));
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
                        //row.append($("<td>" + data.d[i].enquiryid + "</td>"));
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
            <li style="background: none;"><a class="active">View Enquiry</a></li>
        </ul>
    </div>

    <My:stu runat="server" ID="MyUserInfoBoxControl" />
    <asp:HiddenField ID="hfpages" runat="server" />
    <asp:UpdatePanel ID="upp1" runat="server">
        <ContentTemplate>
            <script type="text/javascript" lang="javascript">
                Sys.Application.add_load(forshow);
            </script>
            <div id="popupdiv" class="showpopup" style="text-align: center; margin-left: -145px !important; height: 100%; display: none">

                <div style="text-align: right;">
                    <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer; font-weight: bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
                </div>
                <div id="content">
                    <div>
                        <table id="tbl1" class="file_border bkrt" cellpadding="2" cellspacing="0" border="0" style="width: 580px; float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #8CBF26; margin: 20px 20px; margin-top: 30px; position: relative; padding-top: 30px;">
                            <tr>
                                <td>
                                    <div class="form-box-heading">
                                        Enquiry Details
                                    </div>

                                    <div style="margin: -8px 200px 5px; font-size: 12pt; font-weight: bold; background-color: #a50505; width: 200px!important; color: white!important; text-align: center!important;"
                                        class="for_sigle_row_form">
                                        <label style="font-size: 12pt; font-weight: bold; color: white; margin-left: -70px; margin-top: -2px;">
                                            Enquiry ID:
                                        </label>
                                        <asp:Label ID="lblrealid" Style="font-size: 12pt; font-weight: bold; margin-left: -35px"
                                            runat="server" Text="00000"></asp:Label>
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>
                                            Enquiry Date</label>
                                        <asp:TextBox ID="txtToDate" runat="server" autoComplete="off" Width="210px" ReadOnly="true"></asp:TextBox>
                                        <asp:DropDownList ID="ddleh1" Width="90px" runat="server" Enabled="false">
                                        </asp:DropDownList>
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>
                                            Enquiry Source</label>
                                        <asp:DropDownList runat="server" ID="ddlenquiry" Enabled="false">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Product</label>
                                        <asp:DropDownList runat="server" ID="ddlenqtype">
                                        </asp:DropDownList>
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>Name</label>
                                        <asp:TextBox ID="txtname" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rd2" runat="server" ErrorMessage="Please Enter Name"
                                            ControlToValidate="txtname" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>
                                            Contact No.</label>
                                        <asp:TextBox ID="txtFMobile" runat="server" MaxLength="12" value="" data-placement="right" data-original-title="Please Enter Contact No." rel="tooltip" class="span2" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;

                      <asp:Label ID="lblchkmob" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                        <asp:ImageButton ID="imgbtn1" runat="server" ImageUrl="~/images/addmore.png"
                                            CausesValidation="false" Height="20" Width="20" OnClientClick="showmobilecontrol(this.id)" ToolTip="click here to add another mobile no." />
                                    </div>

                                    <div id="mob2" runat="server" style="display: none" class="for_sigle_row_form">
                                        <label>
                                            Mobile No2<span style="color: Red">*</span></label>
                                        <asp:TextBox ID="txtmob2" runat="server" MaxLength="12" value="" data-placement="right" data-original-title="Please Enter Contact No." rel="tooltip" class="span2" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;

                    <asp:Label ID="Label3" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                        <asp:ImageButton ID="Imgbtn3" runat="server"
                                            ImageUrl="~/images/remove.png" CausesValidation="false" OnClientClick="showmobilecontrol(this.id)"
                                            ToolTip="click here to add another mobile no." Height="20" Width="20" />
                                    </div>

                                    <div class="for_sigle_row_form" id="mob3" style="display: none" runat="server">
                                        <label>
                                            Mobile No3<span style="color: Red">*</span></label>
                                        <asp:TextBox ID="txtmob3" runat="server" MaxLength="12" value="" data-placement="right" data-original-title="Please Enter Contact No." rel="tooltip" class="span2" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;

                    <asp:Label ID="Label4" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                                        <asp:ImageButton ID="Imgbtn4" runat="server" ImageUrl="~/images/remove.png" OnClientClick="showmobilecontrol(this.id)" CausesValidation="false"
                                            Height="20" Width="20" />
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>
                                            EmailId</label>
                                        <asp:TextBox ID="txtFEmailid" runat="server"></asp:TextBox>&nbsp;
                        <asp:Label runat="server" ID="lblmsg" ForeColor="Red"></asp:Label>
                                        <asp:ImageButton ID="imge1" runat="server" ImageUrl="~/images/addmore.png" CausesValidation="false" OnClientClick="showmobilecontrol(this.id)"
                                            ToolTip="click here to add another emailid." Height="20" Width="20" />
                                    </div>
                                    <div class="for_sigle_row_form" id="divforemail2" runat="server">
                                        <label>
                                            Email ID2</label>
                                        <asp:TextBox ID="TextBox1" value="" data-placement="right" data-original-title="Please Enter EMailid"
                                            rel="tooltip" class="span2" runat="server" autoComplete="off"></asp:TextBox>&nbsp;
                    <asp:Label runat="server" ID="Label1" ForeColor="Red"></asp:Label>
                                        <asp:Label runat="server" ID="Label2" ForeColor="Red" Visible="false"></asp:Label>
                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/remove.png" OnClientClick="showmobilecontrol(this.id)" CausesValidation="false"
                                            Height="20" Width="20" />
                                    </div>
                                    <div class="for_sigle_row_form" id="divforemail3" runat="server">
                                        <label>
                                            Email ID3</label>
                                        <asp:TextBox ID="TextBox2" value="" data-placement="right" data-original-title="Please Enter EMailid"
                                            rel="tooltip" class="span2" runat="server" AutoPostBack="true" autoComplete="off"></asp:TextBox>&nbsp;
                    <asp:Label runat="server" ID="Label7" ForeColor="Red"></asp:Label>
                                        <asp:Label runat="server" ID="Label8" ForeColor="Red" Visible="false"></asp:Label>
                                        <asp:ImageButton ID="ImageButton2" OnClientClick="showmobilecontrol(this.id)" runat="server"
                                            ImageUrl="~/images/remove.png" CausesValidation="false"
                                            Height="20" Width="20" />
                                    </div>

                                    <div class="for_sigle_row_form" style="display: none">
                                        <label>
                                            LandLine No.</label>
                                        <asp:TextBox ID="txtlandno" runat="server" MaxLength="12" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;
                                    </div>

                                    <div class="for_sigle_row_form">
                                        <label>
                                            City</label>
                                        <asp:TextBox ID="txtcity" runat="server"></asp:TextBox>&nbsp;
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Message</label>
                                        <asp:TextBox ID="txtmsg" Style="width: 300px!important" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
                                    </div>
                                    <br />
                                </td>
                            </tr>
                        </table>
                        <table id="tbl2" class="file_border bkrt" cellpadding="2" cellspacing="0" border="0" style="padding-bottom: 15px; width: 550px; float: left; background: #F7F7F7; border-radius: 0px; border: 1px solid #8CBF26; padding-top: 30px; position: relative; margin-top: 30px;">
                            <tr>
                                <td>
                                    <div class="form-box-heading">
                                        Final Details
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Last Contacted Date</label>
                                        <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>&nbsp;
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Time</label>
                                        <asp:DropDownList ID="ddlsh" Width="100px" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="for_sigle_row_form">
                                        <label>
                                            Approved By</label>
                                        <asp:TextBox ID="txtcontactedby" runat="server"></asp:TextBox>&nbsp;
                                    </div>

                                    <div class="for_sigle_row_form" style="display: none">
                                        <label>
                                            Status</label>

                                        Approved
                                <asp:DropDownList runat="server" ID="ddlstatus" Visible="false">
                                </asp:DropDownList>
                                    </div>

                                    <%-- <div class="for_sigle_row_form">
                                <label>
                                    Mark as follow:</label>
                                <asp:CheckBox ID="chk" onclick="showmobilecontrol(this.id)" runat="server" />
                            </div>

                            <div id="divfd" class="for_sigle_row_form">
                                <label>
                                    Followup Date</label>
                                <asp:TextBox ID="txtMDOB" runat="server"></asp:TextBox>&nbsp;
                        <div class="clear">
                        </div>
                            </div>
                            <div id="divft" class="for_sigle_row_form">
                                <label>
                                    Followup Time</label>
                                <asp:DropDownList ID="ddleh" Width="100px" runat="server">
                                </asp:DropDownList>
                            </div>--%>
                                    <div class="for_sigle_row_form">
                                        <label></label>
                                        <a href="#" onclick="showpreviousdata()">click here to see the previous contacted details</a>
                                    </div>
                                    <div class="for_sigle_row_form">

                                        <label>
                                            Remarks
                                        </label>

                                        <asp:TextBox ID="txtremark" Style="width: 300px" runat="server" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="CustomerTable" style="display: none; width: 1197px!important; padding: 10px 10px 10px 10px; font-size: 12pt; font-family: Arial; border-bottom-color: green" border="1" cellpadding="5" cellspacing="1">

                            <tr>

                                <th>S. No.</th>
                                <th>Contacted Date</th>
                                <th>Contacted Time</th>
                                <th>Follow Up Date</th>
                                <th>Follow Up Time</th>
                                <th>Remarks</th>
                                <th>Contacted By</th>
                                <th>Status</th>
                            </tr>
                        </table>
                        <a id="btnback" style="display: none!important; font-size: 11pt; font-weight: bold" href="#">Back</a>
                    </div>
                </div>
            </div>

            <div class="content_pane_cont input_content" id="contentPane">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadline">
                            <div style="float: left; width: 1200px;">

                                <asp:DropDownList ID="ddlsearchbydate" runat="server" Width="133px">
                                    <asp:ListItem Value="enquirydate">Search By Date</asp:ListItem>
                                    <asp:ListItem Value="enquirydate">Search By Enquiry Date</asp:ListItem>
                                    <asp:ListItem Value="contacteddate">Search By Contacted Date</asp:ListItem>
                                    <asp:ListItem Value="followupdate">Search By Follow Up Date</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="txtfromdateforsearch" runat="server" Width="70px" Height="23px" placeholder="Date From"> </asp:TextBox>
                                <asp:TextBox ID="txttodateforsearch" runat="server" Width="70px" Height="23px" placeholder="Date To"> </asp:TextBox>
                                <asp:DropDownList ID="ddlproduct" runat="server" Width="133px"></asp:DropDownList>
                                <asp:DropDownList ID="ddlenquirysource" runat="server" Width="133px"></asp:DropDownList>
                                <asp:DropDownList ID="ddlsearchingstatus" runat="server" Width="150px" Style="display: none"></asp:DropDownList>
                                <asp:DropDownList ID="ddlsearchoption" runat="server" Width="100px">
                                    <asp:ListItem Value="0">Search By</asp:ListItem>
                                    <asp:ListItem Value="Enquiry No">Enquiry No</asp:ListItem>
                                    <asp:ListItem Value="Name">Name</asp:ListItem>
                                    <asp:ListItem Value="Mobile">Mobile</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="txtnamesearch" runat="server" Width="117px" Height="23px" placeholder="Make Your Search"> </asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search" CssClass="view-enquiry" Height="23px" />
                                <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                                    BackColor="#E2E2E2" CausesValidation="false" Height="20px"
                                    CssClass="excel" ToolTip="Click here to download Excel sheet" Enabled="false" />
                            </div>

                            <div class="clear"></div>

                            <div style="float: right; margin-top: 8px !important; width: 1000px;">
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView ID="gridenquiry" AutoGenerateColumns="false" EmptyDataText="No data found."
                                Width="100%" CssClass="stm" runat="server" GridLines="None">
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="60px" HeaderText="S.No">
                                        <ItemTemplate>
                                            <asp:Label CssClass="sno" ID="lblroeno" Text='<%#Eval("RowNumber") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" HeaderText="Enquiry No.">
                                        <ItemTemplate>
                                            <asp:Label CssClass="realenquiryno" ID="lblenquiryno" Text='<%#Eval("real_Enqiry_Id") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Enquiry Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblenqdate1" CssClass="enqdate" Text='<%#Eval("enquirydate","{0:MMM dd yyyy}") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Approved Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcontactedate1" CssClass="forcontactdate" Text='<%#Eval("contacteddate","{0:MMM dd yyyy}") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblname1" CssClass="nameforjquery" Text='<%#Eval("name") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderText="Mobile No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblmob" CssClass="mobile" Text='<%#Eval("mobile") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="80px" HeaderText="Class">
                                        <ItemTemplate>
                                            <asp:Label ID="lblenqdate" CssClass="enqtype" Text='<%#Eval("enqtype") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Enquiry Source">
                                        <ItemTemplate>
                                            <asp:Label ID="lblenqdate222" CssClass="enqsource" Text='<%#Eval("enquirysource") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" HeaderText="Approved By">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcontactedby1" runat="server" Text='<%#Eval("contactedby") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Task" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <dl>
                                                <asp:LinkButton ID="lnkView" class="gridViewToolTip" runat="server" Text="View" Font-Underline="true"
                                                    ForeColor="Chocolate" Style="text-decoration: none !important;"> </asp:LinkButton>

                                                <asp:Label ID="lblkeyid" runat="server" CssClass="forsmcid" Style="display: none" Text='<%#Eval("enquiryid") %>'></asp:Label>
                                            </dl>
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

                    <tr id="trfornorecord">
                        <td>
                            <asp:Label ID="lblnorecordfound" runat="server" Style="color: red; margin-left: 200px !important">No record found according to your searching</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%; padding: 4px 10px 10px 10px;">
                            <asp:Label ID="lblmessage" runat="server" Text="No enquiry list according to your searching." Style="display: none; color: red; font-size: 15px; margin-left: 100px !important;"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trforimagepagging" runat="server" style="display: none">
                        <td align="left" style="width: 1070px" class="containerHeadline">
                            <div style="margin-left: 0px; float: left; width: 500px;">
                                <asp:Label ID="lblpage" CssClass="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                                of
                                <asp:Label ID="lblTotalPages" CssClass="lbltotalpage" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                                <span style="font-size: 11pt">Page</span>
                            </div>
                            <div style="margin-left: 0px; float: left; width: 500px;">
                                <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                                <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                                <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                                <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>

        <Triggers>
            <asp:PostBackTrigger ControlID="IBExcel" />
        </Triggers>
    </asp:UpdatePanel>
    <script type="text/javascript">
        $("#<%=ddlproduct.ClientID%> option[value*='---']").addClass('ddlIndxO');
    </script>
</asp:Content>
