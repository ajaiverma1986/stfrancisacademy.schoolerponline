<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="vehicle-details.aspx.cs" Inherits="HO_vehicle_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" >
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2 id="contractheader">Vehicle List</h2>
        </div>
       <div class="searchbar containerHeadline" id="GridBatch">
                 <div class="clear"></div>
                 <asp:DropDownList ID="ddlbranch" runat="server" style="height: 31px; width: 130px;"></asp:DropDownList>
                <asp:ImageButton ID="btnclear" Width="25px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
                  <div class="clear"></div>
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
                         <th align="center" scope="col" style="width:5%;">Vehicle Type</th>
                    </tr>
                </table>
            </div>
        <div class="clear"></div>
        <div id="divProgressBar" class="progress"></div>
        </div>
    <script type="text/javascript">
        var Brid = 0;
        $(document).ready(function () {
            BindGrid();
            $("#ctl00_ContentPlaceHolder1_ddlbranch").on('change', function () {
                Brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
                BindGrid();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlbranch').val('')
                Brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
                BindGrid();
                return false;
            });
        });

        function BindGrid() {
            var trforappend = "";
            $('.BindVehicle tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "vehicle-details.aspx/BindGridByjsVehicle",
                data: "{'Brid':'" + Brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNo + '</td><td>' + data.d[i].Vehiclename + '</td><td>' + data.d[i].Modelnum + '</td><td>' + data.d[i].Numberofseats + '</td><td>' + data.d[i].NextinsuranceDate + '</td><td>' + data.d[i].RoadNextDate + '</td><td>' + data.d[i].Fitnessnextdate + '</td><td>' + data.d[i].vehicletype + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].VehicleRegNo + '</td><td>' + data.d[i].Vehiclename + '</td><td>' + data.d[i].Modelnum + '</td><td>' + data.d[i].Numberofseats + '</td><td>' + data.d[i].NextinsuranceDate + '</td><td>' + data.d[i].RoadNextDate + '</td><td>' + data.d[i].Fitnessnextdate + '</td><td>' + data.d[i].vehicletype + '</td></tr>';
                            $('.BindVehicle').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        alertify.error("No Any Vehicle in this List On The Behalf Of Your Advance Seraching");
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
        //******* End Of Code *******************//

    </script>
</asp:Content>

