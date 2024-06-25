<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="password-request.aspx.cs" Inherits="branchpanel_employee_password_request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .important {
            color: white!important;
        }

        .leavehistory {
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

    <script type="text/javascript">
        function pageLoad() {
            setleavestatus();
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
        }
        function setleavestatus() {

            var gvDrv = document.getElementById("<%=gvleavedetails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {

                var leavestatus = $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") td:eq(6)").find("span").text();
                if (leavestatus == "Approved") {
                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") ").css("background", "#46B525");
                }
                if (leavestatus == "Cancel") {

                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") ").css("background", "red");
                    $("#ctl00_ContentPlaceHolder1_gvleavedetails tr:eq(" + i + ") td ").addClass("important");

                }

            }
        }
    </script>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a class="active">Password Request</a></li>
        </ul>
    </div>
    <div class="clear"></div>
    <div class="content_pane_cont input_content" id="contentPane">

        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label id="leavdetailsbin">Request Password</label>
            <a href="requestleavelist.aspx" title="Get Leave List" style="cursor: pointer; display: none; color: #fff; float: right; margin-right: 20px;">Back</a>
        </div>
        <div id="griddetails" style="float: left; width: 100%;">

            <asp:GridView runat="server" ID="gvleavedetails" AllowPaging="true" EmptyDataText="No Leave Details."
                PageSize="10" AutoGenerateColumns="false" Width="100%" CssClass="stm" GridLines="None" OnPageIndexChanging="gvleavedetails_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp ID">
                        <ItemTemplate>
                            <asp:Label ID="sno2" runat="server" Text='<%#Eval("username") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Emp Name">
                        <ItemTemplate>
                            <asp:Label ID="sno1" runat="server" Text='<%#Eval("empname") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Password">
                        <ItemTemplate>
                            <asp:Label ID="sno5" runat="server" Text='<%#Eval("password") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Mobile">
                        <ItemTemplate>
                            <asp:Label ID="sno6" runat="server" Text='<%#Eval("contact_number") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="sno6" runat="server" Text='<%#Eval("email_address") %>'> </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>