<%@ Page Title="Discount Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="discount_report.aspx.cs" Inherits="BranchPanel_discount_report" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .active96 {
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

    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

            $("#<%=TextBox1.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/searchclass") %>',
                           data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                           dataType: "json",
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           success: function (data) {
                               if (data.d.length > 0) {
                                   response($.map(data.d, function (item) {
                                       return {
                                           label: item.split('-')[0],
                                           val: item.split('-')[1],
                                           val1: item.split('-')[2]

                                       };
                                   }))
                               }
                               else {
                                   response([{ label: 'No results found.', val: -1 }]);
                               }

                           },
                           error: function (response) {
                               alert(response.responseText);
                           },
                           failure: function (response) {
                               alert(response.responseText);
                           }
                       });
                   },
                   select: function (e, i) {

                       $("#<%=HiddenField1.ClientID %>").val(i.item.val);
                },
                minLength: 1

               });

            };
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Collection</a></li>

            <li style="background: none;"><a class="active">Discount Report</a></li>
        </ul>

        <div class="arrowt">
            <a href="Recentfee.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>

                <table width="100%" id="tdd" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadlinenew">
                            <asp:DropDownList ID="ddlRecordperPage" AutoPostBack="true" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" runat="server" Width="90px"
                                Font-Size="11px" Style="margin-top: 3px;">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="20"></asp:ListItem>
                                <asp:ListItem Value="2" Text="30"></asp:ListItem>
                                <asp:ListItem Value="3" Text="50"></asp:ListItem>
                                <asp:ListItem Value="4" Text="100"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="TextBox1" runat="server" placeholder="Enter class Name" Style="padding-right: 35px; margin-left: 541px"></asp:TextBox>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <div style="float: right; width: 180px; margin-top: 3px;">

                                <asp:Button ID="Button1" runat="server" Text="Go" Height="25px" ToolTip="Click here to search items"
                                    CssClass="view-enquiry" OnClick="Button1_Click" />&nbsp;

                             <asp:Button ID="btnreset" runat="server" Text="Reset" ToolTip="Click here for reset"
                                 CssClass="view-enquiry1" OnClick="btnreset_Click" />
                                <%--  <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                                Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />--%>
                            </div>
                        </td>
                    </tr>
                    <%-- </table>--%>

                    <%-- <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="tblGrid">--%>

                    <tr>
                        <td align="left" colspan="4" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView runat="server" ID="gvdetails" AutoGenerateColumns="false"
                                Width="100%" CssClass="stm" GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="7%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Student Name" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblname" Text='<%#Eval("name") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="14%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Class Name" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcourse" Text='<%#Eval("applyClass") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Admission No" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lbadno" Text='<%#Eval("adno") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Total Fee" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblamt" Text='<%#Eval("totalfee","{0:0.00}") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Paid Fee" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lbpaid" Text='<%#Eval("paid","{0:0.00}") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Balance Fee" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lbbal" Text='<%#Eval("balance","{0:0.00}") %>' runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Discount Fee" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lbdisc" Text='<%#Eval("discount","{0:0.00}") %>' ForeColor="SlateBlue" runat="server"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_dark" />
                                <AlternatingRowStyle CssClass="stm_light" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>

                        <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="85px" AutoPostBack="true" OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                            </asp:DropDownList>
                            <div style="float: right; width: 153px;">
                                <asp:ImageButton ID="firstpage" runat="server" CssClass="first-click" ImageUrl="~/images/first.gif" Width="25px" OnClick="firstpage_Click" />

                                <asp:ImageButton ID="previous" runat="server" CssClass="previous-click" ImageUrl="~/images/previous.gif" Width="25px" OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" CssClass="next-click" ImageUrl="~/images/next.gif" Width="25px" OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" CssClass="last-click" ImageUrl="~/images/last.gif" Width="25px" OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>