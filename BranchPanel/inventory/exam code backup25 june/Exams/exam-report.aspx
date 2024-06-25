<%@ Page Title="View Sechedule" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="exam-report.aspx.cs" Inherits="BranchPanel_exam_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .stm td {
            border-bottom: none;
            border-right: none;
        }

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>

            <li style="background: none;"><a class="active" href="#">View Sechedule</a></li>

            <div class="arrowt">
                <a href="testlist.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">

        <div class="for_sigle_row_form">
            <label>
                Exam Name<span style="color: Red">*</span>
            </label>
            <asp:DropDownList ID="ddlexamname" runat="server">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="ddltest13" runat="server" ControlToValidate="ddlexamname"
                ErrorMessage="Please Select Exam Name." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
            <asp:Button ID="btnview" runat="server" Text="View" CssClass="button_save" OnClick="btnview_Click" />
        </div>

        <div class="clear"></div>
        <div>
            <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 700px; padding: 5px 20px; background: #fff; margin: 0px auto;"
                runat="server" id="tblMain">

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>
                                <asp:Label ID="lblexma" runat="server"
                                    Font-Size="13px" Style="color: SlateBlue;"></asp:Label></b>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Class:</b>&nbsp;<asp:Label ID="lblclss" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Exam Date:</b>&nbsp;<asp:Label ID="lbfdate" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label><b> To </b>
                            <asp:Label ID="lbtdate" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Exam Time:</b>&nbsp;<asp:Label ID="lbftime" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label><b> To </b>
                            <asp:Label ID="lbtotme" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>
            <br />
        </div>

        <div class="clear"></div>

        <table id="tblmaintable" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top: 1px solid #ddd;" visible="true">
            <tr class="stm_head">
                <td width="6%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">S. No.
                </td>
                <td width="10%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Exam Name
                </td>

                <td width="11%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">From Date
                </td>
                <td width="11%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">To Date
                </td>

                <td width="24%" colspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd;">Exam Timing
                </td>

                <td width="14%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-left: 1px solid #ddd;">Exam Status
                </td>

                <td width="15%" rowspan="2" align="center" style="font-size: 13px; border-right: 1px solid #ddd; border-left: 1px solid #ddd;">Classes
                </td>
            </tr>
            <tr class="stm_head">
                <td width="12%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; background-color: #C8C8C8;">From
                </td>
                <td width="12%" align="center" style="font-size: 11px; font-weight: normal; height: 20px; line-height: 20px; background: #F5F5F5; border-bottom: 1px solid #ddd; border-right: 1px solid #ddd; background-color: #C8C8C8">To
                </td>
            </tr>
            <tr>
                <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView ID="gridexamdefaultsechudle" AutoGenerateColumns="false" ShowHeader="false" EmptyDataText="No Exam Sechudle Generated"
                        Width="100%" CssClass="stm" GridLines="None" runat="server">
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
                                    <asp:Label ID="lblexamname" runat="server" Text='<%#Eval("examname") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblfromdate" runat="server" Text='<%#Eval("FromDate","{0:MMM dd yyyy}") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbltodate" runat="server" Text='<%#Eval("ToDate","{0:MMM dd yyyy}") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="11%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbllblstarttime" Text='<%#Eval("teststarttime","{0:t}") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblendtime" Text='<%#Eval("testendtime","{0:t}") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblexamstatus" Text='<%#Eval("examstatus") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblclasses" Text='<%#Eval("classforexam") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Left" Width="12%" />
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

        <div class="clear"></div>
        <asp:GridView ShowHeader="true" CssClass="stm drag_drop_grid GridSrc" HeaderStyle-BackColor="Black" ID="grd1" Style="margin-left: 10px;" CellPadding="0" HeaderStyle-Height="30px" Width="100%" BorderWidth="0" runat="server"></asp:GridView>
    </div>
</asp:Content>