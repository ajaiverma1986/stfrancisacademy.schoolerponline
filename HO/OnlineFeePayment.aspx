<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.master" AutoEventWireup="true" CodeFile="OnlineFeePayment.aspx.cs" Inherits="OnlineFeePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <style type="text/css">
        #sidebar {
            width: 120px;
            top: 380px;
            /*margin: 0 0 0 110px;
            position: fixed;
             left: 84%;*/
            padding: 8px;
        }
    </style>
      <link href="css/Style/animate.css" rel="stylesheet" />
    <link href="css/Style/common.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/lightbox.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link id="csspreset" href="css/presets/preset1.css" rel="stylesheet" />
    <!--change css-preset to csspreset -->
    <link href="css/responsive.css" rel="stylesheet" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css' />
    <link rel="shortcut icon" href="#" />
<script type="text/javascript">
    $(document).ready(function () {
        $("#Submit").click(function () {
            var stdRegNo = $("#txtJob").val();
            if (stdRegNo == '') {
                alert('Please Enter Student Registration No.')
            }
            else {
                var trforappend = '';
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "OnlineFeePayment.aspx/checkLogin",
                    data: "{'RegNo':'" + stdRegNo + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var rtn = data.d
                        if (rtn == 0) {
                            alert('Please Enter Valid Student Registration No.')
                            return false;
                        }
                        else {
                            window.location = 'http://www.schoolerponline.in/EmployeePanel/OnlineFeepay.aspx?SturegNo=' + data.d;
                            return false;
                        }
                    }
                });
            }
        });    
    //var win = window.open("Paynow.aspx?stdRegNo=" + stdRegNo, '_blank');
            //win.focus();
            //return false;    
    });
</script>
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="Server">
    <nav class="navbar navbar-default" style="background-color: white">
        <div class="container-fluid">
            <div class="navbar-header">

                <%--                <div style="float: right;">--%>
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".navbar-collapse" aria-expanded="false"
                    aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <a class="navbar-brand" href="Home.aspx" style="margin-left: -100px; margin-top: -20px">
                <h1>
                    <img class="img-responsive" style="margin-left: 80%;" src="images/Logo.jpg" alt="logo" /></h1>
            </a>

            <div style="float: right; margin-left: 870px;">
                <b style="color: purple; margin-left: 190px;">Toll Free:-1800-123-1154</b>
            </div>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <%--<li style="background-color:green; margin-left:100px; color:white"><b>Toll Free:-1800-123-1154</b></li> --%>
                <li><a href="Index.aspx" style="color: purple">Home</a></li>
                <li><a href="Service.aspx" style="color: purple">Service</a></li>
                <li><a href="About-us.aspx" style="color: purple">About Us</a></li>
                <li><a href="Gallery.aspx" style="color: purple">Gallery</a></li>
                <li><a href="OnlineFeePayment.aspx" style="color: purple">Online Pay</a></li>
                <li class='active'><a href="Pricing.aspx" style="color: purple">Pricing</a></li>
                <li><a href="Payment.aspx" style="color: purple">Payment Acceptance</a></li>
                <li><a href="Blog.aspx" style="color: purple">Blog</a></li>
                <li><a href="Contact.aspx" style="color: purple">Contact</a></li>
                <li><a href="adminLogin.aspx" style="color: purple">Login</a></li>
            </ul>
        </div>
    </nav>

    <div id="rlogin" data-modal="modal-1" class="md-trigger" style="cursor: pointer;">
        <a href="javascript:void(0);">
            <img src="images/SendQuery.png" alt="Recommended School" data-toggle="modal" data-target="#sticky"></a>
    </div>
    <div id="recommended-shcool" data-modal="modal-1" class="md-trigger" style="cursor: pointer;">
    </div>
    <div id="tollfeeno" data-modal="modal-1" class="md-trigger" style="cursor: pointer;">
        <img src="images/TollFree.png" alt="Recommended School">
    </div>
    <section id="pricing">
        <div class="container" style="margin-top: -113px">
            <div class="row">
                <div class="heading text-center col-sm-8 col-sm-offset-2 wow fadeInUp" data-wow-duration="1200ms" data-wow-delay="300ms">
                    <h2>Online Fee Payment Portal</h2>
                    <input id="txtJob" type="text" name="txtJob"  Placeholder="Enter Student Reg. No." value="" />
                    <input type="button" id="Submit" name="Submit" value="Submit" />                  
                </div>
            </div>
        </div>
    </section>
</asp:Content>

