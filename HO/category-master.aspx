<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="category-master.aspx.cs" Inherits="HO_category_master" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        #divgrid {
            width: 100%;
        }

        .trcolorchange {
            background-color: #DBDBDB !important;
        }

            .trcolorchange td {
                color: black !important;
            }

        th {
            border-bottom: 1px solid #CDCDCD !important;
        }

        #ctl00_ContentPlaceHolder1_txt_category {
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

        select {
            border: 1px solid #cccccc;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 200px;
        }

        .stm a {
            cursor: pointer !important;
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
            width: 340px;
        }
    </style>
    <div class="main-div-tbl">
        <div class="student-photo_frame content_top1" style="height: 128px;">
            <div class="clear">
            </div>
            <div class="student-photo_frame_img">

                <img id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_imgstu" src="../images/smaster.png" style="border-width: 0px;">
            </div>

            <div style="float: left;">
                <div class="user-deatils">
                    <dl>
                        <span id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname">Category Master</span>
                    </dl>
                </div>

                <div class="clear">
                </div>
            </div>
            <div class="clear">
            </div>
            <div style="margin-bottom: -3px; margin-top: 10.5px;">
                <a style="cursor: pointer" id="btncatmaster" class="active3">Category List</a>

                <a style="cursor: pointer" id="btnsubcategory" class="active7 sgpt1">Sub Category List</a>

                <a style="cursor: pointer" id="btnproduct" class="active7 sgpt1">Product List</a>
            </div>
        </div>
    </div>
    <div class="for_sigle_row_form">
        <div class="clear"></div>
        <div style="width: 100%;">

            <asp:TextBox ID="txt_category" runat="server" placeholder="Search By Category" Style="text-transform: capitalize;"></asp:TextBox>
            <select id="ddl_category" style="width: 200px; display: none"></select>
            <select id="ddl_sub_category" style="width: 200px; display: none"></select>
            <select id="Select1" style="width: 200px; display: none"></select>
            <select id="Select2" style="width: 200px; display: none"></select>
            <select id="ddl_product" style="width: 200px; display: none"></select>
            <asp:ImageButton ID="ImageButton1" Width="25px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." Style="display: none" />
            <a id="btnaddtext" class="active7 sgpt1" style="cursor: pointer; float: right; margin-right: 61px;">Add Category</a>
            <a id="btnaddsubcategory" class="active7 sgpt1" style="cursor: pointer; display: inline-block; float: right; margin-right: 25px;">Add Sub Category</a>
            <a id="btnaddproduct" class="active7 sgpt1" style="cursor: pointer; display: inline-block; float: right; margin-right: 29px;">Add Product</a>
        </div>
    </div>
    <div class="clear"></div>
    <div id="addcategory" style="display: none">
        <div class="for_sigle_row_form">
            <table style="width: 100%" class="maintrforaddremoveexam">
                <tr>
                    <td>
                        <label>
                            Category Name<span style="color: Red;">* </span>
                        </label>
                        <asp:TextBox ID="txttest" runat="server" placeholder="Enter The Category Name" Style="text-transform: capitalize"></asp:TextBox>
                        <img src="../images/add.png" style="width: 16px; cursor: pointer; position: relative; bottom: 3px; margin-left: -4px" alt="No Image" class="imageforadd" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="btnfeetype" runat="server" Text="Submit" CssClass="button_save" />
            <asp:Button ID="btnupdate" runat="server" Text="Update" CssClass="button_save" />

            <a id="btnback" class="button2">Back</a>
        </div>
    </div>
    <div class="clear"></div>
    <div id="categorylist" style="padding-bottom: 10px;">

        <table class="stm categorylist" width="100.00%">
            <tr class="stm_head">
                <th>S.No.</th>
                <th>Category Name</th>
                <th>Status</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 200px; display: none">
            <label style="font-size: 15px; color: red">Sorry Category name not available according to your searching.</label>
        </div>
    </div>
    <div class="clear"></div>
    <div id="subcategory" style="padding-bottom: 10px; display: none;">

        <table class="stm stmforsubcategory" width="100.00%">
            <tr class="stm_head">
                <th>S.No.</th>
                <th>Category Name</th>
                <th>Sub Category Name</th>
                <th>Status</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="divnorecordfound1" style="margin-left: 200px; display: none">
            <label style="font-size: 15px; color: red">Sorry Subcategory name not available according to your searching.</label>
        </div>
    </div>
    <div class="clear"></div>
    <div id="productlist" style="padding-bottom: 10px; display: none;">

        <table class="stm stmforproductlist" width="100.00%">
            <tr class="stm_head">
                <th>S.No.</th>
                <th>Category</th>
                <th>Subcategory</th>
                <th>Product</th>
                <th>Product Code</th>
                <th>Product Description</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="divnorecordfound2" style="margin-left: 200px; display: none">
            <label style="font-size: 15px; color: red">Sorry Product name not available according to your searching.</label>
        </div>
    </div>
    <div class="clear"></div>
    <div id="addproduct" style="display: none">
        <div class="for_sigle_row_form">

            <label>
                Select Category<span style="color: Red;">* </span>
            </label>
            <asp:DropDownList ID="ddlselectcategory" runat="server"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Sub Category<span style="color: Red;">* </span>
            </label>
            <asp:DropDownList ID="ddlselectsubcategory" runat="server"></asp:DropDownList>
        </div>
        <div class="AddMultipleProduct">
            <div class="ProductDetails">
                <div class="for_sigle_row_form">
                    <label>
                        Product Name<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtproductname" runat="server" CssClass="Productname" Style="text-transform: capitalize" placeholder="Enter Product Name"></asp:TextBox>
                    <img src="../images/add.png" style="width: 16px; cursor: pointer; position: relative; bottom: 3px; margin-left: -4px" alt="No Image" class="imageforaddproduct" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Product Code<span style="color: Red;"> </span>
                    </label>
                    <asp:TextBox ID="txtproductcode" runat="server" CssClass="Productcode" Style="text-transform: capitalize" placeholder="Enter the Product Code"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Product Description<span style="color: Red;"></span>
                    </label>
                    <asp:TextBox ID="product_description" runat="server" Height="150" TextMode="MultiLine" CssClass="Productdescription" Style="text-transform: capitalize" placeholder="Enter Product Description"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="button_save" />
            <asp:Button ID="Button2" runat="server" Text="Update" CssClass="button_save" />

            <a id="btnbackproduct" class="button2">Back</a>
        </div>
    </div>
    <div class="clear"></div>
    <div id="addsubcategory" style="display: none">
        <div class="for_sigle_row_form">
            <label>
                Category<span style="color: Red;">* </span>
            </label>
            <asp:DropDownList ID="ddlcategory" runat="server"></asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <table style="width: 100%" class="table2">
                <tr>
                    <td>
                        <label>
                            SubCategory Name<span style="color: Red;">* </span>
                        </label>
                        <asp:TextBox ID="txtcategoryname" runat="server" Style="text-transform: capitalize" placeholder="Enter Subcategory Name"></asp:TextBox>
                        <img src="../images/add.png" style="width: 16px; cursor: pointer; position: relative; bottom: 3px; margin-left: -4px" alt="No Image" class="imageforaddsubcategory" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="Button3" runat="server" Text="Submit" CssClass="button_save" />
            <asp:Button ID="Button4" runat="server" Text="Update" CssClass="button_save" />

            <a id="btnbacksub" class="button2">Back</a>
        </div>
    </div>
    <script type="text/javascript">
        var Categoryid = 0, Pid = 0, CategoryName = '', SubCategoryName = '', CID = 0, scid = 0, PName = '', allcategoryname = '';
        $('#categorylist').show(500)
        $('#btnaddproduct,#addcategory,#Select2,#btnaddsubcategory,#ddl_category,#ddl_sub_category,#ddl_product,#Select1').hide(500)
        $('#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1').show(500)

        $(document).ready(function () {
            BindGrid();
            $('#btncatmaster').click(function () {
                $('#addproduct,#addsubcategory,#btnaddproduct,#btnaddsubcategory,#ddl_category,#ddl_sub_category,#ddl_product,#Select1,#Select2,#addcategory,#subcategory,#productlist').hide(500);
                $('#btnaddtext,#categorylist,#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1').show(500);
                $('#btncatmaster').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('#btnsubcategory,#btnproduct').removeClass('active3').addClass('active7').addClass('sgpt1');
            });
            $('#btnaddtext').click(function () {
                $('#ctl00_ContentPlaceHolder1_txttest').css('border', '');
                $('.imageforadd,#addcategory,#ctl00_ContentPlaceHolder1_btnfeetype').show(500);
                $('#addproduct,#categorylist,#btnaddtext,#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1,#ctl00_ContentPlaceHolder1_btnupdate').hide(500);
                $('.maintrforaddremoveexam tr:gt(0)').remove();
                Clearfunction();
            });
            $('.imageforadd').click(function () {
                var trforadd = '<tr><td><div class="for_sigle_row_form"><label>Category Name</label> <input ID="txttest1" type=text placeholder="Enter The Category Name" class="inputaddremoveexam"/  Style="text-transform: capitalize" ><img class="imageforsub" style="width: 16px; cursor: pointer; position:relative;bottom: 2px;" alt="No Image" src="../images/minus.png"></div></td></tr>'
                $('.maintrforaddremoveexam').append(trforadd);
                return false;
            });
            $('.imageforsub').live("click", function () {
                $(this).parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('#btnsubcategory').click(function () {
                CID = 0;
                scid = 0;
                $('#btnsubcategory').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('#btnproduct,#btncatmaster').removeClass('active3').addClass('active7').addClass('sgpt1');
                $('#categorylist,#productlist,#ctl00_ContentPlaceHolder1_txt_category,#btnaddtext,#Select1,#Select2,#ddl_product,#addproduct,#btnaddproduct,#addcategory,#addsubcategory').hide(500);
                $('#subcategory,#ddl_category,#ddl_sub_category,#ctl00_ContentPlaceHolder1_ImageButton1,#btnaddsubcategory').show(500);
                Bindsubcategoryy();
                categoryddl();
            });
            $('#btnaddsubcategory').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlcategory').css('border', '');
                $('#ctl00_ContentPlaceHolder1_txtcategoryname').css('border', '');
                $('.table2 tr:gt(0)').remove();
                $('#addproduct,#ddl_sub_category,#ddl_category,#subcategory,#ctl00_ContentPlaceHolder1_ImageButton1,#btnaddsubcategory,#ctl00_ContentPlaceHolder1_Button4').hide(500)
                $('.imageforaddsubcategory,#addsubcategory,#ctl00_ContentPlaceHolder1_Button3').show(500)
                category_ddl();
                Clearfunction();
            });
            $('.imageforaddsubcategory').click(function () {
                var trforadd = '<tr><td><div class="for_sigle_row_form"><label>SubCategory Name</label> <input ID="txttest1" type=text placeholder="Enter Subcategory Name" class="inputaddremoveexam"/  Style="text-transform: capitalize"><img class="imageforsub1" style="width: 16px; cursor: pointer; position:relative;bottom: 2px;" alt="No Image" src="../images/minus.png"></div></td></tr>'
                $('.table2').append(trforadd);
                return false;
            });
            $('.imageforsub1').live("click", function () {
                $(this).parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('#btnproduct').click(function () {
                CID = 0;
                scid = 0;
                Pid = 0;
                $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('#btncatmaster,#btnsubcategory').removeClass('active3').addClass('active7').addClass('sgpt1');
                $('#productlist,#Select1,#Select2,#ddl_product,#ctl00_ContentPlaceHolder1_ImageButton1,#btnaddproduct').show(500);
                $('#addproduct,#addcategory,#addsubcategory,#btnaddsubcategory,#ctl00_ContentPlaceHolder1_txt_category,#btnaddtext,#subcategory,#categorylist,#ddl_sub_category,#ddl_category').hide(500);
                Bind_table_product();
                categoryddl();
                $('#ddl_product').html('<option value="0">---Select Product---</option>');

            });
            $('#btnaddproduct').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlselectcategory').css('border', '');
                $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').css('border', '');
                $('#ctl00_ContentPlaceHolder1_txtproductname').css('border', '');
                $('.imageforaddproduct,#addproduct,#ctl00_ContentPlaceHolder1_Button1').show(500);
                $('#ctl00_ContentPlaceHolder1_Button2,#ctl00_ContentPlaceHolder1_ImageButton1,#productlist,#btnaddproduct,#ddl_product,#Select2,#Select1').hide(500);
                $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('.ProductDetails tr:gt(0)').remove();
                category_ddl();
                Clearfunction();
            });
            $('.imageforaddproduct').click(function () {
                var trforadd = '<div class="ProductDetails"><div class="for_sigle_row_form"><label>Product Name<span style="color: Red;">* </span></label>' +
                               '<input class="Productname" type="text" Style="text-transform: capitalize" placeholder="Enter Product Name" /><img class="imageforsubproduct" alt="No Image" style="width: 16px; cursor: pointer; position: relative; bottom: 3px;" src="../images/minus.png">' +
                               '</div><div class="for_sigle_row_form"><label>Product Code<span style="color: Red;"> </span></label><input class="Productcode" type="text" Style="text-transform: capitalize" placeholder="Enter Product Code" />' +
                               '</div><div class="for_sigle_row_form"><label>Product Description<span style="color: Red;"> </span></label>' +
                               '<textarea class="Productdescription" style="height:150px;text-transform: capitalize" placeholder="Enter Product Description" cols="20" rows="2"></textarea></div></div>'
                $(this).parent('div').parent('div').parent('div').append(trforadd);
                return false;
            });
            $('.imageforsubproduct').live("click", function () {
                $(this).parent('div').parent('div').remove();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnfeetype").click(function () {
                var allcategoryname = '';
                if (CheckValidation()) {
                    $('.maintrforaddremoveexam tbody tr').find('input[type=text]').each(function () {
                        if ($(this).val() != "") {
                            allcategoryname = allcategoryname + ',' + $(this).val();
                        }
                    });
                    allcategoryname = allcategoryname.slice(1, allcategoryname.length);
                    SaveCategory(allcategoryname);
                    $('#categorylist,#btnaddtext,#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1').show(500)
                    $('#addcategory').hide(500)
                    $('#btncatmaster').addClass('active3').removeClass('active7').removeClass('sgpt1')
                }
                return false;
            });

            //validation
            function CheckValidation() {
                var status = 1
                //validation for category
                if ($('#ctl00_ContentPlaceHolder1_txttest').val() == '') {
                    $('#ctl00_ContentPlaceHolder1_txttest').css('border', '3px solid red');
                    status = 0;
                }
                else {
                    return true;
                }
                //end of category validation
                //validation for sub category
                if ($('#ctl00_ContentPlaceHolder1_ddlcategory').val() <= 0) {
                    $('#ctl00_ContentPlaceHolder1_ddlcategory').css('border', '3px solid red');
                    status = 0;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtcategoryname').val() == '') {
                    $('#ctl00_ContentPlaceHolder1_txtcategoryname').css('border', '3px solid red');
                    status = 0;
                }
                else {
                    return true;
                }
                //end of sub category validation
                // validation for product
                if ($('#ctl00_ContentPlaceHolder1_ddlselectcategory').val() <= 0) {
                    $('#ctl00_ContentPlaceHolder1_ddlselectcategory').css('border', '3px solid red');
                    status = 0;
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').val() <= 0) {
                    $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').css('border', '3px solid red');
                    status = 0;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtproductname').val() == '') {
                    $('#ctl00_ContentPlaceHolder1_txtproductname').css('border', '3px solid red');
                    status = 0;
                }
                else {
                    return true;
                }
                //end of product validation
                if (status == 0) {
                    return false;
                }
                else {
                    return true;
                }
            }
            //end of validation

            //remove validation of category
            $('#ctl00_ContentPlaceHolder1_txttest').click(function () {
                $('#ctl00_ContentPlaceHolder1_txttest').css('border', '');
            })
            //end of validation of category
            //remove validation of sub category
            $('#ctl00_ContentPlaceHolder1_ddlcategory').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlcategory').css('border', '');
            })
            $('#ctl00_ContentPlaceHolder1_txtcategoryname').click(function () {
                $('#ctl00_ContentPlaceHolder1_txtcategoryname').css('border', '');
            })
            //end of validation of sub category
            //remove validation of product
            $('#ctl00_ContentPlaceHolder1_ddlselectcategory').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlselectcategory').css('border', '');
            })
            $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').css('border', '');
            })
            $('#ctl00_ContentPlaceHolder1_txtproductname').click(function () {
                $('#ctl00_ContentPlaceHolder1_txtproductname').css('border', '');
            })
            //end of validation of product

            $("#ctl00_ContentPlaceHolder1_Button3").click(function () {
                var allsubcategoryname = '', cid = 0;
                if (CheckValidation()) {
                    var cid = $("#ctl00_ContentPlaceHolder1_ddlcategory").val();
                    $('.table2 tbody tr').find('input[type=text]').each(function () {
                        if ($(this).val() != "") {
                            allsubcategoryname = allsubcategoryname + ',' + $(this).val();
                        }
                    });
                    allsubcategoryname = allsubcategoryname.slice(1, allsubcategoryname.length);
                    SaveSubcategory(cid, allsubcategoryname);
                    $('#subcategory,#btnaddsubcategory,#ddl_category,#ddl_sub_category').show(500)
                    $('#addsubcategory').hide(500)
                    $('#btnsubcategory').addClass('active3').removeClass('active7').removeClass('sgpt1')
                    $('#btnaddsubcategory').removeClass('active3').addClass('active7').addClass('sgpt1')
                    Bindsubcategoryy();
                }
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                var Allproductname = '', AllProductCode = '', AllDescription = '';
                if (CheckValidation()) {
                    $('#addproduct').find('.AddMultipleProduct').find('.Productname').each(function () {
                        Allproductname = Allproductname + ',' + $(this).val();
                    });
                    $('#addproduct').find('.AddMultipleProduct').find('.Productcode').each(function () {
                        AllProductCode = AllProductCode + ',' + $(this).val();
                    });
                    $('#addproduct').find('.AddMultipleProduct').find('.Productdescription').each(function () {
                        AllDescription = AllDescription + ',' + $(this).val();
                    });
                    Allproductname = Allproductname.slice(1, Allproductname.length);
                    AllProductCode = AllProductCode.slice(1, AllProductCode.length);
                    AllDescription = AllDescription.slice(1, AllDescription.length);
                    SaveProduct(Allproductname, AllProductCode, AllDescription);
                    $('#btnaddproduct,#productlist,#ddl_product,#Select1,#Select2,#ctl00_ContentPlaceHolder1_ImageButton1').show(500)
                    $('#addproduct').hide(500)
                    $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1')
                    $('#btnaddproduct,#btncatmaster').removeClass('active3').addClass('active7').addClass('sgpt1')
                    $(this).parent('div').parent('div').find('.AddMultipleProduct').find('.ProductDetails:gt(0)').remove();
                }
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_ddlselectcategory").val() == "0") {
                    alertify.error("Please Select Category Name.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_ddlselectsubcategory").val() == "0") {
                    alertify.error("Please Select SubCategory Name.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_txtproductname").val() == "") {
                    alertify.error("Please Enter Product Name.");
                    return false;
                }
                $('#ddl_sub_category,#addproduct').hide(500);
                $('#btnaddproduct,#productlist,#ddl_product,#Select1,#Select2').show(500);
                $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('#btnaddproduct,#btncatmaster').removeClass('active3').addClass('active7').addClass('sgpt1');
                Updateproduct();
                Bind_table_product();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnupdate").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_txttest").val() == "") {
                    alertify.error("Please Enter Category Name.");
                    return false;
                }
                $('#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1,#btnaddtext,#categorylist').show(500)
                $('#addcategory').hide(500)
                $('#btncatmaster').addClass('active3').removeClass('active7').removeClass('sgpt1')
                Updatecategory();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_Button4").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_ddlcategory").val() == "0") {
                    alertify.error("Please Enter Category Name.");
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_txtcategoryname").val() == "") {
                    alertify.error("Please Enter Sub Category Name.");
                    return false;
                }
                $('#btnaddsubcategory,#ddl_sub_category,#ddl_category,#subcategory,#ctl00_ContentPlaceHolder1_ImageButton1').show(500)
                $('#addsubcategory').hide(500)
                $('#btnsubcategory').addClass('active3').removeClass('active7').removeClass('sgpt1')
                UpdateSubcategory();
                Bindsubcategoryy();
                return false;
            });
            $('.edit').live('click', function () {
                CID = 0;
                CID = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('.imageforadd,#addproduct,#categorylist,#btnaddtext,#ctl00_ContentPlaceHolder1_ImageButton1,#ctl00_ContentPlaceHolder1_btnfeetype,#ctl00_ContentPlaceHolder1_txt_category').hide(500)
                $('#addcategory,#ctl00_ContentPlaceHolder1_btnupdate').show(500)
                $('.maintrforaddremoveexam tr:gt(0)').remove();
                Edit2(CID);
                return false;
            });
            $('.editsubcategory').live('click', function () {
                if (parseInt($(this).parent('td').find('input[type=hidden]').val()) == 1) {
                    alertify.error("You Can Not Edit The Sub category Because It's Category Has Deleted");
                    return false;
                }
                SCID = 0;
                SCID = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type=hidden]').val();
                $('.imageforaddsubcategory,#btnaddsubcategory,#ctl00_ContentPlaceHolder1_ImageButton1,#ddl_sub_category,#ddl_category,#Select2,#subcategory,#ctl00_ContentPlaceHolder1_Button3').hide(500);
                $("#addsubcategory,#ctl00_ContentPlaceHolder1_Button4").show();
                $('.table2 tr:gt(0)').remove();
                category_ddl();
                Edit1(SCID);
                return false;
            });
            $('.editproduct').live('click', function () {
                if (parseInt($(this).parent('td').find('input[type=hidden][id*=SubCategoryIsDeleted]').val()) == 1) {
                    alertify.error("You Can Not Edit The Product Because It's Sub Category Has Deleted");
                    return false;
                }
                else if (parseInt($(this).parent('td').find('input[type=hidden][id*=CategoryIsDeleted]').val()) == 1) {
                    alertify.error("You Can Not Edit The Product Because It's Category Has Deleted");
                    return false;
                }
                Pid = 0;
                Pid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('.imageforaddproduct,#btnaddproduct,#productlist,#ctl00_ContentPlaceHolder1_Button1,#Select1,#ddl_product,#ctl00_ContentPlaceHolder1_ImageButton1,#Select2').hide(500);
                $('#addproduct,#ctl00_ContentPlaceHolder1_Button2').show(500);
                $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1')
                Editproduct(Pid);
                return false;
            });
            $("#btnback").click(function () {
                $('#addcategory').hide(500);
                $('#categorylist,#btnaddtext,#ctl00_ContentPlaceHolder1_txt_category,#ctl00_ContentPlaceHolder1_ImageButton1').show(500);
                $('#btncatmaster').addClass('active3').removeClass('active7').removeClass('sgpt1');
                return false;
            });
            $("#btnbacksub").click(function () {
                $('#addsubcategory').hide(500);
                $('#btnaddsubcategory,#subcategory,#ddl_category,#ddl_sub_category,#ctl00_ContentPlaceHolder1_ImageButton1').show(500);
                $('#btnsubcategory').addClass('active3').removeClass('active7').removeClass('sgpt1')
                $('#btnaddsubcategory').removeClass('active3').addClass('active7').addClass('sgpt1')
                return false;
            });
            $("#btnbackproduct").click(function () {
                $('#ddl_sub_category,#addproduct').hide(500);
                $('#btnaddproduct,#productlist,#ddl_product,#Select1,#Select2,#ctl00_ContentPlaceHolder1_ImageButton1').show(500);
                $('#btnproduct').addClass('active3').removeClass('active7').removeClass('sgpt1');
                $('#btnaddproduct').removeClass('active3').addClass('active7').addClass('sgpt1');
                $(this).parent('div').parent('div').find('.AddMultipleProduct').find('.ProductDetails:gt(0)').remove();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_txt_category").keyup(function () {
                CategoryName = '';
                CategoryName = $("#ctl00_ContentPlaceHolder1_txt_category").val();
                BindGrid();
                return false;
            });
            $("#ddl_category").change(function () {
                CID = 0;
                CID = $("#ddl_category").val();
                Bindsubcategoryy();
                $('#ddl_sub_category').html('<option value="0">---Select Subcategory---</option>');
                Subcategoryddl();
                return false;
            });
            $("#ddl_sub_category").change(function () {
                scid = 0;
                scid = $("#ddl_sub_category").val();
                Bindsubcategoryy();
                return false;
            });
            $("#Select1").change(function () {
                CID = 0;
                CID = $("#Select1").val();
                Bind_table_product();
                $('#Select2').html('<option value="0">---Select Subcategory---</option>');
                Subcategoryddl();
                return false;
            });
            $("#Select2").change(function () {
                scid = 0;
                scid = $("#Select2").val();
                Bind_table_product();
                $('#ddl_product').html('<option value="0">---Select Product---</option>');
                bind_product_ddl();
                return false;
            });
            $("#ddl_product").change(function () {
                Pid = 0;
                Pid = $("#ddl_product").val();
                Bind_table_product();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlselectcategory").change(function () {
                CID = 0;
                CID = $("#ctl00_ContentPlaceHolder1_ddlselectcategory").val();
                Subcategoryddl();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ImageButton1").live('click', function () {
                CID = 0, scid = 0, Pid = 0;
                CategoryName = "";
                $("#ctl00_ContentPlaceHolder1_txt_category").val('');
                BindGrid();
                $("#ddl_category").val('0');
                $('#ddl_sub_category').html('<option value="0">---Select Subcategory---</option>');
                Bindsubcategoryy();
                $("#Select1").val('0');
                $('#Select2').html('<option value="0">---Select Subcategory---</option>');
                $('#ddl_product').html('<option value="0">---Select Product---</option>');
                Bind_table_product();
                return false;
            });
            $('.Delete').live('click', function () {
                if (confirm("Are you sure? you want to delete this")) {
                    CID = 0;
                    CID = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    Deletecategory();
                }
                return false;
            });
            $('.Deletesubcategory').live('click', function () {
                if (confirm("Are you sure you want to delete this?")) {
                    scid = 0;
                    scid = $(this).parent('td').parent('tr').find('input[type=hidden]:eq(1)').val();
                    DeleteSubcategory();
                }
                return false;
            });
            $('.Deleteproduct').live('click', function () {
                if (confirm("Are you sure you want to delete this?")) {
                    Pid = 0;
                    Pid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    Deleteproduct();
                }
                return false;
            });
        });
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
        function BindGrid() {
            $('.categorylist tr:gt(0)').remove();
            call_progressbar('start')
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/BindGridByJs",
                data: "{'CategoryName':'" + CategoryName + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].CategoryName + '<input type="hidden" value="' + data.d[i].CID + '" />' +
                                    '<td>' + data.d[i].satatus + '' +
                                    '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="edit"></img></td>' +
                            '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Delete"></img></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                     '<td>' + data.d[i].CategoryName + '<input type="hidden" value="' + data.d[i].CID + '" />' +
                                    '<td>' + data.d[i].satatus + '' +
                                    '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="edit"></img></td>' +
                            '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Delete"></img></td></tr>';
                            $('.categorylist').append(trforappend);
                        }
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                }
            });
        }
        function Bindsubcategoryy() {
            call_progressbar("start");
            $('.stmforsubcategory tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Bindsubcategory",
                data: "{'cid':'" + CID + "','scid':'" + scid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound1').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var trcolor = "";
                            if (parseInt(data.d[i].Isdeleted) == 1) {
                                trcolor = "trcolorchange";
                            }
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_light ' + trcolor + '"><td>' + (i + 1) + '</td>' +
                                    '<td>' + data.d[i].CategoryName + '<input type="hidden" value="' + data.d[i].CID + '" />' +
                                    '<td>' + data.d[i].SubCategoryName + '<input type="hidden" value="' + data.d[i].SCID + '" />' +
                                    '<td>' + data.d[i].SubCategoryStatus + '' +
                                    '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="editsubcategory"></img><input type="hidden" value="' + data.d[i].Isdeleted + '" /></td>' +
                                     '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Deletesubcategory"></img></td></tr>';
                            }
                            else {
                                trforappend = '<tr class="stm_dark ' + trcolor + '"><td>' + (i + 1) + '</td>' +
                                     '<td>' + data.d[i].CategoryName + '<input type="hidden" value="' + data.d[i].CID + '" />' +
                                     '<td>' + data.d[i].SubCategoryName + '<input type="hidden" value="' + data.d[i].SCID + '" />' +
                                     '<td>' + data.d[i].SubCategoryStatus + '' +
                                     '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="editsubcategory"></img><input type="hidden" value="' + data.d[i].Isdeleted + '" /></td>' +
                                     '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Deletesubcategory"></img></td></tr>';
                            }
                            $('.stmforsubcategory').append(trforappend);
                            call_progressbar("end");
                        }
                    }
                    else {
                        $('.divnorecordfound1').css('display', 'inline');
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                }
            });
            return false;
        }
        function Bind_table_product() {
            call_progressbar("start");
            $('.stmforproductlist tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Bindproductdetail",
                data: "{'cid':'" + CID + "','scid':'" + scid + "','Pid':'" + Pid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.divnorecordfound2').css('display', 'none');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var trcolor = "";
                            if (parseInt(data.d[i].CategoryIsDeleted) == 1) {
                                trcolor = "trcolorchange";
                            }
                            else if (parseInt(data.d[i].SubCategoryIsDeleted) == 1) {
                                trcolor = "trcolorchange";
                            }
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_light ' + trcolor + '"><td>' + (i + 1) + '</td>' +
                                   '<td>' + data.d[i].CategoryName + '' +
                                   '<td>' + data.d[i].SubCategoryName + '' +
                                   '<td>' + data.d[i].PName + '<input type="hidden" value="' + data.d[i].Pid + '" />' +
                                   '<td>' + data.d[i].Pcode + '' +
                                   '<td>' + data.d[i].product_description + '' +
                                   '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="editproduct"></img>' +
                                   '<input id="CategoryIsDeleted" type="hidden" value="' + data.d[i].CategoryIsDeleted + '" />' +
                                   '<input Id="SubCategoryIsDeleted" type="hidden" value="' + data.d[i].SubCategoryIsDeleted + '" /></td>' +
                                   '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Deleteproduct"></img></td></tr>';
                            }
                            else
                                trforappend = '<tr class="stm_light ' + trcolor + '"><td>' + (i + 1) + '</td>' +
                                      '<td>' + data.d[i].CategoryName + '' +
                                      '<td>' + data.d[i].SubCategoryName + '' +
                                      '<td>' + data.d[i].PName + '<input type="hidden" value="' + data.d[i].Pid + '" />' +
                                      '<td>' + data.d[i].Pcode + '' +
                                      '<td>' + data.d[i].product_description + '' +
                                      '<td><img src="../images/edit.png" style="cursor:pointer" title="Edit" class="editproduct"></img>' +
                                      '<input id="CategoryIsDeleted" type="hidden" value="' + data.d[i].CategoryIsDeleted + '" />' +
                                      '<input Id="SubCategoryIsDeleted" type="hidden" value="' + data.d[i].SubCategoryIsDeleted + '" /></td>' +
                                      '<td><img src="../images/ic.png" style="cursor:pointer" title="Delete" class="Deleteproduct"></img></td></tr>';
                            $('.stmforproductlist').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        $('.divnorecordfound2').css('display', 'inline');
                    }
                    call_progressbar("end");

                },
                error: function (response) {

                    call_progressbar("end");
                }
            });
        }
        function SaveCategory(allcategoryname) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/AddCategory",
                data: "{'CategoryName':'" + $.trim(allcategoryname).split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Category Added Successfully.");
                        call_progressbar("end");
                        BindGrid();
                    }
                    if (data.d == 2) {
                        alertify.success("Category Name Already Exists.");
                        call_progressbar("end");
                        BindGrid();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Category .");
                        call_progressbar("end");
                    }
                    allcategoryname = '';
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function SaveSubcategory(cid, Allsubcategoryname) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/AddSubCategory",
                data: "{'cid':'" + cid + "','SubCategoryName':'" + Allsubcategoryname.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Sub Category Added Successfully.");
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        alertify.success("Sub category allready exist.");
                        call_progressbar("end");
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Category Adding .");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function SaveProduct(Allproductname, AllProductCode, AllDescription) {
            call_progressbar("start");
            CID = 0, scid = 0, Pid = 0;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/AddProduct",
                data: "{'cid':'" + $('#ctl00_ContentPlaceHolder1_ddlselectcategory').val() + "','scid':'" + $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').val() + "','PName':'" + Allproductname.split("'").join("~") + "','Pcode':'" + AllProductCode.split("'").join("~") + "','product_description':'" + AllDescription.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Product Added Successfully.");
                        call_progressbar("end");
                        Bind_table_product();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Product.");
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function categoryddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/bindcategoryddl",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#ddl_category,#Select1').html('<option value="0">---Select Category---</option>');
                    $('#ddl_sub_category,#Select2').html('<option value="0">---Select Subcategory---</option>');
                    $.each(data.d, function (key, value) {
                        $("#ddl_category,#Select1").append($("<option></option>").val(value.CID).html(value.CategoryName));
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                    call_progressbar("end");
                },
            });
        }
        function Subcategoryddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/bindsubcategoryddl",
                data: "{'CID':'" + CID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#ddl_product').html('<option value="0">---Select Product---</option>');
                    $.each(data.d, function (key, value) {
                        $("#ddl_sub_category,#Select2,#ctl00_ContentPlaceHolder1_ddlselectsubcategory").append($("<option></option>").val(value.SCID).html(value.SubCategoryName));
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                    call_progressbar("end");
                },
            });
        }
        function bind_product_ddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/bind_ddl_product",
                data: "{ 'SCID': '" + scid + "' }",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        $("#ddl_product").append($("<option></option>").val(value.Pid).html(value.PName));
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                    call_progressbar("end");
                },
            });
        }
        function Edit1(SCID) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/editsubcategory_by_ID",
                data: "{'SCID':'" + SCID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $("#ctl00_ContentPlaceHolder1_ddlcategory").val(data.d[i].CID);
                            $("#ctl00_ContentPlaceHolder1_txtcategoryname").val(data.d[i].SubCategoryName);
                        }
                    }
                },
                error: function (result) {
                    alertify.error("Error message");
                }
            });
        }
        function Edit2(CID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/editcategory_by_ID",
                data: "{'CID':'" + CID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {

                            $("#ctl00_ContentPlaceHolder1_txttest").val(data.d[i].CategoryName);
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error("Error message");

                    call_progressbar("end");
                }
            });
        }
        function Editproduct(Pid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/editProduct_by_ID",
                data: "{'Pid':'" + Pid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            category_ddl();
                            CID = data.d[i].CID;
                            Subcategoryddl();
                            $("#ctl00_ContentPlaceHolder1_ddlselectcategory").val(data.d[i].CID);
                            $("#ctl00_ContentPlaceHolder1_ddlselectsubcategory").val(data.d[i].SCID);
                            $("#ctl00_ContentPlaceHolder1_txtproductname").val(data.d[i].PName);
                            $("#ctl00_ContentPlaceHolder1_txtproductcode").val(data.d[i].Pcode);
                            $("#ctl00_ContentPlaceHolder1_product_description").val(data.d[i].product_description);
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error("Error message");
                    call_progressbar("end");
                }
            });
        }
        function Updatecategory() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Update_category",
                data: "{'CID':'" + CID + "','CategoryName':'" + $('#ctl00_ContentPlaceHolder1_txttest').val().split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Category Updated Successfully.");
                        call_progressbar("end");
                        BindGrid();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Category .");
                        call_progressbar("end");
                        BindGrid();
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function UpdateSubcategory() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Update_Subcategory",
                data: "{'SCID':'" + SCID + "','CID':'" + $('#ctl00_ContentPlaceHolder1_ddlcategory').val() + "','SubCategoryName':'" + $('#ctl00_ContentPlaceHolder1_txtcategoryname').val().split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Sub Category Updated Successfully.");
                        call_progressbar("end");
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Category .");
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function Updateproduct() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Update_product",
                data: "{'Pid':'" + Pid + "','CID':'" + $('#ctl00_ContentPlaceHolder1_ddlselectcategory').val() + "','SCID':'" + $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').val() + "','PName':'" + $('#ctl00_ContentPlaceHolder1_txtproductname').val().split("'").join("~") + "','Pcode':'" + $('#ctl00_ContentPlaceHolder1_txtproductcode').val().split("'").join("~") + "','product_description':'" + $('#ctl00_ContentPlaceHolder1_product_description').val().split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success(" Updated Successfully.");
                        call_progressbar("end");
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Adding Category.");
                        call_progressbar("end");
                    }
                    CID = 0, scid = 0, Pid = 0;
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function Deletecategory() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/DeleteCategory",
                data: "{'CID':'" + CID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Category Deleted Successfully.");
                        call_progressbar("end");
                        BindGrid();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Deleted");
                        call_progressbar("end");
                        BindGrid();
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function DeleteSubcategory() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/DeleteSubCategory",
                data: "{'SCID':'" + scid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Sub Category Deleted Successfully.");
                        CID = 0, scid = 0;
                        call_progressbar("end");
                        Bindsubcategoryy();
                        Bindcategorysearch();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Deleted");
                        call_progressbar("end");
                        Bindsubcategoryy();
                        Bindcategorysearch();
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        function Deleteproduct() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/Deleteproduct",
                data: "{'Pid':'" + Pid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Product Deleted Successfully.");
                        call_progressbar("end");
                        Pid = 0, CID = 0, scid = 0;
                        Bind_table_product();
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error occured While Adding Category.");
                        call_progressbar("end");
                        Bind_table_product();
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    return false;
                }
            });
        }
        function Clearfunction() {
            $("#ctl00_ContentPlaceHolder1_txttest,#ctl00_ContentPlaceHolder1_txtcategoryname,ctl00_ContentPlaceHolder1_txtproductname,ctl00_ContentPlaceHolder1_txtproductcode,ctl00_ContentPlaceHolder1_product_description,#ctl00_ContentPlaceHolder1_txtproductname,#ctl00_ContentPlaceHolder1_txtproductcode,#ctl00_ContentPlaceHolder1_product_description").val('');
        }
        function category_ddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "category-master.aspx/bindcategory_ddl",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlcategory,#ctl00_ContentPlaceHolder1_ddlselectcategory').html('<option value="0">---Select Category---</option>');
                    $('#ctl00_ContentPlaceHolder1_ddlselectsubcategory').html('<option value="0">---Select Subcategory---</option>');
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlcategory,#ctl00_ContentPlaceHolder1_ddlselectcategory").append($("<option></option>").val(value.CID).html(value.CategoryName));
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('Error');
                    call_progressbar("end");
                },
            });
        }
    </script>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>