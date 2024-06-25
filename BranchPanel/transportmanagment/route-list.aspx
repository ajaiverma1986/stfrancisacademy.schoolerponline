<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="route-list.aspx.cs" Inherits="BranchPanel_transportmanagment_route_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" >
         <div class="tbl-top-heading" style="width: 100%; margin-left: 0px;margin-top:5px">
              <h2>Route List</h2>
        </div>
        <div  class="for_sigle_row_form showgrid">
         <table class="stm tblforroutelist" style="width:100%">
                   <tr class="stm_head" align="center">
                        <th align="center" scope="col">S.No.</th>
                       <th align="center" scope="col">Route Name</th>
                        <th align="center" scope="col">Source</th>
                        <th align="center" scope="col">Destination</th>
                        <th align="center" scope="col">Distance(K.M.)</th>
                        <th align="center" scope="col">Edit</th>
                        <th align="center" scope="col">Delete</th>
                        <th align="center" scope="col">Details</th>
                  </tr>
             </table>
        </div>
        <div class="DivForSettingListDetails" style="display: none">
                <div class="pop-headng-sty">
                   Detail
        <a id="A1" title="Close this from here" class="btnClose">
            <img src="../../images/no.png" alt="No Image" class="ImgCloseRouteDetails" /></a>
                </div>
                <table style="width: 100%;" class="stm tblforRouteDetailList">
                    <tr class="stm_head">
                        <th align="center" scope="col">SNo.</th>
                        <th align="center" scope="col">Route Name/No.</th>
                        <th align="center" scope="col">City</th>
                        <th align="center" scope="col">Area</th>
                         <th align="center" scope="col">Block</th>
                        <th align="center" scope="col">Road</th>
                        <th align="center" scope="col">Stoppage</th>
                    </tr>
                </table>
            </div>
           <div id="divProgressBar" class="progress"></div>
        </div>
    <script type="text/javascript">
        var RouteDeleteID = 0, RouteDetailsID = 0, RouteUpdateID = 0;
        $(document).ready(function () {
            BindGrid()
            $('.imgfordeleteRoute').live('click', function () {
                RouteDeleteID = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                var confirmstatus = confirm('Are You Sure You Want To Delete');
                if (confirmstatus == true) {
                    Routedelete(RouteDeleteID)
                }
                return false;
            });
            $('.imgfordetails').live('click', function () {
                RouteDetailsID = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                $('.DivForSettingListDetails').show(500)
                BindRouteDetailsGrid(RouteDetailsID)
                $('html, body').animate({
                    scrollTop: $(".DivForSettingListDetails").offset().top
                }, 2000);
               
                return false;
            });
            $('.ImgCloseRouteDetails').click(function () {
                $('.DivForSettingListDetails').hide(500)
                $('html, body').animate({
                    scrollTop: $(".showgrid").offset().bottom
                }, 2000);
                return false;
            });
            $('.ImgforeditRoute').click(function () {
                RouteUpdateID = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                window.location.href = "create-route.aspx?id=" + RouteUpdateID;
                return false;
            });
            return;
        });
        function BindGrid() {
            var trforappend = "";
            $('.tblforroutelist tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "route-list.aspx/BindGridByjsRoute",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].Distance + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="ImgforeditRoute"><input id="Routeid" type="hidden" value="' + data.d[i].routid + '"/></td><td><img src="../../images/delete.gif" style="cursor:pointer" class="imgfordeleteRoute"></td><td><img src="../../images/viewquestion.png" style="cursor:pointer;width:20px;" class="imgfordetails"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].Destination + '</td><td>' + data.d[i].Distance + '</td><td><img src="../../images/edit.png" style="cursor:pointer" class="ImgforeditRoute"><input id="Routeid" type="hidden" value="' + data.d[i].routid + '"/></td><td><img src="../../images/delete.gif" style="cursor:pointer" class="imgfordeleteRoute"></td><td><img src="../../images/viewquestion.png" style="cursor:pointer;width:20px;" class="imgfordetails"></td></tr>';
                            $('.tblforroutelist').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        alertify.error("No Any Route in this List");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindRouteDetailsGrid(RouteDetailsID) {
            var trforappend = "";
            $('.tblforRouteDetailList tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "route-list.aspx/BindGridByjsRouteOfDetails",
                data: "{'RouteDetailsID':'" + RouteDetailsID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].CityName + '</td><td>' + data.d[i].AreaName + '</td><td>' + data.d[i].BlockName + '</td><td>' + data.d[i].RoadName + '</td><td>' + data.d[i].stoppage + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].CityName + '</td><td>' + data.d[i].AreaName + '</td><td>' + data.d[i].BlockName + '</td><td>' + data.d[i].RoadName + '</td><td>' + data.d[i].stoppage + '</td></tr>';
                            $('.tblforRouteDetailList').append(trforappend);
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

        function Routedelete(RouteDeleteID) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "route-list.aspx/deleteRoute",
                data: "{'RouteDeleteID':'" + RouteDeleteID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    alertify.success("Route Delete Successfully.")
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
    </script>
</asp:Content>

