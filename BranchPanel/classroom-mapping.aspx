<%@ Page Title="Assign Room to Class" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="classroom-mapping.aspx.cs" Inherits="classroom_mapping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>
            <li style="background: none;"><a class="active" href="#">Add Room with class</a></li>
        </ul>
        <div class="arrowt">
            <a href="../HO/AddClassBranch.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 3px;"
            class="containerHeadline stripheading">

            <asp:Button runat="server" ID="Button2" CssClass="button_save45" Style="margin-right: -3% !important" Text="Add Room to class"
                ToolTip="Click here to Add Room." OnClick="Button2_Click" />
            <asp:Button runat="server" ID="Button3" CssClass="button_save" Style="margin-left: 703px; margin-top: 4px" Text="Add Room to class stream"
                ToolTip="Click here to Add Section." OnClick="Button3_Click" Visible="false" />
        </div>
        <br />
        <div id="insertdiv" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Class</label>
                <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Section</label>
                <asp:DropDownList ID="ddlsection" runat="server">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Room</label>
                <asp:DropDownList ID="ddlroom" runat="server" OnSelectedIndexChanged="ddlroom_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Capacity<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtcapacity" runat="server" Enabled="false"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label style="padding-top: 3px;">
                    Status<span style="color: Red;"> </span>
                </label>

                <asp:CheckBox ID="chkstatus" runat="server" Height="20px" Width="20px" />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save"
                    ValidationGroup="g1" OnClick="btnAdd_Click" />
                <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_save" OnClick="Button1_Click" />
            </div>
        </div>

        <div id="griddiv" runat="server">

            <asp:GridView ID="grid_classroom" runat="server" EmptyDataText="No data found !" CssClass="stm" BorderWidth="0" HeaderStyle-Height="30px"
                AutoGenerateColumns="false" PagerSettings-Position="Bottom" GridLines="None" AllowPaging="true"
                PagerStyle-Font-Size="15px" PageSize="10" PagerStyle-HorizontalAlign="Right"
                Width="101%" OnRowCommand="grid_classroom_RowCommand">

                <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                <Columns>
                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Room Name" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblrname" runat="server" Text='<% #Bind("roomname")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Classname" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblclassname" runat="server" Text='<% #Bind("classname")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Section" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblsection" runat="server" Text='<% #Bind("section")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Capacity" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblcapacity" runat="server" Text='<% #Bind("capacity")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" Text="Edit" CommandName="Edit1" CommandArgument='<%# Bind("roomid") %>' CausesValidation="false" ToolTip="update"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_dark" />
                <AlternatingRowStyle CssClass="stm_light" />
                <HeaderStyle CssClass="stm_head" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>