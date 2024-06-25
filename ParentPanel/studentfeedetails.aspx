<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentfeedetails.aspx.cs" Inherits="ParentPanel_studentfeedetails" %>

<%--<%@ Register Src="~/ParentPanel/parentuser.ascx" TagName="stu" TagPrefix="My" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active7 {
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

        .widget .widget-content-white {
            background-color: #fff;
            -webkit-box-shadow: 0px 2px 8px 0px rgba(0, 0, 0, 0.15);
            box-shadow: 0px 2px 8px 0px rgba(0, 0, 0, 0.15);
            border: 1px solid #CECAC4;
            border-bottom: 1px solid #B2ACA4;
            border-radius: 4px;
        }
    </style>

    <%--<div class="content_top">
        <ul>
            <li><a style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
          <li style="background: none;"><a class="active">
               Fee Account <asp:Label ID="lblHeading" runat="server"></asp:Label></a></li>
        </ul>
    </div>--%>
    <div class="page-content" id="contentPane">
        <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <div class="page-header">
            <h1><a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Account Detail
                </small>
            </h1>
        </div>
        <div class="row">
            <div class="col-sm-7 infobox-container widget-box" style="border-top: 2px solid #2bbce0; border-radius: 3px;">

                <div class="infobox infobox-green infobox-small infobox-dark">

                    <div class="infobox-data">
                        <div class="infobox-content">
                            <asp:Label runat="server" ID="lbl1" Text="Total" Font-Bold="true" ForeColor="#ffffff"></asp:Label>
                            &nbsp;

                            <asp:Label ID="Label9" runat="server" Text="₹" Font-Bold="true" ForeColor="#ffffff"></asp:Label>&nbsp;
                                        <asp:Label ID="lblTotal" runat="server" Text="0" ForeColor="#ffffff" Font-Bold="true"></asp:Label>
                        </div>
                        <%--<div class="infobox-content">Completion</div>--%>
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

            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>

                <div class="clear"></div>
                <div class="clear"></div>
                <br />
                <div class="col-xs-12" style="background: #fff; margin-top: 12px; padding-top: 17px; border: 1px solid #ddd; border-radius: 3px; border-top: 2px solid #2bbce0; padding-left: 12px;">
                    <div class="table-header">
                        Student Paid Fee Report
                    </div>

                    <div id="Table2" runat="server" visible="false" class="dataTables_wrapper form-inline" role="grid">

                        <asp:GridView runat="server" ID="gridreport" ShowHeader="true" AllowPaging="false"
                            PageSize="20" AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="table table-striped table-bordered table-hover">
                            <Columns>
                                <asp:TemplateField HeaderText="S No.">
                                    <ItemTemplate>
                                        <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="left" />
                                    <ItemStyle HorizontalAlign="left" Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Month">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldate" runat="server" Text='<%# Bind("MonthName") %>'> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="left" />
                                    <ItemStyle HorizontalAlign="left" Width="25%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblclass" runat="server" Text='<%# Bind("payfee","{0:0.00}") %>'> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="left" />
                                    <ItemStyle HorizontalAlign="left" Width="25%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("transdate") %>'> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="left" />
                                    <ItemStyle HorizontalAlign="left" Width="45%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <AlternatingRowStyle CssClass="stm_light" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>
                </div>

                <table class="file_border bkrt" cellpadding="1" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <div class="form-box-heading" style="left: 300px;"></div>
                        </td>
                    </tr>
                </table>

                <%--<table runat="server"  class="file_border bkrt" cellpadding="1" cellspacing="0" border="0" style="width:70%; float:left; background:#F7F7F7; border-radius:0px; border: 1px solid #8CBF26; margin-left:0px; margin-top:30px; position:relative; padding-top:20px;">
                <tr>
                    <td>
                         <div class="form-box-heading" style="left:300px;">Student Due Fee Report</div>

                    <asp:GridView  style="float:left;margin-left:0px;" runat="server" ID="GridView1" ShowHeader="true" AllowPaging="false"
                        PageSize="20" AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm">
                        <Columns>
                             <asp:TemplateField HeaderText="S No.">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                 <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="Month">
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" Text='<%# Bind("MonthName") %>'> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="25%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Due Amount">
                                <ItemTemplate>
                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("duefees","{0:0.00}") %>'> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="25%" />
                            </asp:TemplateField>
                         <%--    <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("transdate") %>'> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="45%" />
                            </asp:TemplateField>--%>

                <%--   </Columns>
                         <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
               </td>
                    </tr>
                 </table>--%>

                <div class="clear"></div>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</asp:Content>