<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="vehicle-to-route.aspx.cs" Inherits="BranchPanel_transportmanagment_vehicle_to_route" EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
        .tblformaproute label {
            width: 20px !important;
        }
    </style>
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
         <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2> Vehicle To Route</h2>
         </div>
         <div class="for_sigle_row_form">
             <label>Select Vehicle Reg.</label>
             <select id="DDLforVehicle" ></select>
         </div>
          <div class="divforstm BindVehicleList" style="display:none">
               <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2> Vehicle Details</h2>
               </div>
                <table class="stm BindVehicle" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:6%;">Bus Reg.No.</th>
                        <th align="center" scope="col" style="width:5%;">Contrator</th>
                        <th align="center" scope="col" style="width:8%;">Driver</th>
                        <th align="center" scope="col" style="width:8%;">Helper</th>
                        <th align="center" scope="col" style="width:5%;">Vehicle Type</th>
                    </tr>
                </table>
          </div>
         <div class="clear"></div>
         <div class="divforstm BindRouteList" style="display:none;">
             <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
                     <h2>Route Details</h2>
               </div>
                <table class="stm tblformaproute" style="width:100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width:3%;">S.No.</th>
                         <th align="center" scope="col" style="width:6%;">Route</th>
                        <th align="center" scope="col" style="width:5%;">Source</th>
                        <th align="center" scope="col" style="width:8%;">Destination</th>
                        <th align="center" scope="col" style="width:8%;">DepartureTime</th>
                        <th align="center" scope="col" style="width:5%;">Arrival Time</th>
                    </tr>
                   <tr class="for_sigle_row_form"> 
                    <td>
                   <label class="labincr">1</label>
                   <input id="hfroutedetails" type="hidden" value="0" />
                    </td>                
                    <td class="t2">
                        <asp:DropDownList ID="ddlRouteName" runat="server" CssClass="ddlRouteName" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select Route--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDeparturetime" runat="server" CssClass="ddlDeparturetime" Style="width: 100px;">
                            <asp:ListItem Value="0">--Select Departure Time--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlArrivaltime" runat="server" CssClass="ddlArrivaltime" Style="width: 100px;">
                            <asp:ListItem Value="0">--Select Arrival Time--</asp:ListItem>
                        </asp:DropDownList>
                         <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;float:right" alt="No Image" class="imgformapvehicletoroute" />
                    </td>
                </tr>
                </table>
         <div class="for_sigle_row_form">
            <input type="submit" class="button_save SaveMapRoute" value="Submit" style="margin-left: 220px;" />
            <input type="submit" class="button_cancel CancelRouteMap" value="Cancel" style="margin-left: 20px;" />
            <input type="submit" class="button_cancel Backtovehiclelist" value="Back" style="margin-left: 20px; display: none" />
        </div>
          </div>
        <div id="divProgressBar" class="progress"></div>
     </div>
    <script type="text/javascript">
        var VehicleID = 0, ChangeRouteID = 0, i = 1, trindex = 1, vehicleRegID = 0, AllRouteDetailsId = '';
        var AlllRouteID = 0, AllDepartureTime = '', AllArrivaltime = '';
        $(document).ready(function () {
            BindVehicleReg()
            CallMethod();
            if (vehicleRegID != 0)
            {
                $('#DDLforVehicle').val(vehicleRegID)
                BindGrid(vehicleRegID)
                $('.BindVehicleList').show(500);
                $('.BindRouteList').show(500);
            }
            $("#DDLforVehicle").change(function () {
                VehicleID = $(this).val();
                BindGrid(VehicleID)
                if (VehicleID > 0) {
                    $('.BindVehicleList').show(500);
                    $('.BindRouteList').show(500);
                    return false;
                }
                else {
                    $('.BindVehicleList').hide(500);
                    $('.BindRouteList').hide(500);
                    return false;
                }
                return false;
            });
            $('.ddlRouteName').live('change', function () {
                trindex = $(this).parent('td').parent('tr').index();
                ChangeRouteID = $(this).val();
                if (ChangeRouteID > 0) {
                    BindSourceDestinationOfRoute(ChangeRouteID)
                }
                else {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(2)').html('');
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(3)').html('');
                }
                return false;
            });
            $('.CancelRouteMap').click(function () {
                $('#DDLforVehicle').val('0');
                $('.BindVehicleList').hide(500);
                $('.BindRouteList').hide(500);
                return false;
            });
            
            $('.imgformapvehicletoroute').click(function () {
                i = i + 1;
                var trforappend = "";
                trindex = $(this).parent('td').parent('tr').index();
                trforappend = $(this).parent('td').parent('tr').clone();
                $('.tblformaproute').append(trforappend);
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgformapvehicletoroute').attr('src', '../../images/minus.png');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgformapvehicletoroute').addClass('imgforsubroute');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforsubroute').removeClass('imgformapvehicletoroute');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                $('.tblformaproute tbody').find('tr:last').find('td:eq(2)').html('');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(3)').html('');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('input[type="hidden"]').val('0');
                if (i % 2 == 0) {
                    $('.tblformaproute tbody').find('tr:last').addClass('stm_light');
                }
                else {
                    $('.tblformaproute tbody').find('tr:last').addClass('stm_dark');
                }
                return false;
            });
            AlllRouteID = '', AllDepartureTime = '', AllArrivaltime = '', AllRouteDetailsId = '';
            $('.SaveMapRoute').click(function () {
                $('.tblformaproute').find('tr').find('td').each(function () {
                    if ($(this).find('input[type="hidden"]').length > 0) {
                        AllRouteDetailsId = AllRouteDetailsId + '~' + $(this).find('input[type="hidden"]').val();
                    }
                    if ($(this).find('.ddlRouteName').length > 0) {
                        AlllRouteID = AlllRouteID + '~' + $(this).find('.ddlRouteName').val();
                    }
                    if ($(this).find('.ddlDeparturetime').length > 0) {
                        AllDepartureTime = AllDepartureTime + '~' + $(this).find('.ddlDeparturetime').val();
                    }
                    if ($(this).find('.ddlArrivaltime').length > 0) {
                        AllArrivaltime = AllArrivaltime + '~' + $(this).find('.ddlArrivaltime').val();
                    }
                });
                AllRouteDetailsId = AllRouteDetailsId.slice(1, AllRouteDetailsId.length);
                AlllRouteID = AlllRouteID.slice(1, AlllRouteID.length);
                AllDepartureTime = AllDepartureTime.slice(1, AllDepartureTime.length);
                AllArrivaltime = AllArrivaltime.slice(1, AllArrivaltime.length);
                SaveVehicleRouteMap()
                return false;
            });
            $('.imgforsubroute').live("click", function () {
                i = i - 1;
                $(this).parent('td').parent('tr').remove();
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                return false;
            });
            $('.Backtovehiclelist').click(function () {
                window.location.href = "vehicle-list.aspx";
                return false;
            });
            return false;
        });
        function CallMethod() {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    vehicleRegID = urlparam[1];
                    BindtxtFieldsOfVehicleRouteMap(urlparam[1])
                     $('.CancelRouteMap').hide();
                    $('.Backtovehiclelist').show();
                }
            }
            //For Finding That Coming For Edit End Here
        }
        function BindVehicleReg() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-to-route.aspx/ddlvehicle",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#DDLforVehicle").html("");
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".ddlRouteName").html("");
                    $.each(data.d, function (key, value) {
                        if (value.VEHICLEREGNO != null) {
                            $("#DDLforVehicle").append($("<option></option>").val(value.VEHICLEID).html(value.VEHICLEREGNO));
                        }
                        if (value.ROUTENAME != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".ddlRouteName").append($("<option></option>").val(value.ROUTEID).html(value.ROUTENAME));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function BindGrid(VehicleID) {
            var trforappend = "";
            $('.BindVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-to-route.aspx/BindGridByjsVehicle",
                data: "{'VehicleID':'" + VehicleID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].VEHICLEREGNO + '</td><td>' + data.d[i].CONTRACTORNAME + '</td><td>' + data.d[i].DRIVERNAME + '</td><td>' + data.d[i].HELPERNAME + '</td><td>' + data.d[i].BUSTYPE + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].VEHICLEREGNO + '</td><td>' + data.d[i].CONTRACTORNAME + '</td><td>' + data.d[i].DRIVERNAME + '</td><td>' + data.d[i].HELPERNAME + '</td><td>' + data.d[i].BUSTYPE + '</td></tr>';
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
        function BindSourceDestinationOfRoute(ChangeRouteID) {
            var trforappend = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-to-route.aspx/BindSourceAndDestination",
                data: "{'ChangeRouteID':'" + ChangeRouteID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(2)').html(data.d[i].ROUTESOURCE);
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(3)').html(data.d[i].DESTINATION);
                            $('.tblformaproute').append(trforappend);
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
        function SaveVehicleRouteMap() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-to-route.aspx/SaveVehicleRouteMap",
                data: "{'VehicleReg':'" + $('#DDLforVehicle').val() + "','AlllRouteID':'" + AlllRouteID + "','AllDepartureTime':'" + AllDepartureTime + "','AllArrivaltime':'" + AllArrivaltime + "','AllRouteDetailsId':'" + AllRouteDetailsId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alert("Submit Successfully");
                        window.location.href = "vehicle-list.aspx";
                        call_progressbar("end");
                    }
                    if (data.d == 2) {
                        alert("Update Successfully");
                        window.location.href = "vehicle-list.aspx";
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                    AllRouteDetailsId = '',AlllRouteID = 0, AllDepartureTime = '', AllArrivaltime = '';
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindtxtFieldsOfVehicleRouteMap(vehicleRegID) {
            $('.tblformaproute').find('tr:gt(1)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-to-route.aspx/BindTxtFieldsOfVehicleRouteDetails",
                data: "{'vehicleRegID':'" + vehicleRegID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {                  
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i > 0) {
                                trforappend = $('.tblformaproute tbody').find('tr:last').clone();
                                $('.tblformaproute').append(trforappend);
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgformapvehicletoroute').attr('src', '../../images/minus.png');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgformapvehicletoroute').addClass('imgforsubroute');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforsubroute').removeClass('imgformapvehicletoroute');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(2)').html('');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(3)').html('');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('input[type="hidden"]').val('0');
                                if (i % 2 == 1) {
                                    $('.tblformaproute tbody').find('tr:last').addClass('stm_light');
                                }
                                else {
                                    $('.tblformaproute tbody').find('tr:last').addClass('stm_dark');
                                }
                            }
                            trindex = i + 1;
                            ChangeRouteID = data.d[i].routeid
                            if (ChangeRouteID > 0) {
                                BindSourceDestinationOfRoute(ChangeRouteID)
                            }
                            else {
                                $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(2)').html('');
                                $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find('td:eq(3)').html('');
                            }
                            $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('input[type="hidden"]').val(data.d[i].vehicleroutemapid);
                            $('.tblformaproute tbody').find('tr:last').find('.ddlRouteName').val(data.d[i].routeid);
                            $('.tblformaproute tbody').find('tr:last').find('.ddlDeparturetime').val(data.d[i].DepartureTime);
                            $('.tblformaproute tbody').find('tr:last').find('.ddlArrivaltime').val(data.d[i].ArrivalTime);
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

