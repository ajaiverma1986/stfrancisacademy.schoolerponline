<%@ Page Title="Registration List" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="registration-list.aspx.cs" Inherits="BranchPanel_registration_list" %>

<%@ Register Src="~/BranchPanel/registration.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--js for calenders--%>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../Calender/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript" rel="stylesheet" />
    <style type="text/css">
        .activereg {
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
    </style>
    <script type="text/javascript">
        var a = jQuery.noConflict();
        var datefrom = '', dateto = '', status = '0', classid = '', mobileno = '', regno = '', name = '', studentstatus = '', fyid = '', pageno = 1, pagecount = 1;
        var pagesize = 20;
        function pageLoad() {
            pagecount = $("#ctl00_ContentPlaceHolder1_hfpages").val();

            $("#ctl00_ContentPlaceHolder1_lblpage").html(1);
            $("#ctl00_ContentPlaceHolder1_lblTotalPages").html(pagecount);
        }
        a(document).ready(function () {
            a(document).on("click", "[id*=gvdetails] [id*=lnkview]", function () {
                var id;
                id = $(this).parent('div').find('.cllblpmid').text();
                window.location.href = "viewregistration.aspx?RId=" + id;
                return false;
            });

            a(document).on("click", "[id*=gvdetails] [id*=lbRegNo]", function () {
                var id;
                id = $(this).parent('div').find('.cllblpmid').text();
                window.location.href = "regconfirm.aspx?RId=" + id;
                return false;
            });

            a("#ctl00_ContentPlaceHolder1_txtdatefrom").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
            });
            a("#ctl00_ContentPlaceHolder1_txtdateto").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
            });

            a("#ctl00_ContentPlaceHolder1_txtdatefrom").on('change', function () {
                datefrom = a("#ctl00_ContentPlaceHolder1_txtdatefrom").val();
                pageno = 1;
                GetStudentlist();

            });
            a("#ctl00_ContentPlaceHolder1_txtdateto").on('change', function () {
                dateto = a("#ctl00_ContentPlaceHolder1_txtdateto").val();
                pageno = 1;
                GetStudentlist();

            });

            a('#ctl00_ContentPlaceHolder1_ddlclass').change(function () {
                classid = a(this).val();
                pageno = 1;
                GetStudentlist();
            });
            a("#ctl00_ContentPlaceHolder1_ddlstatus").change(function () {
                status = $(this).val();
                pageno = 1;
                GetStudentlist();
            });
            a('#ctl00_ContentPlaceHolder1_txtmobileno').on('change', function () {
                mobileno = a(this).val();
                pageno = 1;
                GetStudentlist();
            });
            a('#ctl00_ContentPlaceHolder1_txtregno').on('change', function () {
                regno = a(this).val();
                pageno = 1;
                GetStudentlist();
            });

            a('#ctl00_ContentPlaceHolder1_txtname').on('change keyup', function () {
                name = a(this).val();
                pageno = 1;
                GetStudentlist();
            });
            a("#ctl00_ContentPlaceHolder1_ddlfy").change(function () {
                fyid = a(this).val();
                pageno = 1;
                GetStudentlist();
            });

            //@@@@@@@@@@@@ code for paging @@@@@@@@@@@
            $("#btnfirst").click(function () {
                pageno = 1;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                GetStudentlist();
            });
            $("#btnprev").click(function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    GetStudentlist();
                }
            });
            $("#btnnext").click(function () {

                if (parseInt(pageno) < parseInt(pagecount)) {
                    pageno = parseInt(pageno) + 1;
                    $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                    GetStudentlist();
                }

            });
            $("#btnlast").click(function () {

                pageno = pagecount;
                $("#ctl00_ContentPlaceHolder1_lblpage").html(pageno);
                GetStudentlist();
            });
            $('#ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lnkrequestlist').click(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../EmployeePanel/requestleave.aspx/getenrollmentdate",
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        status = data.d[0].status;
                        if (status == "1") {
                            window.location.replace("add-new-registration.aspx");
                            return false;
                        }
                        else {
                            alert('Registrations closed for this session');
                            return false;
                        }
                    },
                    error: function (result) {
                        alertify.alert('error');

                    }
                });
                //window.location.replace("add-new-registration.aspx");
                return false;
            });
        });
        function GetStudentlist() {
            $.ajax({
                type: "POST",
                url: "common.aspx/BindDatatable",
                data: "{'status':'" + status + "','datefrom':'" + datefrom + "','dateto':'" + dateto + "','classid':'" + classid + "','mobileno':'" + mobileno + "','regno':'" + regno + "','name':'" + name + "','studentstatus':'" + studentstatus + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','fyid':'" + fyid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var srno = 1;
                    $("[id*=gvdetails] tr:gt(1)").remove();

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                            $("[id$=gvdetails]").append(row);
                            $(row).find(".sno1").html(data.d[i].RowNumber);
                            $(row).find(".date1").html(data.d[i].registrationdate);
                            $(row).find(".registrationno").html(data.d[i].Registrationno);
                            $(row).find(".sname1").html(data.d[i].name);
                            $(row).find(".fname1").html(data.d[i].Fname);
                            $(row).find(".applyclass1").html(data.d[i].applyclass);
                            $(row).find(".cllblpmid").html(data.d[i].Rid);
                            $(row).find(".FMobileNo").html(data.d[i].Fmobile);
                            $(row).find(".stustatus").html(data.d[i].stustatus);

                            pagecount = data.d[i].pagecount;
                            if (pagecount == 1) {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                                $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                            }
                            else {
                                $("#ctl00_ContentPlaceHolder1_lblTotalPages").text(pagecount);
                                $("#ctl00_ContentPlaceHolder1_lblpage").text(pageno);
                            }

                            $(".registrationno").css("color", "#d2691e");
                            $(".xyz").css("color", "#d2691e");
                        }
                    }
                    else {
                        var row = $("[id*=gvdetails] tr:eq(1)").clone(true);
                        $("[id$=gvdetails]").append(row);

                        $(".xyz").css("color", "white");
                        $(".xyz").css("text-decoration", "none");
                        $(row).find(".sno1").html("");
                        $(row).find(".date1").html("");
                        $(row).find(".registrationno").html("");
                        $(row).find(".sname1").html("");
                        $(row).find(".fname1").html("No Record Found");
                        $(row).find(".applyclass1").html("");
                        $(row).find(".cllblpmid").html("");
                        $(row).find(".FMobileNo").html("");
                        $(row).find(".stustatus").html('');
                        $(".registrationno").css("text-decoration", "none");
                        $(".registrationno").css("color", "black");
                        $("#ctl00_ContentPlaceHolder1_lblpage").text("1");
                        $("#ctl00_ContentPlaceHolder1_lblTotalPages").text("1");
                    }

                    $("[id*=gvdetails] tr").show();
                    $("[id*=gvdetails] tr:eq(1)").hide();
                },
                error: function (result) {
                    alert("Error");
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
        class="stm">
        <tr>
            <td colspan="10" class="containerHeadline">
                <asp:HiddenField ID="hfpages" runat="server" />

                <div style="float: left; width: 1046px;">

                    <asp:DropDownList ID="ddlclass" runat="server" Width="110px"></asp:DropDownList>
                    <asp:TextBox ID="txtname" runat="server" placeholder="Enter Name" Width="100px" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtregno" runat="server" placeholder="Enter Registration" Width="107px" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtmobileno" runat="server" placeholder="Enter Mobile" Width="100px" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtdatefrom" runat="server" placeholder="Date From" Width="110px" Height="23px"> </asp:TextBox>
                    <asp:TextBox ID="txtdateto" runat="server" placeholder="Date To" Width="110px" Height="23px"> </asp:TextBox>
                    <asp:DropDownList ID="ddlfy" runat="server" Width="110px"></asp:DropDownList>
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
                <asp:GridView runat="server" ID="gvdetails" ShowHeader="true" AutoGenerateColumns="false"
                    GridLines="None" Width="100%" CssClass="stm" EmptyDataText="No record Found.!">
                    <Columns>

                        <asp:BoundField DataField="Rownumber" ItemStyle-CssClass="sno1" HeaderText="S.No." ItemStyle-Width="14%"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="RegistrationDate" ItemStyle-CssClass="date1" HeaderText="Date" runat="server" DataFormatString="{0:dd/MM/yyyy}"
                            ItemStyle-Width="16%" ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderText="Registration No" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div>
                                    <asp:LinkButton ID="lbRegNo" CssClass="registrationno" Style="text-decoration: none" runat="server" Text='<%# Bind("Registrationno") %>'
                                        ToolTip="Click here to see the registration slip"></asp:LinkButton>
                                    <asp:Label ID="lblrid" Text='<%#Eval("Rid")%>' runat="server" CssClass="cllblpmid" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="14%" />
                        </asp:TemplateField>

                        <asp:BoundField DataField="name" ItemStyle-CssClass="sname1" HeaderText="Student Name" ItemStyle-Width="14%"
                            ItemStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="Fname" ItemStyle-CssClass="fname1" HeaderText="Father's Name" ItemStyle-Width="14%"
                            ItemStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="Fmobileno" ItemStyle-CssClass="FMobileNo" HeaderText="Father's Mobile" ItemStyle-Width="14%"
                            ItemStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="applyclass" ItemStyle-CssClass="applyclass1" HeaderText="Apply class" ItemStyle-Width="14%"
                            ItemStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="stustatus" ItemStyle-CssClass="stustatus" HeaderText="Status" ItemStyle-Width="10%"
                            ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="View" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <div>

                                    <asp:LinkButton ID="lnkview" runat="server" class="xyz" Text="View"></asp:LinkButton>
                                    <asp:Label ID="lblpmid" Text='<%#Eval("Rid")%>' runat="server" CssClass="cllblpmid" Style="display: none"></asp:Label>
                                </div>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="9%" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light" />
                    <AlternatingRowStyle CssClass="stm_dark" />
                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 40%" class="containerHeadline">
                <asp:Label ID="lblpage" Style="color: green; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                <asp:Label ID="Label1" runat="server" Style="color: green; font-size: 11pt"></asp:Label>
                Of
                <asp:Label ID="lblTotalPages" Style="margin-left: 0px; font-size: 11pt; font-weight: bold" runat="server"></asp:Label>
                <span style="font-size: 11pt">Page</span>
            </td>

            <td colspan="10" class="containerHeadline" style="padding-left: 10px; padding-bottom: 5px; border: 2px; width: 100%">

                <div style="margin-left: 0px; float: left; width: 300px;">

                    <img src="../images/first.gif" id="btnfirst" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../images/previous.gif" id="btnprev" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../images/next.gif" id="btnnext" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                    <img src="../images/last.gif" id="btnlast" style="cursor: pointer; width: 22px; height: 22px" alt="" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>