<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="AdmissionType.aspx.cs" Inherits="HO_AdmissionType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_pane_cont input_content branch-div-tbl" id="Div1" style="border-top: medium none;">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
            <h2>AdmissionType list</h2>
            <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="containerHeadlinenew">
                <asp:Button runat="server" ID="btnAdd" Text="Add AdmissionType" CssClass="button_save" Style="float: right; height: 25px; margin-right: 12px; margin-top: 3px; padding: 0 5px 1px;" ToolTip="Click here to Add AdmissionType." />
            </div>
        </div>
        <div class="clear"></div>
        <div id="divadd" style="display: none">
            <div class="for_sigle_row_form" style="display: none">
                <label>Pub ID<span style="color: #ff0066">*</span></label>
                <asp:TextBox ID="txtFiName" runat="server" Enabled="false"></asp:TextBox>
                &nbsp                
            </div>
             <div class="for_sigle_row_form">
                <label>Admission Type <span style="color: #ff0066">*</span></label>
                <asp:TextBox runat="server" ID="txtAdmissionType"></asp:TextBox>
                &nbsp                
            </div>
            <div class="for_sigle_row_form divFeeHead">
                <label>Session <span style="color: #ff0066">*</span></label>
                <asp:DropDownList runat="server" ID="ddlFinancialYear1"></asp:DropDownList>
                &nbsp                
            </div>           
            <div class="for_sigle_row_form divFeeHead" style="display:none">
                <label>Branch <span style="color: #ff0066">*</span></label>
                <asp:DropDownList runat="server" ID="ddlBranch"></asp:DropDownList>
                &nbsp                
            </div>
            <div class="for_sigle_row_form divFeeHead" style="display:none">
                <label>Class <span style="color: #ff0066">*</span></label>
                <asp:DropDownList runat="server" ID="ddlClass"></asp:DropDownList>
                &nbsp                
            </div>            
            <div class="for_sigle_row_form">
                <label>Is Active</label>
                <asp:CheckBox runat="server" ID="chkIsActive"></asp:CheckBox>
                &nbsp                
            </div>
            <div class="for_sigle_row_form">
                <label><span style="color: Red"></span></label>
                <button type="button" id="btnsubmit" class="button_save">Save</button>
                <button type="button" id="btnFeeHead" class="button_save divFeeHead1" style="display:none">Update Fee Head</button>
                <asp:Button ID="btncancel" runat="server" Text="Back" CssClass="button2 inputinstitute" />
            </div>
        </div>
        <div class="clear"></div>
        <div class="divFeeHead1" style="display: none">
            <br />
            <div>
                <table id="FeeHeadList" class="stm" style="width: 100%;">
                    <tr class="stm_head">
                        <th scope="col" style="width: 10%">S.No.</th>
                        <th scope="col" style="width: 20%">Fee Head</th>
                        <th scope="col" style="width: 20%">Fee Amount</th>
                        <th scope="col" style="width: 20%">Fee Type</th>
                        <th scope="col" style="width: 20%">Discount Type</th>
                        <th scope="col" style="width: 20%">value</th>
                    </tr>
                </table>
            </div>
        </div>
        <div id="AdmissionTypeList" class="for_sigle_row_form">
            <div style="float: left; width: 100%;" id="searchdiv" class="for_sigle_row_form">
                <asp:TextBox ID="TxtAdmissionTypename" runat="server" Style="height: 23px; width: 200px;" placeholder="Enter AdmissionType Name"></asp:TextBox>
                <%--<asp:DropDownList runat="server" ID="ddlFinancialYear"></asp:DropDownList>--%>
                <img src="../images/clearsearch.png" id="btnclearalld" style="cursor: pointer" width="25" title="Clear All Search" alt="No Image" />
            </div>
            <table id="TableadmissionTypeList" class="stm" style="width: 100%;">
                <tr class="stm_head">
                    <th scope="col" style="width: 10px">S.No.</th>
                    <th scope="col" style="width: 40px">AdmissionType</th>
                    <th scope="col" style="width: 40px">Class</th>
                    <th scope="col" style="width: 40px">Status</th>
                    <th scope="col" style="width: 30px">Add Discount</th>
                    <th scope="col" style="width: 30px">Edit</th>
                </tr>
            </table>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var Mode = 0, IsActive = 0, AdmTypeId = 0, Fyid = 0, AdmType = '';
        $(document).ready(function () {
            HideDivFeeHead(false);
            BindFinancialYears();
            BindAdmTypelist();
            $('#ctl00_ContentPlaceHolder1_btnAdd').click(function () {
                Reset();
                Mode = 1;
                $('#AdmissionTypeList').hide();
                $('#divadd').show();
                return false;
            });
            $("#FeeHeadList").on('keyup', '#txtDiscountRate', function () {
                var actualAmt = $(this).parent('td').parent('tr').find('td:eq(2)').html();
                var amount = $(this).val();
                if (amount != undefined && parseFloat(amount) > 0) {
                    var discountType = $(this).parent('td').parent('tr').find('#ddlDiscountType').val();
                    if (discountType == '1') {
                        if (parseFloat(amount) > parseFloat(actualAmt)) {
                            $(this).val('0.00');
                            alertify.error('Discount amount can not be grather than actual amount.');
                            return false;
                        }
                    }
                    if (discountType == '2') {
                        if (parseFloat(amount) > 100) {
                            $(this).val('0.00');
                            alertify.error('Discount Percentage can not be grather than 100.');
                            return false;
                        }
                    }
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_TxtAdmissionTypename').keyup(function () {
                Mode = 1;
                BindAdmTypelist();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_TxtAdmissionTypename').keyup(function () {
                Mode = 1;
                BindAdmTypelist();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlBranch,#ctl00_ContentPlaceHolder1_ddlFinancialYear1').live('change', function () {
                HideSHowFeeHeadList(false);
                BindClass();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlClass').live('change', function () {
                HideSHowFeeHeadList(false);
                BindFeeHeadList();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btncancel').click(function () {
                $('#AdmissionTypeList').show();
                $('#divadd').hide();
                AdmTypeId = 0;
                Mode = 1;
                BindAdmTypelist();
                HideDivFeeHead(false);
            });
            $('.btnEdit').click(function () {
                Mode = 1;
                AdmTypeId = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                BindAdmType();
                HideDivFeeHead(false);
                $('#AdmissionTypeList').hide();
                $('#divadd').show();
                Mode = 2;
                return false;
            });
            $('.btnAddDiscount').click(function () {
                BindFinancialYears();
                BindBranch();
                Mode = 1;
                AdmTypeId = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                HideDivFeeHead(true);
                BindAdmType();
                $('#AdmissionTypeList').hide();
                $('#divadd').show();
                Mode = 2;
                return false;
            });
            $('#btnFeeHead').click(function () {
                var Fyid = $('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val();
                var Brid = $('#ctl00_ContentPlaceHolder1_ddlBranch').val();
                var ClassId = $('#ctl00_ContentPlaceHolder1_ddlClass').val();
                var FeeHeadIds = '', DiscountTypeIds = '', DiscountRates = '';
                $('#FeeHeadList').find('tr:gt(0)').each(function () {
                    var FeeHeadId = $(this).find('td:eq(0)').find('input[type="hidden"]').val()
                    var DiscountTypeId = $(this).find('td:eq(4)').find('#ddlDiscountType').val();
                    var DiscountRate = $(this).find('td:eq(5)').find('#txtDiscountRate').val();
                    FeeHeadIds = FeeHeadIds + '~' + FeeHeadId;
                    DiscountTypeIds = DiscountTypeIds + '~' + DiscountTypeId;
                    DiscountRates = DiscountRates + '~' + DiscountRate;
                });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "AdmissionType.aspx/addOrUpdateAdmTypeFeeHeadList",
                    data: "{'Fyid':'" + Fyid + "','Brid':'" + Brid + "','ClassId':'" + ClassId + "','AdmTypeId':'" + AdmTypeId + "','FeeHeadIds':'" + FeeHeadIds + "','DiscountTypeIds':'" + DiscountTypeIds + "','DiscountRates':'" + DiscountRates + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d > 0) {
                            if (data.d == 1) {
                                alertify.success('Record Successfully Updated.');
                            }
                            else {
                                alertify.error('Some Records are not Updated.');
                            }
                        }
                        return false;
                        call_progressbar('end')
                    },
                    error: function (result) {
                        call_progressbar('end')
                    }
                });
            });
            $('#btnsubmit').click(function () {
                if ($('#ctl00_ContentPlaceHolder1_txtAdmissionType').val() == '') {
                    alertify.error('Please Enter Admission Type');
                    return falsé;
                } else {
                    FillField();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "AdmissionType.aspx/addOrUpdateAdmType",
                        data: "{'Fyid':'" + Fyid + "', 'Mode':'" + Mode + "','AdmTypeId':'" + AdmTypeId + "','AdmType':'" + AdmType + "','IsActive':'" + IsActive + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d > 0) {
                                if (data.d == 1) {
                                    alertify.success('Record Successfully Added.');
                                }
                                if (data.d == 2) {
                                    alertify.success('Record Successfully Added.');
                                }
                                if (data.d == 3) {
                                    alertify.error('Record already Exists.');
                                }
                            }
                            return false;
                            call_progressbar('end')
                        },
                        error: function (result) {
                            call_progressbar('end')
                        }
                    });
                }
            });
        });       
        function BindBranch() {
            $('#ctl00_ContentPlaceHolder1_ddlBranch').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindBranchDDL",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlBranch').html('<option value="0">--Select Branch--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlBranch').append('<option value="' + data.d[i].Brid + '">' + data.d[i].BrName + '</option>');
                        }
                    }
                }
            });
        }
        function BindClass() {
            $('#ctl00_ContentPlaceHolder1_ddlClass').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindClassDDL",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val() + "','Brid':'" + $('#ctl00_ContentPlaceHolder1_ddlBranch').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlClass').html('<option value="0">--Select Class--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlClass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                        }
                    }
                }
            });
        }
        function BindSection() {
            $('#ctl00_ContentPlaceHolder1_ddlSection').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../BranchPanel/Admission/new-admission.aspx/BindSectionDDL",
                data: "{'Classid':'" + $(this).val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlSection').html('<option value="0">--Select Section--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlSection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                        }
                    }
                }
            });
        }
        function HideDivFeeHead(isShow) {
            if (isShow) {
                //$('#btnFeeHead').show();
                $('.divFeeHead').show();
                $('#btnsubmit').hide();
            } else {
                //$('#btnFeeHead').hide();
                $('#btnsubmit').show();
                $('.divFeeHead').hide();
            }
            $('#ctl00_ContentPlaceHolder1_txtAdmissionType').prop('disabled', isShow);
            $('#ctl00_ContentPlaceHolder1_chkIsActive').prop('disabled', isShow);
        }
        function Reset() {
            $('#ctl00_ContentPlaceHolder1_txtAdmissionType').val('');
            $('#ctl00_ContentPlaceHolder1_chkIsActive').attr('checked', false);
        }
        function BindAdmType() {
            call_progressbar('start')
            $('#TableadmissionTypeList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindAdmTypelist",
                data: "{'Mode':'" + Mode + "','AdmTypeId':'" + AdmTypeId + "','AdmType':'" + $('#ctl00_ContentPlaceHolder1_TxtAdmissionTypename').val() + "','IsActive':'" + IsActive + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_txtAdmissionType').val(data.d[i].AdmType);
                            //$('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val(data.d[i].Fyid);
                            if (data.d[i].IsActive == 1) {
                                $('#ctl00_ContentPlaceHolder1_chkIsActive').attr('checked', true);
                            } else {
                                $('#ctl00_ContentPlaceHolder1_chkIsActive').attr('checked', false);
                            }
                        }
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
        function BindFeeHeadList() {
            Mode = 1;
            call_progressbar('start')
            $('#FeeHeadList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindFeeHeadList",
                data: "{'ClassId':'" + $('#ctl00_ContentPlaceHolder1_ddlClass').val() + "','Brid':'" + $('#ctl00_ContentPlaceHolder1_ddlBranch').val() + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        HideSHowFeeHeadList(true);
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                cssclass = 'stm_light';
                            else
                                cssclass = 'stm_dark';

                            var DiscountTypeId = data.d[i].DiscountTypeId;

                            trforappend = '<tr class=' + cssclass + '><td><input id="hfAdmTypeId" type="hidden" value="' + data.d[i].FeeHeadId + '">' + (i + 1) + '</td>' +
                                '<td>' + data.d[i].feename + '</td>' +
                                '<td>' + parseFloat(data.d[i].Fees).toFixed(2) + '</td>' +
                                '<td>' + data.d[i].Maintype + '</td>';
                            if (DiscountTypeId == 2) {
                                trforappend = trforappend + '<td><select id="ddlDiscountType" class="for_sigle_row_form" style="padding:4px"><option value="1">Flat</option><option value="2" selected>Percentage</option></select></td>';
                            }
                            else {
                                trforappend = trforappend + '<td><select id="ddlDiscountType" class="for_sigle_row_form" style="padding:4px"><option value="1">Flat</option><option value="2">Percentage</option></select></td>';
                            }
                            trforappend = trforappend + '<td><input type="text" id="txtDiscountRate" name="txtDiscountRate" onkeypress="return isNumberKey(event)" value="' + parseFloat(data.d[i].DiscountRate).toFixed(2) + '" class="for_sigle_row_form" style="padding:4px"></td></tr>'
                            $('#FeeHeadList').append(trforappend);
                        }
                    } else {
                        HideSHowFeeHeadList(false);
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
        function HideSHowFeeHeadList(isVisible) {
            if (isVisible > 0) {
                $('.divFeeHead1').show();
                $('#btnFeeHead').show();
            }
            else {
                $('.divFeeHead1').hide();
                $('#btnFeeHead').hide();
            }           
        }
        function BindAdmTypelist() {
            Mode = 1;
            call_progressbar('start')
            $('#TableadmissionTypeList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/BindAdmTypelist",
                data: "{'Mode':'" + Mode + "','AdmTypeId':'" + AdmTypeId + "','AdmType':'" + $('#ctl00_ContentPlaceHolder1_TxtAdmissionTypename').val() + "','IsActive':'" + IsActive + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                cssclass = 'stm_light';
                            else
                                cssclass = 'stm_dark';

                            var status = '';
                            if (data.d[i].IsActive == 1)
                                status = 'True';
                            else
                                status = 'False';
                            trforappend = '<tr class=' + cssclass + '><td>' + (i + 1) + '</td>' +
                                '<td>' + data.d[i].AdmType + '</td>' +
                                '<td>' + data.d[i].Classname + '</td>' +
                                '<td>' + status + '</td>' +
                                '<td><img class="btnAddDiscount" disabled type="image" style="width:20px;" src="../images/btnDiscount.png" />' +
                                '<input id="hfAdmTypeId" type="hidden" value="' + data.d[i].AdmTypeID + '"></td>' +
                                '<td><img class="btnEdit" disabled type="image" style="width:15px;" src="../images/edit.png" />' +
                                '<input id="hfAdmTypeId" type="hidden" value="' + data.d[i].AdmTypeID + '"></td></tr>'
                            $('#TableadmissionTypeList').append(trforappend);
                        }
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
        function FillField() {
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlFinancialYear1').val();
            AdmType = $('#ctl00_ContentPlaceHolder1_txtAdmissionType').val();
            if ($('#ctl00_ContentPlaceHolder1_chkIsActive').prop('checked') == true) {
                IsActive = 1;
            } else {
                IsActive = 0;
            }
        }
        function BindFinancialYears() {
            call_progressbar('start')
            //$('#TableAdmissionTypeList tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AdmissionType.aspx/getFinancialYears",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $.each(data.d, function (data, value) {
                            $("#ctl00_ContentPlaceHolder1_ddlFinancialYear1").append($("<option></option>").val(value.Fyid).html(value.FYName));
                        });
                        $("#ctl00_ContentPlaceHolder1_ddlFinancialYear1").val(data.d[0].CurrentFyid);
                    }
                    call_progressbar('end')
                },
                error: function (result) {
                    call_progressbar('end')
                }
            });
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;

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
    </script>
</asp:Content>

