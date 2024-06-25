<%@ Page Title="Add Route" Language="C#" AutoEventWireup="true" CodeFile="AddRoute.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_AddRoute" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Add Route</a></li>
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
            <b>Add Route </b>
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

        <div class="for_sigle_row_form">
            <label>
                Bus No.<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtbusno" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Bus No."
                ControlToValidate="txtbusno" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Area<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtarea" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Area"
                ControlToValidate="txtarea" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Select Zone<span style="color: Red;">* </span>
            </label>
            <asp:DropDownList ID="ddl_Busroot" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
            </asp:DropDownList>&nbsp;
        </div>

        <div class="for_sigle_row_form">
            <label>
                Route No<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtrouteno" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select Zone"
                ControlToValidate="txtrouteno" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Number of Bus Stops<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtstop" runat="server"
                OnTextChanged="txtstop_TextChanged" AutoPostBack="true"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter stop names"
                ControlToValidate="txtstop" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">
            <p style="margin-left: 190px; font-size: 15px">
                <asp:PlaceHolder ID="Area1" runat="server"></asp:PlaceHolder>
            </p>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Road Name<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtroad" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Road name"
                ControlToValidate="txtroad" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <br />

        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                ValidationGroup="g1" />
            <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_save" OnClick="Button1_Click" />
        </div>
    </div>
</asp:Content>