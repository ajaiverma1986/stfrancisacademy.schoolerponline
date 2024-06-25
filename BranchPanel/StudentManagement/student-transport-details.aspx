<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-transport-details.aspx.cs" Inherits="BranchPanel_StudentManagement_student_transport_details" %>

<%@ Register Src="~/BranchPanel/StudentManagement/student-admission-list.ascx" TagPrefix="My" TagName="stu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activestudenttransport {
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
                <h2>Student Transport Details</h2>
            </div>
            <My:stu runat="server" ID="MyUserInfoBoxControl" />
            <div class="grid-data-resposive">
            </div>
            <input type="submit" class="button_save AddStudentTOtransport" value="Add Student" style="float: right" />
        </div>
    </div>
    <div id="ShowDetails" style="display: none">
        <div class="for_sigle_row_form">
            <label>Select Amount<span style="color: Red; font-weight: bold">*</span></label>
             <asp:DropDownList ID="ddlfyear" runat="server" Height="31px">     
            </asp:DropDownList>  
        </div>

        <div class="for_sigle_row_form">
            <label>Select Amount<span style="color: Red; font-weight: bold">*</span></label>
            <select id="ddlroute"></select>
        </div>
        <div class="for_sigle_row_form" style="display:none">
            <label>Select City<span style="color: Red; font-weight: bold">*</span></label>
            <select id="ddlcity"></select>
        </div>
        <div class="for_sigle_row_form" style="display:none">
            <label>Select Area</label>
            <select id="ddlarea"></select>
        </div>
        <div class="for_sigle_row_form" style="display:none">
            <label>Select Block</label>
            <select id="ddlblock"></select>
        </div>
        <div class="for_sigle_row_form" style="display:none">
            <label>Select Road</label>
            <select id="ddlroad"></select>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Trip</label>
            <select id="ddlstoppage"></select>
        </div>
         <div class="for_sigle_row_form">
            <label>Stoppage</label>
            <input type="text" id="txtStoppage" placeholder="Enter Stoppage" />
        </div>
        <div class="for_sigle_row_form">
            <label>Date</label>
            <input type="text" id="txtdate" onkeypress="return false" placeholder="Enter Date Please" />
        </div>
        <div class="for_sigle_row_form">
            <div class="col-sm-2">
                <asp:CheckBox ID="allck" runat="server" Text="Select All" /><br />
                <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                    <asp:ListItem Value="4" Text="April"></asp:ListItem>
                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                    <asp:ListItem Value="6" Text="June"></asp:ListItem>
                    <asp:ListItem Value="7" Text="July"></asp:ListItem>
                    <asp:ListItem Value="8" Text="August"></asp:ListItem>
                    <asp:ListItem Value="9" Text="September"></asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div class="col-sm-1">
                <br />
                <input type="text" id="txtFee4" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee5" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee6" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee7" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee8" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee9" style="width: 100%" class="numberOnly" maxlength="4" />
            </div>
            <div class="col-sm-2">
                <asp:CheckBoxList ID="CheckBoxList2" runat="server">
                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                    <asp:ListItem Value="1" Text="January"></asp:ListItem>
                    <asp:ListItem Value="2" Text="February"></asp:ListItem>
                    <asp:ListItem Value="3" Text="March"></asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div class="col-sm-1">

                <input type="text" id="txtFee10" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee11" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee12" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee1" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee2" style="width: 100%" class="numberOnly" maxlength="4" />
                <input type="text" id="txtFee3" style="width: 100%" class="numberOnly" maxlength="4" />
            </div>
        </div>
        <div class="divforstm BindVehicleInfo" style="width: 100%;">
            <table class="stm BindVehicle" style="width: 100%; margin-right: 200px;">
                <tr class="stm_head" align="center">
                    <th align="center" scope="col">S.No.</th>
                    <th align="center" scope="col">Vehicle Reg.</th>
                    <th align="center" scope="col">Vehicle Type</th>
                    <th align="center" scope="col">Source</th>
                    <th align="center" scope="col">Destination</th>
                    <th align="center" scope="col">Vehicle Time</th>
                    <th align="center" scope="col">Total Seats</th>
                    <th align="center" scope="col">Available Seats</th>
                    <th align="center" scope="col">Select</th>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form" style="margin-left: 200px;">
            <input type="submit" class="button_save SubmitTransport" value="Submit" />
            <%-- <input type="submit" class="button_cancel CancelTransport" value="Cancel"/>--%>
            <input type="submit" class="button_cancel BackTransport" value="Back" />
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <div class="divforstm BindStuVehicleInfo" style="width: 100%; display: none">
        <table class="stm BindStuToVehicle" style="width: 100%; margin-right: 200px;">
            <tr class="stm_head" align="center">
                <th align="center" scope="col">S.No.</th>
                <th align="center" scope="col">Vehicle Reg.</th>
                <th align="center" scope="col">Route</th>
                <th align="center" scope="col">Source</th>
                <th align="center" scope="col">Destination</th>                
                <th align="center" scope="col">Stoppage</th>
                <th align="center" scope="col">Trip</th>
                <th align="center" scope="col">Added Date</th>
                <th align="center" scope="col">Vehicle Time</th>
                <th align="center" scope="col">Status</th>
                <th align="center" scope="col">Change Status</th>
                <th align="center" scope="col">Edit</th>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var changecityid = 0, changeareaid = 0, ChangeBlockiId = 0, ChangeRoadID = 0, VehicleRouteMapID = 0, ChangeRouteID = 0, RouteId = 0, TransportIDofStu = 0, AddupdateMode = 0,Fyid = 0;
        $(document).ready(function () {

            $(".numberOnly").keypress(function (e) {
                //if the letter is not digit then display error and don't type anything
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    //display error message
                    $("#errmsg").html("Digits Only").show().fadeOut("slow");
                    return false;
                }
            });

            checkTransportOfStd();
            $('.AddStudentTOtransport').click(function () {
                AddupdateMode = 7
                changecityid = 0, changeareaid = 0, ChangeBlockiId = 0, ChangeRoadID = 0, TransportIDofStu = 0;
                $('#txtStoppage').val('');
                $('#ShowDetails').show(500)
                $('.AddStudentTOtransport').hide(500)
                $('.BindStuVehicleInfo').hide(500);
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                $('#txtdate').val('');
                BindGrid()
                BindRoute()
               // Check_Unchecked();
                return false;
            });
            $('#ddlcity').change(function () {
                changecityid = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                return false;
            });
            $('#ddlarea').change(function () {
                changeareaid = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                return false;
            });
            $('#ddlblock').change(function () {
                ChangeBlockiId = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                return false;
            });
            $('#ddlroad').change(function () {
                ChangeRoadID = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                return false;
            });
            $('.radioset').live('change', function () {
                VehicleRouteMapID = $(this).parent('td').parent('tr').find('input[id*=VehicleRoutMapID]').val();
                VehicleRegID = $(this).parent('td').parent('tr').find('input[id*=VehicleRegID]').val();
                return false;
            });
            $('#ddlroute').change(function () {
                for (var i = 1; i <= 12; i++) {
                    $('#txtFee' + i.toString()).val($('#ddlroute option:selected').text());
                }
                debugger;
                ChangeRouteID = $(this).val();
                RouteId = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID);
                BindGrid();

                return false;
            });
            $('.SubmitTransport').click(function () {
                if ($('#ddlroute').val() == '0') {
                    alertify.error("Please Select Amount")
                    return false;
                }
                if ($('#ddlcity').val() != '0') {
                    alertify.error("Please Select City")
                    return false;
                }
                else {
                    SaveTransportForStudent()
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
                AddupdateMode = 10;
                TransportIDofStu = $(this).parent('td').find('input[id*=StuTransID]').val();
                $('#ShowDetails').show(500);
                $('.BindStuVehicleInfo').hide(500);
                $('.CancelTransport').hide(500);
                $('.AddStudentTOtransport').hide(500);
                BindtxtFieldStuGrid()
              //  Check_Unchecked();
                return false;
            });
            $('.BackTransport').click(function () {
                $('#ShowDetails').hide(500);
                $('.BindStuVehicleInfo').show(500);
                $('.AddStudentTOtransport').show(500);
                ChangeRouteID = 0;
                return false;
            });
            $('.statusactive').live('click', function () {
                var changestatus = $(this).parent('td').parent('tr').find('input[id*=idfirst]').val();
                var Stureg = $(this).parent('td').parent('tr').find('input[id*=StuRegID]').val();
                TransportIDofStu = $(this).parent('td').parent('tr').find('input[id*=StuTransID]').val();
                if (changestatus == 1) {
                    var confirmstatus = confirm('Are You Sure You Want To Deactivate?');
                }
                if (changestatus == 0) {
                    var confirmstatus = confirm('Are You Sure You Want To Activate?');
                }
                if (confirmstatus == true) {
                    chngstatus(changestatus, Stureg, TransportIDofStu)
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_allck').click(function () {
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
                    })
                }
                else {
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
                }
            });
        });
        function sopop() {
            AddupdateMode = 7
            changecityid = 0, changeareaid = 0, ChangeBlockiId = 0, ChangeRoadID = 0, TransportIDofStu = 0;
            $('#ShowDetails').show(500)
            $('.AddStudentTOtransport').hide(500)
            $('.BindStuVehicleInfo').hide(500);
            Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
            $('#txtdate').val('');
            BindGrid()
            BindRoute()
         //   Check_Unchecked();
            return false;
        }
        function checkTransportOfStd() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/CheckTransOfStd",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        $('.AddStudentTOtransport').show(500);
                        BindStuGrid();
                    }
                    else {
                        if (confirm('Sorry, You have not take Transport Facility. Do you want take transport ?')) {
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
        function Check_Unchecked() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/CheckUnchecked",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        //for (var i = 0; i < data.d.length; i++) {
                        $("#<%= CheckBoxList1.ClientID %> input:checkbox").each(function () {
                            var MonthName = $('label[for=' + this.id + ']').html();
                            var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                            var isExistsInMontList = findValueInArray(MonthNo, data.d);
                            if (isExistsInMontList) {
                                $(this).prop("disabled", true);
                            }
                        })
                        $("#<%= CheckBoxList2.ClientID %> input:checkbox").each(function () {
                            var MonthName = $('label[for=' + this.id + ']').html();
                            var MonthNo = new Date(MonthName + '-1-01').getMonth() + 1;
                            var isExistsInMontList = findValueInArray(MonthNo, data.d);
                            if (isExistsInMontList) {
                                $(this).prop("disabled", true);
                            }
                        })
                        //   }
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }

        function findValueInArray(value, arr, MonthNo) {      
            var result = false;
            for (var i = 0; i < arr.length; i++) {
                var name = parseInt(arr[i]["InstallmentDate"]);
                if (name == parseInt(value)) {
                    result = true;
                    break;
                }
            }
            return result;
        }

        function Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/BindDDLOFAddRoadTransport",
                data: "{'changecityid':'" + changecityid + "','changeareaid':'" + changeareaid + "','ChangeBlockiId':'" + ChangeBlockiId + "','ChangeRoadID':'" + ChangeRoadID + "','RouteId':'" + RouteId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlcity").html("");
                    $("#ddlarea").html("");
                    $("#ddlblock").html("");
                    $("#ddlroad").html("");
                    $("#ddlstoppage").html("");
                    $.each(data.d, function (key, value) {
                        if (value.zonename != null) {
                            $("#ddlcity").append($("<option></option>").val(value.zoneid).html(value.zonename));
                        }
                        if (value.areaname != null) {
                            $("#ddlarea").append($("<option></option>").val(value.areaid).html(value.areaname));
                        }
                        if (value.BlockName != null) {
                            $("#ddlblock").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                        }
                        if (value.roadname != null) {
                            $("#ddlroad").append($("<option></option>").val(value.roadid).html(value.roadname));
                        }
                        if (value.StoppageName != null) {
                            $("#ddlstoppage").append($("<option></option>").val(value.StoppageID).html(value.StoppageName));
                        }
                    });
                    $("#ddlcity").val(changecityid);
                    $("#ddlarea").val(changeareaid)
                    $("#ddlblock").val(ChangeBlockiId)
                    $("#ddlroad").val(ChangeRoadID)
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
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
                    debugger;
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
        function BindStuGrid() {
            var trforappend = "";
            $('.BindStuToVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/BindGridByTransportStudent",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('.BindStuVehicleInfo').show(500)
                        $('.AddStudentTOtransport').show(500);
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNum + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].RouteDestination + '</td><td>' + data.d[i].StoppageName + '</td><td>' + data.d[i].Trip + '</td><td>' + data.d[i].AddedDate + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].StuTransPortStatus + '</td><td><input class="statusactive" style="width:18px;" type="image" alt=""  src="' + data.d[i].activestatus + ' " /><input id="idfirst" type="hidden" value="' + data.d[i].status + '"/></td><td><img class="ImgforeditStuTrans" style="cursor:pointer" src="../../images/edit.png"><input id="StuRegID" type="hidden" value="' + data.d[i].StuRegNo + '"/><input id="StuTransID" type="hidden" value="' + data.d[i].StuTransPortId + '"/></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNum + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].RouteDestination + '</td><td>' + data.d[i].StoppageName + '</td><td>' + data.d[i].Trip + '</td><td>' + data.d[i].AddedDate + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].StuTransPortStatus + '</td><td><input class="statusactive" style="width:18px;" type="image" alt=""  src="' + data.d[i].activestatus + ' " /><input id="idfirst" type="hidden" value="' + data.d[i].status + '"/></td><td><img class="ImgforeditStuTrans" style="cursor:pointer" src="../../images/edit.png"><input id="StuRegID" type="hidden" value="' + data.d[i].StuRegNo + '"/><input id="StuTransID" type="hidden" value="' + data.d[i].StuTransPortId + '"/></td></tr>';
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
        function BindtxtFieldStuGrid() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/BindtxtTransportStudent",
                data: "{'TransportIDofStu':'" + TransportIDofStu + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            BindRoute()
                            Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId, ChangeRoadID)
                            $('#txtStoppage').val(data.d[i].stoppageName);
                            $('#ddlroute').val(data.d[i].RouteID)
                            $('#ddlroute').trigger('change');
                            $('#ddlcity').val(data.d[i].City);
                            $('#ddlcity').trigger('change');
                            $('#ddlarea').val(data.d[i].Area)
                            $('#ddlarea').trigger('change');
                            $('#ddlblock').val(data.d[i].Block);
                            $('#ddlblock').trigger('change');
                            $('#ddlroad').val(data.d[i].Road)
                            $('#ddlroad').trigger('change');
                            $('#ddlstoppage').val(data.d[i].Stoppage);
                            $('#txtdate').val(data.d[i].AddedDate);
                            var MonthList = data.d[i].MonthList;
                            var feeDetails = data.d[i].feeDetails;
                            var newchar = ','
                            mystring = MonthList.split('@').join(newchar);
                            var arlene1 = [];
                            arlene1 = mystring.split(',');
                            var feeArr = feeDetails.split('@');
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

                            if (data.d[i].VehicleRegID > 0) {
                                $('.BindVehicle tbody').find('tr:gt(0)').find('input[type="hidden"][id="VehicleRegID"][value="' + data.d[i].VehicleRegID + '"]').parent('td').find("input:radio[name=Vehicleschedule]").attr('checked', true);
								VehicleRegID = data.d[i].VehicleRegID;
							}
                            else {
                                $("input:radio[name=Vehicleschedule]").attr('checked', false)
                            }

                            for (var a = 0; a < feeArr.length; a++) {
                                var str = feeArr[a];
                                var str1 = str.split('_');
                                $('#txtFee' + str1[0]).val(str1[1]);
                            }
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
        function SaveTransportForStudent() {
            debugger;
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
            var values = '';
            var date = new Date();
            var m = (new Date).getMonth() + 1;
            var valuesFee = '';
            $("#<%= CheckBoxList1.ClientID %> input:checkbox:checked").each(function () {
                var values1 = $('label[for=' + this.id + ']').html();

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
                    values = values + "@" + values1;
                }


                var values1Fee = $('label[for=' + this.id + ']').html();

                if (values1Fee == 'April') {
                    if ($("#txtFee4").val() == "") {
                        values1Fee = 4 + "_" + 0;
                    }
                    else {
                        values1Fee = 4 + "_" + $("#txtFee4").val();
                    }

                }
                if (values1Fee == 'May') {
                    if ($("#txtFee5").val() == "") {
                        values1Fee = 5 + "_" + 0;
                    }
                    else {
                        values1Fee = 5 + "_" + $("#txtFee5").val();
                    }

                }
                if (values1Fee == 'June') {
                    if ($("#txtFee6").val() == "") {
                        values1Fee = 6 + "_" + 0;
                    }
                    else {
                        values1Fee = 6 + "_" + $("#txtFee6").val();
                    }

                }
                if (values1Fee == 'July') {
                    if ($("#txtFee7").val() == "") {
                        values1Fee = 7 + "_" + 0;
                    }
                    else {
                        values1Fee = 7 + "_" + $("#txtFee7").val();
                    }

                }
                if (values1Fee == 'August') {
                    if ($("#txtFee8").val() == "") {
                        values1Fee = 8 + "_" + 0;
                    }
                    else {
                        values1Fee = 8 + "_" + $("#txtFee8").val();
                    }

                }
                if (values1Fee == 'September') {
                    if ($("#txtFee9").val() == "") {
                        values1Fee = 9 + "_" + 0;
                    }
                    else {
                        values1Fee = 9 + "_" + $("#txtFee9").val();
                    }

                }

                if (valuesFee == '') {
                    valuesFee = values1Fee.trim();
                }
                else {
                    valuesFee = valuesFee + "@" + values1Fee.trim();
                }
            });

            $("#<%= CheckBoxList2.ClientID %> input:checkbox:checked").each(function () {
                debugger;
                var values2 = $('label[for=' + this.id + ']').html();
                var values2Fee = $('label[for=' + this.id + ']').html();

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
                    values = values + "@" + values2;
                }

                if (values2Fee == 'October') {
                    if ($("#txtFee10").val() == "") {
                        values2Fee = 10 + "_" + 0;
                    }
                    else {
                        values2Fee = 10 + "_" + $("#txtFee10").val();;
                    }

                }
                if (values2Fee == 'November') {
                    if ($("#txtFee11").val() == "") {
                        values2Fee = 11 + "_" + 0;
                    }
                    else {
                        values2Fee = 11 + "_" + $("#txtFee11").val();;
                    }


                }
                if (values2Fee == 'December') {
                    if ($("#txtFee12").val() == "") {
                        values2Fee = 12 + "_" + 0;
                    }
                    else {
                        values2Fee = 12 + "_" + $("#txtFee12").val();;
                    }
                }
                if (values2Fee == 'January') {
                    if ($("#txtFee1").val() == "") {
                        values2Fee = 1 + "_" + 0;
                    }
                    else {
                        values2Fee = 1 + "_" + $("#txtFee1").val();;
                    }
                }
                if (values2Fee == 'February') {
                    if ($("#txtFee2").val() == "") {
                        values2Fee = 2 + "_" + 0;
                    }
                    else {
                        values2Fee = 2 + "_" + $("#txtFee2").val();;
                    }
                }
                if (values2Fee == 'March') {
                    if ($("#txtFee3").val() == "") {
                        values2Fee = 3 + "_" + 0;
                    }
                    else {
                        values2Fee = 3 + "_" + $("#txtFee3").val();;
                    }
                }
                if (valuesFee == '') {
                    valuesFee = values2Fee;
                }
                else {
                    valuesFee = valuesFee + "@" + values2Fee;
                }
            });
            if (values == '') {
                alertify.error('Please Select Atleast One Month for take Transport.')
                return false;
            }

            VehicleRouteMapID = $("input[type='radio'][name='Vehicleschedule']:checked").parent('td').find('input[type="hidden"][id="VehicleRoutMapID"]').val();
            if (VehicleRouteMapID == undefined) {
                alertify.error('Please Select Vehicle Type Reg.')
                return false;
            }
            if ($('#txtStoppage').val() == '') {
                alertify.error('Please enter Stoppage Name.')
                return false;
            }
            var AddedDate = $('#txtdate').val();
            var Stoppage = $('#ddlstoppage').val();
            var RouteIDSave = $('#ddlroute').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/SaveTransportStudent",
                data: "{'Trip':'" + Stoppage + "','VehicleId':'" + VehicleRegID + "','AddedDate':'" + AddedDate + "','MonthList':'" + values + "','VehicleRouteMapID':'" + VehicleRouteMapID + "','TransportIDofStu':'" + TransportIDofStu + "','AddupdateMode':'" + AddupdateMode + "','changecityid':'" + changecityid + "','changeareaid':'" + changeareaid + "','ChangeBlockiId':'" + ChangeBlockiId + "','ChangeRoadID':'" + ChangeRoadID + "','Stoppage':'" + Stoppage + "','RouteIDSave':'" + RouteIDSave + "','feeDetails':'" + valuesFee + "','Fyid':'" + Fyid + "','StoppageName':'" + $('#txtStoppage').val() +"'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Submit Successfully");
                        BindStuGrid()
                        $('#ShowDetails').hide();
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        alertify.success("Update Successfully");
                        BindStuGrid()
                        $('#ShowDetails').hide();
                        call_progressbar("end");
                    }
                    if (data.d == 12) {
                        if (confirm('Sorry, You have not Set Transport Fee. Do you want take transport ?')) {
                            window.location.replace('../Fee%20Management/mst_TransPortFee.aspx')
                        }
                    }
                    BindStuGrid()
                    $('#ShowDetails').hide();
                    call_progressbar("end");

                    changecityid = 0, changeareaid = 0, ChangeBlockiId = 0, TransportIDofStu = 0;
                    TransportIDofStu = 0, ChangeRouteID = 0;
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function BindRoute() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-transport-details.aspx/ddlRoute",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlroute").html("");
                    $.each(data.d, function (key, value) {
                        if (value.ROUTENAME != null) {
                            $("#ddlroute").append($("<option></option>").val(value.ROUTEID).html(value.ROUTENAME));
                        }
                    });
                    call_progressbar("end");
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
                url: "student-transport-details.aspx/updatestatus",
                data: "{'changestatus':'" + changestatus + "','Stureg':'" + Stureg + "','TransportIDofStu':'" + TransportIDofStu + "'}",
                dataType: "json",
                success: function (data) {
                    call_progressbar("end");
                    BindStuGrid()
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
</asp:Content>

