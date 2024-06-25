<%@ Page Language="C#" AutoEventWireup="true" CodeFile="book_return.aspx.cs" Inherits="BranchPanel_library_management_book_return" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" %>

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
                     <h2> Return Book</h2>
                     </div>
        <div style="float:left; width:49%;">
            <div id="Returnbook" runat="server">
            <div class="for_sigle_row_form">
                <label>Library Card No<span style="color: Red">*</span></label>
                 <asp:TextBox ID="txtcardno" Style="border: 2px #2CA8C2 solid;" placeholder="Enter Library Card No"  runat="server"> </asp:TextBox>
            </div>
                  <div class="for_sigle_row_form">
                <label>Return Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtreturndate" runat="server" ReadOnly="true" placeholder="Enter Date of Return Book"  > </asp:TextBox>
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
       <div id="takenbook">
         <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2>Issued Book Details</h2>
                     </div>
        <table id="Tabletakenbook" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 10px">Book Id</th>
                <th scope="col" style="width: 20px">ISBN</th>
                <th scope="col" style="width: 60px">Book Title</th>
                <th scope="col" style="width: 50px">Issue Date</th>
                <th scope="col" style="width: 20px">Return Date</th>
                <th scope="col" style="width: 20px">Late Days</th>
                <th scope="col" style="width: 20px">Fine(Per Day)</th>
                 <th scope="col" style="width: 20px">Total Fine</th>
                <th scope="col" style="width: 20px">Return/Reissue</th>
            </tr>
        </table>
           
         </div>
           <div id="returnbook" style="text-align: center; display: none;" class="">
        <table id="Tabledetailofreturnbook" width="100%" class="book shadow1" style="background: #fff;">
             <tr id="ttfine" class="for_sigle_row_form">
                       <td class="t1"><label><b>Total Fine:</b></label></td>
                        <td class="t2"><asp:TextBox ID="txtbookid" runat="server" placeholder="Enter Total Amount" ReadOnly="true"></asp:TextBox></td>
                      </tr>
            <tr id="paymode"class="for_sigle_row_form">
              <td class="t1"><label><b>Payment Mode:</b></label></td>
              <td><select id="ddlmode" >
               <option value="0">Cash</option>
            </select></td>
            </tr>
             <tr  id="payamount" class="for_sigle_row_form">
                       <td class="t1"><label><b> Paid Fine:</b></label></td>
                        <td class="t2"><asp:TextBox ID="TextBoxpaidfine" runat="server" placeholder="Enter Paid Amount"></asp:TextBox></td>
                      </tr>
            <tr  id="discount" class="for_sigle_row_form">
                       <td class="t1"><label><b> Discount On Fine:</b></label></td>
                        <td class="t2"><asp:TextBox ID="Textdiscount" runat="server" placeholder="Enter Discount Amount"></asp:TextBox></td>
                      </tr>
            <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitdata" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                 </table>
        </div>
             
        
           <div id="divProgressBar" class="progress"></div>
         </div>
     <script type="text/javascript">
         //**************************************************variable*********************************************************
         var library_card_no = '', Returndateofbook = '', bookid = '', Isbn = ''; Booktitle = ''; issuedate = '', returndate = ''; lateday = '', Latefine = '', totalfine = 0.00, total = 0.00, subtotal = 0.00, trindex = 0;
   //********************************************************progressbar*******************************************************
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
         //********************************************************return date***********************************************
         $("#ctl00_ContentPlaceHolder1_txtreturndate").datepicker({
             changeMonth: true,
             changeYear: true,
             dateFormat: 'dd MM yy',
             minDate: new Date()
         }).datepicker("setDate", new Date());
         //********************************************************blur event of librarycard*******************************************
         $('#ctl00_ContentPlaceHolder1_txtcardno').blur(function () {
             if ($('#ctl00_ContentPlaceHolder1_txtcardno').val() != '') {
                library_card_no = $('#ctl00_ContentPlaceHolder1_txtcardno').val();
                 if (library_card_no == '') {
                     alertify.error("Please Enter Library Card No.");
                 }
                 else {
                     bindstudentlist(library_card_no);
                     Returndateofbook = $("#ctl00_ContentPlaceHolder1_txtreturndate").val();
                     getbookdetail(library_card_no, Returndateofbook);
                     return false;
                 }
             }
         });
         //*********************************************************change event******************************************************
         $("#ctl00_ContentPlaceHolder1_txtreturndate").change(function () {
             Returndateofbook = $("#ctl00_ContentPlaceHolder1_txtreturndate").val();
            library_card_no = $('#ctl00_ContentPlaceHolder1_txtcardno').val();
             getbookdetail(library_card_no, Returndateofbook);
           return false;

         });
         //**************************************************bind student detail of student*******************************************
        function bindstudentlist(library_card_no) {
             var trforappend = "";
             $('#studentdetail tr').remove();
             call_progressbar("start");
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "book_return.aspx/fillstudentinfo",
                 data: "{'library_card_no':'" + library_card_no + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     if (data.d.length > 0) {
                         for (var i = 0; i < data.d.length; i++) {                             
                             if(data.d[i].student_image != '')
                             {
                                 trforappend = '<tr> <td rowspan="7"><div class="imageviewstudentdetail" style="margin: 5px;">'+
                                 '<img style="max-width:100px;border-width:0px;" src="../../BranchPanel/Student-Registration/student-registration-document/' + data.d[i].student_image + '" alt="No Image" ></td><td><b>Name:</b></td>' +
                                 '<td><b>Name:</b>' +
                                            '<span>' + data.d[i].student_name + '</span></td></tr><tr style="background-color:#fcfcfc;"><td><b>Mobile No. : </b><span>' + data.d[i].mobile + '</span></td>' +
                                            '</tr><tr><td><b>Class Name :</b><span >' + data.d[i].classname + '</span><input id="hfclassid" type="hidden" value="' + data.d[i].sturegno + '"></td></tr><tr style="background-color: #fcfcfc;"><td><b>Section:</b>' +
                                            '<span>' + data.d[i].section + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Library Membership Status:</b>' +
                                            '<span>' + data.d[i].membership + '</span></td></tr><tr style="background-color: #fcfcfc;"><td><b>Admission No.:</b>' +
                                            '<span>' + data.d[i].AdmissionNo + '</span></td></tr>';
                             }
                             else
                             {
                                 trforappend = '<tr> <td rowspan="7"><div class="imageviewstudentdetail" style="margin: 5px;">'+
                                 '<img style="max-width:100px;border-width:0px;" src="../../BranchPanel/Student-Registration/student-registration-document/9update.png" alt="No Image" ></td><td><b>Name:</b></td>'+
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
                         $('#Tabletakenbook tbody').find('tr:gt(0)').remove();
                         alertify.error("Library Card No Is Not Valid Due to Student Status Is Deactive Or Library Status Is Deactive Or Wrong Library Card No");
                         $('#ctl00_ContentPlaceHolder1_txtcardno').val('')
                     }

                     call_progressbar("end");
                 },
                 error: function (result) {
                     call_progressbar("end");
                 }
             });

        }
        //****************************************************************get detail of already book ************************************************************************************
        function getbookdetail(library_card_no, Returndateofbook) {
            $('#Tabletakenbook tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_return.aspx/getdatadetailtakenbook",
                data: "{'library_card_no':'" + library_card_no + "','Returndateofbook':'" + Returndateofbook + "'}",
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
                                         '<td> ' + data.d[i].Bookid + '</td>' +
                                         '<td> ' + data.d[i].ISBN + '</td>' +
                                         '<td> ' + data.d[i].Booktitle + '</td>' +
                                         '<td> ' + data.d[i].issuedate + '</td>' +
                                         '<td> ' + data.d[i].returndate + '</td>' +
                                         '<td> ' + data.d[i].lateday + '</td>' +
                                         '<td> ' + parseFloat(data.d[i].Latefine).toFixed(2) + '</td>' +
                                         '<td> ' + parseFloat(data.d[i].totalfine).toFixed(2) + '</td>' +
                                        '<td><input class="chkreturn" type="checkbox"  style="margin-left:3px;"><input id="reissuebook" type="button"  class="button2 inputinstitute" value="Reissue" style="margin-left:15px;"><input id="hfbookid" type="hidden" value="' + data.d[i].Bookid + '"></td></tr>';

                            $('#Tabletakenbook').append(trforappend);
                        }
                    }
                 

                    call_progressbar('end');
                },
                error: function (response) {
                    call_progressbar("end");
                }
            });
        }
         //*************************************************************change event of checkbox***************************************************
        $('.chkreturn').live('change', function () {
            trindex = $(this).parent('td').parent('tr').index();
            var amount = 0;
            $('#Tabletakenbook').find('tr:gt(0)').each(function () {
               
                if ($(this).find('td:eq(9)').find('input[type="checkbox"]').is(":checked") == true)
                {
                    amount = amount + parseInt($(this).find('td:eq(8)').html())
                    
                }
            })
       
                $('#ctl00_ContentPlaceHolder1_txtbookid').val(amount);
                $('#returnbook').show(500);
                return false;
        
         })
         //****************************************************************submit the return book******************************************************************
       

        $("#ctl00_ContentPlaceHolder1_BtnSubmitdata").click(function () {
            if ($(this).val() == "Submit") {

                Bookreturn();
                return false;
            }
    
        })
        function Bookreturn() {
            var bookid = '', Isbn = '', totalfine = '', returndate = '', librarycard = '', paidamount = 0.00, Grandtotal = 0.00, discountamt = 0.00;
            discountamt = $("#ctl00_ContentPlaceHolder1_Textdiscount").val();
            if (discountamt == "") {
                discountamt = 0.00
            }
            else {
                discountamt = $("#ctl00_ContentPlaceHolder1_Textdiscount").val();
            }
            paidamount = $("#ctl00_ContentPlaceHolder1_TextBoxpaidfine").val();
            if (paidamount == "") {
                paidamount = 0.00
            }
            else {
                paidamount = $("#ctl00_ContentPlaceHolder1_Textdiscount").val();
            }
            Grandtotal = $("#ctl00_ContentPlaceHolder1_txtbookid").val();
            $('#Tabletakenbook').find('tr:gt(0)').each(function () {
                if ($(this).find('td:eq(9)').find('input[type="checkbox"]').is(":checked") == true) {
                    librarycard = $("#ctl00_ContentPlaceHolder1_txtcardno").val();
                    returndate = $("#ctl00_ContentPlaceHolder1_txtreturndate").val();
                    bookid = bookid + ',' + $(this).find('td:eq(1)').html().trim();
                    Isbn = Isbn + ',' + $(this).find('td:eq(2)').html().trim();
                    totalfine = totalfine + ',' + $(this).find('td:eq(8)').html().trim();
                }
            })
            bookid = bookid.slice(1, bookid.length);
            Isbn = Isbn.slice(1, Isbn.length);
            totalfine = totalfine.slice(1, totalfine.length);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "book_return.aspx/savedataforreturnbook",
                data: "{'librarycard':'" + librarycard + "','returndate':'" + returndate + "','bookid':'" + bookid + "','Isbn':'" + Isbn + "','totalfine':'" + totalfine + "','paidamount':'" + paidamount + "','Grandtotal':'" + Grandtotal + "','discountamt':'" + discountamt + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        call_progressbar("end");
                        alertify.success("Book Return Successfully.");
                        $('#returnbook').hide(500);
                        bookid = '', Isbn = '', totalfine = '', returndate = '', librarycard = '', paidamount = 0.00, Grandtotal = 0.00;
                        $('.chkreturn').prop('checked', false);
                        $("#ctl00_ContentPlaceHolder1_TextBoxpaidfine").val('');
                        getbookdetail(library_card_no, Returndateofbook);
                        return false;
                    }

                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
            return false;
        }
         //***********************************************************************Click on reissuebook***************************************************************
        $("#reissuebook").live('click',function () {
            alert('hiii');
            trindex = $(this).parent('td').parent('tr').index();
            var fineamount = 0;
         
            $('#Tabletakenbook').find('tr:gt(0)').each(function () {
                fineamount=$(this).find('td:eq(8)').html() 
            })
            $('#ctl00_ContentPlaceHolder1_txtbookid').val(fineamount);
            $('#returnbook').show(500);
            return false;
        })
     </script>
    
          </asp:Content>
