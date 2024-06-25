<%@ Page Title="Admission-Form" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-admission-form.aspx.cs" Inherits="BranchPanel_student_admission_form" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="default.js" type="text/javascript"></script>
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function pageLoad() {
            var vars = [], hash, i;
            var hashes = window.location.href;
            var hashes1 = window.location.href;
            hash1 = hashes1.split('?');
            hash = hashes.split('=');
            if (hash1[1].substring(0, 5) == 'regno') {
                hash[1] = hash[1].replace("%20", " ")
                if (hash[1] != "") {
                    FillDataOfAdmission(hash[1]);
                }
            }
            else if ((hash1[1].substring(0, 8)) == 'discount') {
                if (hash[1] != "") {
                    Filldiscountdatadetails(hash[1]);
                }
            }

        }

        function stopReloadKey(evt) {
            var evt = (evt) ? evt : ((event) ? event : null);
            var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
            if (evt.keyCode == 13) {
                return false;
            }
        }

        document.onkeypress = stopReloadKey;
    </script>
    <style type="text/css">
        .active4 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 13px;
            margin-top: 3px;
        }

        #ctl00_ContentPlaceHolder1_rbgender label {
            color: #000;
            float: right;
            font-size: 14px;
            margin-right: 5px;
            margin-top: -10px;
            padding-top: 8px;
            text-align: right;
            width: 100px;
            border:none !important;
        }
         #ctl00_ContentPlaceHolder1_rbgender input {
            margin-left: 5px;
        }

         #ctl00_ContentPlaceHolder1_rtransportation label {
            color: #000;
            float: right;
            font-size: 14px;
            margin-right: 5px;
            margin-top: -10px;
            padding-top: 8px;
            text-align: right;
            width: 100px;
            border:none !important;
        }
          #ctl00_ContentPlaceHolder1_rtransportation input {
            margin-left: 5px;
        }

        body {
            font: 70% Arial, Helvetica, sans-serif;
            color: #063774;
        }

        table {
            padding-left:5px !important;
            border: 1px #D0D1D7 solid;
            border-collapse: collapse;
            width:315px !important;
        }

        th {
            padding: 10px 18px;
            text-align: left;
        }

        td {
            padding: 10px 18px;
        }

        .cscfeepay {
            outline: 0;
            height: 25px;
            width: 275px;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx">Home</a></li>

            <li><a>Admission</a></li>
            <li style="background: none;"><a class="active" href="">New Admission</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <br />
        <div id="divstudentadno1" runat="server">
        </div>
        <div runat="server" id="admissionform">

            <div class="for_sigle_row_form">
                <label>
                    Enter Discount Code if Applicable<span style="color: Red"></span></label>
                <asp:TextBox runat="server" ID="txtdiscountcode" onkeypress="return noAlphabets(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Registration No.(for reference)</label>
                <asp:TextBox ID="txtRegNo" runat="server" CssClass="checkreg"></asp:TextBox>
                <asp:HiddenField ID="hfrid" runat="server" Value='<%# Bind("rid") %>' />
                <asp:Label runat="server" ID="lblmsg" ForeColor="Chocolate"></asp:Label>
            </div>

            <div class="for_sigle_row_form">
                <label>
                    Select Financial Year<span style="color: Red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server">
                </asp:DropDownList>
            </div>

            <div class="for_sigle_row_form">
                <label>
                    Admission Date<span style="color: Red">*</span></label>
                <asp:DropDownList ID="ddlMonth" runat="server" Width="112px">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlDate" runat="server" Width="92px">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlYear" runat="server" Width="103px">
                    <asp:ListItem Value="1">2014</asp:ListItem>
                    <asp:ListItem Value="2">2015</asp:ListItem>
                    <asp:ListItem Value="3">2016</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Name of Applicant<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtName" runat="server" CssClass="fname" onkeypress="return lettersOnly(event)" style="width:94px !important;"></asp:TextBox>
            <asp:TextBox ID="txtmidname" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            <asp:TextBox ID="txtLName" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Date of Birth<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                <span id="lblAge"></span>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Father's Name<span style="color: Red">*</span></label>
                <asp:TextBox runat="server" ID="txtFname" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtmidname1" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtlastname1" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Mother's Name</label>
                <asp:TextBox runat="server" ID="txtmother" CssClass="fname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtmidname2" runat="server" CssClass="mname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                &nbsp;
            <asp:TextBox ID="txtlastname2" runat="server" CssClass="lname" onkeypress="return lettersOnly(event)"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form ">
                <label>
                    Gender<span style="color: Red">*</span></label>
                <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="1">Male</asp:ListItem>
                    <asp:ListItem Value="0">Female</asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <div class="for_sigle_row_form ">
                <label>
                    Transportation:</label>
                <asp:RadioButtonList runat="server" ID="rtransportation" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                </asp:RadioButtonList>
                <asp:LinkButton ID="lnk1" runat="server" Text="Change" Style="display: none; margin-left: 436px; margin-top: -25px" CssClass="editlnk"> </asp:LinkButton>
            </div>

            <div class="clear">
            </div>
            <asp:UpdatePanel ID="updr" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">
                        <label>
                            Mobile No.<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtmob" runat="server" MaxLength="12" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                        &nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtmob"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Applying for Class<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_Course" runat="server">
                        </asp:DropDownList>
                        &nbsp;
                    <asp:Label runat="server" ID="lbclassname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                        <asp:Label runat="server" ID="lbclmsg" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                        <asp:Label runat="server" ID="lbclssname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Section<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlSection" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Address Line<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Country<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCountry1" Enabled="false">
                        </asp:DropDownList>
                        &nbsp;
                    <asp:Label runat="server" ID="lblCountryMsg" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            State/Province<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_state" runat="server">
                        </asp:DropDownList>
                        &nbsp;
                    <asp:Label runat="server" ID="lblStateMsg" ForeColor="Chocolate" Text=""></asp:Label>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            City<span style="color: Red">*</span></label>
                        <asp:DropDownList runat="server" ID="ddlCity1">
                        </asp:DropDownList>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="for_sigle_row_form">
                <label>
                    PIN/ZIP code<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8" onkeypress="return noAlphabets(event)"></asp:TextBox>
                &nbsp;
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtPZIP"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>

            <div class="clear"></div>

            <div id="divas" runat="server">
                <div class="for_sigle_row_form">
                    <label style="margin-left: 245px;border-bottom: 3px dotted black; border-top: 3px dotted black; font-weight: bold;font-size: 16px;padding-bottom:10px;width:209px;padding-right:97px">
                        For Office USe Only
                    </label>
                </div>
                <div class="clear">
                </div>
                <div class="for_sigle_row_form" style="display: none">
                    <label>
                        Admission No.<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtadmNo" runat="server" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Class & Section<span style="color: Red">*</span></label>
                    <asp:TextBox runat="server" ID="txtClassSec" Enabled="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Officer Name<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtOfficer" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Pay" OnClientClick="return getfeeheads();" />

                <asp:Button ID="Button4" runat="server" CssClass="button_save" Text="Preview" />
            </div>
        </div>
        <div class="clear">
        </div>
        <div id="preview" runat="server" style="display: none">

            <div class="shadow1" style="width: 42.8%; border: 2px solid #FCFAFA; padding: 5px 20px; margin: 0px auto; background: #fff;">

                <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 487px; border-bottom: 1px dashed #DDDDDD; padding: 5px 20px; margin: 0 auto 0 -15px;">

                    <tr>

                        <td>

                            <asp:Label ID="Label3" runat="server" ForeColor="#249cdd" Font-Bold="true" Font-Size="Large" Style="margin-left: 123px;">Form Preview Details</asp:Label>
                        </td>
                    </tr>
                </table>

                <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 382px;">

                    <tr>

                        <td class="frmde" style="text-align: right;">Registration No.(for reference) :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="regno1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">Name of Applicant :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblappname1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">Date of Birth :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lbldob1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">

                            <b>Father's Name :</b>
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblfather1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Mother's Name :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblmother1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Gender :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblgnder1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Applying Class :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblclass1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">Section :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblsection1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Address Line :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lbladdress1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Country :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblcountry1" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="frmde" style="text-align: right;">State/Province :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblstate1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td class="frmde" style="text-align: right;">City :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblcity1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">PIN/ZIP Code :
                        </td>
                        <td class="frmde">

                            <asp:Label ID="lblpincode1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Mobile No :
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblmobile12" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="trans" class="shadow2" style="width: 42.8%; border: 2px solid #FCFAFA; padding: 5px 20px; margin: 0px auto; background: #fff;">
                <table id="tbltrans" class="file_border1" cellpadding="2" cellspacing="0" border="0" style="min-width: 487px; border-bottom: 1px dashed #DDDDDD; padding: 5px 20px; margin: 0 auto 0 -15px; display: block">
                    <%-- for transport--%>

                    <tr>

                        <td>

                            <asp:Label ID="lbltransportdetail" runat="server" ForeColor="#249cdd" Font-Bold="true" Font-Size="Large" Style="margin-left: 123px;">Transportation Detail</asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Zone:
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblzone" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Area:
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblarea" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Bus:
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblbus" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>

                        <td class="frmde" style="text-align: right;">Busopage:
                        </td>
                        <td class="frmde">
                            <asp:Label ID="lblstopage" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="for_sigle_row_form" style="margin-left: 26%;">
                <label>
                </label>
                <asp:Button ID="Button5" runat="server" CssClass="button_save" Text="Back" />
            </div>
        </div>
        <div class="clear">
        </div>

        <div id="feedetails" style="display: none;" class="stm">

            <%-- <span id="showfeeheads"></span>--%>
            <div id="Container">
            </div>

            <div style="border: 2px #2CA8C2 solid; width: 44%">
                <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">

                    <label>
                        Payment Mode:<span style="color: Red">*</span></label>

                    <asp:DropDownList ID="ddlPayMode" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                        <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                        <%--<asp:ListItem Value="3">Cheque</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>

                <div class="clear"></div>

                <div id="bankdetail" runat="server" style="display: none; margin-left: 20px;">
                    <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                        <label runat="server" id="ll1">
                            Bank Name:<span style="color: Red;">*</span></label>
                        <asp:TextBox runat="server" ID="txtBankName" Height="29px" Width="226px" onkeypress="ValidateAlpha()" Style="padding: 2px; margin-left: -2px;"></asp:TextBox>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form1" style="margin-left: 2%;">
                        <label runat="server" id="Label4">
                            Bank Branch <span style="color: Red;">*</span></label>
                        <asp:TextBox runat="server" ID="txtbranch" Height="31px" Width="223px" Style="margin-left: 27px; padding: 2px;"></asp:TextBox>
                    </div>

                    <div id="Div3" runat="server" style="margin-left: -30px;">
                        <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                            <label runat="server" id="ll2">
                                Draft/Check NO:<span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" Height="29px" Width="226px" ID="txtCheque" Style="padding: 2px;"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div id="Div1" runat="server" style="margin-left: -30px;">
                        <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                            <label runat="server" id="Label1">
                                Draft/Check Date:<span style="color: Red;">*</span></label>
                            <asp:TextBox ID="txtDate" runat="server" Height="29px" Width="226px"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="clear"></div>

                <div id="Div4" runat="server" style="margin-left: 17px;">
                    <div class="for_sigle_row_form1" style="margin-left: 10%; padding-top: 0px;">
                        <label>Payable Fee:</label>
                        <asp:TextBox ID="txtpayablefee" runat="server" Height="29px" Width="220px" Enabled="false" Style="padding: 2px;">0.00</asp:TextBox>
                    </div>
                </div>
                <div class="clear"></div>
                <br />
                <div id="Div5" runat="server" style="margin-left: 10px;">
                    <div class="for_sigle_row_form1" style="margin-left: 15%; padding-top: 0px;">
                        <label>Amount:<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtpaimat" runat="server" Height="29px" Width="226px" onkeypress="return noAlphabets(event)" Style="padding: 2px;">0.00</asp:TextBox>
                        <asp:Label runat="server" ID="lblremain" Style="display: none; margin-left: 59px; margin-top: 8px;" ForeColor="Red">Remaining Blanace:</asp:Label>
                        <asp:Label runat="server" ID="lblremainbal" ForeColor="Red" Style="display: none; margin-left: 178px; margin-top: -11px;"></asp:Label>
                    </div>
                </div>
                <div id="Div6" runat="server" style="margin-left: 106px;">
                    <div class="for_sigle_row_form1" style="margin-left: 7%;">
                        <label>
                        </label>
                        <asp:Button ID="Button1" runat="server" CssClass="button_save" Text="Submit" Style="height: 29px" />
                        <asp:Button ID="Button3" runat="server" CssClass="button_cancel" Text="Back" />
                    </div>
                </div>
            </div>
            <div id="payfeebind" class="myclass" style="float: right; margin-top: -556px; margin-right: 200px;">
            </div>
            <div id="divfeestructure" style="display: none;">
            </div>
        </div>

        <div id="p1" class="maindivpopup" style="display: none;">
            <asp:Panel ID="popup2" runat="server" BackColor="White" Height="275px" Width="500px"
                Style="z-index: 9000000; background-color: White; position: absolute; left: 20%; top: 15%; border: outset 2px #2CA8C2; padding: 5px; display: none;">
                <table width="100%" style="width: 100%; height: 100%; border: 1px solid #2CA8C2;" cellpadding="0" cellspacing="5">
                    <tr style="background-color: #2CA8C2;">
                        <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                            align="center">Add Student To Bus
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Zone:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Area:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:HiddenField ID="myhidden" runat="server" Value="" />
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Bus:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:Label ID="lbmssg" runat="server" Style="display: none;"></asp:Label>
                            <asp:Label ID="lbseatmsg" runat="server" Style="display: none;"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Stoppage:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="Button6" CssClass="button_save" Text="Ok" runat="server" />
                            <asp:Button ID="button7" class="btnClose" Style="margin-left: 60px; margin-top: -35px;" CssClass="button_cancel" runat="server" Text="Cancel" />
                            <asp:Button ID="btn_later" class="btnClose" CssClass="button_cancel" runat="server" tyle="margin-left: 60px;margin-top:-35px;" Text="Cancel" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>
</asp:Content>