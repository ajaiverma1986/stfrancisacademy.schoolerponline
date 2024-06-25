<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-hostel-details.aspx.cs" Inherits="BranchPanel_StudentManagement_student_hostel_details" %>

<%@ Register Src="~/BranchPanel/StudentManagement/student-admission-list.ascx" TagPrefix="My" TagName="stu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activestudenthostel {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .dashboard-boxes h3 {
            font-size: 13px !important;
        }
    </style>
    <div class="clear"></div>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Student Hostel Details</h2>
            </div>
            <My:stu runat="server" ID="MyUserInfoBoxControl" />
            <div class="grid-data-resposive">
            
            <input type="submit" class="button_save AddStudentTOtransport" value="Add Student" style="float: right" />

            <div id="ShowDetails" style="display: none; height:400px">
                <div class="for_sigle_row_form" style="margin-left: 200px;">
                    <input type="submit" class="button_save SubmitTransport" value="Submit" />
                    <%-- <input type="submit" class="button_cancel CancelTransport" value="Cancel"/>--%>
                    <input type="submit" class="button_cancel BackTransport" value="Back" />
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Hostel<span style="color: Red; font-weight: bold">*</span></label>
                    <select id="ddlHostel"></select>
                </div>
                 <div class="for_sigle_row_form">
                    <label>Select Fee<span style="color: Red; font-weight: bold">*</span></label>
                    <select id="ddlHostelFee"></select>
                </div>
                <div class="for_sigle_row_form">
                    <label>Date</label>
                    <input type="text" id="txtdate" onkeypress="return false" placeholder="Enter Date Please" />
                </div>
                <div class="for_sigle_row_form" id="MontList">
                    <div class="col-sm-3">
                        <asp:CheckBox ID="allck" runat="server" Text="Select All" /><br />
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                            <asp:ListItem Value="4" Text="April" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="5" Text="May" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="6" Text="June" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="7" Text="July" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="8" Text="August" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="9" Text="September" Enabled="false"></asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                    <div class="col-sm-3">
                        <asp:CheckBoxList ID="CheckBoxList2" runat="server">
                            <asp:ListItem Value="10" Text="October" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="11" Text="November" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="12" Text="December" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="1" Text="January" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="2" Text="February" Enabled="false"></asp:ListItem>
                            <asp:ListItem Value="3" Text="March" Enabled="false"></asp:ListItem>
                        </asp:CheckBoxList>
                    </div>                    
                </div>
                <div style=" float: right; top: 235px; position: absolute; margin: 0 0 0 600px;">
                    <div class="for_sigle_row_form" style="margin-right: 30px;">
                        <label>Select Month Name<span style="color: Red; font-weight: bold">*</span></label>
                        <select id="ddlMonth">
                            <option value="0">Select Month</option>
                            <option value="4">April</option>
                            <option value="5">May</option>
                            <option value="6">June</option>
                            <option value="7">July</option>
                            <option value="8">Auguest</option>
                            <option value="9">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                            <option value="1">January</option>
                            <option value="2">Feburary</option>
                            <option value="3">March</option>
                        </select>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <table id="GrdPayNow" class="stm" cellspacing="0" cellpadding="5" border="0" style="width: 100%; border-collapse: collapse;">
                            <tbody>
                                <tr class="stm_head" align="center">
                                    <th align="center" scope="col">S.No</th>
                                    <th align="center" scope="col">Fee Name</th>
                                    <th align="center" scope="col">Fee Amoun (₹)</th>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div id="divProgressBar" class="progress"></div>
            </div>
    </div>
            <div class="divforstm BindStuVehicleInfo" style="width: 100%; display: none">
                <table class="stm BindStuToVehicle" style="width: 100%; margin-right: 200px;">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col">S.No.</th>
                        <th align="center" scope="col">HostelName</th>
                        <th align="center" scope="col">Added Date</th>
                        <th align="center" scope="col">Status</th>
                        <th align="center" scope="col">Edit</th>
                    </tr>
                </table>
            </div>
    <script type="text/javascript">
        var HostelID = 0, changecityid = 0, HTSID=0, changeareaid = 0, ChangeBlockiId = 0, ChangeRoadID = 0, VehicleRouteMapID = 0, ChangeRouteID = 0, RouteId = 0, TransportIDofStu = 0, AddupdateMode = 0;
        $(document).ready(function () {
            checkTransportOfStd();
            $('#GrdPayNow').hide();
            $('#MontList').hide();
            $('.AddStudentTOtransport').click(function () {
                AddupdateMode = 7, TransportIDofStu = 0;
                $('#ShowDetails').show(500)
                $('.AddStudentTOtransport').hide(500)
                $('.BindStuVehicleInfo').hide(500);
                $('#txtdate').val('');
                $('#GrdPayNow').show();
                $('#MontList').show();
                BindHostel();
                BindHostelFEE();
                //GetHostelFee();
                Check_Unchecked(0, 0);
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_allck").click(function () {
                if ($(this).is(":checked")) {
                    $("#<%= CheckBoxList1.ClientID %> input:checkbox").each(function () {
                        if (!$(this).is(":disabled")) {
                            $(this).prop("checked", true);
                        }
                    })
                    $("#<%= CheckBoxList2.ClientID %> input:checkbox").each(function () {
                        if (!$(this).is(":disabled")) {
                            $(this).prop("checked", true);
                        }
                    });
                }
                else if ($(this).is(":not(:checked)")) {
                    $("#<%= CheckBoxList1.ClientID %> input:checkbox").each(function () {
                        if (!$(this).is(":disabled")) {
                            $(this).prop("checked", false);
                        }
                    })
                    $("#<%= CheckBoxList2.ClientID %> input:checkbox").each(function () {
                        if (!$(this).is(":disabled")) {
                            $(this).prop("checked", false);
                        }
                    })
                    //$('#GrdPayNow').find('tr').each(function () {
                    //    var row = $(this);
                    //    row.find('input[type="checkbox"]').prop('checked', false);
                    //});
                }
            });
            $('#ddlMonth').change(function () {
                MonthID = $(this).val();
                if (MonthID) {                  
                    GetHostelFee(MonthID);
                }
                else {
                    alertify('No Record Found');
                }
                return false;
            });
            $('#ddlHostelFee').change(function () {
                FeeID = $(this).val();                
                if (FeeID) {
                    $('#BindStuToVehicle').show();
                    Empty();                   
                    BindtxtFieldStuGridByFeeID(FeeID);
                    Check_UncheckedByFeeID(FeeID);                                      
                }
                else {
                    $('#BindStuToVehicle').hide();
                    alertify('No Record Found');
                }
                return false;
            });
            $('.SubmitTransport').click(function () {
                if ($('#ddlHostel').val() == '0') {
                    alertify.error("Please Select Hostel Name")
                    return false;
                }
                if ($('#ddlHostelFee').val() == '0') {
                    alertify.error("Please Select Hostel Fee Name")
                    return false;
                }
                if ($('#txtdate').val() == '') {
                    alertify.error("Please Enter Date")
                    return false;
                }
                else {
                    SaveHostelForStudent();
                    BindStuGrid();
                    return false;
                }
            });
            $("#txtdate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "dd MM yy"
            });
            $('.ImgforeditStuTrans').live('click', function () {               
                $('.AddStudentTOtransport').hide(500);
                TransportIDofStu = $(this).parent('td').find('input[id*=StuTransID]').val();
                Check_Status(TransportIDofStu);
                Empty();
                return false;
            });
            $('.BackTransport').click(function () {
                $('#ShowDetails').hide(500);
                $('.BindStuVehicleInfo').show(500);
                $('.AddStudentTOtransport').hide(500);
                ChangeRouteID = 0;
                return false;
            });
            $('.statusactive').live('click', function () {
                var Status = 0;
                var changestatus = $(this).parent('td').parent('tr').find('input[id*=idfirst]').val();
                var Stureg = $(this).parent('td').parent('tr').find('input[id*=StuRegID]').val();
                TransportIDofStu = $(this).parent('td').parent('tr').find('input[id*=StuTransID]').val();
                if (changestatus == 1) {
                    var confirmstatus = confirm('Are You Sure You Want To Deactivate?');
                    Status = 0;
                }
                if (changestatus == 0) {
                    var confirmstatus = confirm('Are You Sure You Want To Activate?');
                    Status = 1;
                }
                if (confirmstatus == true) {
                    chngstatus(Status, Stureg, TransportIDofStu);
                    BindStuGrid();
                }
                return false;
            });
            return false;
        });
        function BindStuGrid() {
            var trforappend = "";
            $('.BindStuToVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/BindGridByTransportStudent",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    //GetHostelFee();
                    if (data.d.length > 0) {
                        $('.BindStuVehicleInfo').show(500)
                        $('.AddStudentTOtransport').show(500);
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].HostelName + '</td><td>' + data.d[i].AddedDate + '</td><td><input class="statusactive" style="width:18px;" type="image" alt=""  src="' + data.d[i].activestatus + ' " /><input id="idfirst" type="hidden" value="' + data.d[i].status + '"/></td><td><img class="ImgforeditStuTrans" style="cursor:pointer" src="../../images/edit.png"><input id="StuRegID" type="hidden" value="' + data.d[i].StuRegNo + '"/><input id="StuTransID" type="hidden" value="' + data.d[i].StuTransPortId + '"/></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].HostelName + '</td><td>' + data.d[i].AddedDate + '</td><td><input class="statusactive" style="width:18px;" type="image" alt=""  src="' + data.d[i].activestatus + ' " /><input id="idfirst" type="hidden" value="' + data.d[i].status + '"/></td><td><img class="ImgforeditStuTrans" style="cursor:pointer" src="../../images/edit.png"><input id="StuRegID" type="hidden" value="' + data.d[i].StuRegNo + '"/><input id="StuTransID" type="hidden" value="' + data.d[i].StuTransPortId + '"/></td></tr>';
                            $('.BindStuToVehicle').append(trforappend);
                        }
                        $('.AddStudentTOtransport').hide(500);
                        call_progressbar("end");
                    }
                    else {
                        $('.BindStuVehicleInfo').hide(500)
                        $('.AddStudentTOtransport').show(500);
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function Check_Status(HostelIDofStu) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/CheckStatus",
                data: "{'HostelIDofStu':'" + HostelIDofStu + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        $('#ShowDetails').show(500);
                        $('.BindStuVehicleInfo').hide(500);
                        $('.CancelTransport').hide(500);
                        $('.AddStudentTOtransport').hide(500);
                        BindtxtFieldStuGrid();
                        //GetHostelFee();
                        Check_Unchecked(0, HostelIDofStu);
                    }
                    else {
                        alertify.error('This is Deactivated !! Please Activate it First.. ');
                    }
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function sopop() {
            AddupdateMode = 7
            changecityid = 0, changeareaid = 0, ChangeBlockiId = 0, ChangeRoadID = 0, TransportIDofStu = 0;
            $('#ShowDetails').show(500)
            $('.AddStudentTOtransport').hide(500)
            $('.BindStuVehicleInfo').hide(500);
            $('#txtdate').val('');
            BindGrid()
            BindHostel()
            Check_Unchecked(0, 0);
            return false;
        }
        function GetHostelFee(MonthID) {
            var trforappend = '';
            $.ajax({
                type: "POST",
                url: "student-Hostel-details.aspx/GetHostelFee",
                data: "{'MonthID':'" + MonthID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('#GrdPayNow').show();
                    $('#GrdPayNow tbody').find('tr:gt(0)').remove();
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    var i = 0, Class = "";
                    TableGeneralDetails.each(function () {
                        var CurrentDeailsRow = $(this);
                        if (i % 2 == 0)
                            Class = "stm_dark";
                        else
                            Class = "stm_light";
                        trforappend = trforappend + '<tr class=' + Class + '>'
                          + '<td><input type="hidden" value=' + CurrentDeailsRow.find("HostelFeeID").text() + ' />' + (i+1) + '</td>'
                          + '<td>' + CurrentDeailsRow.find("HostelFeeName").text() + '</td>'
                          + '<td>' + CurrentDeailsRow.find("HostelFeeAmt").text() + '</td>'                         
                          //+ '<td><input class="ImgBtnForPayNow" type="checkbox" ' + GetStatus(CurrentDeailsRow.find("InstallmentAmount").text()) + ' title="Check Here For Pay Fee Now." /></td>'                         
                        '</tr>'
                        i = i + 1;
                    });
                    $('#GrdPayNow tbody').append(trforappend);
                },
                error: function (response) {
                    alertify.error('Unable To Access Server. If Internet Connectivity Has Gone Then You Need Not To Worry.');
                }
            });
        }
        function GetStatus(str) {
            if (str == "0") {
                return "disabled";
            }
        }
        function checkTransportOfStd() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/CheckHostelOfStd",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        $('.AddStudentTOtransport').show(500);
                       BindStuGrid();
                    }
                    else {
                        if (confirm('Sorry, You have not take Hostel Facility. Do you want take Hostel ?')) {
                            window.location.replace('student-profile-details.aspx')
                        }
                        //else {
                        //    alert('Why did you press cancel? You should have confirmed');
                        //}
                        $('.AddStudentTOtransport').hide();
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Check_UncheckedByFeeID(FeeID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/Check_UncheckedByFeeID",
                data: "{'FeeID':'" + FeeID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $("#<%= CheckBoxList1.ClientID %> input:checkbox").each(function () {
                                var MonthName = $('label[for=' + this.id + ']').html();
                                var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                                if (parseInt(MonthNo) == parseInt(data.d[i]["InstallmentDate"])) {
                                    var values1 = $(this).prop("disabled", true);
                                }
                            })
                            $("#<%= CheckBoxList2.ClientID %> input:checkbox").each(function () {
                                var MonthName = $('label[for=' + this.id + ']').html();
                                var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                                if (parseInt(MonthNo) == parseInt(data.d[i]["InstallmentDate"])) {
                                    var values1 = $(this).prop("disabled", true);
                                }
                            })
                        }
                    }
                    else {
                        Empty();
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Check_Unchecked(HostelID, HTSID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/CheckUnchecked",
                data: "{'HostelID':'" + HostelID + "','HTSID':'" + HTSID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $("#<%= CheckBoxList1.ClientID %> input:checkbox").each(function () {
                                var MonthName = $('label[for=' + this.id + ']').html();
                                var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                                if (parseInt(MonthNo) == parseInt(data.d[i]["InstallmentDate"])) {
                                    var values1 = $(this).prop("disabled", true);
                                }
                                else {
                                    var values1 = $(this).prop("disabled", false);
                                }
                            })
                            $("#<%= CheckBoxList2.ClientID %> input:checkbox").each(function () {
                                var MonthName = $('label[for=' + this.id + ']').html();
                                var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                                if (parseInt(MonthNo) == parseInt(data.d[i]["InstallmentDate"])) {
                                    var values1 = $(this).prop("disabled", true);
                                }
                                else {
                                    var values1 = $(this).prop("disabled", false);
                                }
                            })
                        }
                    }
                    else
                    {
                        Empty();
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Empty()
        {
            var checked_checkboxes2 = $("[id*=CheckBoxList2] input");

            checked_checkboxes2.each(function () {
                $(this).attr("checked", false);
                $(this).attr("disabled", false);
            });
            var checked_checkboxes = $("[id*=CheckBoxList1] input");

            checked_checkboxes.each(function () {
                $(this).attr("checked", false);
                $(this).attr("disabled", false);
            });
        }
        function BindGrid() {
            var trforappend = "";
            $('.BindVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/BindGridByjsTransportForStudent",
                data: "{'ChangeRouteID':'" + ChangeRouteID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].VEHICLEREGNO + '</td><td>' + data.d[i].VEHICLETYPE + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].NUMBEROFSEATS + '</td><td>' + data.d[i].AvailableSeats + '</td><td><input id="VehicleRoutMapID" type="hidden" value="' + data.d[i].vehicleroutemapid + '"/><input type="radio" class="radioset" name="Vehicleschedule"><input id="VehicleRegID" type="hidden" value="' + data.d[i].vehicleId + '"/></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].VEHICLEREGNO + '</td><td>' + data.d[i].VEHICLETYPE + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].NUMBEROFSEATS + '</td><td>' + data.d[i].AvailableSeats + '</td><td><input id="VehicleRoutMapID" type="hidden" value="' + data.d[i].vehicleroutemapid + '"/><input type="radio" class="radioset" name="Vehicleschedule"><input id="VehicleRegID" type="hidden" value="' + data.d[i].vehicleId + '"/></td></tr>';
                            $('.BindVehicle').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }     
        function BindtxtFieldStuGridByFeeID(FeeID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/BindtxtHostelStudentByFeeID",
                data: "{'FeeID':'" + FeeID + "','HostelID':'0'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {                                                     
                            $("#MontList").show();

                            var MonthList = data.d[i].MonthList;
                            var newchar = ','
                            mystring = MonthList.split('~').join(newchar);
                            var arlene1 = [];
                            arlene1 = mystring.split(',');

                            if (arlene1.length > 0) {
                                var checked_checkboxes2 = $("[id*=CheckBoxList2] input");

                                checked_checkboxes2.each(function () {
                                    var status1 = 0;
                                    var message1 = $(this).closest("td").find("label").html();
                                    var gt1 = new Date(message1 + '-1-01').getMonth() + 1;
                                    for (var j = 0; j < arlene1.length; j++) {
                                        if (parseInt(gt1) == parseInt(arlene1[j])) {
                                            status1 = 1;
                                        }
                                    }
                                    if (status1 == 1) {
                                        $(this).attr("checked", true);
                                    }
                                });


                                var checked_checkboxes = $("[id*=CheckBoxList1] input");

                                checked_checkboxes.each(function () {
                                    var status = 0;
                                    var message = $(this).closest("td").find("label").html();
                                    var gt = new Date(message + '-1-01').getMonth() + 1;
                                    for (var i = 0; i < arlene1.length; i++) {
                                        if (parseInt(gt) == parseInt(arlene1[i])) {
                                            status = 1;
                                        }
                                    }
                                    if (status == 1) {
                                        $(this).attr("checked", true);
                                    }
                                });
                            }
                        }
                        call_progressbar("end");
                    }
                    else {

                        //$('#GrdPayNow').find('tr').each(function () {
                        //    var row = $(this);
                        //        row.find('input[type="checkbox"]').prop('checked', false);
                        //});

                        var checked_checkboxes2 = $("[id*=CheckBoxList2] input");

                        checked_checkboxes2.each(function () {
                            $(this).attr("checked", false);
                            $(this).attr("disabled", false);
                        });

                        var checked_checkboxes = $("[id*=CheckBoxList1] input");

                        checked_checkboxes.each(function () {
                            $(this).attr("checked", false);
                            $(this).attr("disabled", false);
                        });
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function BindtxtFieldStuGrid() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/BindtxtHostelStudent",
                data: "{'HostelIDofStu':'" + TransportIDofStu + "','HostelID':'0'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            BindHostel();
                            BindHostelFEE();
                            Empty();

                            $('#ddlHostel').val(data.d[i].HostelID)
                            // $('#ddlHostel').trigger('change');                          
                            $('#txtdate').val(data.d[i].AddedDate);
                            //$("#MontList").show();

                            //var MonthList = data.d[i].MonthList;
                            //var newchar = ','
                            //mystring = MonthList.split('~').join(newchar);
                            //var arlene1 = [];
                            //arlene1 = mystring.split(',');

                            //if (arlene1.length > 0) {
                            //    var checked_checkboxes2 = $("[id*=CheckBoxList2] input");

                            //    checked_checkboxes2.each(function () {
                            //        var status1 = 0;
                            //        var message1 = $(this).closest("td").find("label").html();
                            //        var gt1 = new Date(message1 + '-1-01').getMonth() + 1;
                            //        for (var j = 0; j < arlene1.length; j++) {
                            //            if (parseInt(gt1) == parseInt(arlene1[j])) {
                            //                status1 = 1;
                            //            }
                            //        }
                            //        if (status1 == 1) {
                            //            $(this).attr("checked", true);
                            //        }
                            //    });


                            //    var checked_checkboxes = $("[id*=CheckBoxList1] input");

                            //    checked_checkboxes.each(function () {
                            //        var status = 0;
                            //        var message = $(this).closest("td").find("label").html();
                            //        var gt = new Date(message + '-1-01').getMonth() + 1;
                            //        for (var i = 0; i < arlene1.length; i++) {
                            //            if (parseInt(gt) == parseInt(arlene1[i])) {
                            //                status = 1;
                            //            }
                            //        }
                            //        if (status == 1) {
                            //            $(this).attr("checked", true);
                            //        }
                            //    });
                            //}

                            //var FeeMonthList = data.d[i].FeeList;
                            //var Feenewchar = ','
                            //var Feemystring = FeeMonthList.split('~').join(Feenewchar);
                            //var Feearlene1 = [];
                            //Feearlene1 = Feemystring.split(',');

                            //GetHostelFee();

                            //for (var i = 0; i < Feearlene1.length; i++) {
                            //    $('#GrdPayNow').find('tr').each(function () {
                            //        var row = $(this);
                            //        if (parseInt(row.find('input[type="hidden"]').val()) == parseInt(Feearlene1[i])) {
                            //            row.find('input[type="checkbox"]').prop('checked', true);
                            //        }
                            //    });
                            //}

                            //if (data.d[i].vehicleroutemapid > 0) {
                            //    $('.BindVehicle tbody').find('tr:gt(0)').find('input[type="hidden"][id="VehicleRoutMapID"][value="' + data.d[i].vehicleroutemapid + '"]').parent('td').find("input:radio[name=Vehicleschedule]").attr('checked', true);
                            //}
                            //else {
                            //    $("input:radio[name=Vehicleschedule]").attr('checked', false)
                            //}
                        }
                        call_progressbar("end");
                    }
                    else {

                        //$('#GrdPayNow').find('tr').each(function () {
                        //    var row = $(this);
                        //        row.find('input[type="checkbox"]').prop('checked', false);
                        //});

                        var checked_checkboxes2 = $("[id*=CheckBoxList2] input");

                        checked_checkboxes2.each(function () {                           
                            $(this).attr("checked", false);
                            $(this).attr("disabled", false);
                        });

                        var checked_checkboxes = $("[id*=CheckBoxList1] input");

                        checked_checkboxes.each(function () {
                            $(this).attr("checked", false);
                            $(this).attr("disabled", false);
                        });                        
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function SaveHostelForStudent() {
            var values = '';
            var date = new Date();
            var m = (new Date).getMonth() + 1;

            $("#<%= CheckBoxList1.ClientID %> input:checkbox:checked").each(function () {
                var values1 = $('label[for=' + this.id + ']').html();
                if (!$(this).is(":disabled")) {
                    if (values1 == 'April') {
                        values1 = 4;
                    }
                    if (values1 == 'May') {
                        values1 = 5;
                    }
                    if (values1 == 'June') {
                        values1 = 6;
                    }
                    if (values1 == 'July') {
                        values1 = 7;
                    }
                    if (values1 == 'August') {
                        values1 = 8;
                    }
                    if (values1 == 'September') {
                        values1 = 9;
                    }

                    if (values == '') {
                        values = values1;
                    }
                    else {
                        values = values + "~" + values1;
                    }
                }
            });

            $("#<%= CheckBoxList2.ClientID %> input:checkbox:checked").each(function () {
                var values2 = $('label[for=' + this.id + ']').html();

                if (!$(this).is(":disabled")) {
                    if (values2 == 'October') {
                        values2 = 10;
                    }
                    if (values2 == 'November') {
                        values2 = 11;
                    }
                    if (values2 == 'December') {
                        values2 = 12;
                    }
                    if (values2 == 'January') {
                        values2 = 1;
                    }
                    if (values2 == 'February') {
                        values2 = 2;
                    }
                    if (values2 == 'March') {
                        values2 = 3;
                    }
                    if (values == '') {
                        values = values2;
                    }
                    else {
                        values = values + "~" + values2;
                    }
                }
            });
            if (values == '') {
                alertify.error('Please Select Atleast One Month for take Hostel.')
                return false;
            }
            //var FeeIDs = '0';
            //$('#GrdPayNow').find('tr').each(function () {
            //    var row = $(this);
            //    if (row.find('input[type="hidden"]').val() != undefined) {
            //        if (FeeIDs == 0) {
            //            FeeIDs = row.find('input[type="hidden"]').val();
            //        }
            //        else {
            //            FeeIDs = FeeIDs + '~' + row.find('input[type="hidden"]').val();
            //        }
            //    }
            //});

            //if (FeeIDs == '0') {
            //    alertify.error('Please Select Atleast Fee Type.')
            //    return false;
            //}
            
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Hostel-details.aspx/SaveHostelStudent",
                data: "{'AddedDate':'" + $('#txtdate').val() + "','MonthList':'" + values + "','HostelID':'" + $('#ddlHostel').val() + "','FeeID':'" + $('#ddlHostelFee').val() + "','HTSID':'" + TransportIDofStu + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Submit Successfully");                       
                        $('#ShowDetails').hide(500);
                        $('.BindStuVehicleInfo').show(500);
                        $('.AddStudentTOtransport').hide(500);
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        alertify.success("Update Successfully");                      
                        $('#ShowDetails').hide(500);
                        $('.BindStuVehicleInfo').show(500);
                        $('.AddStudentTOtransport').hide(500);
                        call_progressbar("end");
                    }
                    if (data.d == 5) {
                        if (confirm('Sorry, You have not Set Hostel Fee. Do you want take Hostel ?')) {
                            window.location.replace('../MasterUC/mst_Hostel.aspx')
                        }
                    }                   
                    $('#ShowDetails').hide(500);
                    $('.BindStuVehicleInfo').show(500);
                    $('.AddStudentTOtransport').hide(500);
                    call_progressbar("end");
                   
                    TransportIDofStu = 0;
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    alert('error')
                    call_progressbar("end");
                }
            });
        }
        function BindHostel() {
            //call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-hostel-details.aspx/ddlHostel",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlHostel").html("");
                    $.each(data.d, function (key, value) {
                        if (value.HostelName != null) {
                            $("#ddlHostel").append($("<option></option>").val(value.HostelID).html(value.HostelName));
                        }
                    });
                    //call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function BindHostelFEE() {
            //call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-hostel-details.aspx/ddlHostelFee",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlHostelFee").html("");
                    $.each(data.d, function (key, value) {
                        if (value.HostelNameFee != null) {
                            $("#ddlHostelFee").append($("<option></option>").val(value.HostelFeeID).html(value.HostelNameFee));
                        }
                    });
                    //call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function chngstatus(changestatus, Stureg, TransportIDofStu) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-hostel-details.aspx/updatestatus",
                data: "{'changestatus':'" + changestatus + "','Stureg':'" + Stureg + "','TransportIDofStu':'" + TransportIDofStu + "'}",
                dataType: "json",
                success: function (data) {
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    alertify.error("Some Network Problem");
                    return false;
                }
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
    </script>
        </div>
    </div>
   
</asp:Content>

