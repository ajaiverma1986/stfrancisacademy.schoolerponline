<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-Vehicletransport-details.aspx.cs" Inherits="BranchPanel_transportmanagment_student_transport_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Student Transport Details</h2>
                <a href="#" onclick="downloadExcel();" style="float:right;color:blue;text-decoration:underline;margin-right: 31px;margin-top: 5px;" >Download Excel</a>
            </div>
            <div class="clear"></div>
            <div class="grid-data-resposive">
                <div class="searchbar containerHeadline ">
                    <div class="clear"></div>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server"  Style="height: 31px; width: 100px;">
                    </asp:DropDownList>
                    <input type="text" id="txtname" placeholder="Enter Name" style="height: 31px; width: 80px;"/>
                     <select id="ddlclass" style="height: 31px; width:100px;"></select>
                     <select id="ddlroute" style="height: 31px; width:100px;"></select>
                     <select id="ddlvehicle" style="height: 31px; width:100px;"></select>
                     <select id="ddlcity" style="height: 31px; width:100px;"></select>
                     <select id="ddlarea" style="height: 31px; width:100px;"></select>  
                    <select id="ddlblock" style="height: 31px; width: 100px;"></select>
                    <select id="ddlroad" style="height: 31px; width: 100px;"></select>
                    <select id="ddlstoppage" style="height: 31px; width: 100px;"></select>
                    <input id="btnclear" type="image" style="width: 25px; height: 25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                </div>
                <div class="divTableDataHolder m-l-sm m-r-sm">
                     <div class="divforstm BindVehicleInfo" style="width:100%;">
                          <table class="stm BindVehicle" style="width: 100%;margin-right:200px;">
                            <tr class="stm_head" align="center">
                                <th align="center" scope="col">S.No.</th>
                                <th align="center" scope="col">Name</th>
                                <th align="center" scope="col">Parent Name</th>
                                <th align="center" scope="col">Mobile</th>
                                <th align="center" scope="col">Class</th>
                                <th align="center" scope="col">Route</th>
                                <th align="center" scope="col">Vehicle</th>
                                <th align="center" scope="col">Source</th>
                                <th align="center" scope="col">Destination</th>
                                <th align="center" scope="col">Vehicle Time</th>
                                <th align="center" scope="col">Added Date</th>
                                <th align="center" scope="col">Status</th>
                                <th align="center" scope="col">Stoppage</th>
                            </tr>
                        </table>
                          <table style="width: 100%">
                    <tr>
                        <td  colspan="10">
                           <table border="0" width="100%">
                                <tr>
                                    <td>

                        <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>                        </td>

                  <td>      <div style="margin-left: 0px; float: left; width: 500px;">
                            <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div> </td>
                                    </tr> </table>
                        </td>
                    </tr>
                </table>
                    </div>
                </div>
            </div>
            <div id="divforcomment" style="text-align: center; display: none;" class="">
                <div>
                    <table class="showpopuptopic showpopup2" style="background-color: white; vertical-align: top">
                        <tr>
                            <td colspan="2" class="pop-headng-sty">Comment
                            <a id="BtnCancelSend" title="Close this from here"
                                class="btnClose">
                                <img alt="No Image" src="../../images/popupcross.png" /></a>
                            </td>
                        </tr>
                        <tr class="for_sigle_row_form">
                            <td>
                                <label>Comment</label><span style="color: red">*</span>
                                <asp:TextBox ID="txtcomment" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="for_sigle_row_form">
                            <td align="center">
                                <asp:Button ID="BtnSend" runat="server" Text="Submit" CssClass="button_save" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="divProgressBar" class="progress"></div>
            <input type="hidden" id="hfpages" />
        </div>
    </div>
    <script type="text/javascript">
        var fyid = 0;
        var ClassID = 0, RouteID = 0, VehicleReg = 0, CityID = 0, AreaID = 0, BlockID = 0, RoadID = 0, StoppageID = 0, StudentName = '';
        var BrBrid = '<%= Session["BrBrid"].ToString() %>';
        function downloadExcel()
        {
            window.location.href = "/Uploads/StuTransportRpt_" + BrBrid + ".xlsx";
        }
        $(document).ready(function () {
            Bindalltypeddl()
            BindStuGrid()
            BindClass();
            FillField();
            pagecount = $("#hfpages").val();
            $(".lblpage").html(1);
            $(".lbltotalpage").html(pagecount);
        
            pagecount = $("#hfpages").val();
            if (parseInt(pagecount) > 0) {
                $(".lblpage").html(1);
                $(".lbltotalpage").html(pagecount);
            }
            else {
                $(".lblpage").html('0');
                $(".lbltotalpage").html('0');
            }
            
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillField();

                alertify.success('You Are On The First Page.');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                BindClass();
                FillField();
                return false;
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillField();

                    return false;
                }
                else {
                    alertify.error('No More Prevoius Page Is There.');
                    return false;
                }
            });
            $('.btnnext').live('click', function () {
                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $(".lblpage").html(pageno);
                    FillField();

                    return false;
                }
                else {
                    alertify.error('No More Next Page Is There.');
                    return false;
                }
            });

            $('.btnlast').live('click', function () {
                pageno = pagecount;
                $(".lblpage").html(pageno);
                FillField();

                alertify.error('You Are On The Last Page.');
                return false;
            });
            $("#ddlclass").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlroute").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlvehicle").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlcity").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlarea").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlblock").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlroad").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#ddlstoppage").change(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $("#txtname").keyup(function () {
                FillField();
                BindStuGrid()
                return false;
            });
            $('#btnclear').click(function () {
                $('#txtname').val('');
                $('#ddlstoppage').val('0');
                $('#ddlroad').val('0');
                $('#ddlblock').val('0');
                $('#ddlarea').val('0');
                $('#ddlcity').val('0');
                $('#ddlvehicle').val('0');
                $('#ddlroute').val('0');
                $('#ddlclass').val('0');
                $(".lbltotalpage").html(pagecount);
                FillField();
                BindStuGrid()
                return false;
            });
            return false;
        });
        function FillField() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            ClassID = $('#ddlclass').val();
            RouteID = $('#ddlroute').val();
            VehicleReg = $('#ddlvehicle').val();
            CityID = $('#ddlcity').val();
            AreaID = $('#ddlarea').val();
            BlockID = $('#ddlblock').val();
            RoadID = $('#ddlroad').val();
            StoppageID = $('#ddlstoppage').val();
            StudentName = $('#txtname').val();
            return false;
        }
        function Bindalltypeddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Vehicletransport-details.aspx/BindDDLTransport",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlcity").html("");
                    $("#ddlarea").html("");
                    $("#ddlblock").html("");
                    $("#ddlroad").html("");
                    $("#ddlstoppage").html("");
                    $("#ddlclass").html("");
                    $("#ddlvehicle").html("");
                    $("#ddlroute").html("");
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
                        if (value.ClassName != null) {
                            $("#ddlclass").append($("<option></option>").val(value.Id).html(value.ClassName));
                        }
                        if (value.VehicleRegNo != null) {
                            $("#ddlvehicle").append($("<option></option>").val(value.vehicleid).html(value.VehicleRegNo));
                        }
                        if (value.RouteName != null) {
                            $("#ddlroute").append($("<option></option>").val(value.RoutId).html(value.RouteName));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function BindStuGrid() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            var trforappend = "";
            $('.BindVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Vehicletransport-details.aspx/BindGridByTransportStudent",
                data: "{'fyid':'" + fyid + "','ClassID':'" + ClassID + "','RouteID':'" + RouteID + "','VehicleReg':'" + VehicleReg + "','CityID':'" + CityID + "','AreaID':'" + AreaID + "','BlockID':'" + BlockID + "','RoadID':'" + RoadID + "','StoppageID':'" + StoppageID + "','StudentName':'" + StudentName + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $('#hfpages').val(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].StudentName + '</td><td>' + data.d[i].Parent + '</td><td>' + data.d[i].PrimaryMobileNo + '</td><td>' + data.d[i].classname + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].VehicleRegNum + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].RouteDestination + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].AddedDate + '</td><td>' + data.d[i].StuTransPortStatus + '</td><td>' + data.d[i].StoppageName + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + data.d[i].RowNumber + '</td><td>' + data.d[i].StudentName + '</td><td>' + data.d[i].Parent + '</td><td>' + data.d[i].PrimaryMobileNo + '</td><td>' + data.d[i].classname + '</td><td>' + data.d[i].RouteName + '</td><td>' + data.d[i].VehicleRegNum + '</td><td>' + data.d[i].RouteSource + '</td><td>' + data.d[i].RouteDestination + '</td><td>' + data.d[i].VehicleTime + '</td><td>' + data.d[i].AddedDate + '</td><td>' + data.d[i].StuTransPortStatus + '</td><td>' + data.d[i].StoppageName + '</td></tr>';
                            $('.BindVehicle').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        $(".lblpage").html(0);
                        $(".lbltotalpage").html(0);
                        alertify.error('No Record Found On The Behlaf Of Your Advance Searching.')
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function BindClass() {
            Fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-Vehicletransport-details.aspx/BindClassMethod",
                data: "{'fyid':'" + Fyid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ddlclass").html("");
                    $("#ddlclass").append($("<option></option>").val('0').html('Select Class'));
                    $.each(data.d, function (key, value) {
                        $("#ddlclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                    });
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

