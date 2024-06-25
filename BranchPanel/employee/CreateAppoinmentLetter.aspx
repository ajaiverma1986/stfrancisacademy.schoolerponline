<%@ Page Title="Create Appoinment Letter" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="CreateAppoinmentLetter.aspx.cs" Inherits="CreateAppoinmentLetter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .separator {
            display: block;
            height: 2px;
            background-color: #E6E6E6;
            margin: 10px 0 15px;
        }

        .bg-blue {
            background-color: #006EB8;
        }
    </style>

    <style type="text/css">
        h3.page-title {
            margin: 0;
        }

        .txtblue {
            color: #006EB8;
        }

        .icons {
            width: 20px;
            height: 20px;
            display: block;
            float: left;
            padding: 4px;
            margin-right: 8px;
            position: relative;
            top: -4px;
        }

        .border-blue {
            border: 1px solid #006EB8;
        }

        .fa {
            display: inline-block;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            line-height: 1;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .radius {
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            -ms-border-radius: 50%;
            border-radius: 50%;
        }

        .m-btm-big {
            margin-bottom: 30px;
        }

        .content-wrap {
            padding: 10px 15px;
        }
    </style>

    <script type="text/javascript">
        function valid() {
            if (document.getElementById('<%=ddlDOBDay.ClientID %>').value == 0) {
                alert("Please Select Day.!");
                document.getElementById('<%=ddlDOBDay.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlDOBMonth.ClientID %>').value == 0) {
                alert("Please Select Month.!");
                document.getElementById('<%=ddlDOBMonth.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlDOBYear.ClientID %>').value == 0) {
                alert("Please Select year.!");
                document.getElementById('<%=ddlDOBYear.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlTitle.ClientID %>').value == 0) {
                alert("Please Select Title.!");
                document.getElementById('<%=ddlTitle.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=rdGender.ClientID %>').value == 0) {
                alert("Please select rdGender.!");
                document.getElementById('<%=rdGender.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtDatejoining.ClientID %>').value.trim() == 0) {
                alert("Please Enter Date of Joining.!");
                document.getElementById('<%=txtDatejoining.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtContactNo.ClientID %>').value.trim() == 0) {
                alert("Please Enter Contact No..!");
                document.getElementById('<%=txtContactNo.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=rblMStatus.ClientID %>').value == 0) {
                alert("Please Select Marital Status.!");
                document.getElementById('<%=rblMStatus.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtAddressLine.ClientID %>').value.trim() == 0) {
                alert("Please Enter Address Details.!");
                document.getElementById('<%=txtAddressLine.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCountry.ClientID %>').value == 0) {
                alert("Please Select Country.!");
                document.getElementById('<%=ddlCountry.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlState.ClientID %>').value == 0) {
                alert("Please Select State.!");
                document.getElementById('<%=ddlState.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlCity.ClientID %>').value == 0) {
                alert("Please Select City.!");
                document.getElementById('<%=ddlCity.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtPincode.ClientID %>').value.trim() == 0) {
                alert("Please Enter Pin code.!");
                document.getElementById('<%=txtPincode.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlDepartment.ClientID %>').value == 0) {
                alert("Please Select Department.!");
                document.getElementById('<%=ddlDepartment.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlDesigNation.ClientID %>').value == 0) {
                alert("Please Select Designation.!");
                document.getElementById('<%=ddlDesigNation.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtSalary.ClientID %>').value.trim() == 0) {
                alert("Please Enter Salary.!");
                document.getElementById('<%=txtSalary.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtHrName.ClientID %>').value.trim() == 0) {
                alert("Please Enter HR name.!");
                document.getElementById('<%=txtHrName.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=ddlProbationPeriod.ClientID %>').value == 0) {
                alert("Please Select Probation Period.!");
                document.getElementById('<%=ddlProbationPeriod.ClientID %>').focus();
                return false;
            }
        }
    </script>

    <script type="text/javascript">
        function toggle5(showHideDiv, switchImgTag) {
            var ele = document.getElementById(showHideDiv);
            var imageEle = document.getElementById(switchImgTag);
            if (ele.style.display == "block") {
                ele.style.display = "none";
                imageEle.innerHTML = '<img src="../images/addd11.png" style=" margin-left:900px;" />';
            }
            else {
                ele.style.display = "block";
                imageEle.innerHTML = '<img src="../images/Green_Minus.gif" style=" margin-left:900px;">';
            }
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Managment</a></li>
            <li id="abc1" runat="server"><a>Create New</a></li>
            <li style="background: none;"><a class="active">Staff Manager</a></li>
            <div class="arrowt">
                <a href="../BranchPanel/CreateAppoinmentLetter.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>
    <div class="clear"></div>

    <asp:Button ID="btnCreate" runat="server" CssClass="button_save" Text="Create New" CausesValidation="false"
        OnClick="btnCreate_Click" />

    <div class="content_pane_cont input_content" id="contentPane">

        <br />
        <br />

        <div id="divAppoinmentLetter" runat="server">

            <div id="headerDivImg">

                <a id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                    <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                </a>
            </div>
            <h4 class="page-title txtblue ">

                <div class="icons border-blue radius">

                    <i class="fa fa-calendar-o txtblue">
                        <img src="../images/stude.png" />
                    </i>
                </div>
                <span id="Span1" style="margin-left: 10px;">Employee Details </span>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg" style="display: block;">

                <div class="for_sigle_row_form">
                    <label>
                        Reference NO<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtRefNo" runat="server" OnTextChanged="txtRefNo_TextChanged" AutoPostBack="true"></asp:TextBox>
                    &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtRefNo"
                    ErrorMessage="Enter Refrence No." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Title<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlTitle" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFName" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                <asp:TextBox ID="txtMName" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Gender<span style="color: #ff0066">*</span></label>
                    <asp:RadioButtonList ID="rdGender" runat="server" RepeatDirection="Horizontal" CssClass="labelfor_radio">

                        <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                        <asp:ListItem Value="0">Female</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Date Of Birth<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlDOBDay" runat="server" AppendDataBoundItems="True" CssClass="ddlDD">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlDOBMonth" runat="server" AppendDataBoundItems="True" CssClass="ddlMM">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlDOBYear" runat="server" AppendDataBoundItems="True" CssClass="ddlYY">
                    </asp:DropDownList>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        D.O.J<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtDatejoining" runat="server"></asp:TextBox>&nbsp&nbsp&nbsp
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Candidate Contact No.<span style="color: Red;">*</span></label>
                    <asp:TextBox ID="txtContactNo" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Marital Status<span style="color: Red;">*</span></label>
                    <asp:RadioButtonList runat="server" ID="rblMStatus" RepeatDirection="Horizontal"
                        CssClass="labelfor_radio">
                        <asp:ListItem Value="1">Unmarried</asp:ListItem>
                        <asp:ListItem Value="2">Married</asp:ListItem>
                    </asp:RadioButtonList>
                    <%--<asp:TextBox ID="txtMaritalStatus" runat="server"></asp:TextBox>--%>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Candidate E-mail ID <span style="color: Red;">*</span></label>
                    <asp:TextBox ID="txtEmailid" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="Please Enter Email Id."
                        ControlToValidate="txtEmailid" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="rev2" runat="server" ControlToValidate="txtEmailid"
                        ErrorMessage="Please Enter Correct Email Id " ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        SetFocusOnError="True" CssClass="rqd"></asp:RegularExpressionValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Upload Photo (500KBMax.)</label>
                    <asp:FileUpload runat="server" ID="fuPhoto" />&nbsp;
                                            <asp:Label runat="server" ID="lblPhoto" Text="" Visible="false"></asp:Label>
                </div>
            </div>

            <div id="Div1">

                <a id="A1" href="javascript:toggle5('contentDivImg111', 'A1');">
                    <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                </a>
            </div>
            <h4 class="page-title txtblue ">

                <div class="icons border-blue radius">

                    <i class="fa fa-calendar-o txtblue">
                        <img src="../images/home1.png" />
                    </i>
                </div>
                <span id="Span2" style="margin-left: 10px;">Address Details </span>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg111" style="display: block;">

                <div class="for_sigle_row_form">
                    <label>
                        Address Line<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtAddressLine" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>

                <asp:UpdatePanel runat="server" ID="upd1">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <label>
                                Country<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                State/Province<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                                OnSelectedIndexChanged="ddlState_SelectedIndexChanged2">
                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                City<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlCity" runat="server" AppendDataBoundItems="True">
                                <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="for_sigle_row_form">
                    <label>
                        Pin/Zip Code<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtPincode" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>
            </div>

            <div id="Div3">

                <a id="A2" href="javascript:toggle5('contentDivImg3333', 'A2');">
                    <img src="../images/Green_Minus.gif" style="margin-left: 900px;" />
                </a>
            </div>
            <h4 class="page-title txtblue ">

                <div class="icons border-blue radius">

                    <i class="fa fa-calendar-o txtblue">
                        <img src="../images/home1.png" />
                    </i>
                </div>
                <span id="Span3" style="margin-left: 10px;">Job Details </span>
            </h4>

            <div class="separator bg-blue"></div>

            <div id="contentDivImg3333" style="display: block;">

                <asp:UpdatePanel runat="server" ID="upd2">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <label>
                                Department<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Designation<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlDesigNation" runat="server" AutoPostBack="True">
                            </asp:DropDownList>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="for_sigle_row_form">
                    <label>
                        Qualification<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtquali" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Salary<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtSalary" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        HR Manager Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtHrName" runat="server"></asp:TextBox>&nbsp&nbsp
               <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ErrorMessage="Please Enter Hr Name"
                    ControlToValidate="txtHrName" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>--%>
                </div>

                <asp:UpdatePanel runat="server" ID="upd12">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <label>
                                Probation Period<span style="color: #ff0066">*</span></label>
                            <asp:DropDownList ID="ddlProbationPeriod" runat="server" AutoPostBack="True" AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <%--  &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server"
                    ErrorMessage="Select Probation Period" ControlToValidate="ddlProbationPeriod"
                    InitialValue="0" CssClass="rqd" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="for_sigle_row_form">
                    <label>
                        Comments</label>
                    <asp:TextBox ID="txtComment" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;
                </div>
            </div>

            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Label ID="lblSuccessMsg" runat="server" Text="" Font-Size="15px" EnableViewState="false"
                    ForeColor="Green"></asp:Label>
                <br />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button_save" OnClientClick="return valid();" OnClick="btnSubmit_Click2" />
                &nbsp;<asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="button_save" OnClick="Cancel_Click"
                    CausesValidation="false" />
            </div>
        </div>
        <%-- <div class="clear"> </div>--%>
    </div>
    <asp:UpdatePanel ID="upd114" runat="server">
        <ContentTemplate>

            <div align="center" id="divgrdOfferLetter" runat="server">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadline" style="padding-left: 10px;">
                            <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                                Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="2"></asp:ListItem>
                                <asp:ListItem Value="2" Text="5"></asp:ListItem>
                                <asp:ListItem Value="3" Text="10"></asp:ListItem>
                            </asp:DropDownList>
                            <div style="float: right; width: 400px;">
                                <asp:DropDownList ID="ddlsearchoption" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlsearchoption_SelectedIndexChanged">
                                    <asp:ListItem Value="0">Search Items</asp:ListItem>
                                    <asp:ListItem Value="1">Name</asp:ListItem>
                                    <asp:ListItem Value="2">Mobile</asp:ListItem>
                                </asp:DropDownList>
                                <asp:TextBox ID="Textbox1" runat="server" Width="150px" Height="23px"> </asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Go" Height="23px" ToolTip="Click here to search items"
                                    OnClick="Button1_Click" CssClass="view-enquiry" />
                                <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="false" CausesValidation="false"
                                    OnClick="ImageButton1_Click" Height="20px" CssClass="excel" ToolTip="Click here to download Excel sheet" />
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td align="left" colspan="8" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView ID="grdAppoinmentLetter" AutoGenerateColumns="false" GridLines="None" Width="100%" runat="server"
                                EmptyDataText="No Record Found!..." OnRowCommand="grdAppoinmentLetter_OnRowCommand"
                                ShowHeader="true" BorderWidth="0">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="6%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reference No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblRefno" Text='<%# Eval("refNo") %>' runat="server" CommandName="View" CommandArgument='<%# Bind("eid") %>'
                                                Font-Bold="true" Font-Underline="true" ForeColor="Chocolate" ToolTip="Click here to see the appointment letter">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="14%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" Text='<%# Eval("comname") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Reference No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldepartment" Text='<%# Eval("department") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Designation" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDesignation" Text='<%# Eval("designame") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="12%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Contact No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMobile" Text='<%# Eval("mobile") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="13%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Email" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" Text='<%# Eval("emailid") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="17%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgEdit" runat="server" CommandName="ActionPerform" CommandArgument='<%# Eval("eid") %>'
                                                ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" />
                            </asp:GridView>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="10" class="containerHeadline" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px" OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                            </asp:DropDownList>
                            <div style="margin-left: 350px; float: left; width: 300px;">
                                <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" OnClick="firstpage_Click" />
                                <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>

                    <tr>

                        <td id="abc" runat="server" visible="false">
                            <asp:GridView ID="GridView1" AutoGenerateColumns="false" Width="100%" runat="server"
                                EmptyDataText="No Record Found!..." OnRowCommand="GridView1_OnRowCommand" BorderWidth="0">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox" runat="server">S.No.</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblrefx" runat="server">Reference No.</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblRefno" Text='<%# Eval("refNo") %>' runat="server" CommandName="View" CommandArgument='<%# Bind("eid") %>'
                                                Font-Bold="true" Font-Underline="true" ForeColor="Chocolate" ToolTip="Click here to see the appointment letter">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>

                                        <HeaderTemplate>
                                            <asp:Label ID="lblnamex" runat="server"> Name</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" Text='<%# Eval("fName") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lbldegx" runat="server">Designation</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDesignation" Text='<%# Eval("designame") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblmobilex" runat="server">Mobile</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblMobile" Text='<%# Eval("mobile") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblstausx" runat="server">Status</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    </div>
    <!-- END PAGE CONTENT-->
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtDatejoining").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>
</asp:Content>