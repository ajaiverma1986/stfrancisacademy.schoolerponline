<%@ Page Title="Create Stopage " Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="createStopage.aspx.cs" Inherits="BranchPanel_createStopage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Route List</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            <b>Create Stopage </b>
        </div>

        <style type="text/css">
            .divContent {
                background-color: White;
                padding: 30px 30px 30px 30px;
                min-height: 800px;
            }

            .tblRectangleBorder {
                font-family: Arial,Helvetica,sans-serif;
                background-color: White;
                color: Black;
                -webkit-box-shadow: 0px 0px 1px 4px #fafafa;
                -moz-box-shadow: 0px 0px 1px 4px #F8A88D;
                box-shadow: 0 0 10px #D0D0D0 inset;
                border-radius: 7px;
                padding: 30px 20px 30px 20px;
                align: center;
            }

            .firstTD {
                margin-bottom: -0.75em;
                margin-top: -0.2em;
                height: auto;
                font-family: Arial,Helvetica,sans-serif;
                font-size: 14px;
                font-weight: normal;
                padding: 0px 0px 0px 20px;
                color: #1C6099;
                font-weight: normal;
                padding-right: 15px;
            }

            .secondTD {
                font-size: 14px;
                font-family: Arial,Helvetica,sans-serif;
                text-align: left;
                padding-left: 20px;
            }

            .ddl {
                margin-top: 5px;
                height: 29px;
                margin: 10 0 5px;
                padding: 5px;
                width: 243px;
                border-radius: 4px;
                margin-top: 7px;
            }

            .file_border {
                border: 1px solid #9A9A9A;
                border-radius: 3px;
                width: 150px;
                height: 28px;
                margin-top: 7px;
            }

            .aspButton {
                border: 1px solid #ff6262;
                -webkit-border-radius: 3px;
                -moz-border-radius: 3px;
                border-radius: 3px;
                font-size: 15px;
                font-family: arial, helvetica, sans-serif;
                padding: 3px 8px;
                text-decoration: none;
                display: inline-block;
                text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
                font-weight: bold;
                color: #FFFFFF;
                background-color: #ff3434;
                background-image: linear-gradient(to bottom, #ff9a9a, #ff4040);
            }

            .style1 {
                margin-bottom: -0.75em;
                margin-top: -0.2em;
                height: 26px;
                font-family: Arial,Helvetica,sans-serif;
                font-size: 14px;
                font-weight: normal;
                color: #1C6099;
                font-weight: normal;
                padding-right: 15px;
                padding-left: 20px;
                padding-top: 0px;
                padding-bottom: 0px;
            }

            .style2 {
                font-size: 14px;
                font-family: Arial,Helvetica,sans-serif;
                text-align: left;
                padding-left: 20px;
                height: 26px;
            }
        </style>

        <br />

        <div class="clear">
        </div>
        <div class="content_pane_cont input_content" id="contentPane">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                class="containerHeadline">
                Create Bus Stop
            </div>
            <br />
            <table style="width: 80%; margin-right: 20px;">
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Route No:
                            </label>
                            <asp:Label ID="lblroute" runat="server"></asp:Label>
                        </div>
                    </td>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Origin:
                            </label>
                            <asp:Label ID="lblorigin" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Destination:
                            </label>
                            <asp:Label ID="lbldestination" runat="server"></asp:Label>
                        </div>
                    </td>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Route Length:
                            </label>
                            <asp:Label ID="lbldist" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>

            <br />
            <br />
            <div class="for_sigle_row_form">
                <label>
                    Enter Number of Bus Stops<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtstops" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter stopage"
                    ControlToValidate="txtstops" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>
</asp:Content>