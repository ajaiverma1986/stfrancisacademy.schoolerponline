<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" 
    AutoEventWireup="true" CodeFile="student-list.aspx.cs" Inherits="BranchPanel_Admission_student_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Admission_No {
            width:150px;
        }
         .Admission_Date {
            width:150px;
        }
    </style>
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
          <div class="content_pane_cont input_content branch-div-tbl" id="Div1">
        <div class="tbl-top-heading">
            <h2>Student List:</h2>
        </div>
             <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" placeholder="From Date" Width="80px" CssClass="itemdisplaynone"  onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" placeholder="To Date" Width="60px" CssClass="itemdisplaynone"  onkeypress="return false"></asp:TextBox>
            <asp:TextBox ID="txtname" runat="server" placeholder="Student Name" Width="60px" ></asp:TextBox>
            <asp:TextBox ID="txtAdmissionNo" runat="server" placeholder="New/Old Adm No" Width="110px"></asp:TextBox>
               <asp:TextBox ID="txtRegistrationNo" runat="server" placeholder="Registration No." Width="60px"></asp:TextBox>
            <asp:TextBox ID="txtfathername" runat="server" placeholder="Parent Name" Width="60px"  CssClass="itemdisplaynone"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" runat="server" placeholder="Parent Mobile No" CssClass="itemdisplaynone" Width="103px"></asp:TextBox>
               <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="31px">     
            </asp:DropDownList>
             <asp:DropDownList ID="ddlSection" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>     
            <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="31px">     
            </asp:DropDownList>
            <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
                  </div>
        <div id="studentslist" class="student-grid">
            <table style="width: 100%" class="studentlistforBatche" cellpadding="0" cellspacing="0">
            </table>
             <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry Student list not found.</label>
        </div>
        </div>
      
        </div>
          <table style="width: 100%">
                <tr>
                    <td style="padding: 5px; " class="containerHeadline" colspan="10">
                        <table border="0" width="100%">
                                <tr>
                                    <td>
                        <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>                         </td>

                  <td>      <div style="margin-left: 0px; float: left; width: 500px;">
                            <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div> </td>
                                    </tr> </table>
                    </td>
                </tr>
            </table>
    </div>
     <script type="text/javascript">
         var pagesize = 100, pageno = 1,studentRegno = '',SectionID=0, IsAdmissionTaken = 0, Fromdate = '', admissionno = '', Todate = '', Registrationnumber = '', StudentName = '', Applyingforclass = 0, Status = 0, Parentname = '', ParentMobileNo = '', studentid = 0, Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         $(document).ready(function () {
             Bindclassddl();
             Studentlist();
             var year = 2024;
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 dateFormat: 'dd MM yy',
                 yearRange: '1970:' + year
             });
             function FillField() {                 
                 Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
                 Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
                 StudentName = $('#ctl00_ContentPlaceHolder1_txtname').val();
                 admissionno = $('#ctl00_ContentPlaceHolder1_txtAdmissionNo').val();
                 Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtRegistrationNo').val();
                 Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
                 ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
                 Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
                 if (Applyingforclass > 0) {
                     if ($('#ctl00_ContentPlaceHolder1_ddlSection').val() != null) {
                         SectionID = $('#ctl00_ContentPlaceHolder1_ddlSection').val();
                     }
                     else {
                         SectionID = 0;
                     }
                 }
                 Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();               
             }
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                 FillField();
                 Studentlist();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlfyear").on('change keyup paste', function () {
                 FillField();
                 Studentlist();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
                 FillField();
                 Studentlist();
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                     data: "{'ClassID':'" + Applyingforclass + "'}",
                     dataType: "json",
                     async: false,
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                         $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                         });
                         call_progressbar("end");
                     }
                 });
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlSection").on('change keyup paste', function () {
                 FillField();
                 Studentlist();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_txtname,#ctl00_ContentPlaceHolder1_txtAdmissionNo,#ctl00_ContentPlaceHolder1_txtRegistrationNo,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno").keyup(function () {
                 FillField();
                 Studentlist();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                 ClearAll();
                 Studentlist();
                 return false;
             });
             $('.StudentName').live('click', function () {
                 studentRegno = $(this).closest('tr').find('input[type=hidden]').val();
                 window.location.href = "student-admission-list.aspx?studentRegno=" + studentRegno;
                 return false;
             });
             $('.btnfirst').live('click', function () {
                 pageno = 1;
                 $(".lblpage").html(pageno);
                 FillField();
                 Studentlist();
                 alertify.success('You Are On The First Page.');
                 return false;
             });
             $('.btnprev').live('click', function () {
                 if (parseInt(pageno) > 1) {
                     pageno = parseInt(pageno) - 1;
                     $(".lblpage").html(pageno);
                     FillField();
                     Studentlist();
                     return false;
                 }
                 else {
                     alertify.error('No More Prevoius Page Is There.');
                     return false;
                 }
             });
             $('.btnnext').live('click', function () {
                 if (parseInt(pageno) < parseInt(pagecount)) {
                     pageno = parseInt(pageno) + 1;
                     $(".lblpage").html(pageno);
                     FillField();
                     Studentlist();
                     return false;
                 }
                 else {
                     alertify.error('No More Next Page Is There.');
                     return false;
                 }
             });
             $('.btnlast').live('click', function () {
                 pageno = pagecount;
                 $(".lblpage").html(pageno);
                 FillField();
                 Studentlist();
                 alertify.success('You Are On The Last Page.');
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                 Bindclassddl();
             });
         });
         function Bindclassddl() {
             $('#ctl00_ContentPlaceHolder1_ddlclass').html('');
             $.ajax({
                 type: 'POST',
                 contentType: "application/json; charset=utf-8",
                 url: "../Student-Registration/student-registration-list.aspx/BindClassDDL",
                 data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "'}",
                 dataType: "json",
                 success: function (data) {
                     $('#ctl00_ContentPlaceHolder1_ddlclass').html('<option value="0">--Select Class--</option>');
                     if (data.d.length > 0) {
                         for (var i = 0; i < data.d.length; i++) {
                             $('#ctl00_ContentPlaceHolder1_ddlclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                         }
                     }
                 }
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
         function ClearAll() {
             Fromdate = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', ParentMobileNo = '';
             Applyingforclass = 0, admissionno = '', Fyid = 0;
             $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtRegistrationNo,#ctl00_ContentPlaceHolder1_txtAdmissionNo,#ctl00_ContentPlaceHolder1_txtname,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txttodate').val('');
            $('#ctl00_ContentPlaceHolder1_ddlfyear').val('0');
            Bindclassddl();
         }
         function Studentlist() {
             call_progressbar('start');
             $('.studentlistforBatche').html('');            
             var trforappend = '';
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "student-list.aspx/GetStudentList",
                 data: "{'SectionID':'" + SectionID + "','Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','StudentName':'" + StudentName + "','admissionno':'" + admissionno + "','Registrationnumber':'" + Registrationnumber + "','Parentname':'" + Parentname + "','ParentMobileNo':'" + ParentMobileNo + "','Applyingforclass':'" + Applyingforclass + "','Fyid':'" + Fyid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     $('.divnorecordfound').css('display', 'none');
                     if (data.d.length > 0) {
                         pagecount = data.d[0].pagecount;
                         $('.lbltotalpage').html(data.d[0].pagecount);
                         if ($(".lblpage").html() == 0) {
                             $(".lblpage").html(1);
                         }
                         for (var i = 0; i < data.d.length; i++) {
                             trforappend = '<tr>' +
                             '<td><div class="student-photo_frame1"><div class="student-photo_frame_img"><img  class="photo" style="border-width: 0px;" src="' + data.d[i].photo + '" alt="No Image" />' +
                              '<input id="hfsturegno" type="hidden" value="' + data.d[i].StuRegNo + '"  /></div>' +                             
                               '<div class="student-detail"><div class="user-deatils1"><a  class="swet StudentName" style="cursor:pointer" >' + data.d[i].studentname + '</a></div>' +
                               '<div class="clear"></div><div class="user-deatils1"><div style="float:left"><dt>Admission No.</dt><cite>:</cite><span  class="Admission_No">' + data.d[i].RegNewNo + '</span></div><div style="float:left"><dt>Father Name.</dt><cite>:</cite><span  class="Admission_No">' + data.d[i].fathername + '</span></div>' +
                               '<div class="clear"></div><div class="user-deatils1"><div style="float:left"></div></div><div class="clear"></div><div class="user-deatils1"><dt>Admission Date.</dt><cite>:</cite><span><span  class="Admission_Date">' + data.d[i].AdmissionDate + '</span></span><dt>Class-Sec.</dt><cite>:</cite><span><span  class="Admission_Date">' + data.d[i].class_sectionname + '</span></span></div>' +
                               '<div class="clear"></div><div class="user-deatils1"><dt>Registration No.</dt><cite>:</cite><span><span  class="Registration_No">' + data.d[i].Registration_No + '</span></span><div class="del-active"></div></div> </div>' +
                              '</tr>';
                             $('.studentlistforBatche').append(trforappend);
                         }
                     }
                     else {
                         $('.divnorecordfound').css('display', 'inline');
                         $(".lblpage").html(0);
                         $('.lbltotalpage').html(0);
                     }
                     call_progressbar("end");
                 },
                 error: function (response) {
                     call_progressbar("end");
                 }
             });
         }
          </script>
      <div id="divProgressBar" class="progress"></div>
</asp:Content>

