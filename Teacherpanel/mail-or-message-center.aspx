<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="mail-or-message-center.aspx.cs" Inherits="EmployeePanel_mail_or_message_center" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .mailcenteractive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .trforradio {
            display: none;
        }

        .main-content {
            min-height: 500px !important;
        }

        .Comman {
            margin-top: 20px !important;
        }

        .table thead > tr > th, .table tbody > tr > th, .table tfoot > tr > th, .table thead > tr > td, .table tbody > tr > td, .table tfoot > tr > td {
            border-top: none !important;
            border-bottom: none !important;
        }

        .btnsubmitforemployeepanel {
            background: none repeat scroll 0 0 #f84904;
            border: medium none;
            color: #fff;
            display: inline-block;
            float: right;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-style: normal;
            font-weight: bold;
            height: 27px;
            margin-right: 400px;
            position: relative;
            text-decoration: none;
            text-shadow: none;
            width: 35px;
            z-index: 5;
        }

        input[type="text"], textarea {
            background-color: #fcfcfc !important;
            border: 1px solid #ccc !important;
            border-radius: 4px !important;
            box-shadow: none !important;
            color: #676767 !important;
            font-size: 14px !important;
            height: 28px !important;
            line-height: 20px !important;
            padding: 3px 6px !important;
            text-align: left !important;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s !important;
            width: 300px !important;
        }

        .login_section1 {
            border-bottom: 1px dashed #c5c8c3;
            font-size: 18px;
            margin-top: 29px;
            padding-bottom: 35px;
            width: 100%;
            font-size: 18px;
        }

        input[type="radio"] {
            visibility: hidden;
        }

        .radio_btn_div {
            float: left;
            height: 20px;
            padding-right: 12px;
            width: auto;
        }

        .rdn_0 {
            background: -moz-linear-gradient(center top, #fcfff4 0%, #dfe5d7 40%, #b3bead 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
            border-radius: 50px;
            box-shadow: 0 1px 1px white inset, 0 1px 3px rgba(0, 0, 0, 0.5);
            float: left;
            height: 18px;
            margin: 0 7px 2px 0;
            position: relative;
            width: 18px;
        }

            .rdn_0 label:after {
                background: -moz-linear-gradient(center top, #228b7f 0%, #228b7f 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
                border-radius: 50px;
                box-shadow: 0 1px 1px white inset, 0 1px 3px rgba(0, 0, 0, 0.5);
                content: "";
                height: 10px;
                left: 1px;
                opacity: 0;
                position: absolute;
                top: 1px;
                width: 10px;
            }

            .rdn_0 input[type="radio"]:checked + label:after {
                opacity: 1 !important;
            }

            .rdn_0 label {
                background: -moz-linear-gradient(center top, #8f8e8e 0%, #8f8e8e 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
                border-radius: 50px;
                box-shadow: 0 1px 1px rgba(0, 0, 0, 0.5) inset, 0 1px 0 rgba(255, 255, 255, 1);
                cursor: pointer;
                height: 12px;
                left: 3px;
                position: absolute;
                top: 3px;
                width: 12px;
            }

        .rdn_1 {
            background: -moz-linear-gradient(center top, #fcfff4 0%, #dfe5d7 40%, #b3bead 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
            border-radius: 50px;
            box-shadow: 0 1px 1px white inset, 0 1px 3px rgba(0, 0, 0, 0.5);
            float: left;
            height: 18px;
            margin: 0 7px 2px 0;
            position: relative;
            width: 18px;
        }

            .rdn_1 label:after {
                background: -moz-linear-gradient(center top, #228b7f 0%, #228b7f 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
                border-radius: 50px;
                box-shadow: 0 1px 1px white inset, 0 1px 3px rgba(0, 0, 0, 0.5);
                content: "";
                height: 10px;
                left: 1px;
                opacity: 0;
                position: absolute;
                top: 1px;
                width: 10px;
            }

            .rdn_1 input[type="radio"]:checked + label:after {
                opacity: 1;
            }

            .rdn_1 label {
                background: -moz-linear-gradient(center top, #8f8e8e 0%, #8f8e8e 100%) repeat scroll 0 0 rgba(0, 0, 0, 0);
                border-radius: 50px;
                box-shadow: 0 1px 1px rgba(0, 0, 0, 0.5) inset, 0 1px 0 rgba(255, 255, 255, 1);
                cursor: pointer;
                height: 12px;
                left: 3px;
                position: absolute;
                top: 3px;
                width: 12px;
            }
    </style>

    <script type="text/ecmascript">
        var radiodbuttonclickedid = "0";
        $(document).ready(function () {
            $('input[type="radio"]').click(function () {
                $('#tblprofiledemo').css("display", "none");
                $('#ctl00_head_btncontinue').css("display", "none");
                $('.sendsmsormessage').css("display", "none");
                $('#ctl00_head_txtloginid').val('');
                radiodbuttonclickedid = $(this).val();
                if (radiodbuttonclickedid == "1") {
                    $('.trforradio').css("display", "none");
                }
                else {
                    $('.trforradio').css("display", "block");
                }
            });
            $('#ctl00_head_btnsubmitloginid').click(function () {
                if ($('#ctl00_head_txtloginid').val() == "") {
                    $('#lblmessage').html("Enter Id Please.");
                    return false;
                }
                else {
                    $('.table').css("display", "block");
                    $('#ctl00_head_btncontinue').css("display", "block");
                    $('.sendsmsormessage').css("display", "none");
                    return false;
                }
            });
            $('#ctl00_head_txtloginid').click(function () {
                $('#lblmessage').html("");
            });
            $('#ctl00_head_btncontinue').click(function () {
                $('#tblprofiledemo').css("display", "none");
                $('#ctl00_head_btncontinue').css("display", "none");
                $('.sendsmsormessage').css("display", "block");
                return false;
            });
            $('#ctl00_head_btnsendmessage').click(function () {
                return false;
            });
            $('#ctl00_head_btncancel').click(function () {
                $('.sendsmsormessage').css("display", "none");
                $('#tblprofiledemo').css("display", "block");
                $('#ctl00_head_btncontinue').css("display", "block");
                return false;
            });
        });
    </script>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                       <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Mail Center
                    </h1>
                </div>
                <div class="main-content">
                    <div class="login_section1">
                        <div class="radio_btn_div">
                            <div class="rdn_0 ">

                                <input id="rdn_0" class="rdn_0" type="radio" checked="checked" name="check" value="1" />
                                <label for="rdn_0"></label>
                            </div>
                            <span>SEND MESSAGE</span>
                        </div>
                        <div class="radio_btn_div">
                            <div class="rdn_1">

                                <input id="rdn_1" class="rdn_1" type="radio" name="check" value="2" />
                                <label for="rdn_1"></label>
                            </div>
                            <span>SEND ATTACHMENT </span>
                        </div>
                    </div>
                    <div class="Comman">
                        <table class="table" style="width: 100%; border: 3px solid #8F4949 !important">
                            <tr>
                                <td class="t1"><span>Enter Id Please:</span></td>
                                <td class="t2">
                                    <asp:TextBox ID="txtloginid" runat="server" placeholder="enter id please to whome you want to send"></asp:TextBox>
                                    <asp:Button ID="btnsubmitloginid" runat="server" CssClass="btnsubmitforemployeepanel" Text="Go" />
                                </td>
                            </tr>
                        </table>
                        <label id="lblmessage" style="font-weight: bold; margin-left: 125px; color: red; margin-top: 10px"></label>
                        <table class="table" style="width: 100%; border: 3px solid #8F4949 !important; display: none" id="tblprofiledemo">
                            <tr>
                                <td class="t1"><span></span></td>
                                <td class="t2">
                                    <asp:ImageButton ID="imgbuttonforidentify" runat="server" ImageUrl="~/images/doll.jpg" Style="border: 2px solid #323641 !important" />
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span>Name:</span></td>
                                <td class="t2">
                                    <label id="lblname">Amit Kumar Sharma</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span>Type:</span></td>
                                <td class="t2">
                                    <label id="lbltype">Parent</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span>Mobile:</span></td>
                                <td class="t2">
                                    <label id="lblmobile">7827739166</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span></span>
                                </td>
                                <td class="t2">
                                    <asp:Button ID="btncontinue" runat="server" CssClass="btnsubmitforemployeepanel" Text="Continue" Style="width: 70px !important; display: none" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sendsmsormessage" style="display: none">
                        <table class="table" style="width: 100%; border: 3px solid #8F4949 !important">
                            <tr>
                                <td class="t1"><span>Subject Please:</span></td>
                                <td class="t2">
                                    <asp:TextBox ID="txtsubject" runat="server" placeholder="enter subject please."></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span>Message To Be Sent:</span></td>
                                <td class="t2">
                                    <asp:TextBox ID="txtmessageforsend" runat="server" placeholder="enter message please." TextMode="MultiLine" Style="height: 150px !important;"></asp:TextBox>
                                </td>
                            </tr>
                            <tr class="trforradio">
                                <td class="t1"><span style="color: #00005F; text-decoration: underline; font-weight: bold">Attechment:</span></td>
                                <td class="t2">
                                    <asp:FileUpload ID="fileuploadattechment" runat="server" Style="border: 3px solid white; width: 300px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="t1"><span></span>
                                </td>
                                <td class="t2">
                                    <asp:Button ID="btnsendmessage" runat="server" CssClass="button_save" Text="Send" Style="width: 70px !important;" />
                                    <asp:Button ID="btncancel" runat="server" CssClass="button_save" Text="Cancel" Style="width: 70px !important;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="sendattachment">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>