<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-registration-list.aspx.cs" Inherits="BranchPanel_Student_Registration_student_registration_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clear"></div>
    <div class="branch-div-tbl">
    <div class="content_pane_cont input_content" id="contentPane">
          <div class="tbl-top-heading">
                <h2>Student Registration List</h2>
                 <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
            </div>       
        <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="80px" ></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="80px"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="102px"></asp:TextBox>
            <asp:TextBox ID="txtstuname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Student Name" Width="102px"></asp:TextBox>          
            <asp:TextBox ID="txtfathername" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Parent Name" Width="86px"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Parent Mobile No" Width="110px"></asp:TextBox>
            <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="31px">     
            </asp:DropDownList>
            <asp:DropDownList ID="ddlstatus" runat="server" Width="120px" Height="31px">
                <asp:ListItem Value="0" Text="Select Status"></asp:ListItem>
                <asp:ListItem Value="1" Text="Registered"></asp:ListItem>
                <asp:ListItem Value="2" Text="Shortlisted"></asp:ListItem>
                <asp:ListItem Value="3" Text="Rejected"></asp:ListItem>
                <asp:ListItem Value="4" Text="Waiting"></asp:ListItem>
                <asp:ListItem Value="5" Text="Addmision"></asp:ListItem>
            </asp:DropDownList>
             <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="31px">     
            </asp:DropDownList>
            <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="../../images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
 </div>
        <div class="grid-data-resposive">
            <div class="divforstm">
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration Date</th>
                    <th align="center">Registration No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Apply Class</th>
                    <th align="center">Status</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Parent Mob No</th>
                    <th>Report</th>
                    <th>Edit</th>
                </tr>
            </table>                
            </div>
            <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry Student Registration list not found.</label>
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
            <input type="hidden" id="hfpages" />
         </div>
     <script type="text/javascript">
         var Admissionnnumber = '', admissionstatus = '',pagesize = 300, pageno = 1, mode = 1, IsAdmissionTaken = 0, Fromdate = '', Todate = '', Registrationnumber = '', StudentName = '', Applyingforclass = 0, Status = 0, Parentname = '', ParentMobileNo = '', RID = 0, Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         $(document).ready(function () {

             $('.ImgGenerateRecipt').live('click', function () {               
                 var registrationNo = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type="hidden"]').val();
                 var win = window.open("../Fee Management/Registration_History.aspx?REG=" + registrationNo, '_blank');
                 win.focus();
                 return false;
                 alert(1);
             });

             Bindclassddl();
             Bindstudentregistration();
                 
             var year = 2022;
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 dateFormat: 'dd MM yy',
                 yearRange: '2000:' + year
             });
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                 FillField();
                 Bindstudentregistration();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno").keyup(function () {
                 FillField();
                 Bindstudentregistration();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlclass,#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddlstatus").on('change keyup paste', function () {
                 FillField();
                 Bindstudentregistration();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                 ClearAll();
                 Bindstudentregistration();
                 return false;
             });
             $('.edit').live('click', function () {              
                 admissionstatus = $(this).closest('tr').find('td:eq(5)').text().trim();
                 if (admissionstatus == 'Admission Taken') {
                     alert('Admission is given so you can not edit information of this student.');
                     return false;
                 }
                 else {
                     RID = $(this).closest('tr').find('input[type=hidden]').val();
                     if ($("#ctl00_ContentPlaceHolder1_ddlfyear").val() == '3')
                     {
                         window.location.href = "StudentNewReg.aspx?RID=" + RID;
                     }
                     else
                     {
                         window.location.href = "student-registration.aspx?RID=" + RID;
                     }
                     return false;
                 }
             });
             $(".BtnExcel").click(function (e) {
                 alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                     if (e) {
                         window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                         e.preventDefault();
                     }
                 });
                 return false;
             });
             $('.btnfirst').live('click', function () {
                 pageno = 1;
                 $(".lblpage").html(pageno);
                 FillField();
                 Bindstudentregistration();
                 alertify.success('You Are On The First Page.');
                 return false;
             });
             $('.btnprev').live('click', function () {
                 if (parseInt(pageno) > 1) {
                     pageno = parseInt(pageno) - 1;
                     $(".lblpage").html(pageno);
                     FillField();
                     Bindstudentregistration();
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
                     Bindstudentregistration();
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
                 Bindstudentregistration();
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
                 url: "student-registration-list.aspx/BindClassDDL",
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
         function lettersOnly(evt) {
             evt = (evt) ? evt : event;
             var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
           ((evt.which) ? evt.which : 0));
             if (charCode > 32 && (charCode < 65 || charCode > 90) &&
           (charCode < 97 || charCode > 122)) {
                 alertify.error("Please Enter Character Only.");
                 return false;
             }
             else
                 return true;
         };
         function isNumberKey(evt) {
             var charCode = (evt.which) ? evt.which : event.keyCode
             if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                 alertify.error("Please Enter Only Numeric Value.");
                 return false;
             }
             else
                 return true;
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
         function FillField() {
             Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
             Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
             Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
             StudentName = $('#ctl00_ContentPlaceHolder1_txtstuname').val();
             Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
             Status = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
             Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
             ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
             Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         }
         function ClearAll() {
             Fromdate = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', ParentMobileNo = '';
             Applyingforclass = 0, Status = 0, Fyid = 1;
             $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val('');
             $('#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlfyear').val('0');
             Bindclassddl();
         }
         function Bindstudentregistration() {
             $('.stm tr:gt(0)').remove();
             call_progressbar('start')
             var trforappend = '', trclass = '';
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "student-registration-list.aspx/BindGridByJs",
                 data: "{'SectionID':'0','Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','StudentName':'" + StudentName + "','Parentname':'" + Parentname + "','ParentMobileNo':'" + ParentMobileNo + "','Status':'" + Status + "','Applyingforclass':'" + Applyingforclass + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "','mode':'" + mode + "','Admissionnnumber':'" + Admissionnnumber + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                 dataType: "json",
                 success: function (data) {
                     $('.divnorecordfound').css('display', 'none');
                     if (data.d.length > 0) {
                         pagecount = data.d[0].pagecount;
                         $('.lbltotalpage').html(data.d[0].pagecount);
                         if ($(".lblpage").html() == 0) {
                             $(".lblpage").html(1);
                         }
                         for (var i = 0; i < data.d.length; i++) {
                             trforappend = trforappend + "<tr class=" + trclass + ">" +
                                 "<td><input type='hidden' value='" + data.d[i].RID + "' />" + (i + 1) + "</td>" +
                                 "<td>" + data.d[i].RegistrationDate + " </td>" +
                                 "<td><input type='hidden' value='" + data.d[i].Registration_No + "' />" + data.d[i].Registration_No + " </td>" +
                                 "<td>" + data.d[i].studentname + " </td>" +
                                 "<td>" + data.d[i].Classname + " </td>" +
                                 "<td>" + data.d[i].Status + " </td>" +
                                 "<td>" + data.d[i].fathername + " </td>" +
                                 "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
                                 '<td><input class="ImgGenerateRecipt" type="image" style="width:20px;border-width:0px;" src="../../images/recipt.png" title="View Registration Report." /></td>'+
                                 "<td><img src='../images/edit.png' style='cursor:pointer' title='Edit' class='edit'></img></td>" +
                                 "</tr>"
                         }
                         $('.stm').append(trforappend);
                     }
                     else {
                         $('.divnorecordfound').css('display', 'inline');
                         $(".lblpage").html(0);
                         $('.lbltotalpage').html(0);
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error("Error While Grid Is Binding");
                     call_progressbar("end");
                 }

             });
         }
            </script>
     <div id="divProgressBar" class="progress"></div>
</asp:Content>