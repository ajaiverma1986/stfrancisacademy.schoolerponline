<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="list-of-holiday.aspx.cs" Inherits="BranchPanel_commonpage_list_of_holiday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        #ContentPlaceHolder1_Grid_Calender a {
            cursor: pointer !important;
        }

        #ContentPlaceHolder1_Grid_Calender td {
            border-left: 2px solid #CDCDCD !important;
            height: 50px !important;
        }

        #ContentPlaceHolder1_Grid_Calender {
            border: 2px solid #CDCDCD !important;
        }
    </style>
    <script type="text/javascript">
        var month = "0", BrId = "0";
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }

        $(document).ready(function () {
            DatePicker();
            $('#ctl00_ContentPlaceHolder1_ddlmonth,#ctl00_ContentPlaceHolder1_ddlbranch').change(function () {
                DatePicker();
            })
        });

        function DatePicker() {
            month = $('#ctl00_ContentPlaceHolder1_ddlmonth').val()
            BrId = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();;
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "list-of-holiday.aspx/BindDbDatePicker",
                data: "{'month':'" + month + "','BrId':'" + BrId + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=Grid_Calender] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=Grid_Calender] tr:eq(1)").clone(true);
                            $("[id$=Grid_Calender]").append(row);
                            $(row).find('.Sun').html(data.d[i].sun);
                            $(row).find('.Mon').html(data.d[i].mon);
                            $(row).find('.Tue').html(data.d[i].tue);
                            $(row).find('.Wed').html(data.d[i].wed);
                            $(row).find('.Thu').html(data.d[i].thu);
                            $(row).find('.Fri').html(data.d[i].fri);
                            $(row).find('.Sat').html(data.d[i].sat);
                        }

                        $("[id*=Grid_Calender] tr").show();
                        $("[id*=Grid_Calender] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>

    <div class="content_pane_cont branch-div-tbl" id="contentPane">

        <div class="tbl-top-heading">
            <h2>Holiday List</h2>
        </div>

        <div class="containerHeadline searchbar">
            <div class="clear"></div>
            <asp:DropDownList ID="ddlmonth" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="ddlbranch" runat="server" Style="height: 31px; width: 260px; margin-left: 0px" OnSelectedIndexChanged="ddlbranch_SelectedIndexChanged"></asp:DropDownList>
            <div class="clear"></div>
        </div>

        <div class="clear"></div>

        <div class="responsive-grid-sty m-r-sm m-l-sm">

            <asp:GridView runat="server" ID="Grid_Calender" ShowHeader="true" AutoGenerateColumns="false" Border="0" GridLines="None" Width="100%" CssClass="stm responsive-table-sty">
                <Columns>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Sunday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblsunday" runat="server" Text='<%# Eval("Sun") %>' CssClass="Sun" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Monday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblmonday" runat="server" Text='<%# Eval("Mon") %>' CssClass="Mon" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Tuesday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lbltuesday" runat="server" Text='<%# Eval("Tue") %>' CssClass="Tue" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Wednesday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblwednesday" runat="server" Text='<%# Eval("Wed") %>' CssClass="Wed" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Thursday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblthrsday" runat="server" Text='<%# Eval("Thr") %>' CssClass="Thu" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Friday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblfriday" runat="server" Text='<%# Eval("Fri") %>' CssClass="Fri" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Saturday" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblsaturday" runat="server" Text='<%# Eval("Sat") %>' CssClass="Sat" Enabled="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>

        <div class="clear"></div>
        <div id="divProgressBar" class="progress"></div>

        <div class="clear"></div>
    </div>
</asp:Content>