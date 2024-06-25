<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="viewtimetable_daywise.aspx.cs" EnableEventValidation="false" Inherits="BranchPanel_Timetable_viewtimetable_daywise" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Days wise Time Table</h2>
        </div>
         <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server">
            </asp:DropDownList>
        </div>
         <div class="for_sigle_row_form">
          <label>Select Day:<span style="color: red">*</span></label>
            <asp:DropDownList ID="ddldays" runat="server">
            </asp:DropDownList>
        </div>
         </div>
     <div class="binddays" style="display: none">
          <table width="100%" class="stm stmdetail">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">class</th>
                    <th align="center">Details</th>
                </tr>
            </table>         
            </div>
      <div class="divforsection" style="display: none">
          <table width="100%" class="stm sectiondetail">
          <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">class</th>
                    <th align="center">Section</th>
                    <th align="center">Details</th>
                </tr>
              </table>    
      </div>
     <div id="divfordetail" style="display: none">
            <table width="100%" class="stm showdetail">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Period</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Subject</th>
                     <th>Teacher</th>
                </tr>
            </table>
            <div class="for_sigle_row_form">
            <asp:Button ID="btnbackfordetail" runat="server" Text="Back" CssClass="button_cancel" />
                </div>
        </div>
         <script type="text/javascript">
             var id = 0, classid = 0, sectionid = 0;
             $(document).ready(function () {
                 $('.viewimage').live('click', function () {
                     classid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                     $('.divforsection').show();
                     var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                     $('.stmdetail tr:gt(0)').remove();
                     $('.stmdetail').append(gettr);
                     BindClassSection();
                     return false;
                 });
                 $('.viewdetail').live('click',function () {
                     $('#divfordetail').show();
                     sectionid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                     var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                     $('.sectiondetail tr:gt(0)').remove();
                     $('.sectiondetail').append(gettr);
                     showDetails();
                     return false;
                 });
                 $('#ctl00_ContentPlaceHolder1_btnbackfordetail').click(function () {
                     $('.binddays').hide();
                     $('.divforsection').hide();
                     $('#divfordetail').hide();
                     $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                     return false;
                 });
                 $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                     $('.binddays').hide();
                     $('.divforsection').hide();
                     $('#divfordetail').hide();
                     $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                     return false;
                 });
             });
             Bindviewtimetable();
             $('#ctl00_ContentPlaceHolder1_ddldays').change(function () {
                 id = $('#ctl00_ContentPlaceHolder1_ddldays').val();
                 if (id > 0) {
                     $('.binddays').show();
                     $('#divfordetail').hide();
                     BindGrid();
                 }
                 else {
                     $('.binddays').hide();
                     $('#divfordetail').hide();
                 }
                 return false;
             });
             function BindGrid() {
                 $('.stmdetail tr:gt(0)').remove();
                 var trforappend = '', trclass = '';
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "viewtimetable_daywise.aspx/BindGriddays",
                     data: "{'fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "'}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d.length > 0) {
                             for (var i = 0; i < data.d.length; i++) {
                                 if (i % 2 == 0) {
                                     trclass = 'stm_dark';
                                 }
                                 else {
                                     trclass = 'stm_light';
                                 }
                                 trforappend = trforappend + "<tr class=" + trclass + ">" +
                                 "<td><input type='hidden' value=" + data.d[i].Classid + " />" + (i + 1) + "</td>" +
                                 "<td>" + data.d[i].Classname + " </td>" +
                                 "<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td>"
                                 "</tr>";
                             }
                             $('.stmdetail').append(trforappend);
                         }
                         else {
                             alertify.error("No Record Found");
                         }

                     },
                     error: function (result) {
                         alertify.error("Error While Grid Is Binding");

                     }

                 });
             }

             function BindClassSection() {
                 $('.sectiondetail tr:gt(0)').remove();
                 var trforappend = '', trclass = '';
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "viewtimetable_daywise.aspx/BindClassSection",
                     data: "{'classid':'" + classid + "'}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d.length > 0) {
                             for (var i = 0; i < data.d.length; i++) {
                                 if (i % 2 == 0) {
                                     trclass = 'stm_dark';
                                 }
                                 else {
                                     trclass = 'stm_light';
                                 }
                                 trforappend = trforappend + "<tr class=" + trclass + ">" +
                                 "<td><input type='hidden' value=" + data.d[i].Sectionid + ">" + (i + 1) + "</td>" +
                                 "<td>" + data.d[i].Classname + " </td>" +
                                 "<td>" + data.d[i].Sectionname + " </td>" +
                                 "<td><input class='viewdetail' type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../../images/viewquestion.png /></td>"
                                 "</tr>";
                             }
                             $('.sectiondetail').append(trforappend);
                         }
                         else {
                             alertify.error("No Record Found");
                         }

                     },
                     error: function (result) {
                         alertify.error("Error While Grid Is Binding");

                     }

                 });
             }
            
                 function Bindviewtimetable() {
                 $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "viewtimetable_daywise.aspx/viewtimetable",
                          data: "{}",
                          dataType: "json",
                          async: false,
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_ddldays").html("");
                              $("#ctl00_ContentPlaceHolder1_ddldays").append($("<option></option>").val('0').html('--Select Day--'));
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_ddldays").append($("<option></option>").val(value.did).html(value.dayname));
                              });
                          },
                          error: function (result) {
                              alertify.error("Some Error");
                          }
                 });
                             
                 }

                 function showDetails() {
                     $('.showdetail tr:gt(0)').remove();
                     $.ajax({
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "create-timetable-schedule.aspx/PeriodDetail",
                         data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val() + "','sectionid':'" + sectionid + "','dayid':'" + $('#ctl00_ContentPlaceHolder1_ddldays').val() + "'}",
                         dataType: "json",
                         async: false,
                         success: function (data) {
                             if (data.d.length > 0) {
                                 for (var i = 0; i < data.d.length; i++) {
                                     if (i % 2 != 0)
                                         trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                             '<td>' + data.d[i].Periodname + '</td>' +
                                             '<td>' + data.d[i].StartTime + '</td>' +
                                             '<td>' + data.d[i].EndTime + '</td>' +
                                             '<td>' + data.d[i].Subjectname + '</td>' +
                                             '<td>' + data.d[i].Facultyname + '</td></tr>';
                                     else
                                         trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                             '<td>' + data.d[i].Periodname + '</td>' +
                                             '<td>' + data.d[i].StartTime + '</td>' +
                                             '<td>' + data.d[i].EndTime + '</td>' +
                                             '<td>' + data.d[i].Subjectname + '</td>' +
                                               '<td>' + data.d[i].Facultyname + '</td></tr>';
                                     $('.showdetail').append(trforappend);
                                 }
                             }
                             else {
                                 alertify.error("No Record Found");
                             }
                         },
                         error: function (result) {
                             alertify.error('Some Error');
                         }
                     });
                 }
              
               </script>       
</asp:Content>

