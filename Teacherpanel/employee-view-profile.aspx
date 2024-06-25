<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="employee-view-profile.aspx.cs" Inherits="EmployeePanel_employee_view_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>
    <style>
        .profileactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
            font-size: 11px!important;
            font-weight: normal!important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 1px solid #CCCCCC!important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 0.50px solid #CCCCCC!important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none!important;
        }
    </style>
    <script type="text/javascript">
        var ctr, txtqualification = "";

        $(document).ready(function () {
            getappointemplist();
        });

        function getappointemplist() {
            call_progressbar("start");
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "employee-view-profile.aspx/GetAppointedEmpList",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        OnSuccessReturn(data);
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    call_progressbar("end");
                    return false;

                }

            });

        }

        function OnSuccessReturn(data) {

            $.each(data.d, function (key, value) {

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
                //=====Checked Document Submited=====
                var item = value.isDocumentSubmit;
                var arr = item.split(",");
                $('input[type=checkbox]').prop("checked", false);
                for (var j = 0; j < arr.length; j++) {
                    $('input[type=checkbox]').each(function () {
                        $(this).prop("disabled", false);
                        if (parseInt(arr[j]) == parseInt($(this).val())) {
                            $(this).prop("checked", true);
                        }
                        $(this).prop("disabled", true);
                    });
                }

                //=====Current Address Details=====
                $("#address").text(value.Taddress);
                $("#country").text(value.per_countryName);
                $("#state").text(value.per_stateName);
                $("#city").text(value.per_cityName);
                $("#pincode").text(value.TpinCode);

                $("#current_address_landmark").text(value.current_address_landmark);
                $("#permanent_address_landmark").text(value.permanent_address_landmark);

                //=====gardians details===========
                $("#father").text(value.father);
                $("#mother").text(value.mother);
                $("#fathermobileno").text(value.fathercontactno);
                $("#mothermobileno").text(value.mothercontactno);
                $("#parentsaddress").text(value.parentsaddress);
                $("#father_alternate_no").text(value.father_alternate_no);

                $("#lblBirthPlace").text(value.birthplace);
                $("#lblNationality").text(value.nationality);

                if (value.qualificaton != "" && value.qualificaton != "0") {

                    $("#ctl00_head_tbl").css("display", "block");
                    $("#ctl00_head_lblmsg").css("display", "none");

                    var Qualifction = value.qualificaton.split("~");
                    var brd = value.education_board.split("~");
                    var yr = value.passing_year.split("~");
                    var sesion = value.session.split("~");
                    var rllnum = value.rollnumber.split("~");
                    var perecnt = value.percentage.split("~");
                    var add = value.institute_address.split("~");

                    var noofrows = document.getElementById('ctl00_head_tbl').rows.length - 1;

                    if (noofrows < Qualifction.length - 1) {
                        for (var a = 0; a < Qualifction.length - 2; a++) {
                            add_Row();
                        }
                    }
                    var totalrows = document.getElementById('ctl00_head_tbl').rows.length;
                    if (totalrows > 1) {
                        var j = 0;

                        for (var i = 1; i < totalrows; i++) {

                            document.getElementById("ctl00_head_tbl").rows[i].cells[0].getElementsByTagName("span")[0].textContent = Qualifction[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[1].getElementsByTagName("span")[0].textContent = brd[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[2].getElementsByTagName("span")[0].textContent = yr[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[3].getElementsByTagName("span")[0].textContent = sesion[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[4].getElementsByTagName("span")[0].textContent = rllnum[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[5].getElementsByTagName("span")[0].textContent = perecnt[j];
                            document.getElementById("ctl00_head_tbl").rows[i].cells[6].getElementsByTagName("span")[0].textContent = add[j];
                            j++;
                        }

                    }
                }
                else {
                    $("#ctl00_head_tbl").css("display", "none");
                    $("#ctl00_head_lblmsg").css("display", "block");
                }

                $("#lblMStatus").text(value.mstatus);
                $("#lblNoOfChildren").text(value.noOfChilds);
                $("#lblPANCardNo").text(value.panNo);

                $("#idname").text(value.id_proof_id);
                $("#idnumber").text(value.id_proof_number);

                $("#ResidentialProofname").text(value.residential_id);
                $("#ResidentialProofnumber").text(value.residential_proof_number);
                $("#lblMessanger").text(value.messanger);

                //degisnation details
                $("#annualctc").text(value.CTC);
                $("#CTCappliedfrom").text(value.CTCappliedfrom);
                $("#inhandsalary").text(value.salary);
                $("#pfno").text(value.pfno);
                $("#esino").text(value.esino);
                $("#tds_account_number").text(value.tds_account_number);

                $("#typeofemployement").text(value.emplyeetype);
                $("#branch").text(value.Brname);
                $("#lblHrname").text(value.hrName);

                $("#lblOffemailid").text(value.emailAlloted);
                $("#lblProbation").text(value.probationPeriond);
                $("#lblDesig").text(value.designation);
                $("#lblDept").text(value.department);
                $("#lblDate").text(value.date);
                $("#lblDOJ").text(value.doj);

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

                var exp = value.totalExperience;
                var fiexp = exp.split(",");
                $("#lblYears").text(fiexp[0]);
                $("#lblMonths").text(fiexp[1]);

                $("#lblFirstRefrenceName").text(value.ref1Name);
                $("#lblfrefContactNo").text(value.ref1Contact);
                $("#lblSecondRefrenceName").text(value.ref2Name);
                $("#lblContactNo").text(value.ref2Contact);
                //medical details
                $("#lblBloodGroup").text(value.bloodGroup);
                $("#lblMedicalCondition").text(value.medicalCondition);
                $("#lblPastDiseases").text(value.pastDeseas);
                $("#lblGeneticDisease").text(value.geneticDeseas);
                $("#lblAnyAllergy").text(value.anyAlergy);
                //bank details
                $("#lblBankName").text(value.bankName);
                $("#lblAccountNo").text(value.accountNo);
                $("#lblBranchName").text(value.branchName);
                $("#lblBranchCode").text(value.branchCode);
                $("#lblIFSCCode").text(value.IFSC);

                $("#biometricno").text(value.AddBiometric_Card_No);

            });
        }
        function add_Row() {
            ctr++;
            txtqualification = "txtqualification" + ctr;
            var txtboard = "txtboard" + ctr;
            var txtyear = "txtyear" + ctr;
            var session = "txtsession" + ctr;
            var txtrollnumber = "txtrollnumber" + ctr;
            var txtpercent = "txtpercent" + ctr;
            var remove = "removebtn" + ctr;

            var instituladdress = "txtinstituteaddress" + ctr;

            var newTr = '<tr style="height:25px"><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtqualification +
                '></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtboard
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:120px;text-transform:none!important"  id=' + txtyear
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important"  id=' + session
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtrollnumber
                + ' ></span></td><td style="border: 1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + txtpercent
                + ' ></span></td><td style="border:1px solid #CCCCCC!important;text-align: center;"><span style="width:150px;text-transform:none!important" id=' + instituladdress
                + ' ></span></td></tr>';
            $('#ctl00_head_tbl').append(newTr);

        }

        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
    </script>

    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                      <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Profile
                    </h1>
                </div>
                <div class="main-content">
                    <div class="row">
                        <%--===============Thid div is for General details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            General Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">

                                                <tr>
                                                    <td class="t1"><span>Employee Code:</span></td>
                                                    <td class="t2">
                                                        <label id="lblRefno1"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Login ID:</span></td>
                                                    <td class="t2">
                                                        <label id="lblusername"></label>
                                                        <%--<a href="http://login.awapalsolutions.com/emp-login.aspx" style="color: blue; text-decoration: underline; font-size: 10px; float: right" target="_blank">Click here for login</a>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Password:</span></td>
                                                    <td class="t2">
                                                        <label id="lblPassword"></label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Full Name:</span></td>
                                                    <td class="t2">
                                                        <label id="lblName"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>DOB:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDOB"></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Gender:</span></td>
                                                    <td class="t2">
                                                        <label id="lblGender">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Birth Place:</span></td>
                                                    <td class="t2">
                                                        <label id="lblBirthPlace">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Nationality:</span></td>
                                                    <td class="t2">
                                                        <label id="lblNationality">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Marital Status:</span></td>
                                                    <td class="t2">
                                                        <label id="lblMStatus">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>No. Of Children:</span></td>
                                                    <td class="t2">
                                                        <label id="lblNoOfChildren">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>ID Name:</span></td>
                                                    <td class="t2">
                                                        <label id="idname">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>ID Number:</span></td>
                                                    <td class="t2">
                                                        <label id="idnumber">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>Residential Proof Name:</span></td>
                                                    <td class="t2">
                                                        <label id="ResidentialProofname">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Residential Proof Number:</span></td>
                                                    <td class="t2">
                                                        <label id="ResidentialProofnumber">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Submitted Document:</span></td>
                                                    <td class="t2">
                                                        <asp:CheckBoxList ID="chkboxlistfordocuments" runat="server" CssClass="forlabel" RepeatDirection="Horizontal" RepeatColumns="2">
                                                            <asp:ListItem Value="1" Text="10th"></asp:ListItem>
                                                            <asp:ListItem Value="2" Text="12th"></asp:ListItem>
                                                            <asp:ListItem Value="3" Text="Graduation"></asp:ListItem>
                                                            <asp:ListItem Value="4" Text="Post Graduation"></asp:ListItem>
                                                            <asp:ListItem Value="5" Text="Diploma"></asp:ListItem>
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                        <%--===============Thid div is for Gardian details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-group"></i>
                                            Gardian Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Father Name:</span></td>
                                                        <td class="t2">
                                                            <label id="father">--</label>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <span>Profession: </span>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Father Mobile No.:</span></td>
                                                        <td class="t2">
                                                            <label id="fathermobileno">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Father Alternate Mobile No.:</span></td>
                                                        <td class="t2">
                                                            <label id="father_alternate_no">--</label>
                                                        </td>
                                                </tbody>
                                            </table>
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Mother Name:</span></td>
                                                        <td class="t2">
                                                            <label id="mother">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Mother Mobile No:</span></td>
                                                        <td class="t2">
                                                            <label id="mothermobileno">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Parents Address:</span></td>
                                                        <td class="t2">
                                                            <label id="parentsaddress">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for current address details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Current Address
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td><span>Address:</span></td>
                                                        <td>
                                                            <label id="address">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>City:</span></td>
                                                        <td class="t2">
                                                            <label id="city">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>State:</span></td>
                                                        <td class="t2">
                                                            <label id="state">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Country:</span></td>
                                                        <td class="t2">
                                                            <label id="country">--</label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="t1"><span>Mobile No:</span></td>
                                                        <td class="t2">
                                                            <label id="lblphone">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td class="t1"><span>Email ID:</span></td>
                                                        <td class="t2">
                                                            <label id="lblEmail">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Pin Code:</span></td>
                                                        <td class="t2">
                                                            <label id="pincode">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Landmark:</span></td>
                                                        <td class="t2">
                                                            <label id="current_address_landmark">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Employement details===============--%>
                        <div class="col-md-6" style="margin-top: -75px!important">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Employment Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">

                                                <tr>
                                                    <td class="t1"><span>Department:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDept">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Designation:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDesig">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>Branch:</span></td>
                                                    <td class="t2">
                                                        <label id="branch">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Pancard No:</span></td>
                                                    <td class="t2">
                                                        <label id="lblPANCardNo">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>DOJ:</span></td>
                                                    <td class="t2">
                                                        <label id="lblDOJ">--</label>
                                                    </td>
                                                </tr>

                                                <tr>

                                                    <td class="t1"><span>Type of Employement: </span></td>
                                                    <td class="t2">
                                                        <label id="typeofemployement">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Probation Period:</span></td>
                                                    <td class="t2">
                                                        <label id="lblProbation">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Annual CTC:</span></td>
                                                    <td class="t2">
                                                        <label id="annualctc">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>CTC Applied Date:</span></td>
                                                    <td class="t2">
                                                        <label id="CTCappliedfrom">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Inhand Salary: </span></td>
                                                    <td class="t2">
                                                        <label id="inhandsalary">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>TDS Account No: </span></td>
                                                    <td class="t2">
                                                        <label id="tds_account_number">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>PF Account No.: </span></td>
                                                    <td class="t2">
                                                        <label id="pfno">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>ESI Account No.: </span></td>
                                                    <td class="t2">
                                                        <label id="esino">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Office Email ID: </span></td>
                                                    <td class="t2">
                                                        <label id="lblOffemailid">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Managing Director:</span></td>
                                                    <td class="t2">
                                                        <label id="lblHrname">--</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Permanent address details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Permanent Address
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Address:</span></td>
                                                        <td class="t2">
                                                            <label id="lblAddress">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>City:</span></td>
                                                        <td class="t2">
                                                            <label id="lblCity">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>State:</span></td>
                                                        <td class="t2">
                                                            <label id="lblState">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Country:</span></td>
                                                        <td class="t2">
                                                            <label id="lblCountry">--</label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="t1"><span>Pin Code:</span></td>
                                                        <td class="t2">
                                                            <label id="lblPinCode">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td class="t1"><span>Landmark:</span></td>
                                                        <td class="t2">
                                                            <label id="permanent_address_landmark">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Employement History===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Employment History
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Address:</span></td>
                                                        <td class="t2">
                                                            <label id="lblPadd">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>City:</span></td>
                                                        <td class="t2">
                                                            <label id="lblPCity">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>State/Province :</span></td>
                                                        <td class="t2">
                                                            <label id="lblPstate">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Country:</span></td>
                                                        <td class="t2">
                                                            <label id="lblPcountry">--</label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="t1"><span>Pin/Zip Code:</span></td>
                                                        <td class="t2">
                                                            <label id="lblPPindcode">--</label>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="t1"><span>Designation :</span></td>
                                                        <td class="t2">
                                                            <label id="lblPDesignation">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Salary:</span></td>
                                                        <td class="t2">
                                                            <label id="lblSalary">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Experience:</span></td>
                                                        <td class="t2">
                                                            <table>
                                                                <tr>
                                                                    <td>Years</td>
                                                                    <td style="padding-left: 14px">Months</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <label id="lblYears"></label>
                                                                    </td>
                                                                    <td style="padding-left: 14px">
                                                                        <label id="lblMonths"></label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>First Refrence Name :</span></td>
                                                        <td class="t2">
                                                            <label id="lblFirstRefrenceName">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Contact No :</span></td>
                                                        <td class="t2">
                                                            <label id="lblfrefContactNo">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Second Refrence Name:</span></td>
                                                        <td class="t2">
                                                            <label id="lblSecondRefrenceName">--</label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="t1"><span>Contact No. :</span></td>
                                                        <td class="t2">
                                                            <label id="lblContactNo">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Medical Details===============--%>
                        <div class="col-md-6" style="margin-top: -380px!important; top: 0px; left: 1px;">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Medical Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">

                                                <tr>
                                                    <td class="t1"><span>Blood Group :</span></td>
                                                    <td class="t2">
                                                        <label id="lblBloodGroup">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Medical Condition :</span></td>
                                                    <td class="t2">
                                                        <label id="lblMedicalCondition">--</label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="t1"><span>Past Diseases :</span></td>
                                                    <td class="t2">
                                                        <label id="lblPastDiseases">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Genetic Disease :</span></td>
                                                    <td class="t2">
                                                        <label id="lblGeneticDisease">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Any Allergy :</span></td>
                                                    <td class="t2">
                                                        <label id="lblAnyAllergy">--</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Account Details===============--%>
                        <div class="col-md-6" style="margin-top: -30px!important">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 class="form-title form-title-first" style="border-bottom: none!important">
                                            <i class="icon-reorder"></i>
                                            Account Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">

                                                <tr>
                                                    <td class="t1"><span>Bank Name :</span></td>
                                                    <td class="t2">
                                                        <label id="lblBankName">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Account No. :</span></td>
                                                    <td class="t2">
                                                        <label id="lblAccountNo">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Branch Name :</span></td>
                                                    <td class="t2">
                                                        <label id="lblBranchName">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>Branch Code :</span></td>
                                                    <td class="t2">
                                                        <label id="lblBranchCode">--</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="t1"><span>IFSC Code :</span></td>
                                                    <td class="t2">
                                                        <label id="lblIFSCCode">--</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Office Use details===============--%>
                        <div class="col-md-6">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 style="border-bottom: none!important" class="form-title form-title-first">
                                            <i class="icon-reorder"></i>
                                            Office Use Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td class="t1"><span>Bio-Metric Card No.:</span></td>
                                                        <td class="t2">
                                                            <label id="biometricno">--</label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--===============Thid div is for Educational Details===============--%>
                        <div class="col-md-6" style="margin-top: -10px!important; margin-right: 64px; width: 920px">
                            <div class="widget">
                                <div class="widget-content-white glossed">
                                    <div class="padded">
                                        <div class="widget-controls pull-right"></div>
                                        <h3 style="border-bottom: none!important" class="form-title form-title-first">
                                            <i class="icon-reorder"></i>
                                            Educational Details
                                        </h3>
                                        <div class="row" style="margin-top: -25px!important">
                                            <table class="table">

                                                <tr>
                                                    <td>
                                                        <table id="tbl" runat="server" style="border: 0px solid #808080; width: 100%; margin-left: 0px; margin-top: 10px">

                                                            <tr class="trqualification">

                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Qualification</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Board/University</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Passing Year</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Session</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Roll Number</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important">Percentage</td>
                                                                <td class="tdfortrqualification" style="border: 1px solid #CCCCCC!important; width: 30%!important">College/Institute Address</td>
                                                            </tr>

                                                            <tr class="trqualification">
                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="ddlqualification1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtboard1" runat="server" Width="100" Text="na" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification" style="width: 80px!important">
                                                                    <asp:Label ID="txtyear1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtsession1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtrollnumber1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtpercentage1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important"></asp:Label></td>

                                                                <td class="tdfortrqualification">
                                                                    <asp:Label ID="txtinsituteaddress1" runat="server" Width="100" CssClass="eductabletxt" Style="text-transform: none!important">
                                                                    </asp:Label></td>
                                                            </tr>
                                                        </table>
                                                        <asp:Label ID="lblmsg" runat="server" Style="display: block; margin-left: 30px" Text="Currently, no education details available."></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-6"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divProgressBar" class="progress"></div>
</asp:Content>