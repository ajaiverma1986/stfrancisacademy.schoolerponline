<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="receipt_setting.aspx.cs" Inherits="HO_receipt_setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .for_sigle_row_form label {
            width: 220px;
        }

        .auto-style1 {
            height: 23px;
        }

        .input_content hr {
            border: none;
            height: 1px;
            color: #717171;
            background-color: #000;
        }

        .content_pane_cont span {
            font-weight: bold;
            color: #000;
        }

        #getbranchlist input[type="text"], input[type="select"], input[type="Password"] {
            -moz-appearance: none;
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 24px;
            line-height: 20px;
            outline: medium none;
            padding: 3px 6px;
            text-align: left;
            width: 287px;
        }
    </style>
    <div class="content_pane_cont" id="contentPane">
        <div class="content_top">
             <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Receipt Settings</span>
    </div>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Service TAX No.:<span style="color: Red;"> </span>
            </label>
            <asp:TextBox ID="txtServicetax" MaxLength="15" runat="server" placeholder="Enter Service Tax No."></asp:TextBox>
            <input id="sevicetax" type="checkbox" />
        </div>
        <div class="for_sigle_row_form">
            <label>
                TIN :<span style="color: Red;"> </span>
            </label>
            <asp:TextBox ID="txttin" onkeypress="return noAlphabets(event)" MaxLength="11" runat="server" placeholder="Enter TIN Number"></asp:TextBox>
            <input id="chktin" type="checkbox" />
        </div>
        <div class="for_sigle_row_form">
            <label>
                Contact No.:<span style="color: Red;"> </span>
            </label>
            <asp:TextBox ID="txtvat" onkeypress="return isNumberKey(event)" MaxLength="12" runat="server" placeholder="Enter Contact No."></asp:TextBox>
            <input id="Chkcontact" type="checkbox" />
        </div>
        <div class="for_sigle_row_form">
            <label>
                Address:<span style="color: Red;"> </span>
            </label>
            <asp:TextBox ID="txtaddress" TextMode="MultiLine" runat="server" placeholder="Enter Address"></asp:TextBox>
            <input id="Chkaddress" type="checkbox" />
        </div>
        <div class="for_sigle_row_form" id="log" runat="server" visible="false"> 
            <label>
                School Logo :
            </label>
            <asp:FileUpload ID="fileuploadforlogo" runat="server" onchange="ShowpImagePreviewOfLogo(this,'#ctl00_ContentPlaceHolder1_fileuploadforlogo');"
                ToolTip="Select" />
            <div id="divbgcolorforreclogo" class="navbar-header aside-md" style="float: right; margin-right: 360px;">
                <a class="navbar-brand" data-toggle="fullscreen" href="#">
                    <img id="imglogo" class="m-r-sm" />
                </a>
            </div>
        </div>
        <div class="for_sigle_row_form">
            <label>Logo Background : </label>
            <input type="color" id="Rbgcolor" />
            <a id="RDbgcolor" style="text-decoration: underline; cursor: pointer; font-weight: 800; font-size: 13px">Default color</a>
        </div>
        <div class="for_sigle_row_form">

            <label>Apply to<span style="color: Red;"></span></label>
            <label style="width: 90px;">All Branch</label>
            <input type="radio" name="enqtype" value="1" checked="checked" style="float: left; margin-top: 9px;" />
            <label style="width: 100px;">Branch Wise</label>
            <input type="radio" name="enqtype" value="2" style="float: left; margin-top: 9px;" />
        </div>
        <div class="clear"></div>
        <div class="for_sigle_row_form">
            <label>Receipt No.<span style="color: Red;"></span></label>
            <label style="width: 80px;">Automatic</label>
            <input type="radio" name="serialnotype" value="1" style="float: left; margin-top: 9px;" />
            <label style="width: 90px;">Manual</label>
            <input type="radio" name="serialnotype" value="2" checked="checked" style="float: left; margin-top: 9px;" />
            <img src="../images/help.png" id="viewhelp" title="help"  style="cursor:help; height: 16px; margin-left: 8px; margin-top: 6px; width: 16px;" />
            <div style="height:100px; width:300px; background:#000; position:fixed ; margin-left:530px; display:none; margin-top:-120px " id="divshowhelp">
                <p style="color:#fff"><b><u>Automatic:</u></b> You can Enter Receipt No. from where you want to start genrate Receipt No. It will increase automatic</p><br />
                 <p style="color:#fff"><b><u>Manual:</u></b> Genrate Receipt No. Manually</p>
            </div>
        </div>
        <div class="clear"></div>
        <div class="for_sigle_row_form" id="divserial" style="display: none">
            <label>Receipt No Start From.<span style="color: Red;"></span></label>
            <input type="text" placeholder="Ex: 102" onkeypress="return noAlphabets(event)" maxlength="7" id="serialnumbers" />
        </div>
        <br />
        <div class="clear"></div>
        <table id="getbranchlist" class="stm" style="width: 100%; display: none;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 73px">Branch Name</th>
                <th scope="col" style="width: 40px">Branch Login ID</th>
                <th scope="col" style="width: 30px">Service Tax No</th>
                <th scope="col" style="width: 30px">TIN</th>
                <th scope="col" style="width: 90px">Contact No</th>
                <th scope="col" style="width: 80px">Address</th>
            </tr>
        </table>
        <div class="clear"></div>
        <div class="for_sigle_row_form" id="divbranchlist" style="display: none">
            <label>Select Branch:</label>
            <select id="ddlbranch"></select>
        </div>
        <div class="for_sigle_row_form">
            <label></label>
            <input type="submit" id="buttoninputinstitute" class="button_save" value="Save" />
            <input type="submit" id="viewreciept" class="button_save" value="View Receipt" />
            <a href="../Common/Default.aspx" class="button2 inputinstitute">Cancel</a>
        </div>
        <br />
         <div id="receiptwrapper" style="width:680px; min-height:480px;  margin:auto; padding:10px 0px; margin-bottom:5px;display: none;">
           <div style="border-bottom:1px solid #e0dfdf; min-height:58px; padding-bottom:8px;">
                <div style="float: left; padding:5px 5px 0" id="divforlogo" runat="server">
                    <asp:Image ID="btnlogoforrecipt" runat="server" Width="184px" />
                </div>
                <div class="receiptwrapper_add" style="float:right; font-size:13px;  font-family:Arial; color:#656d70;">
                        <p id="insservicetaxno"  style="display: none; padding:0px; margin:3px 0;">Service Tax Regn No. : <span></span></p>
                        <p id="instin"  style="display: none; padding:0px; margin:3px 0;">TIN :  <span></span></p>
                        <p id="inscontact"  style="display: none;padding:0px; margin:3px 0;">Contact No. :  <span></span></p>
                         <p id="insaddress"  style="display: none; line-height:15px; padding:0px; margin:3px 0;">Address : <span></span></p>
                    </div>
                    <div style="clear:both;"></div>
           </div>

                <h3 style=" text-align:center; font-size:18px; margin:8px 0 0; font-family:Arial; color:#656d70;">Payment Receipt</h3>

           <p style="float:left; margin:0px 0 10px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;">Receipt No: <span id="recieptno" runat="server" ></span></p>

            <p style="float:right; margin:0px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> Date: <span id="recieptdate" runat="server" ></span></p>

           <div style="clear:both;"></div>

  <div style="clear:both;"></div>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">Recieved with thanks On behalf of</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px solid #5f6162; width:38%;"> <span id="recipetrecivername" runat="server"></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:52px; margin:10px 0 10px;">Roll No.</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:10px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:20.9%;"><span id="Span2" runat="server" ></span></dl>

           <div style="clear:both;"></div>

      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:89px; margin:3px 0 10px;">Class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:3px 1% 10px 0px; border-bottom:1px solid #5f6162;  width:44%;"><span id="Span3" runat="server" ></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:81px; margin:3px 0 10px;">Section</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:29.8%;"><span id="Span4" runat="server" ></span>&nbsp;</dl>

  <div style="clear:both;"></div>

           <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:405px; margin:3px 0 10px;">The Sum of <b> Rs.<span id="Span5" runat="server" ></span>/-</b> (including <b>Rs.<span id="spantaxamount" runat="server">100</span>/- (<span id="spantaxpercentage" runat="server">14%</span>)</b> Service Tax)</p>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:55px; margin:3px 0 10px;">In words</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:91.5%;"><span id="Span6" runat="server"></span></dl>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 0px;">Payment Mode:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:60%;"><span id="Span7" runat="server"></span></dl>

     <div style="clear:both;"></div>

  <table id="chequedetails" runat="server" width="100%" border="0"  cellpadding="0" cellspacing="0" style="margin:4px 0px 0 0px; float:left; font-size:14px; color:#4f4848;   font-family:Arial;">
      <tr style="float:left;">
    <td colspan="2" align="left" style="font-size:14px; color:#4f4848; float:left;  font-family:Arial; padding:2px 0 0px 0px; font-weight:600;">Cheque Details :</td>
    </tr>

  <tr style="float:left;">
    <td style="font-size:14px;  font-family:Arial; float:left; color:#4f4848; font-family:Arial;">
        <table style="width: 100%">

            <tr style="float:left;">
                <td style="float:left;"></td>
                <td align="right" style="padding:0px 0px 0; float:left;">Cheque No:</td>
            </tr>
        </table>
      </td>
    <td align="left" style="float:left; padding-top:2px; padding-right:8px; font-weight:600;">  <span id="Span29" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848; float:left;   padding:0px 0px 3px 0;  font-family:Arial;">Cheque Date:</td>
     <td align="left" style="float:left; padding-right:8px; font-weight:600;"> <span id="Span30" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848; float:left; padding:0px 0px 3px 0; font-family:Arial;">Bank:</td>
    <td align="left" style="float:left; font-weight:600;"> <span id="Span31" runat="server"></span></td>
  </tr>
