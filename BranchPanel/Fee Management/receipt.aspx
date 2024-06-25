<%@ Page Language="C#" AutoEventWireup="true" CodeFile="receipt.aspx.cs" Inherits="BranchPanel_Fee_Management_receipt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="headfirst" runat="server">
 <link id="favicon" rel="shortcut icon" type="image/ico" runat="server" />
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
        <div id="printablediv">

            <div style="width: 680px; min-height: 450px; position:relative; margin: auto auto 60px; padding: 10px 0px; margin-bottom: 35px;  border-bottom: 1px dashed rgb(157, 157, 157);">
                <dl style="font-size:23px; height:1px; text-align:center;  font-family:Arial; color:#424546; font-weight:600;"><span id="SchoolName" runat="server"></span></dl>
           <div style="border-bottom:1px solid #e0dfdf; min-height:55px; padding-bottom:4px;">

                <div style="float: left; padding:5px 5px 0" id="divforlogo" runat="server">
                    <asp:Image ID="btnlogoforrecipt" runat="server" Width="100px" />
                </div>
               
                <div class="receiptwrapper_add" style="float:right; font-size:12px;  font-family:Arial; color:#656d70;">
                        <p id="insservicetaxno" runat="server" style="display: none; padding:0px; margin:2px 0;">Service Tax Regn No. : <asp:Label runat="server" ID="lblservicetax"></asp:Label></p>
                        <p id="instin" runat="server" style="display: none; padding:0px; margin:2px 0;">TIN :  <asp:Label runat="server" ID="lbltin"></asp:Label></p>
                        <p id="inscontact" runat="server" style="display: none;padding:0px; margin:2px 0;">Contact No. :  <asp:Label runat="server" ID="lblcontact"></asp:Label></p>
                         <p id="insaddress" runat="server" style="display: none; line-height:15px; padding:0px; margin:2px 0;">Address : <asp:Label runat="server" id="spanaddress"></asp:Label></p>
                    </div>

                    <div style="clear:both;"></div>
           </div>

                <h3 style=" text-align:center; font-size:18px; margin:10px 0 0;  font-family:Arial; color:#656d70;">Payment Receipt</h3>

           <p style="float:left; margin:0px 0 8px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;">Receipt No: <span id="recieptno" runat="server" style="font-weight:bold;" ></span></p>

            <p style="float:right; margin:0px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> Date: <span id="recieptdate" runat="server" style="font-weight:600;"></span></p>

           <div style="clear:both;"></div>

  <div style="clear:both;"></div>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">Received with Thanks on behalf of</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px solid #5f6162; width:38%;"> <span id="recipetrecivername" runat="server"></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:52px; margin:10px 0 10px;">Admission No.</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:10px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:20.9%;"><span id="Span2" runat="server" ></span></dl>

           <div style="clear:both;"></div>

      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:91px; margin:3px 0 10px;">Class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:3px 1% 10px 0px; border-bottom:1px solid #5f6162;  width:44%;"><span id="Span3" runat="server" ></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:81px; margin:3px 0 10px;">Section</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:29.7%;"><span id="Span4" runat="server" ></span>&nbsp;</dl>

  <div style="clear:both;"></div>

           <p style="font-size:14px; float:left; font-family:Arial; color:#424546;min-width:630px;width:auto; margin:3px 0 10px;">The Sum of <b> Rs.<span id="Span5" runat="server" ></span>/-</b> (Including <b>Rs.<span id="spantaxamount" runat="server">100</span>/- (<span id="spantaxpercentage" runat="server">14%</span>)</b> Service TAX)</p>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:56px; margin:3px 0 10px;">In words</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:91.5%;"><span id="Span6" runat="server"></span></dl>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Payment Mode:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:25%;"><span id="Span7" runat="server"></span></dl>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:135px; margin:3px 0 10px;">Bank TransactionID :</p>
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
</table>

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

                <img src="../../images/sizzer-receipt.png" style="position: absolute; bottom: -19px; z-index: 9999999;" runat="server" id="online1">

               <div style="clear:both;"></div>
</div>

            <div style="width:680px; min-height:360px;  margin:auto; padding:10px 0px;" runat="server" id="online">
