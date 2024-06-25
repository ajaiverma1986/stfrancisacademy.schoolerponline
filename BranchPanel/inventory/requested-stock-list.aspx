<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="requested-stock-list.aspx.cs" Inherits="BranchPanel_inventory_requested_stock_list" %>

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

        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }
    </style>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Requested Stock List To Branch</span>
    </div>
    <div class="DivForDailyStockList">
        <div style="width: 100%;">
            <asp:TextBox ID="txtfromdate" runat="server" CssClass="DateSearch" placeholder="Select From Date" Style="height: 25px" onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" CssClass="DateSearch" placeholder="Select To Date" Style="height: 25px" onkeypress="return false"></asp:TextBox>
            <asp:DropDownList ID="ddlcategory" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Category</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlsubcategory" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Subcategory</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlproduct" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Product</asp:ListItem>
            </asp:DropDownList>
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
        </div>
        <table style="width: 100%;" class="stm StmStockList">
            <tr class="stm_head">
                <td>S.No.</td>
                <td>Date</td>
                <td>Branch</td>
                <td>Stock Name</td>
                <td>Category</td>
                <td>Subcategory</td>
                <td>Product</td>
                <td>Status</td>
                <td>Remark</td>
                <td>Details</td>
              <%--  <td>Edit</td>--%>
                <td>Delete</td>
            </tr>
        </table>
    </div>
    <div class="DivForDailyStockListDetails" style="display: none">
        <div class="pop-headng-sty">
            Requested Stock Deatils Of Requested Stock [<span class="stockname"></span>]
        <a id="A1" title="Close this from here" class="btnClose">
            <img src="../../images/no.png" alt="No Image" class="ImgCloseStockDetails" /></a>
        </div>
        <table style="width: 100%;" class="stm StmStockListDetails">
            <tr class="stm_head">
                <td>SNo.</td>
                <td>Category</td>
                <td>Subcategory</td>
                <td>Product</td>
                <td>Requested Quantity</td>
                <td>Your Description</td>
                <td>Approve Quantity</td>
                <td>Approve Description</td>
            </tr>
        </table>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:TextBox ID="txtremark" runat="server" placeholder="Enter Remark For Receive Please" CssClass="DateSearch" Style="width: 350px"></asp:TextBox>
                    <asp:TextBox ID="txtrecivedate" runat="server" placeholder="Select Receive Date Please" CssClass="DateSearch"></asp:TextBox>
                    <asp:Button ID="btnforrecivestock" runat="server" CssClass="button_save" Text="Receive" Style="margin-left: 50px; margin-top: 10px" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var Id = 0, Mode = 1, FromDate = '', ToDate = '', Category = '', SubCategory = '', Product = '', DDLMode = 1, DDlBindId = 0, Remark = '', DateForSubmit = '', StockRequestId = 0, stockstatus = 0;
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_txtrecivedate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            }).datepicker("setDate", new Date());
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
                stockstatus = $(this).parent('td').parent('tr').find('td:eq(7)').find('input[type=hidden]').val();
                BindRequestedStock();
                $('.DivForDailyStockListDetails').css("display", "block");
                $('.stockname').html($(this).parent('td').parent('tr').find('td:eq(3)').html());
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
                BindRequestedStock();
                return false;
            });
            $('.btnclear').click(function () {
                FillClearSarch();
                FillFieldForSarch();
                BindRequestedStock();
                return false;
            });
            $('.ImgCloseStockDetails').click(function () { $('.DivForDailyStockListDetails').css("display", "none"); });
            $('#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                DDLMode = 2, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindRequestedStock();
            });
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').change(function () {
                DDLMode = 3, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindRequestedStock();
            });
            $('#ctl00_ContentPlaceHolder1_ddlproduct').change(function () {
                FillFieldForSarch();
                BindRequestedStock();
            });
            $('#ctl00_ContentPlaceHolder1_btnforrecivestock').click(function () {
                Remark = $('#ctl00_ContentPlaceHolder1_txtremark').val();
                DateForSubmit = $('#ctl00_ContentPlaceHolder1_txtrecivedate').val();
                StockRequestId = Id;
                if (stockstatus == 1) {
                    alertify.error("Your Request Is Not Seen By The Requested Branch So Product Recive Is Not Possible.");
                }
                else if (stockstatus == 2) {
                    alertify.error("Your Request Is In Process.So Recive Is Not Possible.");
                }
                else if (stockstatus == 3) {
                    alertify.error("Your Request Is Rejected By The Requested Branch.So Recive Is Not Possible.");
                }
                else {
                    if (checktextbox()) {
                        SubmitData();
                    }
                }
                return false;
            });
            BindRequestedStock();
            BindAllDropDownList()
        });

        function BindRequestedStock() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requested-stock-list.aspx/BindRequestedStockList",
                data: "{'Id':'" + Id + "','Mode':'" + Mode + "','FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','Category':'" + Category + "','SubCategory':'" + SubCategory + "','Product':'" + Product + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (Mode == 1) {
                        $('.StmStockList').find('tr:gt(0)').remove();
                        $('.StmStockList').append(data.d);
                    }
                    else if (Mode == 2) {
                        $('.StmStockListDetails').find('tr:gt(0)').remove();
                        $('.StmStockListDetails').append(data.d);
                    }
                    DDLMode = 1, Mode = 1;
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

        function SubmitData() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "requested-stock-list.aspx/ReciveStock",
                data: "{'Remark':'" + Remark + "','Date':'" + DateForSubmit + "','StockRequestId':'" + StockRequestId + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Stock Recived Sucessfully.');
                    }
                    else if (data.d == 2) {
                        alertify.success('Some Error Occur While Stock Is Reciving.');
                    }
                    Remark = '', Date = '', StockRequestId = '0';
                    call_progressbar('end');
                },
                error: function (result) {
                    alertify.success('Some Error Here');
                    call_progressbar("end");
                },
            });
        }

        //Code for validation start here
        function checktextbox() {
            var status = 1;
            if (Remark == '') {
                $('#ctl00_ContentPlaceHolder1_txtremark').addClass('texthover');
                status = 0;
            }
            if (DateForSubmit == '') {
                $('#ctl00_ContentPlaceHolder1_txtrecivedate').addClass('texthover');
                status = 0;
            }
            if (status == 0) {
                return false;
            }
            else {
                return true;
            }
        }
        $("#ctl00_ContentPlaceHolder1_txtremark").focus(function () { $("#ctl00_ContentPlaceHolder1_txtremark").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtrecivedate").focus(function () { $("#ctl00_ContentPlaceHolder1_txtrecivedate ").removeClass("texthover"); });
        //code for validation End here
    </script>
</asp:Content>