</table>

  <div style="clear:both;"></div>

    <div style="float:left; width:48%;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Received By: </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:55%;"><span id="Span11" runat="server">&nbsp;</span></dl>

        <dt style"clear:both;"></dt>
         </div>

     <div style="float:right; width:34%;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Authorized Signatory:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:39%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
               <div style="clear:both;"></div>
</div>
        </div>

    <script type="text/javascript">
        var servicetax = "", TIN = "", Contact = "", branchcontact = '', address = "", date = "", insaddress, background = "", filenameoflogo = "", ImageLogoByteCode = "";
        getbranchnames()
        getdata();
        getradiovalue()
        BindBranchname()
        date = new Date();
        var year = date.getFullYear()
        var month = date.getMonth() + 1
        var day = date.getDate()
        $('#ctl00_ContentPlaceHolder1_lblpaydate').text(day + '/' + month + '/' + year).css('font-weight', '800')
        $('#ctl00_ContentPlaceHolder1_lblpaydate1').text(day + '/' + month + '/' + year).css('font-weight', '800')
        //Function to get service tax,Contact,address etc..

        function getdata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getdata",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        var data = data.d.split('^')
                        servicetax = data[0]
                        TIN = data[1]
                        Contact = data[2]
                        address = data[3]
                        background = data[5];
                        $('#sevicetax').attr('checked', true)
                        $('#chktin').attr('checked', true)
                        $('#Chkcontact').attr('checked', true)
                        $('#Chkaddress').attr('checked', true)
                        $("#ctl00_ContentPlaceHolder1_txtServicetax").val(servicetax)
                        $("#ctl00_ContentPlaceHolder1_txttin").val(TIN)
                        $("#ctl00_ContentPlaceHolder1_txtvat").val(Contact)
                        $("#ctl00_ContentPlaceHolder1_txtaddress").val(address)
                        $('#divbgcolorforreclogo').css('background', background)
                        $('#imglogo').attr('src', '../images/' + data[4])
                        $("#Rbgcolor").val(data[5])
                        $('.receiptwrapper_logo').find('img').attr('src', '../images/' + data[4])
                        $('.receiptwrapper_logo').css('background', data[5])
                        filenameoflogo = data[4];
                        $('.inhials').val(servicetax)
                        $('.finicialyear').val(TIN)
                        $('.digit').val(Contact)
                        $('.address').val(address)
                        $('.chkservice').attr('checked', true)
                        $('.chktin').attr('checked', true)
                        $('.Chkcontact').attr('checked', true)
                        $('.chkaddress').attr('checked', true)
                    }
                },
                error: function (response) {
                }
            });
        }

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };

        $('#serialnumbers').keypress(function () {
            noAlphabets($(this).val());
        });

        $('#sevicetax').change(function () {
            if ($(this).is(":checked") == true) {
                $("#ctl00_ContentPlaceHolder1_txtServicetax").val(servicetax)

                if ($("input:radio[name=enqtype]:checked").val() == 1) {
                    $('.inhials').val(servicetax);
                    $('#insservicetaxno').show(500);
                    $('#insservicetaxno').find('span').html(servicetax)
                    $('.chkservice').attr('checked', true);
                    $('#stuservicetaxno').show(500)
                    $('#stuservicetaxno').find('span').html(servicetax)
                }
                else {
                    $('.inhials').val('');
                    $('.chkservice').attr('checked', false);
                }
            }
            else {
                $("#ctl00_ContentPlaceHolder1_txtServicetax").val('')
                $('.inhials').val('');
                $('#insservicetaxno').hide(500);
                $('#insservicetaxno').find('span').html('')
                $('.chkservice').attr('checked', false);
                $('#stuservicetaxno').hide(500)
                $('#stuservicetaxno').find('span').html('')
            }
        })
        $('#chktin').change(function () {
            if ($(this).is(":checked") == true) {
                $("#ctl00_ContentPlaceHolder1_txttin").val(TIN)
                if ($("input:radio[name=enqtype]:checked").val() == 1) {
                    $('.finicialyear').val(TIN);
                    $('#instin').find('span').html(TIN)
                    $('#instin').show(500);
                    $('.chktin').attr('checked', true)
                    $('#stutin').show(500)
                    $('#stutin').find('span').html(TIN)
                }
                else {
                    $('.finicialyear').val('');
                    $('.chktin').attr('checked', false)
                }
            }
            else {
                $("#ctl00_ContentPlaceHolder1_txttin").val('')
                $('.finicialyear').val('');
                $('#instin').hide(500);
                $('#instin').find('span').html('')
                $('.chktin').attr('checked', false)
                $('#stutin').hide(500)
                $('#stutin').find('span').html('')
            }
        })
        $('#Chkcontact').change(function () {

            if ($(this).is(":checked") == true) {
                $("#ctl00_ContentPlaceHolder1_txtvat").val(Contact)
                if ($("input:radio[name=enqtype]:checked").val() == 1) {
                    $('.digit').val(branchcontact);
                    $('#inscontact').show(500);
                    $('#inscontact').find('span').html(Contact)
                    $('.Chkcontact').attr('checked', true)
                    $('#stucontact').show(500)
                    $('#stucontact').find('span').html(Contact)
                }
                else {
                    $('.digit').val('');
                    $('.Chkcontact').attr('checked', false)
                }
            }
            else {
                $("#ctl00_ContentPlaceHolder1_txtvat").val('')
                $('.digit').val('');
                $('.Chkcontact').attr('checked', false)
                $('#inscontact').find('span').html('')
                $('#inscontact').hide(500);
                $('#stucontact').hide(500)
                $('#stucontact').find('span').html('')
            }
        })
        $('#Chkaddress').change(function () {
            if ($(this).is(":checked") == true) {
                $("#ctl00_ContentPlaceHolder1_txtaddress").val(address)
                if ($("input:radio[name=enqtype]:checked").val() == 1) {
                    $('.address').val(address);
                    $('#insaddress').find('span').html(address)
                    $('.chkaddress').attr('checked', true)
                    $('#insaddress').show(500);
                    $('#stuinsaddress').show(500)
                    $('#stuinsaddress').find('span').html(address)
                }
                else {
                    $('.address').val('');
                    $('.chkaddress').attr('checked', false)
                    //$('#insaddress').find('span').html('')
                }
            }
            else {
                $("#ctl00_ContentPlaceHolder1_txtaddress").val('');
                $('.address').val('');
                $('#insaddress').find('span').html('')
                $('#insaddress').hide(500);
                $('.chkaddress').attr('checked', false)
                $('#stuinsaddress').hide(500)
                $('#stuinsaddress').find('span').html('')
            }
        })

        $(document).ready(function () {

            $('#buttoninputinstitute').click(function () {

                //FillField();
                var brid = "";
                var receptapplyto = $("input:radio[name=enqtype]:checked").val();
                var numberstartfrom = $('#serialnumbers').val();
                var autoormannual = $("input:radio[name=serialnotype]:checked").val();
                address = "", servicetax = "", TIN = "", Contact = "", background = "";
                background = $('#Rbgcolor').val();
                $('#getbranchlist tr:gt(0)').each(function () {
                    brid = brid + ',' + $(this).find('input[type="hidden"]').val();
                    if ($(this).find('td:eq(3)').find('input[type=checkbox]').is(':checked') == true) {
                        servicetax = servicetax + ',1'
                    }
                    else {
                        servicetax = servicetax + ',0'
                    }
                    if ($(this).find('td:eq(4)').find('input[type=checkbox]').is(':checked') == true) {
                        TIN = TIN + ',1'
                    }
                    else {
                        TIN = TIN + ',0'
                    }
                    if ($(this).find('td:eq(5)').find('input[type=checkbox]').is(':checked') == true) {
                        Contact = Contact + ',1'
                    }
                    else {
                        Contact = Contact + ',0'
                    }
                    if ($(this).find('td:eq(6)').find('input[type=checkbox]').is(':checked') == true) {
                        address = address + ',1'
                    }
                    else {
                        address = address + ',0'
                    }
                })
                brid = brid.substring(1, brid.length);
                servicetax = servicetax.substring(1, servicetax.length)
                TIN = TIN.substring(1, TIN.length);
                Contact = Contact.substring(1, Contact.length);
                address = address.substring(1, address.length)
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "receipt_setting.aspx/callmethod",
                    data: "{'Service_tax_no':'" + servicetax + "','TIN':'" + TIN + "','Contact':'" + Contact + "','address':'" + address + "','autoormannual':'" + autoormannual + "','numberstartfrom':'" + numberstartfrom + "','receptapplyto':'" + receptapplyto + "','brid':'" + brid + "','logobgcolor':'" + background + "','Logo':'" + filenameoflogo + "','ImageLogoByteCode':'" + ImageLogoByteCode + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            alertify.success("Receipt Updated Successfully.");
                            FillField();
                            return false;
                        }
                        return false;
                    }
                });
                return false;
            });
            $('#Rbgcolor').change(function () {
                $('#divbgcolorforreclogo').css('background', $(this).val())
            })
            $('#RDbgcolor').click(function () {
                background = $('#Rbgcolor').val('#25405D');
                $('#divbgcolorforreclogo').css('background', '#25405D');
            })
        });
        function getradiovalue() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getradiobuttonvalue",
                data: "",
                dataType: "json",
                success: function (data) {
                    var ApplyTo = "", recieptfor = "", nostartfrom = "";
                    var data = data.d.split('~');
                    nostartfrom = data[0];
                    ApplyTo = data[1];
                    recieptfor = data[2]
                    $('#serialnumbers').val(nostartfrom);
                    $('#ctl00_ContentPlaceHolder1_recieptno').text(nostartfrom);
                    $('#ctl00_ContentPlaceHolder1_lblreceipt1').text(nostartfrom)

                    if (ApplyTo == "1") {
                        $("input:radio[name=enqtype]:eq(0)").attr('checked', true)
                        $('#insservicetaxno').show(500)
                        $('#insservicetaxno').find('span').html(servicetax)
                        $('#stuservicetaxno').show(500)
                        $('#stuservicetaxno').find('span').html(servicetax)
                        $('#instin').show(500)
                        $('#instin').find('span').html(TIN)
                        $('#stutin').show(500)
                        $('#stutin').find('span').html(TIN)
                        $('#inscontact').show(500)
                        $('#inscontact').find('span').html(Contact)
                        $('#stucontact').show(500)
                        $('#stucontact').find('span').html(Contact)
                        $('#insaddress').show(500)
                        $('#insaddress').find('span').html(address)
                        $('#stuinsaddress').show(500)
                        $('#stuinsaddress').find('span').html(address)
                        $('#getbranchlist').hide(500)
                    }
                    else {
                        getnewdatabranchwise();
                        $("input:radio[name=enqtype]:eq(1)").attr('checked', true)

                    }
                    if (recieptfor == "1") {
                        $("input:radio[name=serialnotype]:eq(0)").attr('checked', true)
                        $('#divserial').show(500)
                    }
                    else {

                        $("input:radio[name=serialnotype]:eq(1)").attr('checked', true)
                        $('#divserial').hide(500)
                    }
                    return false;
                },
                error: function (result) {

                }
            });
        }
        $("input:radio[name=serialnotype]").change(function () {
            if ($(this).val() == 1) {
                $('#divserial').show(500)
            }
            else {
                $('#divserial').hide(500)
            }
        })

        $("input:radio[name=enqtype]").change(function () {

            if ($(this).val() == 2) {
                $('.inhials').val('').attr('disabled', false)
                $('.finicialyear').val('').attr('disabled', false)
                $('.digit').val('').attr('disabled', false)
                $('.address').val('').attr('disabled', false)
                $('.chkaddress').attr('disabled', false)
                $('.chktin').attr('disabled', false)
                $('.chkservice').attr('disabled', false)
                $('.Chkcontact').attr('disabled', false)
                $('#getbranchlist').show(500)
                $('#receiptwrapper').hide(500)
                getnewdatabranchwise()

            }
            else {

                $('.inhials').val($('#ctl00_ContentPlaceHolder1_txtServicetax').val()).attr('disabled', true)
                $('.finicialyear').val($('#ctl00_ContentPlaceHolder1_txttin').val()).attr('disabled', true)
                $('.digit').val($('#ctl00_ContentPlaceHolder1_txtvat').val()).attr('disabled', true)
                $('.address').val($('#ctl00_ContentPlaceHolder1_txtaddress').val()).attr('disabled', true)
                $('.chkaddress').attr('disabled', true)
                $('.chkaddress').find('input[type=checkebox]').attr('checked', true)
                $('.chktin').attr('disabled', true).attr('checked', true)
                $('.chktin').find('input[type=checkebox]').attr('checked', true)
                $('.chkservice').attr('disabled', true).attr('checked', true)
                $('.chkservice').find('input[type=checkebox]').attr('checked', true)
                $('.Chkcontact').attr('disabled', true).attr('checked', true)
                $('.Chkcontact').find('input[type=checkebox]').attr('checked', true)
                $('#insservicetaxno').show(500)
                $('#insservicetaxno').find('span').html(servicetax)
                $('#stuservicetaxno').show(500)
                $('#stuservicetaxno').find('span').html(servicetax)
                $('#instin').show(500)
                $('#instin').find('span').html(TIN)
                $('#stutin').show(500)
                $('#stutin').find('span').html(TIN)
                $('#inscontact').show(500)
                $('#inscontact').find('span').html(Contact)
                $('#stucontact').show(500)
                $('#stucontact').find('span').html(Contact)
                $('#insaddress').show(500)
                $('#insaddress').find('span').html(address)
                $('#stuinsaddress').show(500)
                $('#stuinsaddress').find('span').html(address)
                $('#getbranchlist').hide(500)

            }
        });
        function FillField() {
            servicetax = $('#ctl00_ContentPlaceHolder1_txtServicetax').val();
            TIN = $('#ctl00_ContentPlaceHolder1_txttin').val();
            Contact = $('#ctl00_ContentPlaceHolder1_txtvat').val();
            address = $('#ctl00_ContentPlaceHolder1_txtaddress').val();
            background = $('#Rbgcolor').val();
        }

        function getbranchnames() {
            var trforappend = "";
            $('.stm tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getbranchnames",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d.length > 0) {
                        {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0)
                                    trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].brname + '<input type="hidden" value=' + data.d[i].brid + '></td><td> ' + data.d[i].brcode + '</td><td><input type=text style="width:100px; height:20px" maxlength=15 class="inhials" disabled /><input class="chkservice" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" class="finicialyear"  disabled /><input class="chktin" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" onkeypress="return isNumberKey(event)" class="digit" value="' + data.d[i].landlineno + '" maxlength=13 disabled /><input class="Chkcontact" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" maxlength=15 class="address" disabled /><input class="chkaddress" type="checkbox" disabled style="margin-left:3px;"><span class="preview" /></td></tr>';
                                else
                                    trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].brname + '<input type="hidden" value=' + data.d[i].brid + '></td><td> ' + data.d[i].brcode + '</td><td><input type=text style="width:100px; height:20px" maxlength=15   class="inhials" disabled /><input class="chkservice" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" class="finicialyear" disabled /><input class="chktin" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" class="digit" value="' + data.d[i].landlineno + '" onkeypress="return isNumberKey(event)" maxlength=13  disabled /><input class="Chkcontact" type="checkbox" disabled style="margin-left:3px;"></td><td><input type=text style="width:100px; height:20px" maxlength=15 class="address" disabled /><input class="chkaddress" type="checkbox" disabled style="margin-left:3px;"><span class="preview" /></td></tr>';
                                $('.stm').append(trforappend);
                            }
                        }
                    }
                },
                error: function (response) {
                }
            });
        }

        $('.chkservice').live('change', function () {
            if ($(this).is(':checked') == true) {
                $(this).parent('td').find('input[type=text]').val(servicetax);
                $('#insservicetaxno').show(500)
                $('#insservicetaxno').find('span').html(servicetax)
                $('#stuservicetaxno').show(500)
                $('#stuservicetaxno').find('span').html(servicetax)
            }
            else {
                $(this).parent('td').find('input[type=text]').val('');
                $('#insservicetaxno').hide(500)
                $('#insservicetaxno').find('span').html('')
                $('#stuservicetaxno').hide(500)
                $('#stuservicetaxno').find('span').html('')
            }
        })
        $('.chktin').live('change', function () {
            if ($(this).is(':checked') == true) {
                $(this).parent('td').find('input[type=text]').val(TIN);
                $('#instin').show(500)
                $('#instin').find('span').html(TIN)
                $('#stutin').show(500)
                $('#stutin').find('span').html(TIN)
            }
            else {
                $(this).parent('td').find('input[type=text]').val('');
                $('#instin').hide(500)
                $('#instin').find('span').html('')
                $('#stutin').hide(500)
                $('#stutin').find('span').html('')
            }
        })
        $('.Chkcontact').live('change', function () {
            brid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
            if ($(this).is(':checked') == true) {
                getContact(brid);
                if (branchcontact == '') {
                    $(this).parent('td').find('input[type=text]').val(Contact);
                }
                else {
                    $(this).parent('td').find('input[type=text]').val(branchcontact);
                }
                $('#inscontact').show(500)
                $('#inscontact').find('span').html(Contact)
                $('#stucontact').show(500)
                $('#stucontact').find('span').html(Contact)
            }

            else {
                $(this).parent('td').find('input[type=text]').val('');
                $('#inscontact').hide(500)
                $('#inscontact').find('span').html('')
                $('#stucontact').hide(500)
                $('#stucontact').find('span').html('')
            }
        })
        function getContact(brid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getbranchcontact",
                data: "{'brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    branchcontact = data.d

                },
                error: function (response) {
                    alertify.error("Some Error");
                }
            });
        }
        function getaddress(brid) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getbranchaddress",
                data: "{'brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    insaddress = data.d

                },
                error: function (response) {
                }
            });
        }
        $('.chkaddress').live('change', function () {
            if ($(this).is(':checked') == true) {
                var brid = $(this).parents('tr').find('input[type=hidden]').val();
                getaddress(brid)
                $(this).parent('td').find('input[type=text]').val(insaddress);
                $('#insaddress').show(500)
                $('#insaddress').find('span').html(insaddress)
                $('#stuinsaddress').show(500)
                $('#stuinsaddress').find('span').html(insaddress)
            }
            else {
                $(this).parent('td').find('input[type=text]').val('');
                $('#insaddress').hide(500)
                $('#insaddress').find('span').html('')
                $('#stuinsaddress').hide(500)
                $('#stuinsaddress').find('span').html('')
            }
        })
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {

                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            return true;
        }

        $('#viewreciept').click(function () {
            if ($("input:radio[name=enqtype]:checked").val() == 1) {
                $('#divbranchlist').hide(500)
                $('#receiptwrapper').show(500)
                $('html, body').animate({
                    scrollTop: $("#viewreciept").offset().top
                }, 1500);
            }
            else {
                var branchid = $('#ddlbranch').val()

                if ($('#divbranchlist').css('display') == "block") {
                    if (branchid == 0) {
                        alertify.error('Please Select Branch Name');
                    }
                    else {
                        $('#receiptwrapper').show(500)
                        $('html, body').animate({
                            scrollTop: $("#viewreciept").offset().top
                        }, 1500);
                    }
                }
                $('#divbranchlist').show(500)
            }
            return false;
        })
        //Get Branch List
        function BindBranchname() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/bindtestname",
                data: "",
                dataType: "json",
                success: function (data) {
                    $("#ddltestname").html("");
                    $.each(data.d, function (key, value) {
                        $("#ddlbranch").append($("<option></option>").val(value.BrId).html(value.BrName));
                    });
                },
                error: function (result) {
                    alertify.error('Error');
                },
            });
        }

        //View Reciept On change of Branch Name
        $('#ddlbranch').change(function () {
            if ($(this).val() != 0) {
                //Disabled Checkbox
                $('.chkservice').attr('disabled', true)
                $('.chktin').attr('disabled', true)
                $('.Chkcontact').attr('disabled', true)
                $('.chkaddress').attr('disabled', true)

                //Disabled Textbox
                $('.inhials').attr('disabled', true)
                $('.finicialyear').attr('disabled', true)
                $('.digit').attr('disabled', true)
                $('.address').attr('disabled', true)

                $('#getbranchlist tr:gt(0)').each(function () {
                    if ($(this).find('input[type=hidden]').val() == $('#ddlbranch').val()) {
                        $(this).find('input').attr('disabled', false)
                        if ($(this).find('td:eq(3)').find('input[type=checkbox]').is(':checked') == true) {
                            $('#insservicetaxno').show();
                            $('#insservicetaxno').find('span').html($(this).find('td:eq(3)').find('input[type=text]').val())
                            $("#stuservicetaxno").show();
                            $('#stuservicetaxno').find('span').html($(this).find('td:eq(3)').find('input[type=text]').val())
                        }
                        if ($(this).find('td:eq(4)').find('input[type=checkbox]').is(':checked') == true) {
                            $('#instin').show();
                            $('#instin').find('span').html($(this).find('td:eq(4)').find('input[type=text]').val())
                            $('#stutin').show();
                            $('#stutin').find('span').html($(this).find('td:eq(4)').find('input[type=text]').val())
                        }

                        if ($(this).find('td:eq(5)').find('input[type=checkbox]').is(':checked') == true) {
                            $('#inscontact').show();
                            $('#inscontact').find('span').html($(this).find('td:eq(5)').find('input[type=text]').val())
                            $('#stucontact').show();
                            $('#stucontact').find('span').html($(this).find('td:eq(5)').find('input[type=text]').val())
                        }
                        if ($(this).find('td:eq(6)').find('input[type=checkbox]').is(':checked') == true) {
                            $('#insaddress').show();
                            $('#insaddress').find('span').html($(this).find('td:eq(6)').find('input[type=text]').val())
                            $('#stuinsaddress').show();
                            $('#stuinsaddress').find('span').html($(this).find('td:eq(6)').find('input[type=text]').val())
                        }
                    }
                })
            }
            else {

                //Enable checkbox
                $('.chkservice').attr('disabled', false)
                $('.chktin').attr('disabled', false)
                $('.Chkcontact').attr('disabled', false)
                $('.chkaddress').attr('disabled', false)

                //Enable Textbox
                $('.inhials').attr('disabled', false)
                $('.finicialyear').attr('disabled', false)
                $('.digit').attr('disabled', false)
                $('.address').attr('disabled', false)
            }
        })

        //get detail branchwise
        function getnewdatabranchwise() {
            $('#getbranchlist').show(500)
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "receipt_setting.aspx/getbranchwisedata",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {

                    for (var i = 0; i < data.d.length; i++) {
                        $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=text]').val(data.d[i].servicenumber)
                        if (data.d[i].servicenumber != "0") {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=checkbox]').attr('checked', true)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=text]').val(servicetax)
                        }
                        else {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=checkbox]').attr('checked', false)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 3 + ')').find('input[type=text]').val('')
                        }

                        $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=text]').val(data.d[i].is_tin)
                        if (data.d[i].is_tin != "0") {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=checkbox]').attr('checked', true)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=text]').val(TIN)
                        }
                        else {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=checkbox]').attr('checked', false)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 4 + ')').find('input[type=text]').val('')
                        }
                        if (data.d[i].contact != "0") {
                            getContact(data.d[i].brid)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=checkbox]').attr('checked', true)
                            if (branchcontact == '') {
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=text]').val(Contact);
                            }
                            else {
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=text]').val(branchcontact);
                            }
                        }
                        else {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=checkbox]').attr('checked', false)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 5 + ')').find('input[type=text]').val('')
                        }
                        if (data.d[i].is_address == 1) {
                            getaddress(data.d[i].brid)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 6 + ')').find('input[type=text]').val(insaddress)
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 6 + ')').find('input[type=text]').attr('title', insaddress);
                            if (data.d[i].insaddress != "0") {
                                $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 6 + ')').find('input[type=checkbox]').attr('checked', true)
                            }

                        }
                        else {
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 6 + ')').find('input[type=text]').val('')
                            $('#getbranchlist').find('tr:eq(' + (parseInt(i) + 1) + ')').children('td:eq(' + 6 + ')').find('input[type=checkbox]').attr('checked', false)
                        }

                    }
                    $('.inhials').attr('disabled', false)
                    $('.finicialyear').attr('disabled', false)
                    $('.digit').attr('disabled', false)
                    $('.address').attr('disabled', false)
                    $('.chkaddress').attr('disabled', false)
                    $('.chktin').attr('disabled', false)
                    $('.chkservice').attr('disabled', false)
                    $('.Chkcontact').attr('disabled', false)

                },
                error: function (response) {
                }
            });
        }
        //logo upload code
        function ShowpImagePreviewOfLogo(input, controlId) {

            var stat = Logo_Validation(controlId);
            if (stat == true) {
                $.each($(controlId).prop("files"), function (k, filelogo) {
                    filenameoflogo = filelogo['name'];
                });
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        ImageLogoByteCode = e.target.result;
                        $('#imglogo').attr('src', e.target.result);
                        $('#imglogo').show(500)
                        $('.receiptwrapper_logo').find('img').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);

                }
            }
        }
        function Logo_Validation(fileuploadforlogo) {
            var fuData = document.getElementById($(fileuploadforlogo).attr('id'));
            var FileUploadPath = fuData.value;
            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (Extension == "png") {
                    return true;
                }
                else {
                    alertify.alert("You can not upload " + Extension + " file for company logo. You can only upload .png  file.");
                    return false;
                }

            }
        }
        $('#viewhelp').mouseover(function () {
            $('#divshowhelp').show(500)
        })
        $('#viewhelp').mouseleave(function () {
            $('#divshowhelp').hide(500)
        })
    </script>
</asp:Content>