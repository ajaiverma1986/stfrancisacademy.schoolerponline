<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-registration.aspx.cs" Inherits="BranchPanel_student_registration" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Student Information
                <img src="../../images/Expend.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 20px;" alt="No Image" />
                </div>
                <div class="for_sigle_row_form" id="RegistrationSession">
                    <label>
                        Registration Session<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="AdmissionNo" style="display: none">
                    <label>
                        Admission No.(For Reference)</label>
                    <asp:TextBox ID="txtadmissionreferenceno" runat="server" MaxLength="15" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="StudentOldRegNo">
                    <label>
                        Reference Registration No</label>
                    <asp:TextBox ID="txtOldRegNo" runat="server" MaxLength="15" placeholder="Enter Reference Registration No Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="StudentFirstName">
                    <label>
                        Student First Name<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtstudentfirstname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student First Name"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="StudentMiddleName">
                    <label>
                        Student Middle Name</label>
                    <asp:TextBox ID="txtstudentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Middle Name"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="StudentLastName">
                    <label>
                        Student Last Name</label>
                    <asp:TextBox ID="txtstudentlastname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Last Name"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="StudentDOB">
                    <label>
                        Select Student D.O.B<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtstudentdob" onchange="CalculateAge(this)" onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;     
                    <span id="lblAge" style="font-weight: bold; color: red"></span>
                </div>
                <div class="for_sigle_row_form" id="StudentUID">
                    <label>
                        Student Aadhaar Card(UID) No</label>
                    <asp:TextBox ID="txtstudentUid" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Student Aadhaar Card(UID) No"></asp:TextBox>&nbsp;     
                    <span id="lblUid" style="font-weight: bold; color: red"></span>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="Hostal" runat="server" visible="false">
                    <label style="padding-top: 4px;">
                        Hostel</label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistHostal" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1">Yes</asp:ListItem>
                            <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="house" runat="server" visible="false">
                    <label>
                        House Name</label>
                    <asp:DropDownList ID="ddlHouse" runat="server">
                        <asp:ListItem Value="0">--Select House Name--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="Gender">
                    <label style="padding-top: 4px;">
                        Gender<span style="color: Red; font-weight: bold">*</span></label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistgender" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                            <asp:ListItem Value="2">Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="clear"></div>
                <div class="for_sigle_row_form" id="Nationality">
                    <label style="padding-top: 4px;">
                        Nationality<span style="color: Red; font-weight: bold">*</span></label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistnationality" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Indian</asp:ListItem>
                            <asp:ListItem Value="2">Other</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" style="display: none" id="divforothercountry">
                    <label>
                        Country Name</label>
                    <asp:TextBox ID="txtcountryname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Country Name Please" Text="India"></asp:TextBox>&nbsp;                    
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="BirthPlace">
                    <label>
                        Birth Place</label>
                    <asp:TextBox ID="txtbirthplace" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Birth place"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="Religion">
                    <label>
                        Religion<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtreligion" runat="server" onkeypress="return lettersOnly(event)" MaxLength="15" placeholder="Enter Religion Please"></asp:TextBox>&nbsp;                 
                </div>
                <div class="for_sigle_row_form" id="MotherTongue">
                    <label>
                        Mother Tongue</label>
                    <asp:TextBox ID="txtmothertongue" runat="server" onkeypress="return lettersOnly(event)" MaxLength="15" placeholder="Enter Mother Tongue"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="NoOfSiblings">
                    <label>
                        No Of Siblings</label>
                    <asp:TextBox ID="txtnoofsibbling" onkeypress="return isNumberKey(event)" MaxLength="2" runat="server" placeholder="Enter No Of Siblings"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="CastCategory">
                    <label style="padding-top: 4px;">
                        Cast/Category<span style="color: Red; font-weight: bold">*</span></label>
                    <div style="width: 350px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistcast" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">General </asp:ListItem>
                            <asp:ListItem Value="2">OBC</asp:ListItem>
                            <asp:ListItem Value="3">SC</asp:ListItem>
                            <asp:ListItem Value="4">ST</asp:ListItem>
                            <asp:ListItem Value="5">Minority</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Applying For Class<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                </div>
                <div class="for_sigle_row_form" id="TransportationRequired">
                    <label style="padding-top: 4px;">
                        Transportation Required</label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtntransportationrequired" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1">Yes </asp:ListItem>
                            <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="StudentPhotograph">
                    <label style="padding-top: 4px;">
                        Upload Student Photograph</label>
                    <asp:FileUpload ID="fileuploaderofstudentphotograph" runat="server" onchange="ShowpImagePreviewstudentphotograph(this)" />
                </div>
                <div class="user_phot_frame">
                    <div id="stuphotograph" style="display: none; position: absolute; margin-top: -62px" runat="server">
                        <span style="color: black; font-weight: bold; padding-top: 20px;">
                            <center><u>Student Photograph</u></center>
                        </span>
                        <asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px" />
                    </div>

                    <div id="stucertifiacte" style="display: none; position: absolute; margin-left: 175px; margin-top: -62px" runat="server">
                        <span style="color: black; font-weight: bold; padding-top: 20px;">
                            <center><u>Student Certificate</u></center>
                        </span>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px" />
                    </div>
                </div>
                <div class="for_sigle_row_form" id="BirthCertificate">
                    <label style="padding-top: 4px;">
                        Upload Birth Certificate</label>
                    <asp:FileUpload ID="fileuploaderofbirthcertificate" onchange="ShowpImagePreviewshowbirthcertificate(this);" runat="server" />
                </div>
                <div class="for_sigle_row_form" id="DocumentSubmitted">
                    <label style="padding-top: 4px;">
                        Document Submitted</label>
                    <textarea id="txttotalsubmiteddocument" onkeypress="return lettersOnly(event)" runat="server" rows="3" cols="3" placeholder="Enter Document Submitted By Student"></textarea>
                </div>
                <div class="for_sigle_row_form" id="AdditionalInformation">
                    <label style="padding-top: 4px;">
                        Additional Information</label>
                    <textarea id="txtadditionalinformation" runat="server" rows="3" cols="3" placeholder="Enter Additional Information"></textarea>
                </div>
                <div class="for_sigle_row_form" id="Address">
                    <label style="padding-top: 4px;">
                        Address<span style="color: Red; font-weight: bold">*</span></label>
                    <textarea id="txtaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>
                </div>
                <div class="for_sigle_row_form" id="City">
                    <label>
                        City<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="State">
                    <label>
                        State<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtstate" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter State Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="Pin">
                    <label>
                        Pin/Zip Code<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtpiorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="Country">
                    <label>
                        Country<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Student Medical Details
                </div>
                <div class="for_sigle_row_form" id="BloodGroup">
                    <label>
                        Blood Group</label>
                    <asp:DropDownList ID="ddlbloodgroup" runat="server">
                        <asp:ListItem Value="0">--Select  Blood Group--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                    
                </div>
                <div class="clear"></div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Student Previous School Details
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="SchoolName">
                    <label>
                        School Name</label>
                    <asp:TextBox ID="txtschoolname" runat="server" onkeypress="return lettersOnly(event)" MaxLength="25" placeholder="Enter School Name Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="SchoolBoard">
                    <label>
                        Board</label>
                    <asp:TextBox ID="txtboard" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>
                <div class="for_sigle_row_form" id="SchoolMedium">
                    <label>
                        Medium</label>
                    <asp:TextBox ID="txtmedium" runat="server" MaxLength="25" placeholder="Enter Medium Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="SchoolPreviousClassName">
                    <label>
                        Previous Class Name</label>
                    <asp:TextBox ID="txtclassname" runat="server" MaxLength="25" placeholder="Enter Previous Class Name"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="SchoolPercentageInPreviousClass">
                    <label>
                        Percentage In Previous Class</label>
                    <asp:TextBox ID="txtpreviusclsspercentage" runat="server" MaxLength="3" placeholder="Enter Percentage In Previous Class"></asp:TextBox>&nbsp;                       
                </div>
                <div class="for_sigle_row_form" id="SchoolAddress">
                    <label>
                        Address</label>
                    <textarea id="txtschooladdress" runat="server" placeholder="Enter Address Please" rows="3" cols="3"></textarea>&nbsp;                        
                </div>
                <div class="for_sigle_row_form" id="SchoolContactNo">
                    <label>
                        Contact No</label>
                    <asp:TextBox ID="txtcontactno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Contact No Please"></asp:TextBox>&nbsp;                       
                </div>
                <div class="for_sigle_row_form" id="SchoolAlternateContactNo">
                    <label>
                        Alternate Contact No</label>
                    <asp:TextBox ID="txtalternatecontactno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Alternate Contact No Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="SchoolWebsite">
                    <label>
                        School Website</label>
                    <asp:TextBox ID="txtwesite" runat="server" placeholder="Enter Website Please"></asp:TextBox>&nbsp;                       
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Primary Parent Details                   
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="PrimarySelectParentType">
                    <label>
                        Select Parent Type<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:DropDownList ID="ddlparenttype" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentFirstName">
                    <label>
                        Parent First Name<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="First Name Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentMiddleName">
                    <label>
                        Parent Middle Name</label>
                    <asp:TextBox ID="txtparentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Middle Name Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentLastName">
                    <label>
                        Parent Last Name</label>
                    <asp:TextBox ID="txtparentlastname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Last Name Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryMobileNo">
                    <label>
                        Mobile No<span style="color: Red; font-weight: bold">*</span></label>
                    <asp:TextBox ID="txtparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentDOB">
                    <label>
                        Parent D.O.B</label>
                    <asp:TextBox ID="txtparentdateofbirth" onkeypress="return false" runat="server" placeholder="Select D.O.B Please"></asp:TextBox>&nbsp;
                       
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentNationality">
                    <label>
                        Parent Nationality</label>
                    <asp:TextBox ID="txtparentnationality" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;
                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryHighestQualification">
                    <label>
                        Highest Qualification</label>
                    <asp:DropDownList ID="ddlparentqualification" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentOccupation">
                    <label>
                        Parent Occupation</label>
                    <asp:TextBox ID="txtparentoccupation" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Occupation Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="PrimaryDesignation">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtparentdesignation" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Designation Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryNameOfOrganization">
                    <label>
                        Name Of Organization</label>
                    <asp:TextBox ID="txtparentorganization" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Name Of Organization"></asp:TextBox>&nbsp;      
                </div>
                <div class="for_sigle_row_form" id="PrimaryAddressOfOfficeBusiness">
                    <label>
                        Address Of Office/Business</label>
                    <asp:TextBox ID="txtofficeaddress" runat="server" placeholder="Address Of Office/Business"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentAnnualIncome">
                    <label>
                        Parent Annual Income</label>
                    <asp:TextBox ID="txtannualincome" onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" placeholder="Parent Annual Income"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryAddress">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txtparentaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryCity">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtparentcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryState">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtparentstate" runat="server" MaxLength="25" placeholder="Enter State Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="PrimaryPinZipCode">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtparentpincodeorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryCountry">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txtparentcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PrimaryPhoneNo">
                    <label>
                        Phone No</label>
                    <asp:TextBox ID="txtparentphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryEmailId">
                    <label>
                        Email-Id</label>
                    <asp:TextBox ID="txtparentemailid" runat="server" MaxLength="35" placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;                                      
                </div>
                <div class="for_sigle_row_form" id="PrimaryUploadParentPhotograph">
                    <label style="padding-top: 4px;">
                        Upload Parent Photograph</label>
                    <asp:FileUpload ID="fileuploaderofparentphotograph" onchange="ShowpImageParentphotograph(this);" runat="server" />&nbsp;
                     <div class="user_phot_frame">
                         <div id="parentfirstphoto" style="display: none; width: 150px; position: absolute; margin-top: -90px" runat="server">
                             <span style="color: black; font-weight: bold; padding-top: 20px;">
                                 <center><u>Parent Photograph</u></center>
                             </span>
                             <asp:Image ID="Image2" runat="server" ImageUrl="~/images/9update.png" AlternateText="No Attachment" Height="150px" Width="150px" />
                         </div>
                     </div>
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Secondary Parent Details
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="SecondarySelectParentType">
                    <label>
                        Select Parent Type</label>
                    <asp:DropDownList ID="ddlsecondaryparenttype" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentFirstName">
                    <label>
                        Parent First Name</label>
                    <asp:TextBox ID="txtsecondaryparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter First Name Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentMiddleName">
                    <label>
                        Parent Middle Name</label>
                    <asp:TextBox ID="txtsecondaryparentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Middle Name Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentLastName">
                    <label>
                        Parent Last Name</label>
                    <asp:TextBox ID="txsecondaryparentlastname" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Last Name Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentDOB">
                    <label>
                        Parent D.O.B</label>
                    <asp:TextBox ID="txtsecondaryparentdateofbirth" onkeypress="return false" runat="server" Placeholder="Select D.O.B"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentNationality">
                    <label>
                        Parent Nationality</label>
                    <asp:TextBox ID="txtsecondaryparentnationality" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryHighestQualification">
                    <label>
                        Highest Qualification</label>
                    <asp:DropDownList ID="ddlsecondaryparenthighestqualification" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentOccupation">
                    <label>
                        Parent Occupation</label>
                    <asp:TextBox ID="txtsecondaryparentoccupation" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Occupation Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryDesignation">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtsecondaryparentdesignation" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Designation Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="SecondaryNameOfOrganization">
                    <label>
                        Name Of Organization</label>
                    <asp:TextBox ID="txtnameoforganizationofsecondayparent" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Name Of Organization"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryAddressOfOfficeBusiness">
                    <label>
                        Address Of Office/Business</label>
                    <textarea id="txtbusinessorofficeaddressofsecondayparent" runat="server" rows="3" cols="3" placeholder="Address Of Office/Business"></textarea>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryParentAnnualIncome">
                    <label>
                        Parent Annual Income</label>
                    <asp:TextBox ID="txtsecondaryparentannualincome" onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" Placeholder="Annual Income Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryAddress">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txsecondayparentaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>
                    &nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryCity">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtsecondaryparentcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter City Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryState">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtsecondaryparentstate" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter State Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="SecondaryPinZipCode">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtsecondayparentpinorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="SecondaryCountry">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txsecondaryparentcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Country Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryPhoneNo">
                    <label>
                        Phone No</label>
                    <asp:TextBox ID="txtsecondaryparentphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryMobileNo">
                    <label>
                        Mobile No</label>
                    <asp:TextBox ID="txtsecondaryparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="SecondaryEmailId">
                    <label>
                        Email-Id</label>
                    <asp:TextBox ID="txtsecondaryparentemailid" runat="server" MaxLength="35" Placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="SecondaryUploadParentPhotograph">
                    <label style="padding-top: 4px;">
                        Upload Parent Photograph</label>
                    <asp:FileUpload ID="fileuploadforsecondaryparentphotograph" onchange="ShowpImageParentphotographsecond(this);" runat="server" />&nbsp;
                    <div class="user_phot_frame">
                        <div id="secondaryparentphoto" style="display: none; width: 150px; position: absolute; margin-top: -90px" runat="server">
                            <span style="color: black; font-weight: bold; padding-top: 20px;">
                                <center><u>Parent Photograph</u></center>
                            </span>
                            <asp:Image ID="Image3" runat="server" ImageUrl="~/images/9update.png" AlternateText="No Attachment" Height="150px" Width="150px" />
                        </div>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Emergency Contact Person (OTHER THAN PARENTS)
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="EmergencyName">
                    <label style="padding-top: 4px;">
                        Name</label>
                    <asp:TextBox ID="txtnameofcontactpersonincaseofemergency" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Name Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="EmergencyMobileNo">
                    <label style="padding-top: 4px;">
                        Mobile No</label>
                    <asp:TextBox ID="txtemergencymobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="EmergencyAlternateMobileNo">
                    <label style="padding-top: 4px;">
                        Alternate Mobile No</label>
                    <asp:TextBox ID="txtemergencyalternatemobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Alternate Mobile No Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="EmergencyPhoneNo">
                    <label style="padding-top: 4px;">
                        Phone No</label>
                    <asp:TextBox ID="txtemegencycontactpersonphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;       
                </div>
                <div class="for_sigle_row_form" id="EmergencyAddress">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txtemergencycontactpersonaddress" runat="server" rows="3" cols="3" placeholder="Enter Address"></textarea>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="EmergencyCity">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtemergencycontactpersoncity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter City"></asp:TextBox>&nbsp;    
                </div>
                <div class="for_sigle_row_form" id="EmergencyState">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtemergencycontactpersonstate" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter State"></asp:TextBox>&nbsp;
                    
                </div>
                <div class="for_sigle_row_form" id="EmergencyPinZipCode">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtemergencycontactpersonpinorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="EmergencyCountry">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txtemergencycontactpersoncountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Country"></asp:TextBox>&nbsp;                     
                </div>
                <div id="ExamDetail" runat="server" visible="false">
                    <div class="sub-heading">
                        Entrance Test Details
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Exam Date</label>
                        <asp:TextBox ID="txtExamDate" onkeypress="return false" runat="server" Placeholder="Enter Exam Date"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Exam Time</label>
                        <asp:UpdatePanel ID="updatepnl" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtExamTime" onkeypress="return false" runat="server" Placeholder="Enter Exam Time"></asp:TextBox>&nbsp;                     
                         <asp:LinkButton ID="lnbFillTime" runat="server" OnClick="lnbFillTime_Click">Fill Time</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Total Max Marks</label>
                        <asp:TextBox ID="txtMaxMarks" onkeypress="return isNumberKey(event)" runat="server" Placeholder="Enter Total Max Makrs">0</asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Total Obtained Marks</label>
                        <asp:TextBox ID="txtObtainedMarks" onkeypress="return isNumberKey(event)" Text="0" runat="server" Placeholder="Enter Total Obtained Marks">0</asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Result</label>
                        <asp:TextBox ID="txtResult" runat="server" Placeholder="Enter Exam Result"></asp:TextBox>&nbsp;                     
                    </div>
                </div>

                <div class="sub-heading">
                    Student Document Details                  
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form"> 
                    <label style="margin-top: -.8%;">Aadhar card</label>
                    <asp:CheckBox ID="chkAadharCard" runat="server" />                     
                </div>
                <div class="for_sigle_row_form">   
                    <label style="margin-top: -.8%;">Birth certificate</label>
                    <asp:CheckBox ID="ChkBirthCertificate" runat="server" /> 
                </div>
                <div class="for_sigle_row_form">    
                    <label style="margin-top: -.8%;">Migration certificate</label>
                    <asp:CheckBox ID="chkMigrationCertificate" runat="server" /> 
                </div>
                <div class="for_sigle_row_form">   
                    <label style="margin-top: -.8%;">Caste certificate</label>
                    <asp:CheckBox ID="chkCasteCertificate" runat="server" /> 
                </div>
                <div class="for_sigle_row_form">      
                    <label style="margin-top: -.8%;">Last year marksheet</label>
                    <asp:CheckBox ID="chkLastYearMarksheet" runat="server" /> 
                </div>

                <div id="not_editable" runat="server">
                    <div class="sub-heading">
                        Registration Fee Details
                    </div>
                    <div class="for_sigle_row_form" id="RegistrationFee">
                        <label>
                            Registration Fee<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtregistrationfee" onkeypress="return false" runat="server" Placeholder="Enter Registration Fee"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="PaymentMode">
                        <label>
                            Payment Mode</label>
                        <asp:DropDownList ID="ddlpaymentmode" runat="server">
                            <asp:ListItem Value="0">--Select One--</asp:ListItem>
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Cheque</asp:ListItem>
                            <asp:ListItem Value="3">DD</asp:ListItem>
                            <asp:ListItem Value="4">NEFT</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form" id="divbankname" style="display: none" runat="server">
                        <label>
                            Bank Name</label>
                        <asp:TextBox ID="txtchkddneftbankname" runat="server" MaxLength="25" Placeholder="Enter Bank Name"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divbranchname" style="display: none" runat="server">
                        <label>
                            Branch Name</label>
                        <asp:TextBox ID="txtchkddneftbranchname" MaxLength="25" runat="server" Placeholder="Enter Branch Name"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divrefnumber" style="display: none" runat="server">
                        <label>
                            Cheque Number</label>
                        <asp:TextBox ID="txtchkddneftrefno" MaxLength="25" runat="server" Placeholder="Enter Refrence Number"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="for_sigle_row_form" id="divrefdate" style="display: none" runat="server">
                        <label>
                            Cheque Date</label>
                        <asp:TextBox ID="txtchkddneftrefdate" onkeypress="return false" runat="server" Placeholder="Enter Refrence Date"></asp:TextBox>&nbsp;                     
                    </div>
                    <div class="clear"></div>
                    <div class="sub-heading">
                        For Office Use Only
                    </div>
                    <div class="for_sigle_row_form" id="RegistrationDate">
                        <label>
                            Registration Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtregistrationdate" onkeypress="return false" runat="server" Placeholder="Select Registration Date"></asp:TextBox>&nbsp;                    
                    </div>
                    <div class="for_sigle_row_form" id="RegistrationReceipt">
                        <label>
                            Is Required Receipt</label>
                        <asp:CheckBox ID="chkReceipt" runat="server" />&nbsp;                    
                    </div>
                    <div class="for_sigle_row_form" id="Comment">
                        <label style="padding-top: 4px;">
                            Comment</label>
                        <textarea id="txtcomment" runat="server" rows="3" cols="3" placeholder="Your Comment Please"></textarea>&nbsp;                   
                    </div>
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Save/Update</label>
                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" OnClick="btnforupdateorsave_Click" CssClass="button_save" />
                    <asp:Button ID="btnforcancel" runat="server" Text="Cancel" OnClick="btnforcancel_Click" CssClass="button_cancel" />
                </div>
                <br />
                <br />
            </div>
            <asp:Label ID="lblStudentPhotograph" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
            <asp:Label ID="lblStudentcertificate" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
            <asp:Label ID="lblparentfirstphoto" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
            <asp:Label ID="lblparentsecondphoto" Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2022;
        $(document).ready(function () {
            BindFieldOnTheBehalfOfCheckUnCheck();
            Collapse();
            $('#imgbtnforcollapseorexpend').click(function () {
                if ($(this).attr('src') == '../../images/Expend.png') {
                    Expende();
                    $(this).attr('src', '../../images/CollapseAllImages.png');
                }
                else {
                    Collapse();
                    $(this).attr('src', '../../images/Expend.png');
                }
            });
            $("#ctl00_ContentPlaceHolder1_txtstudentdob,#ctl00_ContentPlaceHolder1_txtparentdateofbirth,#ctl00_ContentPlaceHolder1_txtsecondaryparentdateofbirth,#ctl00_ContentPlaceHolder1_txtregistrationdate,#ctl00_ContentPlaceHolder1_txtExamDate,#ctl00_ContentPlaceHolder1_txtchkddneftrefdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + year,
                dateFormat: 'dd MM yy'
            });

            $('#<%=fileuploaderofstudentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#stuphotograph').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test();

                }

            });
            $('#<%=fileuploaderofbirthcertificate.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#stucertifiacte').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test2();

                }
            });
            $('#<%=fileuploaderofparentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#parentfirstphoto').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test3();

                }
            });
            $('#<%=fileuploadforsecondaryparentphotograph.ClientID %>').change(function () {
                var ValidFileExtension = ['jpg', 'JPG', 'jpeg', 'JPEG', 'png', 'PNG', 'gif', 'GIF', 'bmp', 'BMP'];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), ValidFileExtension) == -1) {
                    $('#secondaryparentphoto').hide();
                    alert("Sorry !!! Allowed image formats are '.jpeg','.jpg', '.png', '.gif', '.bmp'");
                    test4();

                }
            });
            $('#ctl00_ContentPlaceHolder1_rbtnlistnationality input').change(function () {
                if ($(this).val() == '1') {
                    $('#divforothercountry').css('display', 'none');
                    $('#ctl00_ContentPlaceHolder1_txtcountryname').val('India');
                }
                else {
                    $('#divforothercountry').css('display', 'block');
                    $('#ctl00_ContentPlaceHolder1_txtcountryname').val('');
                }
            });
            $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').change(function () {
                $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "student-registration.aspx/BindClassDDL",
                    data: "{'Fyid':'" + $(this).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').html('<option value="0">--Select Class--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                            }
                        }
                    }
                });
            });


            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
                var ClassId = $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val();
                var Fyid = $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val();
                if (parseInt(Fyid) == 0) {
                    alertify.error("Select Session First.");
                    $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val('0');
                    return false;
                }
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "student-registration.aspx/ProcessIT",
                    data: "{'ClassId':'" + ClassId + "','Fyid':'" + Fyid + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != '')
                            $('#ctl00_ContentPlaceHolder1_txtregistrationfee').val(data.d);
                        else
                            $('#ctl00_ContentPlaceHolder1_txtregistrationfee').val('0.00');
                    }
                });
            });

            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() == '0') {
                    alertify.error('Select registration  session please.');
                    $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentfirstname').val() == '') {
                    alertify.error('Enter student first name please.');
                    $('#ctl00_ContentPlaceHolder1_txtstudentfirstname').focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
                    alertify.error('Select Section please.');
                    $('#ctl00_ContentPlaceHolder1_ddlsection').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentdob').val() == '') {
                    alertify.error('Select Date of birth please,');
                    $('#ctl00_ContentPlaceHolder1_txtstudentdob').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtOldRegNo').val() != '') {
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "student-registration.aspx/checlOldAdmNo",
                        data: "{'RefAdmNo':'" + $('#ctl00_ContentPlaceHolder1_txtOldRegNo').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d.length > 0) {
                                alertify.error('Enter Student Aadhaar Car No.');
                                $('#ctl00_ContentPlaceHolder1_txtOldRegNo').focus();
                                return false;
                            }
                        }
                    });
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentUid').val() != '') {
                    if ($('#ctl00_ContentPlaceHolder1_txtstudentUid').val().length != 12) {
                        alertify.error('Student Aadhaar Card No. only 12 Digits');
                        $('#ctl00_ContentPlaceHolder1_txtstudentUid').focus();
                        return false;
                    }
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtreligion').val() == '') {
                    alertify.error('Enter religion please.');
                    $('#ctl00_ContentPlaceHolder1_txtreligion').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
                    alertify.error('Select class please.');
                    $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtaddress').val() == '') {
                    alertify.error('Enter address please.');
                    $('#ctl00_ContentPlaceHolder1_txtaddress').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtaddress').val().indexOf(',') !== -1) {
                    alertify.error('Comma is not allows in address .');
                    $('#ctl00_ContentPlaceHolder1_txtaddress').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtcity').val() == '') {
                    alertify.error('Enter city please.');
                    $('#ctl00_ContentPlaceHolder1_txtcity').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstate').val() == '') {
                    alertify.error('Enter state please.');
                    $('#ctl00_ContentPlaceHolder1_txtstate').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtpiorzipcode').val() == '') {
                    alertify.error('Enter pincode/zipcode please.');
                    $('#ctl00_ContentPlaceHolder1_txtpiorzipcode').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtcountry').val() == '') {
                    alertify.error('Enter country please.');
                    $('#ctl00_ContentPlaceHolder1_txtcountry').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlparenttype').val() == '0') {
                    alertify.error('Select primary parent type please.');
                    $('#ctl00_ContentPlaceHolder1_ddlparenttype').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtparentfirstname').val() == '') {
                    alertify.error('Enter primary parent first name please.');
                    $('#ctl00_ContentPlaceHolder1_txtparentfirstname').focus();
                    return false;
                }
                    //else if ($('#ctl00_ContentPlaceHolder1_txtparentlastname').val() == '') {
                    //    alertify.error('Enter primary parent last name please.');
                    //    $('#ctl00_ContentPlaceHolder1_txtparentlastname').focus();
                    //    return false;
                    //}
                else if ($('#ctl00_ContentPlaceHolder1_txtregistrationfee').val() == '') {
                    alertify.error('Enter Registration Fee Please.');
                    $('#ctl00_ContentPlaceHolder1_txtregistrationfee').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtparentmobileno').val() == '') {
                    alertify.error('Enter Parent Mobile No.');
                    $('#ctl00_ContentPlaceHolder1_txtparentmobileno').focus();
                    return false;
                }
                //else if ($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val() == '0') {
                //    alertify.error('Select payment mode please.');
                //    $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').focus();
                //    return false;
                //}
                //else 
                if (parseInt($('#ctl00_ContentPlaceHolder1_ddlpaymentmode').val()) > 1) {
                    if ($('#ctl00_ContentPlaceHolder1_txtchkddneftbankname').val() == '') {
                        alertify.error('Enter bank name please.');
                        $('#ctl00_ContentPlaceHolder1_txtchkddneftbankname').focus();
                        return false;
                    }
                    else if ($('#ctl00_ContentPlaceHolder1_txtchkddneftbranchname').val() == '') {
                        alertify.error('Enter bank brach name please.');
                        $('#ctl00_ContentPlaceHolder1_txtchkddneftbranchname').focus();
                        return false;
                    }
                    else if ($('#ctl00_ContentPlaceHolder1_txtchkddneftrefno').val() == '') {
                        alertify.error('Enter refrence number please.');
                        $('#ctl00_ContentPlaceHolder1_txtchkddneftrefno').focus();
                        return false;
                    }
                    else if ($('#ctl00_ContentPlaceHolder1_txtchkddneftrefdate').val() == '') {
                        alertify.error('Select refrence date please.');
                        $('#ctl00_ContentPlaceHolder1_txtchkddneftrefdate').focus();
                        return false;
                    }
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtregistrationdate').val() == '') {
                    alertify.error('Select registration date please.');
                    $('#ctl00_ContentPlaceHolder1_txtregistrationdate').focus();
                    return false;
                }
                var tempRID=getUrlVars()["RID"];
                if (tempRID == undefined)
                {
                    tempRID = 0;
                }
                if (tempRID > 0) {
                    if ($('#ctl00_ContentPlaceHolder1_txtMaxMarks').val() != '' && $('#ctl00_ContentPlaceHolder1_txtObtainedMarks').val() != '') {
                        if ($('#ctl00_ContentPlaceHolder1_txtMaxMarks').val() < $('#ctl00_ContentPlaceHolder1_txtObtainedMarks').val()) {
                            alertify.error('Obtained Marks can not Greather than Max Marks.');
                            $('#ctl00_ContentPlaceHolder1_txtObtainedMarks').focus();
                            return false;
                        }
                    }
                }
            });
            $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').change(function () {
                if (parseInt($(this).val()) > 1)
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'block');
                else
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'none');
            });
            $("#ctl00_ContentPlaceHolder1_txtparentemailid,#ctl00_ContentPlaceHolder1_txtsecondaryparentemailid").blur(function () {
                var emailid = $(this).val();
                if (emailid != '') {
                    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                    if (!reg.test(emailid)) {
                        alertify.error('Please Enter Valid Email-Id ( ie: amitsharma@awapal.com).');
                        document.getElementById('<%=txtparentemailid.ClientID%>').value = '';

                        return false;
                    }
                }
            });
            $('#ctl00_ContentPlaceHolder1_txtregistrationdate').change(function () {
                $.ajax({
                    type: "POST",
                    url: "student-registration.aspx/IsReadyForAction",
                    data: "{'Date':'" + $(this).val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != 1) {
                            $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                            alert('Registartion Process Is Off For The Selected Session And Registration Date.\nPlease Select Valid Session And Registration Date.');
                        }
                    },
                });
            });
        });
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
        function test() {

            var uploadControl = document.getElementById('<%=fileuploaderofstudentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function test2() {

            var uploadControl = document.getElementById('<%=fileuploaderofbirthcertificate.ClientID%>');
            uploadControl.value = "";
        }
        function test3() {

            var uploadControl = document.getElementById('<%=fileuploaderofparentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function test4() {

            var uploadControl = document.getElementById('<%=fileuploadforsecondaryparentphotograph.ClientID%>');
            uploadControl.value = "";
        }
        function ShowpImagePreviewstudentphotograph(input) {


            $('#ctl00_ContentPlaceHolder1_stuphotograph').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_imguser').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImagePreviewshowbirthcertificate(input) {
            $('#ctl00_ContentPlaceHolder1_stucertifiacte').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_Image1').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotograph(input) {
            $('#ctl00_ContentPlaceHolder1_parentfirstphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_Image2').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotographsecond(input) {

            $('#ctl00_ContentPlaceHolder1_secondaryparentphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_Image3').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function BindFieldOnTheBehalfOfCheckUnCheck() {
            $.ajax({
                type: "POST",
                url: "student-registration.aspx/CheckCheckboxOnTheBehalfOfPermission",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        if (value.Displaystatus == 'none') {
                            $('#' + value.DivName + '').remove();
                        }
                        else {
                            $('#' + value.DivName + '').css('display', 'block');
                        }
                    });
                },
            });
        }
        //-------function for used validation----------
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
        //-----------------------------------------------
        function Collapse() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#TransportationRequired,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "none");
        }
        function Expende() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#TransportationRequired,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "block");
        }
        function CalculateAge() {

            var chunks = $('#ctl00_ContentPlaceHolder1_txtstudentdob').val().split(' ');
            var CalculateDate = chunks[2] + '-' + chunks[1] + '-' + chunks[0];
            //$('#ctl00_ContentPlaceHolder1_txtdob1').val(CalculateDate);
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-registration.aspx/GetYearMonthDate",
                data: "{'Date':'" + CalculateDate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == '0') {
                        alertify.error('Enter Valid Date Please.')
                        $('#ctl00_ContentPlaceHolder1_txtstudentdob').val('');
                        $('#ctl00_ContentPlaceHolder1_txtstudentdob').focus();
                        return false;
                    }
                    $('#lblAge').html(data.d);
                    $('#lblAge').css("", "");
                }
            });
        }
    </script>

</asp:Content>

