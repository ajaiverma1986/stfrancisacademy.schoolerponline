<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master"
    CodeFile="markslist.aspx.cs" Inherits="BranchPanel_Exam_markslist" %>

<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active1 {
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
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <%--  <li><a href="#"></a></li>--%>
            <li style="background: none;"><a class="active" href="#">Marks List</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="clear">
        </div>
        <div class="clear">
        </div>
        <asp:GridView ID="GrdAttendence" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
            runat="server" CssClass="stm0" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderText="S.No">
                    <ItemTemplate>
                        <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="8%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Roll No">
                    <ItemTemplate>
                        <asp:Label ID="lblrollno" runat="server" Text='<%# Bind("adno") %>'></asp:Label>
                        <asp:HiddenField ID="HD2" runat="server" Value='<%# Bind("admiid") %>' />
                    </ItemTemplate>
                    <ItemStyle Width="20%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Student Name">
                    <ItemTemplate>
                        <asp:Label ID="lblname" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="30%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mark">
                    <ItemTemplate>
                        <asp:UpdatePanel ID="upd1" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtmarks" runat="server" AutoPostBack="true" Text='<%# Bind("marks") %>'
                                    onFocus="if(this.value=='0') this.value='';" onBlur="if(this.value=='') this.value='0';" OnTextChanged="txtmarks_TextChanged"></asp:TextBox>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </ItemTemplate>
                    <ItemStyle Width="30%" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
        </asp:GridView>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
            <label>
            </label>
            <asp:Button ID="btnSubmit" runat="server" Text="Save Result" CssClass="button_save"
                OnClick="btnSubmit_Click" />&nbsp;
        </div>
    </div>
</asp:Content>