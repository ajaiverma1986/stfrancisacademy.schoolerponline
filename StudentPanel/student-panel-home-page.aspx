<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="student-panel-home-page.aspx.cs" Inherits="EmployeePanel_employee_panel_home_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .dashboardactive {
            margin: 0px -3px;
            background-color: #2aa9eb;
        }

        .side-bar-wrapper .side-menu > li .dashboardactive i {
            border-right: 1px solid #2cd7fb;
            -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
            box-shadow: 1px 0px 0px 0px #1d93d0;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
            width: 180px!important;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 180px!important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 180px!important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 180px!important;
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

        .showpopupforchangepassword {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 10px solid #24272E;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 40%;
            opacity: 1;
            position: fixed;
            top: 32%;
            width: 38%;
            z-index: 2147483647;
        }

            .showpopupforchangepassword td {
                vertical-align: top;
                color: #666666;
            }

        #lblmessage {
            color: red;
        }
    </style>
    <%--for check password strength start here--%>

    <style>
        .txtrePassstregthtooshortdiv, .txtrePassstregthweakdiv, .txtrePassstregthgooddiv, .txtrePassstregthstrongdiv, .txtPassstregthtooshortdiv, .txtPassstregthweakdiv, .txtPassstregthgooddiv, .txtPassstregthstrongdiv, .txtcurrentPassstregthtooshortdiv, .txtcurrentPassstregthweakdiv, .txtcurrentPassstregthgooddiv, .txtcurrentPassstregthstrongdiv {
            width: 300px;
            height: 200px;
            border: 1px solid black;
            -webkit-animation: mymove 5s infinite; /* Chrome, Safari, Opera */
            animation: mymove 5s infinite;
        }

        /* Chrome, Safari, Opera */
        @-webkit-keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }

        /* Standard syntax */
        @keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }
    </style>
    <%--for check password strength end here--%>

    <script type="text/javascript">

        var oldpassword = "", newpassword = "", Confirmnewpassword = "";

        $(document).on("click", "[id*=lbtnchangepassword]", function () {
            $('#ctl00_head_tdbtnclose').html('Close');
            $("#ctl00_head_divchangepassword").show(500);
            $("#ctl00_head_divchangepassword").fadeIn();
            $('#ctl00_head_txtcurrentpassword').val('');
            return false;
        });

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

        $(document).ready(function () {

            $("#ctl00_head_tdbtnclose").click(function () {
                $("#ctl00_head_divchangepassword").hide(600);
                $('#ctl00_head_txtcurrentpassword').val('');
                $('#ctl00_head_txtnewpassword').val('');
                $('#ctl00_head_txtconfirmnewpassword').val('');
                $('#lblmessage').html('');

            });
            $('#ctl00_head_btnchangepassword').click(function () {
                if ($('#ctl00_head_txtcurrentpassword').val() == "") {
                    $('#lblmessage').html('Enter Current Password Please.');
                }
                else if ($('#ctl00_head_txtnewpassword').val() == "") {
                    $('#lblmessage').html('Enter New Password Please.');
                }
                else if ($('#ctl00_head_txtconfirmnewpassword').val() == "") {
                    $('#lblmessage').html('Confirm New Password Please.');
                }
                else {
                    oldpassword = $('#ctl00_head_txtcurrentpassword').val();
                    newpassword = $('#ctl00_head_txtnewpassword').val();
                    Confirmnewpassword = $('#ctl00_head_txtconfirmnewpassword').val();
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "student-panel-home-page.aspx/ChangePassword",
                        data: "{'oldpassword':'" + oldpassword + "','newpassword':'" + newpassword + "','Confirmnewpassword':'" + Confirmnewpassword + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == 1) {
                                $('#lblmessage').html('Password Changed Sucessfully.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
                                checkStrength($('#ctl00_head_txtnewpassword').val());
                                checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                            }
                            if (data.d == 2) {
                                $('#lblmessage').html('your current password is incorrect.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
                                checkStrength($('#ctl00_head_txtnewpassword').val());
                                checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                            }
                            if (data.d == 3) {
                                $('#lblmessage').html('New Password & Confirm New Password are not same.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
                                checkStrength($('#ctl00_head_txtnewpassword').val());
                                checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                            }
                        },
                        error: function (result) {
                            $('#lblmessage').html('Some Error Try Again Plz.');
                        }
                    });
                }
                return false;
            });
            $('#ctl00_head_txtcurrentpassword').focus(function () {
                $('#lblmessage').html('');
            });
            $('#ctl00_head_txtnewpassword').focus(function () {
                $('#lblmessage').html('');
            });
            $('#ctl00_head_txtconfirmnewpassword').focus(function () {
                $('#lblmessage').html('');
            });

            //code for check passwword strength start here

            $('#ctl00_head_txtnewpassword').keyup(function () {
                if ($('#ctl00_head_txtnewpassword').val() != '') {
                    checkStrength($('#ctl00_head_txtnewpassword').val());
                }
                else {
                    $('.txtPassstregthtooshortdiv').hide();
                }
            })
            //checkStrength($('#ctl00_head_txtnewpassword').val());
            //Code For Confirm Password
            $('#ctl00_head_txtconfirmnewpassword').keyup(function () {
                if ($('#ctl00_head_txtconfirmnewpassword').val() != '') {
                    checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                }
                else {
                    $('.txtrePassstregthtooshortdiv').hide();
                }
            })
            //checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());

            $('#ctl00_head_txtcurrentpassword').keyup(function () {
                if ($('#ctl00_head_txtcurrentpassword').val() != '') {
                    checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                }
                else {
                    $('.txtcurrentPassstregthtooshortdiv').hide();
                }
            })
            //checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
            //code for check passwword strength end here
        });
        function checkStrength(password) {
            //initial strength
            var strength = 0

            //if the password length is less than 6, return message.
            if (password.length < 6) {
                //$('#result').removeClass()
                //$('#result').addClass('short')
                $('.txtPassstregthtooshortdiv').show();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').hide();
                return 'Too short'
            }

            //length is ok, lets continue.

            //if length is 6 characters or more, increase strength value
            if (password.length > 5) strength += 1

            //if password contains both lower and uppercase characters, increase strength value
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

            //if it has numbers and characters, increase strength value
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

            //if it has one special character, increase strength value
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //if it has two special characters, increase strength value
            //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //now we have calculated strength value, we can return messages

            //if value is less than 2
            if (strength < 2) {
                //$('#result').removeClass()
                //$('#result').addClass('weak')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').show();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').hide();
                return 'Weak'
            }
            else if (strength == 2) {
                //$('#result').removeClass()
                //$('#result').addClass('good')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').show();
                $('.txtPassstregthstrongdiv').hide();
                return 'Good'
            }
            else {
                //$('#result').removeClass()
                //$('#result').addClass('strong')
                $('.txtPassstregthtooshortdiv').hide();
                $('.txtPassstregthweakdiv').hide();
                $('.txtPassstregthgooddiv').hide();
                $('.txtPassstregthstrongdiv').show();
                return 'Strong'
            }
        }

        function checkStrength_Confirm(password) {
            //initial strength
            var strength = 0

            //if the password length is less than 6, return message.
            if (password.length < 6) {
                $('.txtrePassstregthtooshortdiv').show();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Too short'
            }

            //length is ok, lets continue.

            //if length is 6 characters or more, increase strength value
            if (password.length > 5) strength += 1

            //if password contains both lower and uppercase characters, increase strength value
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

            //if it has numbers and characters, increase strength value
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

            //if it has one special character, increase strength value
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //if it has two special characters, increase strength value
            //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //now we have calculated strength value, we can return messages

            //if value is less than 2
            if (strength < 2) {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').show();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Weak'
            }
            else if (strength == 2) {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').show();
                $('.txtrePassstregthstrongdiv').hide();
                return 'Good'
            }
            else {
                $('.txtrePassstregthtooshortdiv').hide();
                $('.txtrePassstregthweakdiv').hide();
                $('.txtrePassstregthgooddiv').hide();
                $('.txtrePassstregthstrongdiv').show();
                return 'Strong'
            }
        }

        function checkStrength_Current(password) {
            //initial strength
            var strength = 0

            //if the password length is less than 6, return message.
            if (password.length < 6) {
                $('.txtcurrentPassstregthtooshortdiv').show();
                $('.txtcurrentPassstregthweakdiv').hide();
                $('.txtcurrentPassstregthgooddiv').hide();
                $('.txtcurrentPassstregthstrongdiv').hide();
                return 'Too short'
            }

            //length is ok, lets continue.

            //if length is 6 characters or more, increase strength value
            if (password.length > 5) strength += 1

            //if password contains both lower and uppercase characters, increase strength value
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

            //if it has numbers and characters, increase strength value
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

            //if it has one special character, increase strength value
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //if it has two special characters, increase strength value
            //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

            //now we have calculated strength value, we can return messages

            //if value is less than 2
            if (strength < 2) {
                $('.txtcurrentPassstregthtooshortdiv').hide();
                $('.txtcurrentPassstregthweakdiv').show();
                $('.txtcurrentPassstregthgooddiv').hide();
                $('.txtcurrentPassstregthstrongdiv').hide();
                return 'Weak'
            }
            else if (strength == 2) {
                $('.txtcurrentPassstregthtooshortdiv').hide();
                $('.txtcurrentPassstregthweakdiv').hide();
                $('.txtcurrentPassstregthgooddiv').show();
                $('.txtcurrentPassstregthstrongdiv').hide();
                return 'Good'
            }
            else {
                $('.txtcurrentPassstregthtooshortdiv').hide();
                $('.txtcurrentPassstregthweakdiv').hide();
                $('.txtcurrentPassstregthgooddiv').hide();
                $('.txtcurrentPassstregthstrongdiv').show();
                return 'Strong'
            }
        }
    </script>

    <div class="content-wrapper dashboard-only">
        <div class="content-inner">
            <div class="page-header">

                <h1>
                    <i class="fa fa-user"></i>
                    Profile
                </h1>
            </div>

            <div class="main-content">
                <div class="widget">
                    <div class="row">
                        <div class="col-lg-3 col-md-4 col-sm-6 text-center">
                            <div class="widget-content-blue-wrapper changed-up">
                                <a href="student-view-profile.aspx">
                                    <div class="widget-content-blue-inner padded">
                                        <div class="pre-value-block">
                                            My Profile
                                        </div>
                                        <div class="value-block">
                                            <i class="fa fa-user" style="color: #2aa9eb;"></i>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 text-center">
                            <div class="widget-content-blue-wrapper changed-up">
                                <a href="Messagecenter.aspx">
                                    <div class="widget-content-blue-inner padded">
                                        <div class="pre-value-block">
                                            Notice Board
                                        </div>
                                        <div class="value-block">
                                            <i class="fa fa-sticky-note" style="color: #f17f0f;"></i>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 text-center" style="display:none;">
                            <div class="widget-content-blue-wrapper changed-up">
                                <a href="List-of-Holiday.aspx">
                                    <div class="widget-content-blue-inner padded">
                                        <div class="pre-value-block">
                                            Calender
                                        </div>
                                        <div class="value-block">
                                            <i class="fa fa-calendar-o" style="color: #09ab1c;"></i>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 text-center">
                            <div class="widget-content-blue-wrapper changed-up">

                                <a href="my-test.aspx">
                                    <div class="widget-content-blue-inner padded">
                                        <div class="pre-value-block">
                                            Exam Alerts
                                        </div>
                                        <div class="value-block">

                                            <i class="fa fa-bell" style="color: #fb6b5b;"></i>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div id="divchangepassword" style="text-align: center; display: none;" runat="server">
                            <div style="width: 95%; margin: 0px;">
                                <table class="showpopupforchangepassword" style="background-color: white; vertical-align: top">
                                    <tr>
                                        <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;"><a id="tdbtnclose" runat="server">Close</a></td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Current Password:</span></td>
                                        <td class="t2">
                                            <div>
                                                <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                    <asp:TextBox ID="txtcurrentpassword" runat="server" Style="width: 142px ! important" placeholder="you current password" TextMode="Password" autocomplete="off"></asp:TextBox>
                                                    <div class="txtcurrentPassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                    <div class="txtcurrentPassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                    <div class="txtcurrentPassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                    <div class="txtcurrentPassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>New Password:</span></td>
                                        <td class="t2">
                                            <div>
                                                <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                    <asp:TextBox ID="txtnewpassword" runat="server" Style="Width: 142px ! important;" placeholder="enter new password" TextMode="Password"></asp:TextBox>

                                                    <div class="txtPassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                    <div class="txtPassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                    <div class="txtPassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                    <div class="txtPassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Confirm New Password:</span></td>
                                        <td class="t2">
                                            <div>
                                                <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                    <asp:TextBox ID="txtconfirmnewpassword" runat="server" Style="Width: 142px ! important;" placeholder="enter password same as above" TextMode="Password"></asp:TextBox>

                                                    <div class="txtrePassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                    <div class="txtrePassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                    <div class="txtrePassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                    <div class="txtrePassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="padding-top: 10px!important">
                                            <asp:Button ID="btnchangepassword" runat="server" Text="Submit" CssClass="button_save" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="padding-top: 10px!important">
                                            <label id="lblmessage"></label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>