<dl style="font-size:23px; height:1px; text-align:center;  font-family:Arial; color:#424546; font-weight:600;"><span id="Span17" runat="server"></span></dl>
           <div style="border-bottom:1px solid #e0dfdf; min-height:58px; padding-bottom:4px;">

                <div style="float: left; padding:5px 5px 0" id="divforlogo1" runat="server">

                         <asp:Image ID="Image1" runat="server" Width="100px" />
                    </div>               
                <div id="Div1" class="receiptwrapper_add" runat="server" style="float:right; font-size:12px;  font-family:Arial; color:#656d70;">
                        <p id="stuservicetaxno"  runat="server" style="display: none;padding:0px; margin:2px 0;">Service Tax Regn No. :<asp:Label runat="server" ID="lblserviceno"></asp:Label> </p>
                        <p id="stutin" runat="server" style="display: none; padding:0px; margin:2px 0;">TIN : <asp:Label runat="server" ID="tinno"></asp:Label> </p>
                        <p id="stucontact" runat="server" style="display: none; padding:0px; margin:2px 0;"> Contact No. : <asp:Label runat="server" ID="contact"></asp:Label></p>
                          <p id="stuinsaddress" runat="server" style="display: none; padding:0px; margin:2px 0; line-height:15px; ">Address : <asp:Label runat="server" ID="lbladdress"></asp:Label></p>
                    </div>

                    <div style="clear:both;"></div>
           </div>

                 <h3 style=" text-align:center; font-size:18px; margin:10px 0 0;  font-family:Arial; color:#656d70;">Payment Receipt</h3>

                  <div style="clear:both;"></div>
           <p style="float:left;  margin:0px 0 8px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;">Receipt No: <span id="Span14" runat="server" style="font-weight:600;" ></span> </p>

            <p style="float:right; margin:0px; font-size:14px; font-style:italic; font-family:Arial; color:#424546;"> Date: <span id="Span15" runat="server" style="font-weight:600;"></span></p>

           <div style="clear:both;"></div>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:220px; margin:10px 0 10px;">Received with thanks on behalf of</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:10px 1% 10px 0px; border-bottom:1px solid #5f6162; width:38%;"><span id="Span16" runat="server">&nbsp;</span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:52px; margin:10px 0 10px;">Admission No.</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:10px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:20.9%;"><span id="Span18" runat="server"></span></dl>

           <div style="clear:both;"></div>

      <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:91px; margin:3px 0 10px;">Class</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; font-weight:600;  margin:3px 1% 10px 0px; border-bottom:1px solid #5f6162;  width:44%;""><span id="Span19" runat="server"></span></dl>

  <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:81px; margin:3px 0 10px;">Section</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600;  border-bottom:1px solid #5f6162; width:29.7%;"><span id="Span20" runat="server"></span>&nbsp;</dl>

  <div style="clear:both;"></div>

           <p style="font-size:14px; float:left; font-family:Arial; color:#424546; min-width:630px;width:auto; margin:3px 0 10px;">The Sum of <b> Rs.<span id="Span21" runat="server"></span>/-</b>(including <b>Rs.<span id="span1" runat="server">100</span>/- (<span id="span9" runat="server">14%</span>)</b> Service TAX)</p>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:56px; margin:3px 0 10px;">In words</p>
  <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:91.5%;"><span id="Span22" runat="server"></span></dl>

    <div style="clear:both;"></div>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:106px; margin:3px 0 10px;">Payment Mode:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:25%;"><span id="Span8" runat="server"></span></dl>

    <p style="font-size:14px; float:left; font-family:Arial; color:#424546; width:135px; margin:3px 0 10px;">Bank TransactionID :</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:3px 0 0px; font-weight:600;  width:38%;"><span id="Span13" runat="server" ></span></dl>
    
     <div style="clear:both;"></div>

  <table id="Tr1" runat="server" width="100%" border="0"  cellpadding="0" cellspacing="0" style="margin:0px 0px 0 0px; float:left; font-size:14px; color:#4f4848;   font-family:Arial;">
      <tr style="float:left;">
    <td colspan="2" align="left" style="font-size:14px; color:#4f4848; float:left; font-family:Arial; padding:2px 0 7px 0px; font-weight:600;">Cheque Details :</td>
    </tr>

  <tr style="float:left;">
    <td style="font-size:14px; float:left; font-family:Arial; color:#4f4848; font-family:Arial;">
        <table style="width: 100%">

            <tr style="float:left;">
                <td style="float:left;"></td>
                <td align="right" style="padding:0px 0px 0; float:left;">Cheque No:</td>
            </tr>
        </table>
      </td>
    <td align="left" style=" float:left; padding-top:2px; padding-right:8px; font-weight:600;">  <span id="Span12" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848;  float:left;  padding:2px 2px 3px 0;  font-family:Arial;">Cheque Date:</td>
     <td align="left" style="float:left; font-weight:600; padding-right:8px; padding-top:2px;"> <span id="Span32" runat="server"></span></td>
  </tr>
  <tr style="float:left;">
    <td align="right" style="font-size:14px; color:#4f4848;  float:left; padding:2px 2px 3px 0; font-family:Arial;">Bank:</td>
    <td align="left" style="float:left; font-weight:600; padding-top:2px;"> <span id="Span33" runat="server"></span></td>
  </tr>
</table>

  <div style="clear:both;"></div>

    <div style="float:left; width:48%; margin-top:24px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:7px; color:#424546;">Received By: </p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:6px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:55%;"><span id="Span27" runat="server" ></span></dl>

        <dt style"clear:both;"></dt>
         </div>

     <div style="float:right; width:45%; margin-top:24px;">
    <p style="float:left; font-size:14px; font-style:italic; font-family:Arial; margin-right:4px; margin-top:7px; color:#424546;">Authorized Signatory:</p>
    <dl style="float:left; font-size:13px;  font-family:Arial; color:#424546; margin:6px 0 10px; font-weight:600; border-bottom:1px solid #5f6162; width:53%;">&nbsp;</dl>
   <dt style"clear:both;"></dt>
           </div>
               <div style="clear:both;"></div>
</div>
</div>
    </form>
</body>
</html>
