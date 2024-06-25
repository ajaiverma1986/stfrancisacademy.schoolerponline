<%@ Page Language="C#" AutoEventWireup="true" CodeFile="book_issue.aspx.cs" Inherits="BranchPanel_library_management_book_issue" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1"  runat="Server">
     <style type="text/css">
          .f1 {
            width: auto;
            height: 200px;
            border-radius: 3px;
            }
     </style>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">
                     <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2> Issue Book</h2>
                     </div>
        <div style="float:left; width:49%;">
            <div id="Issuebook" runat="server">
            <div class="for_sigle_row_form">
                <label>Library Card No<span style="color: Red">*</span></label>
                 <asp:TextBox ID="txtcardno" Style="border: 2px #2CA8C2 solid;" placeholder="Enter Library Card No"  runat="server"> </asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>Issue Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtissuedate" runat="server" ReadOnly="true" placeholder="Enter Date of Issue Book"  > </asp:TextBox>
            </div>
            
          </div>

        </div>

        <div style="float:right; width:48%; margin-left:1%;">
            <div>
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                 <h2> Personal Information</h2>
           </div>
                 <table id="studentdetail" width="100%" class="book shadow1" style="background: #fff;">
                 </table>
            </div>

        </div>           
         <div class="clear"></div>   
        <div class="clear"></div>
       <div id="Alreadytakenbook">
         <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2> Already Issued Book Details</h2>
                     </div>
        <table id="TableAlreadytakenbook" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 10px">Book Id</th>
                <th scope="col" style="width: 40px">ISBN</th>
                <th scope="col" style="width: 60px">Book Title</th>
                <th scope="col" style="width: 20px">Issue Date</th>
                <th scope="col" style="width: 20px">Return Date</th>
                <th scope="col" style="width: 20px">Late Fine(Per Day)</th>
            </tr>
        </table>
         </div>
         <div id="bookdetailforissue">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2>Book Issue</h2>
         </div>
        <table id="booklistforissue" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 10px">Book Id</th>
                <th scope="col" style="width: 40px">ISBN</th>
                <th scope="col" style="width: 60px">Book Title</th>
                <th scope="col" style="width: 20px">Issue Date</th>
                <th scope="col" style="width: 20px">Return Date</th>
                <th scope="col" style="width: 20px">Late Fine(Per Day)</th>
            </tr>
        </table>
            <label id="msg" style="height:23px;width:300px;display:none;border: 2px #2CA8C2 solid;margin-left:200px"><b>All Alloted Books are Already Issued.</b></label>
              <div class="for_sigle_row_form">
                       <asp:Button ID="btnissuebook" runat="server" Text="Submit" style="margin-left:520px;display:none" CssClass="button_save" />
                  
              </div>
         </div>
           <div id="divProgressBar" class="progress"></div>
         </div>
      <script type="text/javascript">
          $(document).ready(function () {
           
          });
          //*******************************************************variable*********************************************
          var library_card_no = "", isuuedate = "", sturegno = "0", bookid = "";
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
          function isNumberKey(evt) {
              var charCode = (evt.which) ? evt.which : event.keyCode
              if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                  alertify.error("Please Enter Only Numeric Value.");
                  return false;
              }
              else
                  return true;
          }
          //********************************************************blur event of librarycard**************************************

          $('#ctl00_ContentPlaceHolder1_txtcardno').blur(function () {
              if ($('#ctl00_ContentPlaceHolder1_txtcardno').val() != '') {
                  var library_card_no = $('#ctl00_ContentPlaceHolder1_txtcardno').val();
                  if (library_card_no == '') {
                      alertify.error("Please Enter Library Card No.");
                  }
                  else {
                      bindstudentlist(library_card_no);
                      isuuedate = $("#ctl00_ContentPlaceHolder1_txtissuedate").val();
                      if ($('#studentdetail').find('input[type="hidden"]').length > 0)
                          sturegno = $('#studentdetail').find('input[type="hidden"]').val();
                      else
                          sturegno = 0;
                      library_card_no = $('#ctl00_ContentPlaceHolder1_txtcardno').val();
                      getbookdata(isuuedate, sturegno, library_card_no);
                      getalreadybookdetail(library_card_no);
                      return false;
                  }
              }
          });

          //************************************************************book info**************************************************************************************

          function bindstudentlist(library_card_no) {
             var trforappend = "";
              $('#studentdetail tr').remove();
              call_progressbar("start");
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "book_issue.aspx/fillstudentinfo",
                  data: "{'library_card_no':'" + library_card_no + "'}",
                  dataType: "json",
                  async: false,
                  success: function (data) {
                      if (data.d.length > 0) {
                          for (var i = 0; i < data.d.length; i++) {
                              if (data.d[i].student_image != '') {
                                  trforappend = '<tr> <td rowspan="7"><div class="imageviewstudentdetail" style="margin: 5px;"><img style="max-width:100px;border-width:0px;" alt="No Image" src="../../BranchPanel/Student-Registration/student-registration-document/' + data.d[i].student_image + '" ></td><td><b>Name:</b>' +
                                                 '<span>' + data.d[i].student_name + '</span></td></tr><tr style="background-color:#fcfcfc;"><td><b>Mobile No. : </b><span>' + data.d[i].mobile + '</span></td>' +
                                                 '</tr><tr><td><b>Class Name :</b><span >' + data.d[i].classname + '</span><input id="hfclassid" type="hidden" value="' + data.d[i].sturegno + '"></td></tr><tr style="background-color: #fcfcfc;"><td><b>Section:</b>' +
                                                 '<span>' + data.d[i].section + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Library Membership Status:</b>' +
                                                 '<span>' + data.d[i].membership + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Admission No.:</b>' +
                                                 '<span>' + data.d[i].AdmissionNo + '</span></td></tr>';
                              }
                              else
                              {
                                  trforappend = '<tr> <td rowspan="7"><div class="imageviewstudentdetail" style="margin: 5px;"><img style="max-width:100px;border-width:0px;" alt="No Image" src="../../BranchPanel/Student-Registration/student-registration-document/9update.png" ></td><td><b>Name:</b>' +
                                                                                   '<span>' + data.d[i].student_name + '</span></td></tr><tr style="background-color:#fcfcfc;"><td><b>Mobile No. : </b><span>' + data.d[i].mobile + '</span></td>' +
                                                                                   '</tr><tr><td><b>Class Name :</b><span >' + data.d[i].classname + '</span><input id="hfclassid" type="hidden" value="' + data.d[i].sturegno + '"></td></tr><tr style="background-color: #fcfcfc;"><td><b>Section:</b>' +
                                                                                   '<span>' + data.d[i].section + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Library Membership Status:</b>' +
                                                                                   '<span>' + data.d[i].membership + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Admission No.:</b>' +
                                                                                   '<span>' + data.d[i].AdmissionNo + '</span></td></tr>';
                              }
                              $('#studentdetail').append(trforappend);
                          }

                      }
                      else {
                          $('#TableAlreadytakenbook tbody').find('tr:gt(0)').remove();
                          $('#booklistforissue tbody').find('tr:gt(0)').remove();
                          alertify.error("Library Card No Is Not Valid Due to Student Status Is Deactive Or Library Status Is Deactive Or Wrong Library Card No");
                         
                      }                     
                      call_progressbar("end");
                  },
                  error: function (result) {
                      call_progressbar("end");
                  }
              });

          }
          //*************************************************************book detail for issue grid*******************************************************************************
       
          //***********************************************************************issue date*******************************************************************************
          $("#ctl00_ContentPlaceHolder1_txtissuedate").datepicker({
              changeMonth: true,
              changeYear: true,
              dateFormat: 'dd MM yy',
              maxDate: new Date()
          }).datepicker("setDate", new Date());
          $("#ctl00_ContentPlaceHolder1_txtissuedate").change(function () {
              isuuedate= $("#ctl00_ContentPlaceHolder1_txtissuedate").val();
              if ($('#studentdetail').find('input[type="hidden"]').length > 0)
                  sturegno = $('#studentdetail').find('input[type="hidden"]').val();
              else
                  sturegno = 0;
              library_card_no = $('#ctl00_ContentPlaceHolder1_txtcardno').val();
              getbookdata(isuuedate, sturegno, library_card_no);
              getalreadybookdetail(library_card_no);
              return false;

          });
          //************************************************************check book title on behalf of bookid************************************************
          $('.bookno').live('change', function () {
              var trindex = $(this).parent('td').parent('tr').index();
              if ($(this).val() == '') {
                  $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('td:eq(3)').html('')
                  $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('.Isbnno').val('')
                  return;
              }
              var bookid = $(this).val();
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "book_issue.aspx/gettitle",
                  data: "{'bookid':'" + bookid + "'}",
                  dataType: "json",
                  success: function (data) {                     
                      if (data.d[0].result == 1)
                      {
                          $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('td:eq(3)').html(data.d[0].booktitle)
                          $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('.Isbnno').val(data.d[0].isbn)
                      }
                      else if (data.d[0].result == 2) {
                          alertify.error("Book is not avilable for issue due to Reference Copy or already Distributed");
                          $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('.bookno').val('')
                      }
                      else if (data.d[0].result == 0) {
                          alertify.error("Book Is Not Exists");
                          $('#booklistforissue tbody').find('tr:eq(' + trindex + ')').find('.bookno').val('')
                        
                      }
                  },
                  error: function (result) {

                  }
              });
          });
          //************************************************************check book title on behalf of isbn************************************************
          $('.Isbnno').live('change', function () {
              var trindex1 = $(this).parent('td').parent('tr').index();
              if ($(this).val() == '') {
                  $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('td:eq(3)').html('')
                  $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('.bookno').val('')
                  return;
              }
              var isbn = $(this).val();
              $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "book_issue.aspx/getdata",
                     data: "{'isbn':'" + isbn + "'}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d[0].result == 1){
                             $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('td:eq(3)').html(data.d[0].bookname)
                             $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('.bookno').val(data.d[0].bookid)
                         }
                         else if (data.d[0].result == 2) {
                             alertify.error("Book is not avilable for issue due to Reference Copy or already Distributed");
                             $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('.Isbnno').val('')
                         }
                         else if (data.d[0].result == 0) {
                             alertify.error("Book Is Not Exists");
                             $('#booklistforissue tbody').find('tr:eq(' + trindex1 + ')').find('.Isbnno').val('')

                         }
                     },
                     error: function (result) {

                     }
                 });
          });

          //****************************************************************generate the grid ************************************************************************************

          function getbookdata(isuuedate, sturegno, library_card_no) {
         $('#ctl00_ContentPlaceHolder1_btnissuebook').css("display", "block");
              $('#bookdetailforissue').show(500)
              $('#booklistforissue tr:gt(0)').remove();
              call_progressbar("start");
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "book_issue.aspx/getdatadetailofbook",
                  data: "{'isuuedate':'" + isuuedate + "','sturegno':'" + sturegno + "','library_card_no':'" + library_card_no + "'}",
                  dataType: "json",
                  async: false,
                  success: function (data) {
                      if (data.d.length > 0) {
                          var cssclass = '';
                          for (var i = 0; i < parseInt(data.d[0].maxnoofbook) ; i++) {
                              if (i % 2 != 0)
                                  cssclass = 'stm_light';
                              else
                                  cssclass = 'stm_dark';
                              trforappend = '<tr class=' + cssclass + '><td>' + (i + 1) + '</td>' +
                                     '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" class="bookno" placeholder="Enter Book id" onkeypress="return isNumberKey(event)" max-length=10px/></td>' +
                                     '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" class="Isbnno" placeholder="Enter ISBN No" onkeypress="return isNumberKey(event)"/></td>' +
                                     '<td> ' + '&nbsp;' + '</td>' +
                                     '<td> ' + data.d[0].Issuedate + '</td>' +
                                     '<td> ' + data.d[0].Returndate + '</td>' +
                                     '<td> ' + data.d[0].latefine + '</td></tr>';
                              $('#booklistforissue').append(trforappend);
                          }
                          if (parseInt(data.d[0].maxnoofbook) == 0)
                          {
                              $('#msg').show(500)
                              $('#ctl00_ContentPlaceHolder1_btnissuebook').css("display", "none");
                              alertify.error("All Alloted Books are Already Issued.");
                              
                          }
                          call_progressbar('end');
                      }
                      else {
                          //alertify.error("Library Card No Is Not Valid Due to Student Status Is Deactive Or Library Status Is Deactive Or Wrong Library Card No");
                          //$('#ctl00_ContentPlaceHolder1_txtcardno').val('');
                          $('#ctl00_ContentPlaceHolder1_btnissuebook').css("display", "none");
                          call_progressbar('end');
                      }
                      call_progressbar('end');
                  },
                  error: function (response) {
                      call_progressbar("end");
                  }
              });
          }
          //****************************************************************get detail of already book ************************************************************************************
          function getalreadybookdetail(library_card_no) {
              $('#TableAlreadytakenbook tr:gt(0)').remove();
              call_progressbar("start");
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "book_issue.aspx/getdatadetailofalreadytakenbook",
                  data: "{'library_card_no':'" + library_card_no + "'}",
                  dataType: "json",
                  async: false,
                  success: function (data) {
                      if (data.d.length > 0) {
                          var cssclass = '';
                          for (var i = 0; i < data.d.length; i++) {
                              if (i % 2 != 0)
                                  cssclass = 'stm_light';
                              else
                                  cssclass = 'stm_dark';
                              trforappend = '<tr class=' + cssclass + '><td>' + (i + 1) + '</td>' +
                                           '<td> ' + data.d[i].AlreadyBookid + '</td>' +
                                           '<td> ' + data.d[i].AlreadyISBN + '</td>' +
                                           '<td> ' + data.d[i].AlreadyBooktitle + '</td>' +
                                           '<td> ' + data.d[i].Alreadyissuedate + '</td>' +
                                           '<td> ' + data.d[i].Alreadyreturndate + '</td>' +
                                            '<td> ' + parseFloat(data.d[i].AlreadyLatefine).toFixed(2) + '</td></tr>';
                              $('#TableAlreadytakenbook').append(trforappend);
                          }
                      }

                    
                      call_progressbar('end');
                  },
                  error: function (response) {
                      call_progressbar("end");
                  }
              });
          }
          //***********************************************************************submit event for issuebook******************************************************************
          $('#ctl00_ContentPlaceHolder1_btnissuebook').click(function () {
              if ($("#ctl00_ContentPlaceHolder1_txtcardno").val() == '') {
                  alertify.error("Enter Library Card No.");
                  return false;
              }
              if ($("#ctl00_ContentPlaceHolder1_txtissuedate").val() == '') {
                  alertify.error("Enter Issue Date");
                  return false;
              }
              if ($('.bookno').val() =='') {
                  alertify.error("Enter The Book Id");
                  return false;
              }
              if ($('.Isbnno').val() == '') {
                  alertify.error("Enter The ISBN No.");
                  return false;
              }
              else {
                  insertbookdata();
                  return false;
              }

          })

          //******************************************************************insertdata**************************************************************************
          function insertbookdata() {
               call_progressbar("start");
               var librarycardno = '', issuedate = '', Book_id = '', isbn = '', returndate = '', latefine = '', Book_title = '';
               $('#booklistforissue').find('tr:gt(0)').each(function () {
                   if ($(this).find(".bookno").val().trim() != '') {
                       librarycardno = $("#ctl00_ContentPlaceHolder1_txtcardno").val().trim();
                       issuedate = $("#ctl00_ContentPlaceHolder1_txtissuedate").val().trim();
                       Book_id = Book_id + ',' + $(this).find(".bookno").val().trim();
                       isbn = isbn + ',' + $(this).find(".Isbnno").val().trim();
                       Book_title = Book_title + ',' + $(this).find('td:eq(3)').html().trim();
                       returndate = returndate + ',' + $(this).find('td:eq(5)').html().trim();
                       latefine = latefine + ',' + $(this).find('td:eq(6)').html().trim();
                   }
              })
                   Book_id = Book_id.slice(1, Book_id.length);
                   isbn = isbn.slice(1, isbn.length);
                   Book_title = Book_title.slice(1, Book_title.length);
                   returndate = returndate.slice(1, returndate.length);
                   latefine = latefine.slice(1, latefine.length)
                  $.ajax({
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "book_issue.aspx/savedataforissuebook",
                       data: "{'librarycardno':'" + librarycardno + "','issuedate':'" + issuedate + "','Book_id':'" + Book_id + "','isbn':'" + isbn + "','Book_title':'" + Book_title + "','returndate':'" + returndate + "','latefine':'" + latefine + "'}",
                       dataType: "json",
                       success: function (data) {
                           if (data.d == 1) {
                               call_progressbar("end");
                               alertify.success("Book Issue Successfully.");
                               getalreadybookdetail(librarycardno);
                               getbookdata(isuuedate, sturegno, librarycardno);
                               return false;
                           }
                         
                       },
                       error: function (result) {
                           call_progressbar("end");
                           return false;
                       }
                   });
              return false
               }
      </script>
       </asp:Content>

