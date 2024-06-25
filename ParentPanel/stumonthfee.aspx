<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="stumonthfee.aspx.cs" Inherits="ParentPanel_stumonthfee" %>

<%--<%@ Register Src="~/ParentPanel/parentuser.ascx" TagName="stu" TagPrefix="My" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>
    <style type="text/css">
        .active56 {
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
    <style>
        .conductedlecture235 {
            height: 70px;
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #6EDBFF;
            width: 150px;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
        }
    </style>
    <style>
        .conductedlecture236 {
            height: 70px;
            font-size: 12px;
            color: #000;
            line-height: 30px;
            text-align: left;
            padding: 0px 15px;
            background: #D4A5A5;
            width: 150px;
            margin-left: 100px;
            border-radius: 4px;
            float: left;
        }

        .col-lg-3 {
            width: auto;
        }
    </style>

    <%--    <div class="content_top">
        <ul>
            <li><a style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li style="background: none;"><a class="active" >Monthly Fee Report</a></li>
        </ul>
    </div>--%>

    <div class="page-content" id="contentPane">
        <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <%-- <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px;
            padding-top: 0px;" class="containerHeadline">
            Monthly Fee Report
        </div>--%>

        <div class="page-header">
            <h1><a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Monthly Account Report
                </small>
            </h1>
        </div>
        <div class="row">
            <asp:UpdatePanel runat="server" ID="UpdatePanel7">
                <ContentTemplate>
                    <div class="for_sigle_row_form" runat="server" id="l1">

                        <div class="well" style="width: 22%; margin-bottom: 0px;">
                            <label>
                                Month :<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList runat="server" ID="ddlMonth" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />

                    <div class="col-sm-7 infobox-container widget-box" style="border-top: 2px solid #2bbce0; border-radius: 3px;">

                        <div class="infobox infobox-green infobox-small infobox-dark">

                            <div class="infobox-data">
                                <div class="infobox-content">
                                    <asp:Label runat="server" ID="lbl1" Text="Total" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#ffffff" Font-Bold="true"></asp:Label>
                                    <%--<div class="infobox-content">Completion</div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="infobox infobox-blue infobox-small infobox-dark" style="margin-left: 18px;">

                            <div class="infobox-data">
                                <div class="infobox-content">
                                    <asp:Label runat="server" ID="Label6" Text="Received" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label8" runat="server" Text="₹" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;
                                        <asp:Label ID="lblReceived" runat="server" Text="0" ForeColor="#ffffff" Font-Bold="true"></asp:Label>
                                </div>
                                <%--<div class="infobox-content">$32,000</div>--%>
                            </div>
                        </div>

                        <div class="infobox infobox-grey infobox-small infobox-dark" style="margin-left: 18px;">
                            <%--	<div class="infobox-icon">
												<i class="ace-icon fa fa-download"></i>
											</div>--%>

                            <div class="infobox-data">
                                <div class="infobox-content">
                                    <asp:Label runat="server" ID="Label2" Text="Balance" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label3" runat="server" Text="₹" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;
                                        <asp:Label ID="lblremain" runat="server" Text="0" Font-Bold="true" ForeColor="#ffffff"></asp:Label>
                                </div>
                            </div>
                            <%--<div class="infobox-content">1,205</div>--%>
                        </div>
                    </div>

                    <div class="col-xs-12" style="background: #fff; margin-top: 12px; padding-top: 17px; border: 1px solid #ddd; border-radius: 3px; border-top: 2px solid #2bbce0; padding-left: 12px;">

                        <table cellpadding="2" id="Table4" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">

                            <tr>
                                <td align="left" colspan="7" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                                    <asp:GridView runat="server" ID="gridreport" ShowHeader="true"
                                        AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="table table-striped table-bordered table-hover" OnRowDataBound="gridreport_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldate" runat="server" Text='<%# Bind("FirstName") %>'> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Class">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("applyclass") %>'> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Admission No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("ADNO") %>'> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="18%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Paid Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblamnt" runat="server" Text='<%# Bind("total","{0:0.00}") %>'> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="18%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Due Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldue" runat="server"> </asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="18%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                        <RowStyle CssClass="stm_dark" />
                                        <AlternatingRowStyle CssClass="stm_light" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>