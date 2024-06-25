<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="create-route.aspx.cs" Inherits="BranchPanel_transportmanagment_create_root" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .tblformaproute label {
            width: 20px !important;
        }
    </style>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px; margin-top: 5px">
            <h2>Create Route</h2>
        </div>
        <div class="for_sigle_row_form" style="display: block;">
            <input id="hfrouteid" type="hidden" value="0" />
            <label>
                Route No(Name)<span style="color: Red; font-weight: bold">*</span></label>
            <input type="text" placeholder="Enter Route No./Name Please" id="txtRouteName" />&nbsp;                   
        </div>
        <div class="for_sigle_row_form" style="display: block;">
            <label>
                Source</label>
            <input type="text" placeholder="Enter Source Name Please" id="TextSource" />&nbsp;                   
        </div>
        <div class="for_sigle_row_form" style="display: block;">
            <label>
                Destination</label>
            <input type="text" placeholder="Enter Destination Name Please" id="TextDestination" />&nbsp;                   
        </div>
        <div class="for_sigle_row_form" style="display: block;">
            <label>
                Distance(in KM)</label>
            <input type="text" placeholder="Enter Distance Please" id="TextDistance" />&nbsp;                   
        </div>
        <div class="for_sigle_row_form" style="display: block">
            <table class="stm tblformaproute" style="width: 100%">
                <tr class="stm_head" align="center">
                    <th align="center" scope="col">S.No.</th>
                    <th align="center" scope="col">City</th>
                    <th align="center" scope="col">Area</th>
                    <th align="center" scope="col">Block</th>
                    <th align="center" scope="col">Road</th>
                    <th align="center" scope="col">Stoppage</th>
                </tr>
                <tr class="for_sigle_row_form">
                    <td class="t1">
                        <label class="labincr">1</label>
                        <input id="hfroutedetails" type="hidden" value="0" />
                    </td>
                    <td class="t2">
                        <asp:DropDownList ID="ddlcityname" runat="server" CssClass="cityddl" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select City--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlareaname" runat="server" CssClass="areaddl" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select Area--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlblockname" runat="server" CssClass="blockddl" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select Block--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlroadname" runat="server" CssClass="roadddl" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select Road--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlstoppagename" runat="server" CssClass="ddlstoppage" Style="width: 180px;">
                            <asp:ListItem Value="0">--Select Stoppage--</asp:ListItem>
                        </asp:DropDownList>
                        <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgforaddroute" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="for_sigle_row_form">
            <input type="submit" class="button_save SaveRoot" value="Submit" style="margin-left: 220px;" />
            <input type="submit" class="button_cancel Removedata" value="Clear" style="margin-left: 20px;" />
            <input type="submit" class="button_cancel Backdata" value="Back" style="margin-left: 20px; display: none" />
        </div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var cityid = 0, trindex = 1, changeareaid = 0, changeRoadId = 0, RouteDetailupdateid = 0, AddUpdateMode = 1, ChangeBlockID = 0;
        var AllCityForRouteID = 0, AllAreaForRouteID = 0, AllRoadForRouteID = 0, AllStoppageForRouteID = 0, i = 1, AllBlockForRouteID = 0, AllRouteDetailsId = '';
        $(document).ready(function () {
            Bindcitysearchddl();
            CallMethod();
            $('.Removedata').click(function () {
                $('#txtRouteName').val('');
                $('#TextSource').val('');
                $('#TextDestination').val('');
                $('#TextDistance').val('');
                $('.cityddl').val('0');
                $('.areaddl').val('0');
                $('.roadddl').val('0');
                $('.ddlstoppage').val('0');
                return false;
            });
            $('.imgforaddroute').click(function () {
                i = i + 1;
                var trforappend = "";
                trindex = $(this).parent('td').parent('tr').index();
                trforappend = $(this).parent('td').parent('tr').clone();
                $('.tblformaproute').append(trforappend);
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforaddroute').attr('src', '../../images/minus.png');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforaddroute').addClass('imgforsubroute');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforsubroute').removeClass('imgforaddroute');
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('input[type="hidden"]').val('0');
                if (i % 2 == 0) {
                    $('.tblformaproute tbody').find('tr:last').addClass('stm_light');
                }
                else {
                    $('.tblformaproute tbody').find('tr:last').addClass('stm_dark');
                }
                return false;
            });
            $('.cityddl').live('change', function () {
                trindex = $(this).parent('td').parent('tr').index();
                cityid = $(this).val();
                Bindareaddl(cityid)
                return false;
            });
            $('.areaddl').live('change', function () {
                trindex = $(this).parent('td').parent('tr').index();
                changeareaid = $(this).val();
                BindBlockDDL(changeareaid)
                return false;
            });
            $('.roadddl').live('change', function () {
                trindex = $(this).parent('td').parent('tr').index();
                changeRoadId = $(this).val();
                BindStoppageDDL(changeRoadId)
                return false;
            });
            $('.blockddl').live('change', function () {
                trindex = $(this).parent('td').parent('tr').index();
                ChangeBlockID = $(this).val()
                BindROadDDL(ChangeBlockID)
                return false;
            });
            $('.imgforsubroute').live("click", function () {
                i = i - 1;
                $(this).parent('td').parent('tr').remove();
                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                return false;
            });
            $('.SaveRoot').click(function () {
                if ($('#txtRouteName').val() == '') {
                    alertify.error('Enter Route Name OR Route Number')
                    $('#txtRouteName').focus();
                    return false;
                }
                //else if ($('.cityddl').val() == '0') {
                //    alertify.error('Please Select City')
                //    $('.cityddl').focus();
                //    return false;
                //}
                //else if ($('.areaddl').val() == '0') {
                //    alertify.error('Please Select Area')
                //    $('.areaddl').focus();
                //    return false;
                //}
                //else if ($('.blockddl').val() == '0') {
                //    alertify.error('Please Select Block')
                //    $('.blockddl').focus();
                //    return false;
                //}
                //else if ($('.roadddl').val() == '0') {
                //    alertify.error('Please Select Road')
                //    $('.roadddl').focus();
                //    return false;
                //}
                //else if ($('.ddlstoppage').val() == '0') {
                //    alertify.error('Please Select Stoppage')
                //    $('.ddlstoppage').focus();
                //    return false;
                //}
                else {
                    AllCityForRouteID = '', AllAreaForRouteID = '', AllRoadForRouteID = '', AllStoppageForRouteID = '', AllBlockForRouteID = '', AllRouteDetailsId = '';
                    $('.tblformaproute').find('tr').find('td').each(function () {
                        if ($(this).find('input[type="hidden"]').length > 0) {
                            AllRouteDetailsId = AllRouteDetailsId + '~' + $(this).find('input[type="hidden"]').val();
                        }
                        //if ($(this).find('.cityddl').length > 0) {
                        //    AllCityForRouteID = AllCityForRouteID + '~' + $(this).find('.cityddl').val();
                        //}
                        //if ($(this).find('.areaddl').length > 0) {
                        //    AllAreaForRouteID = AllAreaForRouteID + '~' + $(this).find('.areaddl').val();
                        //}
                        //if ($(this).find('.roadddl').length > 0) {
                        //    AllRoadForRouteID = AllRoadForRouteID + '~' + $(this).find('.roadddl').val();
                        //}
                        //if ($(this).find('.ddlstoppage').length > 0) {
                        //    AllStoppageForRouteID = AllStoppageForRouteID + '~' + $(this).find('.ddlstoppage').val();
                        //}
                        //if ($(this).find('.blockddl').length > 0) {
                        //    AllBlockForRouteID = AllBlockForRouteID + '~' + $(this).find('.blockddl').val();
                        //}
                    });
                    AllRouteDetailsId=AllRouteDetailsId.slice(1, AllRouteDetailsId.length);
                    //AllCityForRouteID = AllCityForRouteID.slice(1, AllCityForRouteID.length);
                    //AllAreaForRouteID = AllAreaForRouteID.slice(1, AllAreaForRouteID.length);
                    //AllRoadForRouteID = AllRoadForRouteID.slice(1, AllRoadForRouteID.length);
                    //AllStoppageForRouteID = AllStoppageForRouteID.slice(1, AllStoppageForRouteID.length);
                    //AllBlockForRouteID = AllBlockForRouteID.slice(1, AllBlockForRouteID.length);
                    SaveRoute();
                }
                return false;
            });
            $('.Backdata').click(function () {
                window.location.href = "route-list.aspx"
                return false;
            });
        });
        function Bindcitysearchddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/searchcity",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".cityddl").html("");
                    $.each(data.d, function (key, value) {
                        if (value.zonename != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".cityddl").append($("<option></option>").val(value.zoneid).html(value.zonename));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Bindareaddl(cityid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/areaddl",
                data: "{'cityid':'" + cityid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".areaddl").html("");
                    $.each(data.d, function (key, value) {
                        if (value.areaname != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".areaddl").append($("<option></option>").val(value.areaid).html(value.areaname));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function BindROadDDL(ChangeBlockID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/BindDDLRoad",
                data: "{'ChangeBlockID':'" + ChangeBlockID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".roadddl").html("");
                    $.each(data.d, function (key, value) {
                        if (value.roadname != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".roadddl").append($("<option></option>").val(value.roadid).html(value.roadname));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function BindStoppageDDL(changeRoadId) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/BindDDLStoppage",
                data: "{'changeRoadId':'" + changeRoadId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".ddlstoppage").html("");
                    $.each(data.d, function (key, value) {
                        if (value.stoppagename != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".ddlstoppage").append($("<option></option>").val(value.stoppageid).html(value.stoppagename));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }

        function BindBlockDDL(changeareaid) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/BindDDLBlock",
                data: "{'changeareaid':'" + changeareaid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".blockddl").html("");
                    $.each(data.d, function (key, value) {
                        if (value.BlockName != null) {
                            $('.tblformaproute tbody').find('tr:eq(' + trindex + ')').find(".blockddl").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function CallMethod() {
            //For Finding That Coming For Edit Start Here
            var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < url.length; i++) {
                var urlparam = url[i].split('=');
                if (parseInt(urlparam.length) > 1) {
                    AddUpdateMode = 1;
                    $('.Backdata').show();
                    $('.Removedata').hide();
                    RouteDetailupdateid = urlparam[1];
                    BindtxtFieldsOfRoute(urlparam[1])
                }
            }
            //For Finding That Coming For Edit End Here
        }
        function SaveRoute() {
            var Routename = $('#txtRouteName').val().trim();
            var Source = $('#TextSource').val().trim();
            var Destination = $('#TextDestination').val().trim();
            var Distance = $('#TextDistance').val().trim();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/SaveRouteData",
                data: "{'RouteId':'" + $('#hfrouteid').val() + "','Routename':'" + Routename.split("'").join("`") + "','Source':'" + Source.split("'").join("`") + "','Destination':'" + Destination.split("'").join("`") + "','Distance':'" + Distance.split("'").join("`") + "','AllCityForRouteID':'" + AllCityForRouteID + "','AllAreaForRouteID':'" + AllAreaForRouteID + "','AllRoadForRouteID':'" + AllRoadForRouteID + "','AllStoppageForRouteID':'" + AllStoppageForRouteID + "','AddUpdateMode':'" + AddUpdateMode + "','RouteDetailupdateid':'" + RouteDetailupdateid + "','AllBlockForRouteID':'" + AllBlockForRouteID + "','AllRouteDetailsId':'" + AllRouteDetailsId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alert("Route Submit Successfully");
                        window.location.href = "route-list.aspx"
                        call_progressbar("end");
                    }
                    if (data.d == 6) {
                        alert("Route Update Successfully");
                        window.location.href = "route-list.aspx"
                        call_progressbar("end");
                    }
                    if (data.d == 8) {
                        alertify.error("This Route Already Exist");
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function BindtxtFieldsOfRoute(RouteDetailupdateid) {
            $('.tblformaproute').find('tr:gt(1)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "create-route.aspx/BindTxtFieldsOfRouteDetails",
                data: "{'RouteDetailupdateid':'" + RouteDetailupdateid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 1; i < data.d.length; i++) {
                            if (i > 1) {
                                trforappend = $('.tblformaproute tbody').find('tr:last').clone();
                                $('.tblformaproute').append(trforappend);
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforaddroute').attr('src', '../../images/minus.png');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforaddroute').addClass('imgforsubroute');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(5)').find('.imgforsubroute').removeClass('imgforaddroute');
                                $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('.labincr').html(i);
                                if (i % 2 == 0) {
                                    $('.tblformaproute tbody').find('tr:last').addClass('stm_light');
                                }
                                else {
                                    $('.tblformaproute tbody').find('tr:last').addClass('stm_dark');
                                }
                            }
                            trindex = i;
                            $('.tblformaproute tbody').find('tr:last').find('td:eq(0)').find('input[type="hidden"]').val(data.d[i].RouteDetailsId);
                            $('.tblformaproute tbody').find('tr:last').find('.cityddl').val(data.d[i].CityID);
                            Bindareaddl(data.d[i].CityID)
                            $('.tblformaproute tbody').find('tr:last').find('.areaddl').val(data.d[i].AreaID);                           
                            BindStoppageDDL(data.d[i].RoadID)
                            $('.tblformaproute tbody').find('tr:last').find('.ddlstoppage').val(data.d[i].StoppageID);
                            BindBlockDDL(data.d[i].AreaID)
                            $('.tblformaproute tbody').find('tr:last').find('.blockddl').val(data.d[i].BlockID);
                            BindROadDDL(data.d[i].BlockID)
                            $('.tblformaproute tbody').find('tr:last').find('.roadddl').val(data.d[i].RoadID);
                        }
                        $('#hfrouteid').val(data.d[0].RouteId);
                        $('#txtRouteName').val(data.d[0].RouteName);
                        $('#TextSource').val(data.d[0].RouteSource);
                        $('#TextDestination').val(data.d[0].Destination);
                        $('#TextDistance').val(data.d[0].Distance);
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

