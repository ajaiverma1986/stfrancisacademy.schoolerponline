<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="TimeTable.aspx.cs" Inherits="BranchPanel_TimeTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .shedule-checkbox label {
            float: left;
            width: 70px!important;
            text-align: left !important;
            margin-left: 10px !important;
        }

        input {
            opacity: 1 !important;
            margin-top: 6px;
            float: left;
        }

        .for_sigle_row_form label {
            float: left;
            padding-top: 6px;
            text-align: right;
            width: 128px;
            margin-right: 20px;
            color: #616161;
            font-size: 13px;
        }

        .boxti {
            margin-left: 25.5%;
            background-color: #f1f1f1;
            width: 45%;
            border-radius: 5px;
            margin-top: 13px;
        }

        .shadow1 {
            -webkit-box-shadow: 0 0 5px rgba(152, 150, 150, 0.65);
            -moz-box-shadow: 0 0 5px rgba(152, 150, 150, 0.65);
            box-shadow: 0 0 5px rgba(152, 150, 150, 0.65);
        }

        .for_sigle_row_form {
            border-bottom: none;
            margin-left: auto;
        }

        .button_save {
            padding: 5px 7px 5px 7px;
            height: 28px;
        }

        .dw label {
            margin-left: -65px;
        }

        .stm0 td {
            border-bottom: 1px solid #dddddd;
            border-left: 1px solid #dddddd;
            line-height: 27px;
            padding: 2px;
            color: #333;
            border-right: 1px solid #dddddd;
            text-align: center;
        }

        #ctl00_ContentPlaceHolder1_rbgender_0 {
            margin-left: 10px;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Time Table</a></li>
            <li style="background: none;"><a class="active" href="#">Schedule Timetable </a>
            </li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <asp:UpdatePanel runat="server" ID="upd">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane">
                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    Schedule Time Table
                </div>

                <div class="for_sigle_row_form boxti shadow1">
                    <div class="for_sigle_row_form">
                        <label>
                            Select Class<span style="color: Red">*</span>
                        </label>
                        <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form" id="divsection" runat="server">
                        <label>
                            Select Section<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="for_sigle_row_form" runat="server" id="divscheduletype">
                        <label style="margin-left: -9px;">
                            Scheduling Type <span style="color: Red">*</span></label>
                        <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="shedule-checkbox"
                            AutoPostBack="true" OnSelectedIndexChanged="rbgender_SelectedIndexChanged">
                            <asp:ListItem Value="1" cssclass="dw">Day-wise</asp:ListItem>
                            <asp:ListItem Value="0">Period-wise</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <div runat="server" id="divdays">
                        <div class="for_sigle_row_form">
                            <label>
                                Select day of week <span style="color: red">*</span></label>
                            <asp:DropDownList ID="ddlDays" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDays_SelectedIndexChanged">
                                <asp:ListItem Text="--Select Day--" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Monday" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Tuesday" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Wednesday" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Thursday" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Friday" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Saturday" Value="6"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div runat="server" id="divperiod">
                        <div class="for_sigle_row_form">
                            <label>
                                Select period<span style="color: red">*</span></label>
                            <asp:DropDownList ID="ddlPeriod" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPeriod_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div runat="server" id="divbtn" style="float: right; width: 21%; /*margin-top: 36px; */">
                    <asp:Button runat="server" ID="btnSubmit" Text="Create Schedule" ToolTip="Click here to set the schedule for the selected class."
                        CssClass="button_save" OnClick="btnSubmit_Click" Style="margin-left: 96px; margin-top: 12px;" /><br />
                </div>

                <br />
                <div runat="server" id="divdayWise" width="101%">
                    <asp:Label runat="server" ID="lblDayname" ForeColor="#2d9fdd" Font-Bold="true"
                        Font-Size="21px" Text="A" Style="margin-left: 15px;"></asp:Label>
                    <asp:GridView runat="server" ID="grdDay" AutoGenerateColumns="false" GridLines="None"
                        CssClass="stm" Width="101%" OnRowDataBound="grdDay_RowDataBound" Style="margin-top: 14px;">
                        <Columns>
                            <asp:TemplateField HeaderText="Period">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblsub" Text='<%#Eval("period") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Timing">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lbltiming" Text='<%#Eval("timing") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlSubject1" AutoPostBack="true" OnSelectedIndexChanged="ddlSubject1_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teacher">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlTeacher1" AutoPostBack="true" OnSelectedIndexChanged="ddlTeacher1_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    &nbsp;
                                    <asp:Label ID="lblmssg" runat="server" ForeColor="Red" Style="position: absolute;"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </div>

                <div runat="server" id="divperiodwise">

                    <div>
                        <asp:Label runat="server" ID="lblPeriod" ForeColor="#2d9fdd" Font-Bold="true" Font-Size="21px"
                            Text="A" Style="margin-left: 15px;"></asp:Label>
                    </div>

                    <asp:GridView runat="server" ID="grdPeriod" AutoGenerateColumns="false" GridLines="None"
                        CssClass="stm" Width="100%" OnRowDataBound="grdPeriod_RowDataBound" Style="margin-top: 14px;">
                        <Columns>
                            <asp:TemplateField HeaderText="Day">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblsub1" Text='<%#Eval("dayname") %>' />
                                    <asp:HiddenField runat="server" ID="hfday" Value='<%#Eval("did") %>' />
                                    <asp:HiddenField runat="server" ID="HiddenField1" Value='<%#Eval("period") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Timing">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lbltiming1" Text='<%#Eval("timing") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Subject">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlSubject2" AutoPostBack="true" OnSelectedIndexChanged="ddlSubject2_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teacher">
                                <ItemTemplate>
                                    <asp:DropDownList runat="server" ID="ddlTeacher2" AutoPostBack="true" OnSelectedIndexChanged="ddlTeacher2_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    &nbsp;
                                    <asp:Label ID="lblmg" runat="server" ForeColor="Red" Style="position: absolute;"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="30%" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </div>
                <br />

                <div runat="server" id="divGrids">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" align="left" style="width: 50%; padding-right: 0px; padding-left: 15px; padding-top: 10px">
                                <asp:GridView ID="GRDSTUDENT" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                    runat="server" CssClass="stm0" GridLines="None" OnRowDataBound="GRDSTUDENT_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Faculty Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="35%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Subjects">
                                            <ItemTemplate>
                                                <asp:Label ID="lbllnk1" runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnsub" runat="server" Value='<%# Eval("eid") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="35%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                </asp:GridView>
                            </td>
                            <td valign="top" style="width: 50%; padding-left: 15px; padding-top: 10px; padding-right: 17px;">
                                <asp:GridView ID="grdLateStudents" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                    ShowHeader="true" runat="server" CssClass="stm0" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Subject Name">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("subjectname") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="45%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Class Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblclass" runat="server" Text='<%# Bind("classname") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                </asp:GridView>
                                <br />
                            </td>
                            <caption>

                                <div class="clear">
                                </div>

                                <tr>

                                    <td style="width: 50%; margin-left: 140px;" valign="bottom">

                                        <asp:GridView ID="grdteacher" runat="server" AutoGenerateColumns="false" BorderWidth="0" CssClass="stm0" GridLines="None" OnRowDataBound="grdteacher_RowDataBound" ShowHeader="true" Visible="false" Width="100%">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Period">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblsub" runat="server" Text='<%#Eval("period") %>' />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Timing">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltiming" runat="server" Text='<%#Eval("timing") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="30%" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Faculty Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblemployee" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Class Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblclass" runat="server" Text='<%# Bind("classname") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="35%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Section">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbsect" runat="server" Text='<%# Bind("section") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="35%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Day">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddy" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="35%" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                            <RowStyle CssClass="stm_light" />
                                            <AlternatingRowStyle CssClass="stm_dark" />
                                        </asp:GridView>
                                        <br />
                                    </td>
                                </tr>
                            </caption>
                        </tr>
                        <caption>
                            <br />
                            <tr>
                                <%--<td style="width: 50%;   padding-right: 40px; padding-left: 40px;" valign="bottom">
                                    <asp:GridView ID="grdteacher" runat="server" AutoGenerateColumns="false" Visible="false"  BorderWidth="0" CssClass="stm0" GridLines="None" ShowHeader="true" Width="100%" OnRowDataBound="grdteacher_RowDataBound">
                                        <Columns>
                                           <asp:TemplateField HeaderText="Period">
                                        <ItemTemplate>
                                             <asp:Label runat="server" ID="lblsub" Text='<%#Eval("period") %>' />
                                          </ItemTemplate>
                                             <ItemStyle HorizontalAlign="Center" Width="10%" />
                                             <HeaderStyle HorizontalAlign="Center" />
                                         </asp:TemplateField>
                                          <asp:TemplateField HeaderText="Timing">
                                     <ItemTemplate>
                                        <asp:Label runat="server" ID="lbltiming" Text='<%#Eval("timing") %>'></asp:Label>
                                   </ItemTemplate>
                                         <ItemStyle HorizontalAlign="Center" Width="30%" />
                                          <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Class Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("classname") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="35%" />
                                            </asp:TemplateField>

                                             <asp:TemplateField HeaderText="Day">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblddy" runat="server" ></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="35%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                        <RowStyle CssClass="stm_light" />
                                        <AlternatingRowStyle CssClass="stm_dark" />
                                    </asp:GridView>
                                    <br />
                                </td>--%>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <br />
                                </td>
                            </tr>
                        </caption>
                    </table>
                </div>

                <br />

                <%-- <div runat="server" id="divbtn" style="float: right; width: 690px;">
                    <asp:Button runat="server" ID="btnSubmit" Text="Create Schedule" ToolTip="Click here to set the schedule for the selected class."
                        CssClass="button_save" OnClick="btnSubmit_Click" Style="margin-left: 85px;margin-top: -38px;" /><br />
                </div>--%>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>