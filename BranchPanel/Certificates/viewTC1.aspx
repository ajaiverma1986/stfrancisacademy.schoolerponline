<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewTC1.aspx.cs" Inherits="BranchPanel_Certificates_viewTC1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />

    <style type="text/css">
        @media print {
            .head {
                display:inline-block;
            }
            #tc {
                background-color: black !important;
                color: white !important;
                -webkit-print-color-adjust: exact;
            }
            #AdmNo {
                display: inline-block;width: 81%;
            }
             #AdmNo1 {
                display: inline-block;text-align:left;
            }
        }

        .smallhead {
            margin: 0 0 0 0;
        }
        #H4 {
    max-width:200px;
    word-wrap:break-word;
        }
    </style>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid" style="font-family: inherit;">
            <div class="row">
                <%--<div class="col-xs-2 col-lg-2">
                    <asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" />
                </div>--%>
                <div class="col-xs-12 col-lg-10">
                    <div class="leftSide" style="text-align: center; font-family: 'Times New Roman';">
                        <h1 class="smallhead">
                            <span id="SchoolName" runat="server" style="font-weight: 600">BRILLIANT PUBLIC SCHOOL</span></h1>
                        <h3 class="smallhead">
                            <span id="lblAddress" runat="server">Harduaganj Thermal Power Station Kasimpur, Aligarh, U.P. -202002</span></h3>
                        <h5 class="smallhead" runat="server" visible="false">Phone No.-<span id="lblPhone" runat="server">05171-2741145</span></h5>
                        <h5 class="smallhead" runat="server" visible="false">Website:<span id="lblWebsite" runat="server">www.bpsaligarh.com</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email:<span id="lblEmail" runat="server">bpscskasimpur@yahoo.com</span></h5>
                    </div>
                </div>
                 <center><table style="width:90%">
                    <tr>
                        <td style="float:left; margin: 0 0 45px 0;">
                            <h4 class="smallhead" style="text-align:justify; width:100%">Book No : <asp:Label ID="BookNo" runat="server"></asp:Label></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;">SI. No. : <asp:Label ID="SNo" runat="server"></asp:Label></h4>
                        </td>
                        <td style="text-align:right;margin: 0 0 0 50px;"><asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" /></td>
                        <td style="float:right; margin: 0 0 45px 0;">
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;"><span style="float:right">Affiliation No : <asp:Label ID="lblSchoolAffi" runat="server"></asp:Label></span></h4>
                            <h4 class="smallhead" style="text-align:justify; width:100%;  margin: 30px 0 0 0;"><span style="float:right">School Code No : <asp:Label ID="Label2" runat="server" Text="70222"></asp:Label></span></h4>
                        </td>
                    </tr>
                </table>
                     </center>
            </div>
            <center><span id="tc" style="border: solid 1px black; padding: 5px;border-radius: 10px 10px 10px 10px;width: 390px;font-size: 20px; font-weight: 600; color:white; background-color:black">TRANSFER CERTIFICATE</span></center>
            <div class="row" style="font-size:13px">
               <%-- <div class="col-xs-4 text-left">
                    <h5><b>Book No</b> :&nbsp;&nbsp;&nbsp;&nbsp;<span id="BookNo" runat="server" style="float:right"></span></h5>
                </div>--%>

                <div class="col-xs-6 text-left">
                    <h5 class="head" style="display:inline-block"><b>Roll No</b>:</h5>
                    <h5 class="head" style="width: 80%; border-bottom: solid 1px black; display:inline-block"><span id="RollNo" runat="server" >0</span></h5>
                </div>
                 <div class="col-xs-6 text-left">
                    <h5 class="head" style="display:inline-block"><b>Admission No :</b></h5>
                    <h5 class="head" style="width: 68%; border-bottom: solid 1px black; display:inline-block"><span id="AdmNo" runat="server" >0</span></h5>
                </div>

                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block">1. &nbsp;&nbsp;&nbsp;&nbsp;Name of Student <span style="float:right"> &nbsp;&nbsp;: </span></h5>
               &nbsp;&nbsp;
                    <h5 id="lblStdName" runat="server" Style="display:inline-block; border-bottom: solid 1px black; width: 80%;">N/A</h5>
                </div>

               <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block"">2. &nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;Mother's Name <span style="float:right">  &nbsp;&nbsp;: </span></h5>
           
                    <h5 id="lblMname" runat="server" Style="border-bottom: solid 1px black; width: 78.5%; display:inline-block">N/A</h5>
                </div>

                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;Father's Name <span style="float:right">  &nbsp;&nbsp;: </span></h5>
           
                    <h5 id="lblFname" runat="server" Style="border-bottom: solid 1px black; width: 79%; display:inline-block">N/A</h5>
                </div>

                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block">3. &nbsp;&nbsp;&nbsp;&nbsp;Address <span style="float:right"> &nbsp;&nbsp;: </span></h5>
               &nbsp;&nbsp;
                    <h5 id="lblAdd" runat="server" style="display:inline-block; border-bottom: solid 1px black; width: 86.5%;">N/A</h5>
                </div>

                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">5. &nbsp;&nbsp;&nbsp;&nbsp;Nationality <span style="float:right"> : </span></h5>
                     <h5 id="lblNation" runat="server" style="border-bottom: solid 1px black; width: 73%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">5. Whether S.C. or S.T. <span style="float:right"> : </span></h5>
                     <%--<h5 id="lblCate" runat="server" style="border-bottom: solid 1px black; width: 60.5%; display:inline-block;">N/A</h5>--%>
                    <input type="text" id="lblCate" runat="server" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 60.5%;" />
                </div>

             <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">6. &nbsp;&nbsp;&nbsp;&nbsp;Date of First admission School <span style="float:right"> : </span></h5>
                     <h5 id="lblDoa" runat="server" style="border-bottom: solid 1px black; width: 30%; display:inline-block;">N/A</h5>
               
                    <h5 style="font-size:12px; display:inline-block;">in class <span style="float:right"> : </span></h5>
                    <input type="text" name="fname" style="border:none; border-bottom: solid 1px black; width: 34.5%; display:inline-block;" />
                </div>


                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px">7. &nbsp;&nbsp;&nbsp;&nbsp;Date of Birth (in Christain Era) as recorded in the Admission Register <span style="float:right"> : </span></h5>
                </div>

                 <div class="col-xs-3 col-sm-3 col-lg-3">
                    <h5 style="font-size:12px; display:inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;in figures <span style="float:right"> : </span></h5>
                     <h5 id="lblDob" runat="server" style="border-bottom: solid 1px black; width: 55%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-9 col-sm-9 col-lg-9">
                    <h5 style="font-size:12px; display:inline-block;">(in words) <span style="float:right"> : </span></h5>
                     <h5 id="lblWDob" runat="server" style="border-bottom: solid 1px black; width: 88%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block">8. &nbsp;&nbsp;&nbsp;&nbsp;Class in which the student studied last <span style="float:right"> &nbsp;&nbsp;: </span></h5>
               &nbsp;&nbsp;
                    <h5 id="lblPrClass" runat="server" style="display:inline-block; border-bottom: solid 1px black; width: 64%;">N/A</h5>
                </div>
                 <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block">9. &nbsp;&nbsp;&nbsp;&nbsp;School/Board/Annual Examination last taken with Result <span style="float:right"> &nbsp;&nbsp;: </span></h5>
               &nbsp;&nbsp;
                    <h5 id="lblBorad" runat="server" style="display:inline-block; border-bottom: solid 1px black; width: 50.5%;">N/A</h5>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block">10. &nbsp;&nbsp;&nbsp;&nbsp;Whether failed, once or twice, in the same <span style="float:right"> &nbsp;&nbsp;: </span></h5>              
                    <h5 id="lblFail" runat="server" style="display:inline-block; border-bottom: solid 1px black; width: 61.5%;">N/A</h5>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size: 12px; display: inline-block">11. &nbsp;&nbsp;&nbsp;&nbsp;Subjects Studied <span style="float: right">: </span></h5>
                    <%--<h5 id="lblSub" runat="server" style="border-bottom: solid 1px black; display:inline-block; width: 81%;">N/A</h5>--%>
                    &nbsp;&nbsp;1.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    2.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    3.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />

                    <h5 style="visibility: hidden; font-size: 12px; display: inline-block">11. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Subjects Studied <span style="float: right">: </span></h5>
                    4.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    5.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    &nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%; visibility:hidden" />

                    <h5 style="text-align: right; font-size: 12px; display: inline-block">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;
                        Effective <span style="float: right">: </span></h5>
                    &nbsp;1.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    2.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                    3.&nbsp;<input type="text" name="fname" style="border:none; border-bottom: solid 1px black; display: inline-block; width: 24.5%;" />
                </div>
                 <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display: inline-block;">12. &nbsp;&nbsp;&nbsp;&nbsp;Whether qualified for promotion to the higher class if so, to which class <span style="float:right"> : </span></h5>
           
                    <h5 id="lblProClass" runat="server" style="border-bottom: solid 1px black; width: 41%; display: inline-block;">N/A</h5>
                </div>
                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">&nbsp;&nbsp;&nbsp;&nbsp;if so, to which class (in figures) <span style="float:right"> : </span></h5>
                     <input type="text" name="fname" style="border:none; border-bottom: solid 1px black; width: 45%; display:inline-block;" />
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">(in words) <span style="float:right"> : </span></h5>
                     <input type="text" name="fname" style="border:none; border-bottom: solid 1px black; width: 81%; display:inline-block;" />
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">13. &nbsp;&nbsp;&nbsp;&nbsp;Month upto which the pupil has paid school dues <span style="float:right"> : </span></h5>            
                    <h5 id="lblDueMonth" runat="server" style="border-bottom: solid 1px black; width: 57%; display:inline-block;">N/A</h5>
                </div>

                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">14. &nbsp;&nbsp;&nbsp;&nbsp;Any fee concession availed of ; If so the nature of such concession <span style="float:right"> : </span></h5>
                    <h5 id="lblCon" runat="server" style="border-bottom: solid 1px black; width: 44%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">15. &nbsp;&nbsp;&nbsp;&nbsp;Total No. of School Working days <span style="float:right"> : </span></h5>
                    <h5 id="lblTdays" runat="server" style="border-bottom: solid 1px black; width: 36%; display: inline-block;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px; display:inline-block;">16. &nbsp;&nbsp;&nbsp;&nbsp;Total days Present <span style="float:right"> : </span></h5>
                      <h5 id="lblPdays" runat="server" style="border-bottom: solid 1px black; width: 57%; display:inline-block;">N/A</h5>
                </div>

                 <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">17. &nbsp;&nbsp;&nbsp;&nbsp;Whether NCC Cadet/Boy Scout/Girl Guide <span style="float:right"> : </span></h5>
                    <h5 id="lblNCC" runat="server" style="border-bottom: solid 1px black; width: 62%; display:inline-block;">N/A</h5>
                </div>

                 <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; width: 100%;">18. &nbsp;&nbsp;&nbsp;&nbsp;Games played or extra curricular activities in which the pupil usually took part (mention achievement level therein)<span style="float:right"> : </span></h5>               
               
                    <h5 id="lblGames" runat="server" style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
                 <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">19. &nbsp;&nbsp;&nbsp;&nbsp;Reason for leaving the school <span style="float:right"> : </span></h5>           
                    <h5 id="lblLeave" runat="server" style="border-bottom: solid 1px black; width: 72%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">20. &nbsp;&nbsp;&nbsp;&nbsp;General Conduct <span style="float:right;"> : </span></h5>                
                    <h5 id="lblCond" runat="server" style="border-bottom: solid 1px black; width: 81%; display:inline-block;">N/A</h5>
                </div>
                
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">21. &nbsp;&nbsp;&nbsp;&nbsp;Date of application for certificate <span style="float:right"> : </span></h5>
                    <h5 id="lblDoc" runat="server" style="border-bottom: solid 1px black; width: 70%; display:inline-block;">N/A</h5>
                </div>

                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">22. &nbsp;&nbsp;&nbsp;&nbsp;Date of Issue of certificate <span style="float:right"> : </span></h5>
                    <h5 id="lblDoi" runat="server" style="border-bottom: solid 1px black; width: 74.5%; display:inline-block;">N/A</h5>
                </div>
                <div class="col-xs-12 col-sm-12 col-lg-12">
                    <h5 style="font-size:12px; display:inline-block;">23. &nbsp;&nbsp;&nbsp;&nbsp;Any other remarks <span style="float:right"> : </span></h5>
                    <h5 id="lblRemark" runat="server" style="border-bottom: solid 1px black; width: 80.5%; display:inline-block;">N/A</h5>
                </div>

                
                 <div class="col-xs-4 text-left">
                    
                <br />
                <br />
                <br />
                     <h5></h5>
                     ><b>Signature of <br /> Class Teacher</b> :&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span1" runat="server" style="float:right"></span></h5>
                </div>
                <div class="col-xs-4 text-center">
                        
                <br />
                <br />
                <br />
                    <h5><b>Checked by<br />(<i>State full Name and designation</i>)</b>:&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span2" runat="server" style="float:right"></span></h5>
                </div>
                <div class="col-xs-4 text-right">
                        
                <br />
                <br />
                <br />
                    <h5><b>Principal <br />SEAL</b> :&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span3" runat="server" style="float:right"></span></h5>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
