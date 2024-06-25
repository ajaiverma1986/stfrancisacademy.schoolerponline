<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="stock-list-day-wise.aspx.cs" Inherits="HO_stock_list_day_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
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

        .SelectSearch {
            border: 1px solid #cccccc;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 200px;
        }

        .DivForDailyStockListDetails {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            opacity: 1;
            display: block;
            padding-bottom: 8px !important;
            top: 9%;
            width: 82% !important;
            max-height: 585px;
            background: #F6F6F6 !important;
            overflow-style: scrollbar;
        }
    </style>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Day Wise Stock List</span>
    </div>
    <div class="DivForDailyStockList">
        <div style="width: 100%;">
            <asp:TextBox ID="txtfromdate" runat="server" CssClass="DateSearch" placeholder="Select From Date" Style="height: 25px; width: 129px" onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" CssClass="DateSearch" placeholder="Select To Date" Style="height: 25px; width: 129px" onkeypress="return false"></asp:TextBox>
            <asp:DropDownList ID="ddlcategory" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Category</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlsubcategory" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Sub Category</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlproduct" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Product</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlbranch" CssClass="SelectSearch" runat="server" Width="140px">
                <asp:ListItem Value="0">Select Branch</asp:ListItem>
            </asp:DropDownList>
           <%--  <select style="height:35px; width: 140px; margin-left: 5px;" id="ddlFranchisee"></select>--%>
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
        </div>
        <table style="width: 100%;" class="stm StmStockList">
            <tr class="stm_head">
                <td>S.No.</td>
                <td>Date</td>
                <td>Stock Name</td>
                <td>Category</td>
                <td>Sub Category</td>
                <td>Product</td>
                <td>Details</td>
            </tr>
        </table>
    </div>
    <div class="DivForDailyStockListDetails" style="display: none">
        <div class="pop-headng-sty">
            Stock Deatils Of Stock [<span class="stockname"></span>]
        <a id="A1" title="Close this from here" class="btnClose">
            <img src="../images/no.png" alt="No Image" class="ImgCloseStockDetails" /></a>
        </div>
        <table style="width: 100%;" class="stm StmStockListDetails">
            <tr class="stm_head">
                <td>S.No.</td>
                <td>Category</td>
                <td>Subcategory</td>
                <td>Product</td>
                <td>Quantity</td>
                <td>Description</td>
            </tr>
        </table>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var Id = 0, Mode = 1, FromDate = '', ToDate = '', Category = '', SubCategory = '', Product = '', DDLMode = 1, DDlBindId = 0, brid = '';
        $(document).ready(function () {
            BindBranch();
            BindFranchisee();
            $('#ctl00_ContentPlaceHolder1_txtfromdate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            })
            $('#ctl00_ContentPlaceHolder1_txttodate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            })
            $('.Details').live('click', function () {
                Id = $(this).parent('td').parent('tr').find('td:eq(0)').find('input[type=hidden]').val(), Mode = 2
                BindStock();
                $('.DivForDailyStockListDetails').css("display", "block");
                $('.stockname').html($(this).parent('td').parent('tr').find('td:eq(2)').html());
                return false;
            });
            $('.Edit').live('click', function () {
                alert('Edit Not Working.');
                return false;
            });
            $('.Delete').live('click', function () {
                alert('Delete Not Working.');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate').change(function () {
                FillFieldForSarch();
                BindStock();
                return false;
            });
            $('.btnclear').click(function () {
                FillClearSarch();
                FillFieldForSarch();
                brid = 0;
                BindStock();
                $('.Details').attr('src', '../images/viewquestion.png');
                $('.Edit').attr('src', '../images/edit.png');
                $('.Delete').attr('src', '../images/ic.png');
                return false;
            });
            $('.ImgCloseStockDetails').click(function () { $('.DivForDailyStockListDetails').css("display", "none"); });
            $('#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                DDLMode = 2, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindStock();
            });
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').change(function () {
                DDLMode = 3, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindStock();
            });
            $('#ctl00_ContentPlaceHolder1_ddlproduct').change(function () {
                FillFieldForSarch();
                BindStock();
            });
            $('#ctl00_ContentPlaceHolder1_ddlbranch').live('change', function () {
                brid = $(this).val();
                BindStock();
            });
            $('#ddlFranchisee').live('change', function () {
                brid = $(this).val();
                BindStock();
                return false;
            });
            BindStock();
            $('.Details').attr('src', '../images/viewquestion.png');
            $('.Edit').attr('src', '../images/edit.png');
            $('.Delete').attr('src', '../images/ic.png');
            BindAllDropDownList();
        });

        function BindStock() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "stock-list-day-wise.aspx/BindStockList",
                data: "{'Id':'" + Id + "','Mode':'" + Mode + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','Category':'" + Category + "','SubCategory':'" + SubCategory + "','Product':'" + Product + "','brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != '') {
                        if (Mode == 1) {
                            $('.StmStockList').find('tr:gt(0)').remove();
                            $('.StmStockList').append(data.d);
                        }
                        else if (Mode == 2) {
                            $('.StmStockListDetails').find('tr:gt(0)').remove();
                            $('.StmStockListDetails').append(data.d);
                        }
                    }
                    else {
                        $('.StmStockList').find('tr:gt(0)').remove();
                        $('.StmStockListDetails').find('tr:gt(0)').remove();
                        alertify.error('No record found');
                    }
                    DDLMode = 1, Mode = 1, Id = 0;
                    call_progressbar('end');
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

        function FillFieldForSarch() {
            FromDate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
            ToDate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
            Category = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
            SubCategory = $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val();
            Product = $('#ctl00_ContentPlaceHolder1_ddlproduct').val();
            Mode = 1;
            Id = 0;
        }

        function FillClearSarch() {
            $('#ctl00_ContentPlaceHolder1_txtfromdate').val('');
            $('#ctl00_ContentPlaceHolder1_txttodate').val('');
            $('#ctl00_ContentPlaceHolder1_ddlcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlproduct').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
            $('#ddlFranchisee').val('0');
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