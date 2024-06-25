<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="enquiry.aspx.cs" Inherits="BranchPanel_enquiry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- Script for calender--%>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../../js/jquery-ui-1.8.19.custom.min.js" type="text/css" />
    <%-- Script for calender--%>
    <%-- Script for Alert--%>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" media="all" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" media="all" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <%-- Script for Alert--%>

    <%-- Script for Time--%>
    <script src="../../js/timepicki.js" type="text/javascript"></script>
    <%-- Script for Time--%>
    <style type="text/css">
        .classcategory td {
            line-height: 20px !important;
            border-bottom: 2px solid #2CA8C2 !important;
        }

        #ctl00_ContentPlaceHolder1_PnlCust::-webkit-scrollbar-thumb {
            background-color: #B03C3F;
            border-radius: 10px;
        }

            #ctl00_ContentPlaceHolder1_PnlCust::-webkit-scrollbar-thumb:hover {
                background-color: #BF4649;
                border: 1px solid #333333;
            }

            #ctl00_ContentPlaceHolder1_PnlCust::-webkit-scrollbar-thumb:active {
                background-color: #A6393D;
                border: 1px solid #333333;
            }

        #chklistboxID {
            overflow: scroll;
        }

        .PnlDesign {
            width: 154px;
            height: auto;
            min-height: 200px;
            overflow: scroll;
            z-index: 1;
            overflow-x: hidden;
            border-radius: 10px;
            border: 3px solid #2CA8C2;
            left: 725px !important;
        }

        #chklistboxID tr {
            border-top: 1px solid #82403B !important;
            border-bottom: 1px solid #82403B !important;
        }

        .drop-down {
            background: none repeat scroll 0 0 #e1f8f8;
            border: 1px solid #ddd;
            max-height: 400px;
            overflow-x: hidden;
            overflow-y: scroll;
            position: absolute;
            width: 247px;
            z-index: 2147483647;
        }

        .lblforclass {
            padding-left: 40px !important;
        }

        #ctl00_ContentPlaceHolder1_txtboxID {
            color: #000 !important;
            text-align: center;
        }

        .ti_tx input {
            width: 30px !important;
            font-size: 20px !important;
            font-weight: bold;
            padding: 3px !important;
        }

        .mi_tx input {
            width: 30px !important;
            font-size: 20px !important;
            font-weight: bold;
            padding: 3px !important;
        }

        .mer_tx input {
            width: 30px !important;
            font-size: 20px !important;
            font-weight: bold;
            padding: 3px !important;
        }

        #ctl00_ContentPlaceHolder1_Grid_Calender th {
            background-color: green;
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

        .ti_tx, .mi_tx, .mer_tx {
            width: 100%;
            text-align: center;
            margin: 10px 0;
        }

        .timepickerintime, .timepickerouttime {
            padding-left: 5px !Important;
            padding-top: 2px !Important;
            padding-bottom: 2px !Important;
        }

        .ui-datepicker-calendar th span {
            color: black !important;
        }

        .time, .mins, .meridian {
            width: 60px;
            float: left;
            margin: 0px 10px;
            font-size: 20px;
            color: #2d2e2e;
            font-family: 'arial';
            font-weight: 700;
        }

        .prev, .next {
            cursor: pointer;
            padding: 18px;
            width: 28%;
            border: 1px solid #ccc;
            margin: auto;
            border-radius: 5px;
            background: url(../../images/arrow.png) no-repeat;
        }

            .prev:hover, .next:hover {
                background-color: #ccc;
            }

        .next {
            background-position: 50% 150%;
        }

        .prev {
            background-position: 50% -50%;
        }

        .time_pick {
            position: relative;
        }

        .timepicker_wrap {
            padding: 10px;
            border-radius: 5px;
            z-index: 2;
            display: none;
            width: 240px;
            box-shadow: 2px 2px 5px 0px rgba(50, 50, 50, 0.35);
            background: #f6f6f6;
            border: 1px solid #ccc;
            float: left;
            position: absolute;
            margin-top: -20px;
            left: 480px !important;
        }

        .arrow_top {
            position: absolute;
            top: -10px;
            left: 20px;
            width: 18px;
            height: 10px;
            z-index: 3;
            background: url(../../images/top_arr.png) no-repeat;
        }
        
    </style>
    <script type="text/javascript">

        var todayDate, date = "", year = "", month = "", time = "", hour = "", min = "", mainemail = "1", alternateemail = "2", cityname = "";

        $(document).ready(function () {
            BindClassByJquery();
            $('#ctl00_ContentPlaceHolder1_txtboxID').keyup(function () {
                cityname = $(this).val();
                $("#chklistboxID tr").remove();
                BindClassByJquery();
            });
            $('#chklistboxID').on('click', 'tr label', function () {
                $('.searchicon ').val($(this).text());
            });

            todayDate = new Date();
            var format = "AM";
            var hour = todayDate.getHours();
            var min = todayDate.getMinutes();
            if (hour > 11) {
                format = "PM";
            }
            if (hour > 12) {
                hour = hour - 12;
            }
            if (hour == 0) {
                hour = 12;
            }
            if (min < 10) {
                min = "0" + min;
            }
            if (parseInt(hour) < 10) {
                hour = '0' + hour;
            }

            time = hour + " : " + min + " : " + format
            $("#ctl00_ContentPlaceHolder1_txtstarttime").val(time);
            //Set Current Time Close

            $("#ctl00_ContentPlaceHolder1_txtstarttime").timepicki();
            //set Current Date
            date = todayDate.getDate();
            month = todayDate.getMonth();
            if (month <= 9) {
                month = month + parseInt(1);
                month = "0" + month;
            }
            if (date <= 9) {
                date = "0" + date;
            }
            year = todayDate.getFullYear();
            todayDate = month + "/" + date + "/" + year;
            $("#ctl00_ContentPlaceHolder1_txtToDate").val(todayDate);
            //set Current Date Close

            $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2012:2020',
                maxDate: new Date()
            });

            $("#ctl00_ContentPlaceHolder1_btnAdd").click(function () {
                var getvalidate = validateenquiry();
                if (getvalidate == false) {
                    return false;
                }

            });

            $("#ctl00_ContentPlaceHolder1_txtFEmailid").blur(function () {

                if (document.getElementById('<%= txtFEmailid.ClientID %>').value.trim() != "") {
                    mainemail = document.getElementById('<%= txtFEmailid.ClientID %>').value;
                    if (!mainemail.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        $("#ctl00_ContentPlaceHolder1_txtFEmailid").focus();
                        alertify.error("Invalid E-Mail address.");
                        $("#ctl00_ContentPlaceHolder1_txtFEmailid").val("");
                        return false;
                    }
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtemail2").blur(function () {

                if (document.getElementById('<%= txtemail2.ClientID %>').value.trim() != "") {
                    alternateemail = document.getElementById('<%= txtemail2.ClientID %>').value;
                    if (!alternateemail.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                        $("#ctl00_ContentPlaceHolder1_txtemail2").focus();
                        alertify.error("Invalid alternate E-Mail address.");
                        $("#ctl00_ContentPlaceHolder1_txtemail2").val("");
                        return false;
                    }
                    if (mainemail == alternateemail) {
                        $("#ctl00_ContentPlaceHolder1_txtemail2").val("");
                        alertify.error("Please enter diffrent email in alternate email");
                    }
                }
            });
            //Add Another Mobile number
            $("#addmore").click(function () {

                $("#mob2").show(500);
                $(this).hide(500);
            });
            //Remove Another Mobile number
            $("#removemob").click(function () {
                $("#mob2").hide(500);
                $("#addmore").show(500);
                $("#ctl00_ContentPlaceHolder1_txtmob2").val("");
            });

            //Add Another Email Address
            $("#addmoreemail").click(function () {
                $("#de2").show(500);
                $(this).hide();
            });
            $("#removeemail").click(function () {
                $("#addmoreemail").show(500);
                $("#de2").hide(500);
                $("#ctl00_ContentPlaceHolder1_txtemail2").val("");
            });

        });

        function BindClassByJquery() {
            $.ajax({
                type: "POST",
                url: "enquiry.aspx/BindCity",
                data: "{'cityname':'" + cityname + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        $("#chklistboxID").append("<tr class='classcategory'><td style='font:bold'><input class='inputhidden' type='hidden' value='" + value.CityId + "'><label class='lblforclass' for='lblfor" + value.CityName + "'>" + value.CityName + "</label></td></tr>")
                    });
                },
                failure: function (response) {
                },
            });
        }

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        }

        function validateenquiry() {

            if (document.getElementById('ctl00_ContentPlaceHolder1_ddlenquiry').value.trim() == "0") {
                $("#ctl00_ContentPlaceHolder1_ddlenquiry").focus();
                alertify.error('Please Select Enquiry Source');
                return false;
            }
            if (document.getElementById('ctl00_ContentPlaceHolder1_Ddlenquirytype').value <= "0") {
                $("#ctl00_ContentPlaceHolder1_Ddlenquirytype").focus();
                alertify.error('Please Select Class');
                return false;
            }
            if (document.getElementById('ctl00_ContentPlaceHolder1_txtname').value <= "0") {
                $("#ctl00_ContentPlaceHolder1_txtname").focus();
                alertify.error('Please Enter Name');
                return false;
            }
            if (document.getElementById('ctl00_ContentPlaceHolder1_txtFMobile').value == "") {
                $("#ctl00_ContentPlaceHolder1_txtFMobile").focus();
                alertify.error('Please Enter Contact Number');
                return false;
            }
            if (document.getElementById('ctl00_ContentPlaceHolder1_txtFMobile').value != "") {
                var totalnumber = $("#ctl00_ContentPlaceHolder1_txtFMobile").val();
                totalnumber = totalnumber.length;
                if (parseInt(totalnumber) < 10) {
                    alertify.error('Invalid Mobile Number');
                    return false;
                }

            }
            if (document.getElementById('ctl00_ContentPlaceHolder1_txtmob2').value != "") {
                var atotalnumber = $("#ctl00_ContentPlaceHolder1_txtmob2").val();
                atotalnumber = atotalnumber.length;
                if (parseInt(atotalnumber) < 10) {
                    alertify.error('Invalid alternate Mobile Number');
                    return false;
                }

            }
            if (document.getElementById('<%= txtFEmailid.ClientID %>').value.trim() != "") {
                mainemail = document.getElementById('<%= txtFEmailid.ClientID %>').value;
                if (!mainemail.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                    $("#ctl00_ContentPlaceHolder1_txtEmailid").focus();
                    alertify.error("Invalid E-Mail address.");
                    return false;
                }
            }
            if (document.getElementById('<%= txtemail2.ClientID %>').value.trim() != "") {
                alternateemail = document.getElementById('<%= txtemail2.ClientID %>').value;
                if (!alternateemail.match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                    $("#ctl00_ContentPlaceHolder1_txtemail2").focus();
                    alertify.error("Invalid alternate E-Mail address.");
                    return false;
                }
            }
            if (mainemail == alternateemail) {
                $("#ctl00_ContentPlaceHolder1_txtemail2").val("");
                alertify.error("Please enter diffrent email in alternate email");
            }
        }
    </script>
    <div class="clear"></div>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;"
                title="Click here to go home Page">Home</a></li>
            <li><a href="viewenquiry.aspx">Enquiry</a></li>
            <li style="background: none;"><a class="active" href="enquiry.aspx">Add Enquiry</a></li>
        </ul>
        <div class="arrowt">
            <a href="viewenquiry.aspx">
                <img src="../../images/back-button.png" src="viewenquiry.aspx" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; left: 0px;"
            class="containerHeadline">
            Add Enquiry
        </div>
        <div class="for_sigle_row_form">
            <label>Enquiry Date & Time<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtToDate" runat="server" autoComplete="off" ReadOnly="true" Width="175px"></asp:TextBox>
            <asp:TextBox runat="server" ID="txtstarttime" ReadOnly="true" autoComplete="off" Style="float: right; width: 100px; margin-top: -36px; margin-right: 518px;"></asp:TextBox>
            <hr />
        </div>
        <div class="for_sigle_row_form">
            <label>Enquiry Source<span style="color: Red">*</span></label>
            <asp:DropDownList runat="server" ID="ddlenquiry"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>Class<span style="color: Red">*</span></label>
            <asp:DropDownList runat="server" ID="Ddlenquirytype" class="span2"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>Name<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtname" runat="server" autoComplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>Mobile No.<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtFMobile" runat="server" MaxLength="12" onkeypress="return noAlphabets(event)" Placeholder="ie: 7827739166"></asp:TextBox>
            <img alt="image" id="addmore" src="../../images/addmore.png" />
        </div>
        <div class="for_sigle_row_form" id="mob2" style="display: none">
            <label></label>
            <asp:TextBox ID="txtmob2" runat="server" MaxLength="12" onkeypress="return noAlphabets(event)" Placeholder="ie: 7827739166"></asp:TextBox>
            <img alt="image" id="removemob" src="../../images/remove.png" />
        </div>
        <div class="for_sigle_row_form">
            <label>Email ID</label>
            <asp:TextBox ID="txtFEmailid" Placeholder="ie: jhon@hotmail.com" runat="server" autoComplete="off"></asp:TextBox>
            <img alt="image" id="addmoreemail" src="../../images/addmore.png" />
        </div>
        <div class="for_sigle_row_form" id="de2" style="display: none">
            <label></label>
            <asp:TextBox ID="txtemail2" runat="server" Placeholder="ie: jhon@hotmail.com" autoComplete="off"></asp:TextBox>
            <img alt="image" id="removeemail" src="../../images/remove.png" />
        </div>
        <div class="for_sigle_row_form" id="de3" style="display: none">
            <label></label>
            <asp:TextBox ID="txtemail3" runat="server" autoComplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form" style="display: none">
            <label>LandLine No.</label>
            <asp:TextBox ID="txtlandno" runat="server" MaxLength="12" onkeypress="return noAlphabets(event)" autoComplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>City.</label>
            <div class="form-row clearfix">
                <div style="float: left; padding-bottom: 13px;">
                    <asp:TextBox ID="txtboxID" class="opendivcheckboxlist" runat="server" onkeyup="KeyUp(this,'#chklistboxID')" TabIndex="2"
                        CssClass="searchicon forminput" placeholder="Search/Enter City"> </asp:TextBox>
                    <cc1:PopupControlExtender ID="PceSelectCustomer" runat="server" PopupControlID="PnlCust" Position="Bottom" TargetControlID="txtboxID">
                    </cc1:PopupControlExtender>
                </div>
                <div id="checkboxlist" class="checkboxlist" runat="server">
                    <asp:Panel ID="PnlCust" runat="server" CssClass="PnlDesign" Style="display: none">
                        <table id="chklistboxID" class="drop-down">
                        </table>
                        <asp:HiddenField ID="hfcity" runat="server" Value='<%#Eval("catId") %>' />
                    </asp:Panel>
                </div>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>Message</label>
            <asp:TextBox ID="TextBox1" runat="server" autoComplete="off" TextMode="MultiLine"></asp:TextBox>&nbsp;
        </div>
        <div class="for_sigle_row_form" style="display: none">
            <label>Enquiry Status<span style="color: Red">*</span></label>
            <asp:DropDownList runat="server" ID="ddlStatus"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label></label>
            <asp:Button ID="btnAdd" runat="server" CssClass="button_save" Text="Submit" OnClick="btSave_Click" />
        </div>
    </div>
</asp:Content>
