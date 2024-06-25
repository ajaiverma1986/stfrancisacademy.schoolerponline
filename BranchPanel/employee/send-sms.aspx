<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="send-sms.aspx.cs" Inherits="branchpanel_employee_send_sms" %>

<%@ Register Src="~/BranchPanel/employee/employee_sms.ascx" TagName="stu" TagPrefix="My" %>
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
            height: 310px;
            margin-top: 100px;
            opacity: 1;
            width: 520px;
            z-index: 2147483647;
        }

        .texthover {
            border: solid 1px red !important;
        }
    </style>
    <script type="text/javascript">
        var keyno = 0, finalkeyno = 0, mobilearray = 0, msg = "", mobilenos = "", dotcount = 0, semicoloncount = 0, coloncount = 0;

        $(document).ready(function () {
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

            $("#ctl00_ContentPlaceHolder1_btnsendformobile").click(function () {
                msg = $("#ctl00_ContentPlaceHolder1_txtmsgformobile").val();
                mobilenos = $("#ctl00_ContentPlaceHolder1_txtformobileno").val();
                sendsms();
                return false;
            });

            //code is  for counting characters in sms text box end here
            $("#ctl00_ContentPlaceHolder1_txtformobileno").keyup(function () {
                var b = $("#ctl00_ContentPlaceHolder1_txtformobileno").val().replace(/[A-Za-z$-]/g, "");
                $("#ctl00_ContentPlaceHolder1_txtformobileno").val(b);

            });

            $("#ctl00_ContentPlaceHolder1_txtformobileno").on("blur", function () {
                mobilevalidation();

            });

            $("#ctl00_ContentPlaceHolder1_txtformobileno").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtformobileno").removeClass("texthover");
            });
            $("#ctl00_ContentPlaceHolder1_txtmsgformobile").focus(function () {
                $("#ctl00_ContentPlaceHolder1_txtmsgformobile").removeClass("texthover");
            });

        });

        function mobilevalidation() {

            if ($("#ctl00_ContentPlaceHolder1_txtformobileno").val() != "") {
                semicoloncount = $("#ctl00_ContentPlaceHolder1_txtformobileno").val().split(";").length - 1;

                dotcount = $("#ctl00_ContentPlaceHolder1_txtformobileno").val().split(".").length - 1;

                coloncount = $("#ctl00_ContentPlaceHolder1_txtformobileno").val().split(":").length - 1;

                if (semicoloncount > 0 || dotcount > 0 || coloncount > 0) {
                    alertify.alert("You can only use comma to seperate mobile numbers.");
                    document.getElementById('ctl00_ContentPlaceHolder1_txtformobileno').className = "texthover";
                    return false;
                }

                mobilearray = $("#ctl00_ContentPlaceHolder1_txtformobileno").val().split(",");

                for (var index = 0; index < mobilearray.length; index++) {
                    if (mobilearray[index].toString() != "") {
                        if (mobilearray[index].length < 10) {
                            alertify.error(mobilearray[index] + " number should not be less than 10 digits.");
                            document.getElementById('ctl00_ContentPlaceHolder1_txtformobileno').className = "texthover";
                            return false;
                        }
                        if (mobilearray[index].length > 10) {
                            alertify.error(mobilearray[index] + " number should not be greater than 10 digits.");
                            document.getElementById('ctl00_ContentPlaceHolder1_txtformobileno').className = "texthover";
                            return false;
                        }
                    }

                }
            }
        }
        function sendsms() {
            if (document.getElementById('<%=txtformobileno.ClientID %>').value == 0) {
                document.getElementById('<%= txtformobileno.ClientID %>').className = "texthover";
                return false;
            }

            if (document.getElementById('<%=txtmsgformobile.ClientID %>').value == 0) {
                document.getElementById('<%= txtmsgformobile.ClientID %>').className = "texthover";
                return false;
            }

            alertify.confirm("Are you sure you want to send this message?", function (e) {
                if (e) {

                    var chkstatus = mobilevalidation();

                    if (chkstatus != false) {
                        $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', true);
                        $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Wait..');

                        call_progressbar("start");
                        $.ajax({
                            type: 'POST',
                            contentType: "application/json; charset=utf-8",
                            url: "offered-employer-list.aspx/sendsmsonmobile",
                            data: "{'mobile':'" + mobilenos + "','msg':'" + msg + "'}",
                            dataType: "json",
                            success: function (data) {

                                if (parseInt(data.d) == 1) {
                                    insert_sms_history(0, "", mobilenos, "", msg, "", "", 1, 0);

                                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');
                                    $('#ctl00_ContentPlaceHolder1_txtmsgformobile').val('');
                                    $('#ctl00_ContentPlaceHolder1_txtformobileno').val('');
                                    alertify.success("Message has been sent successfully");

                                }
                                else {
                                    alertify.error("Mobile number is not valid.");
                                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').prop('disabled', false);
                                    $('#ctl00_ContentPlaceHolder1_btnsendformobile').val('Send');

                                }
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
            <li><a>SMS Center</a></li>
            <li style="background: none;"><a class="active" href="#">Send SMS</a></li>
        </ul>
    </div>
     <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="Stu1" />
   
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr style="height: 450px">
                <td>
                    <div id="divformobile" style="text-align: center; display: block;">
                        <div style="width: 95%; margin: 10px;">
                            <table class="showpopup2" style="background-color: white; vertical-align: top">
                                <tr>
                                    <td colspan="4" style="text-align: center; color: black; padding-top: 5px; font-weight: bold; font-size: 16px" id="td2">Send SMS
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1"><span>To:</span></td>
                                    <td class="t2" style="padding-bottom: 5px">
                                        <asp:TextBox ID="txtformobileno" Style="height: 24px; width: 300px; margin: 9px 0px 4px 0px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="t1" valign="top"><span>Message:</span></td>
                                    <td class="t2">
                                        <div>
                                            <div style="float: left; height: 15px; width: 300px; margin-left: 2px; margin-top: -3px;">
                                                <asp:Label ID="lblremain" runat="server" Style="color: #878484; font-size: 11px"></asp:Label>
                                            </div>
                                            <br />
                                            <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                <asp:TextBox ID="txtmsgformobile" runat="server" Style="height: 100px; width: 300px" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3" style="padding-top: 10px!important">
                                        <asp:Button ID="btnsendformobile" Style="cursor: pointer" runat="server" Text="Send" CssClass="button2" />
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