<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CharacterCertificate.aspx.cs" Inherits="BranchPanel_Certificates_CharacterCertificate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style type="text/css">
        .smallhead {
    margin:0 0 0 0;
}
        @media print {
            #tc {
                background-color: black !important;
                color: white !important;
                -webkit-print-color-adjust: exact;
            }
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script>
        function printDiv() {
            //$('#p1').html("10");
            $(':input').each(function () { // copy the vals to values!
                $(this).attr('value', $(this).val())
            })
            var divToPrint = document.getElementById('DivIdToPrint');

            var newWin = window.open('', 'Print-Window');

            newWin.document.open();

            newWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');

            newWin.document.close();

            setTimeout(function () { newWin.close(); }, 10);

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Main" id="DivIdToPrint" style="width:80%;margin-left:10%;margin-right:10%">                       
            <div class="leftSide" style="text-align: center">                
                <h1 class="smallhead"><asp:Label ID="SchoolName" runat="server"></asp:Label></h1>
                <h3 class="smallhead"><asp:Label ID="lblAddress" runat="server"></asp:Label></h3>
                <h3 class="smallhead">( Affiliated to ICSE, New Delhi )<asp:Label ID="Label1" runat="server"></asp:Label></h3>
                <h3 id="lblPhoneH" runat="server" visible="false" class="smallhead">Affiliaton No.-<asp:Label ID="lblPhone" runat="server"></asp:Label></h3>              
                
              
                 <table style="width:90%">
                    <tr>
                        <td style="float:left; margin: 0 0 45px 0;">
                           <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">Affiliaton No :BI040 <asp:Label ID="lblSchoolAffi"  runat="server"></asp:Label></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">S. No. : <input type="text" id="txtSN" style="border:none; border-bottom:dotted 2px black;font-size:15px; text-align:center; width:145px; font-style: italic; font-weight:550"/></h4>
                        </td>
                        <td style="margin: 0 0 50px 0;text-align: center;"><asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" /></td>
                        <td style="float:right; margin: 0 0 45px 0;">
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">School  No : <asp:Label ID="Label2" runat="server" Text="70222"></asp:Label></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">Date : <input type="text" id="txtDate" style="border:none; border-bottom:dotted 2px black;font-size:15px; text-align:center; width:145px; font-style: italic; font-weight:550"/></h4>
                          
                        </td>
                    </tr>
                     <tr>
                        
                        <td style="text-align: center;" colspan="3">
                              <span id="tc" style="border: solid 1px black; padding: 5px;border-radius: 10px 10px 10px 10px;width: 390px;font-size: 20px; font-weight: 600; color:white; background-color:black">CHARACTER CERTIFICATE</span></center>
   
                        </td>
                       
                    </tr>
                </table>
                    

            </div>
            <br />
            <div class="middle">              
                <div>
                    <div >
                      
                     
                    </div>
                    
                    <div class="para">
                      <i>  
                    This is to certify that Master/Miss </i>&nbsp<asp:TextBox ID="txtName" runat="server" style="border:none; text-align:center; border-bottom:dotted 2px black;font-size:15px; width:245px; font-style: italic; font-weight:550"></asp:TextBox>
                        <br />                       
                  
                    <i>Son/Daughter of</i> &nbsp<asp:TextBox ID="txtFName" runat="server" style="border:none; border-bottom:dotted 2px black; text-align:center;font-size:15px; width:245px; font-style: italic; font-weight:550"></asp:TextBox> <b>Born On</b>
                        <br />                     

                   <asp:TextBox ID="txtBdate" runat="server" style="border:none; border-bottom:dotted 2px black;font-size:15px; width:245px; text-align:center; font-style: italic; font-weight:550"></asp:TextBox>
                        <i>(In Words)</i><asp:TextBox ID="txtBdateW" runat="server" style="border:none; border-bottom:dotted 2px black;font-size:15px; text-align:center; width:245px; font-style: italic; font-weight:550"></asp:TextBox> 
                        &nbsp
                        <br />                      
                         <br />  
                        <b>is / has been a scholar of this school.</b> 
                  
                        <br />
                        <br />
                        <b> His/Her work and conduct is/has been</b> 
                 <asp:TextBox ID="txtWork" runat="server" style="border:none; border-bottom:dotted 2px black; text-align:center;font-size:15px; width:245px; font-style: italic; font-weight:550"></asp:TextBox>
                        <br />
                        <br />
                   <b>He/She has passed his/her</b>
                  <asp:TextBox ID="txtExam" runat="server" style="border:none; border-bottom:dotted 2px black;font-size:15px; text-align:center; width:245px; font-style: italic; font-weight:550"></asp:TextBox>
                         <b>examination in year</b> <asp:TextBox ID="txtYear" runat="server" style="border:none; border-bottom:dotted 2px black;font-size:15px; text-align:center; width:45px; font-style: italic; font-weight:550"></asp:TextBox>
                        <br />
                        <br />
                    
                  <b> As far as known to me he/she bears a good moral character.</b>
                  

                        <br />
                        <br />

                     <i>I wish him/her every success in life.</i>
                        <br />
                        <br />
                           
                </div>
                   
                    </div>

            </div>
            <br /><br />
            
             <div class="right" style="text-align:right">
                  <p style="font-weight:bold">PRINCIPAL</p>
            </div>
        </div>
       <div class="middle" style="display:none">
                <asp:Label ID="Label5" Font-Bold="true" runat="server" Text="DATE:"></asp:Label>
            </div>
         <div style="text-align:center">
            <input type="button" onclick="printDiv();" value="Print" style="background-color:blueviolet;color:white" />
        </div>
    </form>
</body>
</html>
