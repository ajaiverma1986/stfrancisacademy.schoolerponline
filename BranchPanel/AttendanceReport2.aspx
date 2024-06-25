<%@ Page Title="Monthly Attendance" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="AttendanceReport2.aspx.cs" Inherits="BranchPanel_AttendanceReport2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Student Attendence</a></li>
            <li><a>Attendence Report</a></li>
            <li style="background: none;"><a class="active">Monthwise Attendence</a></li>
        </ul>
    </div>

    <asp:Button ID="btn1" runat="server" Text="DayWise Attendance" CssClass="button_save" OnClick="btn1_Click"
        ToolTip="Click here to see attendance daywise." />

    <asp:Button ID="btn2" runat="server" Text="Monthly Attendance" CssClass="button_save" OnClick="btn2_Click"
        ToolTip="Click here to see attendance monthwise." />
    <asp:Button ID="btn3" runat="server" Text="Student Attendance" CssClass="button_save" OnClick="btn3_Click"
        ToolTip="Click here to see attendance studentwise." />

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Monthwise Attendence Report
        </div>
        <div class="clear">
        </div>
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <br />
                    <label>
                        Select Month<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLMonth" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;
            <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Class<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Section<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server" ID="upd2">
            <ContentTemplate>
                <div style="margin-top: 15px; height: auto">
                    <table cellpadding="2" cellspacing="0" border="0" style="width: 120%; border-left: none !important;">
                        <tr id="tr1" runat="server" style="background: #33ccff; display: none">
                            <td class="stm_head2" style="width: 2%; padding-left: 10px; color: #ffffff;">
                                <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                            </td>
                            <td class="stm_head2" style="width: 15%; padding-left: 10px; color: #ffffff;">
                                <asp:Label ID="Label5" runat="server">Student Name</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="lblhead" runat="server">1</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label2" runat="server">2</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label3" runat="server">3</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label4" runat="server">4</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label6" runat="server">5</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label7" runat="server">6</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label8" runat="server">7</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label9" runat="server">8</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label10" runat="server">9</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label11" runat="server">10</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label12" runat="server">11</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label13" runat="server">12</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label14" runat="server">13</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label15" runat="server">14</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label16" runat="server">15</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label17" runat="server">16</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label18" runat="server">17</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label19" runat="server">18</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label20" runat="server">19</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label21" runat="server">20</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label22" runat="server">21</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label23" runat="server">22</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label24" runat="server">23</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label25" runat="server">24</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label26" runat="server">25</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label27" runat="server">26</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label28" runat="server">27</asp:Label>
                            </td>
                            <td style="width: 2%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label29" runat="server">28</asp:Label>
                            </td>
                            <td id="td29" runat="server" style="width: 2%; padding-left: 10px; color: #ffffff;"
                                class="stm_head2">
                                <asp:Label ID="Label30" runat="server">29</asp:Label>
                            </td>
                            <td id="td30" runat="server" style="width: 2%; padding-left: 10px; color: #ffffff;"
                                class="stm_head2">
                                <asp:Label ID="Label31" runat="server">30</asp:Label>
                            </td>
                            <td id="td31" runat="server" style="width: 2%; padding-left: 10px; color: #ffffff;"
                                class="stm_head2">
                                <asp:Label ID="Label33" runat="server">31</asp:Label>
                            </td>
                            <td style="width: 7%; padding-left: 10px; color: #ffffff;" class="stm_head2">
                                <asp:Label ID="Label32" runat="server">Total Present</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="33" class="format">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" ShowHeader="true"
                                    ShowFooter="true" CellPadding="4" ForeColor="#333333" Width="100%" GridLines="Both"
                                    OnRowDataBound="GridView1_RowDataBound" BorderWidth="0" CssClass="stm">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                S.No.
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                                <asp:HiddenField ID="hd1" runat="server" Value='<%# Bind("id") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="4%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                Student Name
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblname" Text='<%# Bind("studentname") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Total
                                            </FooterTemplate>
                                            <ItemStyle Width="15%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                1
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld1" Text='<%# Bind("d1") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd1" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                2
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld2" Text='<%# Bind("d2") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd2" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                3
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld3" Text='<%# Bind("d3") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd3" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                4
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld4" Text='<%# Bind("d4") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd4" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                5
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld5" Text='<%# Bind("d5") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd5" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                6
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld6" Text='<%# Bind("d6") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd6" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                7
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld7" Text='<%# Bind("d7") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd7" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                8
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld8" Text='<%# Bind("d8") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd8" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                9
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld9" Text='<%# Bind("d9") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd9" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                10
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld10" Text='<%# Bind("d10") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd10" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                11
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld11" Text='<%# Bind("d11") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd11" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                12
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld12" Text='<%# Bind("d12") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd12" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                13
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld13" Text='<%# Bind("d13") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd13" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                14
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld14" Text='<%# Bind("d14") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd14" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                15
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld15" Text='<%# Bind("d15") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd15" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                16
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld16" Text='<%# Bind("d16") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd16" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                17
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld17" Text='<%# Bind("d17") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd17" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                18
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld18" Text='<%# Bind("d18") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd18" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                19
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld19" Text='<%# Bind("d19") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd19" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                20
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld20" Text='<%# Bind("d20") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd20" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                21
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld21" Text='<%# Bind("d21") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd21" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                22
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld22" Text='<%# Bind("d22") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd22" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                23
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld23" Text='<%# Bind("d23") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd23" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                24
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld24" Text='<%# Bind("d24") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd24" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                25
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld25" Text='<%# Bind("d25") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd25" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                26
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld26" Text='<%# Bind("d26") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd26" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                27
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld27" Text='<%# Bind("d27") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd27" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                28
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld28" Text='<%# Bind("d28") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd28" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                29
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld29" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd29" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                30
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld30" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd30" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                31
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbld31" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblFd31" runat="server">0</asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="2%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                Total Present
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbldtotal" Text='<%# Bind("ttlpnt") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="16%" HorizontalAlign="Center" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>