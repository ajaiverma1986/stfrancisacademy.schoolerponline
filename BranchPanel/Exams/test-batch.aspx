<%@ Page Title="Student Test List Batch Wise" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="test-batch.aspx.cs" Inherits="BranchPanel_Exam_test_batch" %>

<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .active0 {
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
        .Initial {
            display: block;
            padding: 4px 18px 4px 18px;
            float: left;
            color: Black;
            font-weight: bold;
        }

            .Initial:hover {
                color: White;
            }

        .Clicked {
            float: left;
            display: block;
            padding: 4px 18px 4px 18px;
            color: Black;
            font-weight: bold;
            color: White;
        }
    </style>
    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 50px;
            margin-top: 15px;
        }

        #content_pane {
            background: #fff;
        }

        .file_border1 {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 250px;
            height: 18px;
            margin-top: -10px;
        }

        #content_pane {
            background: #fff;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li><a href="#">Exam List</a></li>
            <li style="background: none;"><a class="active">Student Test List Batch Wise</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png"></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <table class="file_border" cellspacing="0" border="0" style="width: 190px; position: relative; height: 90px; padding-left: 0px; margin-left: 7px; background: #EBEBEB;">

            <tr>
                <td>
                    <div>
                        <b>Selected Batches</b>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <p style="margin-left: 5px; font-size: 15px">
                            <asp:PlaceHolder ID="Area1" runat="server"></asp:PlaceHolder>
                        </p>
                    </div>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <table class=".file_border1" cellspacing="0" border="0" style="width: 390px; position: relative; height: 90px; padding-left: 0px; margin-left: 656px; background: #EBEBEB;">
                    <tr>
                        <td>
                            <asp:Button Text="Students Added" BorderStyle="None" ID="Tab1" CssClass="Initial" runat="server"
                                OnClick="Tab1_Click" />
                            <asp:Button Text="Students Remove" BorderStyle="None" ID="Tab2" CssClass="Initial" runat="server"
                                OnClick="Tab2_Click" /><asp:Label ID="lblcount" runat="server" CssClass="Initial"></asp:Label>

                            <asp:MultiView ID="MainView" runat="server">
                                <asp:View ID="View1" runat="server">
                                    <table style="width: 100%; border-width: 0px; border-color: #666; border-style: solid">

                                        <tr>
                                            <td>

                                                <div class="for_sigle_row_form">

                                                    <asp:TextBox ID="txtmarksp" runat="server" AutoPostBack="true" onFocus="if(this.value=='Search by name') this.value=''; " onBlur="if(this.value=='') this.value='Search by name'; "
                                                        Text="Search by name"></asp:TextBox>
                                                </div>
                                                <asp:UpdatePanel ID="uup1" runat="server">
                                                    <ContentTemplate>
                                                        <asp:GridView ID="gridenquiry" AutoGenerateColumns="false" EmptyDataText="No data found !"
                                                            CellPadding="5" runat="server" Width="100%" CssClass="stm" GridLines="None" OnRowCommand="gridenquiry_RowCommand">
                                                            <Columns>

                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblstu" Text='<% #Bind("name")%>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Batch Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblbt" Text='<% #Bind("batchname")%>' runat="server"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="Linkbutton1" runat="server" CommandName="ed" CommandArgument='<% #bind("regno")%>' Font-Underline="true"
                                                                            ForeColor="Chocolate" Text="Remove" ToolTip="Click here to Remove Student from Test">
                                                                        </asp:LinkButton><asp:HiddenField ID="lblbatch" runat="server" Value='<% #bind("batchid")%>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                                            <RowStyle CssClass="stm_light" />
                                                            <AlternatingRowStyle CssClass="stm_dark" />
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:View>

                                <asp:View ID="View2" runat="server">
                                    <table style="width: 100%; border-width: 0px; border-color: #666; border-style: solid">

                                        <tr>
                                            <td>

                                                <asp:GridView ID="GridView1" AutoGenerateColumns="false" EmptyDataText="No data found !"
                                                    CellPadding="5" runat="server" Width="100%" CssClass="stm" GridLines="None" OnRowCommand="GridView1_RowCommand">
                                                    <Columns>

                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblstu1" Text='<% #Bind("name")%>' runat="server"></asp:Label></ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" Width="20%" />
                                                        </asp:TemplateField>

                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Batch Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblbt" Text='<% #Bind("batchname")%>' runat="server"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="Linkbutton1" runat="server" CommandName="ed" CommandArgument='<% #bind("regno")%>' Font-Underline="true"
                                                                    ForeColor="Chocolate" Text="Add" ToolTip="Click here to Remove Student from Test">
                                                                </asp:LinkButton><asp:HiddenField ID="lblbatch" runat="server" Value='<% #bind("batchid")%>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                                    <RowStyle CssClass="stm_light" />
                                                    <AlternatingRowStyle CssClass="stm_dark" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:View>

                                <%-- <asp:View ID="View2" runat="server">
              <table style="width: 100%; border-width: 1px; border-color: #666; border-style: solid">
              </table>--%>
                                <%--</asp:View>--%>
                                <%--<asp:View ID="View3" runat="server">
              <table style="width: 100%; border-width: 1px; border-color: #666; border-style: solid">
                <tr>
                  <td>
                    <h3>
                      View 3
                    </h3>
                  </td>
                </tr>
              </table>
            </asp:View>--%>
                            </asp:MultiView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>