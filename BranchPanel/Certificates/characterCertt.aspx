<%@ Page Language="C#" AutoEventWireup="true" CodeFile="characterCertt.aspx.cs" Inherits="BranchPanel_Certificates_characterCertt" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="Main">                       
            <div class="leftSide" style="text-align: center">                
                <h1 class="smallhead"><asp:Label ID="SchoolName" runat="server"></asp:Label></h1>
                <h3 class="smallhead"><asp:Label ID="lblAddress" runat="server"></asp:Label></h3>
                <h3 class="smallhead">( Affiliated to C.B.S.E., New Delhi )<asp:Label ID="Label1" runat="server"></asp:Label></h3>
                <h3 ID="lblPhoneH" runat="server" visible="false" class="smallhead">Affiliaton No.-<asp:Label ID="lblPhone" runat="server"></asp:Label></h3>                
               <%-- <center><table style="width:80%">
                    <tr>
                        <td style="float:left"><h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">Affiliaton No : <asp:Label ID="lblSchoolAffi" runat="server"></asp:Label></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">S. No. : <asp:Label ID="lblSrNo" runat="server"></asp:Label></h4>
                        </td>
                        <td><asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" /></td>
                        <td style="float:right; margin: 0 0 45px 0;"><h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;"><span style="float:right">School Code No : <asp:Label ID="lblEmail" runat="server" Text="50085"></asp:Label></span></h4></td>
                    </tr>
                </table>
            </center>--%>

                 <center><table style="width:90%">
                    <tr>
                        <td style="float:left; margin: 0 0 45px 0;">
                           <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">Affiliaton No : <asp:Label ID="lblSchoolAffi" runat="server"></asp:Label></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;">S. No. : <asp:Label ID="lblSrNo" runat="server"></asp:Label></h4>
                        </td>
                        <td style="text-align:right;margin: 0 0 0 50px;"><asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" /></td>
                        <td style="float:right; margin: 0 0 45px 0;">
                           <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0; margin-top: -70px;"><span style="float:right">School Code No : <asp:Label ID="Label2" runat="server" Text="50085"></asp:Label></span></h4>
                        </td>
                    </tr>
                </table>
                     </center>

            </div>
            <div class="middle">              
                <div>
                    <div >
                       <%--<center ><h1 style="border: solid 1px black;width: 390px;font-size: 28px;">CHARACTER CERTIFICATE</h1></center>--%>
                        <center><span id="tc" style="border: solid 1px black; padding: 5px;border-radius: 10px 10px 10px 10px;width: 390px;font-size: 20px; font-weight: 600; color:white; background-color:black">CHARACTER CERTIFICATE</span></center>
   
                    </div>
                    
                    <div class="para">
                      <i>  <center style="text-align:justify">
                    <p>This is to certify that Master/Miss &nbsp<b><asp:Label ID="lblname" runat="server" Width="487px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center"> HINA CHAUDHARY</asp:Label></b>
                        <br />
                        <br />
                  
                    Son/Daughter of &nbsp<b><asp:Label ID="lblparent" runat="server" Width="511px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center">III</asp:Label></b> passed his/her 
                        <br />
                        <br />

                   student of  class &nbsp<b><asp:Label ID="lblclass" runat="server" Width="300px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center">III</asp:Label></b> <br /><br />

                  session &nbsp<b><asp:Label ID="lblFyid" runat="server" Width="322px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center">III</asp:Label></b> His/Her date of Birth according to the admission
                        <br />
                        <br />
                   
                   register is ( in figures&nbsp)<b><asp:Label ID="lbldob" runat="server" Width="569px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center">14-Apr-2008</asp:Label></b>
                        <br />
                        <br />
                    
                   (In Words)&nbsp<b><asp:Label ID="lbldobw" runat="server" Width="645px" Font-Size="15px" Style="border-bottom:dotted 2px black;text-align:center">FOURTEEN APRIL TWO THOUSAND EIGHT</asp:Label></b></p>

                   To the best of my knowledge he/she bears a good moral character and amenable to discipline .
                        <br />
                        <br />

                     I Wish him/her success in future.
                        <br />
                        <br />
                            </center></i>
                </div>
                   
                    </div>

            </div>
            <br /><br />
            <div class="middle">
                <asp:Label ID="Label5" runat="server" Text="DATE:"></asp:Label>
            </div>
        </div>
        <div class="prin">
        <p style:Font-Size="px">PRINCIPAL</p>
            </div>
    </form>
</body>
</html>