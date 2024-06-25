<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TransFeeReceipt.aspx.cs" Inherits="BranchPanel_transportmanagment_TransFeeReceipt" %>
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
              border-right-color: black;
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

         <div style="float: right; width:auto;">           
             <asp:ImageButton ID="ImageButton1" runat="server" OnClick="ImageButton1_Click" Width="30" height="30" ImageUrl="~/images/print.png" style="float: right; cursor: pointer" />
        </div>
        <br />
        
            <div style="width: 680px; min-height: 450px; position:relative; margin: auto auto 60px; margin-bottom: 35px; border: solid 2px;
    padding: 10px 10px 10px 10px;">
                <table style="width: 100%">
                    <tr>
                        <td style="width:15%">
                            <div style="float: left; padding: 5px 5px 0" id="divforlogo" runat="server">
                                <asp:Image ID="btnlogoforrecipt" runat="server" Width="100px" />
                            </div>
                        </td>
                        <td style="width:60%">
                            <dl style="font-size: 20px; height: 8px; text-align: center; font-family: Arial; color: #424546; font-weight: 600;"><span id="SchoolName" runat="server"></span></dl>
                            <h3 id="insaddress" runat="server" style="font-size: 12px; text-align: center; font-family: Arial; color: #424546;">
                                    <asp:Label runat="server" ID="spanaddress"></asp:Label></h3>
                           <!-- <h3 id="insservicetaxno" runat="server" style="font-size: 12px; text-align: center; font-family: Arial; color: #424546;">CBSE Affiliation No :
                                    <asp:Label runat="server" ID="lblSchoolAffi"></asp:Label></h3>--!>
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
                <p style="float:left; margin-top: 20px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> Receipt No : <span id="SpReceiptNo" runat="server" style="font-weight:600;"></span></p>

           <h3 style=" text-align:center; font-size:18px; margin: 0 165px 0 0;  font-family:Arial; color:#656d70;">Transport Fee Receipt</h3>
           

            <p style="float:right; margin:0px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> Date: <span id="recieptdate" runat="server" style="font-weight:600;"></span></p>

           <div style="clear:both;"></div>

  <div style="clear:both;"></div>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">Received with Thanks on behalf of</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px solid #5f6162; width:66%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="recipetrecivername" runat="server"></span></dl>

 <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:95px; margin:10px 0 10px;">Father's Name</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px solid #5f6162; width:45%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="SPparentName" runat="server"></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:115px; margin:10px 0 10px;">Registration No.</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:10px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:20.9%;"><span id="Span2" runat="server" ></span></dl>

      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:45px; margin:11px 0 10px;">&nbsp;Class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:11px 1% 10px 0px; border-bottom:1px solid #5f6162;  width:22%;"><span id="Span3" runat="server" ></span></dl>
      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:45px; margin:11px 0 10px;">&nbsp;Section</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:11px 1% 10px 15px; border-bottom:1px solid #5f6162;  width:22%;"><span id="Span1" runat="server" ></span></dl>
      
                <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:auto; margin:11px 0 10px;">The Sum of <b> Rs.<span id="Span5" runat="server" ></span>/-</b></p>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:56px; margin:11px 0 10px;">In words</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:11px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:91.5%;"><span id="Span6" runat="server"></span></dl>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Payment Mode:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:25%;"><span id="Span7" runat="server">Cash</span></dl>

   <%-- <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:135px; margin:3px 0 10px;">Bank TransactionID :</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:38%;"><span id="Span10" runat="server" ></span></dl>
     <div style="clear:both;"></div>

  <table id="chequedetails" runat="server" width="100%" border="0"  cellpadding="0" cellspacing="0" style="margin:0px 0px 0 0px; float:left; font-size:14px; color:#4f4848;   font-family:Arial;">
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

  <div style="clear:both;"></div>

    <div style="float:left; width:48%; margin-top:24px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Received By: </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:55%;"><span id="Span11" runat="server"></span></dl>

        <dt style"clear:both;"></dt>
         </div>

     <div style="float:right; width:45%; margin-top:24px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:10px; color:#424546;">Authorized Signatory:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:9px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:53%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
</div>

    </form>
</body>
</html>
