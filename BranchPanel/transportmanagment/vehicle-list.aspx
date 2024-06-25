<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="vehicle-list.aspx.cs" Inherits="BranchPanel_transportmanagment_vehicle_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" >
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2 id="contractheader">Vehicle List</h2>
        </div>
           <div class="divforstm BindVehicleList">
                <table class="stm BindVehicle" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:6%;">Reg. No.</th>
                        <th align="center" scope="col" style="width:8%;">Vehical Name</th>
                        <th align="center" scope="col" style="width:6%;">Model No.</th>
                         <th align="center" scope="col" style="width:6%;">Total Seats</th>
                        <th align="center" scope="col" style="width:9%;">Next Insurance Date</th>
                        <th align="center" scope="col" style="width:9%;">Next Road Tax Date</th>
                         <th align="center" scope="col" style="width:7%;">Next F.C. Date</th>
                         <th align="center" scope="col" style="width:2%;">Vehicle Type</th>
                         <th align="center" scope="col" style="width:6%;">Route Details</th>
                         <th align="center" scope="col" style="width:3%;">Edit</th>
                        <th align="center" scope="col" style="width:3%;">Delete</th>
                    </tr>
                </table>
            </div>
        <div class="clear"></div>
          <div class="DivForShowRouteDetails" style="display: none">
                <div class="pop-headng-sty">
                  Route Details
        <a id="A1" title="Close this from here" class="btnClose" style="margin-right:10px;">
            <img src="../../images/no.png" alt="No Image" class="ImgCloseRouteDetails" /></a>
                     <a id="A2" title="Edit this from here" class="btnEdit" style="float:right">
            <img src="../../images/edit.png" alt="No Image" class="ImgEditRouteDetails" /></a>
                </div>
                <table style="width: 100%;" class="stm tblforRouteDetails">
                    <tr class="stm_head">
                        <th align="center" scope="col">SNo.</th>
                        <th align="center" scope="col">Reg. No.</th>
                        <th align="center" scope="col">RouteName</th>
                        <th align="center" scope="col">SourceName</th>
                         <th align="center" scope="col">Destination</th>
                        <th align="center" scope="col">DepartureTime</th>
                        <th align="center" scope="col">ArrivalTime</th>
                    </tr>
                </table>
            </div>
        <div id="divProgressBar" class="progress"></div>
        </div>
    <script type="text/javascript">
        var vehicledelid = 0, VehicleIDForRouteDetail = 0, vehicleIDForRouteEdit = 0;
        $(document).ready(function () {
            BindGrid();
            $('.imgforeditvehicle').live('click', function () {
                var vehicleid = $(this).parent('td').find('input[type=hidden]').val();
                window.location.href = "vehicle-genral-detail.aspx?id=" + vehicleid;
                return false;
            });
            $('.imgfordeletevehicle').live('click', function () {
                vehicledelid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                var confirmstatus = confirm('Are You Sure You Want To Delete');
                if (confirmstatus == true) {
                    vehicledelete(vehicledelid)
                }
                return false;
            });
            $('.imgfordetails').live('click', function () {
                VehicleIDForRouteDetail = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                BindGridRouteDetails(VehicleIDForRouteDetail)
                return false;
            });
            $('.ImgCloseRouteDetails').click(function () {
                $('.DivForShowRouteDetails').hide(500);
                return false;
            });
            $('.ImgEditRouteDetails').click(function () {
                vehicleIDForRouteEdit = $('#VehicleRegID').parent('td').find('input[type=hidden]').val();
                window.location.href = "vehicle-to-route.aspx?id=" + vehicleIDForRouteEdit;
                return false;
            });
            return false;
        });
        function BindGrid() {
            var trforappend = "";
            $('.BindVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-list.aspx/BindGridByjsVehicle",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNo + '</td><td>' + data.d[i].Vehiclename + '</td><td>' + data.d[i].Modelnum + '</td><td>' + data.d[i].Numberofseats + '</td><td>' + data.d[i].NextinsuranceDate + '</td><td>' + data.d[i].RoadNextDate + '</td><td>' + data.d[i].Fitnessnextdate + '</td><td>' + data.d[i].vehicletype + '</td><td><img src="../../images/viewquestion.png" style="cursor:pointer;width:20px;" class="imgfordetails"></td><td><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditvehicle"><input id="vehicleid" type="hidden" value="' + data.d[i].vehicleid + '"/></td><td><img src="../../images/delete.gif" style="cursor:pointer" class="imgfordeletevehicle"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNo + '</td><td>' + data.d[i].Vehiclename + '</td><td>' + data.d[i].Modelnum + '</td><td>' + data.d[i].Numberofseats + '</td><td>' + data.d[i].NextinsuranceDate + '</td><td>' + data.d[i].RoadNextDate + '</td><td>' + data.d[i].Fitnessnextdate + '</td><td>' + data.d[i].vehicletype + '</td><td><img src="../../images/viewquestion.png" style="cursor:pointer;width:20px;" class="imgfordetails"></td><td><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditvehicle"><input id="vehicleid" type="hidden" value="' + data.d[i].vehicleid + '"/></td><td><img src="../../images/delete.gif" style="cursor:pointer" class="imgfordeletevehicle"></td></tr>';
                            $('.BindVehicle').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        alertify.error("No Any Vehicle in this List");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function BindGridRouteDetails(VehicleIDForRouteDetail) {
            var trforappend = "";
            $('.tblforRouteDetails tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-list.aspx/BindGridVehicleRouteDetails",
                data: "{'VehicleIDForRouteDetail':'" + VehicleIDForRouteDetail + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('.DivForShowRouteDetails').show(500);
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td><input id="VehicleRegID" type="hidden" value="' + data.d[i].VehicleRegID + '"/>' + data.d[i].VehicleReg + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].SourceName + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].DepartureTime + '</td><td>' + data.d[i].ArrivalTime + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td><input id="VehicleRegID" type="hidden" value="' + data.d[i].VehicleRegID + '"/>' + data.d[i].VehicleReg + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].SourceName + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].DepartureTime + '</td><td>' + data.d[i].ArrivalTime + '</td></tr>';
                            $('.tblforRouteDetails').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        $('.DivForShowRouteDetails').hide(500);
                        alertify.error("No Any Details on The Behalf of This Vehicle Reg.");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        //**********Function For Delete DEsignation **********//

        function vehicledelete(vehicledelid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-list.aspx/deletevehicle",
                data: "{'vehicledelid':'" + vehicledelid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    alertify.success("Vehicle Delete Successfully.")
                    call_progressbar("end");
                    BindGrid()
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
        //******* End Of Code *******************//
       
    </script>
</asp:Content>

