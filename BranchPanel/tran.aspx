<%@ Page Title="Area Wise Transport List" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="tran.aspx.cs" Inherits="BranchPanel_tran" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        tr td {
            padding: 3px;
            font-size: 12px;
        }
    </style>

    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a href="#">Transport Management</a></li>
            <li><a href="#">Settings</a></li>
            <li style="background: none;"><a class="active" href="#">Area Wise List </a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; border-top: none; line-height: 36px; padding-top: 0px;"
            class="containerHeadlinenew">
            <b>Area Wise List </b>
        </div>

        <script type="text/javascript">
            function lettersOnly(evt) {
                evt = (evt) ? evt : event;
                var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
           ((evt.which) ? evt.which : 0));
                if (charCode > 32 && (charCode < 65 || charCode > 90) &&
           (charCode < 97 || charCode > 122)) {
                    return false;
                }
                else
                    return true;
            };

            function noAlphabets(event) {
                var charCode = (event.which) ? event.which : event.keyCode
                if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                   && (charCode <= 90))
                    return false;

                return true;
            };
        </script>

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
                border: 1px solid #B5B1B1;
                border-radius: 3px;
                width: 150px;
                height: 28px;
                margin-top: 7px;
                background: rgba(255, 255, 255, 0.94);
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

            .shadow1 {
                -webkit-box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
                -moz-box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
                box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
            }
        </style>
        <br />

        <table class="file_border shadow1" cellpadding="2" cellspacing="0" border="0" style="width: auto; margin-left: 31%; padding: 8px;">
            <tr>
                <td>

                    <b>Route No:</b>

                    <asp:Label ID="lblroute" runat="server"></asp:Label>
                </td>

                <td>

                    <b>Bus No:</b>

                    <asp:Label ID="lblbusno" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>

                    <b>Origin: </b>

                    <asp:Label ID="lblorigin" runat="server"></asp:Label>
                </td>

                <td>

                    <b>Destination: </b>

                    <asp:Label ID="lbldestination" runat="server"></asp:Label>
                </td>
            </tr>

            <tr>
                <td>

                    <b>Route Length(in KM):</b>

                    <asp:Label ID="lbldist" runat="server"></asp:Label>
                </td>

                <td>

                    <b>Number of Bus Stoppage: </b>

                    <asp:Label ID="lblbus" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>

                    <b>No. of Seats: </b>

                    <asp:Label ID="lblmin" runat="server"></asp:Label>
                </td>

                <td>

                    <b>Avail Seats: </b>
                    <asp:Label ID="lblavail" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

        <br />
        <table cellpadding="2" cellspacing="0" border="0" style="width: 102%;">
            <tr>
                <td>
                    <asp:GridView ID="gridviewinventory1" runat="server" EmptyDataText="No data found !" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" CssClass="stm"
                        PagerStyle-Font-Size="15px" GridLines="None" PageSize="100" PagerStyle-HorizontalAlign="Right"
                        Width="102%" Style="margin-left: -4px;">
                        <Columns>
                            <asp:TemplateField HeaderText="Route No." ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text='<%#bind("RouteName")%>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Zone" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblzonename" runat="server" Text='<%#bind("zone")%>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Stoppage Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstopage" runat="server" Text='<% #bind("stopagename")%>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Via(Area)" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblvia" runat="server" Text='<% #bind("area")%>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Road Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblroad" runat="server" Text='<% #bind("roadname")%>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
        </table>

        <div class="for_sigle_row_form" style="margin-left: 38%;">
            <asp:Button ID="btnsubmit" runat="server" Text="Edit Bus Stoppage" CssClass="button_save" Width="120px"
                OnClick="btnsubmit_Click" />

            <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save"
                OnClick="btnsubmit1_Click" />
            <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </div>
</asp:Content>