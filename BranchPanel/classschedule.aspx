<%@ Page Title="Class Schedule" Language="C#" AutoEventWireup="true" CodeFile="classschedule.aspx.cs" Inherits="BranchPanel_classschedule"
    MasterPageFile="~/BranchPanel/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #ctl00_ContentPlaceHolder1_GridStateDetail_ctl03_rblday label {
            display: none;
        }

        .style1 {
            height: 38px;
        }
    </style>
    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Time Table</a></li>
            <li><a href="#">View Timetable</a></li>
            <li style="background: none;"><a class="active" href="#">
                <asp:Label runat="server" ID="lblhead" Text="Class Time Table"></asp:Label></a></li>
        </ul>
        <%--  <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Class Timetable" CssClass="button_save"
        ToolTip="Click here to view Class timetable." OnClick="btn1_Click" />

    <asp:Button ID="btn2" runat="server" Text="Teacher Timetable"
        CssClass="button_save" ToolTip="Click here to view teacher timetable."
        OnClick="btn2_Click" />

    <div class="content_pane_cont input_content" id="divscheduletime" runat="server">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Class Time Table
        </div>
        <table width="100%">
            <tr>
                <td align="center">
                    <%--<asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="update">
                        <ProgressTemplate>
                            <img src="../images/i_animated_loading_32_2.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
                    <asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="update">
                        <ProgressTemplate>
                            <div style="position: absolute; top: 195px; left: 568px; z-index: 500px;">
                                <span>
                                    <asp:Label ID="lblWaiting" runat="server" ForeColor="Red" Style="font-size: 11px;"
                                        Text="Please Wait..." Height="15px" Width="100px"></asp:Label>
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="update" runat="server">
                        <ContentTemplate>
                            <div class="for_sigle_row_form">
                                <label>
                                    Select Class
                                </label>
                                <asp:DropDownList ID="ddlwithsection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlwithsection_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="for_sigle_row_form">
                                <label>
                                    Section</label>
                                <asp:DropDownList ID="ddlsection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100%" valign="top" align="center">
                    <%-- <asp:UpdateProgress ID="UpdateProgress6" runat="server" AssociatedUpdatePanelID="updatepanelscheduletime">
                        <ProgressTemplate>
                            <img src="../images/i_animated_loading_32_2.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
                    <asp:UpdateProgress ID="UpdateProgress6" runat="server" AssociatedUpdatePanelID="updatepanelscheduletime">
                        <ProgressTemplate>
                            <div style="position: absolute; top: 316px; left: 478px; z-index: 500px;">
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
                <td>
                    <asp:UpdatePanel ID="updatepanelscheduletime" runat="server" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <table width="100%" id="grdtable" runat="server" visible="false">
                                <tr>
                                    <td>
                                        <%--<div style="border-bottom: none; border-right: none;">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="time_table_design ">
                                                <tr style="background: #33CCFF; height: 36px; font-size: 14px; color: #fff; font-weight: bold;
                                                    line-height: 36px;">
                                                    <td width="12.5%">
                                                        Periods
                                                    </td>
                                                    <td width="12.5%">
                                                        Timming
                                                    </td>
                                                    <td>
                                                        Monday
                                                    </td>
                                                    <td width="12.5%">
                                                        Tuesday
                                                    </td>
                                                    <td width="12.5%">
                                                        Wednesday
                                                    </td>
                                                    <td width="12.5%">
                                                        Thursday
                                                    </td>
                                                    <td width="12.5%">
                                                        Friday
                                                    </td>
                                                    <td width="12.5%">
                                                        Saturday
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>--%>
                                        <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                                            <tr>
                                                <td>

                                                    <asp:GridView ID="grdscheduletime" runat="server" GridLines="None" AutoGenerateColumns="false" CellPadding="0" HeaderStyle-Height="30px" CssClass="stm" Width="100%" BorderWidth="0">

                                                        <Columns>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Periods</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblperiod" Text='<%#Eval("period") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Timming</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lbltime" Text='<%#Eval("time") %>' runat="server"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Monday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject1" runat="server" Text="N/A"></asp:Label>
                                                                    <asp:Label ID="ddlTeacher1" runat="server" Text="N/A"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Tuesday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject2" runat="server" Text="N/A"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="ddlTeacher2" runat="server" Text="N/A"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Wednesday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject3" runat="server" Text="N/A"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="ddlTeacher3" runat="server" Text="N/A"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Thursday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject4" runat="server" Text="N/A"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="ddlTeacher4" runat="server" Text="N/A"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Friday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject5" runat="server" Text="N/A"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="ddlTeacher5" runat="server" Text="N/A"></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="lblsnox1" runat="server"> Saturday</asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="ddlSubject6" runat="server" Text="N/A"></asp:Label>
                                                                    <br />
                                                                    <asp:Label ID="ddlTeacher6" runat="server" Text="N/A"></asp:Label>
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
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlsection" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div class="content_pane_cont" id="contentPanedf" runat="server" visible="false">
        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="false"
            ShowSummary="False" ValidationGroup="g1" />
    </div>
</asp:Content>