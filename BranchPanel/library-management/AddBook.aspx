<%@ Page Title="Add Book" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AddBook.aspx.cs" Inherits="BranchPanel_library_management_AddBook" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_pane_cont input_content branch-div-tbl " id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
            <h2>Add Book</h2>
        </div>

        <div id="addbookdiv" class="for_sigle_row_form">
            <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <select id="ddlsession"></select>
            </div>
            <div class="for_sigle_row_form">
                <label>Category<span style="color: Red">*</span></label>
                <select id="ddlcategory"></select>
                <a id="Addcategory"><u>Add Category</u></a>
            </div>

            <div id="subcategorydiv" class="for_sigle_row_form" style="display: none">
                <label>Sub Category</label>
                <select id="ddlsubcategory"></select>
            </div>

            <div class="for_sigle_row_form">
                <label>Publisher<span style="color: Red">*</span></label>
                <select id="ddlpublisher"></select>
                <a id="Addpublisher"><u>Add Publisher</u></a>
            </div>

            <div class="for_sigle_row_form">
                <label>Author<span style="color: Red">*</span></label>
                <select id="ddlauthor"></select>
                <a id="Addauthor"><u>Add Author</u></a>
            </div>

            <div id="noofbookdiv" class="for_sigle_row_form">
                <label>No Of Books<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtnoofbook" runat="server" onkeypress="return isNumberKey(event)" placeholder="Enter The No Of Books"></asp:TextBox>
            </div>
            <div id="ty" class="for_sigle_row_form"></div>
            <div id="divisbn" class="for_sigle_row_form" style="display: none">
                <label>ISBN<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtisbnno" runat="server" onkeypress="return isNumberKey(event)" placeholder="Enter The ISBN No"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Price Per Unit</label>
                <asp:TextBox ID="txtprice" runat="server" onkeypress="return noAlphabets(event)" placeholder="Enter The Price Per Unit"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Purchase Date</label>
                <asp:TextBox ID="txtpurchaseDate" runat="server" placeholder="Enter The Purchase Date" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Keywords</label>
                <asp:TextBox ID="txtfewword" runat="server" TextMode="MultiLine" placeholder="You Can Enter Multiple Keywords About Book And Each Keyword Seperated From Comma"></asp:TextBox>;
            </div>

            <div class="for_sigle_row_form">
                <label>Title<span style="color: Red">*</span></label>
                <asp:TextBox ID="txttitle" runat="server" Placeholder="Enter The Title Of Book"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form">
                <label>Description</label>
                <asp:TextBox ID="txtdescription" runat="server" TextMode="MultiLine" placeholder="Enter The Description" alt="Image Of Book"></asp:TextBox>
            </div>

            <div class="for_sigle_row_form" id="bookphotograph">
                <label>Book Photograph:</label>
                <asp:FileUpload ID="fileuploaderofbooktphotograph" runat="server" onchange="ShowpImagePreviewParent(this,'#ctl00_ContentPlaceHolder1_fileuploaderofbooktphotograph')" ToolTip="Select" />
                <a class="navbar-brand" data-toggle="fullscreen" href="#">
                    <img id="imgbook" class="m-r-sm" style="display: none; margin-left: 200px; width: 800px; height: 800px" alt="No Image" src="bookimage/default_book.png" /></a>
            </div>

            <div class="for_sigle_row_form">
                <label style="padding-top: 0px;">Not for Issue</label>
                <asp:CheckBox ID="chknotforissued" runat="server" />
            </div>
            <div class="for_sigle_row_form">
                <asp:Button ID="btnsubmit" runat="server" Text="Save" CssClass="button_save" />
                <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button2 inputinstitute" />
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        //************************************************declare variable************************************************
        var bookcategory = "", booksubcategory = "", publisher = "", author = "", noofbook = "", isbn = "", bookExtension = "", FileUploadPath = "";
        var price = "", purchasedate = "", keywords = "", title = "", description = "", booksrc = "", notissue = "", imagebookdata = "", fyid = "";
        var txtymsg = '';
        //***********************************************readyfunction*************************************************
        $(document).ready(function () {

            Bindcategoryddl();
            Bindpublisherddl();
            Bindauthorddl();
            Bindsession();
            CallMethod();

            return false;
        });
        //********************************************************progressbar*****************************************
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
        //****************************************************validation function*****************************************
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        //******************************************************Bind category*************************************************
        function Bindcategoryddl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/Bindcategory",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlcategory").html("");
                    $("#ddlcategory").append($("<option></option>").val('0').html('--Select Category--'));
                    $.each(data.d, function (key, value) {
                        $("#ddlcategory").append($("<option></option>").val(value.categoryid).html(value.categoryname));
                    });
                },
                error: function (result) {
                },
            });
        }
        //****************************************************bind subcategory on change event of category*****************************
        $("#ddlcategory").change(function () {
            call_progressbar('start');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/getsubcategoryfun",
                data: "{ 'categoryid':'" + $(this).val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#subcategorydiv").show(500);
                        $("#ddlsubcategory").html("");
                        $("#ddlsubcategory").append($("<option></option>").val('0').html('--Select Subcategory--'));
                        $.each(data.d, function (key, value) {
                            $("#ddlsubcategory").append($("<option></option>").val(value.subcategoryid).html(value.subcategoryname));
                        });
                    }
                    else {
                        $("#ddlsubcategory").append($("<option></option>").val('0').html('--Select Subcategory--'));
                        $("#subcategorydiv").hide(500);
                    }
                    call_progressbar('end');
                },
                error: function (data) {
                },

            });
        });
        //******************************************************Bind publisher*************************************************
        function Bindpublisherddl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/getpublisherfun",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlpublisher").html("");
                    $("#ddlpublisher").append($("<option></option>").val('0').html('--Select Publisher--'));
                    $.each(data.d, function (key, value) {
                        $("#ddlpublisher").append($("<option></option>").val(value.publisherid).html(value.publishername));
                    });
                },
                error: function (result) {
                },
            });
        }
        //******************************************************Bind publisher*************************************************
        function Bindauthorddl() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/getauthorfun",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlauthor").html("");
                    $("#ddlauthor").append($("<option></option>").val('0').html('--Select Author--'));
                    $.each(data.d, function (key, value) {
                        $("#ddlauthor").append($("<option></option>").val(value.authorid).html(value.authorname));
                    });
                },
                error: function (result) {
                },
            });
        }
        //**************************************************purchasedate***********************************************************

        $("#ctl00_ContentPlaceHolder1_txtpurchaseDate").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy',
            maxDate: new Date()
        }).datepicker("setDate", new Date());
        //*****************************************************isbn no on the basis of no of book************************************
        $("#ctl00_ContentPlaceHolder1_txtnoofbook").keyup(function () {
            var i;
            $("#ty").empty();
            var a = jQuery("#ctl00_ContentPlaceHolder1_txtnoofbook").val();
            for (i = 0; i < a; i++) {
                $("#ty").last().append('<label>Enter Isbn Number</label><span style="color: Red">*</span><input name="multiisbn" type="text" class="txtcheck11" onkeypress="return isNumberKey(event)" onchange="return myFunction()"  placeholder="Enter Isbn number"  id=' + (a + i) + ' /><br />')
            }
        });
        function myFunction() {

            $('.txtcheck11').each(function () {
                var isbn = $(this).val()
                var select = $(this);
                $.ajax(
                  {
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "AddBook.aspx/checkisbn",
                      data: "{'isbn':'" + isbn + "'}",
                      dataType: "json",
                      success: function (data) {
                          if (parseInt(data.d) == parseInt(1)) {
                              alert(isbn + " " + "Already Exist ");
                              select.val('');
                          }
                          else {
                              return;
                          }
                      },
                      error: function (result) {

                      }
                  });
            });
        }
        //*****************************************click on submit*******************************************************************
        $('#ctl00_ContentPlaceHolder1_btnsubmit').click(function () {

            if ($('#ddlsession').val() == '0') {
                alertify.error("Select The session");
                $('#ddlsession').focus();
                return false;
            }
            else if ($('#ddlcategory').val() == '0') {
                alertify.error("Select The Book Category");
                $('#ddlcategory').focus();
                return false;
            }
            else if ($('#ddlpublisher').val() == '0') {
                alertify.error("Select The Publisher");
                $('#ddlpublisher').focus();
                return false;
            }
            else if ($('#ddlauthor').val() == '0') {
                alertify.error("Select The Author");
                $('#ddlauthor').focus();
                return false;
            }
            else if ($('#ctl00_ContentPlaceHolder1_txttitle').val() == "") {
                alertify.error("Select The Title Of Book");
                $('#ctl00_ContentPlaceHolder1_txttitle').focus();
                return false;
            }
            else {
                if ($(this).val() != "Update") {
                    if ($('#ctl00_ContentPlaceHolder1_txtnoofbook').val() == "") {
                        alertify.error("Enter The No Of Book");
                        $('#ctl00_ContentPlaceHolder1_txtnoofbook').focus();
                        return false;
                    }
                    else {
                        $('#ty').find('input[type="text"]').each(function () {
                            if ($(this).val() == '') {
                                alertify.error('Please Enter All The Textbox Of ISBN Number.');
                                $(this).focus();
                                return false;
                            }
                        });
                        FillField();
                        insertthebook();
                        return false;
                    }
                }
                else {

                    if ($('#ty').find('input[type="text"]').val() == '') {
                        alertify.error('Please Enter All The Textbox Of ISBN Number.');
                        $('#ty').find('input[type="text"]').focus();
                        return false;
                    }
                    else {
                        //For Finding That Coming For Edit Start Here
                        var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                        for (var i = 0; i < url.length; i++) {
                            var urlparam = url[i].split('=');
                            if (parseInt(urlparam.length) > 1) {
                                updatebookdata(urlparam[1]);
                            }
                        }
                        //For Finding That Coming For Edit End Here
                        return false;
                    }
                }
            }

        });
        // //***********************************************fill field****************************************************
        function FillField() {
            fyid = $('#ddlsession').val();
            bookcategory = $('#ddlcategory').val();
            if ($('#ddlsubcategory').val() == null)
                booksubcategory = 0
            else
                booksubcategory = $('#ddlsubcategory').val();
            publisher = $('#ddlpublisher').val();
            author = $('#ddlauthor').val();
            noofbook = $('#ctl00_ContentPlaceHolder1_txtnoofbook').val();
            $('#ty').find('input[type="text"]').each(function () {
                isbn = isbn + ',' + $(this).val();
            });
            isbn = isbn.slice(1, isbn.length);
            price = $('#ctl00_ContentPlaceHolder1_txtprice').val();
            purchasedate = $('#ctl00_ContentPlaceHolder1_txtpurchaseDate').val();
            keywords = $('#ctl00_ContentPlaceHolder1_txtfewword').val();
            title = $('#ctl00_ContentPlaceHolder1_txttitle').val();
            description = $('#ctl00_ContentPlaceHolder1_txtdescription').val();
            notissue = $("#ctl00_ContentPlaceHolder1_chknotforissued").is(":checked");
            if (notissue == true) {
                notissue = 1
            }
            else {
                notissue = 0
            }
            return false;
        }
        // //*********************************************Add Book*********************************************************
        function insertthebook() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/saveBookdetail",
                data: "{'bookcategory':'" + bookcategory + "','booksubcategory':'" + booksubcategory + "','publisher':'" + publisher + "','author':'" + author + "','noofbook':'" + noofbook + "','isbn':'" + isbn.split("'").join("~") + "','price':'" + price.split("'").join("~") + "','purchasedate':'" + purchasedate + "','keywords':'" + keywords.split("'").join("~") + "','title':'" + title.split("'").join("~") + "','description':'" + description.split("'").join("~") + "','notissue':'" + notissue + "','booksrc':'" + booksrc + "','bookExtension':'" + bookExtension + "','imagebookdata':'" + imagebookdata + "','fyid':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Add Book Successfully");
                        var confirmbox = confirm('Would you like to add more book.?')
                        if (confirmbox == true) {
                            $('#ddlcategory').val('0');
                            $('#ddlsubcategory').val('0');
                            $('#ddlpublisher').val('0');
                            $('#ddlauthor').val('0');
                            $('#ctl00_ContentPlaceHolder1_txtnoofbook').val('');
                            $('#ctl00_ContentPlaceHolder1_txtprice').val('');
                            $('#ctl00_ContentPlaceHolder1_txtpurchaseDate').val('');
                            $('#ctl00_ContentPlaceHolder1_txtfewword').val('');
                            $('#ctl00_ContentPlaceHolder1_txttitle').val('');
                            $('#ctl00_ContentPlaceHolder1_txtdescription').val('');
                            $('#ctl00_ContentPlaceHolder1_chknotforissued').prop("checked", false);
                            $("#subcategorydiv").hide(500);
                            $('#imgbook').hide();
                            $("#ctl00_ContentPlaceHolder1_fileuploaderofbooktphotograph").val('');
                            $('#ty').html('');
                            bookcategory = "", booksubcategory = "", publisher = "", author = "", noofbook = "", isbn = "", bookExtension = "", FileUploadPath = "";
                            price = "", purchasedate = "", keywords = "", title = "", description = "", booksrc = "", notissue = "", imagebookdata = "", fyid = "";
                        }
                        else {
                            window.location.href = "bookdetail.aspx";
                        }
                        call_progressbar("end");
                        return false;
                    }

                },
                error: function (data) {
                    call_progressbar("end");
                }
            });
            return false;
        }
        //**********************************************book image preview************************************************************

        function book_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            FileUploadPath = fuData.value;
            if (FileUploadPath != '') {
                bookExtension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (bookExtension == "jpg" || bookExtension == "jpeg" || bookExtension == "png" || bookExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + bookExtension + " file for Image.");
                    return false;
                }

            }
        }
        function ShowpImagePreviewParent(input, controlId) {

            var stat = book_Validation(controlId);

            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    imagebookdata = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        booksrc = e.target.result;
                        $('#imgbook').attr('src', e.target.result);
                        $('#imgbook').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        //**************************************************Back Button*****************************************************************
        $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
            window.location.href = "bookdetail.aspx";
            $("#noofbookdiv").show(500);
            return false;
        });
        // ***********************************************************bind Fyid*****************************************************
        function Bindsession() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/bindsession",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlsession").html("");
                    $.each(data.d, function (key, value) {
                        $("#ddlsession").append($("<option></option>").val(value.id).html(value.session));
                    });
                },
                error: function (result) {

                },
            });
        }

        function CallMethod() {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    Edit(urlparam[1]);
                }
            }
            //For Finding That Coming For Edit End Here
        }

        //**********************************************************editbook*************************************************************
        function Edit(IbForUpdate) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/Editdetail",
                data: "{'IbForUpdate':'" + IbForUpdate + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_btnsubmit').val("Update");
                            $('#imgbook').show();
                            $('#imgbook').prop('src', 'bookimage/' + data.d[i].Imagebookname);
                            if (data.d[i].notforissue == 1)
                            { $('#ctl00_ContentPlaceHolder1_chknotforissued').prop("checked", true); }
                            else { $('#ctl00_ContentPlaceHolder1_chknotforissued').prop("checked", false); }
                            $('#ddlsession').val(data.d[i].session);
                            $('#ddlcategory').val(data.d[i].category);
                            $('#ddlsubcategory').val(data.d[i].subcategory);
                            $('#ddlpublisher').val(data.d[i].publisher);
                            $('#ddlauthor').val(data.d[i].author);
                            $('#ctl00_ContentPlaceHolder1_txtprice').val(parseFloat(data.d[i].price).toFixed(2));
                            $('#ctl00_ContentPlaceHolder1_txtpurchaseDate').val(data.d[i].purchasedate);
                            $('#ctl00_ContentPlaceHolder1_txtfewword').val(data.d[i].keywords);
                            $('#ctl00_ContentPlaceHolder1_txttitle').val(data.d[i].Title);
                            $('#ctl00_ContentPlaceHolder1_txtdescription').val(data.d[i].Description);
                            $('#noofbookdiv').hide(500);
                            var a = data.d[i].Noofbook
                            for (i = 0; i < a; i++) {
                                $("#ty").last().append('<label>Enter Isbn Number</label><input name="multiisbn" type="text" value=' + data.d[i].ISBN + ' class="txtcheck11" onkeypress="return isNumberKey(event)" onchange="return myFunction()" onsubmit="return myFunction()" placeholder="Enter Isbn number"  id=' + (a + i) + ' /><br /> ')
                            }

                            return false;
                        }
                    }

                },
                error: function (data) {

                }
            });
        }

        function updatebookdata(IbForUpdate) {
            FillField();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddBook.aspx/updatebook",
                data: "{'bookcategory':'" + bookcategory + "','booksubcategory':'" + booksubcategory + "','publisher':'" + publisher + "','author':'" + author + "','price':'" + price.split("'").join("~") + "','purchasedate':'" + purchasedate + "','keywords':'" + keywords.split("'").join("~") + "','title':'" + title.split("'").join("~") + "','description':'" + description.split("'").join("~") + "','notissue':'" + notissue + "','fyid':'" + fyid + "','isbn':'" + isbn.split("'").join("~") + "','IbForUpdate':'" + IbForUpdate + "','booksrc':'" + booksrc + "','bookExtension':'" + bookExtension + "','imagebookdata':'" + imagebookdata + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    alertify.success('Book updated successfully');
                    call_progressbar("end");
                    bookcategory = "", booksubcategory = "", publisher = "", author = "", noofbook = "", isbn = "", bookExtension = "", FileUploadPath = "";
                    price = "", purchasedate = "", keywords = "", title = "", description = "", booksrc = "", notissue = "", imagebookdata = "", fyid = "";
                    window.location.href = "bookdetail.aspx";
                    return false;
                },
                error: function (data) {
                }
            });
            return false;
        };
        //******************************************************************************************************************************************
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;
            return true;
        };
    </script>
</asp:Content>