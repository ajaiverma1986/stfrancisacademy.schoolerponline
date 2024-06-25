<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewTC.aspx.cs" Inherits="BranchPanel_Certificates_ViewTC" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style type="text/css">
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
        <div class="container-fluid" style="font-family: 'Times New Roman';">
            <div class="row">
                <div class="col-xs-2 col-lg-2">
                    <asp:Image ID="logo" runat="server" CssClass="schoollogo" Width="100px" Height="100px" ImageUrl="~/Images/schoollogo.png" />
                </div>
                <div class="col-xs-8 col-lg-10">
                    <div class="leftSide" style="text-align: center; font-family: 'Times New Roman';">
                        <h2 class="smallhead">
                            <span id="SchoolName" runat="server" style="font-weight: 400">BRILLIANT PUBLIC SCHOOL</span></h2>
                        <h5 class="smallhead">
                            <span id="lblAddress" runat="server">Harduaganj Thermal Power Station Kasimpur, Aligarh, U.P. -202002</span></h5>
                        <h5 class="smallhead">Phone No.-<span id="lblPhone" runat="server">05171-2741145</span></h5>
                        <h5 class="smallhead">Website:<span id="lblWebsite" runat="server">www.bpsaligarh.com</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Email:<span id="lblEmail" runat="server">bpscskasimpur@yahoo.com</span></h5>
                    <center><b>(Affilated To ICSE Board School Code:B1040)</b></center>
					 <center><b>A miniurity Institute run by HARTMAN EDUCATIONAL SOCIETY BAREILLY </b></center>
					</div>
                </div>
            </div>
            <center><h4 style="width: 390px;font-size: 25px;"><b><u>TRANSFER CERTIFICATE</u></b></h4></center>
			
            <div class="row" style="font-size:13px">
                <!--<div class="col-xs-4" style="width: 20% !important;">
                    <h5><b>Book No</b> :&nbsp;&nbsp;&nbsp;<span id="BookNo" runat="server"></span></h5>
                </div>--!>
                 <div class="col-xs-4" style="width: 60% !important;">
                    <h5><b>Admn. No</b>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="OldRegNo" runat="server" style=""></span></h5>
                </div>
                <div class="col-xs-4" style="width: 30% !important;">
                    <h5><b>SR.No</b>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="SNo" runat="server" style=""></span></h5>
                </div>
               <!-- <div class="col-xs-4" style="width: 30% !important;">
                    <h5><b>Admn No</b> :&nbsp;&nbsp;&nbsp;&nbsp;<span id="AdmNo" runat="server"></span></h5>
                </div>--!>



                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">1. &nbsp;&nbsp;&nbsp;&nbsp;Student Name <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblStdName" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">2. &nbsp;&nbsp;&nbsp;&nbsp;Mother's Name <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblMname" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">3. &nbsp;&nbsp;&nbsp;&nbsp;Father's/Guardian's Name <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblFname" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">4. &nbsp;&nbsp;&nbsp;&nbsp;Date of Birth according to Scholar Register <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblDob" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

               <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px"> &nbsp;&nbsp;&nbsp;&nbsp;(in words) <span style="float:right"> : </span></h5>
                </div>
               <div class="col-xs-6 col-sm-6 col-lg-6">
                     <h5 id="lblWDob" runat="server" Style="border-bottom: solid 1px black; max-width:100%; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">5. &nbsp;&nbsp;&nbsp;&nbsp;Nationality <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblNation" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">6. &nbsp;&nbsp;&nbsp;&nbsp;Whether the candidates belongs to S.C/S.T/O.B.C. <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblCate" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">7. &nbsp;&nbsp;&nbsp;&nbsp;Date of admission in the school  <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblDoa" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
               <!-- <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">8. &nbsp;&nbsp;&nbsp;&nbsp;School/Board Annual Examination last taken with result <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblPrClass" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>--!>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">8. &nbsp;&nbsp;&nbsp;&nbsp;Class in which the pupil last studied(In word) <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblBorad" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">9. &nbsp;&nbsp;&nbsp;&nbsp;Whether the student is failed : <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblFail" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                <!-- <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">11. &nbsp;&nbsp;&nbsp;&nbsp;Subjects Studied <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblSub" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>--!>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">10. &nbsp;&nbsp;&nbsp;&nbsp;Whether qualified for promotion to the Next higher class-<span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblProClass" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
               
                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">11. &nbsp;&nbsp;&nbsp;&nbsp;Month upto which the school dues paid <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblDueMonth" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">12. &nbsp;&nbsp;&nbsp;&nbsp;Any fee concession availed of ; If so the nature of such concession <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblCon" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
                 <div class="col-xs-6 col-sm-6 col-lg-6">.</div>
                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">13. &nbsp;&nbsp;&nbsp;&nbsp;No.of meeting up to date <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblTdays" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">14. &nbsp;&nbsp;&nbsp;&nbsp;No.of school days the pupil attended <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblPdays" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                <!-- <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">17. &nbsp;&nbsp;&nbsp;&nbsp;Whether NCC Cadet/Boy Scout/Girl Guide <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblNCC" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>--!>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">15. &nbsp;&nbsp;&nbsp;&nbsp;Co circullar activities in which the pupil took part <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblGames" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">16. &nbsp;&nbsp;&nbsp;&nbsp;General Conduct <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblCond" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">17. &nbsp;&nbsp;&nbsp;&nbsp;Date on which pupil name was struck off the Vidyalaya <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblDoc" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">18. &nbsp;&nbsp;&nbsp;&nbsp;Date of Issue of certificate <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblDoi" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">19. &nbsp;&nbsp;&nbsp;&nbsp;Reason for leaving the school <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblLeave" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                 <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 style="font-size:12px">20. &nbsp;&nbsp;&nbsp;&nbsp;Any other remarks <span style="float:right"> : </span></h5>
                </div>
                <div class="col-xs-6 col-sm-6 col-lg-6">
                    <h5 id="lblRemark" runat="server" Style="border-bottom: solid 1px black; width: 100%;">N/A</h5>
                </div>

                
                 <div class="col-xs-4 text-left">
                    

                <br />
                     <h5></h5>
                     <b>Prepared By <br/> (Name & Designation)</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span1" runat="server" style="float:right"></span></h5>
                </div>
                <div class="col-xs-4 text-center">
                        

                <br />
                    <h5><b> </b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span2" runat="server" style="float:right"></span></h5>
                </div> 
                <div class="col-xs-4 text-right">
                        
               

			<br />
				

				
                    <h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Sign of Principal<br/>(Official Seal )</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="Span3" runat="server" style="float:right"></span></h5>
                </div>
            </div>
        </div>
		<!--<br />
 
				<div>
				<h5><b>Note</b> - If ,this T.C. is issued by the officiating/Incharge Principal,in variably countersigned by the Manager -V.M.C.</h5>
                        
				</div>--!>
				
    </form>
</body>
</html>
