<%@ Page Title="Add Bus for Student" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="addbusforsstudent.aspx.cs" Inherits="BranchPanel_addbusforsstudent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>

    <%--<script type="text/JavaScript">
$(function(){
$(this).bind("contextmenu", function(e)
{
e.preventDefault();
alert("right click is disabled");
});

});
</script>--%>

    <%--<script type="text/javascript">
    $(function () {
        $(document).bind('contextmenu', function (e) {
            e.preventDefault();
            alert('Right Click is not allowed');
        });

    });
  </script>--%>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
                $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });

            });

        });
    </script>
    <style>
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        .maindivpopup {
            position: absolute;
            background: url('../../images/body-bg.png') repeat scroll 0 0 #fff;
            z-index: 2147483647 !important;
            opacity: 1.85;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {

            var ckseat = "";
            var areaid = "";

            $('.lncheck').click(function () {

                if ($(this).text() == "Add") {

                    $("#ctl00_ContentPlaceHolder1_lblID1").text($(this).closest('tr').find('td:eq(2) span:last-child').text());
                    $("#ctl00_ContentPlaceHolder1_lblbooktitle1").text($(this).closest('tr').find('td:eq(1) span:last-child').text());
                    $("#ctl00_ContentPlaceHolder1_tofine1").text($(this).closest('tr').find('td:eq(3) span:last-child').text());

                    $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                    setTimeout(function () {

                        $("#ctl00_ContentPlaceHolder1_DropDownList1").val('');
                        $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                        $("#ctl00_ContentPlaceHolder1_DropDownList2").empty();
                        $("#ctl00_ContentPlaceHolder1_DropDownList3").empty();
                        $('#ctl00_ContentPlaceHolder1_DropDownList4').empty();

                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                        $('#ctl00_ContentPlaceHolder1_popup2').css("display", "block");

                        $(this).closest('tr').find('td:eq(0)').removeAttr("border-style").removeAttr("border-color");
                        $('.maindivpopup').css("display", "block");

                    }, 1000);
                    return false;
                }

                else {

                    $('#ctl00_ContentPlaceHolder1_popup2').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                }

                return false;

            });

            $("#ctl00_ContentPlaceHolder1_DropDownList1").change(function () {
                //alert("ashuuuu");
                var zid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList1").value;
                if (zid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList2').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList2').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "addbusforsstudent.aspx/bindarea",
                          data: "{'ddlzoneid':'" + zid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList2").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList2").append($("<option></option>").val(value.SID).html(value.statename));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });

            });

            $("#ctl00_ContentPlaceHolder1_DropDownList2").change(function () {
                //alert("ashuuuu");
                areaid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList2").value;
                if (areaid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList3').children().remove();
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                    $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "none");
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "addbusforsstudent.aspx/bindbus",
                          data: "{'areaid':'" + areaid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList3").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList3").append($("<option></option>").val(value.areaid).html(value.areaname));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });

            });

            $("#ctl00_ContentPlaceHolder1_DropDownList3").change(function () {

                var bsid = document.getElementById("ctl00_ContentPlaceHolder1_DropDownList3").value;
                var busid = $("#ctl00_ContentPlaceHolder1_DropDownList3 option:selected").text();
                //  alert(busid);
                if (busid == "0") {
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children('option:not(:first)').remove();
                    return;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_DropDownList4').children().remove();
                }

                $.ajax(
                      {
                          type: "POST",
                          contentType: "application/json; charset=utf-8",
                          url: "addbusforsstudent.aspx/binstopage",
                          data: "{'busid':'" + busid + "'}",
                          dataType: "json",
                          success: function (data) {
                              $("#ctl00_ContentPlaceHolder1_DropDownList4").html("");
                              $.each(data.d, function (key, value) {
                                  $("#ctl00_ContentPlaceHolder1_DropDownList4").append($("<option></option>").val(value.stopid).html(value.stopname));
                              });
                          },
                          error: function (result) {
                              alert("Error");
                          }
                      });

                $.ajax(
               {
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   url: "addbusforsstudent.aspx/findseat",
                   data: "{'busid':'" + busid + "'}",
                   dataType: "json",
                   success: function (data) {

                       ckseat = data.d
                       $("#ctl00_ContentPlaceHolder1_lbmssg").text(data.d + ' ' + "seats are available!");
                       $("#ctl00_ContentPlaceHolder1_lbmssg").css("display", "block");
                       $("#ctl00_ContentPlaceHolder1_lbmssg").css("color", "red");
                       if (ckseat == 0) {
                           $("#ctl00_ContentPlaceHolder1_DropDownList3").html('');
                           $("#ctl00_ContentPlaceHolder1_lbmssg").text(data.d + ' ' + "seats are available!!Please change bus!!");

                           $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "addbusforsstudent.aspx/bindbus",
                        data: "{'areaid':'" + areaid + "'}",
                        dataType: "json",
                        success: function (data) {
                            $("#ctl00_ContentPlaceHolder1_DropDownList3").html("");
                            $.each(data.d, function (key, value) {
                                $("#ctl00_ContentPlaceHolder1_DropDownList3").append($("<option></option>").val(value.areaid).html(value.areaname));
                            });
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });

                           // return false;

                       }
                       //ckseat=$("#ctl00_ContentPlaceHolder1_lbseatmsg").text(data.d);

                   },
                   error: function (result) {
                       alert("Error");
                   }
               });

            });

            $('#ctl00_ContentPlaceHolder1_button4').click(function () {

                $('#ctl00_ContentPlaceHolder1_popup2').css("display", "none");

                $('.maindivpopup').css("display", "none");
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_Button3').click(function () {

                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {

                    if (document.getElementById('<%=DropDownList1.ClientID %>').value == 0) {
                        alert("Please Select Zone.");
                        document.getElementById('<%=DropDownList1.ClientID %>').focus();
                    return false;
                }

                    if (document.getElementById('<%=DropDownList2.ClientID %>').value == 0) {
                        alert("Please Select Area.");
                        document.getElementById('<%=DropDownList2.ClientID %>').focus();
                    return false;
                }

                    if (document.getElementById('<%=DropDownList3.ClientID %>').value == 0) {
                        alert("Please Select bus .");
                        document.getElementById('<%=DropDownList3.ClientID %>').focus();
                    return false;
                }
                    if (document.getElementById('<%=DropDownList4.ClientID %>').value == 0) {
                        alert("Please select stoppage.");
                        document.getElementById('<%=DropDownList4.ClientID %>').focus();
                    return false;
                }

                    $.ajax(
                            {

                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "addbusforsstudent.aspx/insertdata",
                                data: "{'adno':'" + $("#ctl00_ContentPlaceHolder1_lblbooktitle1").text() + "','sname':'" + $("#ctl00_ContentPlaceHolder1_lblID1").text() + "','classnm':'" + $("#ctl00_ContentPlaceHolder1_tofine1").text() + "','zoneid':'" + $("#ctl00_ContentPlaceHolder1_DropDownList1").val() + "','areaid':'" + $("#ctl00_ContentPlaceHolder1_DropDownList2").val() + "','busid':'" + $("#ctl00_ContentPlaceHolder1_DropDownList3").val() + "','busno':'" + $("#ctl00_ContentPlaceHolder1_DropDownList3 option:selected").text() + "','stoppageid':'" + $("#ctl00_ContentPlaceHolder1_DropDownList4").val() + "'}",
                                dataType: "json",
                                success: function (data) {
                                    $('.maindivpopup').css("display", "none");
                                    if (data.d == 1) {
                                        window.location.reload();
                                        alert("Record Save Successfully.!");
                                        $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                        return false;
                                    }

                                    else {
                                        alert("Error.");
                                        return false;
                                    }

                                },
                            });

                }, 1000);
                return false;

            });

            function bindgrid() {

                $.ajax({
                    type: "POST",
                    url: "addbusforsstudent.aspx/binddata",
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

                            // $(row).find(".clsrno").html(srno);

                            $(row).find(".adno").html(data.d[i].ADNO);

                            $(row).find(".clsarea").html(data.d[i].sturegno);
                            $(row).find(".ApplyClass").html(data.d[i].ApplyClass);
                            $(row).find(".name").html(data.d[i].name);

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

        });
    </script>

    <style>
        .button_save {
            background-color: #3093C7;
            background-image: linear-gradient(to bottom, #27B1CE, #098EAA);
            border: 1px solid #25729A;
            border-radius: 3px;
            color: #FFFFFF;
            cursor: pointer;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            height: 28px;
            margin-bottom: 3px;
            margin-right: 5px;
            padding: 5px 6px;
            text-decoration: none;
            text-shadow: 0 -1px rgba(0, 0, 0, 0.3);
        }

        .name {
            float: none!important;
            font: bold 1.1em Verdana,Arial,Helvetica,sans-serif;
            padding-top: 0;
            width: auto;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="">Home</a></li>
            <li><a>Transport Management</a></li>
            <li style="background: none;"><a class="active">Student to Bus</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>

    <div class="content_pane_cont input_content" id="contentPane" style="border-bottom: medium none;">
        <%-- <asp:UpdatePanel ID="upd" runat="server">
            <ContentTemplate>--%>
        <%-- <div style="border-bottom: 1px solid #DDDDDD; border-top: medium none; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
        </div>--%>

        <div id="p1" class="maindivpopup" style="display: none;">
            <asp:Panel ID="popup2" runat="server" BackColor="White" Height="275px" Width="500px"
                Style="z-index: 9000000; background-color: White; position: absolute; left: 20%; top: 15%; border: outset 2px #2CA8C2; padding: 5px; display: none;">
                <table width="100%" style="width: 100%; height: 100%; border: 1px solid #2CA8C2;" cellpadding="0" cellspacing="5">
                    <tr style="background-color: #2CA8C2;">
                        <td colspan="2" style="color: White; font-weight: bold; font-size: 1.2em; padding: 3px"
                            align="center">Add Student To Bus
                        </td>
                    </tr>

                    <tr>
                        <td align="right" style="width: 45%">Name:
                        </td>
                        <td>
                            <asp:Label ID="lblID1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">ADNO:
                        </td>
                        <td>
                            <asp:Label ID="lblbooktitle1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Class:
                        </td>
                        <td>
                            <asp:Label ID="tofine1" runat="server"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Zone:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Area:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Bus:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                            <asp:Label ID="lbmssg" runat="server" Style="display: none;"></asp:Label>
                            <asp:Label ID="lbseatmsg" runat="server" Style="display: none;"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td align="right">Select Stoppage:
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" Style="width: 130px; height: 24px;"
                                AppendDataBoundItems="True">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <asp:Button ID="Button3" CssClass="button_save" Text="Update" runat="server" />
                            <asp:Button ID="button4" class="btnClose" CssClass="button_cancel" runat="server" Text="Cancel" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>

        <div id="divstudentadno1" runat="server">
        </div>

        <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
            <tr>
                <td>

                    <asp:GridView ID="griview_addarea" runat="server" EmptyDataText="No data found !" CssClass="stm" BorderWidth="0" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" GridLines="None"
                        Width="100%" OnRowDataBound="griview_addarea_RowDataBound">

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AdmissionNO" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" CssClass="adno" runat="server" Text='<% #Eval("ADNO")%>'></asp:Label>
                                    <%-- <asp:HiddenField ID="hfadid" runat="server" />--%>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Student Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" CssClass="name" Text='<% #Eval("name")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Class" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbclass" runat="server" CssClass="ApplyClass" Text='<% #Eval("ApplyClass")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>

                                    <asp:LinkButton ID="Ed1" runat="server" CssClass="lncheck" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_dark" />
                        <AlternatingRowStyle CssClass="stm_light" />
                        <HeaderStyle CssClass="stm_head" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>