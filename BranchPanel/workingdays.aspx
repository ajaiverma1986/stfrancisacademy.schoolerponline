<%@ Page Title="Working Days" Language="C#" AutoEventWireup="true" CodeFile="workingdays.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master"
    Inherits="BranchPanel_workingdays" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Time Table</a></li>
            <li style="background: none;"><a class="active" href="#">Working Days </a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Working Days
        </div>

        <table style="width: 100%">

            <tr>
                <td style="width: 100%" valign="top" align="center">
                    <%-- <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
                            <ProgressTemplate>
                                <img src="../images/i_animated_loading_32_2.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>--%>

                    <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
                        <ProgressTemplate>
                            <div style="position: absolute; top: 300px; left: 568px; z-index: 500px;">
                                <span>
                                    <asp:Label ID="lblWaiting1" runat="server" ForeColor="Red" Style="font-size: 11px;"
                                        Text="Please Wait..." Height="15px" Width="100px"></asp:Label>
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td style="width: 100%;" valign="top" align="center">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridStateDetail" GridLines="Horizontal"
                                runat="server" AutoGenerateColumns="False"
                                PageSize="20"
                                Width="50%" OnRowDataBound="GridStateDetail_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>

                                            <div class="branchbox">
                                                <div class="mailbox_text">
                                                    <h5>Day Name</h5>
                                                    <h5>Full Day</h5>
                                                    <h5>Half Day</h5>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <div class="branchbox">
                                                <div class="mailbox_text">
                                                    <h5 style="padding-left: 20px">
                                                        <asp:Label ID="lbldayname" runat="server" Text='<%# Eval("dayname") %>' ForeColor="Black"></asp:Label></h5>
                                                    <h5 style="width: 225px; padding-left: 10px">
                                                        <asp:RadioButtonList ID="rblday" runat="server" RepeatDirection="Horizontal" Style="width: 225px">
                                                            <asp:ListItem Selected="True"></asp:ListItem>
                                                            <asp:ListItem></asp:ListItem>
                                                        </asp:RadioButtonList></h5>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td>

                    <div class="for_sigle_row_form">
                        <label></label>
                        <asp:Button ID="btnsubmit" runat="server" CssClass="button_save" Text="Submit" Style="margin-left: 66px; margin-top: 18px" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>