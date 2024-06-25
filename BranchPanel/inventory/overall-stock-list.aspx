<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="overall-stock-list.aspx.cs" Inherits="BranchPanel_inventory_overall_stock_list" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .SelectSearch {
            border: 1px solid #cccccc;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 200px;
        }

        .DateSearch {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 26px;
            line-height: 20px;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 200px;
        }
    </style>
  

    <div class="branch-div-tbl">

       <div class="tbl-top-heading">
         <h2> Overall Stock List </h2>
           </div>

    <div class="DivForDailyStockList mt-10 ml-10 mr-10">
        <div style="width: 100%;">
            <asp:DropDownList ID="ddlcategory" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Category</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlsubcategory" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Subcategory</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlproduct" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Product</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txttiildate" runat="server" CssClass="DateSearch" placeholder="Stock Till Date" Style="height: 25px" onkeypress="return false"></asp:TextBox>
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
        </div>
        <table style="width: 100%;" class="stm StmStockList">
            <tr class="stm_head">
                <td>S.No.</td>
                <td>Category</td>
                <td>Subcategory</td>
                <td>Product</td>
                <td>Total Added Stock</td>
                <td>Total Distributed Stock</td>
                <td>Total Available Stock</td>
                <td>Last Stock Added Date</td>
            </tr>
        </table>
    </div>

        </div>

    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var Category = 0, SubCategory = 0, Product = 0, DDLMode = 1, DDlBindId = 0, TillDate = '';
        $(document).ready(function () {
            BindStockDetails();
            BindAllDropDownList();
            $('#ctl00_ContentPlaceHolder1_txttiildate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            })
            $('#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                DDLMode = 2, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSearch();
                BindStockDetails();
            });
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').change(function () {
                DDLMode = 3, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSearch();
                BindStockDetails();
            });
            $('#ctl00_ContentPlaceHolder1_ddlproduct,#ctl00_ContentPlaceHolder1_txttiildate').change(function () {
                FillFieldForSearch();
                BindStockDetails();
            });
            $('#ctl00_ContentPlaceHolder1_ImageButton1').click(function () {
                ClearSearchData();
                FillFieldForSearch();
                BindStockDetails();
                return false;
            });
        });
        function BindStockDetails() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-stock-list.aspx/BindStockList",
                data: "{'Category':'" + Category + "','SubCategory':'" + SubCategory + "','Product':'" + Product + "','TillDate':'" + TillDate + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.StmStockList').find('tr:gt(0)').remove();
                    $('.StmStockList').append(data.d);
                    call_progressbar('end');
                    if (data.d == '')
                        alertify.error('No record found');
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }
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
        function BindAllDropDownList() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "stock-list-day-wise.aspx/BindAllDDL",
                data: "{'Id':'" + DDlBindId + "','Mode':'" + DDLMode + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (DDLMode == 1) {
                        $('#ctl00_ContentPlaceHolder1_ddlcategory').html('');
                        $('#ctl00_ContentPlaceHolder1_ddlsubcategory').html('<option value="0">Select Subcategory</option>');
                        $('#ctl00_ContentPlaceHolder1_ddlproduct').html('<option value="0">Select Product</option>');
                        $('#ctl00_ContentPlaceHolder1_ddlcategory').html(data.d);
                    }
                    else if (DDLMode == 2) {
                        $('#ctl00_ContentPlaceHolder1_ddlsubcategory').html('');
                        $('#ctl00_ContentPlaceHolder1_ddlproduct').html('<option value="0">Select Product</option>');
                        $('#ctl00_ContentPlaceHolder1_ddlsubcategory').html(data.d);
                    }
                    else if (DDLMode == 3) {
                        $('#ctl00_ContentPlaceHolder1_ddlproduct').html('');
                        $('#ctl00_ContentPlaceHolder1_ddlproduct').html(data.d);
                    }
                    call_progressbar('end');
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }
        function FillFieldForSearch() {
            Category = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
            SubCategory = $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val();
            Product = $('#ctl00_ContentPlaceHolder1_ddlproduct').val();
            TillDate = $('#ctl00_ContentPlaceHolder1_txttiildate').val();
        }
        function ClearSearchData() {
            $('#ctl00_ContentPlaceHolder1_ddlcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlproduct').val('0');
            $('#ctl00_ContentPlaceHolder1_txttiildate').val('');
        }
    </script>
</asp:Content>