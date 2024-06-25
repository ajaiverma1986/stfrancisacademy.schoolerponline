<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="AddLastYearFee.aspx.cs" Inherits="BranchPanel_Fee_Management_AddLastYearFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>--%>
     <div class="content_pane_cont input_content" id="contentPane">
         <div class="grid-data-resposive">
              <div class="sub-heading">
                    Student Information
                <img src="../../images/Expend.png" id="btnAdd" title="Click here to expend or collapse all field." style="float:right; margin-right: 20px; margin-top: -2px; width: 20px;" alt="No Image" />            
                 <%-- <img src="../../images/fee-payment.png" id="btnPay" title="Click here to expend or collapse all field." style="float:right; margin-right: 20px; margin-top: -2px; width: 120px;" alt="No Image" />            --%>
                  </div>
             <div class="for_sigle_row_form">
                    <label>
                        Admission Session<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlFyid" runat="server">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
             <br />
             <div class="divforstm">
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Registration Date</th>
                    <th align="center">Registration No</th>      
                    <th align="center">Admission No</th>                               
                    <th align="center">Student Name</th>
                    <th align="center">Parent Name</th>                    
                    <th align="center">Parent Mob No</th>
                    <th align="center">Class</th>                    
                    <th align="center">Section</th>
                    <th align="center">Amt</th>
                    <th align="center">Bal Amt</th>
                    <th align="center">Pay Status</th>    
                    <th align="center">Edit Detail</th>                      
                    <th align="center">Pay Fee</th>                                
                </tr>
            </table>              
            </div>
            <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry No Record found.</label>
        </div>
    </div>
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Student Information
                <img src="../../images/Expend.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float:right; margin-right: 20px; margin-top: -2px; width: 20px;" alt="No Image" />
                </div>  
                 <div class="for_sigle_row_form" id="RegistrationSession">
                    <label>
                        Admission Session<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlregistrationsession" runat="server">
                        <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                   
                </div>
                 <div class="clear"></div>  
                 <div class="for_sigle_row_form" id="StudentOldRegNo">
                    <label>
                        <asp:HiddenField ID="fdSamid" Value="0" runat="server" />
                        Registration No<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtRegNo" runat="server" MaxLength="15" placeholder="Enter Registration No Please"></asp:TextBox>&nbsp;                  
                </div>    
                 <div class="clear"></div>  
                 <div class="for_sigle_row_form" id="StudentAdmNo">
                    <label>
                        Admission No<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtAdmNo" runat="server" MaxLength="15" placeholder="Enter Admission No Please"></asp:TextBox>&nbsp;                  
                </div>    
                <div class="for_sigle_row_form">
                    <label>
                        Student First Name<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentfirstname" runat="server" MaxLength="15" placeholder="Enter Student First Name Please" ></asp:TextBox>&nbsp;                  
                </div>
                <div class="for_sigle_row_form">
                   <label>
                        Student Middle Name</label>
                    <asp:TextBox ID="txtstudentMiddlename" runat="server" MaxLength="15" placeholder="Enter Student Middle Name Please"></asp:TextBox>&nbsp;                  
                </div>
                 <div class="for_sigle_row_form">
                    <label>
                        Student Last Name</label>
                    <asp:TextBox ID="txtstudentlastname" runat="server" MaxLength="15" placeholder="Enter Student Last Name Please"></asp:TextBox>&nbsp;                  
                </div>             
                
                <div class="for_sigle_row_form" id="StudentDOB">
                    <label>
                        Student D.O.B<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtstudentdob" onchange="CalculateAge(this)"  onkeypress="return false" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;          
                    <span id="lblAge" style="font-weight: bold; color: red"></span>              
                </div>
                <div class="for_sigle_row_form" id="StudentUID">
                    <label>
                        Student Aadhaar Card(UID) No</label>
                    <asp:TextBox ID="txtstudentUid" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Student Aadhaar Card(UID) No"></asp:TextBox>&nbsp;     
                    <span id="lblUid" style="font-weight: bold; color: red"></span>               
                </div>
                
                <div class="clear"></div>
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
                  <div class="for_sigle_row_form" style="display:none" id="divforothercountry">
                    <label>
                        Country Name</label>
                    <asp:TextBox ID="txtcountryname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Enter Country Name Please" Text="India"></asp:TextBox>&nbsp;                    
                </div>
                 <div class="clear"></div>
                <div class="for_sigle_row_form" id="Religion">
                    <label>
                        Religion<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtreligion" runat="server" onkeypress="return lettersOnly(event)" MaxLength="15" placeholder="Enter Religion Please"></asp:TextBox>&nbsp;                 
                </div>                
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
                <div class="for_sigle_row_form">
                    <label>
                       Class<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlapplyingforclass" runat="server">
                        <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                       Section<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlsection" runat="server">
                        <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                </div>
               
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="StudentPhotograph">
                    <label style="padding-top: 4px;">
                        Upload Student Photograph</label>
                    <asp:FileUpload ID="fileuploaderofstudentphotograph" runat="server" onchange="ShowpImagePreviewstudentphotograph(this)"/>
                    <div class="user_phot_frame">
                        <div id="stuphotograph"  Style="display:none; position: absolute;margin-top:-62px" >
                           <span style="color: black;font-weight:bold;padding-top:20px;"><center><u>Student Photograph</u></center></span>
                           <asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px"/>
                        </div>
                         <div id="stucertifiacte" Style="display:none;position: absolute;margin-left:175px;margin-top:-62px">
                              <span style="color: black;font-weight:bold;padding-top:20px;"><center><u>Student Certificate</u></center></span>
                         <asp:Image ID="Image1" runat="server" ImageUrl="~/images/9update.png" Width="150px" Height="150px"/> 
                            </div>
                </div>
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
                    Student Fee Detail                
                </div>  
                 <div class="for_sigle_row_form">
                    <label>
                        Fee Amount Session<span style="color: Red;font-weight:bold">*</span></label>                   
                    <asp:TextBox ID="txtAmount" runat="server" MaxLength="15" placeholder="Enter Fee Amount No Please" Text="0"></asp:TextBox>&nbsp;                  
                </div>    
                <div class="clear"></div>
                <div class="sub-heading">
                    Primary Parent Details                   
                </div>
                <div class="clear"></div>
                <div class="for_sigle_row_form" id="PrimarySelectParentType">
                    <label>
                        Select Parent Type<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:DropDownList ID="ddlparenttype" runat="server">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>&nbsp;                    
                </div>
                <div class="for_sigle_row_form" id="PrimaryParentFirstName">
                    <label>
                        Parent First Name<span style="color: Red;font-weight:bold">*</span></label>
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
                        Mobile No<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtparentmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Enter Mobile No Please"></asp:TextBox>&nbsp;
                      
                </div>    
                 <div class="for_sigle_row_form" id="PrimaryParentEmail">
                    <label>
                        Parent Email ID</label>
                    <asp:TextBox ID="txtEmailID" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Enter Email ID Please"></asp:TextBox>&nbsp;
                       
                </div>                
                <div class="for_sigle_row_form" id="PrimaryParentOccupation">
                    <label>
                        Parent Occupation</label>
                    <asp:TextBox ID="txtparentoccupation" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Enter Occupation Please"></asp:TextBox>&nbsp;
                       
                </div>               
                <div class="clear"></div>
                <div class="sub-heading">
                    For Office Use Only
                </div>
                <div class="for_sigle_row_form" id="RegistrationDate">
                    <label>
                        Admission Date<span style="color: Red;font-weight:bold">*</span></label>
                    <asp:TextBox ID="txtregistrationdate" onkeypress="return false" runat="server" Placeholder="Select Admission Date"></asp:TextBox>&nbsp;
                     
                </div>
                  <div class="for_sigle_row_form" id="Comment">
                    <label style="padding-top: 4px;">
                        Comment</label>
                    <textarea id="txtcomment" runat="server" rows="3" cols="3" Placeholder="Your Comment Please"></textarea>&nbsp;                   
                </div>
                <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label style="padding-top: 4px;">
                        Save/Update</label>
                    <asp:Button ID="btnforupdateorsave" runat="server" Text="Submit" CssClass="button_save" OnClick="btnforupdateorsave_Click" /> 
                     <asp:Button ID="btnforcancel" runat="server" Text="Cancel" CssClass="button_cancel" />               
                </div>
                <br />
                <br />
        </div>         
    </div>
         </div>
    <script type="text/javascript">
        var year = 2020, Samid = 0, Fyid = 0;        
        $(document).ready(function () {
            Samid = GetParameterValues('Samid');
            $(".main-div-tbl").hide();
            $(".grid-data-resposive").show();
            $('#ctl00_ContentPlaceHolder1_ddlFyid').change(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlFyid').val() > 0) {
                    Bindstudentregistration(Samid);
                }
                else {
                    window.location.href = "AddLastYearFee.aspx";
                }
            });
            $('#btnAdd').click(function () {
                $(".main-div-tbl").show();
                $(".grid-data-resposive").hide();
            });
            $('#btnPay').click(function () {
                window.location.href = "PayLastFee.aspx";
            });
            $('.PayFee').live('click', function () {
                var PayStatus = '';
                PayStatus = $(this).closest('tr').find(".name").html();
                if (PayStatus != 'Paid ') {
                    Samid = $(this).closest('tr').find('input[type=hidden]').val();
                    window.location.href = "PayLastFee.aspx?Samid=" + Samid + "&FYID=" + $('#ctl00_ContentPlaceHolder1_ddlFyid').val() + "";
                }
                else {
                    alert('Sorry, Fee Already Paid');
                }
            });
            //$('.showdiscount').live('click', function () {
            //    RID = $(this).closest('tr').find('input[type=hidden]').val();
            //    window.location.href = "PayLastFee.aspx?RID=" + RID + "&FYID=" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "";
            //});
            $('.showdiscount').live('click', function () {
                $(".main-div-tbl").show();
                $(".grid-data-resposive").hide();
                Samid = $(this).closest('tr').find('input[type=hidden]').val();
                $('#ctl00_ContentPlaceHolder1_fdSamid').val(Samid)
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "AddLastYearFee.aspx/BindGridByJs",
                    data: "{'Samid':'" + Samid + "','Mode':'5','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('.divnorecordfound').css('display', 'none');
                        if (data.d.length > 0) {                           
                            for (var i = 0; i < data.d.length; i++) {
                                $("#ctl00_ContentPlaceHolder1_txtRegNo").val(data.d[i].Registration_No);
                                $("#ctl00_ContentPlaceHolder1_txtAdmNo").val(data.d[i].AdmissionNo);
                                $("#ctl00_ContentPlaceHolder1_ddlregistrationsession").val(data.d[i].Fyid);
                                $("#ctl00_ContentPlaceHolder1_txtstudentfirstname").val(data.d[i].studentFname);
                                $("#ctl00_ContentPlaceHolder1_txtstudentMiddlename").val(data.d[i].studentMname);
                                $("#ctl00_ContentPlaceHolder1_txtstudentlastname").val(data.d[i].studentLname);
                                //$("#ctl00_ContentPlaceHolder1_txtstudentdob").val(data.d[i].DOB);
                                //$("#ctl00_ContentPlaceHolder1_txtstudentUid").val(data.d[i].StudentUID);
                                //$("#ctl00_ContentPlaceHolder1_rbtnlistgender").val(data.d[i].Registration_No);
                                //$("#ctl00_ContentPlaceHolder1_txtreligion").val(data.d[i].Registration_No);
                                //$("#ctl00_ContentPlaceHolder1_rbtnlistcast").val(data.d[i].Registration_No);
                                $("#ctl00_ContentPlaceHolder1_ddlapplyingforclass").val(data.d[i].ClassID);
                                BindSection();
                                $("#ctl00_ContentPlaceHolder1_ddlsection").val(data.d[i].SectionID);
                                //$("#ctl00_ContentPlaceHolder1_txtaddress").val(data.d[i].Address);
                                //$("#ctl00_ContentPlaceHolder1_txtcity").val(data.d[i].City);
                                //$("#ctl00_ContentPlaceHolder1_txtstate").val(data.d[i].State);
                                //$("#ctl00_ContentPlaceHolder1_txtpiorzipcode").val(data.d[i].Pin);
                                //$("#ctl00_ContentPlaceHolder1_txtcountry").val(data.d[i].Country);
                                $("#ctl00_ContentPlaceHolder1_txtAmount").val(data.d[i].FeeAmount);
                                //$("#ctl00_ContentPlaceHolder1_ddlparenttype").val(data.d[i].PrimarySelectParentType);
                                $("#ctl00_ContentPlaceHolder1_txtparentfirstname").val(data.d[i].fatherFname);
                                $("#ctl00_ContentPlaceHolder1_txtparentmiddlename").val(data.d[i].fatherMname);
                                $("#ctl00_ContentPlaceHolder1_txtparentlastname").val(data.d[i].fatherLname);
                                $("#ctl00_ContentPlaceHolder1_txtparentmobileno").val(data.d[i].PrimaryMobileNo);
                                //$("#ctl00_ContentPlaceHolder1_txtEmailID").val(data.d[i].PrimaryEmailId);
                                //$("#ctl00_ContentPlaceHolder1_txtparentoccupation").val(data.d[i].PrimaryParentOccupation);
                                //$("#ctl00_ContentPlaceHolder1_txtregistrationdate").val(data.d[i].RegistrationDate);
                                //$("#ctl00_ContentPlaceHolder1_txtcomment").val(data.d[i].Comment);
                                //$("#ctl00_ContentPlaceHolder1_txtreligion").val(data.d[i].Registration_No);
                                //$("#ctl00_ContentPlaceHolder1_txtreligion").val(data.d[i].Registration_No);
                            }
                        }
                        else {
                            $('.divnorecordfound').css('display', 'inline');
                            $(".lblpage").html(0);
                            $('.lbltotalpage').html(0);
                        }
                    },
                    error: function (result) {
                        alertify.error("Error While Grid Is Binding");
                    }
                });
            });
            $("#ctl00_ContentPlaceHolder1_txtstudentdob,#ctl00_ContentPlaceHolder1_txtregistrationdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2020',
                dateFormat: 'dd MM yy'
            });
            $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').change(function () {
                BindSection();
            });
            $('#ctl00_ContentPlaceHolder1_btnforupdateorsave').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() == '0') {
                    alertify.error('Select admission  session please.');
                    $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtRegNo').val() == '') {
                    alertify.error('Enter Student Registration No please.');
                    $('#ctl00_ContentPlaceHolder1_txtRegNo').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtAdmNo').val() == '') {
                    alertify.error('Enter Student Admission No please.');
                    $('#ctl00_ContentPlaceHolder1_txtAdmNo').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentfirstname').val() == '') {
                    alertify.error('Enter student first name please.');
                    $('#ctl00_ContentPlaceHolder1_txtstudentfirstname').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentdob').val() == '') {
                    alertify.error('Select Date of birth please,');
                    $('#ctl00_ContentPlaceHolder1_txtstudentdob').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtreligion').val() == '') {
                    alertify.error('Enter religion please.');
                    $('#ctl00_ContentPlaceHolder1_txtreligion').focus();
                    return false;
                }               
                else if ($('#ctl00_ContentPlaceHolder1_txtstudentUid').val() != '') {
                    if ($('#ctl00_ContentPlaceHolder1_txtstudentUid').val().length != 12) {
                        alertify.error('Student Aadhaar Card No. only 12 Digits');
                        $('#ctl00_ContentPlaceHolder1_txtstudentUid').focus();
                        return false;
                    }
                }                
                else if ($('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').val() == '0') {
                    alertify.error('Select class please.');
                    $('#ctl00_ContentPlaceHolder1_ddlapplyingforclass').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlsection').val() == '0') {
                    alertify.error('Select Section please.');
                    $('#ctl00_ContentPlaceHolder1_ddlsection').focus();
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
                else if ($('#ctl00_ContentPlaceHolder1_txtAmount').val() == '0') {
                    alertify.error('Enter Fee Amount please.');
                    $('#ctl00_ContentPlaceHolder1_txtAmount').focus();
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
                else if ($('#ctl00_ContentPlaceHolder1_txtparentmobileno').val() == '') {
                    alertify.error('Enter Parent Mobile No.');
                    $('#ctl00_ContentPlaceHolder1_txtparentmobileno').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtregistrationdate').val() == '') {
                    alertify.error('Enter Admission Date.');
                    $('#ctl00_ContentPlaceHolder1_txtregistrationdate').focus();
                    return false;
                }
            });
        });
        function GetParameterValues(param) {
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (urlparam[0] == param) {
                    return urlparam[1];
                }
                else {
                    return 0;
                }
            }
        }
        function BindSection()
        {
            $('#ctl00_ContentPlaceHolder1_ddlsection').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../Admission/new-admission.aspx/BindSectionDDL",
                data: "{'Classid':'" + $("#ctl00_ContentPlaceHolder1_ddlapplyingforclass").val() + "'}",
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
        }
        function Bindstudentregistration() {
            $('.stm tr:gt(0)').remove();            
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddLastYearFee.aspx/BindGridByJs",
                data: "{'Samid':'" + Samid + "','Mode':'4','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlFyid').val() + "'}",
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
                            "<td><input type='hidden' value='" + data.d[i].Samid + "' />" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].RegistrationDate + " </td>" +
                            "<td>" + data.d[i].Registration_No + " </td>" +
                             "<td>" + data.d[i].AdmissionNo + " </td>" +
                          "<td>" + data.d[i].studentFname + " " + data.d[i].studentMname + " " + data.d[i].studentLname + " </td>" +
                          "<td>" + data.d[i].fatherFname + " " + data.d[i].fatherMname + " " + data.d[i].fatherLname + " </td>" +
                          //"<td>" + data.d[i].DOB + " </td>" +
                          "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
                          "<td>" + data.d[i].Classname + " </td>" +                         
                          "<td>" + data.d[i].Sectionname + " </td>" +
                          "<td>" + data.d[i].FeeAmount + " </td>" +
                          "<td>" + data.d[i].PaidFee + "</td>"+
                          "<td class='name'>" + data.d[i].PayStatus + " </td>" +
                          "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                          "<td><img src='../../images/fee-payment.png' style='border-width:0px;height:25px;width:30px;border-width:0px;' title='Click here to show detail.' class='PayFee'></img></td>" +
                            "</tr>"
                        }
                        $('.stm').append(trforappend);
                    }
                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }                  
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");                  
                }
            });
        }
    </script>
   
</asp:Content>

