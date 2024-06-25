<%@ Page Title="" Language="C#" MasterPageFile="~/ParentPanel/MasterPage.master" AutoEventWireup="true" CodeFile="dayworkreport.aspx.cs" Inherits="ParentPanel_dayworkreport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            getclasswork();
        });
        function getclasswork() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "dayworkreport.aspx/getclassworkdetails",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_grdclass").show(500);
                        $("[id*=grdclass] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=grdclass] tr:eq(1)").clone(true);

                            $("[id$=grdclass]").append(row);
                            $(row).find('.topiclecture').html(data.d[i].topiclecture);
                            $(row).find('.classwork').html(data.d[i].classwork);
                            $(row).find('.homework').html(data.d[i].homework);
                            $(row).find('.name').html(data.d[i].name);
                            $(row).find('.mobile').html(data.d[i].mobile);
                            $(row).find('.SubjectName').html(data.d[i].SubjectName);
                        }
                        $("[id*=grdclass] tr").show();
                        $("[id*=grdclass] tr:eq(1)").hide();
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_grdclass").hide(500);
                    }
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
    </script>
    <div class="page-content">
        <div class="page-header">
            <h1><a href="studentviewinfo.aspx">Home</a>
                <small>
                    <i class="ace-icon fa fa-angle-double-right"></i>
                    Class & Homework Details
                </small>
            </h1>
        </div>
        <div class="row">
            <asp:TextBox runat="server" ID="txtToDate" Placeholder="Change Date" Style="float: right; margin-top: -34px; margin-right: 5px;"></asp:TextBox>
            <asp:GridView ID="grdclass" AutoGenerateColumns="false" overflow="scroll"
                runat="server" CssClass="table table-striped table-bordered table-hover" GridLines="None" EmptyDataText="No Month added in this branch" Width="99.3%" Style="margin-left: 1.6px; border-left: 1px solid #ddd; margin-bottom: 1px;">
                <Columns>

                    <asp:TemplateField HeaderText="Subject">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("SubjectName") %>' CssClass="SubjectName"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="7%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Lecture">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("topiclecture") %>' CssClass="topiclecture"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="20%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="class Work">
                        <ItemTemplate>
                            <asp:Label ID="lblpaystatus" runat="server" Text='<%# Bind("classwork") %>' CssClass="classwork"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="20%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Homework">
                        <ItemTemplate>
                            <asp:Label ID="lblPayable" runat="server" Text='<%# Bind("homework") %>' CssClass="homework"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="20%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Teacher">
                        <ItemTemplate>
                            <asp:Label ID="lblPaid" runat="server" Text='<%# Bind("name") %>' CssClass="name"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Contact">
                        <ItemTemplate>
                            <asp:Label ID="lblPaid" runat="server" Text='<%# Bind("mobile") %>' CssClass="mobile"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="stm_dark" />
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <AlternatingRowStyle CssClass="stm_light" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>