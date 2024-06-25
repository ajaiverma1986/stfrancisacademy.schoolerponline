<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddProduct.aspx.cs" Inherits="HO_AddProduct" %>

<%@ Register Src="~/HO/hocategorycontrol.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .active2 {
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
            margin-top: -4px;
        }
    </style>
    <script type="text/javascript">
        function pageLoad() {
            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {
                var catvalue = parseInt($("#ctl00_ContentPlaceHolder1_ddlCategory").val());
                if (catvalue == 0) {
                    alert("Please select a category!!");
                    $("#ctl00_ContentPlaceHolder1_ddlCategory").focus();
                    return false;
                }
                var subcatvalue = parseInt($("#ctl00_ContentPlaceHolder1_ddlSubCate").val());
                if (subcatvalue == 0) {
                    alert("Please select a sub-category!!");
                    $("#ctl00_ContentPlaceHolder1_ddlSubCate").focus();
                    return false;
                }
                var pname = $("#ctl00_ContentPlaceHolder1_txtPName").val();
                if (pname.trim() == "") {
                    alert("Please enter product name!!");
                    $("#ctl00_ContentPlaceHolder1_txtPName").focus();
                    return false;
                }
                var pcode = $("#ctl00_ContentPlaceHolder1_txtPcode").val();
                if (pcode.trim() == "") {
                    alert("Please enter product code!!");
                    $("#ctl00_ContentPlaceHolder1_txtPcode").focus();
                    return false;
                }
            });
        };
    </script>
    <style type="text/css">
        .center {
            background-color: White;
            text-align: center;
            margin-right: 20px;
            width: 1135px;
            margin: 0 auto !important;
        }
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "addproduct.aspx/BindDatatoDropdown",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        $("#ddlCategory").append($("<option></option>").val(value.CountryId).html(value.CountryName));
                    });
                },
                error: function (result) {
                    alert("Error");
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnNP").click(function () {
                if ($('#tbl1').is(":hidden")) {
                    $('#div1').show(500);
                    $('#divtop').show(500);

                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%=ddlCategory.ClientID %>').change(function () {
                var id = $('#<%=ddlCategory.ClientID %>').val();
                if (id != "--Select State--") {
                    $('#<%=ddlSubCate.ClientID %>').html("");
                    $.getJSON("Responce.aspx?id=" + id, function (citys) {
                        $.each(citys, function () {
                            $('#<%=ddlSubCate.ClientID %>').append($("<option></option>").val(this['ID']).html(this['CityName']));
                        });
                    });
                }
            });
            $('#<%=ddlSubCate.ClientID %>').change(function () {
                var cityid = $('#<%=ddlSubCate.ClientID %>').html();
                alert(cityid);
            });
        });
    </script>
    <%--<div class="center">
    </div>--%>
    <asp:UpdatePanel runat="server" ID="upd">
        <ContentTemplate>
            <div class="content_top">
                <ul>
                    <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
                    <li><a href="AddProduct.aspx">Manage Inventory</a></li>
                    <li style="background: none;"><a class="active" href="#">
                        <asp:Label runat="server" ID="lbltop" Text="Product List"></asp:Label></a></li>
                </ul>
                <div class="arrowt">
                    <a href="AddProduct.aspx">
                        <img src="../images/back-button.png"></a>
                </div>
            </div>
            <div class="clear">
            </div>
            <div class="content_pane_cont input_content" id="contentPane">
                <My:stu runat="server" ID="MyUserInfoBoxControl" />
                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    <asp:Label runat="server" ID="lblhead" Text="Product List"></asp:Label>
                    <asp:Button runat="server" ID="btnNP" Text="New Product" ToolTip="Click here to add a new product."
                        CssClass="button_save45" OnClick="btnNP_Click" />
                </div>
                <div class="div_form" runat="server" id="div1">
                    <div class="for_sigle_row_form" style="position: relative;">
                        <label>
                            Select Category<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCategory" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Sub-Category<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlSubCate" AutoPostBack="true" OnSelectedIndexChanged="ddlSubCate_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form" id="divtop" runat="server">
                        <label>
                            Select Topic/s</label>
                        <div style="height: 100px; width: 310px; position: relative; border: 1px solid #ddd; overflow-x: hidden; /* horizontal */    overflow-y: auto; /* vertical */clear: right">
                            <asp:GridView ID="grd1" runat="server" BorderWidth="0px" BorderColor="White" AutoGenerateColumns="false"
                                Width="310px" ShowHeader="false" GridLines="none" CssClass="stm">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk1" AutoPostBack="true" runat="server" OnCheckedChanged="chk1_CheckedChanged" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblcourse" runat="server" Text='<% #Bind("topicname")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Product Name<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtPName" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Product Code<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtPcode" runat="server"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Active</label>
                        <asp:CheckBox runat="server" ID="cbactive" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button runat="server" ID="btnSubmit" ToolTip="Click here to save this product."
                            Text="Submit" CssClass="button_save" OnClick="btnSubmit_Click" />
                    </div>
                </div>
                <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;"
                    runat="server" id="tbl1">
                    <tr>
                        <td align="left" colspan="4" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView ID="Grid_Country" AutoGenerateColumns="false" BorderWidth="0" Width="100%"
                                GridLines="None" runat="server" CssClass="stm" OnRowCommand="Grid_Country_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="S No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="4%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Product Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpname" Text='<%# Eval("pname") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Product Code">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcname" Text='<%# Eval("pcode") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpcode" Text='<%# Eval("Status") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit0" CommandArgument='<%# Eval("pID") %>'
                                                ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                        </ItemTemplate>
                                        <ItemStyle Width="7%" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>