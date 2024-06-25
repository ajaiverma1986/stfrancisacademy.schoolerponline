<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-admission-list.aspx.cs" Inherits="BranchPanel_StudentManagement_student_admission_list" %>

<%@ Register Src="~/BranchPanel/StudentManagement/student-admission-list.ascx" TagPrefix="My" TagName="stu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activestudentadmissionlist {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .divforbinddetailsgrid {
            left: 17% !important;
            width: 82% !important;
        }
    </style>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Students All Details</h2>
            </div>
            <asp:HiddenField ID="dfBrid" runat="server" />
            <My:stu runat="server" ID="MyUserInfoBoxControl" />
            <div class="grid-data-resposive">
                <div class="divforstm">
                    <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                        <tr class="stm_head">
                            <th align="center">S.No.</th>
                            <th align="center">Admission No</th>
                            <th align="center">Admission Date</th>
                            <th align="center">Class</th>
                            <th align="center">Academic Year</th>
                            <th align="center">Total Fee</th>
                            <th align="center">Late Fee</th>
                            <th align="center">Discount Fee</th>
                            <th align="center">Paid Fee</th>
                            <th align="center">Main Fee Bal</th>
                            <th align="center">Trans Fee Bal</th>
                            <th align="center">Account Statement</th>
                            <th align="center">Status</th>
                        </tr>
                    </table>
                </div>
                <div class="clear"></div>
            </div>
            <div class="DivForAccoutStatement divforbinddetailsgrid" style="display: none">
                <div class="pop-headng-sty">
                    Your Account Statement
               <a id="BtnCancelTopic" title="Close this from here" class="btnClose">
                   <img src="../../images/popupcross.png" alt="No Image" class="ImgClose" /></a>
                    <div class="upload">
                        <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                        <button class="imgprint" id="anchorprint" title="Click Here For Print Account Statement.">Print</button>
                    </div>
                </div>
                <div class="divforstm DownloadFormatDivForUpload ">
                    <table class="stm  StmstudentBasicdetails" style="width: 98%; margin: 0px 9px 0;" cellpadding="0" cellspacing="0">
                        <tr class="stm_head" align="center">
                            <th align="center" scope="col" style="color: green; font-weight: bold">Name</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Admission No</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Parent Mobile No</th>
                        </tr>
                    </table>
                    <br />
                    <table class="stm Stmstudentdetails" style="width: 98%; margin: 0px 9px 0;" cellpadding="0" cellspacing="0">
                        <tr class="stm_head" align="center">
                            <th align="center" scope="col" style="color: green; font-weight: bold">Class</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Join Date</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Taxable Fee</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Non Taxable Fee</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Discount</th>
                            <th align="center" scope="col" style="color: green; font-weight: bold">Total Fee</th>
                        </tr>
                    </table>
                    <div class="clear"></div>
                    <table class="stm stmforaccountstatement" style="width: 98%; margin: 9px 9px 0" cellpadding="0" cellspacing="0">
                        <tr class="stm_head" align="center">
                            <th align="center" scope="col">S.No.</th>
                            <th align="center" scope="col">Recipt No</th>
                            <th align="center" scope="col">Installment Amount</th>
                            <th align="center" scope="col">Due Date</th>
                            <th align="center" scope="col">Paid Amount</th>
                            <th align="center" scope="col">Actual Fee</th>
                            <th align="center" scope="col">Service Tax</th>
                            <th align="center" scope="col">Payment Mode</th>
                            <th align="center" scope="col">Payment Status</th>
                            <th align="center" scope="col">Installment Name</th>
                            <th align="center" scope="col">Payment Remark</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="divforrcoursecomplete" class="showpopup2" style="display: none;">
                <div class="pop-headng-sty">
                    Please Enter Comment OR Remark
                <a id="removeback" title="Close this from here" class="btnClose">
                    <img src="../../images/popupcross.png" alt="No Image" class="ImgClose" /></a>
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Status Type<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlstatus" runat="server" Width="265px">
                        <asp:ListItem Value="0" Text="--Select Type--"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Terminate"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Transfer"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Pass Out"></asp:ListItem>
                        <asp:ListItem Value="4" Text="Promote"></asp:ListItem>
                        <asp:ListItem Value="5" Text="Running"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                
                <div id="hideshow2" class="for_sigle_row_form">
                    <label>Promoted Session<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlprmotBrid" runat="server"></asp:DropDownList>
                </div>

                 <div id="hideshow" class="for_sigle_row_form">
                    <label>Promoted Class<span style="color: Red">*</span></label>
                     <asp:DropDownList ID="ddlprmotclas" runat="server"></asp:DropDownList>
                </div>
                <div id="hideshow1" class="for_sigle_row_form">
                    <label>Promoted Section<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlprmotsection" runat="server"></asp:DropDownList>
                </div>
                    
                <div class="for_sigle_row_form">
                    <label>Enter Comment<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtremove" runat="server" TextMode="MultiLine" Style="width: 250px;height:100px"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label></label>
                    <asp:Button ID="btnremove" CssClass="button_save" runat="server" Text="Submit" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var StuRegNoForStatusChange = 0, ClassID = 0, PrevFyid=0;
        $(document).ready(function () {
            $("#hideshow").hide();
            $("#hideshow1").hide();
            $("#hideshow2").hide();
            BindAdmissionList();
            $('.anchorforchangestatus').live('click', function () {
                StuRegNoForStatusChange = $(this).parent('td').parent('tr').find('td:eq(9)').find('input[type="hidden"]').val();
                //PrevFyid = $(this).parent('td').parent('tr').find('td:eq(9)').find('input[type="hidden"]').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "student-admission-list.aspx/CheckActionPermission",
                    data: "{'ActionID':'1'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 0) {                            
                            $('#divforrcoursecomplete ').css("display", "block");
                            return false;
                        }
                        else {
                            alert('You have not permission to change this Action');
                            return false;
                        }
                        return false;
                    },
                    error: function (result) {
                        alertify.error("Some Internal Error");
                        call_progressbar("end");
                        return false;
                    }
                });                        
            });
            //$('#ctl00_ContentPlaceHolder1_ddlprmotclas').live('click', function () {
            //    $('#divforrcoursecomplete ').css("display", "block");
            //});
            $('#ctl00_ContentPlaceHolder1_ddlprmotsection').live('click', function () {
                $('#divforrcoursecomplete ').css("display", "block");
            });
            $('#ctl00_ContentPlaceHolder1_ddlprmotBrid').live('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "student-admission-list.aspx/bindclassFyid",
                    data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotBrid').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $("#ctl00_ContentPlaceHolder1_ddlprmotclas").html("");
                        //$("#ctl00_ContentPlaceHolder1_ddlprmotclas").append($("<option></option>").val('0').html('Select Class'));
                        $.each(data.d, function (key, value) {
                            $("#ctl00_ContentPlaceHolder1_ddlprmotclas").append($("<option></option>").val(value.ClassID).html(value.ClassName));
                        });
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
                $('#divforrcoursecomplete ').css("display", "block");
            });
            $('#ctl00_ContentPlaceHolder1_ddlprmotclas').live('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                    data: "{'ClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotclas').val() + "'}",
                    dataType: "json",
                    success: function (data) {                        
                        $("#ctl00_ContentPlaceHolder1_ddlprmotsection").html("");
                        $("#ctl00_ContentPlaceHolder1_ddlprmotsection").append($("<option></option>").val('0').html('Select Section'));
                        $.each(data.d, function (key, value) {
                            $("#ctl00_ContentPlaceHolder1_ddlprmotsection").append($("<option></option>").val(value.SectionID).html(value.SectionName));
                        });
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });              
                $('#divforrcoursecomplete ').css("display", "block");
            });
            $('.ImgClose').click(function () {
                $('#divforrcoursecomplete ').css("display", "none");
                $('.DivForAccoutStatement ').css("display", "none");
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnremove').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '0') {
                    alert('Select Status Type Please.');
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '1' || $('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '3') {
                    if ($('#ctl00_ContentPlaceHolder1_txtremove').val() == '') {
                        alert('Enter Comment OR Remark Please.');
                        return false;
                    }
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "student-admission-list.aspx/TerminateStudent",
                        data: "{'Comment':'" + $('#ctl00_ContentPlaceHolder1_txtremove').val() + "','val':'" + $('#ctl00_ContentPlaceHolder1_ddlstatus').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == 0) {
                                alert("Error");
                                return false;
                            }
                            else {

                                window.location = "../studentmanagement/terminated-student-list.aspx";
                                // return false;
                            }
                        }
                    });
                }
                else {
                    if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '4') {
                        if ($('#ctl00_ContentPlaceHolder1_ddlprmotclas').val() == '0') {
                            alert('Please Select Promoted Class');
                            return false;
                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlprmotsection').val() == '0') {
                            alert('Please Select Promoted Section');
                            return false;
                        }
                        if ($('#ctl00_ContentPlaceHolder1_ddlprmotclas').val() == ClassID) {
                            alert('This is already Class choose another Please');
                            return false;
                        }
                        if ($('#ctl00_ContentPlaceHolder1_ddlprmotBrid').val() == '0') {
                            alert('Please Select Promoted Session');
                            return false;
                        }
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "student-admission-list.aspx/CheckPrmFee",
                            data: "{'ClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotclas').val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotBrid').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == 0) {
                                    if (confirm('Sorry, You have not Config Fee Structure of Promoted Class. Do you want ?')) {
                                        window.location.replace('../../ho/feesSetting.aspx')
                                        var url = "../../ho/feesSetting.aspx";
                                        window.open(url, '_blank');
                                    }
                                    else {
                                        return false;
                                    }
                                }
                            }
                        });
                    }

                    if ($('#ctl00_ContentPlaceHolder1_txtremove').val() == '') {
                        alert('Enter Comment OR Remark Please.');
                        return false;
                    }
                    if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() != '5') {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "student-admission-list.aspx/CheckDue",
                            data: "{'StuRegNo':'" + StuRegNoForStatusChange + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotBrid').val() + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d == 0) {
                                    UpdateComment();
                                }
                                else {
                                    if (confirm('Sorry, You have not Clear Fee of Current Class. Do you want ?')) {
                                        window.location.replace('student-fee-info.aspx?ID=' + StuRegNoForStatusChange)
                                    }
                                    else {
                                        return false;
                                    }
                                }
                            }
                        });
                    }
                }
                              
                return false;
                
            });
            $('.Imgaccountstatement').live('click', function () {
                $('.DivForAccoutStatement').css("display", "block");
                BindStudentinfo();
                BindFeeDetail();
                return false;
            });
            $('.imgprint').click(function () {
                var printWindow = window.open('left=500,top=500,width=500,height=500');
                printWindow.document.write($('.DownloadFormatDivForUpload').html());
                printWindow.document.close();
                printWindow.focus();
                printWindow.print();
                printWindow.close();
            });
            $("#ctl00_ContentPlaceHolder1_ddlstatus").change(function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '4') {
                    //$("#ctl00_ContentPlaceHolder1_ddlprmotclas").show(100);
                    //$("#ctl00_ContentPlaceHolder1_ddlprmotsection").show(100);
                    $("#hideshow").show();
                    $("#hideshow1").show();
                    $("#hideshow2").show();
                }
                else {
                    //$("#ctl00_ContentPlaceHolder1_ddlprmotclas").hide(0);
                    //$("#ctl00_ContentPlaceHolder1_ddlprmotsection").hide(0);
                    $("#hideshow").hide();
                    $("#hideshow2").hide();


                }
            });
           
            
        });
        function UpdateComment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-admission-list.aspx/UpdateComment",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotBrid').val() + "','Comment':'" + $('#ctl00_ContentPlaceHolder1_txtremove').val() + "','Mode':'" + $('#ctl00_ContentPlaceHolder1_ddlstatus').val() + "','PromClassID':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotclas').val() + "','PromSectionID':'" + $('#ctl00_ContentPlaceHolder1_ddlprmotsection').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d > 0) {
                        $("#divforrcoursecomplete").hide(500);
                        BindAdmissionList();
                        if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '1') {
                            alertify.error('Student Terminated Succcessfully.');
                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '2') {
                            alertify.success('Student Tranfered Succcessfully.');

                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '3') {
                            alertify.success('Student Pass Out Succcessfully.');

                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '4') {
                            alertify.success('Student Promoted Succcessfully.');
                        }
                        else if ($('#ctl00_ContentPlaceHolder1_ddlstatus').val() == '5') {
                            alertify.success('Student Status Changed Succcessfully.');
                        }
                        $('#ctl00_ContentPlaceHolder1_ddlstatus').val('0');
                        $('#ctl00_ContentPlaceHolder1_txtremove').val('');
                        $('#ctl00_ContentPlaceHolder1_ddlprmotclas').val('0');
                        $('#ctl00_ContentPlaceHolder1_ddlprmotsection').val('0');

                    }
                    SAMID = 0;
                    return true;
                }

            });

        }
            
       
            
        function BindAdmissionList() {
            var trforappend = '', ClassForTr = '';
            var i = 1;
            $('#ctl00_ContentPlaceHolder1_CourseGrid').find('tbody').find('tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-admission-list.aspx/BindAdmissionDetails",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    TableGeneralDetails.each(function () {
                        if (i % 2 == 0) {
                            ClassForTr = 'stm_dark';
                        }
                        else {
                            ClassForTr = 'stm_light';
                        }
                        var CurrentDeailsRow = $(this);
                        trforappend = trforappend + '<tr class="' + ClassForTr + '">'
                         + '<td>' + CurrentDeailsRow.find("Number").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("AdmissionNo").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("AdmissionDate").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("Classname").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("FyName").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("PayableFeeWithoutTax").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("FeeFine").text() + '</td>'
                         + '<td>' + CurrentDeailsRow.find("Discount").text() + '</td>'
                         +  '<td>' + CurrentDeailsRow.find("PaidFeeWithOutTax").text() + '</td>'
                            + '<td><input type="hidden" value=' + CurrentDeailsRow.find("StuRegNo").text() + ' /><a class="anchorforbalancefee" style="color:#E56979;text-decoration:underline" href="student-fee-info.aspx?ID=' + CurrentDeailsRow.find("StuRegNo").text() + '" >' + CurrentDeailsRow.find("BalanceFee").text() + '</a></td>'
                            + '<td><input type="hidden" value=' + CurrentDeailsRow.find("StuRegNo").text() + ' /><a class="anchorforbalancefee" style="color:#E56979;text-decoration:underline" target="_blank" href="../transportmanagment/StdFeeList.aspx?ID=' + CurrentDeailsRow.find("StuRegNo").text() + '" >' + CurrentDeailsRow.find("TransFeeBal").text() + '</a></td>'
                         + '<td><input class="Imgaccountstatement" type="image" style="width:20px;border-width:0px;" src="../../images/SalaryStatement.png" title="Click Here For Get Account Statement." /></td>'
                         + '<td><a class="anchorforchangestatus" style="color:#E56979;text-decoration:underline">' + CurrentDeailsRow.find("Status").text() + '</a></td>' +
                         '</tr>'
                        i = i + 1;
                        ClassID = CurrentDeailsRow.find("id").text();
                        PrevFyid = CurrentDeailsRow.find("Fyid").text();
                    });
                    $('.stmdetail').append(trforappend);
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }

        function BindStudentinfo() {
            $('.Stmstudentdetails tr:gt(0)').remove();
            $('.StmstudentBasicdetails tr:gt(0)').remove();
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-admission-list.aspx/BindStudentDetails",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");

                    var CurrentDeailsRow = $(TableGeneralDetails);
                    trforappend = trforappend + '<tr>'
                        + '<td>' + CurrentDeailsRow.find("Classname").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("AdmissionDate").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("TaxableAmount").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("NonTaxableAmount").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("Discount").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("PayableFeeWithoutTax").text() + '</td>'
                    '</tr>';

                    $('.Stmstudentdetails').append(trforappend);
                    trforappend = '<tr>' +
                        '<td>' + CurrentDeailsRow.find("Name").text() + '</td>' +
                        '<td>' + CurrentDeailsRow.find("AdmissionNo").text() + '</td>' +
                        '<td>' + CurrentDeailsRow.find("MobileNo").text() + '</td>' +
                        '</tr>';
                    $('.StmstudentBasicdetails').append(trforappend);
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }

        function BindFeeDetail() {
            $('.stmforaccountstatement tr:gt(0)').remove();
            var trforappend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-admission-list.aspx/BindStudentFeeDetails",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);
                        trforappend = trforappend + '<tr>'
                        + '<td>' + CurrentDeailsRow.find("Number").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("ReceiptNo").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("InstallmentAmount").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("InstallmentDate").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("PaidFee").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("ActualFee").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("ServiceTax").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("PaymentMode").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("PaymentStatus").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("InstallmentName").text() + '</td>'
                        + '<td>' + CurrentDeailsRow.find("PaymentRemark").text() + '</td>'
                        '</tr>';
                    });
                    $('.stmforaccountstatement').append(trforappend);
                },
                error: function (response) {
                    alert('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.Just Refresh The Page.');
                }
            });
        }
    </script>
</asp:Content>