<%@ Page Title="Exam List" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master"
    CodeFile="testlist.aspx.cs" Inherits="BranchPanel_Exam_testlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>
    <style type="text/css">
        .stm td {
            border-bottom: none;
            border-right: none;
        }

        .active1 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #8CBF26;
            color: #333333;
            padding: 6px 15px 6px 15px;
            margin-right: 10px;
            height: auto;
        }

        table td {
        }

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 20px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }

        .auto-style1 {
            width: 11%;
        }
    </style>

    <script type="text/javascript">
    </script>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Exams</a></li>
            <li style="background: none;"><a class="active">Exam List</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <asp:Button ID="btnAdd" runat="server" Text="Add New Exam" OnClick="btnAdd_Click"
        ToolTip="Click here create test" CssClass="button_save" Visible="false" />
    <asp:Button ID="Button2" runat="server" Text="Generate Schedule" OnClick="btnAdd_Click1" Visible="false"
        ToolTip="Click here create Schedule" CssClass="button_save" />
    <asp:Button ID="Button3" runat="server" Text="Room Allotment" OnClick="btnAdd_Click2" Visible="false"
        ToolTip="Click here Room Allotment" CssClass="button_save" />

    <asp:Button ID="Button4" runat="server" Text="View Schedule" OnClick="btnAdd_Click3" Visible="false"
        ToolTip="Click here View Schedule" CssClass="button_save" />

    <asp:Button ID="Button5" runat="server" Text="Set Co - Scholastic Areas" OnClick="Button5_Click"
        ToolTip="Click here View Schedule" CssClass="button_save" />

    <asp:Button ID="btnsetmarks" runat="server" Text="Set Scholastic Area" OnClick="btnsetmarks_Click"
        ToolTip="Click here Set Marks" CssClass="button_save" />

    <asp:Button ID="Button6" runat="server" Text="View Result" OnClick="Button6_Click" ToolTip="Click here Set Marks" CssClass="button_save" />

    <asp:Button ID="Button7" runat="server" Text="Admit Card"  ToolTip="Click for admit card" PostBackUrl="~/BranchPanel/Exams/GenerateAdmitCard.aspx" CssClass="button_save" />

     <asp:Button ID="Button8" runat="server" Text="Set Time Table"  ToolTip="Click for time table" PostBackUrl="~/BranchPanel/Exams/SetTimetable.aspx" CssClass="button_save" />
    <div class="content_pane_cont input_content" id="contentPane">

        <asp:UpdatePanel ID="updatepanelgrid" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <script type="text/javascript" lang="javascript">
                    Sys.Application.add_load(title);
                </script>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; display:none; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadline">
                            <div style="float: right; width: 210px;">

                                <asp:DropDownList ID="ddlEnquirySource" runat="server" AutoPostBack="true" Width="150px" OnSelectedIndexChanged="ddlEnquirySource_SelectedIndexChanged">
                                    <asp:ListItem Value="2">Search By Status</asp:ListItem>
                                    <asp:ListItem Value="1">Conducted</asp:ListItem>
                                    <asp:ListItem Value="0">Pending</asp:ListItem>
                                </asp:DropDownList>

                                <asp:Button ID="Button1" runat="server" Text="Go" Visible="false" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" OnClick="Button1_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid"
                    style="border-top: 1px solid #ddd; display:none;">
                    <tr class="stm_head">
                        <td width="6%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">S. No.
                        </td>
                        <td width="10%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Exam Name
                        </td>

                        <td rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;"
                            class="auto-style1">From Date
                        </td>
                        <td rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;"
                            class="auto-style1">To Date
                        </td>
                        <td width="24%" colspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Timing
                        </td>

                        <td width="11%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Classes
                        </td>

                        <td width="14%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-left: 1px solid #ddd;">Status
                        </td>
                    </tr>
                    <tr class="stm_head">
                        <td width="12%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #C9C9C9; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; font-size: 13px; font-weight: bold">From
                        </td>
                        <td width="12%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #C9C9C9; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; font-size: 13px; font-weight: bold">To
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView ID="gridenquiry" AutoGenerateColumns="false" ShowHeader="false" EmptyDataText="No Sechudle Created."
                                Width="100%" CssClass="stm" GridLines="None" runat="server" OnRowDataBound="gridenquiry_RowDataBound" OnRowCommand="gridenquiry_RowCommand">
                                <Columns>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbltestname" ForeColor="Chocolate" CommandName="ed" CommandArgument='<% #Bind("eid")%>'
                                                runat="server" Text='<%#Eval("examname") %>' Font-Underline="true" ToolTip="Click Here For Set Marks" Style="text-decoration: none"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblfromdate" Text='<%#Eval("FromDate","{0:MMM dd yyyy}") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltodate" Text='<%#Eval("ToDate","{0:MMM dd yyyy}") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblteststarttime" Text='<%#Eval("teststarttime") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltestendtime" Text='<%#Eval("testendtime") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblclassesforexam" runat="server" Text='<%#Eval("classforexam") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="11%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnstatus" ForeColor="Chocolate" class="abcd" CommandName="marksdetails" CommandArgument='<% #Bind("eid")%>'
                                                runat="server" Text='<%#Eval("examstatus") %>' Font-Underline="true" ToolTip="Click Here For Show Details" Style="text-decoration: none"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
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
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlEnquirySource" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="gridenquiry" EventName="RowCommand" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>