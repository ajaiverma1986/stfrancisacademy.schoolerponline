<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="addstudent.aspx.cs" Inherits="BranchPanel_SummerTraning_addstudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
             <div class="new-registration">
            <div class="sub-heading">
                    Student Information
                </div> 
                  <div class="for_sigle_row_form">
                    <label>
                        Registration No(If Apllicable)</label>
                    <asp:TextBox ID="txtregistrationno" runat="server" MaxLength="15" placeholder="Enter Reference Registration No If Exists" OnTextChanged="txtregistrationno_TextChanged" AutoPostBack="true"></asp:TextBox>&nbsp;                  
                </div>
                  <div class="for_sigle_row_form" id="RegistrationSession">
                    <label>
                        Summer Camp Session<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlsession" runat="server" OnSelectedIndexChanged="ddlsession_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="Div1">
                    <label>
                        Class</label>
                    <asp:DropDownList ID="ddlclass" runat="server">
                        <asp:ListItem Value="0">--Select Class--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="AdmissionNo">
                    <label>
                        Admission No.(For Reference)</label>
                    <asp:TextBox ID="txtadmissionreferenceno" runat="server" MaxLength="15" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form"  id="StudentFirstName">
                    <label>
                        Student First Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentfirstname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student First Name"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="StudentMiddleName">
                    <label>
                        Student Middle Name</label>
                    <asp:TextBox ID="txtstudentmiddlename" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Middle Name"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="StudentLastName">
                    <label>
                        Student Last Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentlastname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Student Last Name"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="StudentDOB">
                    <label>
                        Select Student D.O.B<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentdob"   onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="Gender">
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
                 <div class="sub-heading">
                    Student Contact Details
                </div>
                 <div class="for_sigle_row_form" id="Div2">
                    <label style="padding-top: 4px;">
                        Parent Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtpname" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter Parent Name"></asp:TextBox>&nbsp;                 
                </div>
                 <div class="for_sigle_row_form" id="Div3">
                    <label style="padding-top: 4px;">
                        Parent Mobile No.<span style="color: Red;font-weight:bold">*</span></label>
                   <asp:TextBox ID="txtpmobile" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter Parent Mobile No. Please"></asp:TextBox>&nbsp;                     
                </div>
                 <div class="for_sigle_row_form" id="Address">
                    <label style="padding-top: 4px;">
                        Address<span style="color: Red;font-weight:bold">*</span></label>
                    <textarea id="txtaddress" runat="server" rows="3" cols="3" placeholder="Enter Address Please"></textarea>                     
                </div>
                <div class="for_sigle_row_form" id="City">
                    <label>
                        City<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtcity" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter City Please"></asp:TextBox>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="State">
                    <label>
                        State<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstate" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter State Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="Pin">
                    <label>
                        Pin/Zip Code<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtpiorzipcode" onkeypress="return isNumberKey(event)" MaxLength="6" runat="server" placeholder="Enter Pin/Zip Code Please"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="Country">
                    <label>
                        Country<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtcountry" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" placeholder="Enter Country Please"></asp:TextBox>&nbsp;                     
                </div>
                 <div class="sub-heading">
                   Emergency Contact Person (OTHER THAN PARENTS)
                </div>
                  <div class="clear"></div>
                  <div class="for_sigle_row_form" id="EmergencyName">
                    <label style="padding-top: 4px;">
                        Name</label>
                    <asp:TextBox id="txtnameofcontactpersonincaseofemergency" onkeypress="return lettersOnly(event)" MaxLength="25" runat="server" Placeholder="Enter Name Please"></asp:TextBox>&nbsp;                  
                </div>
                  <div class="for_sigle_row_form" id="EmergencyMobileNo">
                    <label style="padding-top: 4px;">
                        Mobile No</label>
                    <asp:TextBox id="txtemergencymobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;                  
                </div>
                  <div class="for_sigle_row_form" id="EmergencyAlternateMobileNo">
                    <label style="padding-top: 4px;">
                        Alternate Mobile No</label>
                    <asp:TextBox id="txtemergencyalternatemobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Alternate Mobile No Please"></asp:TextBox>&nbsp;                   
                </div>
                  <div class="for_sigle_row_form" id="EmergencyPhoneNo">
                    <label style="padding-top: 4px;">
                        Phone No</label>
                    <asp:TextBox id="txtemegencycontactpersonphoneno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" Placeholder="Enter Phone No Please"></asp:TextBox>&nbsp;       
                </div>
                  <div class="for_sigle_row_form" id="EmergencyAddress">
                    <label style="padding-top: 4px;">
                        Address</label>
                    <textarea id="txtemergencycontactpersonaddress" runat="server" rows="3" cols="3" Placeholder="Enter Address"></textarea>&nbsp;                   
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

                <div id="not_editable" runat="server">
                <div class="sub-heading">
                    Fee Details
                </div>
                    <div class="for_sigle_row_form" id="FeeType">
                    <label>
                        Payment Mode<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlFeeType" runat="server">
                        <asp:ListItem Value="--Select One--">--Select One--</asp:ListItem>
                        <asp:ListItem Value="Form Selling">Form Selling</asp:ListItem>
                        <asp:ListItem Value="Tc Fee">Tc Fee</asp:ListItem>
                        <asp:ListItem Value="Miscellaneous Fee">Miscellaneous Fee</asp:ListItem>
                        
                    </asp:DropDownList>&nbsp;
                </div>
                    <div class="for_sigle_row_form" id="RegistrationDate">
                    <label>
                       Date<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtregistrationdate" onkeypress="return false" runat="server" Placeholder="Select Registration Date"></asp:TextBox>&nbsp;                    
                </div>
                    <div class="for_sigle_row_form" id="RegistrationFee">
                    <label>
                        Fee<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtregistrationfee" onkeypress="return true" runat="server" Placeholder="Enter Registration Fee"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="PaymentMode">
                    <label>
                        Payment Mode<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlpaymentmode" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem Value="2">Cheque</asp:ListItem>
                        <asp:ListItem Value="3">DD</asp:ListItem>
                        <asp:ListItem Value="4">NEFT</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                </div>
                    <asp:HiddenField ID="SSCID"  runat="server"/>
                <div class="for_sigle_row_form" id="divbankname" style="display:none" runat="server">
                    <label>
                        Bank Name</label>
                    <asp:TextBox ID="txtchkddneftbankname" runat="server" MaxLength="25" Placeholder="Enter Bank Name"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divbranchname" style="display:none" runat="server">
                    <label>
                        Branch Name</label>
                    <asp:TextBox ID="txtchkddneftbranchname" MaxLength="25" runat="server" Placeholder="Enter Branch Name"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divrefnumber" style="display:none" runat="server">
                    <label>
                        Cheque Number</label>
                    <asp:TextBox ID="txtchkddneftrefno" MaxLength="25" runat="server" Placeholder="Enter Refrence Number"></asp:TextBox>&nbsp;                     
                </div>
                <div class="for_sigle_row_form" id="divrefdate" style="display:none" runat="server">
                    <label>
                        Cheque Date</label>
                    <asp:TextBox ID="txtchkddneftrefdate" onkeypress="return false" runat="server" Placeholder="Enter Refrence Date"></asp:TextBox>&nbsp;                     
                </div>
                
                  <div class="for_sigle_row_form" id="Comment">
                    <label style="padding-top: 4px;">
                        Comment</label>
                    <textarea id="txtcomment" runat="server" rows="3" cols="3" Placeholder="Your Comment Please"></textarea>&nbsp;                   
                </div>
                     <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Save/Update</label>
                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" OnClick="btnforupdateorsave_Click" CssClass="button_save" /> 
                     <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />               
                </div>
                    </div>
                <div class="clear"></div>
                 </div> 
             </div>
         </div>
    <script type="text/javascript">
        var year = 2022;
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').change(function () {
                if (parseInt($(this).val()) > 1)
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'block');
                else
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'none');
            });
            $("#ctl00_ContentPlaceHolder1_txtstudentdob,#ctl00_ContentPlaceHolder1_txtregistrationdate,#ctl00_ContentPlaceHolder1_txtchkddneftrefdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + year,
                dateFormat: 'dd MM yy'
            });
            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function () {

                if ($('#ctl00_ContentPlaceHolder1_txtstudentfirstname').val() == "") {
                    alertify.error("Please Enter First Name");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtstudentlastname').val() == "") {
                    alertify.error("Please Enter last Name");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtstudentdob').val() == "") {
                    alertify.error("Please Enter Student DOB");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtpname').val() == "") {
                    alertify.error("Please Enter Parent Name");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtpmobile').val() == "") {
                    alertify.error("Please Enter Parent Mobile Number");
                    $(this).focus();
                    return false;
                }
                if ($("#ctl00_ContentPlaceHolder1_txtaddress").val() == "") {
                    alertify.error("Please EnterAddress");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtcity').val() == "") {
                    alertify.error("Please Enter City");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtstate').val() == "") {
                    alertify.error("Please Enter State");
                    $(this).focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtpiorzipcode').val() == "") {
                    alertify.error('Enter pincode/zipcode please.');
                    $(this).focus();
                    return false;
                }
                
                if ($('#ctl00_ContentPlaceHolder1_txtcountry').val() == '') {
                    alertify.error('Enter country please.');
                    $(this).focus();
                    return false;
                }

                if ($('#ctl00_ContentPlaceHolder1_ddlFeeType').val() == '--Select One--') {
                    alertify.error('Select Fee type.');
                    $('#ctl00_ContentPlaceHolder1_ddlFeeType').focus();
                    return false;
                }
            });
            $('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                if ($(this).val()>0) {
                    getfee();
                }
            });
        });

        function BindPaymentMode(paymentModeID) {
            if (parseInt(paymentModeID) > 1)
                $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'block');
            else
                $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'none');
        }

        function getfee() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "addstudent.aspx/ClassSummerCampFee",
                data: "{'Classid':'" + $('#ctl00_ContentPlaceHolder1_ddlclass').val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlsession').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    
                    if (data.d > 0) {
                        $('#ctl00_ContentPlaceHolder1_txtregistrationfee').val(data.d);
                    }
                }
            });
        }
    </script>
</asp:Content>

