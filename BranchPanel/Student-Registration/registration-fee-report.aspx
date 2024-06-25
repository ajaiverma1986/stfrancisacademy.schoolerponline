<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" enableEventValidation="false" AutoEventWireup="true" CodeFile="registration-fee-report.aspx.cs" Inherits="BranchPanel_Student_Registration_registration_fee_report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="clear"></div>
    <div class="branch-div-tbl">
    <div class="content_pane_cont input_content" id="contentPane">
     <div class="tbl-top-heading">
                <h2>Student Fee Report</h2>
                <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel exc" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
				 <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                     <asp:Button ID="btnPdf"  runat="server"  Visible="true" Text="Download Pdf File"
                CausesValidation="false" Height="20px" CssClass="BtnExcel pd"
                ToolTip="Click here to download Pdf"  ClientIDMode="Static"/>   </div>
            </div>
      <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="65px" ></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="60px"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="96px"></asp:TextBox>
            <asp:TextBox ID="txtstuname" runat="server" placeholder="Student Name" Width="90px"></asp:TextBox>          
            <asp:TextBox ID="txtfathername" runat="server" placeholder="Parent Name" Width="84px"></asp:TextBox>
            <asp:TextBox ID="txtcheckno" runat="server" placeholder="Enter Check No" Width="96px"></asp:TextBox>
            <asp:DropDownList ID="ddlpaymentmode" runat="server" Width="125px" Height="31px">
                <asp:ListItem Value="0" Text="Payment Mode"></asp:ListItem>
                <asp:ListItem Value="1" Text="Cash"></asp:ListItem>
                <asp:ListItem Value="2" Text="Cheque"></asp:ListItem>
                <asp:ListItem Value="3" Text="DD"></asp:ListItem>
                <asp:ListItem Value="4" Text="NEFT"></asp:ListItem>
            </asp:DropDownList>
            
            <asp:DropDownList ID="ddlclass" runat="server" Width="106px" Height="31px">     
            </asp:DropDownList>
            <asp:DropDownList ID="ddlstatus" runat="server" Width="115px" Height="31px">
                <asp:ListItem Value="0" Text="Select Status"></asp:ListItem>
                <asp:ListItem Value="1" Text="Registered"></asp:ListItem>
                <asp:ListItem Value="2" Text="Shortlisted"></asp:ListItem>
                <asp:ListItem Value="3" Text="Rejected"></asp:ListItem>
                <asp:ListItem Value="4" Text="Waiting"></asp:ListItem>
                <asp:ListItem Value="5" Text="Addmision"></asp:ListItem>
            </asp:DropDownList>
             <asp:DropDownList ID="ddlfyear" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>
            <asp:DropDownList ID="ddlUsers" runat="server" Width="125px" ClientIDMode="Static" Height="31px" AutoPostBack="false">                
            </asp:DropDownList>
            <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="../../images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
        </div>
         <div class="divforstm">
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration Date</th>
                    <th align="center">Registration No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Apply Class</th>
                    <th align="center">Status</th>
                    <th align="center">Registration Fee</th>
                    <th align="center">Payment mode</th>
                    <th align="center">CHK/DD/NEFT/REF No</th>  
                    <th align="center">CHK/DD/NEFT/Status</th>     
                     <th align="center">Payment slip</th>     					
                </tr>
            </table>
             <table class="GridSum" style="width: 100%">
                <tr class="stm_head" >
                <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                <td style="margin-right:20px;float:right; color:red;">Total:</td>
                <td>
                <label id="lbltotalregistrationfee"></label>
                </td>
                     <td></td>
                </tr>
            </table>
             <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">           
        <label style="font-size: 15px; color: red">Sorry record not found.</label>
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
        <input type="hidden" value="" id="hdnFile"/>
        </div>
    
         <script type="text/javascript">
             var pagesize = 100, pageno = 1,Fromdate = '', Todate = '',Registrationnumber = '', StudentName = '', Applyingforclass = 0, Status = 0, Parentname = '', checkNo = '', studentid = 0, paymentmode = 0, Fyid = 1;
             $(document).ready(function () {               
                 Bindstudentregistration();
                 BindClass();
                 $(".lblpage").html(1);
                 var year = 2015;
                 $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                     changeMonth: true,
                     changeYear: true,
                     dateFormat: 'dd MM yy',
                     yearRange: '1970:' + year
                 });

                 $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                     FillField();
                     Bindstudentregistration();
                     return false;
                 });
                 $("#ctl00_ContentPlaceHolder1_txtcheckno,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txtregnumber").change(function () {
                     FillField();
                     Bindstudentregistration();
                     return false;
                 });
                 $("#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlclass,#ctl00_ContentPlaceHolder1_ddlpaymentmode,#ctl00_ContentPlaceHolder1_ddlfyear").on('change paste', function () {
                     FillField();
                     Bindstudentregistration();
                     return false;
                 });
                 $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                     ClearAll();
                     Bindstudentregistration();
                     return false;
                 });
                 $('#ddlUsers').change(function () {                    
                     Bindstudentregistration();
                     return false;
                 });
                 $(".exc").click(function (e) {
                     
                     alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                         if (e) {
                             window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                             e.preventDefault();
                         }
                     });
                     return false;
                 });

                 $(".pd").click(function (e) {

                     alertify.confirm("Are You Sure You Want To Download The Pdf.", function (e) {
                         if (e) {                            
                             download_file($('#hdnFile').val(), "reg.pdf")
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
                     BindClass();
                 });
             });
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
			 
			 function OpenRpt(val)
             {
                 var url = "../Fee%20Management/Register_receipt.aspx?RID=" + val + "";
                 window.open(url, '_blank');
			 }

			 function download_file(fileURL, fileName) {
			     // for non-IE
			     if (!window.ActiveXObject) {
			         var save = document.createElement('a');
			         save.href = fileURL;
			         save.target = '_blank';
			         var filename = fileURL.substring(fileURL.lastIndexOf('/') + 1);
			         save.download = fileName || filename;
			         if (navigator.userAgent.toLowerCase().match(/(ipad|iphone|safari)/) && navigator.userAgent.search("Chrome") < 0) {
			             document.location = save.href;
			             // window event not working here
			         } else {
			             var evt = new MouseEvent('click', {
			                 'view': window,
			                 'bubbles': true,
			                 'cancelable': false
			             });
			             save.dispatchEvent(evt);
			             (window.URL || window.webkitURL).revokeObjectURL(save.href);
			         }
			     }

			         // for IE < 11
			     else if (!!window.ActiveXObject && document.execCommand) {
			         var _window = window.open(fileURL, '_blank');
			         _window.document.close();
			         _window.document.execCommand('SaveAs', true, fileName || fileURL)
			         _window.close();
			     }
			 }
             function Bindstudentregistration() {              
                 $('.stm tr:gt(0)').remove();
                 call_progressbar('start')
                 var trforappend = '', trclass = '';
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "registration-fee-report.aspx/BindGridByJs",
                     data: "{'Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','StudentName':'" + StudentName + "','Parentname':'" + Parentname + "','checkNo':'" + checkNo + "','Status':'" + Status + "','Applyingforclass':'" + Applyingforclass + "','paymentmode':'" + paymentmode + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','User':'" + $('#ddlUsers').val() + "'}",
                     dataType: "json",
                     success: function (data) {
                         $('#hdnFile').val('');
                         $('.divnorecordfound').css('display', 'none');
                         $('.GridSum').show();
                         if (data.d.length > 0) {
                             pagecount = data.d[0].pagecount;
                             $('#hdnFile').val(data.d[0].filePath);
                             $('.lbltotalpage').html(data.d[0].pagecount);
                             if ($(".lblpage").html() == 0) {
                                 $(".lblpage").html(1);
                             }
                             for (var i = 0; i < data.d.length; i++) {

                                 trforappend = trforappend + "<tr class=" + trclass + ">" +
                                 "<td><input type='hidden' value='" + data.d[i].RID + "' />" + (i + 1) + "</td>" +
                                 "<td>" + data.d[i].RegistrationDate + " </td>" +
                                 "<td>" + data.d[i].Registration_No + " </td>" +
                                 "<td>" + data.d[i].studentname + " </td>" +
                                 "<td>" + data.d[i].Classname + " </td>" +
                                 "<td>" + data.d[i].Status + " </td>" +
                                 "<td>" + data.d[i].Registrationfee + " </td>" +
                                 "<td>" + data.d[i].Payment + " </td>" +
                                  "<td>" + data.d[i].Paymentmode + " </td>" +
                                  "<td>" + data.d[i].CheckStatus + " </td>" +
                                  "<td><input class='ImgGenerateRecipt' onclick='OpenRpt(&quot;" + data.d[i].Registration_No + "&quot;)' type='image' style='width:20px;border-width:0px;' src='../../images/recipt.png' title='View Payment slip'></td>" +
                                 "</tr>"
                             }
                            
                             $('.stm').append(trforappend);
                             var sum = 0;
                             for (var i = 0; i < data.d.length; i++) {
                               
                                 sum += parseFloat(data.d[i].Registrationfee);      
                             }
                             $('#lbltotalregistrationfee').text(sum.toFixed(2));   
                         }
                         else {
                             $('.GridSum').hide();
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
             function BindClass() {
                 fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
                
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../Fee Management/rollback-fee-list.aspx/bindclass",
                     data: "{'fyid':'" + fyid + "'}",
                     dataType: "json",
                     success: function (data) {
                         $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                         $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('Select Class'));
                         $.each(data.d, function (key, value) {
                             $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.classid).html(value.Classname));
                         });
                         
                     },
                     error: function (result) {
                        
                         alertify.error('Some Error');
                     },
                 });
             }
             function FillField() {
                 Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
                 Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
                 Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
                 StudentName = $('#ctl00_ContentPlaceHolder1_txtstuname').val();
                 Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
                 Status = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
                 Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
                 checkNo = $('#ctl00_ContentPlaceHolder1_txtcheckno').val();
                 paymentmode = $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val();
                 Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
             }
             function ClearAll() {
                 Fromdate = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', checkNo = '';
                 Applyingforclass = 0, Status = 0, paymentmode = 0, Fyid = 1;
                 $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtcheckno').val('');              
                 $('#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlpaymentmode').val('0');
                 $('#ctl00_ContentPlaceHolder1_ddlfyear').val('1');
                 BindClass();
             }
              </script>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>

