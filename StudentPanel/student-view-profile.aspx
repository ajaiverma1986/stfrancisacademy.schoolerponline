<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student-panel-master.master" AutoEventWireup="true" CodeFile="student-view-profile.aspx.cs" Inherits="EmployeePanel_employee_view_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>
    <style>

      
        .widget {
            margin-bottom:20px;
        }
        
        

       
         .profileactive {
             margin: 0px -3px;
            background-color: #2aa9eb;
           
         
        }


        .side-bar-wrapper .side-menu > li .profileactive i {
             border-right: 1px solid #2cd7fb;
                -webkit-box-shadow: 1px 0px 0px 0px #1d93d0;
                box-shadow: 1px 0px 0px 0px #1d93d0;
        }


        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px!important;
            font-weight: normal!important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 1px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 0.50px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }

        .content-wrapper .main-content {
           
        }
         .t1 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
            width: 180px!important;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 180px!important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 180px!important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 180px!important;
        }
        /*.showpopupforchangepassword {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 10px solid #24272E;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 40%;
            opacity: 1;
            position: fixed;
            top: 32%;
            width: 38%;
            z-index: 2147483647;
        }*/

            .showpopupforchangepassword td {
                vertical-align: top;
                color: #666666;
            }

        #lblmessage {
            color: red;
        }
    </style>

     <%--for check password strength start here--%>

    <style>
        .txtrePassstregthtooshortdiv, .txtrePassstregthweakdiv, .txtrePassstregthgooddiv, .txtrePassstregthstrongdiv, .txtPassstregthtooshortdiv, .txtPassstregthweakdiv, .txtPassstregthgooddiv, .txtPassstregthstrongdiv, .txtcurrentPassstregthtooshortdiv, .txtcurrentPassstregthweakdiv, .txtcurrentPassstregthgooddiv, .txtcurrentPassstregthstrongdiv {
            width: 300px;
            height: 200px;
            border: 1px solid black;
            -webkit-animation: mymove 5s infinite; /* Chrome, Safari, Opera */
            animation: mymove 5s infinite;
        }

        /* Chrome, Safari, Opera */
        @-webkit-keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }

        /* Standard syntax */
        @keyframes mymove {
            50% {
                border-radius: 50px;
            }
        }
    </style>
    <%--for check password strength end here--%>
      <script type="text/javascript">

          var oldpassword = "", newpassword = "", Confirmnewpassword = "";
          var ctr = 1;
          $(document).on("click", "[id*=lbtnchangepassword]", function () {
              $('#ctl00_head_tdbtnclose').html('Close');
              $("#ctl00_head_divchangepassword").show(500);
              $("#ctl00_head_divchangepassword").fadeIn();
              $('#ctl00_head_txtcurrentpassword').val('');
              return false;
          });

          function call_progressbar(progtype) {
              if (progtype == "start") {
                  $("#divProgressBar").find("#loader").remove();
                  $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                  $("#divProgressBar").addClass("progressAdd");
              }
              if (progtype == "end") {
                  $("#divProgressBar").find("#loader").remove();
                  $("#divProgressBar").removeClass("progressAdd");
              }
          }

          $(document).ready(function () {
              FillQualification();
              $("#ctl00_head_tdbtnclose").click(function () {
                  $("#ctl00_head_divchangepassword").hide(600);
                  $('#ctl00_head_txtcurrentpassword').val('');
                  $('#ctl00_head_txtnewpassword').val('');
                  $('#ctl00_head_txtconfirmnewpassword').val('');
                  $('#lblmessage').html('');

              });
              $('#ctl00_head_btnchangepassword').click(function () {
                  if ($('#ctl00_head_txtcurrentpassword').val() == "") {
                      $('#lblmessage').html('Enter Current Password Please.');
                  }
                  else if ($('#ctl00_head_txtnewpassword').val() == "") {
                      $('#lblmessage').html('Enter New Password Please.');
                  }
                  else if ($('#ctl00_head_txtconfirmnewpassword').val() == "") {
                      $('#lblmessage').html('Confirm New Password Please.');
                  }
                  else {
                      oldpassword = $('#ctl00_head_txtcurrentpassword').val();
                      newpassword = $('#ctl00_head_txtnewpassword').val();
                      Confirmnewpassword = $('#ctl00_head_txtconfirmnewpassword').val();
                      call_progressbar("start");
                      $.ajax({
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "student-view-profile.aspx/ChangePassword",
                          data: "{'oldpassword':'" + oldpassword + "','newpassword':'" + newpassword + "','Confirmnewpassword':'" + Confirmnewpassword + "'}",
                          dataType: "json",
                          success: function (data) {
                              if (data.d == 1) {
                                  $('#lblmessage').html('Password Changed Sucessfully.');
                                  $('#ctl00_head_txtcurrentpassword').val('');
                                  $('#ctl00_head_txtnewpassword').val('');
                                  $('#ctl00_head_txtconfirmnewpassword').val('');
                                  checkStrength($('#ctl00_head_txtnewpassword').val());
                                  checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                  checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                              }
                              if (data.d == 2) {
                                  $('#lblmessage').html('your current password is incorrect.');
                                  $('#ctl00_head_txtcurrentpassword').val('');
                                  $('#ctl00_head_txtnewpassword').val('');
                                  $('#ctl00_head_txtconfirmnewpassword').val('');
                                  checkStrength($('#ctl00_head_txtnewpassword').val());
                                  checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                  checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                              }
                              if (data.d == 3) {
                                  $('#lblmessage').html('New Password & Confirm New Password are not same.');
                                  $('#ctl00_head_txtcurrentpassword').val('');
                                  $('#ctl00_head_txtnewpassword').val('');
                                  $('#ctl00_head_txtconfirmnewpassword').val('');
                                  checkStrength($('#ctl00_head_txtnewpassword').val());
                                  checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                                  checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                              }
                              call_progressbar("end");
                              return false;
                          },
                          error: function (result) {
                              call_progressbar("end");
                              $('#lblmessage').html('Some Error Try Again Plz.');
                          }
                      });
                  }
                  return false;
              });
              $('#ctl00_head_txtcurrentpassword').focus(function () {
                  $('#lblmessage').html('');
              });
              $('#ctl00_head_txtnewpassword').focus(function () {
                  $('#lblmessage').html('');
              });
              $('#ctl00_head_txtconfirmnewpassword').focus(function () {
                  $('#lblmessage').html('');
              });

              //code for check passwword strength start here

              $('#ctl00_head_txtnewpassword').keyup(function () {
                  if ($('#ctl00_head_txtnewpassword').val() != '') {
                      checkStrength($('#ctl00_head_txtnewpassword').val());
                  }
                  else {
                      $('.txtPassstregthtooshortdiv').hide();
                  }
              })
              //checkStrength($('#ctl00_head_txtnewpassword').val());
              //Code For Confirm Password
              $('#ctl00_head_txtconfirmnewpassword').keyup(function () {
                  if ($('#ctl00_head_txtconfirmnewpassword').val() != '') {
                      checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());
                  }
                  else {
                      $('.txtrePassstregthtooshortdiv').hide();
                  }
              })
              //checkStrength_Confirm($('#ctl00_head_txtconfirmnewpassword').val());

              $('#ctl00_head_txtcurrentpassword').keyup(function () {
                  if ($('#ctl00_head_txtcurrentpassword').val() != '') {
                      checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
                  }
                  else {
                      $('.txtcurrentPassstregthtooshortdiv').hide();
                  }
              })
              //checkStrength_Current($('#ctl00_head_txtcurrentpassword').val());
              //code for check passwword strength end here
          });
          function checkStrength(password) {
              //initial strength
              var strength = 0

              //if the password length is less than 6, return message.
              if (password.length < 6) {
                  //$('#result').removeClass()
                  //$('#result').addClass('short')
                  $('.txtPassstregthtooshortdiv').show();
                  $('.txtPassstregthweakdiv').hide();
                  $('.txtPassstregthgooddiv').hide();
                  $('.txtPassstregthstrongdiv').hide();
                  return 'Too short'
              }

              //length is ok, lets continue.

              //if length is 6 characters or more, increase strength value
              if (password.length > 5) strength += 1

              //if password contains both lower and uppercase characters, increase strength value
              if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

              //if it has numbers and characters, increase strength value
              if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

              //if it has one special character, increase strength value
              if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //if it has two special characters, increase strength value
              //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //now we have calculated strength value, we can return messages

              //if value is less than 2
              if (strength < 2) {
                  //$('#result').removeClass()
                  //$('#result').addClass('weak')
                  $('.txtPassstregthtooshortdiv').hide();
                  $('.txtPassstregthweakdiv').show();
                  $('.txtPassstregthgooddiv').hide();
                  $('.txtPassstregthstrongdiv').hide();
                  return 'Weak'
              }
              else if (strength == 2) {
                  //$('#result').removeClass()
                  //$('#result').addClass('good')
                  $('.txtPassstregthtooshortdiv').hide();
                  $('.txtPassstregthweakdiv').hide();
                  $('.txtPassstregthgooddiv').show();
                  $('.txtPassstregthstrongdiv').hide();
                  return 'Good'
              }
              else {
                  //$('#result').removeClass()
                  //$('#result').addClass('strong')
                  $('.txtPassstregthtooshortdiv').hide();
                  $('.txtPassstregthweakdiv').hide();
                  $('.txtPassstregthgooddiv').hide();
                  $('.txtPassstregthstrongdiv').show();
                  return 'Strong'
              }
          }

          function checkStrength_Confirm(password) {
              //initial strength
              var strength = 0

              //if the password length is less than 6, return message.
              if (password.length < 6) {
                  $('.txtrePassstregthtooshortdiv').show();
                  $('.txtrePassstregthweakdiv').hide();
                  $('.txtrePassstregthgooddiv').hide();
                  $('.txtrePassstregthstrongdiv').hide();
                  return 'Too short'
              }

              //length is ok, lets continue.

              //if length is 6 characters or more, increase strength value
              if (password.length > 5) strength += 1

              //if password contains both lower and uppercase characters, increase strength value
              if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

              //if it has numbers and characters, increase strength value
              if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

              //if it has one special character, increase strength value
              if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //if it has two special characters, increase strength value
              //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //now we have calculated strength value, we can return messages

              //if value is less than 2
              if (strength < 2) {
                  $('.txtrePassstregthtooshortdiv').hide();
                  $('.txtrePassstregthweakdiv').show();
                  $('.txtrePassstregthgooddiv').hide();
                  $('.txtrePassstregthstrongdiv').hide();
                  return 'Weak'
              }
              else if (strength == 2) {
                  $('.txtrePassstregthtooshortdiv').hide();
                  $('.txtrePassstregthweakdiv').hide();
                  $('.txtrePassstregthgooddiv').show();
                  $('.txtrePassstregthstrongdiv').hide();
                  return 'Good'
              }
              else {
                  $('.txtrePassstregthtooshortdiv').hide();
                  $('.txtrePassstregthweakdiv').hide();
                  $('.txtrePassstregthgooddiv').hide();
                  $('.txtrePassstregthstrongdiv').show();
                  return 'Strong'
              }
          }

          function checkStrength_Current(password) {
              //initial strength
              var strength = 0

              //if the password length is less than 6, return message.
              if (password.length < 6) {
                  $('.txtcurrentPassstregthtooshortdiv').show();
                  $('.txtcurrentPassstregthweakdiv').hide();
                  $('.txtcurrentPassstregthgooddiv').hide();
                  $('.txtcurrentPassstregthstrongdiv').hide();
                  return 'Too short'
              }

              //length is ok, lets continue.

              //if length is 6 characters or more, increase strength value
              if (password.length > 5) strength += 1

              //if password contains both lower and uppercase characters, increase strength value
              if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1

              //if it has numbers and characters, increase strength value
              if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1

              //if it has one special character, increase strength value
              if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //if it has two special characters, increase strength value
              //if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1

              //now we have calculated strength value, we can return messages

              //if value is less than 2
              if (strength < 2) {
                  $('.txtcurrentPassstregthtooshortdiv').hide();
                  $('.txtcurrentPassstregthweakdiv').show();
                  $('.txtcurrentPassstregthgooddiv').hide();
                  $('.txtcurrentPassstregthstrongdiv').hide();
                  return 'Weak'
              }
              else if (strength == 2) {
                  $('.txtcurrentPassstregthtooshortdiv').hide();
                  $('.txtcurrentPassstregthweakdiv').hide();
                  $('.txtcurrentPassstregthgooddiv').show();
                  $('.txtcurrentPassstregthstrongdiv').hide();
                  return 'Good'
              }
              else {
                  $('.txtcurrentPassstregthtooshortdiv').hide();
                  $('.txtcurrentPassstregthweakdiv').hide();
                  $('.txtcurrentPassstregthgooddiv').hide();
                  $('.txtcurrentPassstregthstrongdiv').show();
                  return 'Strong'
              }
          }

          function add_Row() {
              ctr++;
              txtqualification = "txtqualification" + ctr;
              var txtboard = "txtboard" + ctr;
              var txtyear = "txtyear" + ctr;
              //var session = "txtsession" + ctr;
              var txtrollnumber = "txtrollnumber" + ctr;
              var txttotalmarks = "txttotalmarks" + ctr;
              var txtobtainedmarks = "txtobtainedmarks" + ctr;
              var txtpercent = "txtpercent" + ctr;
              var remove = "removebtn" + ctr;

              var instituladdress = "txtinstituteaddress" + ctr;

              var newTr = '<tr style="height:25px"><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtqualification +
                  '></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtboard
                  + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtyear
                  
                  + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtrollnumber
                  + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important"  id=' + txttotalmarks
                  + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important"  id=' + txtobtainedmarks
                  + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtpercent
                  + ' ></span></td><td style="border:1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + instituladdress
                  + ' ></span></td></tr>';
              $('#ctl00_head_tbl').append(newTr);

          }

          function FillQualification() {
              if ($('#ctl00_head_txtqualification').val() == "") {
                  $('#ctl00_head_lblmsg').show();
                  $('#ctl00_head_tbl').hide();
              }
              var Qualification = $('#ctl00_head_txtqualification').val().split(",");
              var board = $("#ctl00_head_txtboardlist").val().split(",");
              var passingyear = $('#ctl00_head_txtyear').val().split(",");
              //var session = $('#ctl00_head_txtsession').val().split(",");
              var rollnumber = $('#ctl00_head_txtrollnumber').val().split(",");
              var totalmarks = $('#ctl00_head_txttotalmarks').val().split(",");
              var obtainedmarks = $('#ctl00_head_txtobtainedmarks').val().split(",");
              var parcentasge = $('#ctl00_head_txtpercent').val().split(",")
              var college = $('#ctl00_head_txtinstituteaddress').val().split(",");
              for (var i = 0; i < Qualification.length - 2; i++) {
                  add_Row();
              }
              var row = 1;
              $('#ctl00_head_tbl').find('tr:gt(0)').each(function () {
                  debugger;
                  if (row == 1) {
                      $(this).find('#ctl00_head_ddlqualification1').text(Qualification[row - 1]);
                      $(this).find('#ctl00_head_txtboard1').text(board[row - 1]);
                      $(this).find('#ctl00_head_txtyear1').text(passingyear[row - 1]);
                      //$(this).find('#ctl00_head_txtsession1').text(session[row - 1]);
                      $(this).find('#ctl00_head_txtrollnumber1').text(rollnumber[row - 1]);
                      $(this).find('#ctl00_head_txttotalmarks1').text(totalmarks[row - 1]);
                      $(this).find('#ctl00_head_txtobtainedmarks1').text(obtainedmarks[row - 1]);
                      $(this).find('#ctl00_head_txtpercentage1').text(parcentasge[row - 1]);
                      $(this).find('#ctl00_head_txtinsituteaddress1').text(college[row - 1]);
                      row++;
                  }
                  else {
                      $(this).find('#txtqualification'+row).text(Qualification[row - 1]);
                      $(this).find('#txtboard' + row).text(board[row - 1]);
                      $(this).find('#txtyear' + row).text(passingyear[row - 1]);
                      //$(this).find('#txtsession' + row).text(session[row - 1]);
                      $(this).find('#txttotalmarks' + row).text(totalmarks[row - 1]);
                      $(this).find('#txtobtainedmarks' + row).text(obtainedmarks[row - 1]);
                      $(this).find('#txtrollnumber' + row).text(rollnumber[row - 1]);
                      $(this).find('#txtpercent' + row).text(parcentasge[row - 1]);
                      $(this).find('#txtinstituteaddress' + row).text(college[row - 1]);
                      row++;
                  }
              });
          }
    </script>
    <div class="">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                  
                    <h1>
                        <i class="fa fa-user"></i>
                        Profile
                    </h1>
                </div>

                <div class="main-content">
                    <div class="clearfix"></div>
                    <div class="row">
                         <div class="clearfix"></div>
                        <%--===============Thid div is for Student details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <asp:Image ID="img1" runat="server" Width="100px" Height="100px" style="border:1px solid #ddd; padding:2px;" />
                                        <h3 class="form-title">
                                         
                                            Student Details
                                        </h3>
                                    <div class="clearfix"></div>
                                        <div class="row" style="margin-top: 10px!important">
                                            <table class="table">
                                                <tr>
                                                    <td class="t1"><span>Roll No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblRollno" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Name:</span></td>
                                                    <td class="t2">
                                                        <label id="lblname" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Gender:</span></td>
                                                    <td class="t2">
                                                        <label id="lblGender" runat="server"></label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Date of Birth:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDOB" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Address:</span></td>
                                                    <td class="t2">
                                                        <label id="lblAddress" runat="server"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Board/University:</span></td>
                                                    <td class="t2">
                                                        <label id="lblBoard" runat="server">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Medium:</span></td>
                                                    <td class="t2">
                                                        <label id="lblMedium" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Mobile No for SMS:</span></td>
                                                    <td class="t2">
                                                        <label id="lblMobileno" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Alternate Mobile No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblaltno" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Landline No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblLandlineno" runat="server">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>School/College:</span></td>
                                                    <td class="t2">
                                                        <label id="lblschool" runat="server">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Student Email ID:</span></td>
                                                    <td class="t2">
                                                        <label id="lblemailid" runat="server">--</label>
                                                    </td>
                                                </tr>
                                               
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                        <%--===============Thid div is for Guardian details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <asp:Image ID="Img2" runat="server" Width="100px" Height="100px" style="border:1px solid #ddd; padding:2px; margin:0 auto;"  />
                                        <h3 class="form-title" >
                                           
                                            Guardian Details


                                        </h3>
                                           <div class="clearfix"></div>
                                        <div class="row" style="margin-top: 10px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGName" runat="server">--</label>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Moter Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblmother" runat="server">--</label>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1">
                                                            <span>Relation: </span>
                                                        </td>
                                                        <td class="t2">
                                                            <label id="lblRelation" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Mobile No. for SMS.:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGMobileno" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Email-Id:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGemailid" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Guardian Address:</span></td>
                                                        <td class="t2">
                                                            <label id="lblGAddress" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for student login details Start===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first login-details" style="border-bottom: none!important">
                                            <i class="fa fa-lock"></i>
                                            Login Detail
                                            <a href="#" id="lbtnchangepassword">Change Password</a>
                                        </h3>
                                        <div class="row" >
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>User Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblUserName" runat="server">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Password:</span></td>
                                                        <td class="t2">
                                                            <asp:Label ID="lblpassword" runat="server" Style="cursor: pointer">*****</asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>


                                          <div id="divchangepassword" style=" display: none;" class="forgot-pass" runat="server">
                
                            <h5>Change Password</h5>
                            <table  style="vertical-align: top">
                              
                                <tr>
                                
                                    <td class="t2">
                                        <div>
                                           
                                                <asp:TextBox ID="txtcurrentpassword" runat="server" placeholder="Current Password" TextMode="Password" autocomplete="off"></asp:TextBox>
                                                <div class="txtcurrentPassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                <div class="txtcurrentPassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                <div class="txtcurrentPassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                <div class="txtcurrentPassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                         
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                
                                    <td class="t2">
                                        <div>
                                            <div>
                                                <asp:TextBox ID="txtnewpassword" runat="server"  placeholder="New password" TextMode="Password"></asp:TextBox>

                                                <div class="txtPassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                <div class="txtPassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                <div class="txtPassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                <div class="txtPassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                   <%-- <td class="t1"><span>Confirm New Password:</span></td>--%>
                                    <td class="t2">
                                        <div>
                                            <div>
                                                <asp:TextBox ID="txtconfirmnewpassword" runat="server"  placeholder="Enter Confirm New Password" TextMode="Password"></asp:TextBox>

                                                <div class="txtrePassstregthtooshortdiv" style="background-color: red; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Too Short</span></div>
                                                <div class="txtrePassstregthweakdiv" style="background-color: pink; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px;">Weak</span></div>
                                                <div class="txtrePassstregthgooddiv" style="background-color: yellow; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: black">Good</span></div>
                                                <div class="txtrePassstregthstrongdiv" style="background-color: green; height: 20px; width: 100px; float: right; display: none;"><span style="padding: 5px; color: white">Strong</span></div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Button ID="btnchangepassword" runat="server" Text="Submit" CssClass="button_save" />
                                          <asp:Button ID="tdbtnclose" runat="server" Text="Back" CssClass="button_save" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top: 10px!important">
                                        <label id="lblmessage"></label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                

                                    </div>
                                </div>
                            </div>
                        </div>
                         <%--===============Thid div is for student login details End===============--%>

                        <%-----------------------------Student Qualification Details Start------------------------%>

                        <div class="col-md-6" style="margin-top: -10px!important; margin-right: 64px; width: 100%">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 style="border-bottom: none!important" class="form-title form-title-first">
                                            <i class="icon-reorder"></i>
                                            Educational Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table" style="width:100%">

                                                <tr>
                                                    <td>
                                                        <table id="tbl" runat="server" style="border: 0px solid #808080; width: 100%; margin-left: 0px; margin-top: 10px">

                                                            <tr class="trqualification">

                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Total Marks</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Obtained Marks</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Percentage</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important; width: 30%!important">College/Institute Address</td>
                                                            </tr>

                                                            <tr class="trqualification">
                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="ddlqualification1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtboard1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification" style="width: 80px!important">
                                                                    <asp:Label ID="txtyear1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>


                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtrollnumber1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                
                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txttotalmarks1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                
                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtobtainedmarks1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtpercentage1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtinsituteaddress1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important">
                                                                    </asp:Label></td>
                                                            </tr>
                                                        </table>
                                                        <asp:Label ID="lblmsg" runat="server" Style="display: none; margin-left: 30px" Text="Currently, no education details available."></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                         <%-----------------------------Student Qualification Details End------------------------%>
                         <div class="clearfix"></div>
                    </div>
                     <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <asp:TextBox ID="txtqualification" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtboardlist" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtyear" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtrollnumber" Style="display: none" runat="server"></asp:TextBox>
     <asp:TextBox ID="txttotalmarks" Style="display: none" runat="server"></asp:TextBox>
     <asp:TextBox ID="txtobtainedmarks" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtpercent" Style="display: none" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtinstituteaddress" Style="display: none" runat="server"></asp:TextBox>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>