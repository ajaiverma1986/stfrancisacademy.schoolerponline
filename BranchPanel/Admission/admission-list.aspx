<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="admission-list.aspx.cs" Inherits="BranchPanel_Admission_student_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
         .showpopup2 {
             background: none repeat scroll 0 0 #FFFFFF;
             color: #000000;
             font-family: sans-serif;
             left: 50%;
             opacity: 1;
             position: fixed;
             top: 50%;
             width: 500px;
             z-index: 2147483647;
             height: 400px !important;
             margin-top: -200px;
             margin-left: -250px;
             border: 1px solid #ffb400;
             padding-bottom: 10px;
             overflow: auto;
         }

             .showpopup2 dd {
                 background: #ffb400;
                 padding: 2px 0px;
                 font-size: 16px;
                 width: 485px;
                 float: left;
                 color: #fff;
                 position: fixed;
             }

             .showpopup2 table {
                 margin-top: 44px;
                 display: block;
             }

             .showpopup2 dd img {
                 float: left;
                 margin-left: 10px;
             }

             .showpopup2 dd cite {
                 float: left;
                 line-height: 25px;
                 font-style: normal;
             }




         .tblpopup {
             width: 100%;
             display: block;
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
             width: 83% !important;
         }
     </style>
    <style>
        /* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
}

/* The Close Button */
.close {
  color: red;
  float: right;
  font-size: 35px;
  font-weight: bold;
  margin-top:-10px
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

    </style>
      <div class="clear"></div>
    <div class="branch-div-tbl">
    <div class="content_pane_cont input_content" id="contentPane">
          <div class="tbl-top-heading">
                <h2>Student Admission List</h2>
              <asp:LinkButton ID="AddPermission" runat="server" CssClass="button_save" Style="float: right; margin-top: 5px; margin-right: 3px">Admission Report Setting</asp:LinkButton> 
              <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="CustomExcel" runat="server" Text="Download Custom Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;" OnClick="CustomExcel_Click"
                ToolTip="Click here to download Custom Excel sheet" />  </div>
              <asp:LinkButton ID="AddExcelPermission" runat="server" CssClass="button_save" Style="float: right; margin-top: 5px; margin-right: 3px">Custom Excel Setting</asp:LinkButton> 
              <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button_save" PostBackUrl="~/BranchPanel/MasterUC/ViewStdsecBy.aspx" Style="float: right; margin-top: 5px; margin-right: 3px">Back</asp:LinkButton>            
                 <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;" OnClick="IBExcel_Click"
                ToolTip="Click here to download Excel sheet" />  </div>
            </div>      
        <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="80px"></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="80px"></asp:TextBox>
             <asp:TextBox ID="txtadmission" runat="server" placeholder="New/Old Adm No" Width="110px"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="110px"></asp:TextBox>
            <asp:TextBox ID="txtstuname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Student Name" Width="110px"></asp:TextBox>          
            <asp:TextBox ID="txtfathername" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Parent Name" Width="86px"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Parent Mobile No" Width="111px"></asp:TextBox>
            <asp:DropDownList ID="ddlclass" runat="server" Width="120px" Height="31px">     
            </asp:DropDownList>  
            <asp:DropDownList ID="ddlSection" runat="server" Width="105px" Height="31px">     
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
                     <th align="center">Admission No</th>
                    <th align="center">Registration No</th>
                    <th align="center">Old Adm. No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Class</th>
                    <th align="center">Section</th>
                    <th align="center">Parent Name</th>
                    <th align="center">Parent Mob No</th>
                    <th align="center">Student DOB</th>
                    <th align="center">Report</th>
                    <th align="center">Custom Report</th>
                     <th align="center">More Detail</th> 
                    <th align="center">Upload Doc</th>                  
                </tr>
            </table>              
            </div>
            <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry Student Admission list not found.</label>
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
                                <td class="t1" style="width: 120px;"><span>Admission No:</span></td>
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
                                <td class="t1" style="width: 120px;"><span>Refrence Admission No:</span></td>
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
                                    <td class="t1" style="width: 120px;"><span>Aadhaar Card:</span></td>
                                <td class="t2" colspan="1">
                                    <label id="lblUID">N/A</label>
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

                  <td>      <div style="margin-left: 0px; float: left; width: 500px;z-index:1;">
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
         var pagesize = 201, stuid = 0, SectionID = 0, SAMID = 0, pageno = 1, mode = 3, Fromdate = '', Todate = '', Admissionnnumber = '', Registrationnumber = '', StudentName = '', Applyingforclass = 0, Status = 0, Parentname = '', ParentMobileNo = '', studentid = 0, Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         function GetParameterValues(param) {
             var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
             for (var i = 0; i < url.length; i++) {
                 var urlparam = url[i].split('=');
                 if (urlparam[0] == param) {
                     return urlparam[1];
                 }
             }
         }
         $(document).ready(function () {

             $('#btnSubmit').click(function () {
                 var Registratio_No = false, studentname= false, Classname= false, fathername= false, MobileNo= false, StudentDOB= false, Gender= false, CountryName= false, Religion= false, Address= false, City= false, State= false, Pin= false, Country= false, Aadhar_Card= false, Birth_Certificate= false, Migration_Certificate= false, Caste_Certificate= false, LastYear_Marksheet= false;
                 if ($('#Registratio_No').is(':checked')) {
                     Registratio_No= true;
                 } 
                 if ($('#studentname').is(':checked')) {
                    studentname= true;
                 } 
                 if ($('#Classname').is(':checked')) {
                     Classname= true;
                 } 
                 if ($('#fathername').is(':checked')) {
                     fathername= true;
                 } 
                 if ($('#MobileNo').is(':checked')) {
                    MobileNo = true;
                 } 
                 if ($('#StudentDOB').is(':checked')) {
                     StudentDOB= true;
                 } 
                 if ($('#Gender').is(':checked')) {
                     Gender= true;
                 } 
                 if ($('#CountryName').is(':checked')) {
                     CountryName= true;
                 } 
                 if ($('#Religion').is(':checked')) {
                     Religion= true;
                 } 
                 if ($('#Address').is(':checked')) {
                     Address= true;
                 } 
                 if ($('#City').is(':checked')) {
                     City= true;
                 } 
                 if ($('#State').is(':checked')) {
                    State = true;
                 } 
                 if ($('#Pin').is(':checked')) {
                     Pin= true;
                 } 
                 if ($('#Country').is(':checked')) {
                     Country= true;
                 } 
                 if ($('#Aadhar_Card').is(':checked')) {
                     Aadhar_Card= true;
                 } 
                 if ($('#Birth_Certificate').is(':checked')) {
                    Birth_Certificate = true;
                 } 
                 if ($('#Migration_Certificate').is(':checked')) {
                    Migration_Certificate = true;
                 } 
                 if ($('#Caste_Certificate').is(':checked')) {
                    Caste_Certificate = true;
                 } 
                 if ($('#LastYear_Marksheet').is(':checked')) {
                    LastYear_Marksheet = true;
                 } 
                 var query = 'update AdmissionReportRights set Registratio_No=\'' + Registratio_No + '\',studentname=\'' + studentname + '\',Classname=\'' + Classname + '\',fathername=\'' + fathername + '\',MobileNo=\'' + MobileNo + '\',StudentDOB=\'' + StudentDOB + '\',Gender=\'' + Gender + '\',CountryName=\'' + CountryName + '\',Religion=\'' + Religion + '\',Address=\'' + Address + '\',City=\'' + City + '\',State=\'' + State + '\',Pin=\'' + Pin + '\',Country=\'' + Country + '\',Aadhar_Card=\'' + Aadhar_Card + '\',Birth_Certificate=\'' + Birth_Certificate + '\',Migration_Certificate=\'' + Migration_Certificate + '\',Caste_Certificate=\'' + Caste_Certificate + '\',LastYear_Marksheet=\'' + LastYear_Marksheet + '\'';

                 UpdatePermissionTable(query);
             });
             $('#btnExcelSubmit').click(function () {
                var RID = false, SAMID = false, IsHostel = false, HouseID = false, AdmissionDate = false, AdmissionNo = false, RegistrationDate = false, Registration_No = false;
                 var RefrenceAdmissionNo = false, studentname = false, Classname = false, Sectionname = false, StudentUID = false, RegNewNo = false, Religion = false;
                 var CastCategoryName = false, StudentDOB = false, Gender = false, Nationality = false, BirthPlace = false, NoOfSiblings = false, TransportationRequired = false;
                 var StudentPhotograph = false, BirthCertificate = false, DocumentSubmitted = false, AdditionalInformation = false, Country = false, State = false;
                 var City = false, Pin = false, Address = false, BloodGroup = false, SchoolName = false, SchoolBoard = false, choolMedium = false, SchoolPreviousClassName = false;
                 var SchoolPercentageInPreviousClass = false, SchoolAddress = false, SchoolContactNo = false, SchoolAlternateContactNo = false, SchoolWebsite = false;
                 var PrimarySelectParentType = false, PrimaryParentName = false, PrimaryParentNationality = false, PrimaryHighestQualification = false;
                 var PrimaryParentOccupation = false, PrimaryDesignation = false, PrimaryNameOfOrganization = false, PrimaryAddressOfOfficeBusiness = false;
                 var PrimaryParentAnnualIncome = false, PrimaryAddress = false, PrimaryCity = false, PrimaryState = false, PrimaryPinZipCode = false, PrimaryCountry = false;
                 var PrimaryPhoneNo = false, PrimaryMobileNo = false, PrimaryEmailId = false, SecondarySelectParentType = false, SecondaryParentName = false;
                 var SecondaryParentNationality = false, SecondaryHighestQualification = false, SecondaryParentOccupation = false, SecondaryDesignation = false, SecondaryNameOfOrganization = false;
                 var SecondaryAddressOfOfficeBusiness = false, SecondaryParentAnnualIncome = false, SecondaryAddress = false, SecondaryCity = false, SecondaryState = false;
                   var SecondaryPinZipCode = false, SecondaryCountry = false, SecondaryPhoneNo = false, SecondaryMobileNo = false, SecondaryEmailId = false, EmergencyName = false;
                 var EmergencyMobileNo = false, EmergencyAlternateMobileNo = false, EmergencyPhoneNo = false, EmergencyAddress = false, EmergencyCity = false;
                 var EmergencyState = false, EmergencyPinZipCode = false, EmergencyCountry = false, SchoolMedium = false;
               
                 if ($('#RID').is(':checked')) {
                     RID= true;
                 } 
                 if ($('#SAMID').is(':checked')) {
                    SAMID = true;
                 } 
                 if ($('#IsHostel').is(':checked')) {
                    IsHostel = true;
                 } 
                 if ($('#HouseID').is(':checked')) {
                    HouseID = true;
                 } 
                 if ($('#AdmissionDate').is(':checked')) {
                    AdmissionDate = true;
                 } 
                 if ($('#AdmissionNo').is(':checked')) {
                    AdmissionNo = true;
                 } 
                 if ($('#RegistrationDate').is(':checked')) {
                    RegistrationDate = true;
                 } 
                 if ($('#Registration_No').is(':checked')) {
                    Registration_No = true;
                 } 
                 if ($('#RefrenceAdmissionNo').is(':checked')) {
                    RefrenceAdmissionNo = true;
                 } 
                 if ($('#studentname1').is(':checked')) {
                    studentname = true;
                 } 
                 if ($('#Classname1').is(':checked')) {
                    Classname = true;
                 } 
                 if ($('#Sectionname').is(':checked')) {
                    Sectionname = true;
                 } 
                 if ($('#StudentUID').is(':checked')) {
                    StudentUID = true;
                 } 
                 if ($('#RegNewNo').is(':checked')) {
                    RegNewNo = true;
                 } 
                 if ($('#Religion1').is(':checked')) {
                    Religion = true;
                 } 
                 if ($('#CastCategoryName').is(':checked')) {
                    CastCategoryName = true;
                 } 
                 if ($('#StudentDOB1').is(':checked')) {
                    StudentDOB = true;
                 } 
                 if ($('#Gender1').is(':checked')) {
                    Gender = true;
                 } 
                 if ($('#Nationality').is(':checked')) {
                    Nationality = true;
                 } 
                 if ($('#BirthPlace').is(':checked')) {
                    BirthPlace = true;
                 } 
                 if ($('#NoOfSiblings').is(':checked')) {
                    NoOfSiblings = true;
                 } 
                 if ($('#TransportationRequired').is(':checked')) {
                    TransportationRequired = true;
                 } 
                 if ($('#StudentPhotograph').is(':checked')) {
                    StudentPhotograph = true;
                 } 
                 if ($('#BirthCertificate').is(':checked')) {
                    BirthCertificate = true;
                 } 
                 if ($('#DocumentSubmitted').is(':checked')) {
                    DocumentSubmitted = true;
                 } 
                 if ($('#AdditionalInformation').is(':checked')) {
                    AdditionalInformation = true;
                 } 
                 if ($('#Country1').is(':checked')) {
                    Country = true;
                 } 
                 if ($('#State1').is(':checked')) {
                    State = true;
                 } 
                 if ($('#City1').is(':checked')) {
                    City = true;
                 } 
                 if ($('#Pin1').is(':checked')) {
                    Pin = true;
                 } 
                 if ($('#Address1').is(':checked')) {
                    Address = true;
                 } 
                 if ($('#BloodGroup').is(':checked')) {
                    BloodGroup = true;
                 } 
                 if ($('#SchoolName').is(':checked')) {
                    SchoolName = true;
                 } 
                 if ($('#SchoolBoard').is(':checked')) {
                    SchoolBoard = true;
                 } 
                 if ($('#SchoolMedium').is(':checked')) {
                    SchoolMedium = true;
                 } 
                 if ($('#SchoolPreviousClassName').is(':checked')) {
                    SchoolPreviousClassName = true;
                 } 
                 if ($('#SchoolPercentageInPreviousClass').is(':checked')) {
                    SchoolPercentageInPreviousClass = true;
                 } 
                 if ($('#SchoolAddress').is(':checked')) {
                    SchoolAddress = true;
                 } 
                 if ($('#SchoolContactNo').is(':checked')) {
                    SchoolContactNo = true;
                 } 
                 if ($('#SchoolAlternateContactNo').is(':checked')) {
                    SchoolAlternateContactNo = true;
                 } 
                 if ($('#SchoolWebsite').is(':checked')) {
                    SchoolWebsite = true;
                 } 
                 if ($('#PrimarySelectParentType').is(':checked')) {
                   PrimarySelectParentType  = true;
                 } 
                 if ($('#PrimaryParentName').is(':checked')) {
                    PrimaryParentName = true;
                 } 
                 if ($('#PrimaryParentNationality').is(':checked')) {
                    PrimaryParentNationality = true;
                 } 
                 if ($('#PrimaryHighestQualification').is(':checked')) {
                    PrimaryHighestQualification = true;
                 } 
                 if ($('#PrimaryParentOccupation').is(':checked')) {
                    PrimaryParentOccupation = true;
                 } 
                 if ($('#PrimaryDesignation').is(':checked')) {
                    PrimaryDesignation = true;
                 } 
                 if ($('#PrimaryNameOfOrganization').is(':checked')) {
                    PrimaryNameOfOrganization = true;
                 } 
                 if ($('#PrimaryAddressOfOfficeBusiness').is(':checked')) {
                    PrimaryAddressOfOfficeBusiness = true;
                 } 
                 if ($('#PrimaryParentAnnualIncome').is(':checked')) {
                    PrimaryParentAnnualIncome = true;
                 } 
                 if ($('#PrimaryAddress').is(':checked')) {
                    PrimaryAddress = true;
                 } 
                 if ($('#PrimaryCity').is(':checked')) {
                    PrimaryCity = true;
                 } 
                 if ($('#PrimaryState').is(':checked')) {
                    PrimaryState = true;
                 } 
                 if ($('#PrimaryPinZipCode').is(':checked')) {
                    PrimaryPinZipCode = true;
                 } 
                 if ($('#PrimaryCountry').is(':checked')) {
                    PrimaryCountry = true;
                 } 
                 if ($('#PrimaryPhoneNo').is(':checked')) {
                    PrimaryPhoneNo = true;
                 } 
                 if ($('#PrimaryMobileNo').is(':checked')) {
                    PrimaryMobileNo = true;
                 } 
                 if ($('#PrimaryEmailId').is(':checked')) {
                    PrimaryEmailId = true;
                 } 
                 if ($('#SecondarySelectParentType').is(':checked')) {
                    SecondarySelectParentType = true;
                 } 
                 if ($('#SecondaryParentName').is(':checked')) {
                    SecondaryParentName = true;
                 } 
                 if ($('#SecondaryParentNationality').is(':checked')) {
                    SecondaryParentNationality = true;
                 } 
                 if ($('#SecondaryHighestQualification').is(':checked')) {
                    SecondaryHighestQualification = true;
                 } 
                 if ($('#SecondaryParentOccupation').is(':checked')) {
                    SecondaryParentOccupation = true;
                 } 
                 if ($('#SecondaryDesignation').is(':checked')) {
                     SecondaryDesignation= true;
                 } 
                 if ($('#SecondaryNameOfOrganization').is(':checked')) {
                    SecondaryNameOfOrganization = true;
                 } 
                 if ($('#SecondaryAddressOfOfficeBusiness').is(':checked')) {
                    SecondaryAddressOfOfficeBusiness = true;
                 } 
                 if ($('#SecondaryParentAnnualIncome').is(':checked')) {
                    SecondaryParentAnnualIncome = true;
                 } 
                 if ($('#SecondaryAddress').is(':checked')) {
                    SecondaryAddress = true;
                 } 
                 if ($('#SecondaryState').is(':checked')) {
                    SecondaryState = true;
                 } 
                 if ($('#SecondaryPinZipCode').is(':checked')) {
                    SecondaryPinZipCode = true;
                 } 
                 if ($('#SecondaryCountry').is(':checked')) {
                    SecondaryCountry = true;
                 } 
                 if ($('#SecondaryPhoneNo').is(':checked')) {
                    SecondaryPhoneNo = true;
                 } 
                 if ($('#SecondaryMobileNo').is(':checked')) {
                    SecondaryMobileNo = true;
                 } 
                 if ($('#SecondaryEmailId').is(':checked')) {
                     SecondaryEmailId= true;
                 } 
                 if ($('#EmergencyName').is(':checked')) {
                    EmergencyName = true;
                 } 
                 if ($('#EmergencyMobileNo').is(':checked')) {
                    EmergencyMobileNo = true;
                 } 
                 if ($('#EmergencyAlternateMobileNo').is(':checked')) {
                    EmergencyAlternateMobileNo = true;
                 } 
                 if ($('#EmergencyPhoneNo').is(':checked')) {
                    EmergencyPhoneNo = true;
                 } 
                 if ($('#EmergencyAddress').is(':checked')) {
                    EmergencyAddress = true;
                 } 
                 if ($('#EmergencyCity').is(':checked')) {
                    EmergencyCity = true;
                 } 
                 if ($('#EmergencyState').is(':checked')) {
                    EmergencyState = true;
                 } 
                 if ($('#EmergencyPinZipCode').is(':checked')) {
                    EmergencyPinZipCode = true;
                 } 
                 if ($('#EmergencyCountry').is(':checked')) {
                    EmergencyCountry = true;
                 } 
                 if ($('#SecondaryCity').is(':checked')) {
                    SecondaryCity = true;
                 } 
                 
                 var query = 'update AdmissionCustomExcel set RID=\'' + RID + '\',SAMID=\'' + SAMID + '\',IsHostel=\'' + IsHostel + '\',HouseID=\'' + HouseID + '\',AdmissionDate=\'' + AdmissionDate + '\',AdmissionNo=\'' + AdmissionNo + '\',RegistrationDate=\'' + RegistrationDate + '\',Registration_No=\'' + Registration_No + '\',RefrenceAdmissionNo=\'' + RefrenceAdmissionNo + '\',studentname=\'' + studentname + '\',Classname=\'' + Classname + '\',Sectionname =\'' + Sectionname + '\',StudentUID=\'' + StudentUID + '\',RegNewNo=\'' + RegNewNo + '\',Religion=\'' + Religion + '\',CastCategoryName=\'' + CastCategoryName + '\',StudentDOB =\'' + StudentDOB + '\',Gender =\'' + Gender + '\',Nationality=\'' + Nationality + '\',BirthPlace=\'' + BirthPlace + '\',NoOfSiblings=\'' + NoOfSiblings + '\',TransportationRequired =\'' + TransportationRequired + '\',StudentPhotograph=\'' + StudentPhotograph + '\',BirthCertificate=\'' + BirthCertificate + '\',DocumentSubmitted=\'' + DocumentSubmitted + '\',AdditionalInformation=\'' + AdditionalInformation + '\',Country=\'' + Country + '\',State=\'' + State + '\',City=\'' + City + '\',Pin =\'' + Pin + '\',Address =\'' + Address + '\',BloodGroup =\'' + BloodGroup + '\',SchoolName=\'' + SchoolName + '\',SchoolBoard=\'' + SchoolBoard + '\',SchoolMedium=\'' + SchoolMedium + '\',SchoolPreviousClassName=\'' + SchoolPreviousClassName + '\',SchoolPercentageInPreviousClass=\'' + SchoolPercentageInPreviousClass + '\',SchoolAddress=\'' + SchoolAddress + '\',SchoolContactNo=\'' + SchoolContactNo + '\',SchoolAlternateContactNo=\'' + SchoolAlternateContactNo + '\',SchoolWebsite=\'' + SchoolWebsite + '\',PrimarySelectParentType =\'' + PrimarySelectParentType + '\',PrimaryParentName=\'' + PrimaryParentName + '\',PrimaryParentNationality=\'' + PrimaryParentNationality + '\',PrimaryHighestQualification=\'' + PrimaryHighestQualification + '\',PrimaryParentOccupation=\'' + PrimaryParentOccupation + '\',PrimaryDesignation=\'' + PrimaryDesignation + '\',PrimaryNameOfOrganization=\'' + PrimaryNameOfOrganization + '\',PrimaryAddressOfOfficeBusiness=\'' + PrimaryAddressOfOfficeBusiness + '\',PrimaryParentAnnualIncome=\'' + PrimaryParentAnnualIncome + '\',PrimaryAddress=\'' + PrimaryAddress + '\',PrimaryCity =\'' + PrimaryCity + '\',PrimaryState=\'' + PrimaryState + '\',PrimaryPinZipCode=\'' + PrimaryPinZipCode + '\',PrimaryCountry=\'' + PrimaryCountry + '\',PrimaryPhoneNo=\'' + PrimaryPhoneNo + '\',PrimaryMobileNo=\'' + PrimaryMobileNo + '\',PrimaryEmailId=\'' + PrimaryEmailId + '\',SecondarySelectParentType=\'' + SecondarySelectParentType + '\',SecondaryParentName=\'' + SecondaryParentName + '\',SecondaryParentNationality=\'' + SecondaryParentNationality + '\',SecondaryHighestQualification =\'' + SecondaryHighestQualification + '\',SecondaryParentOccupation=\'' + SecondaryParentOccupation + '\',SecondaryDesignation=\'' + SecondaryDesignation + '\',SecondaryNameOfOrganization=\'' + SecondaryNameOfOrganization + '\',SecondaryAddressOfOfficeBusiness=\'' + SecondaryAddressOfOfficeBusiness + '\',SecondaryParentAnnualIncome=\'' + SecondaryParentAnnualIncome + '\',SecondaryAddress=\'' + SecondaryAddress + '\',SecondaryCity=\'' + SecondaryCity + '\',SecondaryState=\'' + SecondaryState + '\',SecondaryPinZipCode=\'' + SecondaryPinZipCode + '\',SecondaryCountry =\'' + SecondaryCountry + '\',SecondaryPhoneNo=\'' + SecondaryPhoneNo + '\',SecondaryMobileNo=\'' + SecondaryMobileNo + '\',SecondaryEmailId=\'' + SecondaryEmailId + '\',EmergencyName=\'' + EmergencyName + '\',EmergencyMobileNo=\'' + EmergencyMobileNo + '\',EmergencyAlternateMobileNo=\'' + EmergencyAlternateMobileNo + '\',EmergencyPhoneNo=\'' + EmergencyPhoneNo + '\',EmergencyAddress=\'' + EmergencyAddress + '\',EmergencyCity=\'' + EmergencyCity + '\',EmergencyState=\'' + EmergencyState + '\',EmergencyPinZipCode=\'' + EmergencyPinZipCode + '\',EmergencyCountry=\'' + EmergencyCountry + '\'';
                
                UpdatePermissionTable(query);
             });

             function UpdatePermissionTable(query) {                 
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "admission-list.aspx/UpdatePermission",
                     data: JSON.stringify({ 'query_': query }),
                     dataType: "json",
                     success: function (data) {
                       //  alert(data);
                         call_progressbar("end");
                     },
                     error: function (result) {
                         alertify.error("Error While Grid Is Binding");
                         call_progressbar("end");
                     }
                 });
             }

             function BindPermission() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "admission-list.aspx/BindPermission",
                 data: "",
                 dataType: "json",
                 success: function (data) {
                     if (data.d.length > 0) {                         
                         $('#Registratio_No:not(:checked)').attr('checked', data.d[0].Registratio_No);
                         $('#studentname:not(:checked)').attr('checked', data.d[0].studentname);
                         $('#Classname:not(:checked)').attr('checked', data.d[0].Classname);
                         $('#fathername:not(:checked)').attr('checked', data.d[0].fathername);
                         $('#MobileNo:not(:checked)').attr('checked', data.d[0].MobileNo);
                         $('#StudentDOB:not(:checked)').attr('checked', data.d[0].StudentDOB);
                         $('#Gender:not(:checked)').attr('checked', data.d[0].Gender);
                         $('#CountryName:not(:checked)').attr('checked', data.d[0].CountryName);
                         $('#Religion:not(:checked)').attr('checked', data.d[0].Religion);
                         $('#Address:not(:checked)').attr('checked', data.d[0].Address);
                         $('#City:not(:checked)').attr('checked', data.d[0].City);
                         $('#State:not(:checked)').attr('checked', data.d[0].State);
                         $('#Pin:not(:checked)').attr('checked', data.d[0].Pin);
                         $('#Country:not(:checked)').attr('checked', data.d[0].Country);
                         $('#Aadhar_Card:not(:checked)').attr('checked', data.d[0].Aadhar_Card);
                         $('#Birth_Certificate:not(:checked)').attr('checked', data.d[0].Birth_Certificate);
                         $('#Migration_Certificate:not(:checked)').attr('checked', data.d[0].Migration_Certificate);
                         $('#Caste_Certificate:not(:checked)').attr('checked', data.d[0].Caste_Certificate);
                         $('#LastYear_Marksheet:not(:checked)').attr('checked', data.d[0].LastYear_Marksheet);                        
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error("Error While Grid Is Binding");
                     call_progressbar("end");
                 }
             });
             }

             function BindExcelPermission() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "admission-list.aspx/BindExcelPermission",
                 data: "",
                 dataType: "json",
                 success: function (data) {
                     if (data.d.length > 0) {  

                         $('#Classname1:not(:checked)').attr('checked', data.d[0].Classname);
                         $('#studentname1:not(:checked)').attr('checked', data.d[0].studentname);
                         $('#Religion1:not(:checked)').attr('checked', data.d[0].Religion);
                         $('#StudentDOB1:not(:checked)').attr('checked', data.d[0].StudentDOB);
                         $('#Gender1:not(:checked)').attr('checked', data.d[0].Gender);
                         $('#Country1:not(:checked)').attr('checked', data.d[0].Country);
                         $('#State1:not(:checked)').attr('checked', data.d[0].State);
                         $('#City1:not(:checked)').attr('checked', data.d[0].City);
                         $('#Pin1:not(:checked)').attr('checked', data.d[0].Pin);
                         $('#Address1:not(:checked)').attr('checked', data.d[0].Address);

                         $('#RID:not(:checked)').attr('checked', data.d[0].RID);
                         $('#SAMID:not(:checked)').attr('checked', data.d[0].SAMID);
                         $('#IsHostel:not(:checked)').attr('checked', data.d[0].IsHostel);
                         $('#HouseID:not(:checked)').attr('checked', data.d[0].HouseID);
                         $('#AdmissionDate:not(:checked)').attr('checked', data.d[0].AdmissionDate);
                         $('#AdmissionNo:not(:checked)').attr('checked', data.d[0].AdmissionNo);
                         $('#RegistrationDate:not(:checked)').attr('checked', data.d[0].RegistrationDate);
                         $('#Registration_No:not(:checked)').attr('checked', data.d[0].Registration_No);
                         $('#RefrenceAdmissionNo:not(:checked)').attr('checked', data.d[0].RefrenceAdmissionNo);
                         $('#Sectionname:not(:checked)').attr('checked', data.d[0].Sectionname);
                         $('#StudentUID:not(:checked)').attr('checked', data.d[0].StudentUID);
                         $('#RegNewNo:not(:checked)').attr('checked', data.d[0].RegNewNo);
                         $('#CastCategoryName:not(:checked)').attr('checked', data.d[0].CastCategoryName);
                         $('#Nationality:not(:checked)').attr('checked', data.d[0].Nationality);
                         $('#BirthPlace:not(:checked)').attr('checked', data.d[0].BirthPlace);
                         $('#NoOfSiblings:not(:checked)').attr('checked', data.d[0].NoOfSiblings);
                         $('#TransportationRequired:not(:checked)').attr('checked', data.d[0].TransportationRequired);
                         $('#StudentPhotograph:not(:checked)').attr('checked', data.d[0].StudentPhotograph);
                         $('#BirthCertificate:not(:checked)').attr('checked', data.d[0].BirthCertificate);
                         $('#DocumentSubmitted:not(:checked)').attr('checked', data.d[0].DocumentSubmitted);
                         $('#AdditionalInformation:not(:checked)').attr('checked', data.d[0].AdditionalInformation);
                         $('#BloodGroup:not(:checked)').attr('checked', data.d[0].BloodGroup);
                         $('#SchoolName:not(:checked)').attr('checked', data.d[0].SchoolName);
                         $('#SchoolBoard:not(:checked)').attr('checked', data.d[0].SchoolBoard);
                         $('#SchoolMedium:not(:checked)').attr('checked', data.d[0].SchoolMedium);
                         $('#SchoolPreviousClassName:not(:checked)').attr('checked', data.d[0].SchoolPreviousClassName);
                         $('#SchoolPercentageInPreviousClass:not(:checked)').attr('checked', data.d[0].SchoolPercentageInPreviousClass);
                         $('#SchoolAddress:not(:checked)').attr('checked', data.d[0].SchoolAddress);
                         $('#SchoolContactNo:not(:checked)').attr('checked', data.d[0].SchoolContactNo);
                         $('#SchoolAlternateContactNo:not(:checked)').attr('checked', data.d[0].SchoolAlternateContactNo);
                         $('#SchoolWebsite:not(:checked)').attr('checked', data.d[0].SchoolWebsite);
                         $('#PrimarySelectParentType:not(:checked)').attr('checked', data.d[0].PrimarySelectParentType);
                         $('#PrimaryParentName:not(:checked)').attr('checked', data.d[0].PrimaryParentName);
                         $('#PrimaryParentNationality:not(:checked)').attr('checked', data.d[0].PrimaryParentNationality);
                         $('#PrimaryHighestQualification:not(:checked)').attr('checked', data.d[0].PrimaryHighestQualification);
                         $('#PrimaryParentOccupation:not(:checked)').attr('checked', data.d[0].PrimaryParentOccupation);
                         $('#PrimaryDesignation:not(:checked)').attr('checked', data.d[0].PrimaryDesignation);
                         $('#PrimaryNameOfOrganization:not(:checked)').attr('checked', data.d[0].PrimaryNameOfOrganization);
                         $('#PrimaryAddressOfOfficeBusiness:not(:checked)').attr('checked', data.d[0].PrimaryAddressOfOfficeBusiness);
                         $('#PrimaryParentAnnualIncome:not(:checked)').attr('checked', data.d[0].PrimaryParentAnnualIncome);
                         $('#PrimaryAddress:not(:checked)').attr('checked', data.d[0].PrimaryAddress);
                         $('#PrimaryCity:not(:checked)').attr('checked', data.d[0].PrimaryCity);
                         $('#PrimaryState:not(:checked)').attr('checked', data.d[0].PrimaryState);
                         $('#PrimaryPinZipCode:not(:checked)').attr('checked', data.d[0].PrimaryPinZipCode);
                         $('#PrimaryCountry:not(:checked)').attr('checked', data.d[0].PrimaryCountry);
                         $('#PrimaryPhoneNo:not(:checked)').attr('checked', data.d[0].PrimaryPhoneNo);
                         $('#PrimaryMobileNo:not(:checked)').attr('checked', data.d[0].PrimaryMobileNo);
                         $('#PrimaryEmailId:not(:checked)').attr('checked', data.d[0].PrimaryEmailId);
                         $('#SecondarySelectParentType:not(:checked)').attr('checked', data.d[0].SecondarySelectParentType);
                         $('#SecondaryParentName:not(:checked)').attr('checked',data.d[0].SecondaryParentName);
                         $('#SecondaryParentNationality:not(:checked)').attr('checked', data.d[0].SecondaryParentNationality);
                         $('#SecondaryHighestQualification:not(:checked)').attr('checked', data.d[0].SecondaryHighestQualification);
                         $('#SecondaryParentOccupation:not(:checked)').attr('checked', data.d[0].SecondaryParentOccupation);
                         $('#SecondaryDesignation:not(:checked)').attr('checked', data.d[0].SecondaryDesignation);
                         $('#SecondaryNameOfOrganization:not(:checked)').attr('checked', data.d[0].SecondaryNameOfOrganization);
                         $('#SecondaryAddressOfOfficeBusiness:not(:checked)').attr('checked', data.d[0].SecondaryAddressOfOfficeBusiness);
                         $('#SecondaryParentAnnualIncome:not(:checked)').attr('checked', data.d[0].SecondaryParentAnnualIncome);
                         $('#SecondaryAddress:not(:checked)').attr('checked', data.d[0].SecondaryAddress);
                         $('#SecondaryCity:not(:checked)').attr('checked', data.d[0].SecondaryCity);
                         $('#SecondaryState:not(:checked)').attr('checked', data.d[0].SecondaryState);
                         $('#SecondaryPinZipCode:not(:checked)').attr('checked', data.d[0].SecondaryPinZipCode);
                         $('#SecondaryCountry:not(:checked)').attr('checked', data.d[0].SecondaryCountry);
                         $('#SecondaryPhoneNo:not(:checked)').attr('checked', data.d[0].SecondaryPhoneNo);
                         $('#SecondaryMobileNo:not(:checked)').attr('checked', data.d[0].SecondaryMobileNo);
                         $('#SecondaryEmailId:not(:checked)').attr('checked', data.d[0].SecondaryEmailId);
                         $('#EmergencyName:not(:checked)').attr('checked', data.d[0].EmergencyName);
                         $('#EmergencyMobileNo:not(:checked)').attr('checked', data.d[0].EmergencyMobileNo);
                         $('#EmergencyAlternateMobileNo:not(:checked)').attr('checked', data.d[0].EmergencyAlternateMobileNo);
                         $('#EmergencyPhoneNo:not(:checked)').attr('checked', data.d[0].EmergencyPhoneNo);
                         $('#EmergencyAddress:not(:checked)').attr('checked', data.d[0].EmergencyAddress);
                         $('#EmergencyCity:not(:checked)').attr('checked', data.d[0].EmergencyCity);
                         $('#EmergencyState:not(:checked)').attr('checked', data.d[0].EmergencyState);
                         $('#EmergencyPinZipCode:not(:checked)').attr('checked', data.d[0].EmergencyPinZipCode);
                         $('#EmergencyCountry:not(:checked)').attr('checked', data.d[0].EmergencyCountry);                 

                                              
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error("Error While Grid Is Binding");
                     call_progressbar("end");
                 }
             });
         }
             
             $('#ctl00_ContentPlaceHolder1_AddPermission').click(function () {
                 var userrightstatus = confirm('Are You sure you want to Assigne/Remove the admission report rights.');
                 if (userrightstatus == true) {
                     $(".AdmissionReportRights").show(500);
                     $(".AdmissionReportRights").fadeIn();
                     BindPermission();
                     return false;
                 }
                 else {
                     return false;
                 }
                 return false;
             });

             $('#ctl00_ContentPlaceHolder1_AddExcelPermission').click(function () {
                 var userrightstatus = confirm('Are You sure you want to Assigne/Remove the admission excel rights.');
                 if (userrightstatus == true) {
                     $(".AdmissionExcelRights").show(500);
                     $(".AdmissionExcelRights").fadeIn();
                     BindExcelPermission();
                     return false;
                 }
                 else {
                     return false;
                 }
                 return false;
             });

             $('.Btclose1').live('click', function () {
                  $(".AdmissionExcelRights").hide(500);
                  $(".AdmissionExcelRights").fadeOut();
             });

             $('.Btclose').live('click', function () {
                  $(".AdmissionReportRights").hide(500);
                  $(".AdmissionReportRights").fadeOut();
             });

             $('.admissionreportrightsclass').live('click', function () {
                 var registrationNo = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type="hidden"]').val();
                 var win = window.open("../Admission/AdmissionCustomReport.aspx?REG=" + registrationNo, '_blank');
                 win.focus();
                 return false;
             });

             //Applyingforclass = GetParameterValues('ClassID'); 
             //SectionID = GetParameterValues('SectionID');
             //if (Applyingforclass == null)
             //{
             //    Applyingforclass = 0;
             //}
             //if (SectionID == null) {
             //    SectionID = 0;
             //}

             $('.ImgGenerateRecipt').live('click', function () {
                 var registrationNo = $(this).parent('td').parent('tr').find('td:eq(2)').find('input[type="hidden"]').val();
                 var win = window.open("../Fee Management/Admission_History.aspx?REG=" + registrationNo, '_blank');
                 win.focus();
                 return false;
             });

             Bindclassddl();
             Bindstudentregistration();
             var year = 2023;
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
             $("#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtadmission,#ctl00_ContentPlaceHolder1_txtstuname").keyup(function () {
                 FillField();
                 Bindstudentregistration();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlfyear").on('change keyup paste', function () {
                 FillField();
                 Bindstudentregistration();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
                 FillField();
                 Bindstudentregistration();
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                     data: "{'ClassID':'" + ClassID + "'}",
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
                 Bindstudentregistration();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                 ClearAll();
                 Bindstudentregistration();
                 return false;
             });
             //$(".BtnExcel").click(function (e) {
             //    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
             //        if (e) {
             //            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
             //            e.preventDefault();
             //        }
             //    });
             //    return false;
             //});
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
             Admissionnnumber = $('#ctl00_ContentPlaceHolder1_txtadmission').val();
             Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
             StudentName = $('#ctl00_ContentPlaceHolder1_txtstuname').val();
             Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
             ClassID = Applyingforclass;
             if (ClassID > 0) {
                 if ($('#ctl00_ContentPlaceHolder1_ddlSection').val() != null) {
                     SectionID = $('#ctl00_ContentPlaceHolder1_ddlSection').val();
                 }
                 else {
                     SectionID = 0;
                 }
             }
             Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
             ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
             Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
         }
         function ClearAll() {
             Fromdate = '', Admissionnnumber = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', ParentMobileNo = '';
             Applyingforclass = 0, Status = 0, Fyid = 1;
             $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtadmission,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber').val('');
             $('#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
             Bindclassddl();
         }
         function Bindstudentregistration() {
             $('.stm tr:gt(0)').remove();
             call_progressbar('start');
             var trforappend = '', trclass = '';
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../Student-Registration/student-registration-list.aspx/BindGridByJs",
                 data: "{'SectionID':'" + SectionID + "','Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','StudentName':'" + StudentName + "','Parentname':'" + Parentname + "','ParentMobileNo':'" + ParentMobileNo + "','Status':'" + Status + "','Applyingforclass':'" + Applyingforclass + "','Fyid':'" + Fyid + "','mode':'" + mode + "','Admissionnnumber':'" + Admissionnnumber + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
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
                                 "<td><input type='hidden' value='" + data.d[i].SAMID + "' />" + (i + 1) + "</td>" +
                                 "<td>" + data.d[i].AdmissionDate + " </td>" +
                                 "<td><input type='hidden' value='" + data.d[i].Registration_No + "' />" + data.d[i].AdmissionNo + " </td>" +
                                 "<td>" + data.d[i].Registration_No + " </td>" +
                                 "<td>" + data.d[i].RefAdmNo + " </td>" +
                                 "<td>" + data.d[i].studentname + " </td>" +
                                 "<td>" + data.d[i].Classname + " </td>" +
                                 "<td>" + data.d[i].Sectionname + " </td>" +
                                 "<td>" + data.d[i].fathername + " </td>" +
                                 "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
                                 "<td>" + data.d[i].DOB + " </td>" +
                                 '<td><input class="ImgGenerateRecipt" type="image" style="width:20px;border-width:0px;" src="../../images/recipt.png" title="View Admission Report." /></td>' +
                                 '<td><input class="admissionreportrightsclass" type="image" style="width:20px;border-width:0px;" src="../../images/recipt.png" title="View Admission custom Report." /></td>' +
                                 "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                                 "<td><i class='fa fa-upload' onclick='ShowUploadModal(\"" + data.d[i].Registration_No + "\")' style='cursor:pointer;font-size:20px;'></i> </td>" +
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
         function FillDetailsOfStudent() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "admission-list.aspx/FillDetailsOfStudent",
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
                         $('#lblUID').html(data.d[0].StudentUID);
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
         function ShowUploadModal(regnum)
         {
             $("#modalReg").text(regnum);
             $('#fileupload').val('');
             $("#docModal").show();
         }
         function validate(file) {
             var ext = file.split(".");
             ext = ext[ext.length - 1].toLowerCase();
             var arrayExtensions = ["jpg", "png", "pdf"];

             if (arrayExtensions.lastIndexOf(ext) == -1) {
                 alert("Wrong file type. only jpg,png,pdf allowed.");
                 $("#fileupload").val("");
             }
         }
         function SaveDoc()
         {
             if ($('#fileupload').val() == "")
             {
                 alert("choose file (jpg,png,pdf format).")
             }
             var formdata = new FormData();
             formdata.append('fileupload', $('#fileupload').get(0).files[0], $('#fileupload').get(0).files[0].name);
             formdata.append('regnum', $("#modalReg").text());
             $.ajax({
                 url: 'ExamUpload.ashx',
                 type: 'POST',
                 data: formdata,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success: function (file) {                     
                     //  $("#lblModalMessage").html("<b>file has been uploaded.</b> ");
                     alert("file has been uploaded.");
                     $('#fileupload').val("");
                 }                
             });
         }
            </script>

     <div class="AdmissionReportRights showpopup2" style="display: none">       
        <dd> 
            <img src="../../images/userrights.png" style="float:left;" /> <cite> Admission Report Right </cite> 
            <img src="../../images/popupcross.png" class="Btclose" style="float:right; margin-right:10px; margin-top:2px; cursor:pointer;" /> 
        </dd>
         <table id="grdpermission" cellspacing="0" style="border-collapse:collapse;margin-left: 10%;">
             <tbody>
                 <tr>
                     <td>
                         <input id="Registratio_No" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Registration No</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="studentname" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Student Name</span>
                         </span>  
                                              
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Classname" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Class Name</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="fathername" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Father Name</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="MobileNo" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Mobile No</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="StudentDOB" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Student DOB</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Gender" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Gender</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="CountryName" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Country Name</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Religion" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Religion</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="Address" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Address</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="City" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">City</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="State" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">State</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Pin" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Pin</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="Country" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Country</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Aadhar_Card" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Aadhar Card</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="Birth_Certificate" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Birth Certificate</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="Migration_Certificate" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Migration Certificate</span>
                         </span>                        
                     </td>
                     <td>
                         <input id="Caste_Certificate" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">Caste Certificate</span>
                         </span>                        
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <input id="LastYear_Marksheet" type="checkbox" />
                         <span class="ModuleName">
                             <span class="for_cheackbox">LastYear Marksheet</span>
                         </span>                        
                     </td>
                     <td>
                        &nbsp;                      
                     </td>
                 </tr>
                 </tbody>
         </table>
         <div class="clear" style="margin-top:20px;"></div>
         <input type="submit" name="btnSubmit" value="Submit" id="btnSubmit" class="button_save" style="margin-left:100px !important;" />
         <%--<input type="submit" name="ctl00$ContentPlaceHolder1$ImageButtonCancel" value="Cancel" id="ctl00_ContentPlaceHolder1_ImageButtonCancel" class="button2 Btclose" style="margin-left:10px !important;" />--%>
    </div>
    <div class="AdmissionExcelRights showpopup2" style="display: none">       
        <dd> 
            <img src="../../images/userrights.png" style="float:left;" /> <cite> Admission Excel Right </cite> 
            <img src="../../images/popupcross.png" class="Btclose1" style="float:right; margin-right:10px; margin-top:2px; cursor:pointer;" /> 
        </dd>
         <table id="grdpermission1" cellspacing="0" style="border-collapse:collapse;margin-left: 1%;">
             <tbody>
                 <%--<tr>
                     <td style="width: 155px;">
                         <input id="xxxx" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">xxxx</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="xxxx" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">xxxx</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="xxxx" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">xxxx</span>
                         </div>                       
                     </td>
                 </tr>--%>
                <tr>
                     <td style="width: 155px;">
                         <input id="RID" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">RID</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SAMID" type="checkbox" />
                        <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SAMID</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="IsHostel" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">IsHostel</span>
                         </div>                        
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="HouseID" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">HouseID</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="AdmissionDate" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">AdmissionDate</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="AdmissionNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">AdmissionNo</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="RegistrationDate" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">RegistrationDate</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="Registration_No" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Registration_No</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="RefrenceAdmissionNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">RefrenceAdmissionNo</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="studentname1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">studentname</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="Classname1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Classname</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="Sectionname" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Sectionname</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="StudentUID" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">StudentUID</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="RegNewNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">RegNewNo</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="Religion1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Religion</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="CastCategoryName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">CastCategoryName</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="StudentDOB1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">StudentDOB</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="Gender1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Gender</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="Nationality" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Nationality</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="BirthPlace" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">BirthPlace</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="NoOfSiblings" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">NoOfSiblings</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="TransportationRequired" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">TransportationRequired</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="StudentPhotograph" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">StudentPhotograph</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="BirthCertificate" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">BirthCertificate</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="DocumentSubmitted" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">DocumentSubmitted</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="AdditionalInformation" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">AdditionalInformation</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="Country1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Country</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="State1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">State</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="City1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">City</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="Pin1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Pin</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="Address1" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">Address</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="BloodGroup" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">BloodGroup</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolName</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SchoolBoard" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolBoard</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolMedium" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolMedium</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolPreviousClassName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolPreviousClassName</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SchoolPercentageInPreviousClass" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolPercentageInPreviousClass</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolAddress" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolAddress</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolContactNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolContactNo</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SchoolAlternateContactNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolAlternateContactNo</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SchoolWebsite" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SchoolWebsite</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimarySelectParentType" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimarySelectParentType</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryParentName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryParentName</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryParentNationality" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryParentNationality</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryHighestQualification" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryHighestQualification</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryParentOccupation" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryParentOccupation</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryDesignation" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryDesignation</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryNameOfOrganization" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryNameOfOrganization</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryAddressOfOfficeBusiness" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryAddressOfOfficeBusiness</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryParentAnnualIncome" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryParentAnnualIncome</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryAddress" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryAddress</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryCity" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryCity</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryState" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryState</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryPinZipCode" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryPinZipCode</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryCountry" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryCountry</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryPhoneNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryPhoneNo</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="PrimaryMobileNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryMobileNo</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="PrimaryEmailId" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">PrimaryEmailId</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondarySelectParentType" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondarySelectParentType</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryParentName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryParentName</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SecondaryParentNationality" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryParentNationality</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryHighestQualification" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryHighestQualification</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryParentOccupation" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryParentOccupation</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SecondaryDesignation" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryDesignation</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryNameOfOrganization" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryNameOfOrganization</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryAddressOfOfficeBusiness" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryAddressOfOfficeBusiness</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SecondaryParentAnnualIncome" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryParentAnnualIncome</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryAddress" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryAddress</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryCity" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryCity</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SecondaryState" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryState</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryPinZipCode" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryPinZipCode</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryCountry" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryCountry</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="SecondaryPhoneNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryPhoneNo</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryMobileNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryMobileNo</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="SecondaryEmailId" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">SecondaryEmailId</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="EmergencyName" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyName</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyMobileNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyMobileNo</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyAlternateMobileNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyAlternateMobileNo</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="EmergencyPhoneNo" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyPhoneNo</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyAddress" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyAddress</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyCity" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyCity</span>
                         </div>                       
                     </td>
                 </tr>
                 <tr>
                     <td style="width: 155px;">
                         <input id="EmergencyState" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyState</span>
                         </div>                       
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyCountry" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                             <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyCountry</span>
                         </div>                        
                     </td>
                     <td style="width: 155px;">
                         <input id="EmergencyPinZipCode" type="checkbox" />
                         <div style="margin-left: 11px;margin-top: -12px;">
                            <span class="for_cheackbox" style="font-size:11px !important;padding: unset !important;">EmergencyPinZipCode</span>
                         </div>                       
                     </td>
                 </tr>
                 </tbody>
         </table>
         <div class="clear" style="margin-top:20px;"></div>
         <input type="submit" name="btnExcelSubmit" value="Submit" id="btnExcelSubmit" class="button_save" style="margin-left:200px !important;" />
         <%--<input type="submit" name="ctl00$ContentPlaceHolder1$ImageButtonCancel" value="Cancel" id="ctl00_ContentPlaceHolder1_ImageButtonCancel" class="button2 Btclose" style="margin-left:10px !important;" />--%>
    </div>
     <div id="divProgressBar" class="progress"></div>

    <div id="docModal" class="modal">

      <!-- Modal content -->
      <div class="modal-content">
        <span class="close" onclick="$('#docModal').hide();$('#modalReg').text('');$('#fileupload').val('');">&times;</span>
          <p style="font-size: 20px; font-weight: bold">Upload document for Reg. Number:<span id="modalReg"></span></p>
          <div style="width:100%;margin-bottom:70px;margin-top:20px;">
              <div style="width:48%;float:left;text-align:right;font-size:15px">Upload file</div>
              <div style="width:48%;float:right"> <input type="file" id="fileupload" onchange="validate(this.value)" accept="application/pdf,.jpg,.png"/></div>
          </div>
          <div style="width:100%;margin-bottom:40px;text-align:center">
              <input type="button" id="btnupload" onclick="SaveDoc()" value="Upload" style="background-color: cornflowerblue;color: white;width: 90px;border-radius: 3px;padding: 2px;"/>
          </div><br />

          
      </div>

    </div>
    
</asp:Content>

