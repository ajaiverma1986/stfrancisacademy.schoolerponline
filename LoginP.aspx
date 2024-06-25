<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginP.aspx.cs" Inherits="LoginP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
    <meta name="GENERATOR" content="Evrsoft First Page" />
    <title>
        <%=ConfigurationManager.AppSettings["titleBar"].ToString() %></title>
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
            background: #d5ffd2;
            text-align: center;
            font-family: Arial, Helvetica, sans-serif;
            background: url(images/bg-default1.png);
            margin: 0;
        }
        /* // base */
        /* login form */

        .main_login {
            height: 400px;
            width: 600px;
            position: absolute;
            top: 58%;
            left: 50%;
            margin-left: -300px;
            margin-top: -350px;
        }

        .button {
            background: url(images/greenbg.png) repeat-x scroll right center transparent;
            background-color: green;
            border: 1px solid #FF8D34;
            color: #ffffff;
            text-shadow: 0 -1px rgba(0,0,0,0.3);
            text-decoration: none;
            width: 100px;
            height: 34px;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .button1:hover {
            box-shadow: inset 0 1px rgba(255,255,255,0.3), inset 0 20px 40px rgba(255,255,255,0.15);
            background: url(images/greenhover.png) repeat-x scroll right center transparent;
            height: 30px;
        }

        .button_save {
            background-color: #E14491;
            background-image: linear-gradient(to bottom, #D15EA1, #E14491);
            border: 1px solid #AC0F5C;
            border-radius: 3px;
            border-radius: 3px;
            color: #FFFFFF;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            height: 33px;
            margin-bottom: 3px;
            margin-right: 5px;
            padding: 5px 13px;
            text-decoration: none;
            text-shadow: 0 -1px rgba(0, 0, 0, 0.3);
        }

            .button_save:hover {
                background-color: #E14491;
                background-image: linear-gradient(to bottom, #E14491, #D15EA1);
                border: 1px solid #AC0F5C;
            }

        #login {
            margin: 5em auto;
            background: #fff;
            border: 5px solid #E7E7E7;
            width: 338px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px 0px 2px 2px;
            -moz-box-shadow: 0 0 5px #4e707c;
            -webkit-box-shadow: 0 0 5px #4e707c;
            box-shadow: 0 0 5px #4e707c;
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
                background: #40b3e7;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                font-size: 20px;
                padding: 6px 8px;
                margin: 0 0 1.5em 0;
            }

            #login .register {
                position: absolute;
                float: left;
                margin: 0;
                line-height: 30px;
                top: -36px;
                right: 0px;
                background: #8CBF26;
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
        /* // login form */

        .headerlogin {
            width: 100%;
            height: 100px;
        }

        #label1 {
            background: #83b844 url('../oye/img/emailicon.png') center no-repeat;
        }

        #label {
            background: #83b844 url('../oye/img/password.png') center no-repeat;
        }

        .dll {
            Width: 281px;
            height: 30px;
            border: 1px solid #46B929;
            /*  box-shadow: 0 0 5px #46B929 inset;*/
            font-size: 15px;
            line-height: 1em;
        }
    </style>
</head>

<body>
    <img src="images/playbg2.jpg" style="width: 100%; height: 100%; position: relative; text-align: center; z-index: -1;" />

    <div class="main_login" style="height: 300px">

        <div class="headerlogin">
            <img src="images/playschoollogo.png" alt="" width="200" />
        </div>

        <form id="login" method="post" runat="server">

            <h1>Login
            </h1>
            <%--<p class="register">
            Login Here</p>--%>
            <div class="bt">
                <label for="Select Here" id="lblselect">
                </label>
                <asp:DropDownList ID="ddlselect" runat="server" class="field required" CssClass="dll">
                    <asp:ListItem Text="Select Category" Value="0" />
                    <asp:ListItem Text="Parent" Value="1" />
                    <asp:ListItem Text="Teacher" Value="2" />
                </asp:DropDownList>
            </div>

            <div class="bt">
                <label for="login_username" id="label1">
                </label>
                <asp:TextBox ID="UserName" runat="server" AutoComplete="off" class="field required" title="Please provide your username" placeholder="Username"></asp:TextBox>
            </div>
            <div class="bt">
                <label for="login_password" id="label">
                </label>
                <asp:TextBox ID="Password" AutoComplete="off" runat="server" class="field required" TextMode="Password"
                    title="Password is required" placeholder="Password"></asp:TextBox>
            </div>
            <p class="forgot">
                <a href="forgotpassword.aspx" id="forgotpass">Forgot your password?</a>
            </p>
            <div class="submit">
                <asp:Button ID="LoginButton" runat="server" CssClass="button_save" Text="Log in" OnClick="LoginButton_Click1" />
                <label>
                    <input type="checkbox" name="remember" id="login_remember" value="yes" />Remember
                my login on this computer
                </label>
                &nbsp;&nbsp;
            <asp:Label runat="server" ID="lblMsg" Text="" ForeColor="Red"></asp:Label><br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label runat="server" ID="Label1" Text="" ForeColor="Red"></asp:Label>
            </div>
        </form>
    </div>
</body>
</html>