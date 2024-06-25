<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FeeReport.aspx.cs" Inherits="BranchPanel_Certificates_FeeReport" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style type="text/css">
        .smallhead {
    margin:0 0 0 0;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Main">
            <center>
                <asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" />
            </center>            
            <div class="leftSide" style="text-align: center">                
                <h1 class="smallhead"><asp:Label ID="SchoolName" runat="server"></asp:Label></h1>
                <h3 class="smallhead"><asp:Label ID="lblAddress" runat="server"></asp:Label></h3>
                <h3 class="smallhead">Phone No.-<asp:Label ID="lblPhone" runat="server"></asp:Label></h3>
                <h3 class="smallhead">Website:<asp:Label ID="lblWebsite" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email:<asp:Label ID="lblEmail" runat="server"></asp:Label></h3>

            </div>
            <div class="middle">
                <br />
                <div>
                    <div >
                        <center><h1 style="border: solid 1px black;width: 390px;font-size: 30px;">BONAFIDE CERTIFICATE</h1></center>
   
                    </div>
                    
                    <div class="para">
                        <center>
                    <p>This is to certify that Master/Miss &nbsp<b><asp:Label ID="lblname" runat="server" Width="451px" Font-Size="20px" Style="border-bottom:dotted 2px black;text-align:center"> HINA CHAUDHARY</asp:Label></b>
                        <br />
                        <br />
                  
                    is a bonafide student of this school studying in class&nbsp<b><asp:Label ID="lblclass" runat="server" Width="210px" Font-Size="20px" Style="border-bottom:dotted 2px black;text-align:center">III</asp:Label></b>His / Her date of
                        <br />
                        <br />
                   
                    birth as per the school records is(in figures&nbsp)<b><asp:Label ID="lbldob" runat="server" Width="391px" Font-Size="20px" Style="border-bottom:dotted 2px black;text-align:center">14-Apr-2008</asp:Label></b>
                        <br />
                        <br />
                    
                   (In Words)&nbsp<b><asp:Label ID="lbldobw" runat="server" Width="625px" Font-Size="20px" Style="border-bottom:dotted 2px black;text-align:center">FOURTEEN APRIL TWO THOUSAND EIGHT</asp:Label></b></p>
                            </center>
                </div>
                   
                    </div>

            </div>
            <br /><br />
            <div class="middle">
                <asp:Label ID="Label5" runat="server" Text="DATE:"></asp:Label>
            </div>
        </div>
        <div class="prin">
        <p>PRINCIPAL</p>
            </div>
    </form>
</body>
</html>


