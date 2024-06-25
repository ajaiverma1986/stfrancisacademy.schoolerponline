<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="new-provisional-admission.aspx.cs" Inherits="BranchPanel_ProvisionalAdmission_new_provisional_admission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Provisional Admission</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        General Information
                    </div>
                    <div class="for_sigle_row_form" id="AdmissionNo" style="display: none">
                        <label>
                            Admission No.</label>
                        <asp:TextBox ID="txtadmissionreferenceno" runat="server" MaxLength="15" placeholder="Enter Admission No If Exists"></asp:TextBox>&nbsp;
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
                            Student Last Name<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtstudentlastname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Last Name"></asp:TextBox>&nbsp;
                    </div>
                    <div class="for_sigle_row_form" id="StudentDOB">
                        <label>
                            Select Student D.O.B<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtstudentdob" onchange="CalculateAge(this)" onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;
                    <span id="lblAge" style="font-weight: bold; color: red"></span>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class For Admission<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
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
                            Parent Last Name<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtparentlastname" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Last Name Please"></asp:TextBox>&nbsp;
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
                    <div class="for_sigle_row_form" id="PrimaryMobileNo">
                        <label>
                            Mobile No</label>
                        <asp:TextBox ID="txtparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                    </div>
                    <div class="clear"></div>
                    <div id="not_editable" runat="server">
                        <div class="sub-heading">
                            Provisional Admission Fee Details
                        </div>
                        <div class="for_sigle_row_form" id="RegistrationFee">
                            <label>
                                Paid Fee<span style="color: Red; font-weight: bold">*</span></label>
                            <asp:TextBox ID="txtregistrationfee" onkeypress="return false" runat="server" Placeholder="Enter Paid Fee"></asp:TextBox>&nbsp;
                        </div>
                        <div class="for_sigle_row_form" id="PaymentMode">
                            <label>
                                Payment Mode<span style="color: Red; font-weight: bold">*</span></label>
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
                                Provisional Admission Date<span style="color: Red; font-weight: bold">*</span></label>
                            <asp:TextBox ID="txtregistrationdate" onkeypress="return false" runat="server" Placeholder="Select Provisional Admission Date"></asp:TextBox>&nbsp;
                        </div>
                        <div class="for_sigle_row_form" id="Comment">
                            <label style="padding-top: 4px;">
                                Comment</label>
                            <textarea id="txtcomment" runat="server" rows="3" cols="3" placeholder="Your Comment Please"></textarea>&nbsp;
                        </div>
                    </div>
                    <div class="for_sigle_row_form" style="margin-bottom:10px">
                        <label style="padding-top: 4px;">
                            Save/Update</label>
                        <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" OnClick="btnforupdateorsave_Click" CssClass="button_save" />
                        <asp:Button ID="btnforcancel" runat="server" Text="Cancel" OnClick="btnforcancel_Click" CssClass="button_cancel" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var year = 2015;
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_txtstudentdob").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            })
            $("#ctl00_ContentPlaceHolder1_txtregistrationdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());
            $("#ctl00_ContentPlaceHolder1_txtchkddneftrefdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                maxDate: new Date()
            }).datepicker("setDate", new Date());
        });
    </script>
</asp:Content>