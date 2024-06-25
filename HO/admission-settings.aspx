<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="admission-settings.aspx.cs" Inherits="HO_admission_settings" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Admission Settings</h2>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Session</label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server">
                <asp:ListItem Value="0">--Select Session--</asp:ListItem>
            </asp:DropDownList>
        </div>
          <div class="for_sigle_row_form">
            <label>Registration From Date</label>
            <asp:TextBox ID="txtregistrationfromdate" runat="server" placeholder="Select Registration From Date" onkeypress="return false;"></asp:TextBox>
        </div>
          <div class="for_sigle_row_form">
            <label>Registration Till Date</label>
          <asp:TextBox ID="txtregistrationtilldate" runat="server" placeholder="Select Registration Till Date" onkeypress="return false;"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Process</label>
            <table class="stm">
                <tr class="stm_head">
                    <th>S.NO.</th>
                    <th>Admission Process</th>
                    <th>Check</th>
                </tr>
                <tr class="stm_light">
                    <td>1</td>
                    <td>Registration <span style="font-weight: bold; color: green">>>></span> Selection <span style="font-weight: bold; color: green">>>></span> Shortlisting <span style="font-weight: bold; color: green">>>></span> Admission</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="1" /></td>
                </tr>
                <tr class="stm_dark">
                    <td>2</td>
                    <td>Registration <span style="font-weight: bold; color: green">>>></span> Admission</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="2" /></td>
                </tr>
                <tr class="stm_light">
                    <td>3</td>
                    <td>Admission</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="3" /></td>
                </tr>
                 <tr class="stm_dark">
                    <td>4</td>
                    <td>1st OR 3rd</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="5" /></td>
                </tr>
                 <tr class="stm_dark">
                    <td>5</td>
                    <td>1st OR 2nd</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="6" /></td>
                </tr>
                 <tr class="stm_dark">
                    <td>6</td>
                    <td>2nd  OR 3rd</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="7" /></td>
                </tr>
                <tr class="stm_dark">
                    <td>7</td>
                    <td>1st OR 2nd OR 3rd</td>
                    <td>
                        <input type="radio" name="radioforprocess" value="4" /></td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <label>Admission Start From</label>
            <asp:TextBox ID="txtselectfromdate" runat="server" placeholder="Select From Date" onkeypress="return false;"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>Admission Till Date</label>
            <asp:TextBox ID="txttilldate" runat="server" placeholder="Select Till Date" onkeypress="return false;"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form" style="display:none">
            <label>Fee Paid System</label>
            <select id="ddlforfeepaytype" runat="server">
                <option value="1">Once</option>
                <option value="3">Half Yearly</option>
                <option value="4">Quarterly</option>
                <option value="5" selected="selected">Monthly</option>
            </select>
        </div>
        <div class="for_sigle_row_form">
            <label>Provisional Admission</label>
            <select id="ddlprovisionaladmission" runat="server">
                <option value="1" selected="selected">Yes</option>
                <option value="0">No</option>
            </select>
        </div>
          <div class="for_sigle_row_form">
            <label>Admission Start From</label>
            <asp:TextBox ID="txtprovisionaladmissionstartfrom" runat="server" placeholder="Select Provisional Admission From Date" onkeypress="return false;"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>Admission Till Date</label>
            <asp:TextBox ID="txtprovisionaladmissiontilldate" runat="server" placeholder="Select Provisional Admission Till Date" onkeypress="return false;"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label></label>
            <asp:Button ID="btnsubmit" runat="server" Text="SUBMIT" CssClass="button_save" />
        </div>
        <input  type="hidden" value="0" id="hfTASID" />
         <script type="text/javascript">
             var TASID, Fyid, ActiveProcessId, AdmissionFromDate, AdmissionToDate, FeePayTypeId, IsProvisionalAdmission, ProvisionalAdmissionFromDate, ProvisionalAdmissionTillDate;
             var RgistrationFromDate, RegistrationTillDate;
             $(document).ready(function () {
                 var year = 2050;
                 $("#ctl00_ContentPlaceHolder1_txtselectfromdate,#ctl00_ContentPlaceHolder1_txttilldate,#ctl00_ContentPlaceHolder1_txtprovisionaladmissionstartfrom,#ctl00_ContentPlaceHolder1_txtprovisionaladmissiontilldate,#ctl00_ContentPlaceHolder1_txtregistrationfromdate,#ctl00_ContentPlaceHolder1_txtregistrationtilldate").datepicker({
                     changeMonth: true,
                     changeYear: true,
                     yearRange: '2000:' + year,
                     dateFormat: 'dd MM yy'
                 });
                 $('#ctl00_ContentPlaceHolder1_btnsubmit').click(function () {
                     var ConfirmSubmit = confirm('Are you sure you want to submit.?');
                     if (ConfirmSubmit == true) {
                         FillData();
                         $.ajax({
                             type: "POST",
                             contentType: "application/json; charset=utf-8",
                             url: "admission-settings.aspx/SaveData",
                             data: "{'TASID':'" + TASID + "','Fyid':'" + Fyid + "','ActiveProcessId':'" + ActiveProcessId + "','AdmissionFromDate':'" + AdmissionFromDate + "','AdmissionToDate':'" + AdmissionToDate + "','FeePayTypeId':'" + FeePayTypeId + "','IsProvisionalAdmission':'" + IsProvisionalAdmission + "','ProvisionalAdmissionFromDate':'" + ProvisionalAdmissionFromDate + "','ProvisionalAdmissionTillDate':'" + ProvisionalAdmissionTillDate + "','RgistrationFromDate':'" + RgistrationFromDate + "','RegistrationTillDate':'" + RegistrationTillDate + "'}",
                             dataType: "json",
                             async: false,
                             success: function (data) {
                                 alertify.success(data.d);
                             }
                         });
                     }
                     return false;
                 });
                 $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "admission-settings.aspx/BindData",
                         data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                         dataType: "json",
                         async: false,
                         success: function (data) {
                             $('#hfTASID').val('0');
                             $('input[type="radio"]').prop('checked', false);
                             $('#ctl00_ContentPlaceHolder1_txtselectfromdate').val('');
                             $('#ctl00_ContentPlaceHolder1_txttilldate').val('');
                             $('#ctl00_ContentPlaceHolder1_ddlforfeepaytype').val('');
                             $('#ctl00_ContentPlaceHolder1_ddlprovisionaladmission').val('1');
                             $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissionstartfrom').val('');
                             $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissiontilldate').val('')
                             $('#ctl00_ContentPlaceHolder1_txtregistrationfromdate').val('');
                             $('#ctl00_ContentPlaceHolder1_txtregistrationtilldate').val('');
                             var xmlDocGeneralDetails = $.parseXML(data.d);
                             var xmlGeneralDetails = $(xmlDocGeneralDetails);
                             var TableGeneralDetails = xmlGeneralDetails.find("Table");
                             TableGeneralDetails.each(function () {
                                 var CurrentDeailsRow = $(this);
                                 $('#hfTASID').val(CurrentDeailsRow.find("TASID").text());
                                 $('input[type="radio"][value="' + CurrentDeailsRow.find("ActiveProcessId").text() + '"]').prop('checked', true);
                                 $('#ctl00_ContentPlaceHolder1_txtselectfromdate').val(CurrentDeailsRow.find("AdmissionFromDate").text());
                                 $('#ctl00_ContentPlaceHolder1_txttilldate').val(CurrentDeailsRow.find("AdmissionToDate").text());
                                 $('#ctl00_ContentPlaceHolder1_ddlforfeepaytype').val(CurrentDeailsRow.find("FeePayTypeId").text());
                                 $('#ctl00_ContentPlaceHolder1_ddlprovisionaladmission').val(CurrentDeailsRow.find("IsProvisionalAdmission").text());
                                 $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissionstartfrom').val(CurrentDeailsRow.find("ProvisionalAdmissionStartFromDate").text());
                                 $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissiontilldate').val(CurrentDeailsRow.find("ProvisionalAdmissionStartTillDate").text());
                                 $('#ctl00_ContentPlaceHolder1_txtregistrationfromdate').val(CurrentDeailsRow.find("RegistrationFromDate").text());
                                 $('#ctl00_ContentPlaceHolder1_txtregistrationtilldate').val(CurrentDeailsRow.find("RegistrationTillDate").text());
                             });
                         }
                     });
                 });
                 $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change();
             });
             function FillData() {
                 TASID = $('#hfTASID').val();
                 Fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
                 ActiveProcessId = $('input[type="radio"]:checked').val();
                 AdmissionFromDate = $('#ctl00_ContentPlaceHolder1_txtselectfromdate').val();
                 AdmissionToDate = $('#ctl00_ContentPlaceHolder1_txttilldate').val();
                 FeePayTypeId = $('#ctl00_ContentPlaceHolder1_ddlforfeepaytype').val();
                 IsProvisionalAdmission = $('#ctl00_ContentPlaceHolder1_ddlprovisionaladmission').val();
                 ProvisionalAdmissionFromDate = $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissionstartfrom').val();
                 ProvisionalAdmissionTillDate = $('#ctl00_ContentPlaceHolder1_txtprovisionaladmissiontilldate').val();
                 RgistrationFromDate = $('#ctl00_ContentPlaceHolder1_txtregistrationfromdate').val();
                 RegistrationTillDate = $('#ctl00_ContentPlaceHolder1_txtregistrationtilldate').val();
             }
         </script>
    </div> 
</asp:Content>