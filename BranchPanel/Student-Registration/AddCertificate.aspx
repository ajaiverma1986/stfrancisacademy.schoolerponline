<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AddCertificate.aspx.cs" Inherits="BranchPanel_Student_Registration_AddCertificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
            .new-registration .for_sigle_row_form label 
            {
            width: 400px;
            }
    </style>
    <script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
     <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Student Information
                <asp:Button ID="Button1" runat="server" Text="BACK" PostBackUrl="#" CssClass="button_cancel" style="float:right; margin-right: 20px; margin-top: -2px; width:70px;" OnClick="Button1_Click" />                     
                </div>  
                <div class="for_sigle_row_form" id="dis" runat="server" visible="false">
                    <label>
                        Discount Code</label>
                    <asp:TextBox ID="txtdiscountcode" runat="server" MaxLength="15" placeholder="Enter Discount Code If Exists" OnTextChanged="txtdiscountcode_TextChanged" AutoPostBack="true"  ></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="divBookNo" runat="server">
                    <label>Book No. </label>
                    <asp:TextBox ID="txtBookNo" runat="server" MaxLength="15" placeholder="Enter Book No" ></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form" id="Div1" runat="server">
                    <label>
                        SR. No. </label>
                    <asp:TextBox ID="txtTCNo" runat="server" MaxLength="50" placeholder="Enter TC No" ></asp:TextBox>&nbsp;                  
                </div>

                 <div class="for_sigle_row_form" id="RegistrationSession">
                    <label>
                        Admission Session<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                <div class="clear"></div>  

                <div class="for_sigle_row_form">
                    <label>
                        Registration No</label>
                    <asp:TextBox ID="txtregistrationno" runat="server" MaxLength="50" placeholder="Enter Reference Registration No If Exists" OnTextChanged="txtregistrationno_TextChanged" AutoPostBack="true"></asp:TextBox>&nbsp;                  
                </div>
                 <div class="for_sigle_row_form" id="AdmissionNo" style="display:none">
                    <label>
                        Admission No.</label>
                    <asp:TextBox ID="txtadmissionreferenceno" runat="server" MaxLength="50" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                </div>
                                 
               
                 <div class="for_sigle_row_form" id="StudentOldRegNo">
                    <label>
                        Reference Registration No</label>
                    <asp:TextBox ID="txtOldRegNo" runat="server" MaxLength="50" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                </div>                 
                <div class="for_sigle_row_form"  id="StudentFirstName">
                    <label>
                        Student's Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentfirstname" onkeypress="return lettersOnly(event)" MaxLength="40" runat="server" placeholder="Enter Student First Name"></asp:TextBox>&nbsp;                   
                </div>
                 <div class="for_sigle_row_form" id="SecondaryParentFirstName">
                    <label>
                        Mother's Name</label>
                    <asp:TextBox ID="txtsecondaryparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="45" runat="server" Placeholder="Enter First Name Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentFirstName">
                    <label>
                        Father's Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtparentfirstname" onkeypress="return lettersOnly(event)" MaxLength="40" runat="server" placeholder="First Name Please"></asp:TextBox>&nbsp;                      
                </div>
                <div class="clear"></div>                
                <div class="for_sigle_row_form" id="StudentDOB">
                    <label>
                        Select Student D.O.B<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentdob" onchange="CalculateAge(this)"  onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;          
                    <span id="lblAge" style="font-weight: bold; color: red"></span>              
                </div>
                <div class="for_sigle_row_form" id="Nationality">
                    <label style="padding-top: 4px;">
                        Nationality<span style="color: Red;font-weight:bold">*</span></label>
                    <div style="width: 171px; height: 20px; float: left;">
                        <asp:RadioButtonList runat="server" ID="rbtnlistnationality" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                            <asp:ListItem Value="1" Selected="True">Indian</asp:ListItem>
                            <asp:ListItem Value="2">Other</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>                    
                </div>
                <div class="clear"></div>
               <div class="for_sigle_row_form" id="CastCategory">
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
                </div>
                <div class="clear"></div>               
                <div class="for_sigle_row_form" id="DateOfAdm">
                    <label>
                        Date of Admission<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtRegisDate" onchange="CalculateAge(this)"  onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;          
                    <span id="lblDateOfAdm" style="font-weight: bold; color: red"></span>              
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form" id="SchoolName">
                    <label>
                       School/Board Annual Examination last taken with result</label>
                    <asp:TextBox ID="txtschoolname" runat="server" onkeypress="return lettersOnly(event)" MaxLength="50" placeholder="Enter School Name Please"></asp:TextBox>&nbsp;                     
                </div>
                 <div class="for_sigle_row_form" id="SchoolBoard">
                    <label>
                       Class </label>
                    <asp:TextBox ID="txtboard" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Failed">
                    <label>
                        Whether Failed : It's so once/twice in the same class</label>
                    <asp:TextBox ID="txtPassFailed" runat="server" MaxLength="50" placeholder="Enter Class Name Please"></asp:TextBox>&nbsp;                       
                </div>
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Subject">
                    <label>
                        Subject Studied</label>
                    <asp:TextBox ID="txtSubject" runat="server" MaxLength="100" placeholder="Enter Subjects Name Please"></asp:TextBox>&nbsp;                       
                </div> 
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="QualifiedOrPromotion">
                    <label>
                       Whether qualified for promotion to the higher class if so, to which class</label>
                    <asp:TextBox ID="txtClass" runat="server" MaxLength="25" placeholder="Enter Class Name Please"></asp:TextBox>&nbsp;                       
                </div> 
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="DuePaid">
                    <label>
                        Month Upto Which the School Dues Paid</label>
                    <asp:TextBox ID="txtDuePaid" runat="server" MaxLength="25" placeholder="Enter Due Month Please"></asp:TextBox>&nbsp;                       
                </div>  
                
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Concession">
                    <label>
                        Any Fee Concession Name</label>
                    <asp:TextBox ID="txtConcession" runat="server" MaxLength="25" placeholder="Enter Concession Name Please"></asp:TextBox>&nbsp;                       
                </div> 
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="TotalWorking">
                    <label>
                        No. of meeting up to date</label>
                    <asp:TextBox ID="txtTotalNodays" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>   
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="TotalPresent">
                    <label>
                        No. of school days the pupil attendded</label>
                    <asp:TextBox ID="txtPresentDays" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>   
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="NCC">
                    <label>
                        NCC</label>
                    <asp:TextBox ID="txtNcc" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>             
            <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Games">
                    <label>
                        Co circullar activities in which the pupil took part</label>
                    <asp:TextBox ID="txtGames" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>  
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Conduct">
                    <label>
                        General Conduct</label>
                    <asp:TextBox ID="txtConduct" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>    
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="DateOfApp">
                    <label>
                        Date of Aplication for Certification<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtDor" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>    
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="issueCerti">
                    <label>
                        Date of  Issue of Certification<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtDoi" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>  
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="LeavingSchool">
                    <label>
                        Reason of Leaving the School</label>
                    <asp:TextBox ID="txtLeave" runat="server" MaxLength="25" placeholder="Enter Board Name Please"></asp:TextBox>&nbsp;                       
                </div>  
                <div class="clear"></div>   
                 <div class="for_sigle_row_form" id="Remarks">
                    <label>
                        Any Other Remarks</label>
                    <textarea id="txtRemarks" runat="server" rows="3" cols="3" Placeholder="Your Comment Please"></textarea>&nbsp; 
                </div>             
           
                  <div class="for_sigle_row_form" id="Comment" runat="server" visible="false">
                    <label style="padding-top: 4px;">
                        Comment</label>
                    <textarea id="txtcomment" runat="server" rows="3" cols="3" Placeholder="Your Comment Please"></textarea>&nbsp;                   
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
          <asp:Label ID="lblStudentPhotograph"  Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label> 
          <asp:Label ID="lblStudentcertificate"  Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label> 
          <asp:Label ID="lblparentfirstphoto"  Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label> 
          <asp:Label ID="lblparentsecondphoto"  Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label> 
    </div>
         </div>
    <script type="text/javascript">
        var year = 2020;
        $(document).ready(function () {
            BindFieldOnTheBehalfOfCheckUnCheck();
            Expende();
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
            $("#ctl00_ContentPlaceHolder1_txtstudentdob,#ctl00_ContentPlaceHolder1_txtRegisDate,#ctl00_ContentPlaceHolder1_txtDor,#ctl00_ContentPlaceHolder1_txtDoi,#ctl00_ContentPlaceHolder1_txtchkddneftrefdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2020',
                dateFormat: 'dd MM yy'
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
            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() == '0') {
                    alertify.error('Select admission  session please.');
                    $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentfirstname').val() == '') {
                    alertify.error('Enter student first name please.');
                    $('#ctl00_ContentPlaceHolder1_txtstudentfirstname').focus();
                    return false;
                }
                    //else if ($('#ctl00_ContentPlaceHolder1_txtstudentlastname').val() == '') {
                    //    alertify.error('Enter student middle name please');
                    //    $('#ctl00_ContentPlaceHolder1_txtstudentlastname').focus();
                    //    return false;
                    //}
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentdob').val() == '') {
                    alertify.error('Select Date of birth please,');
                    $('#ctl00_ContentPlaceHolder1_txtstudentdob').focus();
                    return false;
                }
                    //else if ($('#ctl00_ContentPlaceHolder1_txtstudentUid').val() == '') {
                    //    alertify.error('Enter Student Aadhaar Car No.');
                    //    $('#ctl00_ContentPlaceHolder1_txtstudentUid').focus();
                    //    return false;
                    //}
                else if ($('#ctl00_ContentPlaceHolder1_txtDor').val() == '') {
                    alertify.error('Enter Date of Aplication for Certification');
                    $('#ctl00_ContentPlaceHolder1_txtDor').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtDoi').val() == '') {
                    alertify.error('Enter Date of Issue Certification');
                    $('#ctl00_ContentPlaceHolder1_txtDoi').focus();
                        return false;
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
                else if ($('#ctl00_ContentPlaceHolder1_txtregistrationdate').val() == '') {
                    alertify.error('Select admission date please.');
                    $('#ctl00_ContentPlaceHolder1_txtregistrationdate').focus();
                    return false;
                }
            });
            $('#ctl00_ContentPlaceHolder1_ddlpaymentmode').change(function () {
                if (parseInt($(this).val()) > 1)
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'block');
                else
                    $('#ctl00_ContentPlaceHolder1_divbankname,#ctl00_ContentPlaceHolder1_divbranchname,#ctl00_ContentPlaceHolder1_divrefnumber,#ctl00_ContentPlaceHolder1_divrefdate').css('display', 'none');
            });
            $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').change(function () {
                $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "../Student-Registration/student-registration.aspx/BindClassDDL",
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
                $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "new-admission.aspx/BindSectionDDL",
                    data: "{'Classid':'" + $(this).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddlsection').html('<option value="0">--Select Section--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                            }
                        }
                    }
                });
            });
            $('#ctl00_ContentPlaceHolder1_txtregistrationdate').change(function () {
                $.ajax({
                    type: "POST",
                    url: "new-admission.aspx/IsReadyForAction",
                    data: "{'Date':'" + $(this).val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "','Registration_No':'" + $('#ctl00_ContentPlaceHolder1_txtregistrationno').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != '1') {
                            if (data.d == '0') {
                                $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                                alert('Admission Process Is Off For The Selected Session And Admission Date.\nPlease Select Valid Session And Admission Date.\nOR Contact To Admin.');
                            }
                            else if (data.d == '2') {
                                $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                                alert('Only Shortlisted Candidate Can Take The Admission.\nOR Contact To Admin.');
                            }
                            else if (data.d == '3') {
                                $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                                alert('Admission Can Be Done If Student Is Registered.\nSo Please Enter The Registration No.\nOR Contact To Admin.');
                            }
                            else if (data.d == '4') {
                                $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                                alert('Registered Student Can Not Take The Admission.\nContact To Admin.');
                            }
                            else if (data.d == '5') {
                                $('#ctl00_ContentPlaceHolder1_txtregistrationdate').val('');
                                alert('Admission Can Be Done If Student Is Registered.\nSo Please Enter The Registration No.\nOR Contact To Admin.');
                            }
                        }
                    },
                });
            });

            $('input[type="radio"][name="ctl00$ContentPlaceHolder1$rbtntransportationrequired"]').change(function () {
                if ($(this).val() == '1') {
                    alert('You Can Decide The Route Or Stopage For Transportaion Facility From.\nStudent Management Module.');
                }
            });

        });

        
        function ShowpImagePreviewstudentphotograph(input) {

            $('#stuphotograph').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_imguser').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImagePreviewshowbirthcertificate(input) {
            $('#stucertifiacte').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_Image1').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotograph(input) {
            $('#parentfirstphoto').show();
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ctl00_ContentPlaceHolder1_Image2').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function ShowpImageParentphotographsecond(input) {
            $('#secondaryparentphoto').show();
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
                url: "new-admission.aspx/CheckCheckboxOnTheBehalfOfPermission",
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
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "none");
        }
        function Expende() {
            $('#AdmissionNo,#StudentMiddleName,#BirthPlace,#MotherTongue,#NoOfSiblings,#DocumentSubmitted,#AdditionalInformation,#BirthCertificate,#BloodGroup' +
            ',#SchoolName,#SchoolBoard,#SchoolMedium,#SchoolPreviousClassName,#SchoolPercentageInPreviousClass,#SchoolAddress,#SchoolContactNo,#SchoolAlternateContactNo,#SchoolWebsite' +
            ',PrimaryParentDOB,#PrimaryParentNationality,#PrimaryHighestQualification,#PrimaryParentOccupation,#PrimaryDesignation,#PrimaryNameOfOrganization,#PrimaryAddressOfOfficeBusiness,#PrimaryParentAnnualIncome,#PrimaryAddress,#PrimaryCity,#PrimaryState,#PrimaryPinZipCode,#PrimaryCountry,#PrimaryPhoneNo,#PrimaryEmailId,#PrimaryParentDOB,#PrimaryUploadParentPhotograph' +
            ',#SecondarySelectParentType,#SecondaryParentFirstName,#SecondaryParentMiddleName,#SecondaryParentLastName,#SecondaryParentDOB,#SecondaryParentNationality,#SecondaryHighestQualification,#SecondaryParentOccupation,#SecondaryDesignation,#SecondaryNameOfOrganization,SecondaryAddressOfOfficeBusiness,SecondaryParentAnnualIncome,#SecondaryAddress,#SecondaryCity,#SecondaryState,#SecondaryPinZipCode,#SecondaryCountry,#SecondaryPhoneNo,#SecondaryMobileNo,#SecondaryEmailId,#SecondaryUploadParentPhotograph,#SecondaryAddressOfOfficeBusiness,#SecondaryParentAnnualIncome' +
            ',#EmergencyName,#EmergencyMobileNo,#EmergencyAlternateMobileNo,#EmergencyPhoneNo,#EmergencyAddress,#EmergencyCity, EmergencyState,#EmergencyPinZipCode,#EmergencyCountry,#EmergencyState' +
            ',#Comment').css("display", "block");
        }
        function CalculateAge() {
            var chunks = $('#ctl00_ContentPlaceHolder1_txtstudentdob').val().split(' ');
            var CalculateDate = chunks[2] + '-' + chunks[1] + '-' + chunks[0];
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Student-Registration/student-registration.aspx/GetYearMonthDate",
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