<%@ Page Title="Transportation Detail" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="transportdetail.aspx.cs" Inherits="BranchPanel_transportdetail" EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.8.2.min.js"></script>
    <script>
        var monthid = "<%=Session["deactivemonth"].ToString()%>";
    </script>

    <script src="../js/transport-js.js">
    </script>

    <style>
        .active61 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>
    <style type="text/css">
        .web_dialog_overlay {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
            background: #000000;
            opacity: .15;
            filter: alpha(opacity=15);
            -moz-opacity: .15;
            z-index: 101;
            display: none;
        }

        .web_dialog {
            display: none;
            position: fixed;
            width: 380px;
            height: 151px;
            top: 50%;
            left: 50%;
            margin-left: -190px;
            margin-top: -100px;
            background-color: #ffffff;
            border: 2px solid #336699;
            padding: 0px;
            z-index: 102;
            font-family: Verdana;
            font-size: 10pt;
        }

        .web_dialog_title {
            border-bottom: solid 2px #336699;
            background-color: #336699;
            padding: 4px;
            color: White;
            font-weight: bold;
        }

            .web_dialog_title a {
                color: White;
                text-decoration: none;
            }

        .align_right {
            text-align: right;
        }
    </style>

    <style>
        .lnke {
            background-color: green;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #e2e2e2 !important;
            border-radius: 3px;
            color: black;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
            margin-right: 5px;
            padding: 5px 13px;
            position: unset;
            right: 42px;
            text-decoration: none;
            top: 7px;
        }
    </style>
    <style>
        .addtotrans {
            background-color: green;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #e2e2e2 !important;
            border-radius: 3px;
            color: black;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
            margin-right: 5px;
            padding: 5px 13px;
            position: unset;
            right: 42px;
            text-decoration: none;
            top: 7px;
        }
    </style>
    <style>
        .deactivetrans {
            background-color: green;
            background-image: linear-gradient(to bottom, #49c0f0, #2cafe3);
            border: 1px solid #e2e2e2 !important;
            border-radius: 3px;
            color: black;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
            margin-right: 5px;
            padding: 5px 13px;
            position: unset;
            right: 42px;
            text-decoration: none;
            top: 7px;
        }
    </style>
    <div id="overlay" class="web_dialog_overlay"></div>

    <div id="dialog" class="web_dialog">
        <table style="width: 100%; border: 0px;" cellpadding="3" cellspacing="0">
            <tr>
                <td class="web_dialog_title">
                    <img src="../images/warningicon.png" style="width: 25px;" />
                    Warning Message</td>
                <td class="web_dialog_title align_right">
                    <a href="" id="btnClose">Close</a>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="padding-left: 15px;">&nbsp;
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    &nbsp;
                    &nbsp;
                       <br />
                    <b style="margin-right: 2px">Student will be deactive from transport since </b>
                    <br />
                    <br />
                    <b>
                        <asp:Label ID="lbl12" runat="server" CssClass="lblmess"></asp:Label></b>
                    <br />
                    <br />
                    <b>Are you sure to Deactive this Student From Transport ? </b>
                </td>

                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;">

                        <asp:Button ID="btnsave" runat="server" Text="OK" CssClass="button_save1" class="confirm" />
                        <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="view-enquiry1" />
                    </td>
                </tr>
        </table>
    </div>
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="">Transportation Detail</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="Div1">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div id="divstudentadno1"></div>

        <div id="Container"></div>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:Button ID="lnkid" runat="server" Text="Show previous History" placeholder="Click here to show orevious history" CssClass="lnke" Style="display: none;"></asp:Button>
        <asp:Button ID="btnaddtotrans" runat="server" Text="transport allotment" placeholder="click here to add transport to the student" CssClass="addtotrans" Style="display: none; margin-left: 165px; margin-top: -32px;"></asp:Button>
        <asp:Button ID="btnactive" runat="server" Text="Back" CssClass="addtotrans" Style="display: none; float: right; margin-top: -29px"></asp:Button>
        <asp:Button ID="btndeactive" runat="server" Text="Deactive Now" placeholder="click here to deactive candidate from transport" CssClass="deactivetrans" Style="display: none; float: left; margin-top: -29px; margin-left: 313px; margin-top: -34px;"></asp:Button>

        <div id="p1" class="maindivpopup" style="display: none;">
            <asp:Panel ID="popup2" runat="server" BackColor="White" Height="275px" Width="500px"
                Style="z-index: 9000000; background-color: White; position: absolute; left: 20%; top: 15%; border: outset 2px #2CA8C2; padding: 5px; display: none;">
                <table width="100%" style="width: 100%; height: 100%; border: 1px solid #2CA8C2;" cellpadding="0" cellspacing="5">
                    <tr style="background-color: #2CA8C2;">
                        <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                            align="center">Add Student To Bus
                        </td>
                    </tr>

                    <tr>
                        <td align="right" style="width: 45%">Name:
                        </td>
                        <td>
                            <asp:Label ID="lblID1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">ADNO:
                        </td>
                        <td>
                            <asp:Label ID="lblbooktitle1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Class:
                        </td>
                        <td>
                            <asp:Label ID="tofine1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select locality/Sector:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Block/Society:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Bus:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:Label ID="lbmssg" runat="server" Style="display: none;"></asp:Label>
                            <asp:Label ID="lbseatmsg" runat="server" Style="display: none;"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Stoppage:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="Button3" CssClass="button_save" Text="Update" runat="server" />
                            <asp:Button ID="button4" class="btnClose" CssClass="button_cancel" runat="server" Text="Cancel" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>

        <div id="divdeactive"></div>
    </div>
</asp:Content>