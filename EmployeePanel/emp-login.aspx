<%@ Page Language="C#" AutoEventWireup="true" CodeFile="emp-login.aspx.cs" Inherits="LoginT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head id="Head1" runat="server">
    <meta name="GENERATOR" content="Evrsoft First Page" />
    <title>Student Login</title>
    <link rel="shortcut icon" href="images/favicon.ico" />
    <meta name="description" content="" />
    <style>
        input.text {
            margin-bottom: 12px;
            width: 95%;
            padding: .4em;
        }

        fieldset {
            padding: 0;
            border: 0;
            margin-top: 25px;
        }

        body {
            font-size: 12px;
            background: #323641;
            text-align: center;
            font-family: Arial, Helvetica, sans-serif;
            background: url(images/bg-default1.png);
        }

        .main_login {
            height: 400px;
            width: 600px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -300px;
            margin-top: -350px;
        }

        .button {
            background: none repeat scroll 0 0 #82403b;
            border: 1px solid #83b522;
            color: #ffffff;
            text-shadow: 0 -1px rgba(0,0,0,0.3);
            text-decoration: none;
            width: 100px;
            height: 34px;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .button1:hover {
            box-shadow: inset 0 1px rgba(255,255,255,0.3), inset 0 20px 40px rgba(255,255,255,0.15);
            background: url(images/greenhover.png) repeat-x scroll right center transparent;
            height: 30px;
        }

        #login {
            margin: 5em auto;
            background: #fff;
            border: 8px solid #E7E7E7;
            width: 500px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px 0px 5px 5px;
            -moz-box-shadow: 0 0 10px #4e707c;
            -webkit-box-shadow: 0 0 10px #4e707c;
            box-shadow: 0 0 10px #4e707c;
            text-align: left;
            position: relative;
            margin: 100px auto;
        }

            #login a, #login a:visited {
                color: #0283b2;
            }

                #login a:hover {
                    color: #111;
                }

            #login h1 {
                background: #82403B;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                font-size: 14px;
                padding: 10px 8px;
                margin: 0 0 1.5em 0;
            }

        .button {
        }

        #login .register {
            position: absolute;
            float: left;
            margin: 0;
            line-height: 30px;
            top: -36px;
            right: 0px;
            background: #82403B;
            padding: 3px 10px;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            border-radius: 4px 4px 0px 0px;
            position: absolute;
            font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
        }

        #login p {
            margin: .5em 25px;
        }

        #login div {
        }

        .bt {
            background: none repeat scroll 0 0 #EEEEEE;
            border-radius: 3px 3px 3px 3px;
            margin: 0.5em 25px;
            padding: 4px;
            position: relative;
            text-align: right;
        }

        #login label {
            float: left;
            line-height: 30px;
            padding-left: 10px;
        }

        #login .field {
            border: 1px solid #ccc;
            width: 280px;
            font-size: 12px;
            line-height: 1em;
            padding: 8px;
            -moz-box-shadow: inset 0 0 5px #ccc;
            -webkit-box-shadow: inset 0 0 5px #ccc;
            box-shadow: inset 0 0 5px #ccc;
        }

        #login div.submit {
            background: none;
            margin: 1em 25px;
            text-align: left;
        }

            #login div.submit label {
                float: none;
                display: inline;
                font-size: 11px;
            }

        #login .forgot {
            text-align: right;
            font-size: 11px;
        }

        #login .back {
            padding: 1em 0;
            border-top: 1px solid #eee;
            text-align: right;
            font-size: 11px;
        }

        #login .error {
            float: left;
            position: absolute;
            left: 95%;
            top: -5px;
            background: #890000;
            padding: 5px 10px;
            font-size: 11px;
            color: #fff;
            text-shadow: #500 0 1px 0;
            text-align: left;
            white-space: nowrap;
            border: 1px solid #500;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            -moz-box-shadow: 0 0 5px #700;
            -webkit-box-shadow: 0 0 5px #700;
            box-shadow: 0 0 5px #700;
        }
    </style>
    <script src="js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#LoginButton').click(function () {
                var tempstatus = 0;
                if ($('#UserName').val() == "") {
                    $('#UserName').css("border", "1px solid red");
                    tempstatus = 1;
                }
                if ($('#Password').val() == "") {
                    $('#Password').css("border", "1px solid red");
                    tempstatus = 1;
                }
                if (tempstatus == 1) {
                    $('#lblMsg').html('Please Fill Red Marked Field.');
                    return false;
                }
            });
            $('#UserName').click(function () {
                $('#UserName').css("border", "1px solid #8CBF26");
                $('#lblMsg').html('');
            });

            $('#Password').click(function () {
                $('#Password').css("border", "1px solid #8CBF26");
                $('#lblMsg').html('');
            });

        });
    </script>
</head>
<body>
    <div class="main_login" style="height: 300px">
        <form id="login" method="post" runat="server">
            <h1>
                <img src="images/logo.png">
            </h1>
            <p class="register">
                Login Here
            </p>
            <div id="divLogin" runat="server">
            <div class="bt">
                <label for="login_username">
                    Username</label>
                <asp:TextBox ID="UserName" runat="server" class="field required" placeholder="Enter Username"></asp:TextBox>
            </div>
            <div class="bt">
                <label for="login_password">
                    Password</label>
                <asp:TextBox ID="Password" runat="server" class="field required" TextMode="Password"
                    placeholder="Enter Password"></asp:TextBox>
            </div>
                </div>
             <div class="bt" id="divOtp" runat="server">               
                 <asp:Label ID="lblOtp" runat="server" Text="Label">OTP</asp:Label>
                <asp:TextBox ID="txtOtp" runat="server" class="field required" placeholder="Enter Opt"></asp:TextBox>
            </div>
            <div class="submit">
                <asp:Button ID="LoginButton" runat="server" CssClass="button" Text="Log in" OnClick="LoginButton_Click1" />
                <asp:Button ID="btnOtp" runat="server" CssClass="button" Text="Submit" OnClick="btnOtp_Click" />
                <asp:Label runat="server" ID="lblMsg" Text="" Style="color: Red; font-size: 15px; font-weight: bold; margin-left: 30px !important;"></asp:Label>
                <a href="#">Forget password ?</a>
            </div>
        </form>
    </div>
</body>
</html>