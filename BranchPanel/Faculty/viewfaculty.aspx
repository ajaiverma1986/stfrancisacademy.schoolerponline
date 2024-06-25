<%@ Page Title="Faculty List" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="viewfaculty.aspx.cs" Inherits="BranchPanel_viewfaculty" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Faculty</a></li>
            <li style="background: none;"><a class="active" href="viewfaculty.aspx">View Faculty</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <%--<iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>--%>
        </div>
    </div>
    <%-- <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                        CausesValidation="false" OnClick="ImageButton1_Click" Height="10px" CssClass="excel"
                        ToolTip="Click here to download Excel sheet" />--%>
    <%-- <asp:Button ID="btnAdd" runat="server" Text="New Faculty" OnClick="btnAdd_Click"
        ToolTip="Click here to add new Faculty" CssClass="button_save" />--%>

    <%--  <asp:UpdatePanel ID="upd444" runat="server">
        <ContentTemplate>--%>

    <div class="content_pane_cont input_content" id="contentPane">

        <asp:UpdatePanel ID="upd444" runat="server">
            <ContentTemplate>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td colspan="10" class="containerHeadline" style="padding-left: 10px;">

                            <div style="float: right; width: 370px;">
                                <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlsearchoption_SelectedIndexChanged">
                                    <asp:ListItem Value="0">Search Items</asp:ListItem>
                                    <asp:ListItem Value="1">Name</asp:ListItem>
                                    <asp:ListItem Value="2">Mobile</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="Textbox1" runat="server" Width="150px" Height="23px"> </asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Go" Height="23px" ToolTip="Click here to search items"
                                    OnClick="Button1_Click" CssClass="view-enquiry" />
                            </div>
                            <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                                Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="2"></asp:ListItem>
                                <asp:ListItem Value="2" Text="5"></asp:ListItem>
                                <asp:ListItem Value="3" Text="10"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td align="left" colspan="11" style="width: 100%; padding: 0px 10px 10px 10px;">
                            <asp:GridView ID="gvDetails" AutoGenerateColumns="false" ShowHeader="false" EmptyDataText="No data found !"
                                GridLines="None" CellPadding="5" runat="server" Width="100%" HeaderStyle-Height="30px"
                                OnRowCommand="gvDetails_RowCommand" OnPageIndexChanging="gvDetails_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="student-photo_frame1">
                                                <div class="student-photo_frame_img">
                                                    <asp:Image runat="server" ID="imgsource" ImageUrl='<%# Eval("photo") %>' />
                                                    <asp:HiddenField ID="hfimage" runat="server" Value='<%# Eval("photo") %>' />
                                                </div>
                                                <div style="float: left;">
                                                    <div class="user-deatils1">
                                                        <asp:LinkButton ID="lbtn3" runat="server" Text='<%# Bind("name") %>' CssClass="swet"
                                                            ToolTip="Click here to Update the Faculty profile." CommandName="ed1" CommandArgument='<%# Bind("eid") %>'></asp:LinkButton>
                                                    </div>
                                                    <div class="clear">
                                                    </div>
                                                    <div class="user-deatils1">
                                                        <dt>Mobile No.</dt>
                                                        <cite>:</cite> <span>
                                                            <asp:Label ID="lblbraddress" runat="server" Text='<%#  Eval("mobile")  %>'></asp:Label>
                                                        </span>
                                                    </div>
                                                    <div class="clear">
                                                    </div>
                                                    <div class="user-deatils1">
                                                        <div class="del-active">

                                                            <asp:linkbutton id="lbtn53" runat="server" text="Subject" tooltip="Click here to add subject " commandname="editsubjects"
                                                                commandargument='<%# Bind("eid") %>' xmlns:asp="#unknown">
                                                            </asp:linkbutton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <%--<HeaderStyle HorizontalAlign="Center" CssClass="stm_head" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />--%>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="10" class="containerHeadline" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px"
                                OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                            </asp:DropDownList>
                            <div style="margin-left: 350px; float: left; width: 300px;">
                                <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px"
                                    OnClick="firstpage_Click" />
                                <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px"
                                    OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px"
                                    OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px"
                                    OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>