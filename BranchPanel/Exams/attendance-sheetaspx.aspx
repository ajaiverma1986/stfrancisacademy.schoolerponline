<%@ Page Title="Attendance Sheet" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="attendance-sheetaspx.aspx.cs" Inherits="BranchPanel_Exams_attendance_sheetaspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function PrintPanel() {
            var panel = document.getElementById("<%=Panel1.ClientID %>");
            var printWindow = window.open('', '', 'height=500,width=500');
            printWindow.document.write('<html><head><title>Singh Study Circle</title>');
            printWindow.document.write('</head><body >');
            printWindow.document.write(panel.innerHTML);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            setTimeout(function () {
                printWindow.print();
            }, 500);
            return false;
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="testlist.aspx">Exam List</a></li>
            <li style="background: none;"><a class="active">Exam Attendance Sheet</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <br />
    <div class="clear">
    </div>
    <asp:Panel runat="server" ID="Panel1">
        <div class="content_pane_cont input_content" id="contentPane">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                class="containerHeadline">
                Attendance Sheet
            </div>
            <br />

            <div class="for_sigle_row_form">

                <asp:Label runat="server" ID="lblbatch"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Class :
                </label>
                <asp:Label runat="server" ID="lblClass"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Subject :
                </label>
                <asp:Label runat="server" ID="lblSub"></asp:Label>
            </div>
            <div class="for_sigle_row_form">

                <asp:Label runat="server" ID="lblTopic"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date :
                </label>
                <asp:Label runat="server" ID="lblDate"></asp:Label>
            </div>
            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">
                <tr>
                    <td align="left" colspan="3" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                        <asp:GridView runat="server" ID="gvdetails" AllowPaging="true" PageSize="50" AutoGenerateColumns="false"
                            Width="100%" CssClass="stm" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="name" HeaderText="Student Name" runat="server" DataFormatString="{0:dd/MM/yyyy}"
                                    ItemStyle-Width="12%" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Attendance" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="sno2" runat="server" Text="_________"> </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="13%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                        <br />
                    </td>
                </tr>
                <%-- <tr>
                    <td>
                    </td>
                </tr>--%>
                <tr>
                    <td></td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <div class="for_sigle_row_form">
        <label>
        </label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnPdf" Text="Export to PDF" CssClass="button_save"
            ToolTip="Click here to print the pdf file for this data."
            OnClientClick="return PrintPanel();" OnClick="btnPdf_Click" />
    </div>
</asp:Content>