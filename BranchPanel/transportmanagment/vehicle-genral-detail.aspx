<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="vehicle-genral-detail.aspx.cs" Inherits="BranchPanel_transportmanagment_vehicle_genral_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content" id="contentPane">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div class="sub-heading">
                    Vehicle Genral Details 
                </div>
                <div class="for_sigle_row_form" style="height: auto; margin-top: 11px;" id="Vehicleowner">
                    <label style="font-size: 18px; margin-top: -4px">Vehicle Type</label>
                    <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Own<input type="radio" style="margin-left: 10px" value="1" checked="checked" name="transporttype" /></label>
                    <label style="margin-left: 20px; width: 100px; text-align: left; font-weight: bold;">Contractor<input type="radio" style="margin-left: 6px" value="2" name="transporttype" /></label>
                </div>
                <div class="clear"></div>
                <div id="Currentdate" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Date<span style="color: Red; font-weight: bold">*</span></label>
                    <input type="text" placeholder="Enter Date Please" id="txtdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="VehicleregName" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Vehicle Reg No.<span style="color: Red; font-weight: bold">*</span></label>
                    <input type="text" placeholder="Enter Registration Number Please" id="txtregistrationname" maxlength="50"/>&nbsp;                   
                </div>
                <div id="VehicleType" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Vehicle Name<span style="color: Red; font-weight: bold">*</span></label>
                    <input type="text" placeholder="Enter Vehicle Type Please" id="txtVehicletype" maxlength="50"/>&nbsp;                   
                </div>
                <div id="makeby" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Make By (Comp.)</label>
                    <input type="text" placeholder="Enter Make By Company " id="txtmakecomp" maxlength="50"/>&nbsp;                   
                </div>
                <div id="numberseats" class="for_sigle_row_form" style="display: block">
                    <label>
                        No. Of Seats<span style="color: red; font-weight: bold">*</span></label>
                    <input type="text" placeholder="Enter Number Of Seats" id="txtnumofseats" onkeypress="return noAlphabets(event)" maxlength="3"/>
                </div>
                <div id="Modelnumber" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Model No.</label>
                    <input type="text" placeholder="Enter Model Number Please" id="txtmodelnum" maxlength="20"/>&nbsp;                   
                </div>
                <div id="vehiclecolor" class="for_sigle_row_form" style="display: block;" >
                    <label>
                        Color</label>
                    <input type="text" placeholder="Enter Color Please" id="txtcolor" maxlength="10"/>&nbsp;                   
                </div>
                <div id="Chachisnum" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Chassis No.</label>
                    <input type="text" placeholder="Enter Chassis Number" id="txtchassis" maxlength="30"/>&nbsp;                   
                </div>
                <div id="divforengin" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Engine No.</label>
                    <input type="text" placeholder="Enter Engine Number" id="txtengine" maxlength="30"/>&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="photoid" style="color: black">
                    <label>
                        Vehicle Photo</label>
                    <div id="divforuploadphoto" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="vehiclefileupload" onchange="ShowpImagePreviewvehicle(this,'#ctl00_ContentPlaceHolder1_vehiclefileupload');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="imgvehicle" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div id="remarkarea" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Comment/Remark</label>
                    <textarea type="text" placeholder="Enter Remark Please" id="txtareaforremark"></textarea>
                </div>
                <div class="clear"></div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Registration Details
                </div>
                <div class="clear"></div>
                <div id="Div4" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Registration No.</label>
                    <input type="text" id="txtRegnumber" disabled="disabled" />&nbsp;                   
                </div>
                <div id="Div2" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Reg. From Date</label>
                    <input type="text" placeholder="Enter Reg. From Date Please" id="txtregfrmdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div3" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Reg. Expiry Date</label>
                    <input type="text" placeholder="Enter  Reg. Expiry Date Please" id="txtregtilldate" onkeypress="return false" />&nbsp;                   
                </div>

                <div class="for_sigle_row_form" id="Div1" style="color: black">
                    <label>
                        Upload Reg. Detail</label>
                    <div id="divforregdetails" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileregdetail" onchange="ShowpImageregdetail(this,'#ctl00_ContentPlaceHolder1_fileregdetail');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="ImageRegistration" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Road Tax Details
                </div>
                <div class="clear"></div>
                <div id="Div5" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Road Tax From Date</label>
                    <input type="text" placeholder="Enter Road Tax From Date Please" id="txtroadfrmdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div6" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Road Tax Expiry Date</label>
                    <input type="text" placeholder="Enter Road Tax Expiry Date Please" id="txtroadtilldate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div8" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Next Road Tax Date</label>
                    <input type="text" placeholder="Enter Next Date Please" id="txtroadnxtdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div class="for_sigle_row_form" style="color: black">
                    <label>
                        Road Upload Detail</label>
                    <div id="divforroadpermit" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="fileroadpermitdetail" onchange="ShowpImagePreviewRoadPermit(this,'#ctl00_ContentPlaceHolder1_fileroadpermitdetail');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="ImageROadPermit" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Fitness Certificate Details
                </div>
                <div class="clear"></div>
                <div id="Div13" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Fitness Certificate From Date</label>
                    <input type="text" placeholder="Enter  Fitness Certificate From Date Please" id="txtfitfromdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div14" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Fitness Certificate Expiry Date</label>
                    <input type="text" placeholder="Enter Fitness Certificate Expiry Date Please" id="txtfittilldate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div15" class="for_sigle_row_form" style="display: block;">
                    <label>
                       Fitness Certificate Next Date</label>
                    <input type="text" placeholder="Enter Fitness Certificate Next Date Please" id="txtfitnxtdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div class="for_sigle_row_form" style="color: black">
                    <label>
                        Fitness Certificate Upload Detail</label>
                    <div id="divforfitnesscard" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="FileFitnessCard" onchange="ShowpImagePreviewFitness(this,'#ctl00_ContentPlaceHolder1_FileFitnessCard');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="ImageFitnessCard" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Insurance Co. Details      
                </div>
                <div class="clear"></div>
                <div class="clear"></div>
                <div id="Insurancecomp" class="for_sigle_row_form" style="display: block;">
                    <label>Insurance Company Name</label>
                    <input type="text" placeholder="Enter Insurance Company Name" id="txtiInsompname" maxlength="50"/>&nbsp;                   
                </div>
                <div class="clear"></div>
                <div id="insnum" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Insurance Policy No.</label>
                    <input type="text" placeholder="Enter Insurance Number" id="txtinsurncenum" maxlength="30"/>&nbsp;                   
                </div>
                <div id="inscontactnum" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Contact Number</label>
                    <input type="text" placeholder="Enter Contact Number" id="txtinscontactnumber" onkeypress="return noAlphabets(event)" maxlength="15"/>&nbsp;                   
                </div>
                <div id="nxtinsnumber" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Next Insurance Date</label>
                    <input type="text" placeholder="Enter Date Please" id="txtnxtinsdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="Div7" style="color: black">
                    <label>
                        Insurance Detail</label>
                    <div id="divforinsurancedetail" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="Fileinsurancedetail" onchange="ShowpImagePreviewInsurance(this,'#ctl00_ContentPlaceHolder1_Fileinsurancedetail');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="ImageInsurance" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div class="clear"></div>
                <div class="sub-heading">
                    Pollution Certificate Details        
                </div>
                <div id="Div9" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Pollution From Date</label>
                    <input type="text" placeholder="Enter Date Please" id="txtvailiddate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div10" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Pollution Expiry Date</label>
                    <input type="text" placeholder="Enter Expiry Date Please" id="txtvailidtilldate" onkeypress="return false" />&nbsp;                   
                </div>
                <div id="Div11" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Next Pollution Date</label>
                    <input type="text" placeholder="Enter Next Pollution Date Please" id="txtnxtdate" onkeypress="return false" />&nbsp;                   
                </div>
                <div class="for_sigle_row_form" id="Div12" style="color: black">
                    <label>
                        Upload Pollution Detail</label>
                    <div id="divforpolutiondetail" style="width: 357px; border: 1px solid; border-color: #ccc; margin-left: 240px; height: 24px; padding-top: 3px; padding-bottom: 3px;">
                        <asp:FileUpload runat="server" ID="Fileuploadpolution" onchange="ShowpImagePreviewPolution(this,'#ctl00_ContentPlaceHolder1_Fileuploadpolution');"
                            ToolTip="Select" />
                    </div>
                    <div class="clear"></div>
                    <asp:Image runat="server" ID="ImagePolutionDetail" Width="110px" Height="110px" Style="display: none; float: right" />
                </div>
                <div class="clear"></div>
                <div class="showcontractordetails" style="display: none">
                    <div class="sub-heading">
                        Contractor Details      
                    </div>
                    <div class="for_sigle_row_form" style="display: block">
                        <label>
                            Select Contractor</label>
                        <select id="ddlcontractor"></select>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Driver</label>
                        <select id="ddldriver">
                            <option value="0">--Select Driver--</option>
                        </select>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Helper</label>
                        <select id="ddlhelper">
                            <option value="0">--Select Helper--</option>
                        </select>
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <input type="submit" class="button_save submitallrecord" value="Submit" style="margin-left: 250px;" />
                    <input type="submit" class="button_cancel clearallvalue" value="Clear" style="text-align: center" />
                    <input type="submit" class="button_cancel Backtovehiclelist" value="Back" style="text-align: center;display:none" />
                </div>
            </div>
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var ImgRegdocabt = "", getREGdocrsc = "", docRegFileUploadPath = "", docRegExtension = "", changecontractorid = 0, vehicletypeid = 1, vehicleupdateid = 0, vehicletypechangeid = 0;
        var imagevehicleabt = "", vehiclegetrsc = "", VehicleFileUploadPath = "", VehicleExtension = "";
        var docROadFileUploadPath = '', docRoadExtension = '', docFittFileUploadPath = '', docfitExtension = '';
        var docInsuFileUploadPath = '', docInsuExtension = '', docPoluExtension = '', docpoluFileUploadPath = '';
        var ImgRoaddocabt = '', getRoaddocrsc = '', ImgFitnessdocabt = '', getFitnessdocrsc = '';
        var Imginsudocabt = '', getinsudocrsc = '', ImgPolutiondocabt = '', getPolutiondocrsc = '';
        var RegFromdate = '', Regtilldate = '', RoadFromdate = '', RoadTilldate = '', Fitfromdate = '', Fittilldate = '', PolutionVdate = '', Polutiontilldate = '';
        var AddUpdateMode = 2;
        $(document).ready(function () {
            BindContractorddl();
            CallMethod();
            $('.clearallvalue').click(function () {
                ClearAllDatatxtBox();
                return false;
            });
            $('.imageforadd').live('click', function () {
                var trforadd = $(this).parent('td').parent('tr').prop('outerHTML');
                $('.addtr').append(trforadd);
                $('.addtr').find('tr:last').find('.imageforadd').attr('src', '../../images/minus.png');
                $('.addtr').find('tr:last').find('img').removeClass('imageforadd');
                $('.addtr').find('tr:last').find('img').addClass('imageforsub');
                return false;
            });
            $('#txtregistrationname').keyup(function () {
                var rid = $(this).val()
                $('#txtRegnumber').val(rid)
                return false;
            });
            $("#txtnxtinsdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtvailiddate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtvailidtilldate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtnxtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtregfrmdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtregtilldate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtroadfrmdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtroadtilldate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtroadnxtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtfittilldate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtfitfromdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtfitnxtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });

            $('#ddlcontractor').change(function () {
                changecontractorid = $(this).val();
                BindddlAreaAndDriver()
                return false;
            });
            $('.Backtovehiclelist').click(function () {
                window.location.href = "vehicle-list.aspx";
                return false;
            });
            $('.imageforsub').live('click', function () {
                $(this).parent('td').parent('tr').remove();
            });
            $('#txtregtilldate').change(function () {
                RegFromdate = $('#txtregfrmdate').val();
                if ($(this).val() < RegFromdate) {
                    alertify.error("Reg. Expiry Date Can Not Be Less Then Reg. From Date")
                    $('#txtregtilldate').val('');
                    $('#txtregtilldate').focus();
                }
                return false;
            });
            $('#txtroadtilldate').change(function () {
                RoadFromdate = $('#txtroadfrmdate').val();
                if ($(this).val() < RoadFromdate) {
                    alertify.error("Road Tax Expiry Date Can Not Be Less Then Road Tax From Date")
                    $('#txtroadtilldate').val('');
                    $('#txtroadtilldate').focus();
                }
                return false;
            });

            $('#txtroadnxtdate').change(function () {
                RoadFromdate = $('#txtroadfrmdate').val();
                RoadTilldate = $('#txtroadtilldate').val();
                if ($(this).val() < RoadFromdate) {
                    alertify.error("Next Road Tax Date Can Not Be Less Then Road Tax From Date")
                    $('#txtroadnxtdate').val('');
                    $('#txtroadnxtdate').focus();
                }
                else if ($(this).val() < RoadTilldate) {
                    alertify.error("Next Road Tax Date Can Not Be Less Then Road Tax Expiry Date")
                    $('#txtroadnxtdate').val('');
                    $('#txtroadnxtdate').focus();
                }
                return false;
            });

            $('#txtfittilldate').change(function () {
                Fitfromdate = $('#txtfitfromdate').val();
                if ($(this).val() < Fitfromdate) {
                    alertify.error("F.C. Expiry Date Can Not Be Less Then F.C. From Date")
                    $('#txtfittilldate').val('');
                    $('#txtfittilldate').focus();
                }
                return false;
            });

            $('#txtfitnxtdate').change(function () {
                Fitfromdate = $('#txtfitfromdate').val();
                Fittilldate = $('#txtfittilldate').val();
                if ($(this).val() < Fitfromdate) {
                    alertify.error("F.C. Next Date Can Not Be Less Then F.C. From Date")
                    $('#txtfitnxtdate').val('');
                    $('#txtfitnxtdate').focus();
                }
                else if ($(this).val() < Fittilldate) {
                    alertify.error("F.C. Next Date Can Not Be Less Then F.C. Expiry Date")
                    $('#txtfitnxtdate').val('');
                    $('#txtfitnxtdate').focus();
                }
                return false;
            });

            $('#txtvailidtilldate').change(function () {
                PolutionVdate = $('#txtvailiddate').val();
                if ($(this).val() < PolutionVdate) {
                    alertify.error("Pollution Expiry Date Can Not Be Less Then Pollution From Date")
                    $('#txtvailidtilldate').val('');
                    $('#txtvailidtilldate').focus();
                }
                return false;
            });

            $('#txtnxtdate').change(function () {
                PolutionVdate = $('#txtvailiddate').val();
                Polutiontilldate = $('#txtvailidtilldate').val();
                if ($(this).val() < PolutionVdate) {
                    alertify.error("Next Pollution Date Can Not Be Less Then Pollution From Date")
                    $('#txtnxtdate').val('');
                    $('#txtnxtdate').focus();
                }
                else if ($(this).val() < Polutiontilldate) {
                    alertify.error("Next Pollution Date Can Not Be Less Then Pollution Pollution Expiry Date")
                    $('#txtnxtdate').val('');
                    $('#txtnxtdate').focus();
                }
                return false;
            });


            $("input:radio[name=transporttype]").change(function () {
                vehicletypechangeid = $(this).val();
                if (vehicletypechangeid == 2) {
                    $('.showcontractordetails').show(500);
                    return false;
                }
                else if (vehicletypechangeid == 1) {
                    $('.showcontractordetails').hide(500);
                    $('#ddlcontractor').val('0');
                    $('#ddldriver').val('0');
                    $('#ddlhelper').val('0');
                    return false;
                }
                return false;
            });
            $('.submitallrecord').click(function () {
                if ($('#txtdate').val() == '') {
                    alertify.error("Enter Date Please");
                    $('#txtdate').focus();
                    return false;
                }
                if ($('#txtregistrationname').val() == '') {
                    alertify.error("Enter Registration Number Please");
                    $('#txtregistrationname').focus();
                    return false;
                }
                if ($('#txtVehicletype').val() == '') {
                    alertify.error("Enter Vehicle Name Please");
                    $('#txtVehicletype').focus();
                    return false;
                }
                if ($('#txtnumofseats').val() == '') {
                    alertify.error("Enter Seat Number Please");
                    $('#txtnumofseats').focus();
                    return false;
                }
                else {
                    Savevehicledata()
                    return false;
                }
            });

        });
        function ClearAllDatatxtBox() {
            $('#txtregistrationname').val('');
            $('#txtVehicletype').val('');
            $('#txtmakecomp').val('');
            $('#txtmodelnum').val('');
            $('#txtcolor').val('');
            $('#txtchassis').val('');
            $('#txtiInsompname').val('');
            $('#txtinsurncenum').val('');
            $('#txtinscontactnumber').val('');
            $('#txtnxtinsdate').val('');
            $('#txtdate').val('');
            $('#txtareaforremark').val('');
            $('#txtnumofseats').val('');
            $('#txtengine').val('');
            $('#txtengine').val('');
            $('#txtvailiddate').val('');
            $('#txtvailidtilldate').val('');
            $('#txtnxtdate').val('');
            $('#txtRegnumber').val('')
            $('#txtregfrmdate').val('');
            $('#txtregtilldate').val('');
            $('#txtroadfrmdate').val('');
            $('#txtroadtilldate').val('');
            $('#txtroadnxtdate').val('');
            $('#txtfitfromdate').val('');
            $('#txtfittilldate').val('');
            $('#txtfitnxtdate').val('');
            $("#ctl00_ContentPlaceHolder1_imgvehicle").hide();
            $("#ctl00_ContentPlaceHolder1_ImageRegistration").hide();
            $("#ctl00_ContentPlaceHolder1_ImageROadPermit").hide();
            $("#ctl00_ContentPlaceHolder1_ImageFitnessCard").hide();
            $("#ctl00_ContentPlaceHolder1_ImageInsurance").hide();
            $("#ctl00_ContentPlaceHolder1_ImagePolutionDetail").hide();
            $("#ctl00_ContentPlaceHolder1_vehiclefileupload").val('');
            $("#ctl00_ContentPlaceHolder1_fileregdetail").val('');
            $("#ctl00_ContentPlaceHolder1_fileroadpermitdetail").val('');
            $("#ctl00_ContentPlaceHolder1_FileFitnessCard").val('');
            $("#ctl00_ContentPlaceHolder1_Fileinsurancedetail").val('');
            $("#ctl00_ContentPlaceHolder1_Fileuploadpolution").val('');
            $("#ddlcontractor").val('');
            $("#ddldriver").val('');
            $("#ddlhelper").val('');
            return false;
        }
        function CallMethod() {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    AddUpdateMode = 5
                    vehicleupdateid = urlparam[1];
                    bindtextfillonclickEdit(urlparam[1])
                    $('.clearallvalue').hide();
                    $('.Backtovehiclelist').show();
                }
            }
            //For Finding That Coming For Edit End Here
        }

        function Savevehicledata() {
            vehicletypeid = $("input[type='radio'][name='transporttype']:checked").val();
            var Contractorid = 0, Contractordriverid = 0, ContractorHelperid = 0;
            Contractorid = $('#ddlcontractor').val();
            Contractordriverid = $('#ddldriver').val();
            ContractorHelperid = $('#ddlhelper').val();
            var Date = $('#txtdate').val().trim();
            var regno = $('#txtregistrationname').val().split("'").join("`");
            var vehiclename = $('#txtVehicletype').val().split("'").join("`");
            var Makeby = $('#txtmakecomp').val().split("'").join("`");
            var NOofSeate = $('#txtnumofseats').val().trim();
            var ModelNo = $('#txtmodelnum').val().split("'").join("`");
            var Color = $('#txtcolor').val().split("'").join("`");
            var ChassisNo = $('#txtchassis').val().split("'").join("`");
            var EnginNo = $('#txtengine').val().split("'").join("`");
            var Remark = $('#txtareaforremark').val().split("'").join("`");
            var InsComp = $('#txtiInsompname').val().split("'").join("`");
            var InsNo = $('#txtinsurncenum').val().split("'").join("`");
            var InsContact = $('#txtinscontactnumber').val().trim();
            var InsDate = $('#txtnxtinsdate').val().trim();
                PolutionVdate = $('#txtvailiddate').val().trim();
                Polutiontilldate = $('#txtvailidtilldate').val().trim();
            var Polutionnxtdate = $('#txtnxtdate').val().trim();
                RegFromdate = $('#txtregfrmdate').val().trim();
                Regtilldate = $('#txtregtilldate').val().trim();
                RoadFromdate = $('#txtroadfrmdate').val().trim();
                RoadTilldate = $('#txtroadtilldate').val().trim();
            var Roadnxtdate = $('#txtroadnxtdate').val().trim();
                Fitfromdate = $('#txtfitfromdate').val().trim();
                Fittilldate = $('#txtfittilldate').val().trim();
            var fitnextdate = $('#txtfitnxtdate').val().trim();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-genral-detail.aspx/vehicledata",
                data: "{'vehicletypeid':'" + vehicletypeid + "','Contractorid':'" + Contractorid + "','Contractordriverid':'" + Contractordriverid + "','ContractorHelperid':'" + ContractorHelperid + "','Date':'" + Date + "','regno':'" + regno + "','vehiclename':'" + vehiclename + "','Makeby':'" + Makeby + "','NOofSeate':'" + NOofSeate + "','ModelNo':'" + ModelNo + "','Color':'" + Color + "','ChassisNo':'" + ChassisNo + "','EnginNo':'" + EnginNo + "','Remark':'" + Remark + "','InsComp':'" + InsComp + "','InsNo':'" + InsNo + "','InsContact':'" + InsContact + "','InsDate':'" + InsDate + "','PolutionVdate':'" + PolutionVdate + "','Polutiontilldate':'" + Polutiontilldate + "','Polutionnxtdate':'" + Polutionnxtdate + "','ImgRegdocabt':'" + ImgRegdocabt + "','getREGdocrsc':'" + getREGdocrsc + "','docRegExtension':'" + docRegExtension + "','imagevehicleabt':'" + imagevehicleabt + "','vehiclegetrsc':'" + vehiclegetrsc + "','VehicleExtension':'" + VehicleExtension + "','docRoadExtension':'" + docRoadExtension + "','docfitExtension':'" + docfitExtension + "','docInsuExtension':'" + docInsuExtension + "','docPoluExtension':'" + docPoluExtension + "','ImgRoaddocabt':'" + ImgRoaddocabt + "','getRoaddocrsc':'" + getRoaddocrsc + "','ImgFitnessdocabt':'" + ImgFitnessdocabt + "','getFitnessdocrsc':'" + getFitnessdocrsc + "','Imginsudocabt':'" + Imginsudocabt + "','getinsudocrsc':'" + getinsudocrsc + "','ImgPolutiondocabt':'" + ImgPolutiondocabt + "','getPolutiondocrsc':'" + getPolutiondocrsc + "','RegFromdate':'" + RegFromdate + "','Regtilldate':'" + Regtilldate + "','RoadFromdate':'" + RoadFromdate + "','RoadTilldate':'" + RoadTilldate + "','Roadnxtdate':'" + Roadnxtdate + "','Fitfromdate':'" + Fitfromdate + "','Fittilldate':'" + Fittilldate + "','fitnextdate':'" + fitnextdate + "','AddUpdateMode':'" + AddUpdateMode + "','vehicleupdateid':'" + vehicleupdateid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alert("Submit Successfully");
                        window.location.href = "vehicle-list.aspx"
                        call_progressbar("end");
                        return false;
                    }
                    if (data.d == 4) {
                        alert("Update Successfully");
                        window.location.href = "vehicle-list.aspx"
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        alertify.error("This Registration No. Already Exist")
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (data) {
                    alertify.error("Some Network Problem..");
                }
            });
        }
        //*******Validation for NO ALphabet*********//
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        //*****End OF Code****************//
        //******* validation *********//
        function Logo_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            VehicleFileUploadPath = fuData.value;
            if (VehicleFileUploadPath != '') {
                VehicleExtension = VehicleFileUploadPath.substring(VehicleFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (VehicleExtension == "jpg" || VehicleExtension == "jpeg" || VehicleExtension == "png" || VehicleExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + VehicleExtension + " file for Image.");
                    return false;
                }

            }
        }
        function ValidationRegDocument(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docRegFileUploadPath = fuData.value;
            if (docRegFileUploadPath != '') {
                docRegExtension = docRegFileUploadPath.substring(docRegFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docRegExtension == "jpg" || docRegExtension == "jpeg" || docRegExtension == "png" || docRegExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docRegExtension + " file for image");
                    return false;
                }

            }
        }
        function ValidationRoaddocument(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docROadFileUploadPath = fuData.value;
            if (docROadFileUploadPath != '') {
                docRoadExtension = docROadFileUploadPath.substring(docROadFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docRoadExtension == "jpg" || docRoadExtension == "jpeg" || docRoadExtension == "png" || docRoadExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docRoadExtension + " file for image");
                    return false;
                }

            }
        }
        function ValidationFittDocument(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docFittFileUploadPath = fuData.value;
            if (docFittFileUploadPath != '') {
                docfitExtension = docFittFileUploadPath.substring(docFittFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docfitExtension == "jpg" || docfitExtension == "jpeg" || docfitExtension == "png" || docfitExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docfitExtension + " file for image");
                    return false;
                }

            }
        }
        function ValidationInsuDocument(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docInsuFileUploadPath = fuData.value;
            if (docInsuFileUploadPath != '') {
                docInsuExtension = docInsuFileUploadPath.substring(docInsuFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docInsuExtension == "jpg" || docInsuExtension == "jpeg" || docInsuExtension == "png" || docInsuExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docInsuExtension + " file for image");
                    return false;
                }

            }
        }
        function ValidationPolutionDocument(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docpoluFileUploadPath = fuData.value;
            if (docpoluFileUploadPath != '') {
                docPoluExtension = docpoluFileUploadPath.substring(docpoluFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docPoluExtension == "jpg" || docPoluExtension == "jpeg" || docPoluExtension == "png" || docPoluExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docPoluExtension + " file for image");
                    return false;
                }

            }
        }
        //**********End of validation***********//
        //**********Show For Image Preview**********//
        function ShowpImagePreviewvehicle(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    imagevehicleabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        vehiclegetrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_imgvehicle').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_imgvehicle').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImageregdetail(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    ImgRegdocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getREGdocrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_ImageRegistration').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_ImageRegistration').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImagePreviewRoadPermit(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    ImgRoaddocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getRoaddocrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_ImageROadPermit').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_ImageROadPermit').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImagePreviewFitness(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    ImgFitnessdocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getFitnessdocrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_ImageFitnessCard').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_ImageFitnessCard').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImagePreviewInsurance(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    Imginsudocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getinsudocrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_ImageInsurance').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_ImageInsurance').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowpImagePreviewPolution(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    ImgPolutiondocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getPolutiondocrsc = e.target.result;
                        $('#ctl00_ContentPlaceHolder1_ImagePolutionDetail').attr('src', e.target.result);
                        $('#ctl00_ContentPlaceHolder1_ImagePolutionDetail').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
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
        //**********End of validation***********//
    </script>
    <script type="text/javascript">

        function BindContractorddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-genral-detail.aspx/contractorlist",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlcontractor").html("");
                    $.each(data.d, function (key, value) {
                        if (value.contractName != null) {
                            $("#ddlcontractor").append($("<option></option>").val(value.contractorid).html(value.contractName));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error...');
                },
            });
        }
        function BindddlAreaAndDriver() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-genral-detail.aspx/binddriverhlpr",
                data: "{'changecontractorid':'" + changecontractorid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddldriver").html("");
                    $("#ddlhelper").html("");
                    $("#ddldriver").append($("<option></option>").val('0').html('--Select Driver--'));
                    $("#ddlhelper").append($("<option></option>").val('0').html('--Select Helper--'));
                    $.each(data.d, function (key, value) {
                        if (value.name != null) {
                            $("#ddldriver").append($("<option></option>").val(value.Con_driverid).html(value.name));
                        }
                        if (value.helpername != null) {
                            $("#ddlhelper").append($("<option></option>").val(value.helperid).html(value.helpername));
                        }
                    });
                },
                error: function (result) {
                    alertify.error('error ...driver');
                },
            });
        }

        function bindtextfillonclickEdit(vehicleupdateid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-genral-detail.aspx/BindTextFieldsVehicle",
                data: "{'vehicleupdateid':'" + vehicleupdateid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (data.d[i].Vehicletypeid == 2) {
                                $("input:radio[name='transporttype'][value='" + data.d[i].Vehicletypeid + "']").prop('checked', true)
                                $('.showcontractordetails').show(500);
                                $("#ddlcontractor").val(data.d[i].Contractorid);
                                changecontractorid = data.d[i].Contractorid
                                BindddlAreaAndDriver()
                                $("#ddldriver").val(data.d[i].Driverid);
                                $("#ddlhelper").val(data.d[i].Helperid);
                            }
                            else if (data.d[i].Vehicletypeid == 1) {
                                $('.showcontractordetails').hide(500);
                            }
                            $("#txtdate").val(data.d[i].date)
                            $("#txtregistrationname").val(data.d[i].VehicleRegNo)
                            $("#txtVehicletype").val(data.d[i].Vehiclename)
                            $("#txtmakecomp").val(data.d[i].Vehiclemake)
                            $("#txtnumofseats").val(data.d[i].Numberofseats)
                            $("#txtmodelnum").val(data.d[i].Modelnum)
                            $("#txtcolor").val(data.d[i].Color)
                            $("#txtchassis").val(data.d[i].ChassisNo)
                            $("#txtengine").val(data.d[i].EnginNo)
                            $("#txtareaforremark").val(data.d[i].Remark)
                            $("#txtRegnumber").val(data.d[i].VehicleRegNo)
                            $("#txtregfrmdate").val(data.d[i].RegFromDate)
                            $("#txtregtilldate").val(data.d[i].RegtillDate)
                            $("#txtroadfrmdate").val(data.d[i].RoadFromDate)
                            $("#txtroadtilldate").val(data.d[i].RoadtillDate)
                            $("#txtroadnxtdate").val(data.d[i].RoadNextDate)
                            $("#txtfitfromdate").val(data.d[i].Fittnessfromdate)
                            $("#txtfittilldate").val(data.d[i].FitnesstillDate)
                            $("#txtfitnxtdate").val(data.d[i].Fitnessnextdate)
                            $("#txtiInsompname").val(data.d[i].Insurancecompname)
                            $("#txtinsurncenum").val(data.d[i].InsuranceNo)
                            $("#txtinscontactnumber").val(data.d[i].ContactNo)
                            $("#txtnxtinsdate").val(data.d[i].NextinsuranceDate)
                            $("#txtvailiddate").val(data.d[i].Vailidfromdate)
                            $("#txtvailidtilldate").val(data.d[i].Vailidtilldate)
                            $("#txtnxtdate").val(data.d[i].Polutionnextdate)
                            $('#ctl00_ContentPlaceHolder1_ImagePolutionDetail').attr('src', '../images/' + data.d[i].PolutionPhoto)
                            $('#ctl00_ContentPlaceHolder1_ImagePolutionDetail').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_ImageInsurance').attr('src', '../images/' + data.d[i].Insurancephoto);
                            $('#ctl00_ContentPlaceHolder1_ImageInsurance').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_ImageFitnessCard').attr('src', '../images/' + data.d[i].Fitnessphoto);
                            $('#ctl00_ContentPlaceHolder1_ImageFitnessCard').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_ImageROadPermit').attr('src', '../images/' + data.d[i].Roadphoto)
                            $('#ctl00_ContentPlaceHolder1_ImageROadPermit').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_ImageRegistration').attr('src', '../images/' + data.d[i].Regphoto);
                            $('#ctl00_ContentPlaceHolder1_ImageRegistration').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_imgvehicle').attr('src', '../images/' + data.d[i].Vehiclephoto);
                            $('#ctl00_ContentPlaceHolder1_imgvehicle').css("display", "block");
                            if (data.d[i].PolutionPhoto == "")
                                $('#ctl00_ContentPlaceHolder1_ImagePolutionDetail').css("display", "none");
                            if (data.d[i].Insurancephoto == "")
                                $('#ctl00_ContentPlaceHolder1_ImageInsurance').css("display", "none");
                            if (data.d[i].Fitnessphoto == "")
                                $('#ctl00_ContentPlaceHolder1_ImageFitnessCard').css("display", "none");
                            if (data.d[i].Roadphoto == "")
                                $('#ctl00_ContentPlaceHolder1_ImageROadPermit').css("display", "none");
                            if (data.d[i].Regphoto == "")
                                $('#ctl00_ContentPlaceHolder1_ImageRegistration').css("display", "none");
                            if (data.d[i].Vehiclephoto == "")
                                $('#ctl00_ContentPlaceHolder1_imgvehicle').css("display", "none");
                            call_progressbar("end");
                        }
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error('Some Network Issue Occur.');
                },
            });
        }
    </script>
</asp:Content>

