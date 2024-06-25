<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="viewtimetable.aspx.cs" Inherits="BranchPanel_Timetable_viewtimetable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <asp:UpdatePanel ID="UPModulePermission" runat="server">
            <ContentTemplate>
                 <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Classwise Time Table View</h2>
        </div>
                <div class="for_sigle_row_form">
                    <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Class:<span style="color: red">*</span></label>
                    <asp:DropDownList ID="ddlclass" runat="server" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Section:<span style="color: red">*</span></label>
                    <asp:DropDownList ID="ddlsection" runat="server" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
                <div id="divfordownload" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="btnprint" runat="server" Text="Print"
                        CausesValidation="false" Height="20px" CssClass="btnprint" Style="float: right;"
                        ToolTip="Click here to Print sheet" />
                </div>
                <div id="divforprint" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
                <div class="for_sigle_row_form divforgrid">
                    <asp:GridView ID="grdtimetable" runat="server" CssClass="stm" AutoGenerateColumns="true" GridLines="None" Width="100%">
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        $(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                //$("[id*=grdtimetable]").find('tr:eq(1)').remove();
                $("[id*=grdtimetable]").find('tr:eq(0)').addClass('stm_head');
                $("[id*=grdtimetable]").find('tr:gt(0):odd').addClass('stm_dark');
                $("[id*=grdtimetable]").find('tr:gt(0):even').addClass('stm_light');
                $("[id*=grdtimetable]").find('tr').find('td:nth-child(2)').remove();
                $("[id*=grdtimetable]").find('tr').find('th:eq(1)').remove();
                $("[id*=grdtimetable]").find('tr').find('th:eq(0)').html('S.NO');
                $("[id*=grdtimetable]").find('tr').find('th:eq(2)').html('PeriodTime');
                $("[id*=grdtimetable]").find('tr').find('th:eq(1)').html('PeriodName');
                var i = 1;
                $("[id*=grdtimetable]").find('tr:gt(0)').each(function () {
                    $(this).find('td:eq(0)').html(i);
                    i++;
                });
                $(".BtnExcel").click(function (e) {
                    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                        if (e) {
                            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforgrid').html()));
                            e.preventDefault();
                        }
                    });
                    return false;
                });
                $('.btnprint').click(function () {
                    var printWindow = window.open('left=500,top=500,width=500,height=500');
                    printWindow.document.write($('.divforgrid').html());
                    printWindow.document.close();
                    printWindow.focus();
                    printWindow.print();
                    printWindow.close();
                });
                $('#ctl00_ContentPlaceHolder1_ddlsection').change(function () {
                    $('#divfordownload').show();
                    $('#divforprint').show();
                });
            });
        });
    </script>
</asp:Content>

