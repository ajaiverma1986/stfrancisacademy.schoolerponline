<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="add-eidtleave.aspx.cs" Inherits="branchpanel_employee_add_eidtleave" %>

<%@ Register Src="leave-managment.ascx" TagName="emp" TagPrefix="UC1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>

    <style type="text/css">
        .addedit {
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

        .addeditleave {
            width: 80%;
            margin-left: 10%;
            padding: 5px;
        }

            .addeditleave select {
                border: 1px solid #ccc;
                border-radius: 0 !important;
                color: #676767;
                margin-bottom: 0;
                padding: 4px 5px;
                width: 245px;
            }

            .addeditleave input {
                background: #fcfcfc;
                border: 1px solid #ccc;
                color: #676767;
                font-size: 14px;
                height: 20px;
                line-height: 20px;
                padding: 3px 6px;
                text-align: left;
                transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
                width: 230px;
            }

            .addeditleave textarea {
                background: #fcfcfc;
                border: 1px solid #ccc;
                color: #676767;
                font-size: 14px;
                height: 80px;
                line-height: 20px;
                padding: 3px 6px;
                text-align: left;
                transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
                width: 230px;
            }

            .addeditleave label {
                color: #616161;
                float: left;
                font-size: 13px;
                margin-right: 20px;
                padding-top: 2px;
                text-align: right;
            }

            .addeditleave input[type="text"]:focus, textarea:focus {
                border: 1px solid #99CC00;
                box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset, 0 0 8px rgba(82, 168, 236, 0.6);
                outline: 0 none;
            }

        .important td {
            color: #fff!important;
        }

        #ContentPlaceHolder1_grdleavtype td {
            text-align: justify;
        }
    </style>
    <script type="text/javascript">

        function pageLoad() {
            document.title = 'Add/Edit Leaves';
        }

        $(document).ready(function () {

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $("#update").click(function () {
                $("#ContentPlaceHolder1_btnadd").css("display", "none");
                $("#ContentPlaceHolder1_btnupdate").css("display", "block");
                $("#leavetypes").css("display", "block");
            });

            $("#openadd").click(function () {
                if ($(this).html() == "Add Leave") {
                    $("#addleave").show(500);
                    $(this).html("Close");
                    return;
                }

                if ($(this).html() == "Close") {
                    $("#addleave").hide(500);
                    $(this).html("Add Leave");
                }
            });
            setleavestatus();

        });
        function setleavestatus() {

            var gvDrv = document.getElementById("<%=grdleavtype.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {

                var leavestatus = $("#ContentPlaceHolder1_grdleavtype tr:eq(" + i + ") td:eq(6)").find("span").text();
                if (leavestatus == "Close") {
                    $("#ContentPlaceHolder1_grdleavtype tr:eq(" + i + ") ").css("background", "#FF0000");
                    $("#ContentPlaceHolder1_grdleavtype tr:eq(" + i + ") ").addClass("important");
                }
            }
        }

        function checkvalidation() {
            if (document.getElementById('<%=txtname.ClientID %>').value.trim() == "") {
                alertify.error("Please Enter Leave Name");
                document.getElementById('<%=txtname.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtylimit.ClientID %>').value.trim() == "") {
                alertify.error("Please Enter Limit");
                document.getElementById('<%=txtylimit.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtleavecode.ClientID %>').value.trim() == "") {
                alertify.error("Please Enter Leave Code");
                document.getElementById('<%=txtleavecode.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtcflimit.ClientID %>').value.trim() == "") {
                alertify.error("Please Enter Carry Forword Limit");
                document.getElementById('<%=txtcflimit.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtdesc.ClientID %>').value.trim() == "") {
                alertify.error("Please Enter Description");
                document.getElementById('<%=txtdesc.ClientID %>').focus();
                return false;
            }
        }
        function fixedlength(txtquantity, keyEvent, maxlength) {
            var val = txtquantity.value;
            if (txtquantity.value.length > maxlength) {
                txtquantity.value = txtquantity.value.substr(0, maxlength);
            }
            else if (txtquantity.value.length < maxlength || txtquantity.value.length == maxlength) {

                txtquantity.value = txtquantity.value.replace(/[^\d]+/g, '');
                return true;
            }
            else
                return false;
        }
    </script>
    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Leave Managment</a></li>
            <li style="background: none;"><a class="active" href="add-eidtleave.aspx">Add/Edit Leaves</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <UC1:emp runat="server" ID="empuser" />
        <div style="width: 100%; background: #016fa7; color: #fff !important; font-family: calibri; font-size: 18px; height: 40px; line-height: 40px; margin-top: 0px; padding: 0 10px;">
            <label>Add Leave Types</label>
            <li style="display: none">
                <asp:LinkButton runat="server" Style="float: right; margin-right: 20px" ID="lnkopn" Text="Update Leave" OnClick="lnkopn_Click"></asp:LinkButton></li>
        </div>

        <div id="addleave" style="display: none">

            <div class="addeditleave" style="margin-top: 10px;">
                <div style="float: left; padding: 10px; width: 100%; display: none" id="leavetypes" runat="server">
                    <label style="margin-left: 18px">Available</label>
                    <asp:DropDownList runat="server" ID="ddlleavetype" AutoPostBack="true" OnSelectedIndexChanged="ddlleavetype_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div style="float: left; padding: 10px">
                    <label>Enter Name</label>
                    <asp:TextBox ID="txtname" runat="server" PLaceholder="ie: Annual"></asp:TextBox>
                </div>

                <div style="float: left; margin-left: 30px; padding: 10px; width: 400px">
                    <label>Code</label>
                    <asp:TextBox ID="txtleavecode" Width="80" placeholder="ie:AL" runat="server"></asp:TextBox>
                </div>

                <div style="float: left; padding: 10px">
                    <label>Yearly Limit</label>
                    <asp:TextBox ID="txtylimit" Width="90" placeholder="ie:10" runat="server" onblur="return fixedlength(this, event, 2);"
                        onkeypress="return fixedlength(this, event, 2);" onkeyup="return fixedlength(this, event, 2);"></asp:TextBox>
                </div>

                <div style="float: left; margin-left: 30px; padding: 10px">
                    <label style="margin-left: 43px;">Carry Foward Limit</label>
                    <asp:TextBox ID="txtcflimit" Width="90" placeholder="ie:5" runat="server" onblur="return fixedlength(this, event, 2);"
                        onkeypress="return fixedlength(this, event, 2);" onkeyup="return fixedlength(this, event, 2);"></asp:TextBox>
                </div>

                <div style="float: left; padding: 10px">
                    <label>Description</label>
                    <asp:TextBox ID="txtdesc" TextMode="MultiLine" placeholder="ie:This is for a year" Width="441px" runat="server"></asp:TextBox>
                </div>
            </div>
            <div style="float: left">
                <br />
                <asp:CheckBox runat="server" ID="chkactdeact" Checked="true" Text="Active" Style="font-size: 14px; color: #616161; display: none" />
                <asp:Button runat="server" ID="btnadd" OnClientClick="return checkvalidation()" OnClick="btnadd_Click" Text="Add" CssClass="button_save" />
                <asp:Button runat="server" ID="btnupdate" OnClientClick="return checkvalidation()" OnClick="btnupdate_Click" Style="display: none" Text="update" CssClass="button_save" />
            </div>
        </div>
        <div style="float: left; width: 100%">
            <br />
            <a id="openadd" style="float: right; cursor: pointer; margin-right: 20px; margin-top: -0px">Add Leave</a>
            <br />
            <br />
            <asp:GridView ID="grdleavtype" runat="server" Width="100%" GridLines="none" CssClass="stm"
                AutoGenerateColumns="False" ShowFooter="false" EmptyDataText="no project added">
                <Columns>
                    <asp:TemplateField HeaderText="S No.">
                        <ItemTemplate>
                            <asp:Label ID="Lab" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Leave Name">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("Leave_Type") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Code">
                        <ItemTemplate>

                            <asp:Label ID="lblprojectid" runat="server" Text='<%#Eval("leavecode") %>' CssClass="id"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Limit/Year">
                        <ItemTemplate>
                            <asp:Label ID="lblclient" runat="server" Text='<% # Eval("limit")%>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="carry Fwd">
                        <ItemTemplate>
                            <asp:Label ID="lblcontact" runat="server" Text='<% # Eval("carryfwd")%>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="lbldomain" runat="server" Text='<% # Eval("description")%>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="60%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblplan" runat="server" Text='<% # Eval("status")%>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>