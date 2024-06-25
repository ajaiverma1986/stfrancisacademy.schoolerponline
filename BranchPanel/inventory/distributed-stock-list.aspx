<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="distributed-stock-list.aspx.cs" Inherits="BranchPanel_inventory_distributed_stock_list" %>

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
            width: 130px;
        }

        .SelectSearch {
            border: 1px solid #cccccc;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 150px;
        }
    </style>



    <div class="branch-div-tbl">
    <div class="tbl-top-heading">
        <h2> Distributed Stock </h2>
        </div>
    <div class="DistributedStockList  ml-10 mr-10 mt-10">
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
            <asp:DropDownList ID="ddltype" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="0">Select Type</asp:ListItem>
                <asp:ListItem Value="1">Student</asp:ListItem>
                <asp:ListItem Value="2">Employee</asp:ListItem>
                <asp:ListItem Value="3">Branch</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlreporttype" CssClass="SelectSearch" runat="server">
                <asp:ListItem Value="2" Selected="True">General Report</asp:ListItem>
                <asp:ListItem Value="1">Breif Report</asp:ListItem>
            </asp:DropDownList>
            <asp:ImageButton ID="ImageButton1" CssClass="btnclear" Width="20px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
        </div>

        <div class="clearfix"></div>

        <div class="DivForBreifDetails ">
            <table style="width: 100%;" class="stm StmForBindDistriButionList">
                <tr class="stm_head">
                    <td>S.No.</td>
                    <td>Date</td>
                    <td>Name</td>
                    <td>Category</td>
                    <td>SubCategory</td>
                    <td>Product</td>
                    <td>Quantity</td>
                    <td>Comment</td>
                    <td>Type</td>
                </tr>
            </table>
        </div>
        <div class="DivForGeneralDetails">
            <table style="width: 100%;" class="stm StmForBindGeneralDistriButionList">
                <tr class="stm_head">
                    <td>S.No.</td>
                    <td>Date</td>
                    <td>Distributed Stock Name</td>
                    <td>Distributed To</td>
                    <td>No. Of Product Distributed</td>
                </tr>
            </table>
        </div>
    </div>
    
        </div>
        <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var DDLMode = 1, DDlBindId = 0, FromDate = '', ToDate = '', Category = 0, SubCategory = 0, Product = 0, Type = 0;
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_txtfromdate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            })
            $('#ctl00_ContentPlaceHolder1_txttodate').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            })
            $('#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                DDLMode = 2, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindDistributedStockList();
            });
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').change(function () {
                DDLMode = 3, DDlBindId = $(this).val();
                BindAllDropDownList();
                FillFieldForSarch();
                BindDistributedStockList();
            });
            $('#ctl00_ContentPlaceHolder1_ddlproduct').change(function () {
                FillFieldForSarch();
                BindDistributedStockList();
            });
            $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_ddlcategory,#ctl00_ContentPlaceHolder1_ddlsubcategory,#ctl00_ContentPlaceHolder1_ddlproduct,#ctl00_ContentPlaceHolder1_ddltype,#ctl00_ContentPlaceHolder1_ddlreporttype').change(function () {
                FillFieldForSarch();
                BindDistributedStockList();
                return false;
            });
            $('.btnclear').click(function () {
                FillClearSarch();
                FillFieldForSarch();
                BindDistributedStockList();
                return false;
            });
            BindAllDropDownList();
            BindDistributedStockList();
        });

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
        function FillFieldForSarch() {
            FromDate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
            ToDate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
            Category = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
            SubCategory = $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val();
            Product = $('#ctl00_ContentPlaceHolder1_ddlproduct').val();
            Type = $('#ctl00_ContentPlaceHolder1_ddltype').val();
        }
        function FillClearSarch() {
            $('#ctl00_ContentPlaceHolder1_txtfromdate').val('');
            $('#ctl00_ContentPlaceHolder1_txttodate').val('');
            $('#ctl00_ContentPlaceHolder1_ddlcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlsubcategory').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlproduct').val('0');
            $('#ctl00_ContentPlaceHolder1_ddltype').val('0');
        }
        function BindDistributedStockList() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "distributed-stock-list.aspx/BindDistributedStockList",
                data: "{'FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','Category':'" + Category + "','SubCategory':'" + SubCategory + "','Product':'" + Product + "','Type':'" + Type + "','Mode':'" + $('#ctl00_ContentPlaceHolder1_ddlreporttype').val() + "'}",
                dataType: "json",
                success: function (data) {
                        if ($('#ctl00_ContentPlaceHolder1_ddlreporttype').val() == '1') {
                            $('.StmForBindDistriButionList').find('tr:gt(0)').remove();
                            $('.StmForBindDistriButionList').append(data.d);
                            $('.DivForGeneralDetails').css("display", "none");
                            $('.DivForBreifDetails').css("display", "block");
                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlreporttype').val() == '2') {
                            $('.StmForBindGeneralDistriButionList').find('tr:gt(0)').remove();
                            $('.StmForBindGeneralDistriButionList').append(data.d);
                            $('.DivForGeneralDetails').css("display", "block");
                            $('.DivForBreifDetails').css("display", "none");
                        }
                        if (data.d == '') {
                            alertify.error('No record found');
                        }
                    FromDate = '', ToDate = '', Category = 0, SubCategory = 0, Product = 0, Type = 0;
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }
    </script>
</asp:Content>