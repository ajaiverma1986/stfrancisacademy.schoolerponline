<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="StuAttendance.aspx.cs" Inherits="Teacherpanel_StuAttendance" %>
<%--<%@ Page EnableEventValidation="true" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" media="all" />



  <%--  <style type="text/css">
        .leaveactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .Highlighted a {
            background-color: #FFFF00 !important;
            pointer-events: none;
        }

            .Highlighted a:hover {
                color: #ff0000 !important;
                pointer-events: none;
            }

        .active6 {
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

        .important {
            color: white!important;
        }

            .important a {
                color: white!important;
            }

        td {
            border-bottom: 1px black !important;
            border-top: 1px black !important;
        }

        th {
            border-top: 1px black !important;
        }

        .ui-datepicker table {
            border-collapse: collapse;
            font-size: 0.7em;
            margin: 0 0 0.4em;
            width: 100%;
        }

        .ui-datepicker-multi-2 .ui-datepicker-group {
            width: 45%;
        }

        .col-md-9 select {
            border: 1px solid #ccc;
            border-radius: 0 !important;
            color: #676767;
            margin-bottom: 0;
            padding: 4px 5px;
            width: 293px;
        }

        .col-md-9 textarea {
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 64px;
            line-height: 20px;
            margin-bottom: 0;
            margin-top: 0;
            padding: 3px 6px;
            text-align: left;
            transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
            width: 300px;
        }

        .col-md-9 label {
            color: #616161;
            float: left;
            font-size: 13px;
            margin-right: 20px;
            padding-top: 2px;
            text-align: right;
            width: 123px;
        }

        body {
            color: #333333;
            font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 13px;
            line-height: 1.42857;
        }

        .stm_head th {
            font-size: 13px;
        }

        .texthover {
            border: 1px solid red !important;
        }
    </style>
    <script type="text/javascript">
       
    </script>--%>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                       <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Student Attendance
                    </h1>
                </div>
                <div class="clearfix">
                </div>

                <div class="main-content">
              
                      <div style="width: 100%; " id="divdatewiseleave">

                               <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Take/Update Attendance</h2>
            </div>
            <div class="main-div-tbl">
                <div class="new-registration">
                    <div class="sub-heading">
                        Attendance Information
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Class For Attendance<span style="color: Red; font-weight: bold">*</span></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlapplyingforclass"  Width="26%"  CssClass="btn btn-secondry dropdown-toggle" runat="server" OnSelectedIndexChanged="ddlapplyingforclass_SelectedIndexChanged">
                            <asp:ListItem Value="0">--Select  Class--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Section  For Attendance<span style="color: Red; font-weight: bold">*</span></label>&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlsection" runat="server"  Width="26%"  CssClass="btn btn-secondry dropdown-toggle">
                            <asp:ListItem Value="0">--Select  Section--</asp:ListItem>
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Date<span style="color: Red; font-weight: bold">*</span></label> &nbsp;&nbsp;
                        <asp:TextBox ID="txtdateforattendance" runat="server" placeholder="Select Date Please" onkeypress="return false"></asp:TextBox>
                    </div>
                    <div class="sub-heading">
                        Student List
                    </div>
                    <div class="ClassForAttendance">
                        <table class="stm tblforattendance" width="100%">
                            <tr class="stm_head">
                                <th>S.NO.</th>
                                <th>Admission NO</th>
                                <th>Mark As Absent</th>
                                <th>Student Name</th>
                                <th>Attendance Status</th>
                            </tr>
                        </table>
                    </div>
                    <div class="for_sigle_row_form" style="margin-bottom:10px;display:none" id="divforsubmit">
                        <label>
                        </label>
                        <asp:Button ID="btnforsubmit" runat="server" Text="SUBMIT" CssClass="button_save" />
                    </div>
                </div>
            </div>
        </div>
    </div>


                            </div>

                </div>
            </div>
        </div>
    </div>
      <script type="text/javascript">
          var year = 2015;
          var AdmissionNo = '', AttendanceStatus = '', SturegNo = '';
          $(document).ready(function () {
              $("#ctl00_head_txtdateforattendance").datepicker({
                  changeMonth: true,
                  changeYear: true,
                  dateFormat: 'dd MM yy',
                  maxDate: new Date()
              }).datepicker("setDate", new Date());

              $('#ctl00_head_ddlapplyingforclass').change(function () {
                  $('#ctl00_head_ddlsection').html('');
                  $.ajax({
                      type: 'POST',
                      contentType: "application/json; charset=utf-8",
                      url: "StuAttendance.aspx/BindSectionDDL",
                      data: "{'Classid':'" + $(this).val() + "'}",
                      dataType: "json",
                      success: function (data) {
                          $('#ctl00_head_ddlsection').html('<option value="0">--Select Section--</option>');
                          if (data.d.length > 0) {
                              for (var i = 0; i < data.d.length; i++) {
                                  $('#ctl00_head_ddlsection').append('<option value="' + data.d[i].SECTIONID + '">' + data.d[i].SECTIONNAME + '</option>');
                              }
                          }
                      }
                  });
              });
              $('#ctl00_head_btnforsubmit').click(function () {
                  $('.tblforattendance').find('tbody').find('tr:gt(0)').each(function () {
                      AdmissionNo = AdmissionNo + ',' + $(this).find('td:eq(1)').html();
                      SturegNo = SturegNo + ',' + $(this).find('td:eq(2)').find('input[type="checkbox"]').val();
                      if ($(this).find('td:eq(2)').find('input[type="checkbox"]').prop('checked') == true) {
                          AttendanceStatus = AttendanceStatus + ',' + '0';
                      }
                      else {
                          AttendanceStatus = AttendanceStatus + ',' + '1';
                      }
                  });
                  AdmissionNo = AdmissionNo.slice(1, AdmissionNo.length);
                  SturegNo = SturegNo.slice(1, SturegNo.length);
                  AttendanceStatus = AttendanceStatus.slice(1, AttendanceStatus.length);
                  $.ajax({
                      type: 'POST',
                      contentType: "application/json; charset=utf-8",
                      url: "StuAttendance.aspx/TakeAttendance",
                      data: "{'AdmissionNo':'" + AdmissionNo + "','SturegNo':'" + SturegNo + "','AttendanceStatus':'" + AttendanceStatus + "','Date':'" + $('#ctl00_head_txtdateforattendance').val() + "'}",
                      dataType: "json",
                      success: function (data) {
                          if (data.d == '1') {
                              alertify.success('Attendance Taken Successfully.');
                          }
                          if (data.d == '0') {
                              alertify.success('Some Error While Taking Attendance.');
                          }
                          AdmissionNo = '', SturegNo = '', AttendanceStatus = '';
                          return false;
                      }
                  });
                  return false;
              });
              $('#ctl00_head_ddlsection,#ctl00_head_txtdateforattendance').change(function () {
                  TakeAttendanceDefault();
              });

              $('.chkforabsent').live('change', function () {
                  if ($(this).prop('checked') == true) {
                      $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'red');
                      $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', 'cursive');
                  }
                  else {
                      $(this).parent('td').parent('tr').find('td:eq(3)').css('color', 'black');
                      $(this).parent('td').parent('tr').find('td:eq(3)').css('font-family', '"Helvetica Neue",Helvetica,Arial,sans-serif');
                  }
              });

          });
          function TakeAttendanceDefault() {
              if ($('#ctl00_head_ddlapplyingforclass').val() == '0') {
                  alertify.error('Select Class Please.');
              }
              else if ($('#ctl00_head_ddlsection').val() == '0') {
                  alertify.error('Select Section Please.');
              }
              else if ($('#ctl00_head_txtdateforattendance').val() == '') {
                  alertify.error('Select Date Please.');
              }
              else {
                  BindAttendanceGrid();
              }
              return false;
          }
          function BindAttendanceGrid() {
              $('#divforsubmit').css("display", "none");
              var trforappend = '', trclass = '', tdclass = '';
              $.ajax({
                  type: 'POST',
                  contentType: "application/json; charset=utf-8",
                  url: "StuAttendance.aspx/BindAttendanceGrid",
                  data: "{'Classid':'" + $('#ctl00_head_ddlapplyingforclass').val() + "','SectionId':'" + $('#ctl00_head_ddlsection').val() + "','Date':'" + $('#ctl00_head_txtdateforattendance').val() + "'}",
                  dataType: "json",
                  success: function (data) {
                      $('.tblforattendance').find('tbody').find('tr:gt(0)').remove();
                      if (data.d.length > 0) {
                          $('#divforsubmit').css("display", "block");
                          for (var i = 0; i < data.d.length; i++) {
                              if (i % 2 == 0) {
                                  trclass = 'stm_dark'
                              }
                              else {
                                  trclass = 'stm_light'
                              }
                              if (data.d[i].CHECKBOXSTATUS != '') {
                                  tdclass = 'style="color:red;font-family:cursive"'
                              }
                              else {
                                  tdclass = '';
                              }
                              trforappend = trforappend + '<tr class="' + trclass + '">' +
                                  '<td>' + data.d[i].ROWNUMBER + '</td>' +
                                  '<td>' + data.d[i].ADMISSIONNO + '</td>' +
                                  '<td><input type="checkbox" value="' + data.d[i].STUREGNO + '" ' + data.d[i].CHECKBOXSTATUS + ' class="chkforabsent" /></td>' +
                                  '<td ' + tdclass + '>' + data.d[i].NAME + '</td>' +
                                  '<td>' + data.d[i].ATTENDANCESTATUS + '</td>' +
                                  '</tr>'
                          }
                      }
                      else {
                          trforappend = '<tr>' +
                                  '<td></td>' +
                                  '<td></td>' +
                                  '<td>No Student List Found.</td>' +
                                  '<td</td>' +
                                  '<td></td>' +
                                  '</tr>'
                      }
                      $('.tblforattendance').append(trforappend);
                      trforappend = '', trclass = '';
                  }
              });
          }
    </script>
    <asp:HiddenField runat="server" ID="hfempcode" />
    <label id="chkapplyedleave" style="display: none"></label>

</asp:Content>

