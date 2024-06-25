<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration_History.aspx.cs" Inherits="BranchPanel_Fee_Management_Registration_History" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="headfirst" runat="server">
 <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
      <style type="text/css">
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
     <%--<script type="text/javascript">
         $(document).ready(function () {
             $('img').click(function () {
                 var printWindow = window.open('left=500,top=500,width=500,height=500');
                 printWindow.document.write($('#printablediv').html());
                 printWindow.document.close();
                 printWindow.focus();
                 printWindow.print();
                 printWindow.close();
             });
         });
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">

        
        <br />
        
            <div  style="width: 740px; min-height: 450px; position:relative; margin: auto auto 60px; margin-bottom: 35px;  border: 1px solid rgb(157, 157, 157);">
                <table style="width: 100%">
                    <tr>
					 <td style="text-align: left; border: none;width:86%" colspan="1">
                                         <img id="grdSTDResult_ctl02_Image1" class="schoollogo" src="../images/newhome-banner.jpg" style="height:160px;width:100%;border-width:0px;">
                                    </td>
                       
                      
                      
                    </tr>
                </table>

           <h3 style=" text-align:center; font-size:16px; margin:10px 0 0;  font-family:Arial; color:#656d70;">Registration Form 2021-22</h3><br>
           
  <h6 style=" text-align:center; font-size:16px; margin:10px 0 0;  font-family:Arial; color:#656d70;">(Use Capital Letter Only)</h6>
            <p style="float:right; margin:0px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> <span id="recieptdate" runat="server" style="font-weight:600;"></span></p>

           <div style="clear:both;"></div>

  <div style="clear:both;"></div>

  <p style="font-size:16px; float:left; font-family:Arial; color:#424546; width:120px; margin:10px 0 10px;"><b>1.  </b>Pupil's name</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px dotted #5f6162; width:80%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="recipetrecivername" runat="server"></span></dl>
<%--<asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png" Width="120px" Height="120px" />--%>

  <p style="font-size:16px; float:left; font-family:Arial; color:#424546; width:140px; margin:10px 0 10px;"><b>2.  </b>Registration No.</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:10px 1% 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:20%;"><span id="Span2" runat="server" ></span></dl>

      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:45px; margin:11px 0 10px;">&nbsp;Class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:11px 1% 10px 0px; border-bottom:1px dotted #5f6162;  width:12%;"><span id="Span3" runat="server" ></span></dl>
      
      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:60px; margin:11px 0 10px;">&nbspCategory</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:23px 1% 10px 0px; border-bottom:1px dotted #5f6162;  width:12%;"><span id="category" runat="server" ></span></dl>
              

    <div style="clear:both;"></div>

    


               <%-- mkg start--%>
                <br />
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:110px; margin:3px 0 10px;"><b>3.  </b>Date Of Birth:</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -8px 0px; font-weight:600;  border-bottom:1px dotted #5f6162; width:20.9%;">
                    <span id="DOB" runat="server" ></span>
                </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:70px; margin:3px 0 10px; margin-left: 22px;">Gender </p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:4px 1% 10px 0px; border-bottom:1px dotted #5f6162;  width:50%;">
                    <span id="Gender" runat="server" ></span>
                </dl>
				<br/>

                 
                     <span id="Nationality" runat="server" ></span>
                 </dl>
                
     <div style="clear:both;"></div>
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp Religion:</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -35px 0px; font-weight:600;  border-bottom:1px dotted #5f6162; width:19%;">
                    <span id="Religion" runat="server" ></span>
                </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:60px; margin:3px 0 10px; margin-left: 55px;">Address :</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:3px 1% 25px 0px; border-bottom:1px dotted #5f6162;  width:57%;">
                    <span id="Address" runat="server" ></span>
                </dl>
                <br />
     <div style="clear:both;"></div>
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspCity:</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -50px 0px; font-weight:600;  border-bottom:1px dotted #5f6162; width:15%;">
                    <span id="City" runat="server" ></span>
                </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:60px; margin:3px 0 10px; margin-left: 38px;">State :</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:4px 1% 10px -12px; border-bottom:1px dotted #5f6162;  width:15%;">
                    <span id="State" runat="server" ></span>
                </dl>

                 <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Pin:</p>
                 <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -75px 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:15%;">
                     <span id="Pin" runat="server" ></span>
                 </dl>
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;margin-left: 35px;">Country:</p>
                 <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -42px 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:24.9%;">
                     <span id="Country" runat="server" ></span>
                 </dl>
                <br />
     <div style="clear:both;"></div>
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;"><b>4.  </b>Father Name </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:41%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="ParentName" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">Phone No :</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:29%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="PhoneNo" runat="server"></span>
      </dl>
	  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspOccupation </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="occupation" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">Post held</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:29%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="postheld" runat="server"></span>
      </dl>
