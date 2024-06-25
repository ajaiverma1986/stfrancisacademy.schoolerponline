<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="emp-schedule.aspx.cs" Inherits="BranchPanel_emp_schedule" %>

<%@ Register Src="~/BranchPanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activeschedule {
            border-color: #ccc!important;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px!important;
            margin-top: 3px;
        }

        .stm_head {
            background: linear-gradient(#858992, #858992) repeat scroll 0 0 rgba(0, 0, 0, 0);
            border-bottom: 1px solid #0D6B7E;
            border-top: 1px solid #0D6B7E;
            color: #FFFFFF !important;
            font-weight: bold;
            line-height: 36px;
            padding-left: 10px;
        }
    </style>
    <script type="text/javascript">
        function pageLoad() {
            document.title = "Employee Schedule";

        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Employee Schedule</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <%--<My:stu runat="server" ID="MyUserInfoBoxControl" />--%>

        <div class="clear"></div>
        <table width="100.11%" border="0" cellspacing="0" cellpadding="0" id="tablecreatetimetable" style="margin: 20px 0px 0px 0px !important" runat="server">
            <tr class="stm_head">
                <td rowspan="4" align="center" style="/*width: 67px; */ font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">S. No.
                </td>
                <td rowspan="4" align="center" style="width: 88px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Day
                </td>
                <td colspan="2" align="center" style="width: 108px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">1st Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">2nd Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">3rd Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">4th Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">5th Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">6th Lecture
                </td>

                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">7th Lecture
                </td>
                <td colspan="2" align="center" style="width: 110px; font-size: 11px; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">8th Lecture
                </td>
            </tr>

            <tr class="stm_head">

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">From
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">To
                </td>
            </tr>

            <tr class="stm_head">

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">9:35 AM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">10:30 AM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">10:30 AM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">11:30 AM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">11:30 AM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:30 PM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:30 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">12:55 PM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">1:25 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:00 PM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:00 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:15 PM
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:15 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:45 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">2:45 PM
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">3:00 PM
                </td>
            </tr>

            <tr class="stm_head">

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>

                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Class
                </td>
                <td width="50px" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #A7A7A7; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd;">Subject
                </td>
            </tr>

            <tr>
                <td align="left" colspan="22" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridcreatetimetable" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                        runat="server" CssClass="stm0" GridLines="None" ShowHeader="false">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblSNo" Text='<%# Bind("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="110px" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblday" runat="server" CssClass="Day" Text='<%# Bind("Day") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="100px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof1stlecture" runat="server" CssClass="FirstLectureClass" Text='<%# Bind("FirstLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof1stlecture" runat="server" CssClass="FirstLectureSubject" Text='<%# Bind("FirstLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof2ndlecture" runat="server" CssClass="SecondLectureClass" Text='<%# Bind("SecondLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof2ndlecture" runat="server" CssClass="SecondLectureSubject" Text='<%# Bind("SecondLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof3rdlecture" runat="server" CssClass="ThirdLectureClass" Text='<%# Bind("ThirdLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof3rdlecture" runat="server" CssClass="ThirdLectureSubject" Text='<%# Bind("ThirdLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof4thlecture" runat="server" CssClass="FourthLectureClass" Text='<%# Bind("FourthLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof4thlecture" runat="server" CssClass="FourthLectureSubject" Text='<%# Bind("FourthLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof5thlecture" runat="server" CssClass="FifthLectureClass" Text='<%# Bind("FifthLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof5thlecture" runat="server" CssClass="FifthLectureSubject" Text='<%# Bind("FifthLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof6thlecture" runat="server" CssClass="SixthLectureClass" Text='<%# Bind("SixthLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof6thlecture" runat="server" CssClass="SixthLectureSubject" Text='<%# Bind("SixthLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof7thlecture" runat="server" CssClass="SeventhLectureClass" Text='<%# Bind("SeventhLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof7thlecture" runat="server" CssClass="SeventhLectureSubject" Text='<%# Bind("SeventhLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblclassof8thlecture" runat="server" CssClass="EightthLectureClass" Text='<%# Bind("EightthLectureClass") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblsubjectof8thlecture" runat="server" CssClass="EightthLectureSubject" Text='<%# Bind("EightthLectureSubject") %>' Style="text-decoration: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="150px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>