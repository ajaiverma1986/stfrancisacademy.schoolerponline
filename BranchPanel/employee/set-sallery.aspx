<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="set-sallery.aspx.cs" Inherits="BranchPanel_set_sallery" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <link href="../../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />

    <script type="text/javascript">

        function pageLoad() {
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $("#ctl00_ContentPlaceHolder1_txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
            });
        }
    </script>

    <style type="text/css">
        .activesetsallery {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
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
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Set Sallery</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <asp:UpdatePanel ID="updatepanelmain" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label runat="server" id="Label1">
                        Employee Name<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtemployeename" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label runat="server" id="Label2">
                        Salary Type<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtsallerytype" runat="server" ReadOnly="true" Text="Monthly"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label runat="server" id="lbldateofsalleryapply">
                        Salary Implementation Date<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtdate" runat="server" placeholder="Select Date Please"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label runat="server" id="Label3">
                        Salary <span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtsallery" runat="server" placeholder="Enter Amount Please"></asp:TextBox>
                    <asp:LinkButton ID="lbtnupdatesallery" runat="server" OnClick="updatesallery_Click" Text="Edit Sallery" Style="font-size: 13px; border: 1px dotted black"></asp:LinkButton>
                    <asp:LinkButton ID="lbtnforsalleryupdate" Text="Revised Sallery" runat="server" OnClick="lbtnforsalleryupdate_Click" Style="font-size: 13px; border: 1px dotted black"></asp:LinkButton>
                </div>
                <div class="for_sigle_row_form">
                    <label></label>
                    <asp:Button ID="btnsubmit" runat="server" Text="Set Sallery" CssClass="button1" OnClick="btnsubmit_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button2" CausesValidation="false" OnClick="Button1_Click" />
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
                    <tr>
                        <td colspan="2" align="left" style="padding-left: 0px; padding-right: 0px; width: 100%">
                            <asp:GridView ID="grdminthlysalleryreport" AutoGenerateColumns="false" GridLines="None" Width="100%" runat="server"
                                EmptyDataText="No Salary History Found." ShowHeader="true" BorderWidth="0">
                                <Columns>

                                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="From Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblfromdate" Text='<%# Eval("FromDate","{0:MMM dd yyyy}") %>' runat="server" CssClass="department"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="To Date" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltodate" Text='<%# Eval("ToDate","{0:MMM dd yyyy}") %>' runat="server" CssClass="designation"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Monthly Sallery" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsalary" Text='<%# Eval("Amount","{0:f}") %>' runat="server" CssClass="mobile"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Current Sallery" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstatus" Text='<%# Eval("Status") %>' runat="server" CssClass="mobile"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnsubmit" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="lbtnforsalleryupdate" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>