<%@ Page Title="" Language="C#" MasterPageFile="~/EmployeePanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="employee-panel-home-page.aspx.cs" Inherits="EmployeePanel_employee_panel_home_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .dashboardactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
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
    <script type="text/javascript">

        var oldpassword = "", newpassword = "", Confirmnewpassword = "";

        $(document).on("click", "[id*=lbtnchangepassword]", function () {
            $('#ctl00_head_tdbtnclose').html('Close');
            $("#ctl00_head_divchangepassword").show(500);
            $("#ctl00_head_divchangepassword").fadeIn();
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
   
                        url: "employee-panel-home-page.aspx/ChangePassword",
                        data: "{'oldpassword':'" + oldpassword + "','newpassword':'" + newpassword + "','Confirmnewpassword':'" + Confirmnewpassword + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == 1) {
                                $('#lblmessage').html('Password Changed Sucessfully.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
                            }
                            if (data.d == 2) {
                                $('#lblmessage').html('your current password is incorrect.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
                            }
                            if (data.d == 3) {
                                $('#lblmessage').html('New Password & Confirm New Password are not same.');
                                $('#ctl00_head_txtcurrentpassword').val('');
                                $('#ctl00_head_txtnewpassword').val('');
                                $('#ctl00_head_txtconfirmnewpassword').val('');
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
        });
    </script>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="../emp-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-dashboard"></i>
                        Dashboard
                    </h1>
                </div>
                <div class="main-content">
                    <div class="widget">
                        <div class="alert alert-warning alert-dismissable">
                            <button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button>
                            <i class="icon-exclamation-sign"></i>
                            <strong>Welcome!</strong>
                            <strong>
                                <asp:Label ID="lbluername" runat="server"></asp:Label></strong>
                        </div>
                    </div>
                    <div class="widget">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-6 text-center">
                                <div class="widget-content-blue-wrapper changed-up" style="width: 240px!important">
                                    <div class="widget-content-blue-inner padded">
                                        <div class="pre-value-block">
                                            <i class="icon-dashboard"></i>
                                            <asp:LinkButton ID="lnkattandance" runat="server" PostBackUrl="~/EmployeePanel/emp-attandance-report.aspx" Text="Today's Attandance"></asp:LinkButton>
                                        </div>
                                        <div class="value-block">
                                            <div class="value-self">NA </div>
                                            <div class="value-sub"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4 col-sm-6 text-center" style="margin-left: 30px;">
                                <div class="widget-content-blue-wrapper changed-up" style="width: 240px!important; height: 173px!important">
                                    <div class="widget-content-blue-inner padded" style="height: 142px!important">
                                        <div class="pre-value-block">
                                            <i class="icon-tag"></i>
                                            <asp:LinkButton ID="lnkprofile" runat="server" Text="Your Profile" PostBackUrl="student-view-profile.aspx"></asp:LinkButton>
                                        </div>
                                        <div class="value-block">
                                            <div class="value-self">E1</div>
                                            <div class="value-sub">Till Date</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-4 col-sm-6 text-center" style="margin-left: 30px;">
                                <div class="widget-content-blue-wrapper changed-up" style="width: 240px!important; height: 173px!important">
                                    <div class="widget-content-blue-inner padded" style="height: 142px!important">
                                        <div class="pre-value-block">
                                            <i class="icon-tag"></i>
                                            <asp:LinkButton ID="lbtnchangepassword" runat="server" Text="Change Password"></asp:LinkButton>
                                        </div>
                                        <div class="value-block">
                                            <div class="value-self">E1</div>
                                            <div class="value-sub">Till Date</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="divchangepassword" style="text-align: center; display: none;" runat="server">
                        <div style="width: 95%; margin: 10px;">
                            <table class="showpopupforchangepassword" style="background-color: white; vertical-align: top;     border-collapse: inherit;">
                                <tr>
                                    <td colspan="4" style="text-align: right; cursor: pointer; color: red; padding-right: 13px; padding-top: 5px;"><a id="tdbtnclose" runat="server">Close</a></td>
                                </tr>
                                <tr>
                                    <td class="t1"><span>Current Password:</span></td>
                                    <td class="t2">
                                        <div>
                                            <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                <asp:TextBox ID="txtcurrentpassword" runat="server" Style="width: 250px" placeholder="you current password" TextMode="Password"></asp:TextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t1"><span>New Password:</span></td>
                                    <td class="t2">
                                        <div>
                                            <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                <asp:TextBox ID="txtnewpassword" runat="server" Style="width: 250px" placeholder="enter new password" TextMode="Password"></asp:TextBox>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t1"><span>Confirm New Password:</span></td>
                                    <td class="t2">
                                        <div>
                                            <div style="margin-top: -8px; float: left; margin-bottom: 10px">
                                                <asp:TextBox ID="txtconfirmnewpassword" runat="server" Style="width: 250px" placeholder="enter password same as above" TextMode="Password"></asp:TextBox>
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
</asp:Content>