<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="send-email.aspx.cs" Inherits="branchpanel_employee_send_email" %>

<%@ Register Src="~/BranchPanel/employee/employee_email.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>

    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .t1 {
            height: 10px !important;
            padding-top: 0px !important;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
        }

        .t2 {
            padding-top: 0px !important;
            font-size: 12px !important;
            text-align: left !important;
        }

        .showpopup2 {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 400px;
            margin-top: 100px;
            opacity: 1;
            width: 748px;
            z-index: 2147483647;
        }

        .texthover {
            border: solid 1px red !important;
        }
    </style>
    <script type="text/javascript">
        var emailid = "", subject = "", msg = "", semicoloncount = 0, coloncount = 0;

        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_txtemailids").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtemailids").removeClass("texthover");
            });
            $("#ctl00_ContentPlaceHolder1_txtsubject").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtsubject").removeClass("texthover");
            });
            $("#ctl00_ContentPlaceHolder1_txtmesg").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtmesg").removeClass("texthover");
            });

            $("#ctl00_ContentPlaceHolder1_btnsend").click(function () {
                subject = $("#ctl00_ContentPlaceHolder1_txtsubject").val();
                msg = $("#ctl00_ContentPlaceHolder1_txtmesg").val();
                emailid = $("#ctl00_ContentPlaceHolder1_txtemailids").val();
                SendingEmail();
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_txtemailids").blur(function () {

                emailvalidation();
            });
        });

        function emailvalidation() {

            if ($("#ctl00_ContentPlaceHolder1_txtemailids").val() != "") {
                semicoloncount = $("#ctl00_ContentPlaceHolder1_txtemailids").val().split(";").length - 1;

                coloncount = $("#ctl00_ContentPlaceHolder1_txtemailids").val().split(":").length - 1;

                if (semicoloncount > 0 || coloncount > 0) {
                    alertify.alert("You can only use comma to seperate email address.");
                    document.getElementById('ctl00_ContentPlaceHolder1_txtemailids').className = "texthover";
                    return false;
                }

                mobilearray = $("#ctl00_ContentPlaceHolder1_txtemailids").val().split(",");

                for (var index = 0; index < mobilearray.length; index++) {
                    if (mobilearray[index].toString() != "") {
                        if (!mobilearray[index].toString().match(/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/)) {
                            alertify.error(mobilearray[index] + " is not valid email address");
                            document.getElementById('ctl00_ContentPlaceHolder1_txtemailids').className = "texthover";
                            return false;
                        }

                    }

                }
            }
        }

        function SendingEmail() {

            if (document.getElementById('<%=txtemailids.ClientID %>').value == 0) {
                document.getElementById('<%= txtemailids.ClientID %>').className = "texthover";
                return false;
            }

            if (document.getElementById('<%=txtsubject.ClientID %>').value == 0) {
                document.getElementById('<%= txtsubject.ClientID %>').className = "texthover";
                return false;
            }

            if (document.getElementById('<%=txtmesg.ClientID %>').value == 0) {
                document.getElementById('<%= txtmesg.ClientID %>').className = "texthover";
                return false;
            }

            var emlstatus = emailvalidation();
            if (emlstatus != false) {
                $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', true);
                $('#ctl00_ContentPlaceHolder1_btnsend').val('Wait..');

                call_progressbar("start");

                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "shortlisted-candidates-list.aspx/SendMail",
                    data: "{'emailid':'" + emailid + "','subject':'" + subject + "','msg':'" + msg + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (parseInt(data.d) == 1) {
                            alertify.success("Mail has been sent successfully.");
                            insert_sms_history(0, "", 0, emailid, msg, subject, "", 2, 0);
                            $('#ctl00_ContentPlaceHolder1_btnsend').prop('disabled', false);
                            $('#ctl00_ContentPlaceHolder1_btnsend').val('Send');
                            $('#ctl00_ContentPlaceHolder1_txtsubject').val('');
                            $('#ctl00_ContentPlaceHolder1_txtmesg').val('');

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

                    id = "";
                    refNo = "";
                    mobile = "";
                    emailid = "";
                    subject = "";
                    msg = "";
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
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>E-mail Center</a></li>
            <li style="background: none;"><a class="active" href="#">Send E-mail</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="Stu1" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr style="height: 450px">
                <td>
                    <div id="divforemail" style="text-align: center; display: block;">
                        <div style="width: 95%; margin: 10px;">
                            <table class="showpopup2" style="background-color: white; vertical-align: top">
                                <tr>
                                    <td colspan="4" style="text-align: center; color: black; padding-top: 5px; font-weight: bold; font-size: 16px" id="td2">Send E-mail
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>To:</span></td>
                                    <td class="t2" style="padding-bottom: 5px">
                                        <asp:TextBox ID="txtemailids" Style="height: 24px; width: 615px; margin: 9px 0px 4px 0px; color: #676363" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t1" id="tdforsubject"><span>Subject:</span></td>
                                    <td class="t2" id="tdforsubject1">
                                        <asp:TextBox ID="txtsubject" Style="height: 24px; width: 615px; margin: 9px 0px 4px 0px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1" valign="top"><span>Message:</span></td>
                                    <td class="t2">
                                        <asp:TextBox ID="txtmesg" runat="server" Style="height: 150px; width: 615px; margin: 9px 0px 4px 0px" TextMode="MultiLine"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td colspan="3" style="padding-top: 10px!important">
                                        <asp:Button ID="btnsend" runat="server" Style="cursor: pointer" Text="Send" CssClass="button2" />
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