<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="MemeberPanel_Login" EnableViewState="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head id="headfirst" runat="server">
    <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
    <script src="js/jquery-1.8.3.min.js"></script>
    <link rel="shortcut icon" type="image/ico" href="../images/favicon.ico " />
    <link rel="stylesheet" href="css/style.default.css" type="text/css" />
    <title>School Management Software</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#LoginButton').click(function () {
                if ($('#UserName').val() == "") {
                    alertify.error('Enter User Name Please');
                    $('#UserName').focus();
                    return false;
                }
                else if ($('#Password').val() == "") {
                    alertify.error('Enter Password Please.');
                    $('#Password').focus();
                    return false;
                }
                else {
                    return true;
                }
            });
            $('#btnthanks').click(function () {
                $('.registerconformation-popup').css("display", "none");
                return false;
            });
        });
    </script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-112013300-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag() { dataLayer.push(arguments); }
        gtag('js', new Date());

        gtag('config', 'UA-112013300-1');
    </script>

</head>
<body class="loginpage">
    <div class="loginbox">
        <div class="loginboxinner">
            <div class="logo">
                <%--<h1>Login here
                </h1>--%>
                <asp:Image ID="logo" runat="server" Width="50" Height="50" AlternateText="Login here" />
            </div>
            <form id="login" method="post" runat="server">
                <asp:ScriptManager ID="ScriptManager2" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="updatepanelone" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:Panel ID="Panelotp" runat="server">
                            <div class="username">
                                <div class="usernameinner">
                                    <asp:TextBox ID="UserName" runat="server" AutoCompleteType="Disabled" autocomplete="off" class="field required" placeholder="Enter Username" title="Please provide your username"></asp:TextBox>
                                </div>
                            </div>
                            <div class="password">
                                <div class="passwordinner">
                                    <asp:TextBox ID="Password" runat="server" AutoCompleteType="Disabled" TextMode="Password" autocomplete="off" CssClass="field required colorblkack" placeholder="Enter Password" title="Password is required" MaxLength="20"></asp:TextBox>
                                </div>
                            </div>
                            <asp:Button ID="LoginButton" runat="server" Text="Sign In" OnClick="LoginButton_Click" />
                            <asp:Label runat="server" ID="lblMsg" Text="" ForeColor="Red"></asp:Label>
                        </asp:Panel>
                        <asp:Panel ID="Panellogin" runat="server" DefaultButton="btnotpsend" Style="display: block">
                            <div class="password">
                                <div class="passwordinner">
                                    <asp:TextBox ID="txtotp" runat="server" AutoCompleteType="Disabled" class="field required" placeholder="Enter OTP" TextMode="Password"
                                        title="Password is required"></asp:TextBox>
                                </div>
                            </div>
                            <div class="submit" id="divsubmit">
                                <asp:Button ID="btnotpsend" runat="server" CssClass="button_save" Text="Submit" Style="width: 100px" OnClick="btnotpsend_Click" />
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" CssClass="button_save" Style="width: 100px" Text="Cancel" />
                                <asp:Button ID="btnresend" runat="server" CssClass="button_save" Text="Resend OTP" Style="width: 100px" OnClick="btnresend_Click" />
                                <asp:Label runat="server" ID="Label1" Text="" ForeColor="Red"></asp:Label>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="LoginButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnotpsend" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
                <div class="keep"><a href="ForgotPassword.aspx">Forgot Password</a></div>
                <%--<p>Powered by <a href="#" target="_blank">G</a></p>--%>
            </form>
        </div>
    </div>
</body>
</html>