<p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;"><b>5.  </b>Mother Name </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:81%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="SParentName" runat="server"></span>
      </dl>
	  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspOccupation</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="moccupation" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">Post held</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:29%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="mpostheld" runat="server"></span>
      </dl>
	  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:330px; margin:10px 0 10px;"><b>6.  </b>Local gaurdian's Name(if any) </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:66%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="lgaurdianName" runat="server"></span>
      </dl>
	   <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspAddress</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="gaddress" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">Mobile</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:29%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="gmobile" runat="server"></span>
      </dl>
	   <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:330px; margin:10px 0 10px;"><b>7.  </b>School last attended</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:66%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="slastattended" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:330px; margin:10px 0 10px;"><b>8.  </b>Class last studies(till date)</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:66%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="classlast" runat="server"></span>
      </dl>
	                  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:330px; margin:10px 0 10px;"><b>9.  </b>  Admission Sought to class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:66%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="admisssighttoclass" runat="server"></span>
	 
      </dl>
	                  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:370px; margin:10px 0 10px;"><b>10.  </b>  Maintain any serious illness/handicap</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:61%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="illnesshistry" runat="server"></span>
      </dl>
	  
      <div style="clear:both;"></div>
	  
	  <center><b>Document Status</b></center>
      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Aadhar card:</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -17px 0px; font-weight:600;  border-bottom:1px dotted #5f6162; width:15%;">
                 <%--   <span id="Aadharcard" runat="server" ></span>--%>
                </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:105px; margin:3px 0 10px; margin-left: 22px;">Birth certificate :</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:4px 1% 10px 0px; border-bottom:1px dotted #5f6162;  width:15%;">
                   <%-- <span id="Birthcertificate" runat="server" ></span>--%>
                </dl>

                 <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Caste certificate:</p>
                 <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px 5px 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:15%;">
                   <%--  <span id="Castecertificate" runat="server" ></span>--%>
                 </dl>
                <br />
     <div style="clear:both;"></div>
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:180px; margin:3px 0 10px;">Migration certificate:</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px -45px 0px; font-weight:600;  border-bottom:1px dotted #5f6162; width:20.9%;">
                   <%-- <span id="Migrationcertificate" runat="server" ></span>--%>
                </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:135px; margin:3px 0 10px; margin-left: 55px;">Last year marksheet :</p>
                <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:4px 1% 10px 0px; border-bottom:1px dotted #5f6162;  width:30%;">
                   <%-- <span id="Lastyearmarksheet" runat="server" ></span>--%>
                </dl>
                <br />
     <div style="clear:both;"></div>

  </dl>

               <%-- mkg end--%>
			   
 <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
<center><b>Special Instruction</b></center>


  <%--<table id="chequedetails" runat="server" width="100%" border="0"  cellpadding="0" cellspacing="0" style="margin:0px 0px 0 0px; float:left; font-size:14px; color:#4f4848;   font-family:Arial;">
      <tr style="float:left;">
    <td colspan="2" align="left" style="font-size:14px; color:#4f4848; float:left;  font-family:Arial; padding:2px 0 0px 0px; font-weight:600;">Cheque Details: </td>
    </tr>

  <tr style="float:left;">
    <td style="font-size:14px;  font-family:Arial; float:left; color:#4f4848; font-family:Arial;">
        <table style="width: 100%">

            <tr style="float:left;">
                <td style="float:left;"></td>
                <td align="right" style="padding:0px 0px 0; float:left;">Cheque No: </td>
            </tr>
        </table>
      </td>
    <td align="left" style="float:left; padding-top:2px; padding-right:8px; font-weight:600;">  <span id="Span29" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848; float:left;   padding:2px 2px 3px 0;  font-family:Arial;">Cheque Date: </td>
     <td align="left" style="float:left; padding-right:8px; padding-top:2px; font-weight:600;"> <span id="Span30" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848; float:left; padding:2px 2px 3px 0;  font-family:Arial;">Bank: </td>
    <td align="left" style="float:left; font-weight:600; padding-top:2px;"> <span id="Span31" runat="server"></span></td>
	
  </tr>
