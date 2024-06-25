<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="PayLastFee.aspx.cs" Inherits="BranchPanel_Fee_Management_PayLastFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="grid-data-resposive">
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Student Information
                <img src="../../images/Expend.png" id="imgbtnforcollapseorexpend" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 20px;" alt="No Image" />
                        <img src="../../images/back.png" id="btnBack" title="Click here to expend or collapse all field." style="float: right; margin-right: 20px; margin-top: -2px; width: 70px;" alt="No Image" />
                    </div>
                    <div class="for_sigle_row_form" id="RegistrationSession">
                        <label>
                            Admission Session<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:DropDownList ID="ddlregistrationsession" runat="server">
                            <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                        </asp:DropDownList>&nbsp;                   
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form" id="StudentOldRegNo">
                        <label>
                            <asp:HiddenField ID="fdRid" Value="0" runat="server" />
                            Registration No<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtRegNo" runat="server" MaxLength="15" placeholder="Enter Registration No Please"></asp:TextBox>&nbsp;                                     
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form" id="StudentAdmNo">
                        <label>
                            Admission No<span style="color: Red; font-weight: bold">*</span></label>
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
                    <asp:TextBox ID="txtstudentdob" runat="server" placeholder="Select Student D.O.B"></asp:TextBox><span class="dob-formate">(DD/MM/YYYY)</span>&nbsp;          
                    <span id="lblAge" style="font-weight: bold; color: red"></span>              
                </div>               
                    <div class="for_sigle_row_form">
                        <label>
                            Fee Amount <span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtAmount" runat="server" MaxLength="15" placeholder="Enter Fee Amount No Please" Text="0"></asp:TextBox>&nbsp;                  
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Payble Amount <span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtPaidAmt" runat="server" MaxLength="15" placeholder="Enter Fee Amount No Please" Text="0"></asp:TextBox>&nbsp;                  
                    </div>
                    <div class="clear"></div>
                  
                    <div class="for_sigle_row_form" id="RegistrationDate">
                        <label>
                            Payemnt Date<span style="color: Red; font-weight: bold">*</span></label>
                        <asp:TextBox ID="txtPayDate" onkeypress="return false" runat="server" Placeholder="Select Admission Date"></asp:TextBox>&nbsp;
                     
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
    </div>
    <script type="text/javascript">
        var year = 2020, RID = 0, Fyid = 0;
        $(document).ready(function () {
            RID = getUrlVars("RID");
            Fyid = getUrlVars("FYID");
            $('#fdRID').val(RID);
            Bindstudentregistration();
            $('#btnAdd').click(function () {
                $(".main-div-tbl").show();
                $(".grid-data-resposive").hide();
            });
            $('#btnBack').click(function () {
                window.location.href = "AddLastYearFee.aspx";
            });          
            $("#ctl00_ContentPlaceHolder1_txtPayDate,#ctl00_ContentPlaceHolder1_txtregistrationdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:2020',
                dateFormat: 'dd MM yy'
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
                else if ($('#ctl00_ContentPlaceHolder1_txtAmount').val() == '') {
                    alertify.error('Select Fee Amount can not blank');
                    $('#ctl00_ContentPlaceHolder1_txtAmount').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPaidAmt').val() == '') {
                    alertify.error('Select Payble Amount can not blank');
                    $('#ctl00_ContentPlaceHolder1_txtPaidAmt').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtAmount').val() == '0') {
                    alertify.error('Select Fee Amount can not Zero');
                    $('#ctl00_ContentPlaceHolder1_txtAmount').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPaidAmt').val() == '0') {
                    alertify.error('Select Payble Amount can not Zero');
                    $('#ctl00_ContentPlaceHolder1_txtPaidAmt').focus();
                    return false;
                }
                else if (parseFloat($('#ctl00_ContentPlaceHolder1_txtPaidAmt').val()) > parseFloat($('#ctl00_ContentPlaceHolder1_txtAmount').val())) {
                    alertify.error('Payble Amount can not greater than Fee Amount');
                    $('#ctl00_ContentPlaceHolder1_txtPaidAmt').focus();
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtPayDate').val() == '') {
                    alertify.error('Select Payment Date');
                    $('#ctl00_ContentPlaceHolder1_txtPayDate').focus();
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
            });
        });
        function getUrlVars(param) {
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
        function Bindstudentregistration() {
            $('#ctl00_ContentPlaceHolder1_fdRid').val(RID)
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddLastYearFee.aspx/BindGridByJs",
                data: "{'RID':'" + RID + "','Mode':'5','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlregistrationsession').val() + "'}",
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
                            $("#ctl00_ContentPlaceHolder1_txtstudentdob").val(data.d[i].DOB);
                            //$("#ctl00_ContentPlaceHolder1_txtAmount").val(data.d[i].FeeAmount);
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
        }
    </script>

</asp:Content>

