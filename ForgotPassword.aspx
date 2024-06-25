<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta name="GENERATOR" content="Evrsoft First Page" />
    <title><%=ConfigurationManager.AppSettings["titleBar"].ToString() %></title>
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

        /*body {
            font-size: 12px;
            background: #fff;
            text-align: center;
            font-family: Arial, Helvetica, sans-serif;

        }*/
        /* // base */
        /* login form */

        .main_login {
            /*height: 400px;*/
            width: 600px;
            position: absolute;
            top: 58%;
            left: 50%;
            margin-left: -300px;
            margin-top: -350px;
        }

        .button {
            background: url(images/greenbg.png) repeat-x scroll right center transparent;
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
            background: none repeat scroll 0 0 #FFFFFF;
            border: 8px solid #E7E7E7;
            border-radius: 5px 0 5px 5px;
            box-shadow: 0 0 10px #4E707C;
            margin: 100px auto;
            position: relative;
            text-align: left;
            width: 500px;
        }

            #login a, #login a:visited {
                color: #0283b2;
            }

                #login a:hover {
                    color: #111;
                }

            #login h1 {
                background: #8CBF26;
                color: #fff;
                text-shadow: #007dab 0 1px 0;
                font-size: 14px;
                padding: 10px 8px;
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
            width: 260px;
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

        .button2 {
            background: url("images/redbg.png") repeat-x scroll right center rgba(0, 0, 0, 0);
            border: 1px solid #F4AB4C;
            color: #FFFFFF;
            height: 34px;
            margin-bottom: 10px;
            margin-left: 1%;
            margin-right: 8px;
            text-shadow: 0 1px rgba(255, 255, 255, 0.3);
            width: 100px;
        }

        .headerlogin {
            width: 100%;
            height: 100px;
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
        /* // login form */
    </style>
</head>
<body style="background: #ddd; width: 100%; height: 100%; text-align: center; z-index: -1;">
    <%--<img src="images/playbg2.jpg" style="width: 100%; position: relative; text-align: center; z-index: -1;" />--%>

    <div class="main_login" style="height: 300px">
        

        <form id="login" method="post" runat="server">

            <h1><a href="Login.aspx"></a></h1>
            <p class="register">Forgot Password</p>
            <div class="bt">
                <label for="login_username">Enter UserName</label>
                <asp:TextBox ID="UserName" runat="server" class="field required"
                    title="Please provide your username" OnTextChanged="UserName_TextChanged"></asp:TextBox>
            </div>
            <div class="bt">
                <label for="login_mobile">Enter Mobile No</label>
                <asp:TextBox ID="Mobile" runat="server" class="field required" title="Mobile No is required"></asp:TextBox>
            </div>

            <div id="pwd" runat="server" visible="false">
                <div class="bt">
                <label for="login_mobile">Enter New Password</label>
                <asp:TextBox ID="txtpwd" runat="server" class="field required" title="Mobile No is required" TextMode="Password"></asp:TextBox>
            </div>
                <div class="bt">
                <label for="login_mobile">Retype New Password</label>
                <asp:TextBox ID="cpwd" runat="server" class="field required" title="Mobile No is required" TextMode="Password"></asp:TextBox>
            </div>
            </div>

            <div class="submit">
                <asp:Button ID="SearchButton" runat="server" CssClass="button_save" Text="Sumbit" 
                    OnClick="SearchButton_Click1" />
                <asp:Button ID="Button1" runat="server" CssClass="button_save" Text="Sumbit" Visible="false"
                    OnClick="SearchButton_Click" />

                &nbsp;

                <asp:Button ID="cancelButton" runat="server" CssClass="button2" Text="Cancel" onclick="dfds_Click"  />

&nbsp;&nbsp;
                <br />
                <asp:Label runat="server" ID="lblMsg" Text="" ForeColor="Red"></asp:Label><br />
                <a id="alogin" runat="server" visible="false" href="login.aspx">Password Change Successfully ! click here to login</a>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <asp:Label runat="server" ID="lblPassword" Visible="false" ForeColor="Red"></asp:Label>
                <asp:Label runat="server" ID="lblEmail" Visible="false" ForeColor="Red"></asp:Label>

                &nbsp;
            </div>
        </form>
    </div>
</body>
</html>