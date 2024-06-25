<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="registrationdetails.aspx.cs" Inherits="BranchPanel_registrationdetails" %>

<%@ Register Src="~/BranchPanel/registration.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../js/alertify.js"></script>
    <link type="text/css" href="../css/alertify.core.css" media="all" rel="Stylesheet" />
    <link type="text/css" href="../css/alertify.default.css" media="all" rel="Stylesheet" />
    <style type="text/css">
        .activeall {
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
        .divgridfooter {
            border-top:1px solid #D0D1D7 !important;
            border-bottom:1px solid #D0D1D7 !important;
            padding-top:5px !important;
            padding-bottom:5px !important;
            height:15px !important;
              border-left:1px solid #D0D1D7 !important;
  border-right:1px solid #D0D1D7 !important;
        }
    </style>
    <script type="text/javascript">
        var fyid = 0, classid = 0, status = 0;
        $(document).ready(function () {

            $("#classwisedetails").hide();
            $("#ctl00_ContentPlaceHolder1_btnback").hide();
            $("#ctl00_ContentPlaceHolder1_ddlstatus").hide();

            $("#ctl00_ContentPlaceHolder1_ddlfy").change(function () {
                fyid = $(this).val();
                BindGridMain();
            });

            $(".lbllkg").click(function () {
                classid = 1;
                Bindclasswise();
            });
            $(".lblukg").click(function () {
                classid = 2;
                Bindclasswise();
            });
            $(".lblist").click(function () {
                classid = 3;
                Bindclasswise();
            });
            $(".lbliind").click(function () {
                classid = 4;
                Bindclasswise();
            });
            $(".lbliiird").click(function () {
                classid = 5;
                Bindclasswise();
            });
            $(".lblivth").click(function () {
                classid = 6;
                Bindclasswise();
            });
            $(".lblvith").click(function () {
                classid = 7;
                Bindclasswise();
            });
            $(".lblvith").click(function () {
                classid = 8;
                Bindclasswise();
            });
            $(".lblviith").click(function () {
                classid = 9;
                Bindclasswise();
            });
            $(".lblviiith").click(function () {
                classid = 10;
                Bindclasswise();
            });
            $(".lblixth").click(function () {
                classid = 11;
                Bindclasswise();
            });
            $(".lblxth").click(function () {
                classid = 12;
                Bindclasswise();
            });
            $(".lblxith").click(function () {
                classid = 13;
                Bindclasswise();
            });
            $(".lblxiith").click(function () {
                classid = 14;
                Bindclasswise();
            });

            $("#ctl00_ContentPlaceHolder1_btnback").click(function () {
                $("#classwisedetails").hide(500);
                $("#totaldetails").show(500);
                $("#ctl00_ContentPlaceHolder1_ddlstatus").hide(500);
                $("#ctl00_ContentPlaceHolder1_ddlfy").show(500);
                $(this).hide(500);
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlstatus").change(function () {
                status = $(this).val();
                Bindclasswise();
            });
        });
        function BindGridMain() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registrationdetails.aspx/gettotalregistration",
                data: "{'fyid':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_gvdetails").show(500);
                        $("[id*=gvdetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find('.index').html(j);
                            //Number of Student from here.
                            $(row).find('.lbllkg').html(data.d[i].LKG);
                            $(row).find('.lblukg').html(data.d[i].UKG);
                            $(row).find('.lblist').html(data.d[i].I);
                            $(row).find('.lbliind').html(data.d[i].II);
                            $(row).find('.lbliiird').html(data.d[i].III);
                            $(row).find('.lblivth').html(data.d[i].IV);
                            $(row).find('.lblvth').html(data.d[i].V);
                            $(row).find('.lblvith').html(data.d[i].VI);
                            $(row).find('.lblviith').html(data.d[i].VII);
                            $(row).find('.lblviiith').html(data.d[i].VIII);
                            $(row).find('.lblixth').html(data.d[i].IX);
                            $(row).find('.lblxth').html(data.d[i].X);
                            $(row).find('.lblxith').html(data.d[i].XI);
                            $(row).find('.lblxiith').html(data.d[i].XII);
                            $(row).find('.lbltotal').html(data.d[i].totalstudent);
                            //Fees Details From here
                            $('.lbllkgfee').html(data.d[i].LKGfee);
                            $('.lblukgfee').html(data.d[i].UKGfee);
                            $('.lblifee').html(data.d[i].Ifee);
                            $('.lbliifee').html(data.d[i].IIfee);
                            $('.lbliiifee').html(data.d[i].IIIfee);
                            $('.lblivfee').html(data.d[i].IVfee);
                            $('.lblvfee').html(data.d[i].Vfee);
                            $('.lblvifee').html(data.d[i].VIfee);
                            $('.lblviifee').html(data.d[i].VIIfee);
                            $('.lblviiifee').html(data.d[i].VIIIfee);
                            $('.lblixfee').html(data.d[i].IXfee);
                            $('.lblxfee').html(data.d[i].Xfee);
                            $('.lblxifee').html(data.d[i].XIfee);
                            $('.lblxiifee').html(data.d[i].XIIfee);
                            $('.lbltotalfee').html(data.d[i].totalfee);
                            j = j + 1;
                        }

                        $("[id*=gvdetails] tr").show();
                        $("[id*=gvdetails] tr:eq(1)").hide();

                    }
                    else {
                        alertify.error("There not any record related this this keyword");
                        $("#ctl00_ContentPlaceHolder1_gvdetails").hide(500);

                    }
                },
                error: function (result) {
                }
            });
        }
        function Bindclasswise() {
            $("#totaldetails").hide(500);
            $("#classwisedetails").show(500);
            $("#ctl00_ContentPlaceHolder1_btnback").show(500);
            $("#ctl00_ContentPlaceHolder1_ddlfy").hide(500)
            $("#ctl00_ContentPlaceHolder1_ddlstatus").show(500);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "registrationdetails.aspx/getclasswisedata",
                data: "{'classid':'" + classid + "','status':'" + status + "'}",
                dataType: "json",
                success: function (data) {
                    var j = 1;
                    if (data.d.length > 0) {
                        $("#ctl00_ContentPlaceHolder1_gvclasswisedetails").show(500);
                        $("[id*=gvclasswisedetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvclasswisedetails] tr:eq(1)").clone(true);
                            $("[id$=gvclasswisedetails]").append(row);
                            $(row).find('.cllblpmid').html(j);
                            //Number of Student from here.
                            $(row).find('.RegistrationDate').html(data.d[i].RegistrationDate);
                            $(row).find('.RegistrationNo').html(data.d[i].RegistrationNo);
                            $(row).find('.studentname').html(data.d[i].studentname);
                            $(row).find('.father').html(data.d[i].father);
                            $(row).find('.FMobileNo').html(data.d[i].FMobileNo);
                            $(row).find('.stustatus').html(data.d[i].stustatus);
                            j = j + 1;
                        }
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_gvclasswisedetails").hide(500);
                        alertify.error("There is not any record for this selection");
                    }
                    $("[id*=gvclasswisedetails] tr").show();
                    $("[id*=gvclasswisedetails] tr:eq(1)").hide();
                },
                error: function (result) {
                }
            });
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Student Administration</a></li>
            <li><a>Registration Master</a></li>
            <li style="background: none;"><a class="active" href="#">Registration List</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
    </div>
    <asp:Button CssClass="button" ID="btnback" Style="float: right" Text="Back" runat="server" />
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
        class="stm">
        <tr>
            <td colspan="10" class="containerHeadline">
                <asp:HiddenField ID="hfpages" runat="server" />

                <div style="float: left; width: 900px;">

                    <asp:DropDownList ID="ddlfy" runat="server" Width="150px"></asp:DropDownList>
                    <asp:DropDownList ID="ddlstatus" runat="server" Width="110px">
                        <asp:ListItem Value="">-Status-</asp:ListItem>
                        <asp:ListItem Value="1">Admission</asp:ListItem>
                        <asp:ListItem Value="0">Registration</asp:ListItem>
                        <asp:ListItem Value="3">Reject</asp:ListItem>
                        <asp:ListItem Value="2">Selection</asp:ListItem>
                        <asp:ListItem Value="5">Waiting</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="left" colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                <div id="totaldetails">
                    <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                        GridLines="None" Width="100%" CssClass="stm" EmptyDataText="No record Found.">
                        <Columns>
                            <asp:TemplateField HeaderText="S.no" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblrid" Text="1" runat="server" CssClass="cllblpmid"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="LKG" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>

                                    <a class="lbllkg" style="cursor: pointer"><%#Eval("LKG")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="UKG" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblukg" style="cursor: pointer"><%#Eval("UKG")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Ist" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblist" style="cursor: pointer"><%#Eval("Ist")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="IInd" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lbliind" style="cursor: pointer"><%#Eval("IInd")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="IIIrd" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lbliiird" style="cursor: pointer"><%#Eval("IIIrd")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="IVth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblivth" style="cursor: pointer"><%#Eval("IVth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Vth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblvth" style="cursor: pointer"><%#Eval("Vth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="VIth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblvith" style="cursor: pointer"><%#Eval("VIth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="VIIth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblviith" style="cursor: pointer"><%#Eval("VIIth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="VIIIth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblviiith" style="cursor: pointer"><%#Eval("VIIIth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="IXth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblixth" style="cursor: pointer"><%#Eval("IXth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Xth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblxth" style="cursor: pointer"><%#Eval("Xth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="XIth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblxith" style="cursor: pointer"><%#Eval("XIth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="XIIth" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <a class="lblxiith" style="cursor: pointer"><%#Eval("XIIth")%></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Total" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbltotal" Text='<%#Eval("totalstudent")%>' runat="server" CssClass="lbltotal"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>

                    <div class="divgridfooter">

                    <div style="float: left; width: 8%; text-align: center;">
                        <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total Fee:" Style="color: green"></asp:Label>
                    </div>

                    <div style="float: left; width: 7%;">
                        <asp:Label ID="lbllkgfee" runat="server" CssClass="lbllkgfee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblukg" runat="server" CssClass="total" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 5%;">
                        <asp:Label ID="lblifee" runat="server" CssClass="lblifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lbliifee" runat="server" CssClass="lbliifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lbliiifee" runat="server" CssClass="lbliiifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblivfee" runat="server" CssClass="lblivfee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblvfee" runat="server" CssClass="lblvfee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblvifee" runat="server" CssClass="lblvifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblviifee" runat="server" CssClass="lblviifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 7%;">
                        <asp:Label ID="lblviiifee" runat="server" CssClass="lblviiifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 7%;">
                        <asp:Label ID="lblixfee" runat="server" CssClass="lblixfee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblxfee" runat="server" CssClass="lblxfee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblxifee" runat="server" CssClass="lblxifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lblxiifee" runat="server" CssClass="lblxiifee" Style="color: green;"></asp:Label>
                    </div>

                    <div style="float: left; width: 6%;">
                        <asp:Label ID="lbltotalfee" runat="server" CssClass="lbltotalfee" Style="color: green;"></asp:Label>
                    </div>
                        </div>
                </div>

                <div class="clear"></div>
                <div id="classwisedetails" style="float: left; width: 100%">

                    <asp:GridView runat="server" ID="gvclasswisedetails" ShowHeader="true" AutoGenerateColumns="false"
                        GridLines="None" Width="100%" CssClass="stm" EmptyDataText="No record Found.!">
                        <Columns>

                            <asp:TemplateField HeaderText="S.no" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblrid" Text="1" runat="server" CssClass="cllblpmid"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbllkg" Text='<%#Eval("RegistrationDate")%>' runat="server" CssClass="RegistrationDate"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Registration No" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblukg" Text='<%#Eval("RegistrationNo")%>' runat="server" CssClass="RegistrationNo"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblist" Text='<%#Eval("studentname")%>' runat="server" CssClass="studentname"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Father" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lbliind" Text='<%#Eval("father")%>' runat="server" CssClass="father"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mobile" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblxiith" Text='<%#Eval("FMobileNo")%>' runat="server" CssClass="FMobileNo"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblxiith" Text='<%#Eval("stustatus")%>' runat="server" CssClass="stustatus"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
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
</asp:Content>