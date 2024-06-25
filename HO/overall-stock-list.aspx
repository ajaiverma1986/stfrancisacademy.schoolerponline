<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="overall-stock-list.aspx.cs" Inherits="HO_overall_stock_list" %>

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
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Overall Stock List</span>
    </div>
    <div class="DivForDailyStockList">
        <div style="width: 100%;">
            <asp:DropDownList ID="ddlcategory" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Category</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlsubcategory" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Subcategory</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlproduct" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Product</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txttiildate" runat="server" CssClass="DateSearch" placeholder="Stock Till Date" Style="height: 25px" onkeypress="return false"></asp:TextBox>
            <asp:DropDownList ID="ddlbranch" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Branch</asp:ListItem>
            </asp:DropDownList>
         <%--    <select style="height:35px; width: 140px; margin-left: 5px;" id="ddlFranchisee"></select>--%>
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
        </div>
        <table style="width: 100%;" class="stm StmStockList">
            <tr class="stm_head">
                <td>S.No.</td>
                <td>Category</td>
                <td>Sub category</td>
                <td>Product</td>
                <td>Total Added Stock</td>
                <td>Total Distributed Stock</td>
                <td>Total Available Stock</td>
                <td>Last Stock Added Date</td>
            </tr>
        </table>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var Category = 0, SubCategory = 0, Product = 0, DDLMode = 1, DDlBindId = 0, TillDate = '', brid = '';
        $(document).ready(function () {
            BindBranch();
            BindFranchisee();
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
            $('#ctl00_ContentPlaceHolder1_ImageButton1').live('click', function () {
                ClearSearchData();
                FillFieldForSearch();
                brid = 0;
                BindStockDetails();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlbranch').live('change', function () {
                brid = $(this).val();
                BindStockDetails();
            });
            $('#ddlFranchisee').live('change', function () {
                brid = $(this).val();
                BindStockDetails();
            });
        });
        function BindStockDetails() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "overall-stock-list.aspx/BindStockList",
                data: "{'Category':'" + Category + "','SubCategory':'" + SubCategory + "','Product':'" + Product + "','TillDate':'" + TillDate + "','brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != '') {
                        $('.StmStockList').find('tr:gt(0)').remove();
                        $('.StmStockList').append(data.d);
                        call_progressbar('end');
                    }
                    else {
                        call_progressbar('end');
                        $('.StmStockList').find('tr:gt(0)').remove();
                        alertify.error('No record found');
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
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
            $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
            $('#ddlFranchisee').val('0');
        }

        function BindBranch() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "stock-list-day-wise.aspx/BindBranch",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlbranch").append($("<option></option>").val(value.Id).html(value.Name));
                    });
                    Branchid = 1;
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('Some Network Issue.');
                },
            });
        }
        function BindFranchisee() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "OverallAdmissions.aspx/BindFranchisee",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlFranchisee").html("");
                    $("#ddlFranchisee").append($("<option></option>").val('0').html('Select Franchisee'));
                    $.each(data.d, function (key, value) {
                        $("#ddlFranchisee").append($("<option></option>").val(value.Id).html(value.Name));

                    });
                    Branchid = 0;
                    call_progressbar("end");
                }
            });
        }
    </script>
</asp:Content>