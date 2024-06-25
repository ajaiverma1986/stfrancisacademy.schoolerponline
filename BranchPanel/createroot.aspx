<%@ Page Title="Create Route" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="createroot.aspx.cs" Inherits="BranchPanel_createroot" EnableEventValidation="false" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
        .active4 {
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

        .stm td {
            border-bottom: 1px solid #DDDDDD;
            color: #333333;
            line-height: 35px;
          padding: 7px 20px;
    text-align: left;
        }

        #uniform-ctl00_ContentPlaceHolder1_radiobtn_0 {
            margin-top: 12px;
        }

        #uniform-ctl00_ContentPlaceHolder1_radiobtn_1 {
            margin-top: 12px;
        }
    </style>

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

    <div class="content_top" >
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a >Master Settings</a></li>
            <li><a>Transport Settings</a></li>
            <li style="background: none;"><a class="active">Create Route</a></li>

            <div class="arrowt">
                <a href="../Branchpanel/createroot.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">

        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
            <span style="line-height: 39px;">
                <asp:Label ID="lblroot1" runat="server"></asp:Label></span>
            <%-- <asp:Button runat="server" ID="Button2" CssClass="button_save45" Text="Add Rout"
        ToolTip="Click here to Add Rout." OnClick="Button2_Click"   />--%>
        </div>
        <br />
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>

                <div class="for_sigle_row_form">
                    <label>
                        Route No(Name)<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtrouteno" runat="server" AutoPostBack="true" OnTextChanged="txtrouteno_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Route No."
                        ControlToValidate="txtrouteno" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Source<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtorigin" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Origin"
                        ControlToValidate="txtorigin" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Destination<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtdest" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter Destination"
                        ControlToValidate="txtdest" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Distance(in KM)<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtdistance" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Enter Destination"
                        ControlToValidate="txtdistance" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form" id="busstop">

                    <label id="li1" runat="server">
                        Number of Bus Stops<span style="color: Red;">* </span>
                    </label>
                    <asp:TextBox ID="txtstops" runat="server" AutoPostBack="true"
                        onkeypress="return noAlphabets(event)" OnTextChanged="txtstops_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter No of Stops"
                        ControlToValidate="txtstops" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <tr>
                    <td id="abc" runat="server">

                        <div class="for_sigle_row_form" id="createstopage" runat="server">
                            <label>Do you want Create Stopage<span style="color: Red">*</span></label>
                            <asp:RadioButtonList runat="server" ID="radiobtn" RepeatDirection="Horizontal" AutoPostBack="true"
                                OnSelectedIndexChanged="radiobtn_SelectedIndexChanged" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="2" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>&nbsp;
                        </div>
                    </td>
                </tr>

                <div class="for_sigle_row_form">
                    <tr>
                        <td id="stopposition" runat="server">
                            <label>
                                New Stopage position:<span style="color: Red;">* </span>
                            </label>
                            <asp:TextBox ID="txtpos" runat="server" AutoPostBack="true"
                                onkeypress="return noAlphabets(event)" OnTextChanged="txtpos_TextChanged"></asp:TextBox>
                        </td>
                    </tr>
                </div>

                <div class="for_sigle_row_form" style="margin-left: 0px;">
                    <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-top: medium none; border-left: none !important; border-bottom: none;">
                        <tr>
                            <td>
                                <asp:GridView ID="Gridview1" GridLines="None" runat="server"
                                    AutoGenerateColumns="false"
                                    OnRowDataBound="Gridview1_RowDataBound" OnRowEditing="Gridview1_RowEditing"
                                    OnRowUpdating="Gridview1_RowUpdating" OnRowCommand="Gridview1_RowCommand" HeaderStyle-Height="30px"
                                    OnSelectedIndexChanged="Gridview1_SelectedIndexChanged" Width="100.3%"
                                    class="stm">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Select Sector">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlzone" runat="server" Width="100%" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddl_Course_SelectedIndexChanged">
                                                </asp:DropDownList>

                                                <asp:Label ID="lblzon" runat="server" Text="Lunch" Visible="false"></asp:Label>
                                            </ItemTemplate>

                                            <%--<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Select Society">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlarae" runat="server" Width="100%" AutoPostBack="true" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlarae_SelectedIndexChanged">
                                                </asp:DropDownList>

                                                <asp:Label ID="lbllunch" runat="server" Text="Lunch" Visible="false"></asp:Label>
                                            </ItemTemplate>

                                            <%--<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>--%>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Road Name">
                                            <ItemTemplate>
                                                <%--<asp:TextBox ID="TextBox2" runat="server" Width="100%"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlroad" runat="server" Width="100%" AutoPostBack="true"></asp:DropDownList>

                                                <asp:Label ID="lblroadname" runat="server" Text='<%#Eval("status") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Stop Name">
                                            <ItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server" Width="95%"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkstatus1" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <AlternatingRowStyle CssClass="stm_dark" />

                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="clear"></div>
                
                <div style="margin-left: 35.6%;">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save"
                        OnClick="btnsubmit_Click" />
                    <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="button_save"  style="background-color:red" CausesValidation="false"
                        OnClick="btncancel_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save" CausesValidation="false"
                        OnClick="btncancel1_Click" Visible="false" />
                    <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>