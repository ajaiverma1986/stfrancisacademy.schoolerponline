<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="transfered-student-list.aspx.cs" Inherits="BranchPanel_StudentManagement_transfered_student_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <style type="text/css">
.tblpopup {
    width: 100%;
    display:block;
}
.theadpopup {
    display: inline-block;
    width: 100%;
    height: 20px;
   
}

.tbodypopup {
    height: 500px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}
         .showpopupemployeedetails {
             width:83% !important;
         }
         </style>
      <div class="clear"></div>
    <div class="branch-div-tbl">
    <div class="content_pane_cont input_content" id="contentPane">
          <div class="tbl-top-heading">
                <h2>Transfer Student List</h2>
                 <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
            </div>      
        <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="80px"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="80px"></asp:TextBox>
             <asp:TextBox ID="txtadmission" runat="server" placeholder="Adimission No" Width="110px"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="110px"></asp:TextBox>
            <asp:TextBox ID="txtstuname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Student Name" Width="110px"></asp:TextBox>          
            <asp:TextBox ID="txtfathername" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Parent Name" Width="85px"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Parent Mobile No" Width="110px"></asp:TextBox>
             
            <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="31px">     
            </asp:DropDownList>    
            <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="31px">     
            </asp:DropDownList>       
            <asp:ImageButton ID="btnclear"  style="height:25px;width:25px;margin-top:2px" ImageUrl="../../images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
 </div>
        <div class="grid-data-resposive">
            <div class="divforstm">
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Admission Date</th>
                     <th align="center">Profile No</th>
                    <th align="center">Registration No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Class</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Parent Mob No</th>
                     <th align="center">More Detail</th> 
                                     
                </tr>
            </table>              
            </div>
            <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry Transfer Student list not found.</label>
        </div>
    </div>            
    </div>
         <div class="showpopupemployeedetails" style="display: none;z-index:9999999999999">
                    <div class="pop-headng-sty">
                        Student Admission Details Of ( <label  id="lbl_StudentName">N/A</label>)
         <a id="anchoremployeedetailsclose" title="Close this from here" class="btnClose">
             <img src="../../images/popupcross.png" alt="No Image" class="ImgCloseEmployyeDetails" /></a>
                    </div>
                    <div class="popup-responsive-div" style="z-index:9999999999999">
                        <table class="tblpopup" style="background-color: white; vertical-align: top; width: 98%; margin-top: 27px; margin-left: 10px;z-index:9999999999999">
                            
                            <tbody class="tbodypopup">
   
                                   <tr>
                                  <td> 
                                  <label id="Label5" style="width:100%;height:20px;color:red;">Student Detail:</label>
                             </td>   
                              </tr>

                                <tr>
                                <td class="t1" style="width: 120px;"><span>Admission Date:</span></td>
                                <td class="t2">
                                    <label id="lblAdmissionDate"></label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Profile No:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblAdmissionNo">--</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Registration Date:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblRegistrationDate">--</label>
                                </td>
                                  <td class="t1" style="width: 120px;"><span>Registration No:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblRegistrationNo">N/A+</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Refrence Profile No:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblRefrenceAdmissionNo">N/A</label>
                                </td>
                            </tr>
                                <tr>                              
                                <td class="t1" style="width: 120px;"><span>Student Name:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblStudentName">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Class Name:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblClassName">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Religion:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblReligion">N/A</label>
                                </td>  
                                 <td class="t1" style="width: 120px;"><span>Cast Category Name:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblCastCategoryName">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Student DOB:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblStudentDOB">N/A</label>
                                </td>
                            </tr>
                                <tr>
                                <td class="t1" style="width: 120px;"><span>Gender:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblGender">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Nationality:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblNationality">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Birth Place:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblBirthPlace">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>No Of Siblings:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblNoOfSiblings">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Transportation Required:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblTransportationRequired">N/A</label>
                                </td>  
                            </tr>
                                <tr>
                                
                                 <td class="t1" style="width: 120px;"><span>Document Submitted:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblDocumentSubmitted">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Additional Information:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblAdditionalInformation">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Country:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblCountry">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>State:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblState">N/A</label>
                                </td>  
                                    <td class="t1" style="width: 120px;"><span>City:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblCity">N/A</label>
                                </td>                         
                            </tr>
                                <tr>
                                

                                <td class="t1" style="width: 120px;"><span>Pin:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPin">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Address:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblAddress">N/A</label>
                                </td>

                               <td class="t1" style="width: 120px;"><span>Blood Group:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblBloodGroup">N/A</label>
                                </td>
                            </tr>
                                <tr>
                                  <td> 
                                  <label id="Label1" style="width:100%;height:20px;color:red;">Student School Detail:</label>
                             </td>   
                              </tr>
                                <tr>
                               <td class="t1" style="width: 120px;"><span>School Name:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolName">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>School Board:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolBoard">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>School Medium:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolMedium">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>School Previous ClassName:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolPreviousClassName">N/A</label>
                                </td>  
                                 <td class="t1" style="width: 120px;"><span>School Percentage InPreviousClass:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolPercentageInPreviousClass">N/A</label>
                                </td>
                            </tr>
                                <tr>
                                 <td class="t1" style="width: 120px;"><span>School Address:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolAddress">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>School ContactNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolContactNo">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>School Alternate ContactNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolAlternateContactNo">N/A</label>
                                </td> 

                                 <td class="t1" style="width: 120px;"><span>School Website:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSchoolWebsite">N/A</label>
                                </td>
                            </tr>
                               
                                 <tr>
                                  <td> 
                                  <label id="Label6" style="width:100%;height:20px;color:red;">Student Primary Parent Detail:</label>
                             </td>   
                              </tr>
                                <tr>
                                <td class="t1" style="width: 120px;"><span>Primary ParentType:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimarySelectParentType">--</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Primary ParentName:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryParentName">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Primary Parent Nationality:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryParentNationality">N/A</label>
                                </td>

                                    <td class="t1" style="width: 120px;"><span>Primary Highest Qualification:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryHighestQualification">N/A</label>
                                </td>
                                    <td class="t1" style="width: 120px;"><span>Primary Parent Occupation:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryParentOccupation">N/A</label>
                                </td>
                            </tr>
                                <tr>                             
                                 <td class="t1" style="width: 120px;"><span>Primary Designation:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryDesignation">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Primary Name Of Organization:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryNameOfOrganization">N/A</label>
                                </td> 
                                <td class="t1" style="width: 120px;"><span>Primary Address Of Office/Business:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryAddressOfOfficeBusiness">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Primary Parent Annual Income:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryParentAnnualIncome">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Primary Address:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryAddress">N/A</label>
                                </td>
                                </tr>
                                <tr>
                                <td class="t1" style="width: 120px;"><span>Primary City:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryCity">N/A</label>
                                </td> 
                                <td class="t1" style="width: 120px;"><span>Primary State:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryState">N/A</label>
                                </td> 
                                <td class="t1" style="width: 120px;"><span>Primary PinZipCode:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryPinZipCode">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Primary Country:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryCountry">N/A</label>
                                </td>
                                 <td class="t1" style="width: 120px;"><span>Primary PhoneNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryPhoneNo">N/A</label>
                                </td>  
                            </tr>
                                <tr>   
                                <td class="t1" style="width: 120px;"><span>Primary MobileNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryMobileNo">N/A</label>
                                </td> 
                                <td class="t1" style="width: 120px;"><span>Primary EmailId:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblPrimaryEmailId">N/A</label>
                                </td>
                            </tr>
                               
                                 <tr>
                                  <td> 
                                  <label id="Label2" style="width:100%;height:20px;color:red;">Student Secondary Parent Detail:</label>
                             </td>   
                              </tr>
                                <tr>
                                <td class="t1" style="width: 120px;"><span>SecondarySelectParentType:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondarySelectParentType">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Secondary ParentName:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryParentName">N/A</label>
                                </td>
 
                        
                              <td class="t1" style="width: 120px;"><span>Secondary Parent Nationality:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryParentNationality">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Secondary Highest Qualification:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryHighestQualification">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>SecondaryParent Occupation:</span></td>
                                <td class="t2" colspan="1"> 
                                    <label id="lblSecondaryParentOccupation">N/A</label>
                                </td>
                                     </tr>
                                <tr>
                                 <td class="t1" style="width: 120px;"><span>Secondary Designation:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryDesignation">N/A</label>
                                </td> 
                                     <td class="t1" style="width: 120px;"><span>Secondary Name Of Organization:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryNameOfOrganization">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>SecondaryAddress Of Office/Business:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryAddressOfOfficeBusiness">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>Secondary Parent AnnualIncome:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryParentAnnualIncome"></label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Secondary Address:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryAddress">N/A</label>
                                </td> 
                            </tr>
                                <tr>
                               <td class="t1" style="width: 120px;"><span>Secondary City:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryCity">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Secondary State:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryState">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Secondary PinZipCode:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryPinZipCode">N/A</label>
                                </td>

                                 <td class="t1" style="width: 120px;"><span>Secondary Country:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryCountry">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>SecondaryPhoneNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryPhoneNo">N/A</label>
                                </td>
 
                            </tr>
                                <tr>
                                 <td class="t1" style="width: 120px;"><span>Secondary MobileNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryMobileNo">N/A</label>
                                </td>
                                <td class="t1" style="width: 120px;"><span>SecondaryEmailId:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblSecondaryEmailId">N/A</label>
                                </td>
                                </tr>
                               
                                 <tr>
                                  <td> 
                                  <label id="Label3" style="width:100%;height:20px;color:red;">Student Emergency Parent Detail:</label>
                             </td>   
                              </tr>
                                <tr>
                                 <td class="t1" style="width: 120px;"><span>Emergency Name:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyName">N/A</label>
                                </td>  
                            
                               <td class="t1" style="width: 120px;"><span>Emergency MobileNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyMobileNo">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Emergency Alternate MobileNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyAlternateMobileNo">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Emergency PhoneNo:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyPhoneNo">N/A</label>
                                </td>
                                 
                                
                                <td class="t1" style="width: 120px;"><span>Emergency Address:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyAddress">N/A</label>
                                </td> 
                             </tr>
                                <tr>
                                <td class="t1" style="width: 120px;"><span>Emergency City:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyCity">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Emergency State:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyState">N/A</label>
                                </td>

                                <td class="t1" style="width: 120px;"><span>Emergency PinZipCode:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyPinZipCode">N/A</label>
                                </td>
                                
                                
                               <td class="t1" style="width: 120px;"><span>Emergency Country:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblEmergencyCountry">N/A</label>
                                </td> 
                            </tr>
                                </tbody>
                        </table>
                    </div>
                </div>
         </div>
     <script type="text/javascript">
         var Fromdate = '',SAMID=0, Todate = '',Admissionnnumber = '',Registrationnumber = '',StudentName = '',Applyingforclass = 0,Status = 0,Parentname = '',ParentMobileNo = '',studentid = 0,Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         $(document).ready(function () {
             Bindclassddl();
             Bindstudentpassout();
             var year = 2015;
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 dateFormat: 'dd MM yy',
                 yearRange: '1970:' + year
             });
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                 FillField();
                 Bindstudentpassout();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtadmission,#ctl00_ContentPlaceHolder1_txtstuname").keyup(function () {

                 FillField();
                 Bindstudentpassout();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlclass,#ctl00_ContentPlaceHolder1_ddlfyear").on('change keyup paste', function () {
                 FillField();
                 Bindstudentpassout();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                 ClearAll();
                 Bindstudentpassout();
                 return false;
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
             $('.showdiscount').live('click', function () {
                 SAMID = $(this).closest('tr').find('input[type=hidden]').val();
                 $('.showpopupemployeedetails').css("display", "block");
                 FillDetailsOfStudent();
             });
             $('.ImgCloseEmployyeDetails').click(function () {
                 $('.showpopupemployeedetails').css("display", "none");
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
         function FillDetailsOfStudent() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "transfered-student-list.aspx/FillDetailsOfStudent",
                 data: "{'SAMID':'" + SAMID + "'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d.length > 0) {
                         $('#lblAdmissionDate').html(data.d[0].AdmissionDate);
                         $('#lblAdmissionNo').html(data.d[0].AdmissionNo);
                         $('#lblRegistrationDate').html(data.d[0].RegistrationDate);
                         $('#lblRegistrationNo').html(data.d[0].Registration_No);
                         $('#lblRefrenceAdmissionNo').html(data.d[0].RefrenceAdmissionNo);
                         $('#lblStudentName,#lbl_StudentName').html(data.d[0].studentname);
                         $('#lblClassName').html(data.d[0].Classname);
                         $('#lblReligion').html(data.d[0].Religion);
                         $('#lblCastCategoryName').html(data.d[0].CastCategoryName);
                         $('#lblStudentDOB').html(data.d[0].StudentDOB);


                         $('#lblGender').html(data.d[0].Gender);
                         $('#lblNationality').html(data.d[0].Nationality);
                         $('#lblBirthPlace').html(data.d[0].BirthPlace);
                         $('#lblNoOfSiblings').html(data.d[0].NoOfSiblings);
                         $('#lblTransportationRequired').html(data.d[0].TransportationRequired);
                         //$('#lblBirthCertificate').html(data.d[0].BirthCertificate);
                         $('#lblDocumentSubmitted').html(data.d[0].DocumentSubmitted);
                         $('#lblAdditionalInformation').html(data.d[0].AdditionalInformation);
                         $('#lblCountry').html(data.d[0].Country);
                         $('#lblState').html(data.d[0].State);
                         $('#lblCity').html(data.d[0].City);
                         $('#lblPin').html(data.d[0].Pin);
                         $('#lblAddress').attr('href', data.d[0].Address);



                         $('#lblBloodGroup').html(data.d[0].BloodGroup);
                         $('#lblSchoolName').html(data.d[0].SchoolName);
                         $('#lblSchoolBoard').html(data.d[0].SchoolBoard);
                         $('#lblSchoolMedium').html(data.d[0].SchoolMedium);
                         $('#lblSchoolPreviousClassName').html(data.d[0].SchoolPreviousClassName);
                         $('#lblSchoolPercentageInPreviousClass').html(data.d[0].SchoolPercentageInPreviousClass);
                         $('#lblSchoolAddress').html(data.d[0].SchoolAddress);
                         $('#lblSchoolContactNo').html(data.d[0].SchoolContactNo);
                         $('#lblSchoolAlternateContactNo').html(data.d[0].SchoolAlternateContactNo);
                         $('#lblSchoolWebsite').html(data.d[0].SchoolWebsite);
                         $('#lblPrimarySelectParentType').html(data.d[0].PrimarySelectParentType);
                         $('#lblPrimaryParentName').html(data.d[0].PrimaryParentName);
                         $('#lblPrimaryParentNationality').html(data.d[0].PrimaryParentNationality);
                         $('#lblPrimaryHighestQualification').html(data.d[0].PrimaryHighestQualification);
                         $('#lblPrimaryParentOccupation').html(data.d[0].PrimaryParentOccupation);
                         $('#lblPrimaryDesignation').html(data.d[0].PrimaryDesignation);
                         $('#lblPrimaryNameOfOrganization').html(data.d[0].PrimaryNameOfOrganization);
                         $('#lblPrimaryAddressOfOfficeBusiness').html(data.d[0].PrimaryAddressOfOfficeBusiness);
                         $('#lblPrimaryParentAnnualIncome').html(data.d[0].PrimaryParentAnnualIncome);
                         $('#lblPrimaryAddress').html(data.d[0].PrimaryAddress);
                         $('#lblPrimaryCity').html(data.d[0].PrimaryCity);
                         $('#lblPrimaryState').attr('href', data.d[0].PrimaryState);


                         $('#lblPrimaryPinZipCode').html(data.d[0].PrimaryPinZipCode);
                         $('#lblPrimaryCountry').html(data.d[0].PrimaryCountry);
                         $('#lblPrimaryPhoneNo').html(data.d[0].PrimaryPhoneNo);
                         $('#lblPrimaryMobileNo').html(data.d[0].PrimaryMobileNo);
                         $('#lblPrimaryEmailId').html(data.d[0].PrimaryEmailId);
                         $('#lblSecondarySelectParentType').html(data.d[0].SecondarySelectParentType);
                         $('#lblSecondaryParentName').html(data.d[0].SecondaryParentName);
                         $('#lblSecondaryParentNationality').html(data.d[0].SecondaryParentNationality);
                         $('#lblSecondaryHighestQualification').html(data.d[0].SecondaryHighestQualification);
                         $('#lblSecondaryParentOccupation').html(data.d[0].SecondaryParentOccupation);
                         $('#lblSecondaryDesignation').html(data.d[0].SecondaryDesignation);
                         $('#lblSecondaryNameOfOrganization').html(data.d[0].SecondaryNameOfOrganization);
                         $('#lblSecondaryAddressOfOfficeBusiness').html(data.d[0].SecondaryAddressOfOfficeBusiness);
                         $('#lblSecondaryParentAnnualIncome').html(data.d[0].SecondaryParentAnnualIncome);
                         $('#lblSecondaryAddress').html(data.d[0].SecondaryAddress);
                         $('#lblSecondaryCity').html(data.d[0].SecondaryCity);
                         $('#lblSecondaryState').html(data.d[0].SecondaryState);
                         $('#lblSecondaryPinZipCode').html(data.d[0].SecondaryPinZipCode);
                         $('#lblSecondaryCountry').html(data.d[0].SecondaryCountry);
                         $('#lblSecondaryPhoneNo').html(data.d[0].SecondaryPhoneNo);
                         $('#lblSecondaryMobileNo').html(data.d[0].SecondaryMobileNo);
                         $('#lblSecondaryEmailId').attr('href', data.d[0].SecondaryEmailId);



                         $('#lblEmergencyName').html(data.d[0].EmergencyName);
                         $('#lblEmergencyMobileNo').html(data.d[0].EmergencyMobileNo);
                         $('#lblEmergencyAlternateMobileNo').html(data.d[0].EmergencyAlternateMobileNo);
                         $('#lblEmergencyPhoneNo').html(data.d[0].EmergencyPhoneNo);
                         $('#lblEmergencyAddress').html(data.d[0].EmergencyAddress);
                         $('#lblEmergencyCity').html(data.d[0].EmergencyCity);
                         $('#lblEmergencyState').html(data.d[0].EmergencyState);
                         $('#lblEmergencyPinZipCode').html(data.d[0].EmergencyPinZipCode);
                         $('#lblEmergencyCountry').html(data.d[0].EmergencyCountry);
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error("Error While Grid Is Binding");
                     call_progressbar("end");
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
         function ClearAll() {
             Fromdate = '', Admissionnnumber = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', ParentMobileNo = '';
             Applyingforclass = 0, Status = 0, Fyid = 0;
             $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtadmission,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber').val('');
             $('#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
             Bindclassddl();
         }
         function FillField() {
             Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
             Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
             Admissionnnumber = $('#ctl00_ContentPlaceHolder1_txtadmission').val();
             Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
             StudentName = $('#ctl00_ContentPlaceHolder1_txtstuname').val();
             Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
             Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
             ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
             Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         }
         function Bindstudentpassout() {
             $('.stm tr:gt(0)').remove();
             call_progressbar('start');
             var trforappend = '', trclass = '';
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "transfered-student-list.aspx/BindGridByJs",
                 data: "{'Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','StudentName':'" + StudentName + "','Parentname':'" + Parentname + "','ParentMobileNo':'" + ParentMobileNo + "','Status':'" + Status + "','Applyingforclass':'" + Applyingforclass + "','Fyid':'" + Fyid + "','Admissionnnumber':'" + Admissionnnumber + "'}",
                 dataType: "json",
                 success: function (data) {
                     $('.divnorecordfound').css('display', 'none');
                     if (data.d.length > 0) {
                         for (var i = 0; i < data.d.length; i++) {
                             trforappend = trforappend + "<tr class=" + trclass + ">" +
                             "<td><input type='hidden' value='" + data.d[i].SAMID + "' />" + (i + 1) + "</td>" +
                             "<td>" + data.d[i].AdmissionDate + " </td>" +
                             "<td>" + data.d[i].AdmissionNo + " </td>" +
                              "<td>" + data.d[i].Registration_No + " </td>" +
                             "<td>" + data.d[i].studentname + " </td>" +
                             "<td>" + data.d[i].Classname + " </td>" +
                             "<td>" + data.d[i].fathername + " </td>" +
                             "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
                             "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                             "</tr>"
                         }
                         $('.stm').append(trforappend);
                     }
                     else {
                         $('.divnorecordfound').css('display', 'inline');
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

