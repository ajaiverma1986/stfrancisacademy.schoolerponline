<%@ Page Language="C#" AutoEventWireup="true" CodeFile="performance-graph.aspx.cs" Inherits="branchpanel_employee_performance_graph" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="performancegraph/fusioncharts.js"></script>
    <script type="text/javascript" src="performancegraph/themes/fusioncharts.theme.fint.js"></script>
    <script src="../../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
        var janchart = 0, febchart = 0, marchart = 0, aprchart = 0, maychart = 0, junchart = 0, julchart = 0, augchart = 0, sepchart = 0, octchart = 0, novchart = 0, decchart = 0, fyid = 0;
        $(document).ready(function () {
            fyid = $('#ddlfinancialyear').val();
            if (fyid != 0) {
                BindGraph();
            }
            $('#ddlfinancialyear').change(function () {
                fyid = $(this).val();
                BindGraph();
            });
        });
        function BindChart() {
            FusionCharts.ready(function () {
                var revenueChart = new FusionCharts({
                    "type": "column3d",
                    "renderAt": "chartContainer",
                    "width": "1300",
                    "height": "600",
                    "dataFormat": "json",
                    "dataSource": {
                        "chart": {
                            "caption": "Monthly Wise Employee Performnace Report",
                            "xAxisName": "Months",
                            "yAxisName": "Total Points (In Month)",
                            "theme": "fint"
                        },
                        "data": [
                           {
                               "label": "Apr",
                               "value": aprchart
                           },
                           {
                               "label": "May",
                               "value": maychart
                           },
                           {
                               "label": "Jun",
                               "value": junchart
                           },
                           {
                               "label": "Jul",
                               "value": julchart
                           },
                           {
                               "label": "Aug",
                               "value": augchart
                           },
                           {
                               "label": "Sep",
                               "value": sepchart
                           },
                           {
                               "label": "Oct",
                               "value": octchart
                           },
                           {
                               "label": "Nov",
                               "value": novchart
                           },
                           {
                               "label": "Dec",
                               "value": decchart
                           }, {
                               "label": "Jan",
                               "value": janchart
                           },
                           {
                               "label": "Feb",
                               "value": febchart
                           },
                           {
                               "label": "Mar",
                               "value": marchart
                           }
                        ]
                    }

                });
                revenueChart.render();
            })
        }
        function BindGraph() {
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "performance-graph.aspx/BindGraphByWebMethod",
                data: "{'financialyeraid':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        for (i = 0; i < data.d.length; i++) {
                            janchart = data.d[0].Jan;
                            febchart = data.d[0].Feb;
                            marchart = data.d[0].Mar;
                            aprchart = data.d[0].Apr;
                            maychart = data.d[0].May;
                            junchart = data.d[0].Jun;
                            julchart = data.d[0].Jul;
                            augchart = data.d[0].Aug;
                            sepchart = data.d[0].Sep;
                            octchart = data.d[0].Oct;
                            novchart = data.d[0].Nov;
                            decchart = data.d[0].Dec;
                            BindChart();
                        }
                    }
                },
                error: function (response) {
                }
            });
        }
    </script>
    <style>
        .Divforfinancialyear {
            margin-left: 400px !important;
            margin-top: 10px !important;
            margin-bottom: 10px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="Divforfinancialyear">
                <span style="font-family: Arial; font-weight: bold; color: green">Select Financial Year:</span>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="150px" Style="height: 25px !important;">
                </asp:DropDownList>
                <asp:Label ID="lblempname" runat="server" Style="font-weight: bold; margin-left: 90px !important;"></asp:Label>
            </div>
            <div id="chartContainer"></div>
        </div>
    </form>
</body>
</html>