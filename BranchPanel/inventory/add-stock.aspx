<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="add-stock.aspx.cs" Inherits="BranchPanel_inventory_add_stock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .texthover {
            border: dotted 1px white !important;
            background-color: #FD3018 !important;
            color: white !important;
        }
    </style>


        <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">

 <div class="tbl-top-heading"> <h2>Add Stock </h2> </div>
    <div class="for_sigle_row_form">
        <label>
            Stock Name<span style="color: Red;">* </span>
        </label>
        <asp:TextBox ID="txtstockname" runat="server" placeholder="Enter Stock Name Please" autocomplete="off"></asp:TextBox>
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
                <td style="width:50px">Quantity</td>
                <td>Description</td>
            </tr>
        </table>
    </div>
    <div class="for_sigle_row_form">
        <label>
            Date<span style="color: Red;">* </span>
        </label>
        <asp:TextBox ID="txtdateforaddstock" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
    </div>
    <div class="for_sigle_row_form">
        <label>
        </label>
        <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save" Style="cursor: pointer" />
        <asp:Button ID="btncancel" runat="server" Text="Clear" CssClass="button_cancel" Style="cursor: pointer" />
    </div>


</div>


    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">

        var Mode = 0, Id = '', Name = '';

        var AllProduct = '', AllSubCategory = '', AllCategory = '', StockName = '', DateD = '', AllQuantity = '', AllDescription = '', status = 0;

        $(document).ready(function () {
            Mode = 1, Id = '';
            BindValueForBind(Mode);
            BindEveryThing();
            $('#ctl00_ContentPlaceHolder1_txtdateforaddstock').datepicker({
                dateFormat: "dd MM yy",
                maxDate: new Date()
            }).datepicker("setDate", new Date());
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
            $('#ctl00_ContentPlaceHolder1_btnsubmit').live('click', function () {
                FillFieldForAddStock();
                if (checkvalidation()) {
                    SubmitData();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
                $('input[type=text]').val('');
                return false;
            });
            $('.chkboxcategory').live('change', function () {
                $("#ctl00_ContentPlaceHolder1_txtcategory").removeClass("texthover");
                Mode = 2, Id = '';
                BindValueForBind(Mode);
                BindEveryThing();
                $('.divforselectsubcategory').css("display", "block");
                return false;
            });
            $('.chkboxsubcategory').live('change', function () {
                $("#ctl00_ContentPlaceHolder1_txtsubcategory").removeClass("texthover");
                Mode = 3, Id = '';
                BindValueForBind(Mode);
                BindEveryThing();
                $('.divforselectproduct').css("display", "block");
                $('.stmforproduct').find('.txtquantity').attr('readonly', true);
                return false;
            });
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
            });
        });

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

        function FillFieldForAddStock() {
            AllCategory = '', AllSubCategory = '', AllProduct = '', AllQuantity = '', AllDescription = '', StockName = '', DateD = '';
            $('.stmforcategory').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                    AllCategory = AllCategory + '~' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                }
            });
            $('.stmforsubcategory').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                    AllSubCategory = AllSubCategory + '~' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                }
            });
            $('.stmforproduct').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(0)').find('input[type=checkbox]').attr('checked') == 'checked') {
                    AllProduct = AllProduct + '~' + $(this).find('td:eq(0)').find('input[type=hidden]').val()
                    AllQuantity = AllQuantity + '~' + $(this).find('td:eq(2)').find('input[type=text]').val()
                    AllDescription = AllDescription + '~' + $(this).find('td:eq(3)').find('input[type=text]').val()
                }
            });
            StockName = $('#ctl00_ContentPlaceHolder1_txtstockname').val();
            DateD = $('#ctl00_ContentPlaceHolder1_txtdateforaddstock').val();
        }

        function SubmitData() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "add-stock.aspx/AddStock",
                data: "{'StockName':'" + StockName + "','AllCategory':'" + AllCategory + "','AllSubCategory':'" + AllSubCategory + "','AllProduct':'" + AllProduct + "','AllQuantity':'" + AllQuantity + "','AllDescription':'" + AllDescription + "','Date':'" + DateD + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Stock Added Successfully.');
                    }
                    else if (data.d == 2) {
                        alertify.success('Some Error Occur While Stock Is Added.');

                    }
                    StockName = '', AllCategory = '', AllSubCategory = '', AllProduct = '', AllQuantity = '', AllDescription = '', DateD = '';
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
            if (StockName == '') {
                document.getElementById('<%= txtstockname.ClientID %>').className = "texthover";
                status = 0;
            }
            if (AllCategory == '') {
                document.getElementById('<%= txtcategory.ClientID %>').className = "texthover";
                status = 0;
            }
            if (AllSubCategory == '') {
                document.getElementById('<%= txtsubcategory.ClientID %>').className = "texthover";
                status = 0;
            }
            if (AllProduct == '') {
                document.getElementById('<%= txtproduct.ClientID %>').className = "texthover";
                status = 0;
            }
            if (DateD == '') {
                document.getElementById('<%= txtdateforaddstock.ClientID %>').className = "texthover";
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
            if (status == 0) {
                return false;
            }
            else {
                return true;
            }
        }

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;
            return true;
        };
        $("#ctl00_ContentPlaceHolder1_txtstockname").focus(function () { $("#ctl00_ContentPlaceHolder1_txtstockname").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtcategory").focus(function () { $("#ctl00_ContentPlaceHolder1_txtcategory").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtsubcategory").focus(function () { $("#ctl00_ContentPlaceHolder1_txtsubcategory").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtproduct").focus(function () { $("#ctl00_ContentPlaceHolder1_txtproduct").removeClass("texthover"); });
        $("#ctl00_ContentPlaceHolder1_txtdateforaddstock").focus(function () { $("#ctl00_ContentPlaceHolder1_txtdateforaddstock").removeClass("texthover"); });
        $(".txtquantity").live('focus', function () { $(this).parent('td').parent('tr').find(".txtquantity").removeClass("texthover"); });
        $(".txtdescription").live('focus', function () { $(this).parent('td').parent('tr').find(".txtdescription").removeClass("texthover"); });
        //Code For Manage Validation End Here
    </script>
</asp:Content>