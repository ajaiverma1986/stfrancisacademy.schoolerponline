<%@ Page Title="Add Bus to Route" Language="C#" AutoEventWireup="true" CodeFile="bustoroute.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_bustoroute" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
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
                $("#ctl00_ContentPlaceHolder1_txtMDOB").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>
    <style>
        #ctl00_ContentPlaceHolder1_GridStateDetail_ctl03_rblday label {
            display: none;
        }

        .style1 {
            height: 38px;
        }
    </style>
    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a href="#">Master Settings</a></li>
            <li><a href="#">Transport Settings</a></li>
            <li style="background: none;"><a class="active" href="#">Add Bus to Route</a></li>

            <div class="arrowt">
                <a href="../Branchpanel/bustoroute.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
        <%-- <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <div class="clear">
    </div>

    <script type="text/javascript">
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
       ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
       (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
               && (charCode <= 90))
                return false;

            return true;
        };
    </script>
    <style type="text/css">
        .active7 {
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

    <style type="text/css">
        .divContent {
            background-color: White;
            padding: 30px 30px 30px 30px;
            min-height: 800px;
        }

        .tblRectangleBorder {
            font-family: Arial,Helvetica,sans-serif;
            background-color: White;
            color: Black;
            -webkit-box-shadow: 0px 0px 1px 4px #fafafa;
            -moz-box-shadow: 0px 0px 1px 4px #F8A88D;
            box-shadow: 0 0 10px #D0D0D0 inset;
            border-radius: 7px;
            padding: 30px 20px 30px 20px;
            align: center;
        }

        .firstTD {
            margin-bottom: -0.75em;
            margin-top: -0.2em;
            height: auto;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 0px 0px 0px 20px;
            color: #1C6099;
            font-weight: normal;
            padding-right: 15px;
        }

        .secondTD {
            font-size: 14px;
            font-family: Arial,Helvetica,sans-serif;
            text-align: left;
            padding-left: 20px;
        }

        .ddl {
            margin-top: 5px;
            height: 29px;
            margin: 10 0 5px;
            padding: 5px;
            width: 243px;
            border-radius: 4px;
            margin-top: 7px;
        }

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }

        .aspButton {
            border: 1px solid #ff6262;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 15px;
            font-family: arial, helvetica, sans-serif;
            padding: 3px 8px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #ff3434;
            background-image: linear-gradient(to bottom, #ff9a9a, #ff4040);
        }

        .style1 {
            margin-bottom: -0.75em;
            margin-top: -0.2em;
            height: 26px;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 14px;
            font-weight: normal;
            color: #1C6099;
            font-weight: normal;
            padding-right: 15px;
            padding-left: 20px;
            padding-top: 0px;
            padding-bottom: 0px;
        }

        .style2 {
            font-size: 14px;
            font-family: Arial,Helvetica,sans-serif;
            text-align: left;
            padding-left: 20px;
            height: 26px;
        }
    </style>

    <div class="content_pane_cont input_content" id="Div1" runat="server">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
            <span style="line-height: 39px;">Add Bus to Route</span>
            <asp:Button runat="server" ID="Button2" CssClass="view-enquiry" Text="Add"
                OnClick="Button1_Click" Style="float: right; margin-top: 8.5px;" />
        </div>

        <div id="divmn" runat="server" style="margin-top: 15px;">

            <div class="for_sigle_row_form">
                <label>
                    Route No(Name)<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlroute" runat="server"
                    OnSelectedIndexChanged="ddlroute_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Route No."
                    ControlToValidate="ddlroute" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>

            <div class="for_sigle_row_form">
                <label>
                    Bus No<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlbus" runat="server"
                    OnSelectedIndexChanged="ddlbus_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please select Bus."
                    ControlToValidate="ddlbus" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
        </div>

        <table style="width: 100%" id="abc" runat="server">

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Vehicle Registration No.<span style="color: Red;">*</span></label>

                        <asp:TextBox ID="txtRegNo" runat="server" Enabled="true"
                            OnTextChanged="txtRegNo_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Registration No."
                            ControlToValidate="txtRegNo" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Number of Seats<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtNumOfSeat" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqnumberseat" runat="server" ErrorMessage="Please Enter Number of seats"
                            ControlToValidate="txtNumOfSeat" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Chassis No.<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtChassisNo" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqchesisno" runat="server" ErrorMessage="Please Enter Chasis No."
                            ControlToValidate="txtChassisNo" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Model<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtModel" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqmodel" runat="server" ErrorMessage="Please Enter Model"
                            ControlToValidate="txtModel" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Make<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtmake" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqmake" runat="server" ErrorMessage="Please Enter Make"
                            ControlToValidate="txtmake" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>

                    <div class="for_sigle_row_form">
                        <label>
                            Next FC Date<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtDate" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>
                            Next Tax Date<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtToDate" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td style="margin-left: 20px; font-size: 15px; background: url(../images/active.png) no-repeat; height: 32px; color: #fff; padding-left: 46px;">
                    <label><b>&nbsp;&nbsp; Insurance Co. Details</b></label>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Insurance Company Name<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtIncCmpny" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqcompanyname" runat="server" ErrorMessage="Please Enter Comapany "
                            ControlToValidate="txtIncCmpny" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Insurance Number<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtInsurenceNum" runat="server" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqinsuranceno" runat="server" ErrorMessage="Please Enter Insurace No."
                            ControlToValidate="txtInsurenceNum" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <%--<tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Contact Person<span style="color: Red;">* </span></label>
                               <asp:TextBox ID="txtCnctPersn" runat="server"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rqcontactperson" runat="server" ErrorMessage="Please Enter Contact person "
                            ControlToValidate="txtCnctPersn" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                                </div>
                                </td>
                                </tr>--%>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Contact Number<span style="color: Red;">* </span></label>
                        <asp:TextBox ID="txtCnctNum" runat="server" MaxLength="10" onblur="javascript:return IsNumeric();" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqcntnumber" runat="server" ErrorMessage="Please Enter Contact Number "
                            ControlToValidate="txtCnctNum" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                </td>
            </tr>

            <tr>
                <td>

                    <div class="for_sigle_row_form">
                        <label>
                            Next Insurance Date<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtMDOB" runat="server" Enabled="false"></asp:TextBox>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="for_sigle_row_form">
                        <label>Insurance Documents</label>

                        <asp:FileUpload ID="FileUpload1" runat="server" type="file" EnableViewState="true" />
                        <asp:Label ID="lblfile" runat="server"></asp:Label>
                    </div>
                </td>
            </tr>
        </table>

        <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
            <tr>

                <td>
                    <asp:GridView ID="Gridview1" runat="server" HeaderStyle-Height="30px" CssClass="stm" BorderWidth="0"
                        AutoGenerateColumns="false" GridLines="None" Width="100%" OnRowCommand="Gridview1_RowCommand" OnRowDataBound="Gridview1_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Route No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblrouteno" runat="server" Text='<%# Bind("Routeno") %>'>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="6%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Bus No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblbusno" runat="server" Text='<%# Bind("BusNo") %>'>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="7%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="View" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkvw" runat="server" Text="View" CommandName="view" CommandArgument='<%# Eval("BusNo") %>'></asp:LinkButton>
                                    <%-- <asp:HiddenField ID="hfid" runat="server" Value='<%# Eval("registrationno") %>' />--%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
        </table>

        <div class="for_sigle_row_form" style="margin-left: 245px; margin-top: -10px;">
            <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save"
                OnClick="btnsubmit_Click" />
            <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </div>
</asp:Content>