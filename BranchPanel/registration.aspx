<%@ Page Title="New Registration" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="registration.aspx.cs" Inherits="BranchPanel_registration" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <script src="../js/jquery.ui.datepicker.js" type="text/javascript"></script>--%>

    <style>
        .content_top {
            float: none !important;
        }

        .for_sigle_row_form1 label {
            float: left;
            /* padding-top: 8px; */
            text-align: right;
            width: 220px;
            margin-right: 20px;
            color: #616161;
            font-size: 14px;
        }
    </style>
    <script type="text/javascript">

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
        function ValidateAlpha() {
            var keyCode = window.event.keyCode;
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32) {
                window.event.returnValue = false;
                alert("Enter only letters");
            }
        }
    </script>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "mm dd yy"
                });
            });

        });
    </script>
    <script type="text/javascript">

        function check() {

            if (document.getElementById('<%=txtFiName.ClientID %>').value.trim() == 0) {
                alert("Please enter student first name.");
                document.getElementById('<%=txtFiName.ClientID %>').focus();
             return false;
         }

         if (document.getElementById('<%=txtLName.ClientID %>').value.trim() == 0) {
                alert("Please enter student last name.");
                document.getElementById('<%=txtLName.ClientID %>').focus();
            return false;
        }

        if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == 0) {
                alert("Please Enter Date of Birth.");
                document.getElementById('<%=txtToDate.ClientID %>').focus();
             return false;
         }
         if (document.getElementById('<%=txtFFname.ClientID %>').value.trim() == 0) {
                alert("Please enter father first name.");
                document.getElementById('<%=txtFFname.ClientID %>').focus();
             return false;
         }

         if (document.getElementById('<%=txtFLname.ClientID %>').value.trim() == 0) {
                alert("Please enter father last name.");
                document.getElementById('<%=txtFLname.ClientID %>').focus();
             return false;
         }

         if (document.getElementById('<%=ddlClass.ClientID %>').value == 0) {
                alert("Please select class.");
                document.getElementById('<%=ddlClass.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtPAddress.ClientID %>').value.trim() == 0) {
                alert("Please enter address.");
                document.getElementById('<%=txtPAddress.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=ddlCountry1.ClientID %>').value == 0) {
                alert("Please select country.");
                document.getElementById('<%=ddlCountry1.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=ddlState1.ClientID %>').value == 0) {
                alert("Please select state.");
                document.getElementById('<%=ddlState1.ClientID %>').focus();
               return false;
           }
           if (document.getElementById('<%=ddlCity1.ClientID %>').value == 0 || document.getElementById('<%=ddlCity1.ClientID %>').valueOf == "--Select City--") {
                alert("Please select city.");
                document.getElementById('<%=ddlCity1.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=txtPZIP.ClientID %>').value.trim() == 0) {
                alert("Please eneter pin code!");
                document.getElementById('<%=txtPZIP.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=txtmob.ClientID %>').value.trim() == 0) {
                alert("Please enter mobile number.");
                document.getElementById('<%=txtmob.ClientID %>').focus();
            return false;
        }
        if (document.getElementById('<%=ddlPayMode.ClientID %>').value == 0) {
                alert("Please select paymentmode.");
                document.getElementById('<%=ddlPayMode.ClientID %>').focus();
                    return false;
                }

                var index = document.getElementById('ctl00_ContentPlaceHolder1_ddlPayMode').selectedIndex;

                if (parseInt(index) == parseInt(2) || (parseInt(index) == parseInt(3))) {

                    if (document.getElementById('<%=txtbnkname.ClientID %>').value.trim() == 0) {
                        alert("Please enter bank name.");
                        document.getElementById('<%=txtbnkname.ClientID %>').focus();
                        return false;
                    }
                    if (document.getElementById('<%=txtchck.ClientID %>').value.trim() == 0) {
                        alert("Please enter cheque number.");
                        document.getElementById('<%=txtchck.ClientID %>').focus();
                        return false;
                    }
                }

            }
    </script>
    <script type="text/javascript">
        $('#txtLName').poshytip({
            className: 'tip-yellowsimple',
            showOn: 'focus',
            alignTo: 'target',
            alignX: 'right',
            alignY: 'center',
            offsetX: 5,
            showTimeout: 100
        });
    </script>

    <%-- <script type="text/javascript">
         function CalculateAge(DOB) {

             if (DOB.value != '') {

                 now = new Date()

                 dob = DOB.value.split('/');

                 if (dob.length === 3) {

                     born = new Date(dob[2], dob[1] * 1 - 1, dob[0]);

                     age = Math.floor((now.getTime() - born.getTime()) / (365.25 * 24 * 60 * 60 * 1000));
                     alert(age);

                     if (now.getMonth() < dob[0]) {
                         var monthDiff = (dob[0])-(now.getMonth());
                         alert(monthDiff);
                     }
                     else {
                         var monthDiff = (now.getMonth())-(dob[0]);
                         alert(monthDiff);
                     }

                     if (isNaN(age)) {

                         document.getElementById('lblAge').innerHTML = '';

                         alert('Input date is incorrect!');

                     }

                     else {

                         document.getElementById('lblAge').innerHTML = age +" Years " +  monthDiff+ "Month " ;

                     }

                 }

             }

         }
        </script>--%>

    <script type="text/javascript">
        function CalculateAge(DOB) {

            var inputdob = DOB.value;

            if (inputdob == "") {

                alert("Enter date of Birth");

                document.getElementById('lblAge').innerHTML = '';

                return false;

            }

            var DOBDate = new Date(inputdob);

            var currentDate = new Date();

            var months = currentDate.getMonth() - DOBDate.getMonth();

            var years = currentDate.getFullYear() - DOBDate.getFullYear();

            var days = currentDate.getDate() - DOBDate.getDate();

            if (years <= 0) {

                alert("Date of Birth is atleast 3 years old ");

                $('#ctl00_ContentPlaceHolder1_txtToDate').val("");

                return false;

            }

            else if (months < 0) {

                years = parseInt(years, 10) - 1;

                months = 12 + parseInt(months, 10);

                if (days < 0) {

                    months = parseInt(months, 10) - 1;

                    days = 30 + parseInt(days, 10);

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

                else

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (days) + ' Days';

            }

            else {

                if (months == 0) {

                    years = parseInt(years, 10) - 1;

                    if (days < 0) {

                        dayDiff = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (-days) + ' Days';

                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

                else {

                    if (days < 0) {

                        months = parseInt(months, 10) - 1;

                        days = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';

                }

            }

        }
    </script>

    <script type="text/javascript" id="hjfkhgjk">

        function alertTest() {
            $(document).ready(function () {

                debugger;
                $("#ctl00_ContentPlaceHolder1_ddlCountry1").change(function () {
                    //alert("ashuuuu");
                    var cid = document.getElementById("ctl00_ContentPlaceHolder1_ddlCountry1").value;
                    if (cid == "0") {
                        $('#ctl00_ContentPlaceHolder1_ddlState1').children('option:not(:first)').remove();
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();

                        return;
                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_ddlState1').children().remove();
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();

                    }

                    $.ajax(
                       {
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "common.aspx/bindstate",
                           data: "{'cid':'" + cid + "'}",
                           dataType: "json",
                           success: function (data) {
                               $("#ctl00_ContentPlaceHolder1_ddlState1").html("");
                               $.each(data.d, function (key, value) {
                                   $("#ctl00_ContentPlaceHolder1_ddlState1").append($("<option></option>").val(value.SID).html(value.statename));
                               });
                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });
                });

                $("#ctl00_ContentPlaceHolder1_ddlState1").change(function () {

                    var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddlState1").value;

                    if (sid == "0") {
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children('option:not(:first)').remove();
                        return;
                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_ddlCity1').children().remove();
                    }

                    $.ajax(
                       {
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "common.aspx/bindcity",
                           data: "{'sid':'" + sid + "'}",
                           dataType: "json",
                           success: function (data) {
                               $("#ctl00_ContentPlaceHolder1_ddlCity1").html("");
                               $.each(data.d, function (key, value1) {
                                   $("#ctl00_ContentPlaceHolder1_ddlCity1").append($("<option></option>").val(value1.CTID).html(value1.cityName));
                               });
                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });

                });

                $("#ctl00_ContentPlaceHolder1_ddlClass").change(function () {
                    //alert("ashuuuu");
                    var clid = document.getElementById("ctl00_ContentPlaceHolder1_ddlClass").value;
                    if (clid == 0) {
                        $('#ctl00_ContentPlaceHolder1_txtRegFee').val(" 0.00");
                        $('#ctl00_ContentPlaceHolder1_txtClassSec').val("");
                        return;
                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_txtClassSec').val($("#ctl00_ContentPlaceHolder1_ddlClass :selected").text());

                    }

                    $.ajax(
                       {
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           url: "registration.aspx/bindclass",
                           data: "{'Classid':'" + clid + "'}",
                           dataType: "json",
                           success: function (data) {
                               //alert(data.d);
                               //$("#ctl00_ContentPlaceHolder1_ddlState1").html("");
                               //$.each(data.d, function (key, value) {
                               $('#ctl00_ContentPlaceHolder1_txtRegFee').val(parseFloat(data.d).toFixed(2));// json result
                               //$("#ctl00_ContentPlaceHolder1_txtRegFee").text(details[0].cityName);
                               //});
                           },
                           error: function (result) {
                               alert("Error");
                           }
                       });

                });

                $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {

                    var clid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;

                    if ((clid == 0)) {

                        $('#ctl00_ContentPlaceHolder1_divcash').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_divcheq').css("display", "none");
                        return;
                    }

                    else if ((clid == 1)) {
                        $('#ctl00_ContentPlaceHolder1_divcash').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_divcheq').css("display", "none");
                        return;

                    }
                    else if (clid > 1) {
                        $('#ctl00_ContentPlaceHolder1_divcash').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_divcheq').css("display", "block");

                    }

                });

            });

        }
        //alertTest();
    </script>

    <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Student Administration</a></li>
            <li><a>Registration</a></li>
            <li style="background: none;"><a class="active" href="#">New Registration</a></li>
        </ul>
        <%-- <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>--%>
        <div class="arrowt">
            <a href="RegList.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <asp:UpdatePanel ID="upd11" runat="server">
        <ContentTemplate>

            <div class="content_pane_cont input_content" id="contentPane">

                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    New Student
                </div>

                <br />

                <div class="for_sigle_row_form">

                    <label>
                        Name of Applicant<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFiName" runat="server" CssClass="fname" AutoPostBack="false" onkeypress="ValidateAlpha()" OnTextChanged="txtFiName_TextChanged1"></asp:TextBox>&nbsp

                                                <asp:TextBox ID="TextBox11" runat="server" CssClass="mname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtLName" runat="server" CssClass="lname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                            <asp:RegularExpressionValidator ID="regName" runat="server" ControlToValidate="txtFiName" CssClass="rqd" ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Enter a valid First name" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox11" CssClass="rqd" ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Enter a valid Mid Name" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtLName" CssClass="rqd" ValidationExpression="^[a-zA-Z'.\s]{1,50}" Text="Enter a valid Last Name" />
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Date of Birth<span style="color: Red">*</span></label>

                    <asp:TextBox ID="txtToDate" runat="server" onchange="CalculateAge(this)"></asp:TextBox>
                    <%-- <asp:Label runat="server" ID="DateTimeLabel" ForeColor="Black" Font-Size="12px" Text=""></asp:Label>--%>
                    <span id="lblAge"></span>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Father's name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFFname" runat="server" CssClass="fname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtFMname" runat="server" CssClass="mname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                                <asp:TextBox ID="txtFLname" runat="server" CssClass="lname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mother's name</label>
                    <asp:TextBox ID="txtMFname" runat="server" CssClass="fname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMMname" runat="server" CssClass="mname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMLname" runat="server" CssClass="lname" onkeypress="ValidateAlpha()"></asp:TextBox>&nbsp
                </div>

                <div class="for_sigle_row_form1" style="margin-left: 13%;">
                    <label>
                        Gender<span style="color: Red">*</span></label>
                    <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                        <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                        <asp:ListItem Value="0">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="for_sigle_row_form">

                    <label>
                        Applying for Class<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlClass">
                    </asp:DropDownList>
                    &nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Address Line<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Country<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlCountry1">
                    </asp:DropDownList>
                    &nbsp;
                                                                                 <asp:Label runat="server" ID="lblCountryMSg" ForeColor="Chocolate" Text=""></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State/Province<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlState1">
                    </asp:DropDownList>
                    &nbsp;
                                                                                 <asp:Label runat="server" ID="lblStateMsg" ForeColor="Chocolate" Text=""></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlCity1">
                    </asp:DropDownList>
                    &nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        PIN/ZIP code<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8"
                        onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="txtPZIP"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Contact No.<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtmob" runat="server" MaxLength="13" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtmob"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Father Qualification</label>
                    <asp:DropDownList runat="server" ID="ddlFQualifiaction1">
                    </asp:DropDownList>
                    &nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mother Qualification</label>
                    <asp:DropDownList runat="server" ID="ddlMQualifiaction1">
                    </asp:DropDownList>
                    &nbsp;
                </div>

                <div class="for_sigle_row_form">

                    <label>
                        Parent Annual Income:</label>
                    <asp:TextBox ID="txtincome" runat="server" placeholder="0.00" onkeypress="return noAlphabets(event)"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">

                    <label>
                        Registration Fee:<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtRegFee" runat="server"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Payment Mode<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlPayMode" runat="server" Height="28px" Width="313px">
                        <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                        <asp:ListItem Value="3">Cheque</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                </div>

                <div class="for_sigle_row_form" runat="server" id="divcash" style="display: none;">
                    <label runat="server" id="lblbnk">
                        Bank Name<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtbnkname" runat="server" Text=""></asp:TextBox>
                </div>
                <div class="for_sigle_row_form" runat="server" id="divcheq" style="display: none;">
                    <label runat="server" id="lblchk">
                        Cheque/DD Number<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtchck" runat="server" Text=""></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label><strong style="color: red">For Office Use Only</strong></label>
                    <br />
                    <label>
                    </label>
                    <br />
                </div>

                <%--  <div class="for_sigle_row_form">
                                                <label>
                                                    Enter receipt number<span style="color: Red">*</span></label>
                                                <asp:TextBox ID="txtreceipt" runat="server" AutoPostBack="true" OnTextChanged="txtreceipt_TextChanged"></asp:TextBox>&nbsp;
                                                <asp:Label ID="lblmsg1" runat="server" CssClass="rqd"></asp:Label>
                                            </div>--%>

                <%--<div class="for_sigle_row_form">

                    <label>
                        Registration No.<span style="color: Red">*</span></label><asp:TextBox ID="txtadmNo" runat="server" ReadOnly="true"></asp:TextBox>
                </div>--%>
                <div class="for_sigle_row_form">
                    <label>
                        Registration Date<span style="color: Red">*</span></label><asp:TextBox ID="txtAdmDate"
                            ReadOnly="true" runat="server"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">

                    <label>
                        Class
                                            <span style="color: Red">*</span></label><asp:TextBox runat="server" ReadOnly="true"
                                                ID="txtClassSec"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Officer Name<span style="color: Red">*</span></label><asp:TextBox ID="txtOfficer"
                            runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <b>
                        <asp:Label runat="server" ID="lblMsg"></asp:Label></b>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" ToolTip="Click here to submit details."
                        OnClick="btnsubmit_Click" OnClientClick="return check();" />
                    <%-- <a id="A1" href="javascript:;" class="btn btn-success button-submit " runat="server"
                                        onserverclick="btnsubmit_Click">Submit <i class="icon-ok"></i></a>--%>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>