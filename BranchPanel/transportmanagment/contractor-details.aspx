<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="contractor-details.aspx.cs" Inherits="BranchPanel_transportmanagment_contractor_details"  EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        th {
            border-bottom: 1px solid #CDCDCD !important;
        }

        .stm1 td {
            text-align: center;
            border-top: 0px;
        }

        input[type="text"], select, input[type="Password"] {
        }
        .stm1 {
            border-right: 1px solid #ddd;
            padding-bottom: 0px !important;
        }

        .inputtopictime {
            margin-bottom: 10px;
        }

       .showpopupdriver, .showpopupshowtopic {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            left: 50%;
            opacity: 1;
            max-height: 500px;
            display: block;
            overflow: auto;
            padding-bottom: 8px !important;
            top: 15%;
            width: 680px !important;
            margin-left: -250px !important;
        }

        .showpopup2 span {
            float: right;
            padding-left: 0;
            height: 1px;
            width: 1px;
        }

  .showpopup2 .for_sigle_row_form input[type="text"] {
    height: 24px;
    width: 228px;
  } 
        .t1 {
        }

        .t2 {
        }
            .t2 input {
                float: left;
                margin-top: 10px;
            }

            .t2 select {
                float: left;
                margin-top: 10px;
            }

    </style>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" >
         <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2 id="contractheader">Contractor Details</h2>
              <h2 id="DriverHeader" style="display:none">Driver Details</h2>
              <h2 id="HelperHeader" style="display:none">Helper Details</h2>
               <input type="submit" class="button_save BackData" value="Back" style="float:right;margin-top:5px;display:none"/>
        </div>
            <div id="divaddtopic" style="text-align: center; display: none;" class="">
            <div class="">

                <table class="showpopupdriver showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="2" class="pop-headng-sty">Add Driver
                            <a id="BtnCancelDriver" title="Close this from here"
                                class="btnClose">
                                <img src="../../images/popupcross.png"></a>
                            <a class="btnClose imageclose" style="display:none">
                                <img src="../../images/popupcross.png" style="cursor:pointer"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label><span style="color: red">*</span>Select Contractor</label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="ddlforselectcontractor" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Name Please"  id="txtdrivername" onkeypress="return lettersOnly(event)"/>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Contact No:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Contact No Please"  id="txtdrivermobile" onkeypress="return noAlphabets(event)" maxlength="15"/>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Email:</label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Email Please"  id="txtdriveremail"/>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Date:</label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Date Please"  id="txtdated" onkeypress="return false"/>&nbsp;
                        </td>
                         </tr>
                     <tr class="for_sigle_row_form" >
                        <td class="t1">
                            <label>
                                Address:</label>
                        </td>
                        <td class="t2">
                          <textarea type="text" placeholder="Enter Address Please"  id="txtaddress" style="margin-top:5px;margin-left:-212px;"></textarea>&nbsp;
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form" >
                        <td class="t1">
                            <label>
                                Remark:</label>
                        </td>
                        <td class="t2">
                          <textarea type="text" placeholder="Enter Remark Please"  id="txtdriverremark" style="margin-top:5px;margin-left:-212px;"></textarea>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                DL:</label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter DL Number" id="txtdriverdoc" style="width:230px;"/>
                          <input id="driverfileupload" type="file" onchange="ShowDriverPreview(this,'#driverfileupload');" title="Select" />
                          <img id="imgfordriver" style="height:110px;width:110px;display: none;  float:right" src="">
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitdriver" runat="server" Text="Submit" CssClass="button_save" style="margin-top:5px;"/>
                            <asp:Button ID="Btnclear" runat="server" Text="Clear" CssClass="button_cancel" style="margin-top:5px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

           <div id="divforhelper" style="text-align: center; display: none;" class="">
            <div class="">

                <table class="showpopuphelper showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="2" class="pop-headng-sty">Add Helper
                            <a id="displaydataofhelper" title="Close this from here"
                                class="btnClose helperclose">
                                <img src="../../images/popupcross.png"></a>
                             <a class="btnClose imagecloseHelper" style="display:none">
                                <img src="../../images/popupcross.png" style="cursor:pointer"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Select Contractor:
                                <span style="color: red">*</span>
                            </label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="ddlforhelper" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Name Please"  id="txthelpername" onkeypress="return lettersOnly(event)"/>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Contact No:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Contact No Please"  id="txthelpercontact" onkeypress="return noAlphabets(event)" maxlength="15"/>&nbsp;
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Date:</label>
                        </td>
                        <td class="t2">
                          <input type="text" placeholder="Enter Date Please"  id="txtdatehelper" onkeypress="return false"/>&nbsp;
                        </td>
                         </tr>
                     <tr class="for_sigle_row_form" >
                        <td class="t1">
                            <label>
                                Address:</label>
                        </td>
                        <td class="t2">
                          <textarea type="text" placeholder="Enter Address Please"  id="txthelperaddress" style="margin-top:5px;margin-left:-26px;"></textarea>&nbsp;
                        </td>
                    </tr>
            
                    <tr class="for_sigle_row_form" >
                        <td class="t1">
                            <label>
                                Remark:</label>
                        </td>
                        <td class="t2">
                          <textarea type="text" placeholder="Enter Remark Please"  id="txthelperremark" style="margin-top:5px;margin-left:-26px;"></textarea>&nbsp;
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="butnhelper" runat="server" Text="Submit" CssClass="button_save" style="margin-top:5px;"/>
                            <asp:Button ID="clearhelper" runat="server" Text="Clear" CssClass="button_cancel" style="margin-top:5px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
         <div class="divforstm bindcontractorsetails">
                <table class="stm bindcontractore" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:8%;">Contractor Name<a class="AddContractor" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                        <th align="center" scope="col" style="width:8%;">Mobile</th>
                         <th align="center" scope="col" style="width:10%;">e-mail</th>
                        <th align="center" scope="col" style="width:8%;">Driver<a class="addDriverforinsert" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                        <th align="center" scope="col" style="width:8%;">Helper<a class="addconductorforinsert" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                         <th align="center" scope="col" style="width:3%;">Edit</th>
                    </tr>
                </table>
            </div>
           <div class="divforstm binddriverdetails" style="display:none">
                <table class="stm binddriver" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:8%;">contractor Name</th>
                        <th align="center" scope="col" style="width:8%;">Name</th>
                         <th align="center" scope="col" style="width:10%;">Contact</th>
                        <th align="center" scope="col" style="width:8%;">Date</th>
                        <th align="center" scope="col" style="width:8%;">DL Number</th>
                         <th align="center" scope="col" style="width:3%;">Edit</th>
                    </tr>
                </table>
            </div>

              <div class="divforstm bindHelperdetails" style="display:none">
                <table class="stm bindHelper" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:8%;">contractor Name</th>
                        <th align="center" scope="col" style="width:8%;">Name</th>
                         <th align="center" scope="col" style="width:10%;">Contact</th>
                        <th align="center" scope="col" style="width:8%;">Date</th>
                         <th align="center" scope="col" style="width:3%;">Edit</th>
                    </tr>
                </table>
            </div>
        <div id="maindivforaddandshow" style="display:none">
         <div id="ccname" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Contractor Name<span style="color: Red;font-weight:bold">*</span></label>
                    <input type="text" placeholder="Enter Contract Name"  id="txtcomcontrctname" onkeypress="return lettersOnly(event)"/>&nbsp;                   
        </div>
        <div class="clear"></div>
         <div id="tinno" class="for_sigle_row_form" style="display: block;">
                    <label>
                       Tin No.</label>
                    <input type="text" placeholder="Enter Registration Number Please"  id="tinnumber"/>&nbsp;                   
        </div>
         <div id="sstax" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Service Tax No.</label>
                    <input type="text" placeholder="Enter Service Tax Number"  id="txtsstax"/>&nbsp;                   
        </div>
         <div id="contactno" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Contact No<span style="color: Red;font-weight:bold" >*</span></label>
                    <input type="text" placeholder="Enter Contact Number Please"  id="txtcontactnum" onkeypress="return noAlphabets(event)" maxlength="15"/>&nbsp;                   
        </div>
         <div id="emailid" class="for_sigle_row_form" style="display: block;">
                    <label>
                        email-ID</label>
                    <input type="text" placeholder="Enter Email ID Please"  id="txtemailid"/>&nbsp;                   
        </div>

            <div id="Div2" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Date</label>
                    <input type="text" placeholder="Enter Date Please"  id="txtdate" onkeypress="return false"/>&nbsp;                   
        </div>
        <div class="for_sigle_row_form" id="photoid" style="color: black">
            <label>
                   PanCard Number</label>
                   <input type="text" placeholder="Enter Document Name" id="txtpannum" style="width:288px;"/>
             <div class="clear"></div>
        </div>
        <div class="for_sigle_row_form" style="color: black">
            <label>
                  UpLoad PanCard</label>
            <input id="Pancard" type="file" onchange="ShowdocumentPreviewPancard(this,'#Pancard');" title="Select" />
            <img id="docimagename" style="height:110px;width:110px;display: none;  float:right" src="">
         </div>
            <div class="clear"></div>
        <div class="for_sigle_row_form" id="Div1" style="color: black">
           <label>
                   Address Document</label>
                   <input type="text" placeholder="Enter Document Name" id="txtContractDoc" style="width:288px;"/>
            <div class="clear"></div>
        </div>
            <div class="for_sigle_row_form" style="color: black">
                <label>
                   Upload Document</label>
                 <input id="documenttype" type="file" onchange="ShowdocumentPreview(this,'#documenttype');" title="Select" />
                   <img id="dynamicdocimage" style="height:110px;width:110px;display: none;  float:right" src="">
            </div>
            <div id="adrs" class="for_sigle_row_form" style="display: block;">
                    <label>
                        Address</label>
                    <textarea type="text" placeholder="Enter Address"  id="adresscompany" maxlength="500"></textarea>&nbsp;                   
           </div>
        <div class="for_sigle_row_form">
          <input type="submit" class="button_save SaveContractor" value="Submit" style="margin-left:150px;"/>
         <%--  <input type="submit" class="button_cancel Removedata" value="Clear" style="margin-left:20px;"/>--%>
            <input type="submit" class="button_cancel Cancelcon" value="Back" style="margin-top:5px;margin-left:20px;display:none"/>
        </div>
   
            </div>
         <div id="divProgressBar" class="progress"></div>
        </div>
    <script type="text/javascript">
        var Imgdocabt = "", getdocrsc = "", docFileUploadPath = "", docExtension = "";
        var imagepanabt = "", pandocgetrsc = "", PanVehicleFileUploadPath = "", PanExtension = "";
        var ShowHElperListMode = 0, hlprshowtxtid = 0, updatehelpermode = 0;
        var imagedriverdata = "", drivergetrsc = "", driverFileUploadPath = "", driverExtension = "";
        var mode = 2, updateid = 0, updatemode = 0, contractupdtid = 0, contractorforshow = 0, contractupdtidbb = 0, DriverMode = 0, updatedriverid = 0, DriverModeAddUpdate = 0;
        $(document).ready(function () {
            BindGrid(mode, updateid);
            $('.AddContractor').click(function () {
                updatemode = 1;
                $('#maindivforaddandshow').show(500);
                $('.AddContractor').hide(500);
                $('.Cancelcon').show(500)
                $('.bindcontractorsetails').hide(500)
                cleardata();
                return false;
            });
            $("#txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });

            $("#txtdated").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $("#txtdatehelper").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            //$('.Removedata').click(function () {
            //    cleardata();
            //    return false;
            //});
            $('.imgforeditcon').live('click',function () {
                mode = 3;
                updatemode = 4;
                updateid = $(this).parent('td').find('input[id*=contractid]').val();
                $('.bindcontractorsetails').hide(500);
                $('#maindivforaddandshow').show(500);
                $('.Cancelcon').show(300);
                $('.AddContractor').hide(300);
                BindGrid(mode, updateid)
                return false;
            });
            $("#txtemailid").blur(function () {
                var email = $(this).val()
                if (email != "") {
                    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                    if (!reg.test(email)) {
                        alertify.error('Please Enter Valid Email ID');
                        return false;
                    }
                }
            })
            $('.ViewConductor').live('click',function () {
                ShowHElperListMode = 9;
                $('.bindHelperdetails').show(500);
                $('.bindcontractorsetails').hide(500);
                $('.BackData').show(500);
                $('#HelperHeader').show()
                $('#contractheader').hide()
                contractupdtidbb = $(this).parent('td').parent('tr').find('input[id*=contractid]:last').val();
                BindGridHelperData(contractupdtidbb)
                return false;
            });
            $('.AddDriver').live('click', function () {
                DriverModeAddUpdate = 6;
                BindallContractor()
                driverdataclear()
                contractupdtid = $(this).parent('td').find('input[id*=condriverid]').val();
                $('#divaddtopic').show(500);
                $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').val(contractupdtid)
                $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').attr('disabled', true)
                return false;
            });
            $('.BackData').click(function () {
                $('.bindcontractorsetails').show(500);
                $('.binddriverdetails').hide(500);
                $('.bindHelperdetails').hide(500);
                $('.BackData').hide(500);
                $('#contractheader').show();
                $('#DriverHeader').hide();
                $('#HelperHeader').hide();
                $('#BtnCancelDriver').show();
                $('.imageclose').hide();
                $('.imagecloseHelper').hide();
                $('.helperclose').show();
                return false;
            });
            $('.addconductorforinsert').click(function () {
                updatehelpermode = 7;
                $('#divforhelper').show(500);
                $('#ctl00_ContentPlaceHolder1_ddlforhelper').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_ddlforhelper').val('0');
                BindallContractor();
                helpercleardata();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_clearhelper').click(function () {
                helpercleardata();
                return false;
            });
            
            $('#BtnCancelDriver').click(function () {
                $('#divaddtopic').hide(500);
                return false;
            });
            $('.showdataonclosedriver').click(function () {
                DriverMode = 8, updatedriverid = 0;
                BindGridDriverData(contractorforshow, updatedriverid)
                $('.binddriverdetails').show(500);
                return false;
            });

            $('.imageclose').click(function () {
                DriverMode = 8, updatedriverid = 0;
                BindGridDriverData(contractorforshow, updatedriverid)
                $('.binddriverdetails').show(500);
                $('#divaddtopic').hide(500);
                return false;
            });

            $('.Cancelcon').click(function () {
                mode = 2, updateid = 0;
                $('#maindivforaddandshow').hide(500);
                $('.AddContractor').show(500)
                $('.Cancelcon').hide(500)
                $('.bindcontractorsetails').show(500)
                cleardata()
                BindGrid(mode, updateid)
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_Btnclear').click(function () {
                driverdataclear()
                return false;
            });
            $('.imgforeditdr').live('click', function () {
                BindallContractor()
                DriverMode = 10;
                DriverModeAddUpdate = 11;
                updatedriverid = $(this).parent('td').find('input[id*=drid]').val();
                $('#divaddtopic').show(500);
                $('.binddriverdetails').hide(500);
                BindGridDriverData(contractorforshow, updatedriverid)
                $('.imageclose').show();
                $('#BtnCancelDriver').hide();
                return false;
            });

            $('.imgforedithlpr').live('click', function () {
                ShowHElperListMode = 12;
                updatehelpermode = 13;
                BindallContractor();
                hlprshowtxtid = $(this).parent('td').find('input[id*=hlprid]').val();
                $('#divforhelper').show(500);
                $('.bindHelperdetails').hide(500);
                BindGridHelperData(contractupdtidbb)
                $('.imagecloseHelper').show();
                $('.helperclose').hide();
                return false;
            });
            $('.addDriverforinsert').click(function () {
                contractupdtid = 0;
                DriverModeAddUpdate = 6;
                $('#divaddtopic').show(500);
                $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').attr('disabled', false)
                BindallContractor()
                driverdataclear();
                $('.imageclose').hide();
                return false;
            });
            $('.helperclose').click(function () {
                $('#divforhelper').hide(500);
                return false;
            });
            $('.imagecloseHelper').click(function () {
                ShowHElperListMode = 9;
                $('.bindHelperdetails').show(500);
                $('#divforhelper').hide(500);
                BindGridHelperData(contractupdtidbb)
            });
            $('.AddConductor').live('click', function () {
                updatehelpermode = 7;
                BindallContractor();
                helpercleardata();
                contractupdtidbb = $(this).parent('td').parent('tr').find('input[id*=contractid]:last').val();
                $('#ctl00_ContentPlaceHolder1_ddlforhelper').val(contractupdtidbb)
                $('#ctl00_ContentPlaceHolder1_ddlforhelper').attr('disabled',true)
                $('#divforhelper').show(500);
                return false;
            });
            $("#txtdriveremail").blur(function () {
                var email = $(this).val()
                if (email != "") {
                    var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
                    if (!reg.test(email)) {
                        alertify.error('Please Enter Valid Email ID');
                        return false;
                    }
                }
            })
            $('.ViewDriver').live('click', function () {
                DriverMode = 8;
                $('.bindcontractorsetails').hide(500);
                $('.binddriverdetails').show(500);
                $('.BackData').show(500);
                contractorforshow = $(this).parent('td').find('input[id*=condriverid]').val();
                BindGridDriverData(contractorforshow, updatedriverid)
                $('#contractheader').hide()
                $('#DriverHeader').show()
                return false;
            });
            $('.SaveContractor').click(function () {
                var status = 0;
                if ($('#txtcomcontrctname').val() == '') {
                    alertify.error('Please Enter Contractor Name')
                    $('#txtcomcontrctname').focus();
                    status = 1;
                    return false;
                }
                else if ($('#txtcontactnum').val() == '') {
                    alertify.error('Please Enter Contact Number')
                    $('#txtcontactnum').focus();
                    status = 1;
                    return false;
                }

                else {
                    SaveCotractdata()
                    status = 0
                    return false;
                }
            });
            $('#ctl00_ContentPlaceHolder1_BtnSubmitdriver').click(function () {
                var drstatus = 0;
                if ($('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').val() == ('0')) {
                    alertify.error('Select Contractor Please')
                    $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').focus();
                    drstatus = 1;
                    return false;
                }
                else if ($('#txtdrivername').val() == '') {
                    alertify.error('Enter Name Please')
                    $('#txtdrivername').focus();
                    drstatus = 1;
                    return false;
                }
                else if ($('#txtdrivermobile').val() == '') {
                    alertify.error('Enter Mobile Number Please')
                    $('#txtdrivermobile').focus();
                    drstatus = 1;
                    return false;
                }
                else if (drstatus == 0) {
                    Savedriverdataforinsert(DriverModeAddUpdate, updatedriverid)
                    $('.maindivforaddandshow').hide(500);
                    return false;
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_butnhelper').click(function () {
                var helperstatus = 0;
                if ($('#ctl00_ContentPlaceHolder1_ddlforhelper').val() == '0') {
                    alertify.error('Select Contractor Please')
                    helperstatus = 1;
                    return false;
                }
                else if ($('#txthelpername').val() == '') {
                    alertify.error('Enter Name Please')
                    $('#txthelpername').focus();
                    helperstatus = 1;
                    return false;
                }
                else if ($('#txthelpercontact').val() == '') {
                    alertify.error('Enter Number Please')
                    $('#txthelpercontact').focus();
                    helperstatus = 1;
                    return false;
                }
                else if (helperstatus == 0) {
                    Savehelperdatadataforinsert()
                    return false;
                }

                return false;
            });
            return false;
        });
        function driverdataclear() {
            $('#txtdrivername').val('');
            $('#txtdrivermobile').val('');
            $('#txtdriveremail').val('');
            $('#txtdated').val('');
            $('#txtdriverdoc').val('');
            $('#txtaddress').val('');
            $('#driverfileupload').val('');
            $('#imgfordriver').hide();
            $('#txtdriverremark').val('');
            return false;
        }

        function cleardata() {
            $('#txtcomcontrctname').val('');
            $('#adresscompany').val('');
            $('#tinnumber').val('');
            $('#txtsstax').val('');
            $('#txtcontactnum').val('');
            $('#txtemailid').val('');
            $('#txtpannum').val('');
            $('#txtContractDoc').val('');
            $('#Pancard').val('');
            $('#txtdate').val('');
            $('#documenttype').val('');
            $('#docimagename').hide(500);
            $('#dynamicdocimage').hide(500);
            return false;
        }
        function helpercleardata() {
            $('#txthelpername').val('')
            $('#txthelpercontact').val('')
            $('#txtdatehelper').val('')
            $('#txthelperaddress').val('')
            $('#txthelperremark').val('')
            return false;
        }
        //******* validation *********//
        function Logo_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            PanVehicleFileUploadPath = fuData.value;
            if (PanVehicleFileUploadPath != '') {
                PanExtension = PanVehicleFileUploadPath.substring(PanVehicleFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (PanExtension == "jpg" || PanExtension == "jpeg" || PanExtension == "png" || PanExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + PanExtension + " file for Image.");
                    return false;
                }

            }
        }
        function ValidationDocument(fileuploadforlogo) {

            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            docFileUploadPath = fuData.value;
            if (docFileUploadPath != '') {
                docExtension = docFileUploadPath.substring(docFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (docExtension == "jpg" || docExtension == "jpeg" || docExtension == "png" || docExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + docExtension + " file for image");
                    return false;
                }

            }
        }

        function ValidationDriver(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            driverFileUploadPath = fuData.value;
            if (driverFileUploadPath != '') {
                driverExtension = driverFileUploadPath.substring(driverFileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (driverExtension == "jpg" || driverExtension == "jpeg" || driverExtension == "png" || driverExtension == "gif") {
                    return true;
                }
                else {
                    alert("You can not upload " + driverExtension + " file for Image.");
                    return false;
                }

            }
        }
        //**********End of validation***********//
        //**********Show For Image Preview**********//
        function ShowdocumentPreviewPancard(input, controlId) {
            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    imagepanabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        pandocgetrsc = e.target.result;
                        $('#docimagename').attr('src', e.target.result);
                        $('#docimagename').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function ShowdocumentPreview(input, controlId) {
            var stat = ValidationDocument(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    Imgdocabt = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        getdocrsc = e.target.result;
                        $('#dynamicdocimage').attr('src', e.target.result);
                        $('#dynamicdocimage').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }

        function ShowDriverPreview(input, controlId) {
            var stat = ValidationDocument(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    imagedriverdata = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $(controlId).attr('src', e.target.result);
                        drivergetrsc = e.target.result;
                        $('#imgfordriver').attr('src', e.target.result);
                        $('#imgfordriver').show(500)
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        //**********End of validation***********//
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
    
        function SaveCotractdata() {
            var ContractName = $('#txtcomcontrctname').val().trim();
            var COntractAddress = $('#adresscompany').val().trim();
            var Contracttin = $('#tinnumber').val().trim();
            var contracsstax = $('#txtsstax').val().trim();
            var ContractCOntact = $('#txtcontactnum').val().trim();
            var ContractEmail = $('#txtemailid').val().trim();
            var ContractPan = $('#txtpannum').val().trim();
            var ContactDocument = $('#txtContractDoc').val().trim();
            var datetype = $('#txtdate').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/COntractordata",
                data: "{'ContractName':'" + ContractName.split("'").join("`") + "','COntractAddress':'" + COntractAddress.split("'").join("`") + "','Contracttin':'" + Contracttin.split("'").join("`") + "','contracsstax':'" + contracsstax.split("'").join("`") + "','ContractCOntact':'" + ContractCOntact.split("'").join("`") + "','ContractEmail':'" + ContractEmail.split("'").join("`") + "','ContractPan':'" + ContractPan.split("'").join("`") + "','ContactDocument':'" + ContactDocument.split("'").join("`") + "','Imgdocabt':'" + Imgdocabt + "','getdocrsc':'" + getdocrsc + "','docExtension':'" + docExtension + "','imagepanabt':'" + imagepanabt + "','pandocgetrsc':'" + pandocgetrsc + "','PanExtension':'" + PanExtension + "','datetype':'" + datetype + "','updatemode':'" + updatemode + "','updateid':'" + updateid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Submit Successfully");
                        $('#maindivforaddandshow').hide();
                        $('.bindcontractorsetails').show();
                        $('.AddContractor').show();
                        $('.Cancelcon').hide();
                        BindGrid(mode, updateid);
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        mode = 2, updateid = 0;
                        alertify.success("Update Successfully");
                        $('.bindcontractorsetails').show();
                        $('#maindivforaddandshow').hide();
                        $('.AddContractor').show();
                        $('.Cancelcon').hide();
                        BindGrid(mode, updateid);
                        call_progressbar("end");
                    }
                    if (data.d == 9) {
                        alertify.error("This Name Already Exists..");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
   
        function Savedriverdataforinsert(DriverModeAddUpdate, updatedriverid) {
            var Contractoridfordriver = $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').val().trim();
            var drivername= $('#txtdrivername').val().trim();
            var drivermob = $('#txtdrivermobile').val().trim();
            var driveremail = $('#txtdriveremail').val().trim();
            var driverdate = $('#txtdated').val().trim();
            var driverdoc = $('#txtdriverdoc').val().trim();
            var driveraddress = $('#txtaddress').val().trim();
            var driverremark = $('#txtdriverremark').val().trim();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/Driverdata",
                data: "{'Contractoridfordriver':'" + Contractoridfordriver + "','drivername':'" + drivername.split("'").join("`") + "','drivermob':'" + drivermob.split("'").join("`") + "','driveremail':'" + driveremail.split("'").join("`") + "','driverdate':'" + driverdate.split("'").join("`") + "','driverdoc':'" + driverdoc.split("'").join("`") + "','driveraddress':'" + driveraddress.split("'").join("`") + "','imagedriverdata':'" + imagedriverdata + "','drivergetrsc':'" + drivergetrsc + "','driverExtension':'" + driverExtension + "','driverremark':'" + driverremark + "','DriverModeAddUpdate':'" + DriverModeAddUpdate + "','updatedriverid':'" + updatedriverid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 3) {
                        mode = 2, updateid = 0;
                        alertify.success("Submit Successfully");

                        $('#divaddtopic').hide(500);
                        $('.bindcontractorsetails').show();
                        $('.AddContractor').show();
                        $('.Cancelcon').hide();
                        BindGrid(mode, updateid);
                        call_progressbar("end");
                    }
                    if (data.d == 5) {
                        DriverMode = 8, updatedriverid = 0;
                        alertify.success("Update Successfully");
                        BindGridDriverData(contractorforshow, updatedriverid)
                        $('.binddriverdetails').show(500);
                        $('#divaddtopic').hide(500);
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };
        function Savehelperdatadataforinsert() {
            var helpercontractorid = $('#ctl00_ContentPlaceHolder1_ddlforhelper').val().trim();
            var helpername = $('#txthelpername').val().trim();
            var helpercontact = $('#txthelpercontact').val().trim();
            var helperdate = $('#txtdatehelper').val().trim();
            var helperaddress = $('#txthelperaddress').val().trim();
            var helperremark = $('#txthelperremark').val().trim();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/helperdata",
                data: "{'helpercontractorid':'" + helpercontractorid + "','helpername':'" + helpername.split("'").join("`") + "','helpercontact':'" + helpercontact + "','helperdate':'" + helperdate + "','helperaddress':'" + helperaddress.split("'").join("`") + "','helperremark':'" + helperremark.split("'").join("`") + "','updatehelpermode':'" + updatehelpermode + "','hlprshowtxtid':'" + hlprshowtxtid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 4) {
                        mode = 2, updateid = 0;
                        alertify.success("Submit Successfully");
                        $('#divforhelper').hide(500);
                        BindGrid(mode, updateid);
                        call_progressbar("end");
                    }
                    if (data.d == 7) {
                        ShowHElperListMode = 9;
                        alertify.success("Update Successfully");
                        $('#divforhelper').hide(500);
                        $('.bindHelperdetails').show(500);
                        BindGridHelperData(contractupdtidbb)
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindGrid(mode, updateid) {
            var trforappend = "";
            $('.bindcontractore tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/BindGridByJscontractor",
                data: "{'mode':'" + mode + "','updateid':'" + updateid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (mode == 2) {
                                if (i % 2 != 0)
                                    trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].contractname + '</td><td>' + data.d[i].contractcontact + '</td><td>' + data.d[i].contractemail + '</td><td><input id="condriverid" type="hidden" value="' + data.d[i].contractorid + '"/>' + data.d[i].driver + '</td><td>' + data.d[i].conductor + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforeditcon"><input id="contractid" type="hidden" value="' + data.d[i].contractorid + '"/></td></tr>';
                                else
                                    trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].contractname + '</td><td>' + data.d[i].contractcontact + '</td><td>' + data.d[i].contractemail + '</td><td><input id="condriverid" type="hidden" value="' + data.d[i].contractorid + '"/>' + data.d[i].driver + '</td><td>' + data.d[i].conductor + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforeditcon"><input id="contractid" type="hidden" value="' + data.d[i].contractorid + '"/></td></tr>';
                                $('.bindcontractore').append(trforappend);
                            }
                            else if (mode == 3) {
                                $('#txtcomcontrctname').val(data.d[i].contractname);
                                $('#tinnumber').val(data.d[i].contracttin);
                                $('#txtsstax').val(data.d[i].contracsstax);
                                $('#txtcontactnum').val(data.d[i].contractcontact);
                                $('#txtemailid').val(data.d[i].contractemail);
                                $('#txtdate').val(data.d[i].date);
                                $('#txtpannum').val(data.d[i].ContractPan);
                                $('#txtContractDoc').val(data.d[i].ContactDocument);
                                $('#adresscompany').val(data.d[i].COntractAddress);
                                $('#dynamicdocimage').attr('src', '../images/' + data.d[i].Imgdocabt)
                                $('#dynamicdocimage').css("display", "block");
                                if (data.d[i].Imgdocabt == "")
                                    $('#dynamicdocimage').css("display", "none");
                                $('#docimagename').attr('src', '../images/' + data.d[i].imagepanabt)
                                $('#docimagename').css("display", "block");
                                if (data.d[i].imagepanabt == "")
                                    $('#docimagename').css("display", "none");
                            }
                        }
                        call_progressbar("end");
                    }
                    else {
                        alertify.error("No Any Contractor in this List");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindallContractor() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/bindcontractorddl",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlforselectcontractor").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlforhelper").html("");
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlforselectcontractor").append($("<option></option>").val(value.contractorid).html(value.ContractName));
                        $("#ctl00_ContentPlaceHolder1_ddlforhelper").append($("<option></option>").val(value.contractorid).html(value.ContractName));
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }

        function BindGridDriverData(contractorforshow, updatedriverid) {
            var trforappend = "";
            $('.binddriver tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/BindGridByJsDriver",
                data: "{'contractorforshow':'" + contractorforshow + "','DriverMode':'" + DriverMode + "','updatedriverid':'" + updatedriverid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (DriverMode == 8) {
                                if (i % 2 != 0)
                                  
                                    trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td><input id = "ctoridfordriverupdate" type = "hidden" value "' + data.d[i].ctorid + '"/>' + data.d[i].contractorname + '</td><td>' + data.d[i].name + '</td><td>' + data.d[i].mobile + '</td><td>' + data.d[i].con_date + '</td><td>' + data.d[i].driver_document + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforeditdr"><input id="drid" type="hidden" value="' + data.d[i].con_driverid + '"/></td></tr>';
                                else
                                    trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td><input id = "ctoridfordriverupdate" type = "hidden" value "' + data.d[i].ctorid + '"/>' + data.d[i].contractorname + '</td><td>' + data.d[i].name + '</td><td>' + data.d[i].mobile + '</td><td>' + data.d[i].con_date + '</td><td>' + data.d[i].driver_document + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforeditdr"><input id="drid" type="hidden" value="' + data.d[i].con_driverid + '"/></td></tr>';
                                $('.binddriver').append(trforappend);
                            }
                            else if (DriverMode == 10) {
                                $('#ctl00_ContentPlaceHolder1_ddlforselectcontractor').val(data.d[i].ctorid)
                                $('#txtdrivername').val(data.d[i].name)
                                $('#txtdrivermobile').val(data.d[i].mobile)
                                $('#txtdriveremail').val(data.d[i].email)
                                $('#txtdated').val(data.d[i].con_date)
                                $('#txtaddress').val(data.d[i].driver_address)
                                $('#txtdriverdoc').val(data.d[i].driver_document)
                                $('#txtdriverremark').val(data.d[i].driverremark)
                                $('#imgfordriver').attr('src', '../images/' + data.d[i].docimage)
                                $('#imgfordriver').css("display", "block");
                                if (data.d[i].docimage == "")
                                    $('#imgfordriver').css("display", "none");
                            }
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindGridHelperData(contractupdtidbb) {
            var trforappend = "";
            $('.bindHelper tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "contractor-details.aspx/BindGridByJsHelper",
                data: "{'contractupdtidbb':'" + contractupdtidbb + "','ShowHElperListMode':'" + ShowHElperListMode + "','hlprshowtxtid':'" + hlprshowtxtid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (ShowHElperListMode == 9) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].contractorname + '</td><td>' + data.d[i].helpername + '</td><td>' + data.d[i].helpercontact + '</td><td>' + data.d[i].helperdate + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforedithlpr"><input id="hlprid" type="hidden" value="' + data.d[i].helperid + '"/></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].contractorname + '</td><td>' + data.d[i].helpername + '</td><td>' + data.d[i].helpercontact + '</td><td>' + data.d[i].helperdate + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="imgforedithlpr"><input id="hlprid" type="hidden" value="' + data.d[i].helperid + '"/></td></tr>';
                            $('.bindHelper').append(trforappend);
                        }
                            else if (ShowHElperListMode == 12) {
                                $('#ctl00_ContentPlaceHolder1_ddlforhelper').val(data.d[i].contractorhelperid)
                                $('#txthelpername').val(data.d[i].helpername);
                                $('#txthelpercontact').val(data.d[i].helpercontact);
                                $('#txtdatehelper').val(data.d[i].helperdate);
                                $('#txthelperaddress').val(data.d[i].helperaddress);
                                $('#txthelperremark').val(data.d[i].helperremark);
                            }
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>
</asp:Content>

