<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="distribute-stock.aspx.cs" Inherits="BranchPanel_inventory_distribute_stock_list" %>

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
            width: 150px;
        }

        .SelectSearch {
            border: 1px solid #cccccc;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 160px;
        }

        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }
    </style>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Distribute Stock</span>
    </div>
    <div class="DistributeNewStock">
        <div class="for_sigle_row_form">
            <label>
                Distribute Stock Name<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtdistributestockname" runat="server" placeholder="Enter The Distribute Stock Name"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Type<span style="color: Red;">* </span>
            </label>
            <asp:DropDownList ID="ddlselecttype" runat="server">
                <asp:ListItem Value="0">Select Employee/Student For Distribute</asp:ListItem>
                <asp:ListItem Value="1">Student</asp:ListItem>
                <asp:ListItem Value="2">Employee</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="SearchStudent" style="display: none">
            <div class="for_sigle_row_form">
                <label>
                    Filter By Course/Batch<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlClass" runat="server" Style="width: 175px">
                    <asp:ListItem Value="0">Select Class</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlSection" runat="server" Style="width: 175px">
                    <asp:ListItem Value="0">Select Section</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="divforsearch" style="display: none">
        </div>
        <div class="for_sigle_row_form  DivStmForSearch" style="display: none">
            <label>
            </label>
            <table style="width: 357px;" class="stm StmForSearch">
                <tr class="stm_head">
                    <td>Select</td>
                    <td>Name</td>
                    <td>AdmissionNo</td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Search Category<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtcategory" runat="server" placeholder="Enter Category Name i.e a,b,c" autocomplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form divforselectcategory">
            <label>
            </label>
            <div style="max-height: 500px; overflow: auto">
                <table style="width: 357px; max-height: 500px; overflow: auto" class="stm stmforcategory">
                    <tr class="stm_head">
                        <td>Select</td>
                        <td>Category</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Search Subcategory<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtsubcategory" runat="server" placeholder="Enter Sub Category Name i.e a,b,c" autocomplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form divforselectsubcategory" style="display: none">
            <label>
            </label>
            <div style="max-height: 500px; overflow: auto">
                <table style="width: 357px; max-height: 500px; overflow: auto" class="stm stmforsubcategory">
                    <tr class="stm_head">
                        <td>Select</td>
                        <td>Subcategory</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Search Product<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtproduct" runat="server" placeholder="Enter Product Name i.e a,b,c" autocomplete="off"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form divforselectproduct" style="display: none">
            <label>
            </label>
            <table style="width: 100%;" class="stm stmforproduct">
                <tr class="stm_head">
                    <td>Select</td>
                    <td>Product</td>
                    <td>Quantity</td>
                    <td>Comment</td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Date<span style="color: Red;">* </span>
            </label>
            <asp:TextBox ID="txtdate" runat="server" placeholder="Select Date Please" autocomplete="off" onkeypress="return false"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save" Style="cursor: pointer" />
            <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="button_cancel" Style="cursor: pointer" />
        </div>
    </div>

    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        var Mode = 0, Id = '', Name = '', SearchingValue = '', SearchMode = 0, AllDistributerId = '', DistributedDate = '', AllProductId = '', AllQuentity = '', AllComment = '', DistributeStockName = '';
        var pid = 0, pdroductamount = 0;
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            }).datepicker("setDate", new Date());
            $('#ctl00_ContentPlaceHolder1_ddlClass,#ctl00_ContentPlaceHolder1_ddlSection').change(function () {
                BindGrid();
            });
            $('#ctl00_ContentPlaceHolder1_ddlselecttype').change(function () {
                $('.DivStmForSearch').css("display", "none");
                $('.StmForSearch').find('tr:gt(0)').remove();
                if ($(this).val() == '1') {
                    $('.SearchStudent').css("display", "block");
                    $('.divforsearch').html('<div class="for_sigle_row_form"><label>Make Your Search<span style="color: Red;">*' +
                   '</span></label><input class="StudentSearch" type="text" autocomplete="off" placeholder="Student Name" /></div>');
                    $('.divforsearch').css("display", "block");
                    $('.DivStmForSearch').css("display", "block");
                    SearchingValue = $(this).val();
                    SearchMode = 1;
                    BindGrid();
                }
                else if ($(this).val() == '2') {
                    $('.SearchStudent').css("display", "none");
                    $('.divforsearch').html('<div class="for_sigle_row_form"><label>Make Your Search<span style="color: Red;">*' +
                   '</span></label><input class="EmployeeSearch" type="text" autocomplete="off" placeholder="Employee Code/Employee Name/Mobile" /></div>');
                    $('.divforsearch').css("display", "block");
                    $('.DivStmForSearch').css("display", "block");
                    SearchingValue = '';
                    SearchMode = 2;
                    BindGrid();
                }
                else {
                    $('.SearchStudent').css("display", "none");
                    $('.divforsearch').html('');
                    $('.divforsearch').css("display", "none");
                    $('.DivStmForSearch').css("display", "none");
                }
            });

            $('#ctl00_ContentPlaceHolder1_txtproduct').keyup(function () {
                Mode = 3, Id = '', Name = '';
                BindValueForBind(Mode);
                Name = $(this).val();
                BindEveryThing();
            });
            $('#ctl00_ContentPlaceHolder1_txtsubcategory').keyup(function () {
                Mode = 2, Id = '', Name = '';
                BindValueForBind(Mode);
                Name = $(this).val();
                BindEveryThing();
            });
            $('#ctl00_ContentPlaceHolder1_txtcategory').keyup(function () {
                Mode = 1, Id = '', Name = '';
                BindValueForBind(Mode);
                Name = $(this).val();
                BindEveryThing();
            });
            $('.chkboxcategory').live('change', function () {
                Mode = 2, Id = '';
                BindValueForBind(Mode);
                BindEveryThing();
                $('.divforselectsubcategory').css("display", "block");
                return false;
            });
            $('.chkboxsubcategory').live('change', function () {
                Mode = 3, Id = '';
                BindValueForBind(Mode);
                BindEveryThing();
                $('.divforselectproduct').css("display", "block");
                return false;
            });

            $('.StudentSearch').live('keyup', function () {
                SearchingValue = $(this).val();
                SearchMode = 1;
                BindGrid()
            });

            $('.EmployeeSearch').live('keyup', function () {
                SearchingValue = $(this).val();
                SearchMode = 2;
                BindGrid();
            });

            $('#ctl00_ContentPlaceHolder1_btnsubmit').click(function () {
                FillFieldForDistributeProduct();
                if (checkvalidation()) {
                    SubmitDistributeData();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
                $('input[type=text]').val('');
                $('.DistributeNewStock').css("display", "none");
                $('.DistributedStockList').css("display", "block");
                $('.spanheading').html('Distributed Stock List:');
                BindGrid();
                return false;
            });

            Mode = 1, Id = '';
            BindValueForBind(Mode);
            BindEveryThing();
        });

        function BindValueForBind(TempMode) {
            if (TempMode == 2) {
                $('.stmforcategory').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                        Id = Id + ',' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                    }
                });
            }
            if (TempMode == 3) {
                $('.stmforsubcategory').find('tr:gt(0)').each(function () {
                    if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                        Id = Id + ',' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                    }
                });
            }
        }

        function BindEveryThing() {
            if (Id == '' && Mode != 1) {
                if (Mode == 2) {
                    $('.stmforsubcategory').find('tr:gt(0)').remove();
                    $('.stmforproduct').find('tr:gt(0)').remove();
                    $('.divforselectproduct').css("display", "none");
                    $('.stmforsubcategory').append('');
                    $('.divforselectsubcategory').css("display", "none");
                    call_progressbar('end');
                }
                else if (Mode == 3) {
                    $('.stmforproduct').find('tr:gt(0)').remove();
                    $('.stmforproduct').append('');
                    $('.divforselectproduct').css("display", "none");
                    call_progressbar('end');
                }
                return fasle;
            }
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-stock.aspx/BindEveryThing",
                data: "{'Id':'" + Id + "','Mode':'" + Mode + "','Name':'" + Name + "'}",
                dataType: "json",
                success: function (data) {
                    if (Mode == 1) {
                        $('.stmforcategory').find('tr:gt(0)').remove();
                        $('.stmforsubcategory').find('tr:gt(0)').remove();
                        $('.stmforproduct').find('tr:gt(0)').remove();
                        $('.divforselectsubcategory').css("display", "none");
                        $('.divforselectproduct').css("display", "none");
                        $('.stmforcategory').append(data.d);
                        if (data.d == '') {
                            alertify.error('No Category Added In The System');
                        }
                        call_progressbar('end');
                    }
                    else if (Mode == 2) {
                        $('.stmforsubcategory').find('tr:gt(0)').remove();
                        $('.stmforproduct').find('tr:gt(0)').remove();
                        $('.divforselectproduct').css("display", "none");
                        $('.divforselectsubcategory').css("display", "block");
                        $('.stmforsubcategory').append(data.d);
                        if (data.d == '') {
                            alertify.error('No Subcategory For The Selected Category.');
                            $('.divforselectsubcategory').css("display", "none");
                        }
                        call_progressbar('end');
                    }
                    else if (Mode == 3) {
                        $('.stmforproduct').find('tr:gt(0)').remove();
                        $('.stmforproduct').append(data.d);
                        $('.divforselectproduct').css("display", "block");
                        if (data.d == '') {
                            alertify.error('No Product For The Selected SubCategory.');
                            $('.divforselectproduct').css("display", "none");
                        }
                        call_progressbar('end');
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
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
        function BindGrid() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "distribute-stock.aspx/BindSearchingGrid",
                data: "{'SearchMode':'" + SearchMode + "','SearchingValue':'" + SearchingValue + "','Section':'" + $('#ctl00_ContentPlaceHolder1_ddlSection').val() + "','Class':'" + $('#ctl00_ContentPlaceHolder1_ddlClass').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('.StmForSearch').find('tr:gt(0)').remove();
                    $('.StmForSearch').append(data.d)
                    if (data.d == '') {
                        alertify.error('No Record Found First Add The Record.');
                    }
                    call_progressbar('end');
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }
        function FillFieldForDistributeProduct() {
            AllProductId = '', DistributeStockName = '', DistributedDate = '', AllQuentity = '', AllComment = '', SearchMode = 0, AllDistributerId = '';
            $('.stmforproduct').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                    AllProductId = AllProductId + '~' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                    AllQuentity = AllQuentity + '~' + $(this).find('td:eq(2)').find('input[type=text]').val()
                    AllComment = AllComment + '~' + $(this).find('td:eq(3)').find('input[type=text]').val()
                }
            });
            DistributedDate = $('#ctl00_ContentPlaceHolder1_txtdate').val();
            DistributeStockName = $('#ctl00_ContentPlaceHolder1_txtdistributestockname').val();
            SearchMode = $('#ctl00_ContentPlaceHolder1_ddlselecttype').val();
            $('.StmForSearch').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                    AllDistributerId = AllDistributerId + '~' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                }
            });
        }

        function SubmitDistributeData() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "distribute-stock.aspx/DistributeProduct",
                data: "{'DistributerType':'" + SearchMode + "','DistributerId':'" + AllDistributerId + "','AllProductId':'" + AllProductId + "','AllQuentity':'" + AllQuentity + "','AllComment':'" + AllComment + "','DistributedDate':'" + DistributedDate + "','DistributeStockName':'" + DistributeStockName + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Product Distributed Sucessfully.');
                    }
                    else if (data.d == 2) {
                        alertify.success('Some Error Occur While Stock Is Added.');
                    }
                    SearchMode = 0, AllDistributerId = '', AllProductId = '', AllQuentity = '', AllComment = '', DistributedDate = '';
                    call_progressbar('end');
                },
                error: function (result) {
                    call_progressbar("end");
                },
            });
        }

        //Code For Manage Validation Start Here

        function checkvalidation() {
            status = 1;
            if (DistributeStockName == '') {
                document.getElementById('<%= txtdistributestockname.ClientID %>').className = "texthover";
                status = 0;
            }
            if (AllProductId == '') {
                document.getElementById('<%= txtproduct.ClientID %>').className = "texthover";
                status = 0;
            }
            if (DistributedDate == '') {
                document.getElementById('<%= txtdate.ClientID %>').className = "texthover";
                status = 0;
            }
            $('.stmforproduct').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').is(':checked')) {
                    if ($(this).find('td:eq(2)').find('.txtquantity').val() == '') {
                        $(this).find('td:eq(2)').find('.txtquantity').addClass("texthover");
                        status = 0;
                    }
                    if ($(this).find('td:eq(3)').find('.txtdescription').val() == '') {
                        $(this).find('td:eq(3)').find('.txtdescription').addClass("texthover");
                        status = 0;
                    }
                }
            });
            if (status == 1) {
                return true;
            }
            else {
                return false;
            }
        }

        $("#ctl00_ContentPlaceHolder1_txtdistributestockname").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdistributestockname").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtproduct").focus(function () { $("#ctl00_ContentPlaceHolder1_txtproduct").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtdate").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdate").removeClass("texthover"); });
        $(".txtquantity").live('focus', function () { $(this).parent('td').parent('tr').find(".txtquantity").removeClass("texthover"); });
        $(".txtdescription").live('focus', function () { $(this).parent('td').parent('tr').find(".txtdescription").removeClass("texthover"); });

        $('.chkboxproduct').live('change', function () {
            $("#ctl00_ContentPlaceHolder1_txtproduct").removeClass("texthover");
            if ($(this).is(':checked')) {
                $(this).parent('td').parent('tr').find('input[type=text]').attr("readonly", false);
            }
            else {
                $(this).parent('td').parent('tr').find('.txtquantity').removeClass("texthover");
                $(this).parent('td').parent('tr').find('.txtdescription').removeClass("texthover");
                $(this).parent('td').parent('tr').find('input[type=text]').val('');
                $(this).parent('td').parent('tr').find('input[type=text]').prop('readonly', true);
            }
        })

        $('.txtquantity').live('on change paste', function () {
            pid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
            pdroductamount = $(this).val();
            available_product();
        });

        function available_product() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "distribute-stock.aspx/CheckProduct",
                data: "{'pid':'" + pid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 0) {
                        alertify.error('Product is not available');
                    }
                    if (data.d < pdroductamount && data.d != 0) {
                        alert("Only " + data.d + " Product is available");
                    }
                }
            });
        }
        //Code For Manage Validation End Here
    </script>
</asp:Content>