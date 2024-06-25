<%@ Page Title="Book Detail" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="bookdetail.aspx.cs" Inherits="BranchPanel_library_management_bookdetail" EnableEventValidation="false" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
   <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
   <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Book list</h2>
   </div>
   <div id="booklist" class="for_sigle_row_form">
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
                 <asp:Button ID="btnforimageview" runat="server" Text="Click For Image View" CssClass="button_save" title="Click For Image View"/>
            </div>
            <table id="Tablebooklist" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 5px">S.No.</th>
                <th scope="col" style="width: 15px">Book Id</th>
                <th scope="col" style="width: 30px">ISBN</th>
                <th scope="col" style="width: 70px">Title</th>
                <th scope="col" style="width: 50px">Key Words</th>
                <th scope="col" style="width: 20px">Edit</th>
                <th scope="col" style="width: 20px">Delete</th>
            </tr>
           </table>
           </div>
           <div id="divProgressBar" class="progress"></div>
        </div>
     <script type="text/javascript">
         //*********************************************************variable***********************************************
         var bookid = "", isbn = "", title = "", category = 0, publisher = "0", author = "0", fyid = 0, subcategory = 0, keywords = "", hiddenbookid = "";
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
   </script>
    <script type="text/javascript">
        $(document).ready(function () {
            Bindbooklist();
            Bindcategoryddl();
            Bindpublisherddl();
            Bindauthorddl();
            Bindsession();
            $('#ddlcategory').change(function () {
                category = $(this).val();
                Bindbooklist()
            })
            $('#ddlpublisher').change(function () {

                publisher = $(this).val();
                Bindbooklist()
            })
            $('#ddlauthor').change(function () {

                author = $(this).val();
                Bindbooklist()
            })
            $('#ddlsession').change(function () {

                fyid = $(this).val();
                Bindbooklist()
            })

            $('#ddlsubcategory').change(function () {

                subcategory = $(this).val();
                Bindbooklist()
            })
            $('#ctl00_ContentPlaceHolder1_Txtbookid').keyup(function () {

                bookid = $(this).val();
                Bindbooklist()
            })
            $('#ctl00_ContentPlaceHolder1_Textisbn').keyup(function () {

                isbn = $(this).val();
                Bindbooklist()
            })
            $('#ctl00_ContentPlaceHolder1_Texttitle').keyup(function () {
                title = $(this).val();
                Bindbooklist()
            })
            $('#ctl00_ContentPlaceHolder1_Textkeyword').keyup(function () {

                keywords = $(this).val();
                Bindbooklist()
            })
         
            return false;
        });
      
        //********************************************************************clear all field*************************************************
        $("#btnclearalld").click(function () {
            $('#ctl00_ContentPlaceHolder1_Txtbookid').val('');
            $('#ctl00_ContentPlaceHolder1_Textisbn').val('');
            $('#ctl00_ContentPlaceHolder1_Texttitle').val('');
            $('#ctl00_ContentPlaceHolder1_Textkeyword').val('');
            $('#ddlsession').val('0');
            $('#ddlauthor').val('0');
            $('#ddlpublisher').val('0');
            $('#ddlcategory').val('0');
            $(".subcategorydiv").hide(500);
            $('#ddlsubcategory').val('0');
            bookid = "", isbn = "", title = "", category = 0, publisher = "0", author = "0", fyid = 0, subcategory = 0, keywords = "";
            Bindbooklist();
            return false;
        });
        //**********************************************booklist******************************************************************
        function Bindbooklist() {
            call_progressbar('start')
            $('#Tablebooklist tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "bookdetail.aspx/fillbooklist",
                data: "{'bookid':'" + bookid.split("'").join("~") + "','isbn':'" + isbn.split("'").join("~") + "','title':'" + title.split("'").join("~") + "','category':'" + category + "','publisher':'" + publisher + "','author':'" + author + "','fyid':'" + fyid + "','subcategory':'" + subcategory + "','keywords':'" + keywords.split("'").join("~") + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                cssclass = 'stm_light';
                            else
                                cssclass = 'stm_dark';
                            trforappend = '<tr class=' + cssclass + '><td>' + data.d[i].rownumber + '</td>' +
                                       '<td>' + data.d[i].Bookid + '</td>' +
                                       '<td>' + data.d[i].ISBN+ '</td>' +
                                       '<td>' + data.d[i].Title + '</td>' +
                                       '<td>' + data.d[i].keywords + '</td>' +
                                       '<td><input class=editimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/edit.png><input id="hfbookid" type="hidden" value="' + data.d[i].Bookid + '">' + '</td>' +
                                      '<td><input class=deleteimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/ic.png /></td></tr>';

                            $('#Tablebooklist').append(trforappend);
                         
                        }
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }

        //******************************************************Bind category*************************************************
        function Bindcategoryddl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "bookdetail.aspx/Bindcategory",
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
                url: "bookdetail.aspx/getsubcategoryfun",
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
                url: "bookdetail.aspx/getpublisherfun",
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
                url: "bookdetail.aspx/getauthorfun",
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
                url: "bookdetail.aspx/bindsession",
                data: "",
                dataType: "json",
                async:false,
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
        //**************************************************************delete book here*****************************************]
      
        $('.deleteimage').live("click", function () {
            if (confirm("Are you sure you want to delete this?")) {
                 var bookidfordelete = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
                 $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "bookdetail.aspx/deletebook",
                    data: "{'bookidfordelete':'" + bookidfordelete + "'}",
                    dataType: "json",
                    success: function (data) {
                        alertify.success("book deleted successfully.");
                        Bindbooklist();
                    },

                    error: function (result) {
                        alert("Error");
                    }
                });

            }
            return false;
        });
        // *******************************************************click for edit book Detail******************************************************
        $('.editimage').live('click', function () {
             hiddenbookid = 0;
             hiddenbookid = $(this).parent('td').parent('tr').find('input[type=hidden]').val()
             window.location.href = "AddBook.aspx?Id=" + hiddenbookid;
            return false;
        });
        //****************************************************************click for imageview************************************************************
        $("#ctl00_ContentPlaceHolder1_btnforimageview").click(function () {
            window.location.href = "book_imageview.aspx"
            return false;
        });
      
    </script>
</asp:Content>