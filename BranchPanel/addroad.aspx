<%@ Page Title="Add Road" Language="C#" AutoEventWireup="true" CodeFile="addroad.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_addroad" enableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
        .active2 {
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
    </style>
    <style>
        #ctl00_ContentPlaceHolder1_GridStateDetail_ctl03_rblday label {
            display: none;
        }

        .style1 {
            height: 38px;
        }
    </style>
    <%-- <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>--%>

    <script type="text/javascript">

        $(document).ready(function () {
            //BindGridView();
            var rd = 0;
            $("#ctl00_ContentPlaceHolder1_divall").css("display", "none");

            $("#Button2").click(function () {

                $("#ctl00_ContentPlaceHolder1_divbtntop").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                $('#ctl00_ContentPlaceHolder1_ddl_Busroot').find('option:first').attr('selected', 'selected');
                $('#ctl00_ContentPlaceHolder1_ddlarea1').html('');
                $('#ctl00_ContentPlaceHolder1_txtroad').val('');

                $("#ctl00_ContentPlaceHolder1_divgrid1").css("display", "none");
                return false;

            });
            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_divbtntop").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_divgrid1").css("display", "block");
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddl_Busroot").change(function () {
                var zoneid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Busroot").value;
                $.ajax(
                   {

                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       url: "addroad.aspx/bindarea",
                       data: "{'zoneid':'" + zoneid + "'}",
                       dataType: "json",
                       success: function (data) {
                           $("#ctl00_ContentPlaceHolder1_ddlarea1").html("");
                           $.each(data.d, function (key, value1) {
                               $("#ctl00_ContentPlaceHolder1_ddlarea1").append($("<option></option>").val(value1.areaid).html(value1.areaname));
                           });
                       },
                       error: function (result) {
                           alert("Error");

                       }

                   });
            });

            $("#ctl00_ContentPlaceHolder1_btnAdd").click(function () {
                debugger;
                alert('hi')
                var txtname = $(this).attr("value");
                var zoneid = $("#ctl00_ContentPlaceHolder1_ddl_Busroot option:selected").val();
                var zonename = $("#ctl00_ContentPlaceHolder1_ddl_Busroot option:selected").text();
                var areaid = $("#ctl00_ContentPlaceHolder1_ddlarea1 option:selected").val();
                var areaname = $("#ctl00_ContentPlaceHolder1_ddlarea1 option:selected").text();
                var road = $("#ctl00_ContentPlaceHolder1_txtroad").val();

                $.ajax({
                    type: "POST",
                    url: "addroad.aspx/addroad",
                    data: "{'zoneid':'" + zoneid + "','zonename':'" + zonename + "','areaid':'" + areaid + "','areaname':'" + areaname + "','road':'" + road + "','roadid':'" + rd + "','textname':'" + txtname + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        bindgrid();
                        $("#ctl00_ContentPlaceHolder1_divall").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_divgrid1").css("display", "block");
                        $("#ctl00_ContentPlaceHolder1_divbtntop").css("display", "block");
                        if (d.data.length == 1) {
                            alert("Successfully added");
                            //bindRoadgrid()
                            // bindgrid();
                            return false;
                        }
                        else {
                            alert("Successfully updated");
                            // bindRoadgrid()
                            // bindgrid();
                            return false;
                        }

                    }

                });

                return false;
            });

            //function bindRoadgrid() {
            //    $.ajax({
            //        type: "POST",
            //        url: "addroad.aspx/BindDatatable",
            //        data: "{}",
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (data) {

            //            $("[id*=griview_addarea] tr:gt(1)").remove();
            //            $("[id*=griview_addarea] tr:gt(1)").remove();
            //            var srno = 1;
            //            for (var i = 0; i < data.d.length; i++) {

            //                var row = $("[id*=griview_addarea] tr:eq(1)").clone(true);

            //                $("[id$=griview_addarea]").append(row);

            //                $(row).find(".clsrno").html(srno);

            //                $(row).find(".clszone").html(data.d[i].zonename);

            //                $(row).find(".clsarea").html(data.d[i].area);
            //                $(row).find(".clsroadname").html(data.d[i].roadname);
            //                $(row).find(".clsroadid").html(data.d[i].roadid);
            //                $(row).find(".clsroadid").html(data.d[i].roadid);

            //                srno = parseInt(srno) + 1;
            //            }
            //            $("[id*=griview_addarea] tr").show();
            //            $("[id*=griview_addarea] tr:eq(1)").hide();

            //        },
            //        error: function (result) {
            //            alert("Error");
            //        }

            //    });
            //}

            function bindgrid() {

                $.ajax({
                    type: "POST",
                    url: "addroad.aspx/BindDatatable",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=griview_addarea] tr:gt(1)").remove();
                        $("[id*=griview_addarea] tr:gt(1)").remove();
                        var srno = 1;
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=griview_addarea] tr:eq(1)").clone(true);

                            $("[id$=griview_addarea]").append(row);

                            $(row).find(".clsrno").html(srno);

                            $(row).find(".clszone").html(data.d[i].zonename);

                            $(row).find(".clsarea").html(data.d[i].area);
                            $(row).find(".clsroadname").html(data.d[i].roadname);
                            $(row).find(".clsroadid").html(data.d[i].roadid);
                            $(row).find(".clsroadid").html(data.d[i].roadid);

                            srno = parseInt(srno) + 1;
                        }
                        $("[id*=griview_addarea] tr").show();
                        $("[id*=griview_addarea] tr:eq(1)").hide();

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            }

            $(".editlnk").click(function () {
                rd = $(this).closest('tr').find('.clsroadid').text();
                $("#ctl00_ContentPlaceHolder1_divall").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_divgrid1").css("display", "none");
                $("#ctl00_ContentPlaceHolder1_btnAdd").attr('value', 'Update');
                $("#ctl00_ContentPlaceHolder1_divbtntop").css("display", "none");

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "addroad.aspx/filldata",
                    data: "{'roadid':'" + rd + "'}",
                    dataType: "json",
                    success: function (data) {

                        $.each(data.d, function (key, value) {
                            $('#ctl00_ContentPlaceHolder1_ddl_Busroot').val(value.zoneid);
                            $('#ctl00_ContentPlaceHolder1_txtroad').val(value.roadname);

                            var sid = document.getElementById("ctl00_ContentPlaceHolder1_ddl_Busroot").value;
                            if (sid == "0") {
                                $('#ctl00_ContentPlaceHolder1_ddlarea1').children('option:not(:first)').remove();
                                return;
                            }
                            else {
                                $('#ctl00_ContentPlaceHolder1_ddlarea1').children().remove();
                            }

                            $.ajax(
                              {

                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "addroad.aspx/bindarea",
                                  data: "{'zoneid':'" + sid + "'}",
                                  dataType: "json",
                                  success: function (data) {
                                      $("#ctl00_ContentPlaceHolder1_ddlarea1").html("");
                                      $.each(data.d, function (key, value1) {
                                          $("#ctl00_ContentPlaceHolder1_ddlarea1").append($("<option></option>").val(value1.areaid).html(value1.areaname));
                                      });
                                      $('#ctl00_ContentPlaceHolder1_ddlarea1').val(value.areaid);
                                  },
                                  error: function (result) {
                                      alert("Error");
                                  }
                              });

                        });
                    }

                });

                return false;
            });

        });
    </script>

    <script type="text/javascript">

        $(document).ready(function () {

            $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
            setTimeout(function () {

                $.ajax({
                    type: "POST",
                    url: "addroad.aspx/BindDatatable",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        $("[id*=griview_addarea] tr:gt(1)").remove();
                        $("[id*=griview_addarea] tr:gt(1)").remove();
                        var srno = 1;
                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=griview_addarea] tr:eq(1)").clone(true);

                            $("[id$=griview_addarea]").append(row);

                            $(row).find(".clsrno").html(srno);

                            $(row).find(".clszone").html(data.d[i].zonename);

                            $(row).find(".clsarea").html(data.d[i].area);
                            $(row).find(".clsroadname").html(data.d[i].roadname);
                            $(row).find(".clsroadid").html(data.d[i].roadid);
                            $(row).find(".clsroadid").html(data.d[i].roadid);

                            srno = parseInt(srno) + 1;
                        }
                        $("[id*=griview_addarea] tr").show();
                        $("[id*=griview_addarea] tr:eq(1)").hide();
                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                return false;

            }, 1000);

        });
    </script>

    <script type="text/javascript">      //  for row command as anchor tag
        $(document).ready(function () {
            $('.swet').click(function () {
                var id;

                id = $(this).closest("td").find("[id*=lbladmiid]").text();

                window.location.replace("addroad.aspx?roadid=" + id);

                return false;

            });

        });
    </script>

    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Master Settings</a></li>
            <li><a>Transport Settings</a></li>

            <div class="arrowt">
                <a href="../Branchpanel/addroad.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
            <li style="background: none;"><a class="active">Add Road </a></li>
        </ul>
        <%--   <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div id="divbtntop" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
            <a id="Button2" class="view-enquiry" style="float: right; height: 25px; margin-right: 12px; margin-top: 5.5px; padding: 0 5px 1px;">Add Road</a>
        </div>

        <div id="divstudentadno1" runat="server">
        </div>

        <div id="divall" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Select Sector<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddl_Busroot" runat="server"
                    AppendDataBoundItems="True">
                </asp:DropDownList>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Society<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlarea1" runat="server"></asp:DropDownList>&nbsp;
                                          <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please select Area"
                                                ControlToValidate="ddlarea1" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Road Name<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtroad" runat="server"></asp:TextBox>
                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Road Name"
                    ControlToValidate="txtroad" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" />
                <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_cancel" CausesValidation="false" />
            </div>
        </div>

        <div id="divgrid1" runat="server">

            <asp:GridView ID="griview_addarea" runat="server" EmptyDataText="No data found !" CssClass="stm" GridLines="None" BorderWidth="0" HeaderStyle-Height="30px"
                AutoGenerateColumns="false" PagerSettings-Position="Bottom"
                PagerStyle-Font-Size="15px" PagerStyle-HorizontalAlign="Right"
                Width="100%">

                <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                <Columns>
                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblperiod" runat="server" Text='<%#Container.DataItemIndex+1 %>' CssClass="clsrno"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sector" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblproducname" runat="server" Text='<% #Eval("zonename")%>' CssClass="clszone"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Society" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblstatus" runat="server" Text='<% #Eval("area")%>' CssClass="clsarea"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Road Name" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Label ID="lblroad" runat="server" Text='<% #Eval("roadname")%>' CssClass="clsroadname"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" Text="Edit" ToolTip="update" CssClass="editlnk"></asp:LinkButton>
                            <asp:Label ID="lbladmiid" runat="server" CssClass="clsroadid" Text='<%#Eval("roadid") %>' Style="display: none;"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_dark" />
                <AlternatingRowStyle CssClass="stm_light" />
                <HeaderStyle CssClass="stm_head" />
            </asp:GridView>
        </div>
    </div>
    <%--  </ContentTemplate>
        </asp:UpdatePanel>--%>
</asp:Content>