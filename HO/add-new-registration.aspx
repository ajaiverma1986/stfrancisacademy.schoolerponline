<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="add-new-registration.aspx.cs" Inherits="HO_add_new_registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Student Information
                </div>
                <div class="for_sigle_row_form" style="display:none">
                    <label>
                        Registration Session<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                    <input type="checkbox" id="RegistrationSession" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Admission No.(For Reference)</label>
                    <asp:TextBox ID="txtadmissionreferenceno" runat="server" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="AdmissionNo" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Student First Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentfirstname" runat="server" placeholder="Enter Student First Name"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="StudentFirstName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Student Middle Name</label>
                    <asp:TextBox ID="txtstudentmiddlename" runat="server" placeholder="Enter Student Middle Name"></asp:TextBox>&nbsp;
                    <input type="checkbox" id="StudentMiddleName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Student Last Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentlastname" runat="server" placeholder="Enter Student Last Name"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="StudentLastName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Student D.O.B<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentdob" runat="server" placeholder="Select Student D.O.B"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="StudentDOB" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Gender<span style="color: Red;font-weight:bold">*</span></label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistgender" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                            <asp:ListItem Value="2">Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </div> 
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Nationality<span style="color: Red;font-weight:bold">*</span></label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistnationality" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Indian</asp:ListItem>
                            <asp:ListItem Value="2">Other</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                     &nbsp; <input type="checkbox" id="Nationality" checked="checked" style="display:none" />
                </div>
                 <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Birth Place</label>
                    <asp:TextBox ID="txtbirthplace" runat="server" placeholder="Enter Birth place"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="BirthPlace" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Religion<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtreligion" runat="server" placeholder="Enter Religion Please"></asp:TextBox>&nbsp;
                    <input type="checkbox" id="Religion" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mother Tongue</label>
                    <asp:TextBox ID="txtmothertongue" runat="server" placeholder="Enter Mother Tongue"></asp:TextBox>&nbsp;
                    <input type="checkbox" id="MotherTongue" checked="checked" />
                </div>
                  <div class="for_sigle_row_form">
                    <label>
                        No Of Siblings</label>
                    <asp:TextBox ID="TextBox5" runat="server" placeholder="Enter No Of Siblings"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="NoOfSiblings" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Cast/Category<span style="color: Red;font-weight:bold">*</span></label>
                    <div style="width: 350px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistcast" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">General </asp:ListItem>
                            <asp:ListItem Value="2">OBC</asp:ListItem>
                            <asp:ListItem Value="3">SC</asp:ListItem>
                            <asp:ListItem Value="4">ST</asp:ListItem>
                            <asp:ListItem Value="5">Minority</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    &nbsp; <input type="checkbox" id="CastCategory" checked="checked" style="display:none" />
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Applying For Class<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                    </asp:DropDownList>&nbsp;<input type="checkbox" id="ApplyingForClass" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Transportation Required</label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtntransportationrequired" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Yes </asp:ListItem>
                            <asp:ListItem Value="2">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                      &nbsp; <input type="checkbox" id="TransportationRequired" checked="checked" />
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Upload Student Photograph</label>
                    <asp:FileUpload ID="fileuploaderofstudentphotograph" runat="server" />
                      &nbsp; <input type="checkbox" id="StudentPhotograph" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Upload Birth Certificate</label>
                    <asp:FileUpload ID="fileuploaderofbirthcertificate" runat="server" />
                      &nbsp; <input type="checkbox" id="BirthCertificate" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Document Submitted</label>
                    <textarea id="txttotalsubmiteddocument" runat="server" rows="3" cols="3" placeholder="Enter Document Submitted By Student"></textarea>
                      &nbsp; <input type="checkbox" id="DocumentSubmitted" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Additional Information</label>
                    <textarea id="txtadditionalinformation" runat="server" rows="3" cols="3" placeholder="Enter Additional Information"></textarea>
                      &nbsp; <input type="checkbox" id="AdditionalInformation" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Address<span style="color: Red;font-weight:bold">*</span></label>
                    <textarea id="txtaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>
                      &nbsp; <input type="checkbox" id="Address" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtcity" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;
                    <input type="checkbox" id="City" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstate" runat="server" placeholder="Enter State Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="State" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtpiorzipcode" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="Pin" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Country<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtcountry" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="Country" checked="checked" style="display:none" />
                </div>
                <div class="clear"></div>
                 <div class="sub-heading">
                    Student Medical Details
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Blood Group</label>
                    <asp:DropDownList ID="ddlbloodgroup" runat="server">
                        <asp:ListItem Value="0">--Select  Blood Group--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                      <input type="checkbox" id="BloodGroup" checked="checked" />
                </div>
                <div class="clear"></div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Student Previous School Details
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label>
                        School Name</label>
                    <asp:TextBox ID="txtschoolname" runat="server" placeholder="Enter School Name Please"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolName" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Board</label>
                    <asp:TextBox ID="txtboard" runat="server" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolBoard" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Medium</label>
                    <asp:TextBox ID="txtmedium" runat="server" placeholder="Enter Medium Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="SchoolMedium" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Previous Class Name</label>
                    <asp:TextBox ID="txtclassname" runat="server" placeholder="Enter Previous Class Name"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolPreviousClassName" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Percentage In Previous Class</label>
                    <asp:TextBox ID="TextBox4" runat="server" placeholder="Enter Percentage In Previous Class"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="SchoolPercentageInPreviousClass" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Address</label>
                    <textarea ID="txtschooladdress" runat="server" placeholder="Enter Address Please" rows="3" cols="3"></textarea>&nbsp;
                        <input type="checkbox" id="SchoolAddress" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Contact No</label>
                    <asp:TextBox ID="txtcontactno" runat="server" placeholder="Enter Contact No Please"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolContactNo" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Alternate Contact No</label>
                    <asp:TextBox ID="txtalternatecontactno" runat="server" placeholder="Enter Alternate Contact No Please"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolAlternateContactNo" checked="checked" />
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        School Website</label>
                    <asp:TextBox ID="txtwesite" runat="server" placeholder="Enter Website Please"></asp:TextBox>&nbsp;
                        <input type="checkbox" id="SchoolWebsite" checked="checked" />
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Primary Parent Details
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Parent Type</label>
                    <asp:DropDownList ID="ddlparenttype" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                       <input type="checkbox" id="PrimarySelectParentType" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent First Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtparentfirstname" runat="server" placeholder="First Name Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentFirstName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Middle Name</label>
                    <asp:TextBox ID="txtparentmiddlename" runat="server" placeholder="Middle Name Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentMiddleName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Last Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtparentlastname" runat="server" placeholder="Last Name Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentLastName" checked="checked" style="display:none" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent D.O.B</label>
                    <asp:TextBox ID="txtparentdateofbirth" runat="server" placeholder="Select D.O.B Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentDOB" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Nationality</label>
                    <asp:TextBox ID="txtparentnationality" runat="server" placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="PrimaryParentNationality" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Highest Qualification</label>
                   <asp:DropDownList ID="ddlparentqualification" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                       <input type="checkbox" id="PrimaryHighestQualification" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Occupation</label>
                    <asp:TextBox ID="txtparentoccupation" runat="server" placeholder="Occupation Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentOccupation" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtparentdesignation" runat="server" placeholder="Designation Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryDesignation" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name Of Organization</label>
                    <asp:TextBox ID="TextBox1" runat="server" placeholder="Name Of Organization"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryNameOfOrganization" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Address Of Office/Business</label>
                    <asp:TextBox ID="TextBox2" runat="server" placeholder="Address Of Office/Business"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryAddressOfOfficeBusiness" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Annual Income</label>
                    <asp:TextBox ID="TextBox3" runat="server" placeholder="Parent Annual Income"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryParentAnnualIncome" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txtparentaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>&nbsp;
                       <input type="checkbox" id="PrimaryAddress" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtparentcity" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryCity" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtparentstate" runat="server" placeholder="Enter State Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryState" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtparentpincodeorzipcode" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryPinZipCode" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txtparentcountry" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryCountry" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No</label>
                    <asp:TextBox ID="txtparentphoneno" runat="server" placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                       <input type="checkbox" id="PrimaryPhoneNo " checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mobile No</label>
                    <asp:TextBox ID="txtparentmobileno" runat="server" placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="PrimaryMobileNo" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Email-Id</label>
                    <asp:TextBox ID="txtparentemailid" runat="server" placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;
                                           <input type="checkbox" id="PrimaryEmailId" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Upload Parent Photograph</label>
                    <asp:FileUpload ID="fileuploaderofparentphotograph" runat="server" />&nbsp;
                                           <input type="checkbox" id="PrimaryUploadParentPhotograph" checked="checked" />
                </div>


                 <div class="clear"></div>
                <div class="sub-heading">
                    Secondary Parent Details
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Parent Type</label>
                    <asp:DropDownList ID="ddlsecondaryparenttype" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                      <input type="checkbox" id="SecondarySelectParentType" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent First Name</label>
                    <asp:TextBox ID="txtsecondaryparentfirstname" runat="server" Placeholder="Enter First Name Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="SecondaryParentFirstName" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Middle Name</label>
                    <asp:TextBox ID="txtsecondaryparentmiddlename" runat="server" Placeholder="Enter Middle Name Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryParentMiddleName" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Last Name</label>
                    <asp:TextBox ID="txsecondaryparentlastname" runat="server" Placeholder="Enter Last Name Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryParentLastName" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent D.O.B</label>
                    <asp:TextBox ID="txtsecondaryparentdateofbirth" runat="server" Placeholder="Select D.O.B"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="SecondaryParentDOB" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Nationality</label>
                    <asp:TextBox ID="txtsecondaryparentnationality" runat="server" Placeholder="Enter Nationality Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryParentNationality" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Highest Qualification</label>
                   <asp:DropDownList ID="ddlsecondaryparenthighestqualification" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                      <input type="checkbox" id="SecondaryHighestQualification" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Occupation</label>
                    <asp:TextBox ID="txtsecondaryparentoccupation" runat="server" Placeholder="Enter Occupation Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryParentOccupation" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtsecondaryparentdesignation" runat="server" Placeholder="Enter Designation Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryDesignation" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name Of Organization</label>
                    <asp:TextBox ID="txtnameoforganizationofsecondayparent" runat="server" Placeholder="Enter Name Of Organization"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryNameOfOrganization" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Address Of Office/Business</label>
                    <textarea ID="txtbusinessorofficeaddressofsecondayparent" runat="server" rows="3" cols="3" Placeholder="Address Of Office/Business"></textarea>&nbsp;
                     <input type="checkbox" id="SecondaryAddressOfOfficeBusiness" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Parent Annual Income</label>
                    <asp:TextBox ID="txtsecondaryparentannualincome" runat="server" Placeholder="Annual Income Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryParentAnnualIncome" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txsecondayparentaddress" runat="server" rows="3" cols="3" Placeholder="Enter Address Please"></textarea> &nbsp;
                      <input type="checkbox" id="SecondaryAddress" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtsecondaryparentcity" runat="server" Placeholder="Enter City Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryCity" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtsecondaryparentstate" runat="server" Placeholder="Enter State Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryState" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtsecondayparentpinorzipcode" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="SecondaryPinZipCode" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txsecondaryparentcountry" runat="server" Placeholder="Enter Country Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryCountry" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No</label>
                    <asp:TextBox ID="txtsecondaryparentphoneno" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="SecondaryPhoneNo" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mobile No</label>
                    <asp:TextBox ID="txtsecondaryparentmobileno" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="SecondaryMobileNo" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Email-Id</label>
                    <asp:TextBox ID="txtsecondaryparentemailid" runat="server" Placeholder="Enter Email-Id Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="SecondaryEmailId" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Upload Parent Photograph</label>
                    <asp:FileUpload ID="fileuploadforsecondaryparentphotograph" runat="server" />&nbsp;
                      <input type="checkbox" id="SecondaryUploadParentPhotograph" checked="checked" />
                </div>
                  <div class="clear"></div>
                <div class="sub-heading">
                   Emergency Contact Person (OTHER THAN PARENTS)
                </div>
                  <div class="clear"></div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Name</label>
                    <asp:TextBox id="txtnameofcontactpersonincaseofemergency" runat="server" Placeholder="Enter Name Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="EmergencyName" checked="checked" />
                </div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Mobile No</label>
                    <asp:TextBox id="txtemergencymobileno" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="EmergencyMobileNo" checked="checked" />
                </div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Alternate Mobile No</label>
                    <asp:TextBox id="txtemergencyalternatemobileno" runat="server" Placeholder="Enter Alternate Mobile No Please"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="EmergencyAlternateMobileNo" checked="checked" />
                </div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Phone No</label>
                    <asp:TextBox id="txtemegencycontactpersonphoneno" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="EmergencyPhoneNo" checked="checked" />
                </div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txtemergencycontactpersonaddress" runat="server" rows="3" cols="3" Placeholder="Enter Address"></textarea>&nbsp;
                     <input type="checkbox" id="EmergencyAddress" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City</label>
                    <asp:TextBox ID="txtemergencycontactpersoncity" runat="server" Placeholder="Enter City"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="EmergencyCity" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State</label>
                    <asp:TextBox ID="txtemergencycontactpersonstate" runat="server" Placeholder="Enter State"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="EmergencyState" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code</label>
                    <asp:TextBox ID="txtemergencycontactpersonpinorzipcode" runat="server" Placeholder="Enter Pin/Zip Code"></asp:TextBox>&nbsp;
                     <input type="checkbox" id="EmergencyPinZipCode" checked="checked" />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Country</label>
                    <asp:TextBox ID="txtemergencycontactpersoncountry" runat="server" Placeholder="Enter Country"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="EmergencyCountry" checked="checked" />
                </div>
                                <div class="sub-heading">
                    Registration Fee Details
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Registration Fee</label>
                    <asp:TextBox ID="txtregistrationfee" runat="server" Placeholder="Enter Registration Fee"></asp:TextBox>&nbsp;    
                     <input type="checkbox" id="RegistrationFee" checked="checked" />                 
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Payment Mode</label>
                    <asp:DropDownList ID="ddlpaymentmode" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem Value="2">Cheque</asp:ListItem>
                        <asp:ListItem Value="3">DD</asp:ListItem>
                        <asp:ListItem Value="4">NEFT</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                    <input type="checkbox" id="PaymentMode" checked="checked" /> 
                </div>
                <div class="for_sigle_row_form" id="divbankname" style="display:none">
                    <label>
                        Bank Name</label>
                    <asp:TextBox ID="txtchkddneftbankname" runat="server" Placeholder="Enter Bank Name"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divbranchname" style="display:none">
                    <label>
                        Branch Name</label>
                    <asp:TextBox ID="txtchkddneftbranchname" runat="server" Placeholder="Enter Branch Name"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divrefnumber" style="display:none">
                    <label>
                        Cheque Number</label>
                    <asp:TextBox ID="txtchkddneftrefno" runat="server" Placeholder="Enter Cheque Number"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divrefdate" style="display:none">
                    <label>
                        Cheque Date</label>
                    <asp:TextBox ID="txtchkddneftrefdate" runat="server" Placeholder="Enter Cheque Date"></asp:TextBox>&nbsp;                     
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    For Office Use Only
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Registration Date<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtregistrationdate" runat="server" Placeholder="Select Registration Date"></asp:TextBox>&nbsp;
                      <input type="checkbox" id="RegistrationDate" checked="checked" style="display:none" />
                </div>
                  <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Comment</label>
                    <textarea id="txtcomment" runat="server" rows="3" cols="3" Placeholder="Your Comment Please"></textarea>&nbsp;
                     <input type="checkbox" id="Comment" checked="checked" style="display:none" />
                </div>
                <div class="clear"></div>
                <br />
                <br />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            BindFieldOnTheBehalfOfCheckUnCheck();
            $('input[type="checkbox"]').change(function () {
                var value = 0, ColumnName = '';
                if ($(this).prop('checked') == true)
                    value = 1;
                ColumnName = $(this).attr('id');
                $.ajax({
                    type: "POST",
                    url: "add-new-registration.aspx/AddOrRemovePermission",
                    data: "{'value':'" + value + "','ColumnName':'" + ColumnName + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (parseInt(data.d) == 1) {
                            if (value == 1)
                                alertify.success('Field Added Successfully.!!!!');
                            else
                                alertify.error('Field Removed Successfully.!!!!');
                        }
                        else
                            alertify.error('Some Issue Here.!!!!');
                    },
                });
            });
        });
        function BindFieldOnTheBehalfOfCheckUnCheck() {
            $.ajax({
                type: "POST",
                url: "add-new-registration.aspx/CheckCheckboxOnTheBehalfOfPermission",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        if (value.CheckStatus == 'false') {
                            $('#' + value.ColumnName + '').prop("checked", false);
                        }
                    });            
                },
            });
        }
    </script>
</asp:Content>