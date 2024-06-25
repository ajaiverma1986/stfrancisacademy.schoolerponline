<%@ Page Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="book_imageview.aspx.cs" Inherits="BranchPanel_library_management_book_imageview"  EnableEventValidation="false"  %>
  <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
      <style type="text/css">
          .imageviewofbook {
              background: #FFF none repeat scroll 0px 0px;
              border: 2px solid #DDD;
              border-radius: 5px;
              margin: 5px;
              padding: 7px;
              width: 80%;
          }

          .booklist tr 
          {

              float:left;
             
          }

      </style>
     
         <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
          <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Book list</h2>
           </div>
        <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
           <asp:TextBox ID="Txtbookid" runat="server" style="height:23px;width:90px;" placeholder="Enter Book Id"></asp:TextBox>
                 <asp:TextBox ID="Textisbn" runat="server" style="height:23px;width:90px;" placeholder=" Enter ISBN"></asp:TextBox>
                 <asp:TextBox ID="Texttitle" runat="server" style="height:23px;width:130px;" placeholder="Title Of Book"></asp:TextBox>
                 <asp:TextBox ID="Textkeyword" runat="server" style="height:23px;width:130px;" placeholder="Keywords Of Book"></asp:TextBox>
                 <select id="ddlcategory" style="width:100px;height:31px"></select>
                  <select id="ddlsubcategory"class="subcategorydiv" style="width:100px;display:none;height:31px"></select>
                 <select id="ddlpublisher" style="width:100px;height:31px"></select>
                 <select id="ddlauthor" style="width:100px;height:31px"></select>
                 <select id="ddlsession" style="width:100px;height:31px"></select>
            <img src="../../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" height="25px" title="Clear All Search" alt="No Image" />
            <asp:Button ID="btnforlistview" runat="server" Text="Click For List View" CssClass="button_save" title="Click For list View"/>
            </div>

             <div  style=" width:100%;background:#fff;">
                 <table class="booklist" width="100%">
                 </table>
            </div>
            </div>
            <div id="divProgressBar" class="progress"></div>
    
      <script type="text/javascript">
          //*****************************************************variable**************************************************************
          var bookid = "", isbn = "", title = "", category = 0, publisher = "0", author = "0", fyid = 0, subcategory = 0, keywords = "";
              //********************************************************************************************************************
        $(document).ready(function () {
            Bindbooklistimagedata()
            Bindcategoryddl();
            Bindpublisherddl();
            Bindauthorddl();
            Bindsession();
            $("#ctl00_ContentPlaceHolder1_btnforlistview").click(function () {
                window.location.href = "bookdetail.aspx"
                return false;
            });
            $('#ddlcategory').change(function () {
                category = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ddlpublisher').change(function () {

                publisher = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ddlauthor').change(function () {

                author = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ddlsession').change(function () {

                fyid = $(this).val();
                Bindbooklistimagedata()
            })

            $('#ddlsubcategory').change(function () {

                subcategory = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ctl00_ContentPlaceHolder1_Txtbookid').keyup(function () {

                bookid = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ctl00_ContentPlaceHolder1_Textisbn').keyup(function () {

                isbn = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ctl00_ContentPlaceHolder1_Texttitle').keyup(function () {
                title = $(this).val();
                Bindbooklistimagedata()
            })
            $('#ctl00_ContentPlaceHolder1_Textkeyword').keyup(function () {

                keywords = $(this).val();
                Bindbooklistimagedata()
            })
            //*********************************************clear*******************************************************
            //********************************************************************clear all field*************************************************
            $("#btnclearalld").click(function () {
                $('#ctl00_ContentPlaceHolder1_Txtbookid').val('');
                $('#ctl00_ContentPlaceHolder1_Textisbn').val('');
                $('#ctl00_ContentPlaceHolder1_Texttitle').val('');
                $('#ctl00_ContentPlaceHolder1_Textkeyword').val('');
                $('#ddlcategory').val('0');
                $('#ddlpublisher').val('0');
                $('#ddlsession').val('0');
                $('#ddlauthor').val('0');
                $(".subcategorydiv").hide(500);
                $('#ddlsubcategory').val('0');
                bookid = "", isbn = "", title = "", category = 0, publisher = "0", author = "0", fyid = 0, subcategory = 0, keywords = "";
                Bindbooklistimagedata();
                return false;
            });
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
        //******************************************************Bind category*************************************************
        function Bindcategoryddl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_imageview.aspx/Bindcategory",
                data: "",
                dataType: "json",
                success: function (data) {
                    $("#ddlcategory").html("");
                    $("#ddlcategory").append($("<option></option>").val('0').html('-Category-'));
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
                url: "book_imageview.aspx/getsubcategoryfun",
                data: "{ 'categoryid':'" + $(this).val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $(".subcategorydiv").show(500);
                        $("#ddlsubcategory").html("");
                        $("#ddlsubcategory").append($("<option></option>").val('0').html('-Subcategory-'));
                        $.each(data.d, function (key, value) {
                            $("#ddlsubcategory").append($("<option></option>").val(value.subcategoryid).html(value.subcategoryname));
                        });
                    }
                    else {
                        $("#ddlsubcategory").append($("<option></option>").val('0').html('-Subcategory-'));
                        $(".subcategorydiv").hide(500);
                    }
                    call_progressbar('end');
                },
                error: function (data) {
                },

            });
        });
        //******************************************************Bind publisherddl*************************************************
        function Bindpublisherddl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_imageview.aspx/getpublisherfun",
                data: "",
                dataType: "json",
                success: function (data) {
                    $("#ddlpublisher").html("");
                    $("#ddlpublisher").append($("<option></option>").val('0').html('-Publisher-'));
                    $.each(data.d, function (key, value) {
                        $("#ddlpublisher").append($("<option></option>").val(value.publisherid).html(value.publishername));
                    });
                },
                error: function (result) {
                },
            });
        }
        //******************************************************Bind authorddl*************************************************
        function Bindauthorddl() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_imageview.aspx/getauthorfun",
                data: "",
                dataType: "json",
                success: function (data) {
                    $("#ddlauthor").html("");
                    $("#ddlauthor").append($("<option></option>").val('0').html('-Author-'));
                    $.each(data.d, function (key, value) {
                        $("#ddlauthor").append($("<option></option>").val(value.authorid).html(value.authorname));
                    });
                },
                error: function (result) {
                },
            });
        }
        // ***********************************************************bind Fyid*****************************************************
        function Bindsession() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_imageview.aspx/bindsession",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlsession").html("");
                    $("#ddlsession").append($("<option></option>").val('0').html('-Session-'));
                    $.each(data.d, function (key, value) {
                        $("#ddlsession").append($("<option></option>").val(value.id).html(value.session));
                    });
                },
                error: function (result) {

                },
            });
        }
        //**********************************************booklist******************************************************************
       

        function Bindbooklistimagedata() {
            var trforappend = "";
            $('.booklist tr').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_imageview.aspx/fillbookimagelist",
                data: "{'bookid':'" + bookid.split("'").join("~") + "','isbn':'" + isbn.split("'").join("~") + "','title':'" + title.split("'").join("~") + "','category':'" + category + "','publisher':'" + publisher + "','author':'" + author + "','fyid':'" + fyid + "','subcategory':'" + subcategory + "','keywords':'" + keywords.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {

                            trforappend = '<tr> <td><div class="imageviewofbook" style="margin: 5px;"><div class="book_img" style="margin: 0 auto; overflow:hidden;  width: 114px; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;"> <a  href="bookinformation.aspx?id=' + data.d[i].Book_id + '&category=' + data.d[i].Category_id + '">' +
                                '<img  alt="No Image" src="bookimage/' + data.d[i].Book_Image + '" style="height:90px;  width:100%;border-width:0px;"></a>'+
                                '<br></div><div class="book" style="text-align: left;"><b style="font-size: 12px; line-height: 22px;">Title :<u><a  href="bookinformation.aspx?id=' + data.d[i].Book_id + '&category=' + data.d[i].Category_id + '">' + data.d[i].Book_Title + '</a></u>' +
                                '</b><br><b style="font-size: 10px;">Publisher Name :<span >' + data.d[i].Publisher_Name + '</span></b><br><b style="font-size: 10px;">Author Name :<span >' + data.d[i].Authorname + '</span></b><br><b style="font-size: 10px;">ISBN:<span >' + data.d[i].Isbn + '</span></b><div style="display: none"></div><div class="clear"></div> </div></div></td></tr>';
                              
                            $('.booklist').append(trforappend);
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alert('Error');
                    call_progressbar("end");
                }
            });
        }
        </script>
    </asp:Content>

