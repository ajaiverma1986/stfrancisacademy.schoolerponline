<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="SchoolProfile.aspx.cs" Inherits="BranchPanel_Common_SchoolProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
          <style>
        #ctl00_ContentPlaceHolder1_radiobuttonlistformanageotpodp input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonlistformanageotpodp label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ContentPlaceHolder1_radioformailcheck input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radioformailcheck label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonforsmscheck input {
            float: left !important;
            width: 15px !important;
            margin-left: 5px;
        }

        #ctl00_ContentPlaceHolder1_radiobuttonforsmscheck label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        #ctl00_ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        .for_sigle_row_form {
            margin-bottom: 0;
            margin-left: 10%;
            margin-right: auto;
            padding: 5px 0;
            width: 100%;
        }

        .for {
            border-bottom: 1px solid #f5f5f5;
            height: auto;
            margin-bottom: 0;
            margin-left: 842px !important;
            margin-right: auto;
            padding: 5px 0;
            position: absolute;
            width: 250px !important;
            margin-top: 15px;
        }

        #ctl00_ContentPlaceHolder1_rdGender label {
            width: 50px !important;
            padding-top: 0px !important;
        }

        .textfocus {
            border: solid 1px #99cc00 !important;
            box-shadow: 0 0 5px 1px #bce0fe !important;
            color: black;
            background-color: white !important;
        }

        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }

        #result {
            margin-left: 5px;
        }

        #divforpassword .short {
            color: #FF0000;
        }

        #divforpassword .weak {
            color: #E66C2C;
        }

        #divforpassword .good {
            color: #2D98F3;
        }

        #divforpassword .strong {
            color: #006400;
        }
        .txtrePassstregthtooshortdiv, .txtrePassstregthweakdiv, .txtrePassstregthgooddiv, .txtrePassstregthstrongdiv, .txtPassstregthtooshortdiv, .txtPassstregthweakdiv, .txtPassstregthgooddiv, .txtPassstregthstrongdiv {
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
  <div class="content_pane_cont" id="contentPane">
        <div class="cheadline1" style="width: 100%; margin-left: 0px">
            <span class="spanheading">User Detail</span>
        </div>
        <div class="clear">
        </div>
        <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">

            <table style="width: 100%; border-right: 1px solid #DDDDDD; margin-top: 10px;">

                <tr>
                    <td>
                        <div class="for">
                            <label>
                            </label>
                            <asp:ImageButton ID="img" Style="display: block" ImageUrl="~/images/9update.png" Height="150" Width="130" runat="server" Enabled="false" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form" id="divsponserid" runat="server">
                            <label>
                                Sponser ID</label>
                            <asp:TextBox ID="txtsponserid" runat="server" placeholder="Enter Sponser Id" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr style="display: none">
                    <td>
                        <div class="for_sigle_row_form" id="divforupdate" runat="server">
                            <label>
                                Reference No/Employee Code</label>
                            <asp:TextBox ID="txtrefno" placeholder="Reference No." runat="server" MaxLength="10" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Name<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtFName" runat="server" PlaceHolder="First Name" Style="" ReadOnly="true"></asp:TextBox>&nbsp                           
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Gender<%--<span style="color: #ff0066">*</span>--%></label>
                            <div style="width: 300px; border: 1px solid; border-color: #ccc; margin-left: 170px; height: 24px; padding-top: 3px">
                                <asp:RadioButtonList ID="rdGender" runat="server" RepeatDirection="Horizontal" Width="200" ReadOnly="true">
                                    <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                    <asp:ListItem Value="2">Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Address Line <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtaddress" placeholder="Address Line " runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                City<%--<span style="color: Red;">*</span>--%>
                            </label>

                            <asp:TextBox ID="txtcity" runat="server" placeholder="Enter City Name Please" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                State<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtstate" runat="server" placeholder="Enter State Name Please" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                PIN Code<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtPinCode" placeholder="PIN Code" runat="server" MaxLength="6" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Country<%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtcountry" runat="server" placeholder="Enter Country Name Please" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Mobile No. <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtmobile" placeholder="Mobile No." runat="server" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Email ID <%--<span style="color: Red;">*</span>--%></label>
                            <asp:TextBox ID="txtemailaddress" placeholder="E-mail ID" runat="server" Style="text-transform: none!important" ReadOnly="true"></asp:TextBox>
                        </div>
                    </td>
                </tr>               
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Login ID<span style="color: Red;">* </span>
                            </label>
                            <asp:TextBox ID="txtUserName" placeholder="Login ID" runat="server" Style="text-transform: none!important" MaxLength="8" ReadOnly="true"></asp:TextBox>&nbsp&nbsp
                        </div>
                    </td>
                </tr>           
                <tr>
                    <td>
                        <div id="divforradio" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Dual Authentication</label>
                                <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 300px;">
                                    <asp:RadioButtonList ID="radiobuttonlistformanageotpodp" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="1">OTP</asp:ListItem>
                                        <asp:ListItem Value="2">ODP</asp:ListItem>
                                        <asp:ListItem Value="3" Selected="True">NONE</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form tractivewhenotpodtselected" style="display: none" id="divforsendemail" runat="server">
                            <label style="padding-top: 1px;" id="lblotpotpemail">
                                Email OTP/ODP<span style="color: #ff0066">*</span></label>
                            <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 353px;">
                                <asp:RadioButtonList ID="radioformailcheck" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                    <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form tractivewhenotpodtselected" style="display: none" id="divforsendsms" runat="server">
                            <label style="padding-top: 1px;" id="lblotpotpsms">
                                Sms OTP/ODP</label>
                            <div style="border: 1px solid #ccc; height: 24px; margin-left: 170px; padding-top: 3px; width: 353px;">
                                <asp:RadioButtonList ID="radiobuttonforsmscheck" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                    <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="trforip">
                    <td>
                        <div id="divforidentifyuserbyIp" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Identify User by IP</label>
                                <input type="text" class="txtipforlogin" placeholder="Enter The IP Address Please" />
                                <input type="checkbox" class="chkforip" />
                                <img class="imgforaddip" alt="No Image" style="width: 16px; cursor: pointer; margin-top: -6px" src="../../images/add.png" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="trformac">
                    <td>
                        <div id="divforidentifyuserbymac" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Identify User by MAC</label>
                                <input type="text" class="txtmacforlogin" placeholder="Enter The MAC Address Please" />
                                <input type="checkbox" class="chkformac" />
                                <img class="imgfroaddmac" alt="No Image" style="width: 16px; cursor: pointer; margin-top: -6px" src="../../images/add.png" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divforactive" runat="server">
                            <div class="for_sigle_row_form">
                                <label style="padding-top: 1px;">
                                    Active</label>
                                <asp:CheckBox ID="chkActive" runat="server" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label><asp:Button ID="lbtngotolist" runat="server" Text="Cancel" CssClass="button2" OnClick="lbtngotolist_Click" />
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
        <asp:HiddenField ID="hfforipaddress" runat="server" />
        <asp:HiddenField ID="hfformacaddress" runat="server" />
    </div>
</asp:Content>

