<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master"
    CodeFile="studentmarkreport.aspx.cs" Inherits="BranchPanel_Exams_studentmarkreport" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="FusionCharts/FusionCharts.js"></script>
    <script type="text/javascript" language="JavaScript">
    </script>

    <style type="text/css">
        .active3 {
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
    <style type="text/css">
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
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Student Marks Report</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane" style="position: relative;">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="clear">
        </div>
        <div class="clear">
        </div>
        <div style="text-align: center" runat="server" id="cht1">
            <asp:Literal ID="FCLiteral1" runat="server"></asp:Literal>
            <%--<asp:Chart ID="Chart2" runat="server" BorderlineColor="Black" BorderlineDashStyle="Solid"
                BackColor="#B6D6EC" BackGradientStyle="TopBottom" BackSecondaryColor="White"
                Height="250px" Width="350px">
                <Titles>
                    <asp:Title Name="Title1" Text="Exam Analysis" Alignment="TopCenter" Font="Verdana, 12pt, style=Bold">
                    </asp:Title>
                </Titles>
                <Legends>
                    <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Default"
                        LegendStyle="Table" />
                </Legends>
                <Series>
                    <asp:Series Name="Students" BorderColor="180, 26, 59, 105" ChartType="Pie">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BackGradientStyle="TopBottom" BackSecondaryColor="#B6D6EC"
                        BorderDashStyle="Solid" BorderWidth="2">
                        <AxisX>
                            <MajorGrid Enabled="False" />
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>--%>
        </div>
        <br />
        <div id="abc" runat="server">
            <table cellpadding="0" cellspacing="0" border="0" style="margin-left: 0px;">
                <tr>
                    <td>
                        <div class="conductedlecture234" style="background: #FCF8E3; margin-left: 10px;">
                            <asp:Label runat="server" ID="Label4" Text="Students" Font-Bold="true" ForeColor="#CDAD85"></asp:Label><br />
                            <asp:Label ID="lblappear" runat="server" Font-Bold="true" ForeColor="#CDAD85"></asp:Label>
                            <asp:Label ID="lbltot" runat="server" Font-Bold="true" ForeColor="#CDAD85"></asp:Label>
                        </div>
                    </td>
                    <td style="width: 180px;">
                        <div class="conductedlecture234" style="background: #C4E5F6; margin-left: 30px;">
                            <asp:Label runat="server" ID="lbl1" Text=" Highest " Font-Bold="true" ForeColor="#81A4BE"></asp:Label><br />
                            <asp:Label ID="lblhighestmarks" runat="server" Text="00" Font-Bold="true" ForeColor="#81A4BE"></asp:Label>
                        </div>
                    </td>
                    <td>
                        <div class="conductedlecture234" style="background: #DFF0D8; margin-left: 30px;">
                            <asp:Label runat="server" ID="Label6" Text="Avg" Font-Bold="true" ForeColor="#6B9F78"></asp:Label><br />
                            <asp:Label ID="lblavgmarks" runat="server" Font-Bold="true" ForeColor="#6B9F78"></asp:Label>
                        </div>
                    </td>
                    <td>
                        <div class="conductedlecture234" style="background: #F2DEDE; margin-left: 30px;">
                            <asp:Label runat="server" ID="Label1" Text="Lowest" Font-Bold="true" ForeColor="#C76F6E"></asp:Label><br />
                            <asp:Label ID="lbllowestmarks" runat="server" Font-Bold="true" ForeColor="#C76F6E"></asp:Label>
                        </div>
                    </td>
                    <td>
                        <div class="conductedriz" style="margin-left: 60px;">
                            <asp:Button runat="server" ID="btnPdf" Text="Broadcast Test Results" CssClass="button_save"
                                ToolTip="Click here to Broadcast" OnClick="btnPdf_Click" />
                        </div>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:GridView ID="GridView1" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                runat="server" CssClass="stm0" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Roll No">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject1" runat="server" Text='<%# Bind("adno") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Student Name">
                        <ItemTemplate>
                            <asp:Label ID="lblmarks" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rank">
                        <ItemTemplate>
                            <asp:Label ID="lblrank" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Marks">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject2" runat="server" Text='<%# Bind("marks","{0:f}") %>'></asp:Label>
                            <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("admiid") %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Percentage">
                        <ItemTemplate>
                            <asp:Label ID="lblper" runat="server" Text='<%# Bind("percentage","{0:f}") %>'></asp:Label>
                            <asp:HiddenField ID="HD3" runat="server" Value='<%# Bind("Status") %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
            </asp:GridView>
        </div>
        <div id="Div1" runat="server" visible="false">
            <div class="for_sigle_row_form">
                <label>
                    Send Sms To</label>
            </div>
            <asp:RadioButtonList runat="server" ID="RadioButtonList2" RepeatDirection="Vertical"
                AutoPostBack="true" TextAlign="Right" CssClass="inline-rb">
                <asp:ListItem Value="0">Students</asp:ListItem>
                <asp:ListItem Value="1">Parents</asp:ListItem>
                <asp:ListItem Selected="True" Value="2">Both</asp:ListItem>
            </asp:RadioButtonList>
            <div class="for_sigle_row_form">
                <label>
                    Send Email To</label>
            </div>
            <asp:RadioButtonList runat="server" ID="RadioButtonList1" RepeatDirection="Vertical"
                AutoPostBack="true" TextAlign="Right" CssClass="inline-rb">
                <asp:ListItem Value="0">Students</asp:ListItem>
                <asp:ListItem Value="1">Parents</asp:ListItem>
                <asp:ListItem Selected="True" Value="2">Both</asp:ListItem>
            </asp:RadioButtonList>
            <div class="conductedriz" style="margin-left: 350px;">
                <asp:Button runat="server" ID="Button1" Text="Broadcast" CssClass="button_save" ToolTip="Click here to Broadcast"
                    OnClick="Button1_Click1" />
            </div>
            <div class="conductedriz" style="margin-left: -50px;">
                <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="button_save" CausesValidation="false"
                    OnClick="Button1_Click" />
            </div>
        </div>
    </div>
</asp:Content>