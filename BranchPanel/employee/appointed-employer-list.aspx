<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="appointed-employer-list.aspx.cs" Inherits="BranchPanel_appointed_employer_list" %>

<%@ Register Src="~/BranchPanel/employee/employe-management.ascx" TagName="stu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .activeappointlist {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .auto-style1 {
            width: 107%;
        }

        .auto-style2 {
            background: none repeat scroll 0 0 #e2e2e2;
            position: relative;
            box-shadow: 0 3px 4px -6px #333333;
            color: #333;
            font-size: 14px;
            height: 30px;
            line-height: 30px;
            padding-top: 5px;
            width: 107%;
        }
    </style>

    <script type="text/javascript">
        var a = jQuery.noConflict();

        var refNo = "", name = "", mobile = "", designationid = "", deptid = "", pageno = 1, pagecount = 1, pagesize = 10, emaild = "", eid = "";

        function pageLoad() {

            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();
            $("#ctl00_ContentPlaceHolder1_lblpage").html(1);
            $("#ctl00_ContentPlaceHolder1_lblTotalPages").html(pagecount);

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');
        }

        a(document).ready(function () {
            $("#tdClosepopup").click(function () {
                $("#divMessage").hide(600);

            });

            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lblRefno]", function () {
                var id;
                id = $(this).parent('div').find('.id').text();
                window.location.href = "AppointmentLetter.aspx?eid=" + id;
                return false;
            });
            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=imgEdit]", function () {
                var id;
                id = $(this).parent('div').find('.id').text();
                window.location.href = "editAppointment.aspx?id=" + id;
                return false;
            });

            a(document).on("click", "[id*=grdAppoinmentLetter] [id*=lbllnkformore]", function () {

                eid = $(this).parent('div').find('.id').text();

                if (eid != "0") {
                    $("#divMessage").show(500);
                    $("#tab1").fadeIn();
                    getappointemplist(eid);
                }
                return false;
            });

            a('#ctl00_ContentPlaceHolder1_txtreferenceno').on('change', function () {
                refNo = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });
            a('#ctl00_ContentPlaceHolder1_txtName').on('change keyup', function () {
                name = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });

            a('#ctl00_ContentPlaceHolder1_txtemailid').on('change keyup', function () {
                emaild = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });

            a('#ctl00_ContentPlaceHolder1_txtcontactno').on('change', function () {
                mobile = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });

            a('#ctl00_ContentPlaceHolder1_ddldesignation').on('change', function () {
                designationid = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });

            a('#ctl00_ContentPlaceHolder1_ddldept').on('change', function () {

                deptid = a(this).val();
                pageno = 1;
                GetAppointedEmpList();
            });

            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
            $("#btnfirst").click(function () {
                pageno = 1;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                GetAppointedEmpList();
            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    GetAppointedEmpList();
                }
            });
            $("#btnnext").click(function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    GetAppointedEmpList();
                }
            });
            $("#btnlast").click(function () {

                pageno = pagecount;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                GetAppointedEmpList();
            });

        });

        function GetAppointedEmpList() {
            $.ajax({
                type: "POST",
                url: "appointed-employer-list.aspx/GetAppointedEmpList",
                data: "{'refNo':'" + refNo + "','name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','emaild':'" + emaild + "','eid':'" + eid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var srno = 1;
                    $("[id*=grdAppoinmentLetter] tr:gt(1)").remove();

                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=grdAppoinmentLetter] tr:eq(1)").clone(true);
                            $("[id$=grdAppoinmentLetter]").append(row);

                            $(row).find(".Row_num").html(data.d[i].RowNumber);
                            $(row).find(".refNo").html(data.d[i].refNo);
                            $(row).find(".Name").html(data.d[i].comname);
                            $(row).find(".department").html(data.d[i].department);
                            $(row).find(".designation").html(data.d[i].designation);
                            $(row).find(".mobile").html(data.d[i].mobile);
                            $(row).find(".email").html(data.d[i].email);
                            $(row).find(".id").html(data.d[i].eid);

                            pagecount = data.d[i].pagecount;

                            if (pagecount == 1) {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                            }
                        }

                    }
                    else {
                        var row = $("[id*=grdAppoinmentLetter] tr:eq(1)").clone(true);
                        $("[id$=grdAppoinmentLetter]").append(row);

                        $(row).find(".Row_num").html("No Record Found");
                        $(row).find(".refNo").html("No Record Found");
                        $(row).find(".Name").html("No Record Found");
                        $(row).find(".department").html("No Record Found");
                        $(row).find(".designation").html("No Record Found");
                        $(row).find(".mobile").html("No Record Found");
                        $(row).find(".email").html("No Record Found");
                    }

                    $("[id*=grdAppoinmentLetter] tr").show();
                    $("[id*=grdAppoinmentLetter] tr:eq(1)").hide();
                },
                error: function (result) {
                    alert("Error");
                }
            });
        }

        function getappointemplist(id) {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "appointed-employer-list.aspx/GetAppointedEmpList",
                data: "{'refNo':'" + refNo + "','name':'" + name + "','mobile':'" + mobile + "','designationid':'" + designationid + "','deptid':'" + deptid + "','emaild':'" + emaild + "','eid':'" + eid + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    OnSuccessReturn(data);
                },
                error: function (response) {
                    alert("Some Error Occured");
                }
            });
        }

        function OnSuccessReturn(data) {
            $.each(data.d, function (key, value) {

                $("#img1").attr("src", "../../facultyimage/" + value.photo);
                $("#lblRefno1").text(value.refNo);
                $("#lblusername").text(value.username);
                $("#lblPassword").text(value.password);
                $("#lblName").text(value.comname);
                $("#lblphone").text(value.mobile);
                $("#lblEmail").text(value.emailID);
                $("#lblDOB").text(value.dob);
                $("#lblCountry").text(value.countryName);
                $("#lblState").text(value.stateName);
                $("#lblCity").text(value.cityName);
                $("#lblAddress").text(value.address);
                $("#lblPinCode").text(value.pinCode);
                $("#lblGender").text(value.gender);

                $("#lblBirthPlace").text(value.birthplace);
                $("#lblNationality").text(value.gender);
                $("#lblEqualification").text(value.Hqualificaton);
                $("#lblPqualification").text(value.qqualificaton);
                $("#lblMStatus").text(value.mstatus);
                $("#lblNoOfChildren").text(value.noOfChilds);
                $("#lblFname").text(value.father);
                $("#lblMname").text(value.mother);
                $("#lblPANCardNo").text(value.panNo);
                $("#lblVoterIDNo").text(value.voterIdNo);
                $("#lblADHARNo").text(value.aadharNo);
                $("#lblDrivingLicenceNo").text(value.dlNo);
                $("#lblPassportNo").text(value.passportNo);
                $("#lblMessanger").text(value.messanger);

                //degisnation details
                $("#lblHrname").text(value.hrName);
                $("#lblOffemailid").text(value.emailAlloted);
                $("#lblProbation").text(value.probationPeriond);
                $("#lblDesig").text(value.designation);
                $("#lblDept").text(value.department);
                $("#lblDate").text(value.date);
                $("#lblDOJ").text(value.doj);
                $("#lblHRName").text(value.hrName);
                $("#lblComment").text(value.comments);
                //previous job details
                $("#lblOrg").text(value.preOrganisation);
                $("#lblPadd").text(value.pAddress);
                $("#lblPcountry").text(value.pcountry);
                $("#lblPstate").text(value.pstate);
                $("#lblPCity").text(value.pcity);
                $("#lblPPindcode").text(value.pPincode);
                $("#lblPDesignation").text(value.pDesignation);
                $("#lblSalary").text(value.pSalary);
                $("#lblDuration").text(value.pDuration);
                $("#lblTotalExperience").text(value.totalExperience);
                $("#lblFirstRefrenceName").text(value.ref1Name);
                $("#lblfrefContactNo").text(value.ref1Contact);
                $("#lblSecondRefrenceName").text(value.ref2Name);
                $("#lblContactNo").text(value.ref2Contact);
                //medical details
                $("#lblBloodGroup").text(value.ref2Contact);
                $("#lblMedicalCondition").text(value.ref2Contact);
                $("#lblPastDiseases").text(value.ref2Contact);
                $("#lblGeneticDisease").text(value.ref2Contact);
                $("#lblAnyAllergy").text(value.ref2Contact);
                //bank details
                $("#lblBankName").text(value.bankName);
                $("#lblAccountNo").text(value.accountNo);
                $("#lblBranchName").text(value.branchName);
                $("#lblBranchCode").text(value.branchCode);
                $("#lblIFSCCode").text(value.IFSC);

            });
        }
    </script>
    <asp:HiddenField ID="hfpages" runat="server" />
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a class="active" href="#">Appointed Employee List</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>
    <div align="center" id="divgrdOfferLetter" runat="server">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
            class="stm">

            <tr>
                <td colspan="2" class="containerHeadline" style="width: 100%">

                    <div style="float: left; width: 150px;">
                        <asp:DropDownList ID="ddlRecordperPage" Visible="false" runat="server" Width="90px" Font-Size="11px">
                            <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="1" Text="2"></asp:ListItem>
                            <asp:ListItem Value="2" Text="5"></asp:ListItem>
                            <asp:ListItem Value="3" Text="10"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div style="float: right; width: 1000px;">

                        <asp:TextBox ID="txtreferenceno" runat="server" Width="130px" placeholder="Enter Reference No" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtName" runat="server" Width="130px" placeholder="Enter First Name" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtcontactno" runat="server" Width="130px" placeholder="Enter Contact No"> </asp:TextBox>
                        <asp:TextBox ID="txtemailid" runat="server" Width="130px" placeholder="Enter Email ID"> </asp:TextBox>
                        <asp:DropDownList ID="ddldept" runat="server" Width="180px"></asp:DropDownList>
                        <asp:DropDownList ID="ddldesignation" runat="server" Width="180px"></asp:DropDownList>
                    </div>
                </td>
            </tr>
            <tr>

                <td colspan="2" align="left" style="padding-left: 0px; padding-right: 0px; width: 100%">
                    <asp:GridView ID="grdAppoinmentLetter" AutoGenerateColumns="false" GridLines="None" Width="100%" runat="server"
                         ShowHeader="true" BorderWidth="0">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="Row_num"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="6%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reference No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lblRefno" Text='<%# Eval("refNo") %>' runat="server" ForeColor="Chocolate" CssClass="refNo"></asp:LinkButton>
                                        <asp:Label ID="lblid" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="14%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" Text='<%# Eval("comname") %>' runat="server" CssClass="Name"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Department" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="department" Text='<%# Eval("department") %>' runat="server" CssClass="department"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblDesignation1" Text='<%# Eval("designation") %>' runat="server" CssClass="designation"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblMobile" Text='<%# Eval("mobile") %>' runat="server" CssClass="mobile"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="13%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" Text='<%# Eval("email") %>' ToolTip='<%# Eval("emailid") %>' Style="cursor: pointer" runat="server" CssClass="email"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="17%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:ImageButton ID="imgEdit" runat="server" ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                        <asp:Label ID="lblidforedit" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="8%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div>
                                        <asp:LinkButton ID="lbllnkformore" Text='More..' runat="server" ForeColor="blue"></asp:LinkButton>
                                        <asp:Label ID="lblempid" runat="server" Text='<%#Eval("eid") %>' CssClass="id" Style="display: none"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>

            <tr id="trforpagging" runat="server" style="width: 100%">
                <td align="left" style="width: 1000px" class="containerHeadline">
                    <div style="margin-left: 0px; float: left; width: 400px;">
                        <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                        Of
                <asp:Label ID="lblTotalPages" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                        <span style="font-size: 11pt">Page</span>
                    </div>
                    <div style="margin-left: 0px; float: left; width: 300px;">

                        <img src="../../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                        <img src="../../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div id="divMessage" class="showpopup" style="text-align: center; display: none">

                        <div style="text-align: right;">
                            <a id="tdClosepopup" style="text-align: right; color: red; cursor: pointer;font-weight:bold; margin-right: 14px; margin-top: 10px !important;">Close</a>
                        </div>

                        <div id="content">
                            <div id="tab1">
                                <table style="background-color: white; vertical-align: top; width: 98%;">
                                    <tr>

                                        <td style="width: 15%; text-align: left; padding-left: 15px;">
                                            <img id="imgLogo" src="../images/logo.png" height="100px" width="120px" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Personal Details</td>
                                    </tr>

                                   <%-- <tr>
                                     <td colspan="6" rowspan="4" style="width: 100px; text-align: left; padding-left: 15px;">
                                            <img id="img1" height="100px" width="100px" />
                                        </td>
                                   </tr>--%>

                                    <tr>
                                        <td class="t3"><span>Reference Number:</span></td>
                                        <td class="t4">
                                            <label id="lblRefno1"></label>
                                        </td>
                                         <td class="t3"><span>Login ID:</span></td>
                                        <td class="t4">
                                            <label id="lblusername"></label>
                                            <a href="http://login.awapalsolutions.com/emp-login.aspx" style="color:blue;text-decoration:underline;font-size:10px;float:right" target="_blank" >Click here for login</a>
                                        </td>
                                         <td class="t3"><span>Password:</span></td>
                                        <td class="t4">
                                            <label id="lblPassword"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Full Name:</span></td>
                                        <td class="t2">
                                            <label id="lblName"></label>
                                        </td>
                                        <td class="t3"><span>DOB:</span></td>
                                        <td class="t4">
                                            <label id="lblDOB"></label>
                                        </td>
                                        <td class="t1"><span>Gender:</span></td>
                                        <td class="t2">
                                            <label id="lblGender"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t3"><span>Birth Place:</span></td>
                                        <td class="t4">
                                            <label id="lblBirthPlace"></label>
                                        </td>
                                        <td class="t1"><span>Nationality:</span></td>
                                        <td class="t2">
                                            <label id="lblNationality"></label>
                                        </td>
                                        <td class="t3"><span>Educational Qualification:</span></td>
                                        <td class="t4">
                                            <label id="lblEqualification"></label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>Professional Qualification:</span></td>
                                        <td class="t2">
                                            <label id="lblPqualification"></label>
                                        </td>
                                        <td class="t3"><span>Marital Status:</span></td>
                                        <td class="t4">
                                            <label id="lblMStatus"></label>
                                        </td>
                                        <td class="t1"><span>No. Of Children:</span></td>
                                        <td class="t2">
                                            <label id="lblNoOfChildren"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t3"><span>Father Name:</span></td>
                                        <td class="t4">
                                            <label id="lblFname"></label>
                                        </td>
                                        <td class="t1"><span>Mother Name:</span></td>
                                        <td class="t2">
                                            <label id="lblMname"></label>
                                        </td>
                                        <td class="t3"><span>PAN Card No:</span></td>
                                        <td class="t4">
                                            <label id="lblPANCardNo"></label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>Voter ID No:</span></td>
                                        <td class="t2">
                                            <label id="lblVoterIDNo"></label>
                                        </td>
                                        <td class="t3"><span>ADHAR Card No.:</span></td>
                                        <td class="t4">
                                            <label id="lblADHARNo"></label>
                                        </td>
                                        <td class="t1"><span>Driving Licence No:</span></td>
                                        <td class="t2">
                                            <label id="lblDrivingLicenceNo"></label>
                                        </td>
                                    </tr>

                                    <tr>

                                        <td class="t1"><span>Passport No.:</span></td>
                                        <td class="t2">
                                            <label id="lblPassportNo"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Address Details</td>
                                    </tr>

                                    <tr>

                                        <td class="t3"><span>Phone No:</span></td>
                                        <td class="t4">
                                            <label id="lblphone"></label>
                                        </td>

                                        <td class="t3"><span>Email ID:</span></td>
                                        <td class="t4">
                                            <label id="lblEmail"></label>
                                        </td>
                                        <td class="t1"><span>City:</span></td>
                                        <td class="t2">
                                            <label id="lblCity"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t3"><span>State:</span></td>
                                        <td class="t4">
                                            <label id="lblState"></label>
                                        </td>

                                        <td class="t1"><span>Country:</span></td>
                                        <td class="t2">
                                            <label id="lblCountry"></label>
                                        </td>
                                        <td class="t3"><span>Address:</span></td>
                                        <td class="t4">
                                            <label id="lblAddress"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Pin Code:</span></td>
                                        <td class="t2">
                                            <label id="lblPinCode">Not Mentioned</label>
                                        </td>
                                        <td class="t1"><span>Instant Messenger:</span></td>
                                        <td class="t2">
                                            <label id="lblMessanger">Not Mentioned</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Designation Details</td>
                                    </tr>
                                    <tr>
                                        <td class="t3"><span>Department:</span></td>
                                        <td class="t4">
                                            <label id="lblDept"></label>
                                        </td>

                                        <td class="t1"><span>Designation:</span></td>
                                        <td class="t2">
                                            <label id="lblDesig"></label>
                                        </td>
                                        <td class="t1"><span>Probation Period:</span></td>
                                        <td class="t2">
                                            <label id="lblProbation"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>DOJ:</span></td>
                                        <td class="t2">
                                            <label id="lblDOJ"></label>
                                        </td>
                                        <td class="t3"><span>Letter Date: </span></td>
                                        <td class="t4">
                                            <label id="lblDate"></label>
                                        </td>
                                        <td class="t3"><span>Office Email ID: </span></td>
                                        <td class="t4">
                                            <label id="lblOffemailid"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>HR Name:</span></td>
                                        <td class="t2">
                                            <label id="lblHrname"></label>
                                        </td>

                                        <td class="t1"><span>Comments:</span></td>
                                        <td class="t2">
                                            <label id="lblComment"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="6" class="tblHeading">Previous job Details </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Organiazation Name:</span></td>
                                        <td class="t2">
                                            <label id="lblOrg"></label>
                                        </td>

                                        <td class="t1"><span>Address:</span></td>
                                        <td class="t2">
                                            <label id="lblPadd"></label>
                                        </td>
                                        <td class="t1"><span>Country:</span></td>
                                        <td class="t2">
                                            <label id="lblPcountry"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>State/Province :</span></td>
                                        <td class="t2">
                                            <label id="lblPstate"></label>
                                        </td>

                                        <td class="t1"><span>City:</span></td>
                                        <td class="t2">
                                            <label id="lblPCity"></label>
                                        </td>
                                        <td class="t1"><span>Pin/Zip Code:</span></td>
                                        <td class="t2" ">
                                            <label id="lblPPindcode"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Designation :</span></td>
                                        <td class="t2">
                                            <label id="lblPDesignation"></label>
                                        </td>

                                        <td class="t1"><span>Salary:</span></td>
                                        <td class="t2">
                                            <label id="lblSalary"></label>
                                        </td>
                                        <td class="t1"><span>Duration(in months) :</span></td>
                                        <td class="t2">
                                            <label id="lblDuration"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Total Experience(in months):</span></td>
                                        <td class="t2">
                                            <label id="lblTotalExperience"></label>
                                        </td>

                                        <td class="t1"><span>First Refrence Name :</span></td>
                                        <td class="t2">
                                            <label id="lblFirstRefrenceName"></label>
                                        </td>
                                        <td class="t1"><span>Contact No :</span></td>
                                        <td class="t2">
                                            <label id="lblfrefContactNo"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Second Refrence Name:</span></td>
                                        <td class="t2">
                                            <label id="lblSecondRefrenceName"></label>
                                        </td>

                                        <td class="t1"><span>Contact No. :</span></td>
                                        <td class="t2">
                                            <label id="lblContactNo"></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6" class="tblHeading">Medical Details </td>
                                    </tr>
                                    <tr>
                                        <td class="t1"><span>Blood Group :</span></td>
                                        <td class="t2">
                                            <label id="lblBloodGroup"></label>
                                        </td>

                                        <td class="t1"><span>MedicalCondition :</span></td>
                                        <td class="t2">
                                            <label id="lblMedicalCondition "></label>
                                        </td>
                                        <td class="t1"><span>Past Diseases :</span></td>
                                        <td class="t2">
                                            <label id="lblPastDiseases"></label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="t1"><span>Genetic Disease :</span></td>
                                        <td class="t2">
                                            <label id="lblGeneticDisease"></label>
                                        </td>

                                        <td class="t1"><span>Any Allergy :</span></td>
                                        <td class="t2">
                                            <label id="lblAnyAllergy"></label>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td colspan="6" class="tblHeading">Account Details </td>
                                    </tr>
                                     <tr>
                                         <td class="t1"><span>Bank Name :</span></td>
                                        <td class="t2">
                                            <label id="lblBankName"></label>
                                        </td>

                                        <td class="t1"><span>Account No. :</span></td>
                                        <td class="t2">
                                            <label id="lblAccountNo"></label>
                                        </td>
                                          <td class="t1"><span>Branch Name :</span></td>
                                        <td class="t2">
                                            <label id="lblBranchName"></label>
                                        </td>
                                    </tr>
                                     <tr>
                                         <td class="t1"><span>Branch Code :</span></td>
                                        <td class="t2">
                                            <label id="lblBranchCode"></label>
                                        </td>

                                        <td class="t1"><span>IFSC Code :</span></td>
                                        <td class="t2">
                                            <label id="lblIFSCCode"></label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>