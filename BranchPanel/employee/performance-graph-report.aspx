<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="performance-graph-report.aspx.cs" Inherits="branchpanel_employee_performance_graph_report" %>

<%@ Register Src="employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activeperformancereport {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        #ctl00_ContentPlaceHolder1_lbtnperformancegraph {
            margin-left: 900px !important;
            color: green !important;
            font-size: 15px !important;
            font-family: arial !important;
            font-weight: bold;
        }

        #ctl00_ContentPlaceHolder1_gridperformance th {
            color: green !important;
        }
    </style>
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/ecmascript">
        var fyid = 0, payid = 0;

        $(document).ready(function () {
            document.title = 'Performance';

            $('#ctl00_ContentPlaceHolder1_lbtnperformancegraph').click(function () {
                var eid = $('#ctl00_ContentPlaceHolder1_hfeid').val();
                window.open("performance-graph.aspx?id=" + eid, "_blank");
                return false;
            });

            fyid = $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").val();
            payid = $("#ctl00_ContentPlaceHolder1_ddlpayid").val();
            if (fyid != 0 && payid != 0) {
                get_performance();
            }

            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear").change(function () {
                fyid = $(this).val();
                get_performance();

            });

            $("#ctl00_ContentPlaceHolder1_ddlpayid").change(function () {
                payid = $(this).val();
                get_performance();
            });
        });

        function get_performance() {
            // call_progressbar("start");
            $.ajax({
                type: "POST",
                url: "performance-graph-report.aspx/Fill_Performance",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var srno = 1;
                    $("[id*=gridperformance] tr:gt(1)").remove();

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gridperformance] tr:eq(1)").clone(true);
                            $("[id$=gridperformance]").append(row);

                            $(row).find(".RowNumber").html(data.d[i].RowNumber);
                            $(row).find(".job_performance").html(data.d[i].job_performance);
                            $(row).find(".refNo").html(data.d[i].refNo);
                            $(row).find(".perform1").html(data.d[i].perform1);
                            $(row).find(".perform2").html(data.d[i].perform2);
                            $(row).find(".perform3").html(data.d[i].perform3);
                            $(row).find(".perform4").html(data.d[i].perform4);
                            $(row).find(".perform5").html(data.d[i].perform5);
                            $(row).find(".perform6").html(data.d[i].perform6);
                            $(row).find(".perform7").html(data.d[i].perform7);
                            $(row).find(".perform8").html(data.d[i].perform8);
                            $(row).find(".perform9").html(data.d[i].perform9);
                            $(row).find(".perform10").html(data.d[i].perform10);

                            $(row).find(".perform11").html(data.d[i].perform11);
                            $(row).find(".perform12").html(data.d[i].perform12);
                            $(row).find(".perform13").html(data.d[i].perform13);
                            $(row).find(".perform14").html(data.d[i].perform14);
                            $(row).find(".perform15").html(data.d[i].perform15);
                            $(row).find(".perform16").html(data.d[i].perform16);
                            $(row).find(".perform17").html(data.d[i].perform17);
                            $(row).find(".perform18").html(data.d[i].perform18);
                            $(row).find(".perform19").html(data.d[i].perform19);

                            $(row).find(".perform20").html(data.d[i].perform20);
                            $(row).find(".perform21").html(data.d[i].perform21);
                            $(row).find(".perform22").html(data.d[i].perform22);
                            $(row).find(".perform23").html(data.d[i].perform23);
                            $(row).find(".perform24").html(data.d[i].perform24);
                            $(row).find(".perform25").html(data.d[i].perform25);
                            $(row).find(".perform26").html(data.d[i].perform26);
                            $(row).find(".perform27").html(data.d[i].perform27);
                            $(row).find(".perform28").html(data.d[i].perform28);
                            $(row).find(".perform29").html(data.d[i].perform29);

                            $(row).find(".perform30").html(data.d[i].perform30);
                            $(row).find(".perform31").html(data.d[i].perform31);
                            $(row).find(".totalpoints").html(data.d[i].totalpoints);

                        }

                        $("#ctl00_ContentPlaceHolder1_gridperformance").css("display", "block");
                    }
                    //else
                    //{
                    //    var row = $("[id*=gridperformance] tr:eq(1)").clone(true);
                    //    $("[id$=gridperformance]").append(row);

                    //    //$(row).find(".id").css("display", "none");
                    //    //$(row).find(".Row_num").css("display", "none");
                    //    //$(row).find(".emailid").css("display", "none");
                    //    //$(row).find(".refNo").css("display", "none");
                    //    //$(row).find(".Name").css("display", "none");
                    //    //$(row).find(".department").css("display", "none");
                    //    //$(row).find(".date").css("display", "none");
                    //    //$(row).find(".designation").css("display", "none");
                    //    //$(row).find(".mobile").css("display", "none");
                    //    //$(row).find(".edit").css("display", "none");
                    //    //$(row).find(".status").css("display", "none");
                    //    //$(row).find(".doj").css("display", "none");
                    //    //$(row).find(".doi").css("display", "none");

                    //    $("#ctl00_ContentPlaceHolder1_gridperformance").css("display", "none");
                    //}

                    $("[id*=gridperformance] tr").show();
                    $("[id*=gridperformance] tr:eq(1)").hide();

                    //call_progressbar("end");
                },
                error: function (result) {
                    //call_progressbar("end");
                    return false;
                }
            });
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a>Performance</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <asp:LinkButton ID="lbtnperformancegraph" runat="server" Text="[ Performance Graph ]"></asp:LinkButton>
        <asp:HiddenField ID="hfeid" runat="server" />
        <table width="100%" id="tabledetails" border="0" cellspacing="0" cellpadding="0" runat="server">
            <tr>
                <td>
                    <div style="float: left; margin-bottom: 10px; margin-top: 10px !important;" id="getindicators">
                        <div style="height: 15px; width: 80px; text-align: center; background-color: white; float: left; margin-left: 10Px; color: black; padding: 5px; font-weight: bold">Indicators</div>
                        <div style="height: 15px; width: 90px; text-align: center; background-color: red; float: left; margin-left: 10Px; color: white; padding: 5px">Very Poor [ 1 ]</div>
                        <div style="height: 15px; width: 80px; text-align: center; background-color: orange; float: left; margin-left: 10Px; color: white; padding: 5px">Poor [ 2 ]</div>
                        <div style="height: 15px; width: 100px; text-align: center; background-color: blue; float: left; margin-left: 10Px; color: white; padding: 5px">Average [ 3 ]</div>
                        <div style="height: 15px; width: 80px; text-align: center; background-color: skyblue; float: left; margin-left: 10Px; color: black; padding: 5px">Good [ 4 ]</div>
                        <div style="height: 15px; width: 100px; text-align: center; background-color: green; float: left; margin-left: 10Px; color: white; padding: 5px">Very Good [ 5 ]</div>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="containerHeadline" style="width: 1072px">
                    <div style="float: right; width: 100%;">
                        <asp:DropDownList ID="ddlpayid" runat="server" Width="150px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="150px">
                        </asp:DropDownList>
                    </div>
                </td>
            </tr>
            <tr class="trnorecordfound" style="display: none !important; width: 1072px">
                <td style="width: 1072px">
                    <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="11" style="width: 100%; overflow: auto">
                    <div style="height: auto; width: 1060px; overflow: auto;">
                        <asp:GridView runat="server" ID="gridperformance" Style="overflow: auto!important" ShowHeader="true" AutoGenerateColumns="false"
                            GridLines="None" CssClass="stm"
                            CellPadding="5" Width="100%" HeaderStyle-Height="0px">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="50px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Job Performance" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmainworkingdays" runat="server" Text='<%# Eval("job_performance") %>' CssClass="job_performance"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="01" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblone" runat="server" Text='<%# Eval("perform1") %>' CssClass="perform1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="02" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwo" runat="server" Text='<%# Eval("perform2") %>' CssClass="perform2" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="03" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblthree" runat="server" Text='<%# Eval("perform3") %>' CssClass="perform3" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="04" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfour" runat="server" Text='<%# Eval("perform4") %>' CssClass="perform4" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="05" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfive" runat="server" Text='<%# Eval("perform5") %>' CssClass="perform5" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="06" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsix" runat="server" Text='<%# Eval("perform6") %>' CssClass="perform6" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="07" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblseven" runat="server" Text='<%# Eval("perform7") %>' CssClass="perform7" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="08" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbleight" runat="server" Text='<%# Eval("perform8") %>' CssClass="perform8" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="09" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblnine" runat="server" Text='<%# Eval("perform9") %>' CssClass="perform9" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="10" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblten" runat="server" Text='<%# Eval("perform10") %>' CssClass="perform10" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="11" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbleleven" runat="server" Text='<%# Eval("perform11") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="12" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwelve" runat="server" Text='<%# Eval("perform12") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="13" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblthrteen" runat="server" Text='<%# Eval("perform13") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="14" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblforteen" runat="server" Text='<%# Eval("perform14") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="15" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfifteen" runat="server" Text='<%# Eval("perform15") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="16" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsixteen" runat="server" Text='<%# Eval("perform16") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="17" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblseventeen" runat="server" Text='<%# Eval("perform17") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="18" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbleighteen" runat="server" Text='<%# Eval("perform18") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="19" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblnineteen" runat="server" Text='<%# Eval("perform19") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="20" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwenty" runat="server" Text='<%# Eval("perform20") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="21" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentyone" runat="server" Text='<%# Eval("perform21") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="22" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentytwo" runat="server" Text='<%# Eval("perform22") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="23" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentythree" runat="server" Text='<%# Eval("perform23") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="24" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentyfour" runat="server" Text='<%# Eval("perform24") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="25" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentyfive" runat="server" Text='<%# Eval("perform25") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="26" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentysix" runat="server" Text='<%# Eval("perform26") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="27" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentyseven" runat="server" Text='<%# Eval("perform27") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="28" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentyeight" runat="server" Text='<%# Eval("perform28") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="29" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltwentynine" runat="server" Text='<%# Eval("perform29") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="30" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblthirty" runat="server" Text='<%# Eval("perform30") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="12px" HeaderText="31" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblthirtyone" runat="server" Style="font-weight: bold!important" Text='<%# Eval("perform31") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblthirtyone" runat="server" Text='<%# Eval("totalpoints") %>' CssClass="totalpoints" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>