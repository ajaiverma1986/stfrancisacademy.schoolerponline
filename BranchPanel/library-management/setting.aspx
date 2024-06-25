<%@ Page Title="Library Setting" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="setting.aspx.cs" Inherits="BranchPanel_library_management_setting" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" style="border-bottom: medium none; border-top: medium none;">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Library Setting</h2>
        </div>
         <div class="for_sigle_row_form">
              <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
          <select id="ddlsession"></select>
      </div>
     <div class="for_sigle_row_form">
                <label>From Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="Enter From Date of Book Setting"  > </asp:TextBox>
            </div>
     <div class="for_sigle_row_form">
                <label>To Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txttodate" runat="server" ReadOnly="true" placeholder="Enter To Date of Book Setting"  > </asp:TextBox>
            </div>
        <div class="clear"></div>
        <div class="for_sigle_row_form">
            <label>Apply to:<span style="color: Red;"></span></label>
            <label style="width: 90px;">All Classes</label>
            <input type="radio" name="settingfor" value="1" style="float: left; margin-top: 9px;" />
            <label style="width: 100px;">Class Wise</label>
            <input type="radio" name="settingfor" value="2" style="float: left; margin-top: 9px;" />
        </div>
     
        <div id="commanToall">


            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>No of Book Per Card<span style="color: red">*</span></label>
                <asp:TextBox ID="txtbook" runat="server" onkeypress="return isNumberKey(event)" placeholder=" Enter The No Of Book Per Card"></asp:TextBox>&nbsp
            </div>

            <div class="for_sigle_row_form">

                <label>Apply fine for Book<span style="color: #ff0066"> </span></label>
                <label style="width: 90px;">Yes</label>
                <input type="radio" name="enqtype" value="1" style="float: left; margin-top: 9px;" />
                <label style="width: 100px;">No</label>
                <input type="radio" name="enqtype" value="2" style="float: left; margin-top: 9px;" />
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>Fine Amount per day<span style="color: #ff0066"> </span></label>
                <asp:TextBox ID="txtamt" runat="server" onkeypress="return noAlphabets(event)"  placeholder=" Enter The Fine Amount Per Day"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>No of Days to Return Book<span style="color: #ff0066"> </span></label>
                <asp:TextBox ID="txtreturnbook" runat="server" onkeypress="return isNumberKey(event)" placeholder=" Enter The No Of Days To Return Book" MaxLength="3"></asp:TextBox>
            </div>

            <label></label>
            <div class="for_sigle_row_form">
                <label style="padding-top: 2px">Active<span style="color: #ff0066"> </span></label>
                <asp:CheckBox ID="checkactive" runat="server"/>
            </div>
            <div class="for_sigle_row_form">
                <label><span style="color: #ff0066"></span></label>
                <asp:Button ID="btnsave1" runat="server" Text="Submit" CssClass="button_save"  class="confirm" />
            </div>

        </div>
        <div id="classwisesetting"style="display:none">
        <table id="classwise" class="stm" style="width: 100%;">
            <tr class="stm_head">
                <th scope="col" style="width: 10px">S.No.</th>
                <th scope="col" style="width: 95px">Class Name</th>
                <th scope="col" style="width: 40px">No Of Book(Per Card)</th>
                <th scope="col" style="width: 40px">Apply Fine</th>
                <th scope="col" style="width: 30px">Fine Amount(Per Day)</th>
                <th scope="col" style="width: 30px">No Of Day(Return Book)</th>
                <th scope="col" style="width: 30px">Status</th>
                <th scope="col" style="width: 30px">Edit</th>
                 <th scope="col" style="width: 30px">Revise</th>
            </tr>
        </table>
         <%--  <div class="for_sigle_row_form">         
            <input type="submit" id="buttonsaveclasswise" class="button_save" value="Editable" />
            <input type="submit" id="btnsave" class="button_save" value="Save" style="display:none" />
            <input type="submit" id="btncancel" class="button2 inputinstitute" value="Cancel" style="display:none" />
         </div>--%>
            </div>
     <div id="divrevisethesettingdate" style="text-align: center; display: none;" class="">
            <div class="">
               <table class="showpopuparea showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="4" class="pop-headng-sty"> Add Date For Apply Setting
                            <a id="BtnCancelapplydate" title="Close this from here"
                                class="btnClose">
                                <img src="../../images/popupcross.png"></a>
                        </td>
                    </tr>
                  
                      <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Date:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="txtapplydate" runat="server" placeholder="Enter Date" ReadOnly="true"></asp:TextBox>
                        </td>
                      </tr>
                     
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitdata" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="clear"></div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {

            var classid = "", classname = "", Noofbook = "",fromdate="",todate="", finestatus = "", Noofdaytoreturn = "", settingstatus = "", fineamt = "";
            var session = "", Fyid = "", trindex = 0;
            Bindsession();
            Fyid = $('#ddlsession').val();
            getdata(Fyid);
            var year = 2018;
            $("#ctl00_ContentPlaceHolder1_txtfromdate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '1970:' + year
            });

            $("#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '1970:' + year
            });

            $("#ctl00_ContentPlaceHolder1_btnsave1").click(function () {
                if ($('#ddlsession').val() == "0") {
                alertify.error("Please Select The Session ");
                return false;
                 }
                if ($('#ctl00_ContentPlaceHolder1_txtbook').val() == "") {
                    alertify.error('No of Book Per Card');
                    $('#ctl00_ContentPlaceHolder1_txtbook').focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txtfromdate').val() == "") {
                    alertify.error('please enter From Date.');
                    $('#ctl00_ContentPlaceHolder1_txtfromdate').focus();
                    return false;
                }
                if ($('#ctl00_ContentPlaceHolder1_txttodate').val() == "") {
                    alertify.error('plase enter TO Date.');
                    $('#ctl00_ContentPlaceHolder1_txttodate').focus();
                    return false;
                }
                if ($("input:radio[name=enqtype]:checked").val() == 1) {
                    if ($("#ctl00_ContentPlaceHolder1_txtamt").val() == "") {
                        alertify.error('Enter Fine Amount per day');
                        $("#ctl00_ContentPlaceHolder1_txtamt").focus();
                        return false;
                    }
                    else if ($('#ctl00_ContentPlaceHolder1_txtreturnbook').val() == "") {
                        alertify.error('Enter No of Days to Return Book');
                        $('#ctl00_ContentPlaceHolder1_txtreturnbook').focus();
                        return false;
                    }
                    else {
                        insertdata()
                        return false;
                    }
                }
                else {
                    insertdata()
                    return false;
                }
                return false;
            });
           
        });
        //****************************************************************get fyid value on change event*********************************************
        $('#ddlsession').change(function () {
          Fyid = $(this).val();
          getdata(Fyid);
          return false;
        })
        //**********************************************************getprevious setting of comman toall****************************************************
        $('.Chkfine').live('change', function () {
           if (!$(this).prop('checked')) {
                $(this).parent('td').parent('tr').find('td:eq(4)').find('input[type="text"]').val('0.00');
            }
        });
        $('.fineamount').live('change', function () {
            if (!$(this).parent('td').parent('tr').find('td:eq(3)').find('input[type="checkbox"]').prop('checked')) {
                alertify.error('Please Check First Apply Fine.');
                $(this).val('0.00');
            }
        });
        function getdata(Fyid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "setting.aspx/getdata",
                data: "{'Fyid':'" + Fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                      var data = data.d.split('^')
                        fyid= data[0]
                        nbookpercard = data[1];
                        allowfine = data[2];
                        amtperday = data[3];
                        returnday = data[4];
                        status = data[5];  
                        fromdate = data[6];
                        todate = data[7];
                        TypeOfSettings = data[8];
                        if (TypeOfSettings == 'CommanToAll') {
                            $('input[type="radio"][name="settingfor"][value="' + 1 + '"]').change();
                            $('input[type="radio"][name="settingfor"][value="' + 1 + '"]').prop('checked', true);
                            $('#ctl00_ContentPlaceHolder1_checkactive').prop('checked', true);
                            $("input[name=enqtype][value=" + allowfine + "]").prop('checked', true);
                            $("#ctl00_ContentPlaceHolder1_txtbook").val(nbookpercard);
                            $("#ctl00_ContentPlaceHolder1_txtamt").val(amtperday);
                            $("#ctl00_ContentPlaceHolder1_txtreturnbook").val(returnday);
                            $("#ctl00_ContentPlaceHolder1_txtfromdate").val(fromdate);
                            $("#ctl00_ContentPlaceHolder1_txttodate").val(todate);
                        }
                        else {
                            $('input[type="radio"][name="settingfor"][value="' + 2 + '"]').change();
                            $('input[type="radio"][name="settingfor"][value="' + 2 + '"]').prop('checked', true);
                            $('#ctl00_ContentPlaceHolder1_checkactive').prop('checked', false);
                            $("input[name=enqtype][value=" + allowfine + "]").prop('checked', false);
                            $("#ctl00_ContentPlaceHolder1_txtbook").val('');
                            $("#ctl00_ContentPlaceHolder1_txtamt").val('');
                            $("#ctl00_ContentPlaceHolder1_txtreturnbook").val('');
                            $("#ctl00_ContentPlaceHolder1_txtfromdate").val('');
                            $("#ctl00_ContentPlaceHolder1_txttodate").val('');
                        }
                                            
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                }
            });
        }
        //*********************************************save setting for all class*********************************************************
        function insertdata() {
            call_progressbar("start");
            var session = $('#ddlsession').val();
           var settingfor = $("input:radio[name=settingfor]:checked").val();
                classname = 0;
                fromdate = $("#ctl00_ContentPlaceHolder1_txtfromdate").val();
                todate = $("#ctl00_ContentPlaceHolder1_txttodate").val();
                Noofbook = $('#ctl00_ContentPlaceHolder1_txtbook').val();
                finestatus = $("input:radio[name=enqtype]:checked").val();
                fineamt = $('#ctl00_ContentPlaceHolder1_txtamt').val();
                Noofdaytoreturn = $('#ctl00_ContentPlaceHolder1_txtreturnbook').val();
                settingstatus = $("#ctl00_ContentPlaceHolder1_checkactive").is(":checked");
                if (settingstatus == true) {
                    settingstatus = 1
                }
                else {
                    settingstatus = 0
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "setting.aspx/savesettingdata",
                    data: "{'classname':'" + classname + "','Noofbook':'" + Noofbook + "','finestatus':'" + finestatus + "','fineamt':'" + fineamt + "','Noofdaytoreturn':'" + Noofdaytoreturn + "','settingstatus':'" + settingstatus + "','session':'" + session + "','settingfor':'" + settingfor + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                    dataType: "json",
                    success: function (data) {
                        alertify.success("Setting insert successfully")
                        call_progressbar("end");
                        location.reload()
                    },
                    error: function (data) {
                        call_progressbar("end");
                        location.reload()
                    }
                });
                location.reload()
                return false;
            }
          
        
        //********************************************************progressbar*****************************************
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
        //*********************************************show detail setting wise*************************************
        $("input:radio[name=settingfor]").change(function () {
            if ($(this).val() == '2') {
                $('#commanToall').hide(500)
                $('#classwisesetting').show(500)
                getdataclasswise($('#ddlsession').val());
            }
            else {
                $('#classwisesetting').hide(500)
                $('#commanToall').show(500)
             
            }
        });
        //***********************************************enabled record class wise**************************************
    
        $('#buttonsaveclasswise').click(function () {
            $('#classwise').find('input').attr('disabled', false)
            //$('#btnsave').show(500);
            $('#buttonsaveclasswise').hide(500);
            $('#btncancel').show(500);
            return false;
        })
     
    
     //**********************************************************edit class wise data************************************

        $('.imgforedit').live('click',function () {
            $(this).parents('tr').find('input').attr('disabled', false);
            $(this).parents('tr').children('td:eq(7)').find('.imgforedit').hide(500);
            $(this).parents('tr').children('td:eq(7)').find('.sbtnupdate').show(500);
            $(this).parents('tr').children('td:eq(7)').find('.sbtncancel').show(500);
            return false;
        })
        //********************************update**************************************************************
        $('.sbtnupdate').live('click', function () {
            if ($('#ddlsession').val() != "0") {
                call_progressbar("start");
                var session = $('#ddlsession').val();
                var settingfor = $("input:radio[name=settingfor]:checked").val();
                var classid = '', noofbook = '', allowfine = '', fineamount = '', noofdaytoreturn = '', status = '', cwidforupdate='';
                classid = $(this).parents('tr').find('input[type="hidden"]').val();
                cwidforupdate = $(this).parents('tr').find('td:eq(0)').find('span').html()
                noofbook = $(this).parents('tr').find(".noofbook").val();
                var a = $(this).parents('tr').find("td:eq(3)").find('input[type="checkbox"]').is(':checked');
                if (a == true) {
                    allowfine = 1;
                }
                else {
                    allowfine = 0;
                }

                fineamount = $(this).parents('tr').find(".fineamount").val();
                noofdaytoreturn = $(this).parents('tr').find(".noofday").val();
                var b = $(this).parents('tr').find("td:eq(6)").find('input[type="checkbox"]').is(':checked');
                if (b == true) {
                    status = 1;
                }
                else {
                    status = 0;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "setting.aspx/updatedataclasswise",
                    data: "{'classid':'" + classid + "','noofbook':'" + noofbook + "','allowfine':'" + allowfine + "','fineamount':'" + fineamount + "','noofdaytoreturn':'" + noofdaytoreturn + "','status':'" + status + "','session':'" + session + "','cwidforupdate':'" + cwidforupdate + "','settingfor':'" + settingfor + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            call_progressbar("end");
                            alertify.success("Settings Updated Successfully.");                        
                            getdataclasswise(Fyid);
                            return false;
                          
                        }

                        return false;
                    },
                    error: function (result) {
                        call_progressbar("end");
                        return false;
                    }
                });
                $(this).parents('tr').children('td:eq(7)').find('.imgforedit').show(500);
                $(this).parents('tr').children('td:eq(7)').find('.sbtnupdate').hide(500);
                $(this).parents('tr').children('td:eq(7)').find('.sbtncancel').hide(500);
                $(this).parents('tr').find('input').attr('disabled', true)
                $(this).parents('tr').find('input[type="image"],img').attr('disabled', false)
                return false;
            }
            else {
                alertify.error("Please Select The Session ");
                return false;
            }
        })
        //*************************************cancel***************************************************************
        $('.sbtncancel').live('click', function () {
            $(this).parents('tr').children('td:eq(7)').find('.imgforedit').show(500);
            $(this).parents('tr').children('td:eq(7)').find('.sbtnupdate').hide(500);
            $(this).parents('tr').children('td:eq(7)').find('.sbtncancel').hide(500);
            $(this).parents('tr').find('input').attr('disabled', true)
            $(this).parents('tr').find('input[type="image"],img').attr('disabled', false)
            return false;
        });
        //*********************************************show detail class wise*********************************************

        function getdataclasswise(Fyid) {
          $('#classwise').show(500)
            $('.stm tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "setting.aspx/getclasswisedatadetail",
                data: "{'fyid':'" + Fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    var ischecked = "";
                    var isstatus = "";
                    if (data.d.length > 0) {
                        var cssclass = '';
                        for (var i = 0; i < data.d.length; i++) {
                            if (data.d[i].allowfine == "1") {
                                ischecked = "checked"
                            }
                            else {
                                ischecked = "";
                            }
                            if (data.d[i].status == "1") {
                                isstatus = "checked"
                            }
                            else {
                                isstatus = "";
                            }
                            if (i % 2 != 0) 
                                cssclass = 'stm_light';
                            else
                                cssclass='stm_dark';
                            trforappend = '<tr class=' + cssclass + '><td><span class="sbcwid" style="display:none">' + data.d[i].sbcwid + '</span>' + (i + 1) + '</td>' +
                                   '<td> ' + data.d[i].classname + '</td>' + '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" value="' + data.d[i].Noofbook + '" class="noofbook" disabled onkeypress="return isNumberKey(event)"</td>' +
                                   '<td><input class="Chkfine" disabled value="' + data.d[i].allowfine + '" type="checkbox"  style="margin-left:3px;" ' + ischecked + '></td>' +
                                   '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" value="' + parseFloat(data.d[i].fineamount).toFixed(2) + '" class="fineamount" disabled onkeypress="return isNumberKey(event)" </td>' +
                                   '<td class="for_sigle_row_form"><input type=text style="width:100px; height:20px" value="' + data.d[i].noofdaytoreturn + '" class="noofday" disabled onkeypress="return isNumberKey(event)" </td>' +
                                    '<td><input class="Chkstatus" disabled value="' + data.d[i].status + '" type="checkbox"  style="margin-left:3px;" ' + isstatus + '></td>' +
                                    '<td><img class="imgforedit" disabled type="image" style="width:15px;" src="../../images/edit.png" /><img class="sbtncancel" title="Click here for cancel" src="../../images/ic.png" style="display: none; float: right;cursor:pointer"><img class="sbtnupdate" title="Click here for update" src="../../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer">'+
                                   '<input id="hfclassid" type="hidden" value="' + data.d[i].classid + '"></td>'+
                                   '<td><input class=reviseimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/rewised.png /><img class="revisebtncancel" title="Click here for cancel" src="../../images/ic.png" style="display: none; float: right;cursor:pointer"><img class="revisebtnupdate" title="Click here for Revise" src="../../images/update.png" style="display: none; margin-right:2px; float: right;cursor:pointer"></td></tr>';
                            $('.stm').append(trforappend);

                        }
                    }
                    call_progressbar('end')
                },
                error: function (response) {
                    call_progressbar("end");
                }
            });
        }
        // ***********************************************************bind session ddl*****************************************************
        function Bindsession() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "setting.aspx/bindsession",
                data: "",
                dataType: "json",
                async:false,
                success: function (data) {
                    $("#ddlsession").html("");
                    $.each(data.d, function (key, value) {
                        $("#ddlsession").append($("<option></option>").val(value.id).html(value.session));
                    });
                },
                error: function (result) {
                
                },
            });
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        //******************************************************************************************************************************************
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else {
                return true;
            }
        };
       
        //***************************************************************click on revise*******************************************************************

        $('.reviseimage').live('click', function () {
            $(this).parents('tr').find('input').attr('disabled', false);
            $(this).parents('tr').children('td:eq(8)').find('.reviseimage').hide(500);
            $(this).parents('tr').children('td:eq(8)').find('.revisebtncancel').show(500);
            $(this).parents('tr').children('td:eq(8)').find('.revisebtnupdate').show(500);
            return false;
        })
        
        $('.revisebtncancel').live('click', function () {
            $(this).parents('tr').find('input').attr('disabled', true);
            $(this).parents('tr').find('input[type="image"]').attr('disabled', false);
            $(this).parents('tr').children('td:eq(8)').find('.reviseimage').show(500);
            $(this).parents('tr').children('td:eq(8)').find('.revisebtncancel').hide(500);
            $(this).parents('tr').children('td:eq(8)').find('.revisebtnupdate').hide(500);
            return false;
        });
        $('.revisebtnupdate').live('click', function () {
            trindex = $(this).parent('td').parent('tr').index();
            $(this).parents('tr').find('input').attr('disabled', false);
            if (confirm("Are you sure you want Revise this?")) {
                $('#divrevisethesettingdate').show(500);
                return false;
            }
        });
        //*********************************************************cancel popup*****************************************************
        $('#BtnCancelapplydate').live('click', function () {
            $(this).parents('tr').find('input').attr('disabled', true)
            $('#divrevisethesettingdate').hide(500);
          return false;
        });
        $("#ctl00_ContentPlaceHolder1_txtapplydate").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy',
        }).datepicker("setDate", new Date());
        
        $("#ctl00_ContentPlaceHolder1_BtnSubmitdata").click(function () {
            var session = $('#ddlsession').val();
            var settingfor = $("input:radio[name=settingfor]:checked").val();
            var classid = '', noofbook = '', allowfine = '', fineamount = '', noofdaytoreturn = '', status = '', cwid = '', revisesettingapplydate = '';
            classid = $('#classwise tbody').find('tr:eq(' + trindex + ')').find('input[type="hidden"]').val();
            cwid = $('#classwise tbody').find('tr:eq(' + trindex + ')').find('td:eq(0)').find('span').html()
            noofbook = $('#classwise tbody').find('tr:eq(' + trindex + ')').find(".noofbook").val();
            var a = $('#classwise tbody').find('tr:eq(' + trindex + ')').find("td:eq(3)").find('input[type="checkbox"]').is(':checked');
            if (a == true) {
                allowfine = 1;
            }
            else {
                allowfine = 0;
            }

            fineamount = $('#classwise tbody').find('tr:eq(' + trindex + ')').find(".fineamount").val();
            noofdaytoreturn = $('#classwise tbody').find('tr:eq(' + trindex + ')').find(".noofday").val();
            var b = $('#classwise tbody').find('tr:eq(' + trindex + ')').find("td:eq(6)").find('input[type="checkbox"]').is(':checked');
            if (b == true) {
                status = 1;
            }
            else {
                status = 0;
            }
            revisesettingapplydate = $('#ctl00_ContentPlaceHolder1_txtapplydate').val();
            if ($('#ddlsession').val() != "0") {
             call_progressbar("start");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "setting.aspx/revisedataclasswise",
                    data: "{'classid':'" + classid + "','noofbook':'" + noofbook + "','allowfine':'" + allowfine + "','fineamount':'" + fineamount + "','noofdaytoreturn':'" + noofdaytoreturn + "','status':'" + status + "','session':'" + session + "','cwid':'" + cwid + "','settingfor':'" + settingfor + "','revisesettingapplydate':'" + revisesettingapplydate + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 1) {
                            call_progressbar("end");
                            $('#classwise tbody').find('tr:eq(' + trindex + ')').find('td:last').find('.revisebtnupdate').hide(500);
                            $('#classwise tbody').find('tr:eq(' + trindex + ')').find('td:last').find('.revisebtncancel').hide(500);
                            $('#classwise tbody').find('tr:eq(' + trindex + ')').find('td:last').find('.reviseimage').show(500);
                            alertify.success("Settings Revised Successfully.");
                            $('#classwise tbody').find('tr:eq(' + trindex + ')').find('input').attr('disabled', true)
                            $('#classwise tbody').find('tr:eq(' + trindex + ')').find('input[type="image"],img').attr('disabled', false)
                            $('#buttonsaveclasswise').show(500);
                            $('#divrevisethesettingdate').hide(500);
                            getdataclasswise(Fyid);
                            classid = '', noofbook = '', allowfine = '', fineamount = '', noofdaytoreturn = '', status = '', cwid = '', revisesettingapplydate = '';                       
                            return false;
                        }

                    },
                    error: function (result) {
                        call_progressbar("end");
                        return false;
                    }
                });
                return false;
            }
            else {
                alertify.error("Please Select The Session ");
                return false;
            }
            return false;
      
        });

    </script>

</asp:Content>
