<%@ Page Title="Book Information" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="bookinformation.aspx.cs" Inherits="BranchPanel_library_management_bookinformation" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <style type="text/css">
        .book tr td {
            border: 1px solid #ddd;
            padding: 10px;
            font-size: 12px;
        }

        .shadow1 {
            -webkit-box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
            -moz-box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
            box-shadow: 0 0 2px rgba(0, 0, 0, 0.35);
        }
    </style>
      <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Book Information</h2>
           </div>
            <div class="for_sigle_row_form" style="float:right">
                       <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button_save" />
                       </div>
            <%-- div for book info--%>
            <div style="text-align: left;">
                 <table id="bookinfo" width="1%" class="book shadow1" style="background: #fff;">
                 </table>
            </div>
    <%--      div for similar books--%>
          <div class="shadow1" style="padding: 6px; margin-bottom: -18px; width: 80%; margin-top:5px;">
              <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2> Similar Book Information</h2>
           </div>
          <div class="shadow1" style="border: 1px solid #ddd; width: 100%; height: 402px; margin-top: 4.5%; background: #FCFCFC;overflow: scroll; overflow-x: hidden;">
              <table id="similarbook" width="95%" class="book shadow1" style="background: #fff;">
                  </table>
              </div>
              </div>
        
    </div>
    <div id="divProgressBar" class="progress"></div>
    <script type="text/javascript">
        //************************************************variable*************************************************************
        var bookid = "", categoryid = "";
        //**********************************************************************************************************************
        $(document).ready(function () {
          
         bookid = GetParameterValues('id');
         categoryid = GetParameterValues('category');
         Bindbookinfofromlist(bookid);
         Bindsimilarlist(categoryid);
       });

        //******************************************************call method for query******************************************
      
        function GetParameterValues(param) {
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (urlparam[0] == param) {
                    return urlparam[1];
                }
            }
        }
    
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
       
        //************************************************************book info**************************************************************************************

        function Bindbookinfofromlist(bookid) {
            var trforappend = "";
            $('#bookinfo tr').remove();
            call_progressbar("start");
            $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "bookinformation.aspx/fillbookinfo",
                        data: "{'bookid':'" + bookid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            if (data.d.length > 0) {
                                for (var i = 0; i < data.d.length; i++) {
                                    trforappend = '<tr> <td rowspan="7"><div class="imageviewofbook" style="margin: 5px;"><img style="width:280px;border-width:0px;" src="bookimage/' + data.d[i].Book_Imagename + '" ></td><td><b>Title :</b>' +
                                                   '<span>' + data.d[i].Book_Title + '</span></td></tr><tr style="background-color:#fcfcfc;"><td><b>Publisher Name : </b><span>' + data.d[i].Publisher_Name + '</span></td>' +
                                                   '</tr><tr><td><b>Author Name :</b><span >' + data.d[i].Author_Name + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>No. of books :</b>' +
                                                   '<span>' + data.d[i].Noofbook + '</span></td></tr><tr><td><b>Status :</b><span>' + data.d[i].Status + '</span>' +
                                                   '</td></tr><tr style="background-color: #fcfcfc;"><td><b>Description:</b>'+
                                                   '<span style="display:inline-block;width:210px;word-wrap: normal; word-break: break-all;">' + data.d[i].Description + '</span></td></tr>';

                                    $('#bookinfo').append(trforappend);
                               }
                          }
                            call_progressbar("end");
                        },
                        error: function (result) {
                          call_progressbar("end");
                        }
                    });
           
        }

        //******************************************************************************similar book*******************************************************************
        function Bindsimilarlist(categoryid) {
            var trforappend = "";
            $('#similarbook tr').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "bookinformation.aspx/fillsimilarbookinfo",
                data: "{'categoryid':'" + categoryid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = '<tr><td><div class="carda" style="padding: 8px; width: 137%;"><br><div style="float: left;">'+
                                          '<div class="book_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">'+
                                          '<a  href="bookinformation.aspx?id=' + data.d[i].book_id + '&category=' + data.d[i].category_id + '">' +
                                           '<img style="height:90px;width:85px;border-width:0px;"src="bookimage/' + data.d[i].Book_Imagename + '">' +
                                           '</a><br></div></div><div style="float: left;"><div class="booki" style="text-align: left; padding-left: 14%; padding-top: 6%; line-height: 21px;">'+
                                          '<b>Title :<u><a href="bookinformation.aspx?id=' + data.d[i].book_id + '&category=' + data.d[i].category_id + '">' + data.d[i].Book_Title + '</a></u> </b><br>' +
                                          '<b>Publisher Name :</b><span>' + data.d[i].Publisher_Name + '</span><br>' +
                                           '<b>Status :</b><span>' + data.d[i].Status + '</span><div style="display:none"></div>' +
                                             '</div><div class="clear"></div></div></div></td></tr>';

                            $('#similarbook').append(trforappend);
                        }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });

        }

      //**************************************************Back Button*****************************************************************
        $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
            window.location.href = "book_imageview.aspx";
           return false;
        });
 </script>

</asp:Content>