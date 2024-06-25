<%@ Page Title="Employee Attendance" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="empattendance.aspx.cs" Inherits="BranchPanel_empattendancece" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Employee Attendance</a></li>
            <li style="background: none;"><a class="active" href="#">Attendance</a></li>
            <div class="arrowt">
                <a href="empattendance.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Employee Attendance
        </div>
        <%-- code for calendra--%>
        <%--<table id="ctl00_MainContent_tbldata" style="width: 100%; padding-top: 10px" align="center">
	<tbody><tr>
		<td style="width: 50%"></td>
		<td width="50%">
                        <table style="width: 100%">
                            <tbody><tr>
                                <td style="width: 20%"></td>
                                <td style="width: 5%" align="right">
                                    <a id="ctl00_MainContent_btnleft" onclick="Loading();" href="javascript:__doPostBack('ctl00$MainContent$btnleft','')"><i class=" icon-chevron-left"></i></a>
                                </td>
                                <td style="width: 10%" align="center">
                                    <table style="width: 100%" align="center">
                                        <tbody><tr>

                                            <td style="width: 100%" align="center">
                                                <span class="dxeBase" id="ctl00_MainContent_lblday" style="color:#C80F4B;font-family:NixieOneRegular;font-size:30px;font-weight:bold;">Tuesday</span>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td style="width: 100%" align="center">
                                                <span class="dxeBase" id="ctl00_MainContent_lbldate" style="font-family:NixieOneRegular;font-size:20px;font-weight:bold;font-style:italic;">22/07/2014</span>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                                <td style="width: 5%">
                                    <a id="ctl00_MainContent_btnright" onclick="Loading();" href="javascript:__doPostBack('ctl00$MainContent$btnright','')"><i class=" icon-chevron-right"></i></a>
                                </td>
                                <td style="width: 10%"></td>
                            </tr>
                        </tbody></table>
                    </td>
	</tr>
</tbody></table>--%>
        <%--   end of calendra--%>
        <div class="for_sigle_row_form">
            <label>
            </label>

            <asp:Button runat="server" ID="btnInTime" Text="In Time" ToolTip="Click here to mark log in time."
                CssClass="button_save" OnClick="btnInTime_Click" />
            <asp:Button runat="server" ID="btnOutTime" Text="Out Time" ToolTip="Click here to mark log out time."
                CssClass="button_save" OnClick="btnOutTime_Click" />
        </div>
        <div runat="server" id="divtext">
            <div class="for_sigle_row_form">
                <label>
                    Select Date<span style="color: Red;">* </span>
                </label>

                <asp:TextBox runat="server" ID="txtDate" placeholder="Select Date"
                    Height="24px" AutoPostBack="true" onkeypress="return noAlphabets(event)" OnTextChanged="txtDate_TextChanged"></asp:TextBox>
            </div>
            <%--  <div class="for_sigle_row_form">
           <label>
                            Select Time<span style="color: Red;">* </span>
                        </label>
                                                            <asp:DropDownList ID="ddlToHH" runat="server" Width="315px">
                                                            </asp:DropDownList>
                                                        </div>--%>
            <label>
            </label>
        </div>

        <div runat="server" align="center">
            <asp:Label ID="lblmsg" runat="server" CssClass="bharat123"></asp:Label>
            <table style="width: 100%; border-left: none !important;">
                <tr>
                    <td>
                        <asp:GridView ID="Grid_holiday" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                            runat="server" CssClass="stm" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="S No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk1" Checked='<%# Eval("status") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Employee">
                                    <ItemTemplate>

                                        <asp:Label ID="lblreason" Text='<%# Eval("name") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("eid") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                            <AlternatingRowStyle CssClass="stm_light" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>

        <div runat="server" id="credential">
            <%--  <div class="for_sigle_row_form">
                <label>
                    Enter your Username<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtEUser" runat="server"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEUser"
                    ErrorMessage="Please enter username." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Password<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtEpass" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEpass"
                    ErrorMessage="Please enter Password." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>--%>
            <div class="for_sigle_row_form" id="dibsubmit" runat="server">
                <label>
                </label>
                <%-- <asp:Button runat="server" ID="btnAttendance" Text="Mark Attendance" CssClass="button_save"
                    OnClick="btnAttendance_Click" />&nbsp;&nbsp;--%>
                <asp:Button runat="server" ID="btnsubmit" Text="Submit" CssClass="button_save" OnClick="btnBack2_Click"
                    CausesValidation="false" />
            </div>
        </div>
    </div>
</asp:Content>