</table>--%>

  

                <div style="float:left; width:100%; margin-top:1px;">
                    <p style="line-height: 25px;">
                       1. Specify the name of the persson(s) authorised to take the child during/after school-hours.
                    </p>
					<p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspa.   </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="aid" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">b.  </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:25%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="bld" runat="server"></span>
      </dl>
	  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbspAddress  </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:40%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="aadddress" runat="server"></span>
      </dl>

                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:200px; margin:10px 0 10px;">Address  </p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px -115px; border-bottom:1px dotted #5f6162; width:25%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <span id="baddress" runat="server"></span>
      </dl>
                    </div>
<div style="clear:both;"></div>
<dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
</br></br>
 <div style="float:left; width:100%; margin-top:4px;">
                    <p style="line-height: 25px;">
                       2. Assistance to complete any class work and home work by .
                    </p>
					
                <table style="width: 100%">
                    <tr>
					 <td style="text-align: left; border: none;width:86%" colspan="1">
                                         <img id="grdSTDResult_ctl02_Image1" class="schoollogo" src="../images/line2.jpg" style="height:30px;width:100%;border-width:0px;">
                                    </td>
									</tr>
									</table>
					           </div>
<div style="clear:both;"></div>
<dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>	</br>
<center><b>Undertaking</b></center>
<div style="float:left; width:100%; margin-top:4px;">
                    <p style="line-height: 25px;">
                       I-----------------------parent/guardian of Master/Miss--------------------------seeking his/her admission for class -----------------do affirm that the date of birth recorded is correct and that I will not ask for a change of it in  future under any circumstances .
                    </p>
					<dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
					<center><b>Declaration </b></center>
					
                 <p style="line-height: 25px;">
				 I have read and understood the rules and regulations of the institution as given in the prospectus. I agree and promise to abide by them at all times. I also promise to pay the school fee and all other charges by the 15 of month.
				 </p>
				  <p style="line-height: 25px;">
				  I fully understand that the school accepting the registration form of my ward is in no way bound to grant admission. Admissions are purely based on the availability of seat and on qualifying the pre admission test/interview . I also understand that the decision of the principal/committee regarding the admission will be final and binding on me.
				 </p>
					           </div>
<div style="clear:both;"></div>


    <div style="float:left; width:48%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Dated: </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:22px 0 10px; font-weight:600; border-bottom:1px dotted #5f6162; width:55%;"><span id="Span11" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>

     <div style="float:right; width:45%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Parent’s/Guardian’s Sign</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:14px 0 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:30%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
		   <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>

		    <div style="float:left; width:48%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Principal’s remark  </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:22px 0 10px; font-weight:600; border-bottom:1px dotted #5f6162; width:55%;"><span id="Span12x" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>

     <div style="float:right; width:45%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Admitted to Class</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:14px 0 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:50%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
		    <div style="float:left; width:48%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Registration No : </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:22px 0 10px; font-weight:600; border-bottom:1px dotted #5f6162; width:55%;"><span id="Span13" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>
 <div style="float:right; width:45%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;"> Dated:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:4px 0 10px; font-weight:600;  border-bottom:1px dotted #5f6162; width:70%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
		    <div style="float:left; width:48%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Admission Receipt No :</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:22px 0 10px; font-weight:600; border-bottom:1px dotted #5f6162; width:45%;"><span id="Span14" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>
     <div style="float:right; width:45%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Dated</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:6px 0 20px; font-weight:600;  border-bottom:1px dotted #5f6162; width:70%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
   
           </div>
		   <div style="float:left; width:48%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;"></p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:22px 0 10px; font-weight:600; border-bottom:1px dotted #5f6162; width:0%;"><span id="Span16" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>
     <div style="float:right; width:45%; margin-top:4px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;"><b>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbspPrincipal's Signature</b></p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:6px 0 20px; font-weight:600;  border-bottom:1px dotted #5f6162; width:1%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
   
           </div>
		 
		   <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:2px solid #5f6162; width:100%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
   
           </br></br>	</br></br>
		   <div class ="clear"></div>
   <div style="margin-top:10px;">
		   
		  
		  
		  <left><b> 1.</b>Transfer  Certificate (Original)</left></br>
		   <left><b>2. </b> Marksheet (Photocopy)</left></br>
		   <left><b>3. </b> Photocopy of residential proof (Electricity Bill/Telephone Bill/Aadhar Card /Bank Passbook)</left></br>
		   <left><b>4. </b> Two photographs of the student with parents</left></br>
		   <left><b>5. </b> Two (passport size) photographs of the student </left></br>
		   <left><b>6. </b> Birth certificate from the Church Register /Nagar Nigam/Block Office /Government Hospital </left>
		   
</div>
		   </div>
		   </br>
		   
    </form>
	
</body>
</html>
