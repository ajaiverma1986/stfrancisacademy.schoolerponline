<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="employee-list.aspx.cs" Inherits="BranchPanel_employee_list" %>

<%@ Register Src="~/branchpanel/employee/employee-managemen.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style>
        .conductedlecture235 {
            background: none repeat scroll 0 0 #eeefff;
            border: 1px solid #b4b8ff;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        .conductedlecture236 {
            background: none repeat scroll 0 0 #d4feff;
            border: 1px solid #41e1e6;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter td {
            border-color: #c3c0c0!important;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter a {
            color: black !important;
        }

        .texthover {
            border: solid 1px red !important;
        }

        .activeofferlist {
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

        .user-deatils1 span {
            float: left;
            font-size: 12px;
        }

        .user-deatils1 dt {
            font-size: 12px !important;
        }

        .del-activestatusupdate {
            margin-left: 419px !important;
            margin-top: -60px !important;
        }

            .del-activestatusupdate input {
                margin-right: 5px !important;
                margin-left: 5px !important;
            }

            .del-activestatusupdate label {
                color: #3399FF !important;
                font-size: 15px !important;
            }

        .student-photo_frame1 {
            height: 165px !important;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
            padding-left: 5px;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 40px!important;
            border: 1px solid #CCCCCC;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px!important;
            border: 1px solid #CCCCCC;
            padding-left: 5px;
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

        .showpopup {
            opacity: 1;
            position: fixed;
            /*left: 4%;
            top: 3%;*/
            background: none repeat scroll 0 0 #fff;
            border: 15px solid #8CBF26;
            border-radius: 17px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: 600px;
            width: 1200px;
            z-index: 99999999999;
            overflow: scroll;
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
            width: 38%;
            z-index: 2147483647;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 2px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 1px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }
    </style>
    <script type="text/javascript">
        var a = jQuery.noConflict();

        var refNo = "", name = "", mobile = "", designationid = "", deptid = "0", emaild = "", eid = "", pageno = 1, pagecount = 1, pagesize = 15, difirstid, divsecondid, viewtype = 0, subject = "", msg = "", youstatus = "", txtqualification = "";
        var ctr = 1;

        function pageLoad() {
            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);
            ForMarkRed();

            document.title = 'Employee List';
        }
        function ForMarkRed() {

            $('.eid').parent('div').parent('div').parent('div').css("background-color", "#EDEDED");
            $('.eid').parent('div').parent('div').parent('div').find('span').css("color", "#5B5B5B");
            $('.eid').parent('div').parent('div').parent('div').find('a').css("color", "#2D9FDD");
            $('.eid').parent('div').parent('div').parent('div').find('dt').css("color", "#434343");

            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "employee-list.aspx/GEtRedMarkEmployeeList",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('.eid').each(function () {
                                var tempeid = 0;
                                tempeid = $(this).html();
                                if (parseInt(tempeid) == parseInt(data.d[i].eid)) {
                                    $(this).parent('div').parent('div').parent('div').css("background-color", "#9D0000");
                                    $(this).parent('div').parent('div').parent('div').find('span').css("color", "white");
                                    $(this).parent('div').parent('div').parent('div').find('a').css("color", "white");
                                    $(this).parent('div').parent('div').parent('div').find('dt').css("color", "white");
                                }
                            });
                        }
                    }
                },
                error: function (response) {
                }
            });
        }
        //======= this code is for binding drop down at runtime end here ==========

        function add_Row() {
            ctr++;
            txtqualification = "txtqualification" + ctr;
            var txtboard = "txtboard" + ctr;
            var txtyear = "txtyear" + ctr;
            var session = "txtsession" + ctr;
            var txtrollnumber = "txtrollnumber" + ctr;
            var txtpercent = "txtpercent" + ctr;
            var remove = "removebtn" + ctr;

            var instituladdress = "txtinstituteaddress" + ctr;

            var newTr = '<tr style="height:25px"><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtqualification +
                '></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtboard
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtyear
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important"  id=' + session
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtrollnumber
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtpercent
                + ' ></span></td><td style="border:1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + instituladdress
                + ' ></span></td></tr>';
            $('#ctl00_ContentPlaceHolder1_tbl').append(newTr);

        }

        a(document).ready(function () {
            //code is  for counting characters in sms text box
            var totalChars = 160; //Total characters allowed in textarea
            var countTextBox = $('#ctl00_ContentPlaceHolder1_txtmsgformobile') // Textarea input box
            var charsCountEl = $('#ctl00_ContentPlaceHolder1_lblremain'); // Remaining chars count will be displayed here
            charsCountEl.text("Total characters : " + totalChars); //initial value of countchars element
            countTextBox.on("keyup keypress paste", function () { //user releases a key on the keyboard
                var thisChars = this.value.replace(/{.*}/g, '').length; //get chars count in textarea
                var per = thisChars * 100;
                var value = (per / totalChars); // total percent complete
                if (thisChars > totalChars) //if we have more chars than it should be
                {
                    var CharsToDel = (thisChars - totalChars); // total extra chars to delete
                    this.value = this.value.substring(0, this.value.length - CharsToDel); //remove excess chars from textarea
                }
                else if (thisChars == 0) {
                    charsCountEl.text("Total characters : " + totalChars);
                }
                else {
                    var finchar = totalChars - thisChars;
                    charsCountEl.text("Remaining characters : " + finchar); //count remaining chars
                }
            });

            //code is  for counting characters in sms text box end here
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
            a("#ctl00_ContentPlaceHolder1_txtmsgformobile").focus(function () {
                a("#ctl00_ContentPlaceHolder1_txtmsgformobile").removeClass("texthover");
            });
            a("#ctl00_ContentPlaceHolder1_txtsubject").focus(function () {
                a("#ctl00_ContentPlaceHolder1_txtsubject").removeClass("texthover");
            });
            a("#ctl00_ContentPlaceHolder1_txtmesg").focus(function () {
                a("#ctl00_ContentPlaceHolder1_txtmesg").removeClass("texthover");
            });
            a(document).on("click", "[id*=gvDetails] [id*=lbtnlogin]", function () {

                eid = $(this).parent('div').find('.eid').text();
                window.open("../../teacher-login.aspx?eid=" + eid + "", "_blank");
                return false;
            });
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lblRefno]", function () {
                var id;
                id = $(this).parent('div').find('.id').text();
                window.location.href = "AppointmentLetter.aspx?eid=" + id;
                return false;
            });
            a(document).on("click", "[id*=gvDetails] [id*=lnkformoredetails]", function () {
                eid = $(this).parent('div').find('.eid').text();
                if (eid != "0") {
                    $("#divMessage").show(500);
                    $("#tab1").fadeIn();
                    getappointemplist(eid);
                }
                return false;
            });
            //===================this code is showing pop up start here==============
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lnkforemailid]", function () {

                emaild = $(this).parent('div').find('.email').text();
                refNo = $(this).parent('div').find('.refNo').text();
                eid = $(this).parent('div').find('.id').text();
                $("#divforemail").show(500);
                $("#ctl00_ContentPlaceHolder1_lblforemailid").text(emaild);

                return false;
            });
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lnkbtnformobile]", function () {

                mobile = $(this).parent('div').find('.mobile').text();
                refNo = $(this).parent('div').find('.refNo').text();
                eid = $(this).parent('div').find('.id').text();

                $("#divformobile").show(500);
                $("#ctl00_ContentPlaceHolder1_lblformobile").text(mobile);
                return false;
            });
            a(document).on("click", "[id*=gvDetails] [id*=lbllinkformobilegvdetails]", function () {

                mobile = $(this).parent('div').find('.mobile').text();
                refNo = $(this).parent('div').find('.refNno').text();
                eid = $(this).parent('div').find('.eid').text();

                $("#divformobile").show(500);
                $("#ctl00_ContentPlaceHolder1_lblformobile").text(mobile);
                return false;
            });
            $("#btclose1").click(function () {
                $("#divformobile").hide(600);
                $('#ctl00_ContentPlaceHolder1_txtmsgformobile').val('');
                $('#ctl00_ContentPlaceHolder1_lblremain').text("Total characters : " + 160);
            });

            $("#btclose").click(function () {
                $("#divforemail").hide(600);

            });
            a("#ctl00_ContentPlaceHolder1_btnsend").click(function () {
                subject = $("#ctl00_ContentPlaceHolder1_txtsubject").val();
                msg = $("#ctl00_ContentPlaceHolder1_txtmesg").val();
                SendingEmail();
                return false;
            });
            a("#ctl00_ContentPlaceHolder1_btnsendformobile").click(function () {
                msg = $("#ctl00_ContentPlaceHolder1_txtmsgformobile").val();
                sendsms();
                return false;
            });
            //==================pop up code ends here==================================
            //==============this code is for Grid View starts here ======================
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=imgEdit]", function () {
                var id;
                id = $(this).parent('div').find('.id').text();
                window.location.href = "emp-profile.aspx?id=" + id;
                return false;
            });
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lbllnkformore]", function () {

                eid = $(this).parent('div').find('.id').text();

                if (eid != "0") {
                    $("#divMessage").show(500);
                    $("#tab1").fadeIn();
                    getappointemplist(eid);
                }
                return false;
            });
            $("#tdClosepopup").click(function () {
                $("#divMessage").hide(600);

                var length = $('#ctl00_ContentPlaceHolder1_tbl tr:gt(0)').length;

                for (var i = length ; i > 1; i--) {
                    $('#ctl00_ContentPlaceHolder1_tbl tr:eq(' + i + ')').remove();

                }

            });
            //============= this code is for image view starts here=======================
            a(document).on("click", "[id*=gvDetails] [id*=lbtn3]", function () {
                var id;
                id = $(this).parent('div').find('.eid').text();

                if (id != "0") {
                    window.location.href = "employment-details.aspx?id=" + id;
                }
                return false;
            });
            a('#ctl00_ContentPlaceHolder1_txtreferenceno').on('change', function () {
                fill_all_field();

                GetOfferedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_txtName').on('keyup', function () {
                fill_all_field();
                GetOfferedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_txtcontactno').on('change', function () {
                fill_all_field();
                GetOfferedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_ddldept').on('change', function () {
                fill_all_field();
                designationid = "";
                if (deptid == "") {
                    deptid = "0";
                }
                GetOfferedEmpList();
                filldisig();
            });

            a('#ctl00_ContentPlaceHolder1_ddldesignation').on('change', function () {
                fill_all_field();
                if (designationid == "") {
                    designationid = "0";
                }
                GetOfferedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_ddlgridviewimageview').on('change', function () {
                eid = "";

                viewtype = a(this).val();
                GetOfferedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_ddlsearchbystatus').on('change', function () {
                youstatus = a(this).val();
                GetOfferedEmpList();
            });

            function fill_all_field() {
                pageno = 1;
                refNo = a('#ctl00_ContentPlaceHolder1_txtreferenceno').val().trim();
                name = a('#ctl00_ContentPlaceHolder1_txtName').val().trim();
                mobile = a('#ctl00_ContentPlaceHolder1_txtcontactno').val().trim();
                deptid = a('#ctl00_ContentPlaceHolder1_ddldept').val().trim();
                designationid = a('#ctl00_ContentPlaceHolder1_ddldesignation').val().trim();
            }

            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
            $(".btnfirst").click(function () {

                pageno = 1;
                $(".lblpage").html(pageno);
                GetOfferedEmpList();
            });
            $(".btnprev").click(function () {

                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    GetOfferedEmpList();
                }
            });
            $(".btnnext").click(function () {

                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $(".lblpage").html(pageno);
                    GetOfferedEmpList();
                }
            });

            $(".btnlast").click(function () {
                pageno = pagecount;
                $(".lblpage").html(pageno);
                GetOfferedEmpList();
            });

        });

        function SendingEmail() {

            if (document.getElementById('<%=txtsubject.ClientID %>').value == 0) {
                document.getElementById('<%= txtsubject.ClientID %>').className = "texthover";
                return false;
            }

            if (document.getElementById('<%=txtmesg.ClientID %>').value == 0) {
                document.getElementById('<%= txtmesg.ClientID %>').className = "texthover";
                return false;
            }
            alertify.confirm("Are you sure you want to send this E-mail?", function (e) {
                if (e) {

                    $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', true);
                    $('#ctl00_ContentPlaceHolder1_btnsend').val('Wait..');

                    call_progressbar("start");

                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "shortlisted-candidates-list.aspx/SendMail",
                        data: "{'emailid':'" + emaild + "','subject':'" + subject + "','msg':'" + msg + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (parseInt(data.d) == 0) {
                                insert_sms_history(parseInt(eid), refNo, mobile, emaild, msg, subject, "Appoint", 2, 0);

                                alertify.success("Mail has been sent successfully.");
                                $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsend').val('Send');
                                $('#ctl00_ContentPlaceHolder1_txtsubject').val('');
                                $('#ctl00_ContentPlaceHolder1_txtmesg').val('');
                                $("#divforemail").hide(600);

                            }
                            else {
                                $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsend').val('Send');

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
                }
            });
            return false;
        }

        function sendsms() {

            if (document.getElementById('<%=txtmsgformobile.ClientID %>').value == 0) {
                document.getElementById('<%= txtmsgformobile.ClientID %>').className = "texthover";
                return false;
            }
            alertify.confirm("Are you sure you want to send this message?", function (e) {
                if (e) {
                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', true);
                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Wait..');
                    call_progressbar("start");
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "offered-employer-list.aspx/sendsmsonmobile",
                        data: "{'mobile':'" + mobile + "','msg':'" + msg + "'}",
                        dataType: "json",
                        success: function (data) {

                            $('#ctl00_ContentPlaceHolder1_txtmsgformobile').val('');

                            if (parseInt(data.d) == 1) {
                                insert_sms_history(parseInt(eid), refNo, mobile, emaild, msg, subject, "Appoint", 1, 0);

                                $("#divformobile").hide(600);
                                $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');
                                alertify.success("Message has been sent successfully");

                            }
                            else {
                                alertify.error("Mobile number is not valid.");
                                $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                                $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');

                            }
                            mobile = "";
                            $('#ctl00_ContentPlaceHolder1_lblremain').text("Total characters : " + 160);
                            call_progressbar("end");
                            return false;

                        },
                        error: function (response) {
                            call_progressbar("end");
                            return false;

                        }
                    });
                }
            });
            return false;
        }

        function insert_sms_history(eid, Refno, MobileNo, email_id, msg, subject, MessageModule, mode, shortlist_id) {

            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../Comman.aspx/Maintain_Sms_Email_Log",
                data: "{'eid':'" + eid + "','Refno':'" + Refno + "','MobileNo':'" + MobileNo + "','email_id':'" + email_id + "','msg':'" + msg + "','subject':'" + subject + "','MessageModule':'" + MessageModule + "','mode':'" + mode + "','shortlist_id':'" + shortlist_id + "'}",
                dataType: "json",
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        alertify.success("This SMS history has been maintained");
                    }
                    if (parseInt(data.d) == 2) {
                        alertify.success("This mail history has been maintained");
                    }

                    eid = "";
                    refNo = "";
                    mobile = "";
                    emaild = "";
                    subject = "";
                    msg = "";
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
                     data: "{'did':'" + deptid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddldesignation").html("");
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddldesignation").append($("<option></option>").val(value.desigid).html(value.designame));
                         });
                         call_progressbar("end");
                     },
                     error: function (result) {
                         call_progressbar("end");
                         return false;
                     }
                 });
        }

        function GetOfferedEmpList() {

            youstatus = $('#ctl00_ContentPlaceHolder1_ddlsearchbystatus').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                url: "employee-list.aspx/GetAppointedEmpList",
                data: "{'refNo':'" + refNo + "','name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','emaild':'" + emaild + "','eid':'" + eid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','status':'" + youstatus + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    viewtype = document.getElementById('<%= ddlgridviewimageview.ClientID %>').selectedIndex;
                    if (viewtype == 0) {
                        $("#ctl00_ContentPlaceHolder1_trforimage").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_trforimagepagging").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_trforgridview").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_trforgridviewpaggingpagging").css("display", "none");

                        var srno = 1;
                        $("[id*=gvDetails] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            $(".student-photo_frame1").css("display", "block");
                            $(".student-photo_frame1").css("width", "1053px");
                            $("#ctl00_ContentPlaceHolder1_lblmessage").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_trforimage").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_trforimagepagging").css("display", "block");

                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=gvDetails] tr:eq(1)").clone(true);

                                $("[id$=gvDetails]").append(row);
                                $(row).find(".forcheckclick").attr("src", "../../employeeimage/" + data.d[i].photo);
                                $(row).find(".eid").html(data.d[i].eid);
                                $(row).find(".refno").html(data.d[i].refNo);
                                $(row).find(".mobile").html(data.d[i].mobile);
                                $(row).find(".title").html(data.d[i].designation);
                                $(row).find(".swet").html(data.d[i].comname);
                                $(row).find(".status").html(data.d[i].status);
                                $(row).find(".department").html(data.d[i].department);

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
                            ForMarkRed();
                        }
                        else {
                            $("#ctl00_ContentPlaceHolder1_trforimagepagging").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_trforimage").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_lblmessage").css("display", "block");
                        }
                        $("[id*=gvDetails] tr").show();
                        $("[id*=gvDetails] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                    else {

                        $("#ctl00_ContentPlaceHolder1_trforimage").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_trforimagepagging").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_trforgridview").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_trforgridviewpaggingpagging").css("display", "block");

                        $("#tdforgrid").css("width", "100%");
                        var srno = 1;
                        $("[id*=grdAppoinmentLetter] tr:gt(1)").remove();

                        if (data.d.length > 0) {
                            $("#ctl00_ContentPlaceHolder1_trforgridview").css("display", "block");
                            $("#ctl00_ContentPlaceHolder1_lblmessage").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_trforgridviewpaggingpagging").css("display", "block");

                            for (var i = 0; i < data.d.length; i++) {
                                var row = $("[id*=grdAppoinmentLetter] tr:eq(1)").clone(true);
                                $("[id$=grdAppoinmentLetter]").append(row);

                                $(row).find(".Row_num").html(data.d[i].RowNumber);
                                $(row).find(".refNo").html(data.d[i].refNo);
                                $(row).find(".Name").html(data.d[i].comname);
                                $(row).find(".department").html(data.d[i].department);
                                $(row).find(".designation").html(data.d[i].designation);
                                $(row).find(".mobile").html(data.d[i].mobile);

                                $(row).find(".email").html(data.d[i].emailID);

                                $(row).find(".id").html(data.d[i].eid);

                                pagecount = data.d[i].pagecount;

                                if (pagecount == 1) {
                                    $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                    $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                                }
                                else {
                                    $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                    $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                                }
                            }

                        }
                        else {

                            $("#ctl00_ContentPlaceHolder1_trforgridviewpaggingpagging").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_trforgridview").css("display", "none");
                            $("#ctl00_ContentPlaceHolder1_lblmessage").css("display", "block");
                        }

                        $("[id*=grdAppoinmentLetter] tr").show();
                        $("[id*=grdAppoinmentLetter] tr:eq(1)").hide();
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
            }
            function getappointemplist(id) {
                youstatus = $('#ctl00_ContentPlaceHolder1_ddlsearchbystatus').val();
                call_progressbar("start");
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "employee-list.aspx/GetAppointedEmpList",
                    data: "{'refNo':'" + refNo + "','name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','emaild':'" + emaild + "','eid':'" + eid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','status':'" + youstatus + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d.length > 0) {
                            OnSuccessReturn(data);
                            eid = "";

                        }
                        call_progressbar("end");
                    },
                    error: function (response) {
                        call_progressbar("end");
                        return false;

                    }

                });

            }

            function OnSuccessReturn(data) {

                $.each(data.d, function (key, value) {

                    $("#img1").attr("src", "../../employeeimage/" + value.photo);
                    $("#lblRefno1").text(value.refNo);

                    $("#lblusername").text(value.username);
                    $("#lblPassword").text(value.password);

                    $("#lblName").text(value.comname);
                    $("#lblphone").text(value.mobile);
                    $("#lblEmail").text(value.emailID);

                    $("#lblDOB").text(value.dob);
                    $("#lblCountry").text(value.countryName);
                    $("#lblState").text(value.stateName);
                    $("#lblCity").text(value.cityName);
                    $("#lblAddress").text(value.address);
                    $("#lblPinCode").text(value.pinCode);
                    $("#lblGender").text(value.gender);
                    //=====Checked Document Submited=====
                    var item = value.isDocumentSubmit;
                    var arr = item.split(",");
                    $('input[type=checkbox]').prop("checked", false);
                    for (var j = 0; j < arr.length; j++) {
                        $('input[type=checkbox]').each(function () {
                            $(this).prop("disabled", false);
                            if (parseInt(arr[j]) == parseInt($(this).val())) {
                                $(this).prop("checked", true);
                            }
                            $(this).prop("disabled", true);
                        });
                    }

                    //=====Current Address Details=====
                    $("#address").text(value.Taddress);
                    $("#country").text(value.per_countryName);
                    $("#state").text(value.per_stateName);
                    $("#city").text(value.per_cityName);
                    $("#pincode").text(value.TpinCode);

                    $("#current_address_landmark").text(value.current_address_landmark);
                    $("#permanent_address_landmark").text(value.permanent_address_landmark);

                    //=====gardians details===========
                    $("#father").text(value.father);
                    $("#mother").text(value.mother);
                    $("#fathermobileno").text(value.fathercontactno);
                    $("#mothermobileno").text(value.mothercontactno);
                    $("#parentsaddress").text(value.parentsaddress);
                    $("#father_alternate_no").text(value.father_alternate_no);

                    $("#lblBirthPlace").text(value.birthplace);
                    $("#lblNationality").text(value.nationality);

                    if (value.qualificaton != "" && value.qualificaton != "0") {

                        $("#ctl00_ContentPlaceHolder1_tbl").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "none");

                        var Qualifction = value.qualificaton.split("~");
                        var brd = value.education_board.split("~");
                        var yr = value.passing_year.split("~");
                        var sesion = value.session.split("~");
                        var rllnum = value.rollnumber.split("~");
                        var perecnt = value.percentage.split("~");
                        var add = value.institute_address.split("~");

                        var noofrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length - 1;

                        if (noofrows < Qualifction.length - 1) {
                            for (var a = 0; a < Qualifction.length - 2; a++) {
                                add_Row();
                            }
                        }
                        var totalrows = document.getElementById('ctl00_ContentPlaceHolder1_tbl').rows.length;
                        if (totalrows > 1) {
                            var j = 0;

                            for (var i = 1; i < totalrows; i++) {

                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[0].getElementsByTagName("span")[0].textContent = Qualifction[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[1].getElementsByTagName("span")[0].textContent = brd[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[2].getElementsByTagName("span")[0].textContent = yr[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[3].getElementsByTagName("span")[0].textContent = sesion[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[4].getElementsByTagName("span")[0].textContent = rllnum[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[5].getElementsByTagName("span")[0].textContent = perecnt[j];
                                document.getElementById("ctl00_ContentPlaceHolder1_tbl").rows[i].cells[6].getElementsByTagName("span")[0].textContent = add[j];
                                j++;
                            }

                        }
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_tbl").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_lblmsg").css("display", "block");
                    }

                    $("#lblMStatus").text(value.mstatus);
                    $("#lblNoOfChildren").text(value.noOfChilds);
                    $("#lblPANCardNo").text(value.panNo);

                    $("#idname").text(value.id_proof_id);
                    $("#idnumber").text(value.id_proof_number);

                    $("#ResidentialProofname").text(value.residential_id);
                    $("#ResidentialProofnumber").text(value.residential_proof_number);
                    $("#lblMessanger").text(value.messanger);

                    //degisnation details
                    $("#annualctc").text(value.CTC);
                    $("#CTCappliedfrom").text(value.CTCappliedfrom);
                    $("#inhandsalary").text(value.salary);
                    $("#pfno").text(value.pfno);
                    $("#esino").text(value.esino);
                    $("#tds_account_number").text(value.tds_account_number);

                    $("#typeofemployement").text(value.emplyeetype);
                    $("#branch").text(value.Brname);
                    $("#lblHrname").text(value.hrName);

                    $("#lblOffemailid").text(value.emailAlloted);
                    $("#lblProbation").text(value.probationPeriond);
                    $("#lblDesig").text(value.designation);
                    $("#lblDept").text(value.department);
                    $("#lblDate").text(value.date);
                    $("#lblDOJ").text(value.doj);

                    $("#lblComment").text(value.comments);
                    //previous job details
                    $("#lblOrg").text(value.preOrganisation);
                    $("#lblPadd").text(value.pAddress);
                    $("#lblPcountry").text(value.pcountry);
                    $("#lblPstate").text(value.pstate);
                    $("#lblPCity").text(value.pcity);
                    $("#lblPPindcode").text(value.pPincode);
                    $("#lblPDesignation").text(value.pDesignation);
                    $("#lblSalary").text(value.pSalary);
                    $("#lblDuration").text(value.pDuration);

                    var exp = value.totalExperience;
                    var fiexp = exp.split(",");
                    $("#lblYears").text(fiexp[0]);
                    $("#lblMonths").text(fiexp[1]);

                    $("#lblFirstRefrenceName").text(value.ref1Name);
                    $("#lblfrefContactNo").text(value.ref1Contact);
                    $("#lblSecondRefrenceName").text(value.ref2Name);
                    $("#lblContactNo").text(value.ref2Contact);
                    //medical details
                    $("#lblBloodGroup").text(value.bloodGroup);
                    $("#lblMedicalCondition").text(value.medicalCondition);
                    $("#lblPastDiseases").text(value.pastDeseas);
                    $("#lblGeneticDisease").text(value.geneticDeseas);
                    $("#lblAnyAllergy").text(value.anyAlergy);
                    //bank details
                    $("#lblBankName").text(value.bankName);
                    $("#lblAccountNo").text(value.accountNo);
                    $("#lblBranchName").text(value.branchName);
                    $("#lblBranchCode").text(value.branchCode);
                    $("#lblIFSCCode").text(value.IFSC);

                    $("#biometricno").text(value.AddBiometric_Card_No);

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
            }
    </script>
    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="employee-list.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a class="active">Employee List</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <asp:HiddenField ID="hfpages" runat="server" />

        <div id="boxid" runat="server" style="margin-left: 150px !important; margin-bottom: 10px !important;">
            <table id="tbllde">
                <tr>

                    <td valign="top" align="left">
                        <div class="conductedlecture235 secbox" style="margin-left: 10px;">
                            <asp:Label runat="server" ID="lbl1" Text="Total: " Font-Bold="true" ForeColor="#B136A4"></asp:Label>
                            <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#B136A4" Font-Bold="true"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture236 thirdbox" style="margin-left: 10px;">
                            <asp:Label runat="server" ID="Label6" Text="Working: " Font-Bold="true" ForeColor="#824a9e"></asp:Label>
                            <asp:Label ID="lblworking" runat="server" Text="0" ForeColor="#824a9e" Font-Bold="true"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture236 fourthbox" style="margin-left: 11px; border: 1px solid #15E6B5;">
                            <asp:Label runat="server" ID="Label4" Text="Suspended: " Font-Bold="true" ForeColor="#14879e"></asp:Label>
                            <asp:Label ID="lblsupended" runat="server" Text="0" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture236 fourthbox" style="margin-left: 11px; border: 1px solid #15E6B5;">
                            <asp:Label runat="server" ID="Label14" Text="On Leave: " Font-Bold="true" ForeColor="#14879e"></asp:Label>
                            <asp:Label ID="lblonleave" runat="server" Text="0" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                        </div>
                    </td>
                    <td valign="top" align="left">
                        <div class="conductedlecture236 fourthbox" style="margin-left: 11px; border: 1px solid #15E6B5;">
                            <asp:Label runat="server" ID="Label17" Text="Notice period: " Font-Bold="true" ForeColor="#14879e"></asp:Label>
                            <asp:Label ID="lblnoticeperiod" runat="server" Text="0" Font-Bold="true" ForeColor="#14879e"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" class="containerHeadline" style="width: 100%">

                    <div style="float: right; width: 100%;">

                        <asp:DropDownList ID="ddlgridviewimageview" runat="server" Width="100px" Style="float: right" Font-Size="12px">
                            <asp:ListItem Value="1" Text="Image View"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Grid View"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddldesignation" runat="server" Style="float: right" Font-Size="12px" Width="160px"></asp:DropDownList>
                        <asp:DropDownList ID="ddldept" runat="server" Style="float: right" Font-Size="12px" Width="160px"></asp:DropDownList>
                        <asp:TextBox ID="txtcontactno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Contact No"> </asp:TextBox>
                        <asp:TextBox ID="txtreferenceno" runat="server" Width="120px" Font-Size="12px" Style="float: right" placeholder="Reference No" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtName" runat="server" Width="120px" Font-Size="12px" placeholder="Name" Style="float: right" Height="23px"> </asp:TextBox>
                        <asp:DropDownList ID="ddlsearchbystatus" runat="server" Width="115px" Style="float: right" Font-Size="12px">
                            <asp:ListItem Value="1" Text="Working"></asp:ListItem>
                            <asp:ListItem Value="2" Text="Suspend"></asp:ListItem>
                            <asp:ListItem Value="5" Text="On Leave"></asp:ListItem>
                            <asp:ListItem Value="11" Text="Notice period"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </td>
            </tr>
            <tr id="trforimage" runat="server">
                <td align="left" colspan="11" style="width: 100%; padding: 0px 10px 10px 10px;">
                    <asp:GridView ID="gvDetails" AutoGenerateColumns="false" ShowHeader="true"
                        GridLines="None" CellPadding="5" runat="server" Width="100%" HeaderStyle-Height="0px">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="student-photo_frame1">
                                        <div class="student-photo_frame_img">
                                            <asp:Image runat="server" ID="imgsource" ImageUrl='<%#Eval ("photo","../../employeeimage/{0}") %>' CssClass="forcheckclick" AlternateText="Sorry No Image" />
                                        </div>
                                        <div style="float: left;">
                                            <div class="user-deatils1">
                                                <asp:LinkButton ID="lbtn3" runat="server" Text='<%# Bind("name") %>' CssClass="swet"
                                                    ToolTip="Click here to Update the Employee profile.">  </asp:LinkButton>
                                                <asp:Label ID="lbleid2" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                            </div>
                                            <div class="clear"></div>
                                            <div class="user-deatils1">
                                                <dt>Emp Code. :</dt>
                                                <asp:Label ID="lblrefno" runat="server" Text='<%#  Eval("refno")  %>' CssClass="refno"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="user-deatils1">
                                                <dt>Mobile No :</dt>
                                                <div>
                                                    <asp:LinkButton ID="lbllinkformobilegvdetails" runat="server" Text='<%#  Eval("mobile")  %>' CssClass="mobile" Style="font-size: 14px; color: #2d9fdd; float: left;" ToolTip="click here for send sms."></asp:LinkButton>
                                                    <asp:Label ID="Label1lbleidforsmshistory1" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                                    <asp:Label ID="lblrefnoforsmshtry1" runat="server" Text='<%#  Eval("refno")  %>' Style="display: none" CssClass="refno"></asp:Label>
                                                </div>
                                                </span>
                                            </div>

                                            <div class="user-deatils1">
                                                <dt>Department :</dt>
                                                <asp:Label ID="Label3" runat="server" Text='<%#  Eval("department")  %>' CssClass="department"></asp:Label>
                                                </span>
                                            </div>

                                            <div class="user-deatils1">
                                                <dt>Designation :</dt>
                                                <asp:Label ID="lbldesignation" runat="server" Text='<%#  Eval("jobTitle")  %>' CssClass="title"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="clear"></div>

                                            <div class="user-deatils1">
                                                <dt>Status:</dt>
                                                <asp:Label ID="lblstatus" runat="server" Text='<%#  Eval("status")  %>' CssClass="status"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="clear"></div>
                                            <div class="user-deatils1">
                                                <div class="user-deatils1">
                                                    <div class="del-more">
                                                        <asp:LinkButton ID="lnkformoredetails" runat="server" Text="More.." Style="color: #249cdd!important" ToolTip="Click here to see employee details">
                                                        </asp:LinkButton>
                                                        <asp:Label ID="lbleid5" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="del-activelogin">
                                                    <asp:LinkButton ID="lbtnlogin" runat="server" Text="Login As A Employee" ToolTip="Click here to login as a employee" CssClass="LinkClickemployee">
                                                    </asp:LinkButton>
                                                    <asp:Label ID="lbllogineid" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="eid"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; padding: 4px 10px 10px 10px;">
                    <asp:Label ID="lblmessage" runat="server" Text="No employee list according to your searching." Style="display: none; color: red; font-size: 15px; margin-left: 100px !important;"></asp:Label>
                </td>
            </tr>

            <tr id="trforimagepagging" runat="server" style="display: none">
                <td align="left" style="width: 1070px" class="containerHeadline">
                    <div style="margin-left: 0px; float: left; width: 500px;">
                        <asp:Label ID="lblpage" CssClass="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <%--<asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>--%>
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

            <%--======================================This code is for Grid View==============================--%>
            <tr id="trforgridview" runat="server" style="display: none">

                <td id="tdforgrid" colspan="2" align="left" style="padding-left: 0px; padding-right: 0px; width: 100%">
                    <asp:GridView ID="grdAppoinmentLetter" AutoGenerateColumns="false" GridLines="Both" Width="100%" runat="server"
                        ShowHeader="true" BorderWidth="0">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Emp Code." HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lblRefno" Text='<%# Eval("refNo") %>' runat="server" ForeColor="Chocolate" CssClass="refNo"></asp:LinkButton>
                                        <asp:Label ID="lblid" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name" HeaderStyle-Width="300px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lbllnkformore" Text='<%# Eval("comname") %>' runat="server" CssClass="Name"></asp:LinkButton>
                                        <asp:Label ID="lblempid" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation/Department" HeaderStyle-Width="400px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblDesignation1" Text='<%# Eval("designation") %>' runat="server" CssClass="designation"></asp:Label>
                                    <label id="lblsless">/</label>
                                    <asp:Label ID="department" Text='<%# Eval("department") %>' runat="server" CssClass="department"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact No." HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lnkbtnformobile" Text='<%# Eval("mobile") %>' runat="server" CssClass="mobile" ToolTip="click here for send sms."></asp:LinkButton>
                                        <asp:Label ID="Label1lbleidforsmshistory2" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="id"></asp:Label>
                                        <asp:Label ID="lblrefnoforsmshtry2" runat="server" Text='<%#  Eval("refno")  %>' Style="display: none" CssClass="refNo"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lnkforemailid" Text='<%# Eval("emailid") %>' Style="cursor: pointer" runat="server" CssClass="email" ToolTip="click here for send email."></asp:LinkButton>
                                        <asp:Label ID="Label1lbleidforsmshistory3" runat="server" Text='<%# Bind("eid") %>' Style="display: none" CssClass="id"></asp:Label>
                                        <asp:Label ID="lblrefnoforsmshtry3" runat="server" Text='<%#  Eval("refno")  %>' Style="display: none" CssClass="refNo"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                        <asp:Label ID="lblidforedit" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>

            <tr id="trforgridviewpaggingpagging" runat="server" style="width: 1070px; display: none">
                <td align="left" style="width: 1066px!important" class="containerHeadline">
                    <div style="margin-left: 0px; float: left; width: 500px;">
                        <asp:Label ID="lblpage2" CssClass="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <%--  <asp:Label ID="Label2" runat="server" Style="color: green; font-size: 11pt"></asp:Label>--%>
                        of
                <asp:Label ID="lblTotalPages2" CssClass="lbltotalpage" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <span style="font-size: 11pt">Page</span>
                    </div>
                    <div style="margin-left: 0px; float: left; width: 500px;">

                        <img src="../../images/first.gif" id="btnfirst1" class="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/previous.gif" id="btnprev1" class="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/next.gif" id="btnnext1" class="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/last.gif" id="btnlast1" class="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    </div>
                </td>
            </tr>
            <%--=========================================Code For Grid View Ends here===========================================--%>

            <%--=====================================this code is for gridview pop up============================--%>
            <tr>
                <td>
                    <div id="divMessage" class="showpopup" style="text-align: center; display: none">

                        <div style="text-align: right;">
                            <div style="width: 50px; height: 33px; float: right; text-align: center; margin: 20px 21px 0px 0px; margin-right: 33px">
                                <a id="tdClosepopup" style="color: white; cursor: pointer; font-size: 15px; text-decoration: none" class="button2">Close</a>
                            </div>
                        </div>

                        <div id="content">
                            <div id="tab1">
                                <table style="background-color: white; vertical-align: top; width: 98%; margin-top: 27px; margin-left: 10px">
                                    <tr>
                                        <td colspan="6" class="tblHeading">General Details</td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Employee Code:</span></td>
                                        <td class="t2">
                                            <label id="lblRefno1"></label>
                                        </td>
                                        <td class="t1"><span>Login ID:</span></td>
                                        <td class="t2">
                                            <label id="lblusername"></label>
                                            <a href="http://school.awapalsolutions.com/emp-login.aspx" style="color: blue; text-decoration: underline; font-size: 10px; float: right" target="_blank">Click here for login</a>
                                        </td>
                                        <td class="t1"><span>Password:</span></td>
                                        <td class="t2">
                                            <label id="lblPassword"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Full Name:</span></td>
                                        <td class="t2">
                                            <label id="lblName"></label>
                                        </td>

                                        <td class="t1"><span>DOB:</span></td>
                                        <td class="t2">
                                            <label id="lblDOB"></label>
                                        </td>

                                        <td class="t1"><span>Gender:</span></td>
                                        <td class="t2">
                                            <label id="lblGender">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Birth Place:</span></td>
                                        <td class="t2">
                                            <label id="lblBirthPlace">--</label>
                                        </td>
                                        <td class="t1"><span>Nationality:</span></td>
                                        <td class="t2">
                                            <label id="lblNationality">--</label>
                                        </td>
                                        <td class="t1"><span>Marital Status:</span></td>
                                        <td class="t2">
                                            <label id="lblMStatus">--</label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>No. Of Children:</span></td>
                                        <td class="t2">
                                            <label id="lblNoOfChildren">--</label>
                                        </td>
                                        <td class="t1"><span>ID Name:</span></td>
                                        <td class="t2">
                                            <label id="idname">--</label>
                                        </td>
                                        <td class="t1"><span>ID Number:</span></td>
                                        <td class="t2">
                                            <label id="idnumber">--</label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>Residential Proof Name:</span></td>
                                        <td class="t2">
                                            <label id="ResidentialProofname">--</label>
                                        </td>
                                        <td class="t1"><span>Residential Proof Number:</span></td>
                                        <td class="t2" colspan="3">
                                            <label id="ResidentialProofnumber">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Submitted Document:</span></td>
                                        <td class="t2" colspan="5">
                                            <asp:CheckBoxList ID="chkboxlistfordocuments" runat="server" CssClass="forlabel" RepeatDirection="Horizontal" RepeatColumns="5">
                                                <asp:ListItem Value="1" Text="10th Marksheet"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="12th Marksheet"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="Graduate Degree"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="Post Graduate Degree"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="Diploma"></asp:ListItem>
                                            </asp:CheckBoxList>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Education Details</td>
                                    </tr>

                                    <tr>

                                        <td class="t2" colspan="6">

                                            <table id="tbl" runat="server" style="border: 0px solid #808080; width: 98%; margin-left: 10px; margin-top: 10px; margin-bottom: 10px">

                                                <tr class="trqualification">

                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Session</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Percentage</td>
                                                    <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important; width: 30%!important">College/Institute Address</td>
                                                </tr>

                                                <tr class="trqualification">
                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="ddlqualification1" runat="server" Width="120" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="txtboard1" runat="server" Width="120" Text="na" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification" style="width: 80px!important">
                                                        <asp:Label ID="txtyear1" runat="server" Width="120" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="txtsession1" runat="server" Width="150" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="txtrollnumber1" runat="server" Width="150" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="txtpercentage1" runat="server" Width="150" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                    <td class="tdfortrqualification">
                                                        <asp:Label ID="txtinsituteaddress1" runat="server" Width="150" CssClass="eductabletxt" Style="text-transform: none!important">
                                                        </asp:Label></td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="lblmsg" runat="server" Style="display: block; margin-left: 30px" Text="Currently, no education details available."></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Current Address Details</td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Address:</span></td>
                                        <td class="t2" colspan="5">
                                            <label id="address">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>City:</span></td>
                                        <td class="t2">
                                            <label id="city">--</label>
                                        </td>

                                        <td class="t1"><span>State:</span></td>
                                        <td class="t2">
                                            <label id="state">--</label>
                                        </td>

                                        <td class="t1"><span>Country:</span></td>
                                        <td class="t2">
                                            <label id="country">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Mobile No:</span></td>
                                        <td class="t2">
                                            <label id="lblphone">--</label>
                                        </td>

                                        <td class="t1"><span>Email ID:</span></td>
                                        <td class="t2">
                                            <label id="lblEmail">--</label>
                                        </td>

                                        <td class="t1"><span>Pin Code:</span></td>
                                        <td class="t2">
                                            <label id="pincode">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Landmark:</span></td>
                                        <td class="t2" colspan="6">
                                            <label id="current_address_landmark">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Permanent Address Details</td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Address:</span></td>
                                        <td class="t2" colspan="5">
                                            <label id="lblAddress">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>City:</span></td>
                                        <td class="t2">
                                            <label id="lblCity">--</label>
                                        </td>
                                        <td class="t1"><span>State:</span></td>
                                        <td class="t2">
                                            <label id="lblState">--</label>
                                        </td>

                                        <td class="t1"><span>Country:</span></td>
                                        <td class="t2">
                                            <label id="lblCountry">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Pin Code:</span></td>
                                        <td class="t2">
                                            <label id="lblPinCode">--</label>
                                        </td>
                                        <td class="t1"><span>Landmark:</span></td>
                                        <td class="t2" colspan="3">
                                            <label id="permanent_address_landmark">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Gardian Details</td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Father Name:</span></td>
                                        <td class="t2">
                                            <label id="father">--</label>
                                        </td>
                                        <td class="t1"><span>Father Mobile No.:</span></td>
                                        <td class="t2">
                                            <label id="fathermobileno">--</label>
                                        </td>
                                        <td class="t1"><span>Father Alternate Mobile No.:</span></td>
                                        <td class="t2">
                                            <label id="father_alternate_no">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Mother Name:</span></td>
                                        <td class="t2">
                                            <label id="mother">--</label>
                                        </td>
                                        <td class="t1"><span>Mother Mobile No:</span></td>
                                        <td class="t2">
                                            <label id="mothermobileno">--</label>
                                        </td>
                                        <td class="t1"><span>Parents Address:</span></td>
                                        <td class="t2">
                                            <label id="parentsaddress">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Employement Details</td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Department:</span></td>
                                        <td class="t2">
                                            <label id="lblDept">--</label>
                                        </td>

                                        <td class="t1"><span>Designation:</span></td>
                                        <td class="t2">
                                            <label id="lblDesig">--</label>
                                        </td>

                                        <td class="t1"><span>Branch:</span></td>
                                        <td class="t2">
                                            <label id="branch">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Pancard No:</span></td>
                                        <td class="t2">
                                            <label id="lblPANCardNo">--</label>
                                        </td>

                                        <td class="t1"><span>DOJ:</span></td>
                                        <td class="t2">
                                            <label id="lblDOJ">--</label>
                                        </td>

                                        <td class="t1"><span>Type of Employement: </span></td>
                                        <td class="t2">
                                            <label id="typeofemployement">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Probation Period:</span></td>
                                        <td class="t2">
                                            <label id="lblProbation">--</label>
                                        </td>

                                        <td class="t1"><span>Annual CTC:</span></td>
                                        <td class="t2">
                                            <label id="annualctc">--</label>
                                        </td>

                                        <td class="t1"><span>CTC Applied Date:</span></td>
                                        <td class="t2">
                                            <label id="CTCappliedfrom">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Inhand Salary: </span></td>
                                        <td class="t2">
                                            <label id="inhandsalary">--</label>
                                        </td>
                                        <td class="t1"><span>TDS Account No: </span></td>
                                        <td class="t2">
                                            <label id="tds_account_number">--</label>
                                        </td>

                                        <td class="t1"><span>PF Account No.: </span></td>
                                        <td class="t2">
                                            <label id="pfno">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>ESI Account No.: </span></td>
                                        <td class="t2">
                                            <label id="esino">--</label>
                                        </td>

                                        <td class="t1"><span>Office Email ID: </span></td>
                                        <td class="t2">
                                            <label id="lblOffemailid">--</label>
                                        </td>
                                        <td class="t1"><span>Managing Director:</span></td>
                                        <td class="t2">
                                            <label id="lblHrname">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Employement History </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Organiazation Name:</span></td>
                                        <td class="t2">
                                            <label id="lblOrg">--</label>
                                        </td>

                                        <td class="t1"><span>Address:</span></td>
                                        <td class="t2">
                                            <label id="lblPadd">--</label>
                                        </td>
                                        <td class="t1"><span>Country:</span></td>
                                        <td class="t2">
                                            <label id="lblPcountry">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>State/Province :</span></td>
                                        <td class="t2">
                                            <label id="lblPstate">--</label>
                                        </td>

                                        <td class="t1"><span>City:</span></td>
                                        <td class="t2">
                                            <label id="lblPCity">--</label>
                                        </td>
                                        <td class="t1"><span>Pin/Zip Code:</span></td>
                                        <td class="t2">
                                            <label id="lblPPindcode">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Designation :</span></td>
                                        <td class="t2">
                                            <label id="lblPDesignation">--</label>
                                        </td>

                                        <td class="t1"><span>Salary:</span></td>
                                        <td class="t2">
                                            <label id="lblSalary">--</label>
                                        </td>
                                        <td class="t1"><span>Experience:</span></td>
                                        <td class="t2">
                                            <table>
                                                <tr>
                                                    <td><b>Years</b></td>
                                                    <td style="padding-left: 14px"><b>Months</b></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label id="lblYears"></label>
                                                    </td>
                                                    <td style="padding-left: 14px">
                                                        <label id="lblMonths"></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>First Refrence Name :</span></td>
                                        <td class="t2">
                                            <label id="lblFirstRefrenceName">--</label>
                                        </td>
                                        <td class="t1"><span>Contact No :</span></td>
                                        <td class="t2">
                                            <label id="lblfrefContactNo">--</label>
                                        </td>
                                        <td class="t1"><span>Second Refrence Name:</span></td>
                                        <td class="t2">
                                            <label id="lblSecondRefrenceName">--</label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>Contact No. :</span></td>
                                        <td class="t2" colspan="6">
                                            <label id="lblContactNo">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="tblHeading">Medical Details </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Blood Group :</span></td>
                                        <td class="t2">
                                            <label id="lblBloodGroup">--</label>
                                        </td>

                                        <td class="t1"><span>Medical Condition :</span></td>
                                        <td class="t2">
                                            <label id="lblMedicalCondition">--</label>
                                        </td>
                                        <td class="t1"><span>Past Diseases :</span></td>
                                        <td class="t2">
                                            <label id="lblPastDiseases">--</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Genetic Disease :</span></td>
                                        <td class="t2">
                                            <label id="lblGeneticDisease">--</label>
                                        </td>

                                        <td class="t1"><span>Any Allergy :</span></td>
                                        <td class="t2" colspan="3">
                                            <label id="lblAnyAllergy">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="tblHeading">Account Details </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Bank Name :</span></td>
                                        <td class="t2">
                                            <label id="lblBankName">--</label>
                                        </td>

                                        <td class="t1"><span>Account No. :</span></td>
                                        <td class="t2">
                                            <label id="lblAccountNo">--</label>
                                        </td>
                                        <td class="t1"><span>Branch Name :</span></td>
                                        <td class="t2">
                                            <label id="lblBranchName">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Branch Code :</span></td>
                                        <td class="t2">
                                            <label id="lblBranchCode">--</label>
                                        </td>

                                        <td class="t1"><span>IFSC Code :</span></td>
                                        <td class="t2" colspan="3">
                                            <label id="lblIFSCCode">--</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="tblHeading">Office Use Details</td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Bio-Metric Card No.:</span></td>
                                        <td class="t2" colspan="6">
                                            <label id="biometricno">--</label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="divforemail" style="text-align: center; display: none;">
                        <div style="width: 95%; margin: 10px;">
                            <table class="showpopup2" style="background-color: white; vertical-align: top">
                                <tr>
                                    <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td1"><a id="btclose">Close</a></td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>To:</span></td>
                                    <td class="t2" style="padding-bottom: 5px">
                                        <asp:Label ID="lblforemailid" Style="height: 24px; width: 250px;" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t1" id="tdforsubject"><span>Subject:</span></td>
                                    <td class="t2" id="tdforsubject1">
                                        <asp:TextBox ID="txtsubject" Style="height: 24px; width: 250px;" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1" valign="top"><span>Message:</span></td>
                                    <td class="t2">
                                        <asp:TextBox ID="txtmesg" runat="server" Style="height: 100px; width: 251px" TextMode="MultiLine"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td colspan="3" style="padding-top: 10px!important">
                                        <asp:Button ID="btnsend" runat="server" Text="Send" CssClass="button2" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div id="divformobile" style="text-align: center; display: none;">
                        <div style="width: 95%; margin: 10px;">
                            <table class="showpopup2" style="background-color: white; vertical-align: top">
                                <tr>
                                    <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;" id="td2"><a id="btclose1">Close</a></td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>To:</span></td>
                                    <td class="t2" style="padding-bottom: 5px">
                                        <asp:Label ID="lblformobile" Style="height: 24px; width: 250px;" Enabled="false" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1" valign="top"><span>Message:</span></td>
                                    <td class="t2">
                                        <div>
                                            <div style="float: left; height: 15px; width: 300px; margin-left: 2px; margin-top: -8px;">
                                                <asp:Label ID="lblremain" runat="server" Style="color: #878484; font-size: 11px"></asp:Label>
                                            </div>
                                            <br />
                                            <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                <asp:TextBox ID="txtmsgformobile" runat="server" Style="height: 100px; width: 251px" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3" style="padding-top: 10px!important">
                                        <asp:Button ID="btnsendformobile" runat="server" Text="Send" CssClass="button2" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divProgressBar" class="progress"></div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>