<%@ Page Title="Show Fee" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Showfee.aspx.cs" Inherits="BranchPanel_Showfee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function PrintGridData() {
            var prtGrid = document.getElementById('divMain');
            prtGrid.border = 0;

            var prtwin = window.open('', 'PrintGridViewData', 'left=0,top=0,width=1000,height=700,tollbar=0,scrollbars=1,status=0,resizable=1,fontsize=20px');
            prtwin.document.write(prtGrid.outerHTML);
            prtwin.document.close();
            prtwin.focus();
            prtwin.print();
            prtwin.close();
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Fee Managment</a></li>
            <li style="background: none;"><a class="active" href="#">Fee Structure</a></li>
            <div class="arrowt">
                <div class="arrowt">
                    <a href="default.aspx">
                        <img src="../images/back-button.png"></a>
                </div>
            </div>
        </ul>
        <%--<div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Fee Structure<div style="float: right; width: 50px;">
                <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false"
                    OnClick="ImageButton1_Click" Height="25" CssClass="excel2" />
            </div>
        </div>

        <div class="for_sigle_row_form" runat="server" id="ll">
            <label>
                Branch</label>
            <asp:TextBox ID="txtBranch" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form" style="text-align: center;" id="divid" runat="server">
            <b>Class
            </b>

            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">-- Select Class --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Class"
                ControlToValidate="ddlClass" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <%--MAIN CONTENT TO BE DISPLAYED HERE--%>

        <table width="100%" cellspacing="0" cellpadding="0" style="margin-top: 0px; border-bottom: 1px solid #ddd;"
            class="stm" runat="server" id="divMain">
            <tr>
                <%-- <td colspan="5">
          </td>--%>
            </tr>

            <tr>
                <td colspan="5" style="width: 100%; padding-left: 0px; padding-right: 0px; border: 0px;" align="left">
                    <asp:GridView ID="grdDetails" ShowFooter="true" GridLines="None" AutoGenerateColumns="false"
                        Width="100%" CellPadding="0" CellSpacing="0" runat="server"
                        OnRowDataBound="grdDetails_RowDataBound" BorderWidth="0" BorderColor="White">
                        <Columns>
                            <asp:TemplateField HeaderText="  S.No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Fee Category">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("feecategory") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Fee Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("feename") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Fee">
                                <ItemTemplate>
                                    Rs&nbsp;<asp:Label ID="txtfees" runat="server" Text='<%# Bind("fees","{0:f}") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label runat="server" ID="lbTot" Text="Total"></asp:Label>
                                </FooterTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <FooterStyle HorizontalAlign="Center" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total Fee">
                                <ItemTemplate>
                                    Rs&nbsp;<asp:Label ID="txtTotalfee" runat="server" Text='<%# Bind("totalfee","{0:f}") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    Rs&nbsp;
                                    <asp:Label runat="server" ID="lblTotalfee"></asp:Label>
                                </FooterTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <FooterStyle HorizontalAlign="Center" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                        </Columns>

                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>

                <td runat="server" id="abc" visible="false">
                    <asp:GridView ID="grdDetails1" ShowFooter="true" AutoGenerateColumns="false" Visible="true"
                        Width="100%" CellPadding="0" CellSpacing="0" runat="server"
                        OnRowDataBound="grdDetails1_RowDataBound" BorderWidth="0" BorderColor="White">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <HeaderTemplate>S.No.</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />

                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <HeaderTemplate>
                                    <asp:Label ID="lblheadx" runat="server">Fee Category</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("feecategory") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <HeaderTemplate>
                                    <asp:Label ID="Label1x" runat="server">Fee Type</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblclass" runat="server" Text='<%# Bind("feename") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <HeaderTemplate>
                                    <asp:Label ID="lblfeesx" runat="server">Fee</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    Rs&nbsp;<asp:Label ID="txtfees1" runat="server" Text='<%# Bind("fees","{0:f}") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Label runat="server" ID="lbTot1" Text="Total"></asp:Label>
                                </FooterTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <FooterStyle HorizontalAlign="Center" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <HeaderTemplate>
                                    <asp:Label ID="lblTotalx1" runat="server">Total Fee</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    Rs&nbsp;<asp:Label ID="txtTotalfee1" runat="server" Text='<%# Bind("totalfee","{0:f}") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    Rs&nbsp;
                                    <asp:Label runat="server" ID="lblTotalfee1"></asp:Label>
                                </FooterTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <FooterStyle HorizontalAlign="Center" Font-Bold="true" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                        </Columns>

                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
            </tr>

            <%--<tr>
                    <td colspan="3" width="100%" style="text-align:center">
                    </td>
                    </tr>--%>
        </table>
        <div class="for_sigle_row_form" id="tdButton" align="center" colspan="5" valign="middle" runat="server" style="padding: 20px;">
            <%--  <asp:Button runat="server" ID="btn" Text="Print" CssClass="button_save" />--%>

            <%--        <asp:Button ID="btnCancel" Text="BACK" runat="server" CssClass="button_save"
                                    ToolTip="Click here to go to the Home page" onclick="btnCancel_--%>
        </div>

        <div class="for_sigle_row_form" runat="server" id="divButton">
            <label>
            </label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
            <asp:Label ID="lblmsg" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
        </div>
    </div>
</asp:Content>