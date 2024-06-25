<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdmissionCustomReport.aspx.cs" Inherits="BranchPanel_Admission_AdmissionCustomReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="headfirst" runat="server">
   <%-- <link href="../../css/app.v1.css" rel="stylesheet" />--%>
   
 <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
      <style type="text/css">
          .form-div-brack{
              margin-bottom: 5%;
          }

          .mydatagrid {
              width: 100%;
              border: solid 2px black;
              min-width: 80%;
          }

          .header {
              background-color: #646464;
              font-family: Arial;
              color: White;
              border: none 0px transparent;
              height: 25px;
              text-align: left;
              font-size: 16px;
              border-right-color: black;
          }

          .rows {
              background-color: #fff;
              font-family: Arial;
              font-size: 14px;
              color: #000;
              min-height: 25px;
              text-align: left;
              border: none 0px transparent;
          }

              .rows:hover {
                  background-color: #ff8000;
                  font-family: Arial;
                  color: #fff;
                  text-align: left;
              }

          .selectedrow {
              background-color: #ff8000;
              font-family: Arial;
              color: #fff;
              font-weight: bold;
              text-align: left;
          }

          .mydatagrid a /** FOR THE PAGING ICONS  **/ {
              background-color: Transparent;
              padding: 5px 5px 5px 5px;
              color: #fff;
              text-decoration: none;
              font-weight: bold;
          }

              .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/ {
                  background-color: #c9c9c9;
                  color: #fff;
              }

          .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/ {
              /*background-color: #c9c9c9;*/
              color: #000;
              padding: 5px 5px 5px 5px;
          }

          .pager {
              background-color: #646464;
              font-family: Arial;
              color: White;
              height: 30px;
              text-align: left;
          }

          .mydatagrid td {
              padding: 5px;
          }

          .mydatagrid th {
              padding: 5px;
          }

          .BorderRight {
              border-right-color: black
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

          .clear {
              clear: both;
          }

          .student_sty {
              border-top: 1px dashed #454545;
              margin: 0 10px;
              padding-top: 10px;
          }

          .ml10 {
              margin-left: 10px;
          }

          .amnt_img {
              background: url(../../images/amountbox.png) no-repeat left -13px;
              width: 267px;
          }
      </style>
 
    <style type="text/css">
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

        .clear {
            clear: both;
        }

        .student_sty {
            border-top: 1px dashed #454545;
            margin: 0 10px;
            padding-top: 10px;
        }

        .ml10 {
            margin-left: 10px;
        }

        .amnt_img {
            background: url(../../images/amountbox.png) no-repeat left -13px;
            width: 267px;
        }
    </style>
         <script src="../../js/jquery-1.11.1.min.js"></script>    
</head>
<body>
    <form id="form1" runat="server">

         <div style="float: right; width:auto;">           
             <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" Width="30" height="30" ImageUrl="~/images/print.png" style="float: right; cursor: pointer" />
        </div>
        <br />        
            <div style="width: 680px; min-height: 450px; position:relative; margin: auto auto 60px; margin-bottom: 35px;  border-bottom: 1px dashed rgb(157, 157, 157);">
                <table style="width: 100%">
                    <tr>
                        <td style="width:15%">
                            <div style="float: left; padding: 5px 5px 0" id="divforlogo" runat="server">
                                <asp:Image ID="btnlogoforrecipt" runat="server" Width="100px" />
                            </div>
                        </td>
                        <td style="width:60%">
                            <dl style="font-size: 26px; height: 8px; text-align: center; font-family: Arial; color: #424546; font-weight: 600;"><span id="SchoolName" runat="server"></span></dl>
                            <h3 id="insaddress" runat="server" style="font-size: 12px; text-align: center; font-family: Arial; color: #424546;">
                                    <asp:Label runat="server" ID="spanaddress"></asp:Label></h3>
                            <h3 id="insservicetaxno" runat="server" style="font-size: 12px; text-align: center; font-family: Arial; color: #424546;">CBSE Affiliation No :
                                    <asp:Label runat="server" ID="lblSchoolAffi"></asp:Label></h3>
                        </td>
                        <td style="width:25%">
                            <div class="receiptwrapper_add" style="float: right; text-align:right; font-size: 12px; font-family: Arial; color: #656d70;">
                                <p id="inscontact" runat="server" style="padding: 0px; margin: 2px 0;">Ph.: 
                                    <asp:Label runat="server" ID="lblcontact"></asp:Label></p>
                                <p id="inscontact2" runat="server" style="padding: 0px; margin: 2px 0;">Mob : 
                                    <asp:Label runat="server" ID="lblMob"></asp:Label></p> 
                                <p id="instin" runat="server" style="padding: 0px; margin: 2px 0;">
                                    <asp:Label runat="server" ID="lblservicetax"></asp:Label></p>
                                <p id="P1" runat="server" style="padding: 0px; margin: 2px 0;">
                                    <asp:Label runat="server" ID="lblEmailID"></asp:Label></p>                                                                                               
                            </div>
                        </td>
                    </tr>
                </table>
           <h3 style=" text-align:center; font-size:18px; margin:10px 0 0;  font-family:Arial; color:#656d70;">Admission Receipt</h3>
           
<div id="divRegistratio_No" class="form-div-brack" runat="server">
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width: 150px;width:150px;">Registration No :</p>
    <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; margin:12px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162;width: 400px;">
        <span id="Registratio_No" runat="server" ></span>
    </dl>
</div>

<div id="divstudentname" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Student Name :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="studentname" runat="server"></span>
  </dl>
</div>

<div id="divClassname" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Class Name :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Classname" runat="server"></span>
  </dl>
</div>

<div id="divfathername" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Father Name :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="fathername" runat="server"></span>
  </dl>
</div>

<div id="divMobileNo" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Father Name :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="MobileNo" runat="server"></span>
  </dl>
</div>


<div id="divStudentDOB" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Student DOB :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="StudentDOB" runat="server"></span>
  </dl>
</div>
                
<div id="divGender" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Gender :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Gender" runat="server"></span>
  </dl>
</div>
                
<div id="divCountryName" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Country Name :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="CountryName" runat="server"></span>
  </dl>
</div>
                
<div id="divReligion" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Religion :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Religion" runat="server"></span>
  </dl>
</div>
                
<div id="divAddress" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Address :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Address" runat="server"></span>
  </dl>
</div>
                
<div id="divCity" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">City :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="City" runat="server"></span>
  </dl>
</div>
                
<div id="divState" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">State :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="State" runat="server"></span>
  </dl>
</div>
                
<div id="divPin" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Pin :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Pin" runat="server"></span>
  </dl>
</div>
                
<div id="divCountry" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Country :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Country" runat="server"></span>
  </dl>
</div>
                
<div id="divAadhar_Card" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Aadhar Card :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Aadhar_Card" runat="server"></span>
  </dl>
</div>
                
<div id="divBirth_Certificate" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Birth Certificate :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Birth_Certificate" runat="server"></span>
  </dl>
</div>
                
<div id="divMigration_Certificate" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Migration Certificate :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Migration_Certificate" runat="server"></span>
  </dl>
</div>
                
<div id="divCaste_Certificate" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">Caste Certificate :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="Caste_Certificate" runat="server"></span>
  </dl>
</div>
                
<div id="divLastYear_Marksheet" class="form-div-brack" runat="server">
    <br />
    <p style="font-size:15px; float:left; font-family:Arial; color:#424546;width:150px;">LastYear Marksheet :</p>
  <dl style="float:left; font-size:15px;  font-family:Arial; color:#424546; font-weight:600;  margin:12px 1% 10px 0px; border-bottom:1px solid #5f6162;width: 400px;">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="LastYear_Marksheet" runat="server"></span>
  </dl>
</div>


        
</div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "admission-list.aspx/BindPermission",
                 data: "",
                 dataType: "json",
                 success: function (data) {
                     if (data.d.length > 0) {                       
                         if (!data.d[0].Registratio_No) {
                             $('#divRegistratio_No').hide();                             
                         }
                         if (!data.d[0].studentname) {
                             $('#divstudentname').hide();   
                         }
                         if (!data.d[0].Classname) {
                             $('#divClassname').hide();   
                         }
                          if (!data.d[0].fathername) {
                             $('#divfathername').hide();   
                         }
                          if (!data.d[0].MobileNo) {
                             $('#divMobileNo').hide();   
                         }
                          if (!data.d[0].StudentDOB) {
                             $('#divStudentDOB').hide();   
                         }
                          if (!data.d[0].Gender) {
                             $('#divGender').hide();   
                         }
                          if (!data.d[0].CountryName) {
                             $('#divCountryName').hide();   
                         }
                          if (!data.d[0].Religion) {
                             $('#divReligion').hide();   
                         }
                          if (!data.d[0].Address) {
                             $('#divAddress').hide();   
                         }
                          if (!data.d[0].City) {
                             $('#divCity').hide();   
                         }
                          if (!data.d[0].State) {
                             $('#divState').hide();   
                         }
                          if (!data.d[0].Pin) {
                             $('#divPin').hide();   
                         }
                          if (!data.d[0].Country) {
                             $('#divCountry').hide();   
                         }
                          if (!data.d[0].Aadhar_Card) {
                             $('#divAadhar_Card').hide();   
                         }
                          if (!data.d[0].Birth_Certificate) {
                             $('#divBirth_Certificate').hide();   
                         }
                          if (!data.d[0].Migration_Certificate) {
                             $('#divMigration_Certificate').hide();   
                         }
                          if (!data.d[0].Caste_Certificate) {
                             $('#divCaste_Certificate').hide();   
                         }
                          if (!data.d[0].LastYear_Marksheet) {
                             $('#divLastYear_Marksheet').hide();   
                         }

                         //$('#Registratio_No:not(:checked)').attr('checked', data.d[0].Registratio_No);
                         //$('#studentname:not(:checked)').attr('checked', data.d[0].studentname);
                         //$('#Classname:not(:checked)').attr('checked', data.d[0].Classname);
                         //$('#fathername:not(:checked)').attr('checked', data.d[0].fathername);
                         //$('#MobileNo:not(:checked)').attr('checked', data.d[0].MobileNo);
                         //$('#StudentDOB:not(:checked)').attr('checked', data.d[0].StudentDOB);
                         //$('#Gender:not(:checked)').attr('checked', data.d[0].Gender);
                         //$('#CountryName:not(:checked)').attr('checked', data.d[0].CountryName);
                         //$('#Religion:not(:checked)').attr('checked', data.d[0].Religion);
                         //$('#Address:not(:checked)').attr('checked', data.d[0].Address);
                         //$('#City:not(:checked)').attr('checked', data.d[0].City);
                         //$('#State:not(:checked)').attr('checked', data.d[0].State);
                         //$('#Pin:not(:checked)').attr('checked', data.d[0].Pin);
                         //$('#Country:not(:checked)').attr('checked', data.d[0].Country);
                         //$('#Aadhar_Card:not(:checked)').attr('checked', data.d[0].Aadhar_Card);
                         //$('#Birth_Certificate:not(:checked)').attr('checked', data.d[0].Birth_Certificate);
                         //$('#Migration_Certificate:not(:checked)').attr('checked', data.d[0].Migration_Certificate);
                         //$('#Caste_Certificate:not(:checked)').attr('checked', data.d[0].Caste_Certificate);
                         //$('#LastYear_Marksheet:not(:checked)').attr('checked', data.d[0].LastYear_Marksheet);                        
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error("Error While Grid Is Binding");
                     call_progressbar("end");
                 }
             });
        });
    </script>
</body>
    </html>
