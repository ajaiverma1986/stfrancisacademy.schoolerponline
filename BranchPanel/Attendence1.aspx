<%@ Page Title="Attendance Register" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="Attendence1.aspx.cs" Inherits="BranchPanel_Attendence1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px; width: 33px;">Home</a></li>
            <li><a href="#">Student Attendance</a></li>
            <li style="background: none;"><a class="active" href="#">Attendance Register</a></li>
        </ul>
       <%-- <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="containerHeadline" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;">
            Student Attendance
        </div>
        <br />
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Select Class<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLClass" runat="server" OnSelectedIndexChanged="DDLClass_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Section<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLSection_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Month & Date<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLMonth" runat="server" Width="125px" AutoPostBack="True" OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;
                     <asp:DropDownList ID="ddldays" runat="server" Width="80px"
                         AutoPostBack="True" OnSelectedIndexChanged="ddldays_SelectedIndexChanged">
                     </asp:DropDownList>
                    <asp:TextBox ID="txtDAyname" runat="server" Width="80px" ReadOnly="true"></asp:TextBox>
                </div>
                <br />
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <div style="margin-top: 15px;">
                    <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">

                        <tr id="tr1" runat="server" style="background: #33ccff;">
                            <td class="stm_head2" style="width: 8%; padding-left: 10px; color: #ffffff;">
                                <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                            </td>
                            <td class="stm_head2" style="width: 12%; padding-left: 10px; color: #ffffff;">
                                <asp:Label ID="Label3" runat="server">Mark For Absent</asp:Label>
                            </td>
                            <%-- <td  class="stm_head2" style="width: 12%; padding-left: 10px;">
                            <asp:CheckBox ID="chkall" runat="server"
                                AutoPostBack="true" oncheckedchanged="chkall_CheckedChanged" />
                        </td>--%>
                            <td style="padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="lblhead" runat="server">Student Nmae</asp:Label>
                            </td>
                            <td style="width: 12%; padding-left: 10px; color: #ffffff; font-weight: bold;">
                                <asp:Label ID="Label2" runat="server">Status</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="border-bottom: 1px solid #ddd;">
                                <asp:GridView ID="GrdAttendence" AutoGenerateColumns="false" ShowHeader="false" Width="100%"
                                    BorderWidth="0" runat="server" GridLines="None" CssClass="stm">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="8%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkclass" Checked='<%#Eval("attendance") %>' AutoPostBack="true" OnCheckedChanged="chkclass_CheckedChanged" runat="server" />
                                                &nbsp;<asp:Label ID="lbmssg" runat="server" ForeColor="Red"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                                <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("adid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblstatus" runat="server" Text='<%# Bind("state") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="for_sigle_row_form">
                    <%--<label>
                </label>--%>
                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>

                    <br />
                    <label>
                    </label>
                    <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="button_save" OnClick="btnSubmit_Click" />
                </div>

                <div class="for_sigle_row_form">
                    <label style="margin-left: 130px;">

                        <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="button_save"
                            OnClick="btnBack_Click1" />
                </div>
                </label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>