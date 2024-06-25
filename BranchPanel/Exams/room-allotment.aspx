<%@ Page Title="Room Allotment" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="room-allotment.aspx.cs" Inherits="BranchPanel_Exams_room_allotment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        function validateCheckBoxes() {

            var isValid = false;
            var cnt = 0;

            if (document.getElementById('<%=ddlexamname.ClientID %>').value.trim() == 0) {
                alert("Please select exam name.");
                document.getElementById('<%=ddlexamname.ClientID %>').focus();
                return false;
            }

            var gridView = document.getElementById('<%= grdclass.ClientID %>');
            for (var i = 0; i < gridView.rows.length; i++) {

                var inputs = gridView.rows[i].getElementsByTagName('input');
                if (inputs != null) {
                    if (inputs[0].type == "checkbox") {
                        if (inputs[0].checked) {
                            isValid = true;
                            cnt++;

                        }
                    }
                }
            }

            if (cnt == 0) {
                alert("Please select atleast one Room for exam.");
                return false;
            }
            return true;
        }
    </script>

    <script src="jquery-1.2.6.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).bind('load', function () {
            var status = 0
            var headerChk = $(".chkHeader input");
            var itemChk = $(".chkItem input");
            headerChk.bind("click", function () {
                itemChk.each(function () { this.checked = headerChk[0].checked; })
                status++;
            });
            itemChk.bind("click", function () { if ($(this).checked == false) headerChk[0].checked = false; });
        });
    </script>

    <script type="text/javascript">
        var headerChk = $(".button_save input");
        headerChk.bind("click", function () {

        });
    </script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            var index1 = document.getElementById('ctl00_ContentPlaceHolder1_ddlexamname').selectedIndex;
        });
    </script>

    <div class="content_pane_cont input_content" id="contentPane">

        <div class="content_top" >
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>

            <li style="background: none;"><a class="active" href="#">Room Allotment</a></li>

            <div class="arrowt">
                <a href="testlist.aspx">
                    <img src="../images/back-button.png" /></a>
            </div>
        </ul>
    </div>


        <%--<div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Exam Setting
        </div>--%>

        <div class="for_sigle_row_form">
            <label>
                Exam Name<span style="color: Red">*</span>
            </label>
            <asp:DropDownList ID="ddlexamname" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlexamname_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="ddltest13" runat="server" ControlToValidate="ddlexamname"
                ErrorMessage="Please Select Exam Name." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>
        <div class="for_sigle_row_form">

            <label>
                Select Room for exam</label>
            <asp:GridView ID="grdclass" AutoGenerateColumns="false" BorderWidth="0" Style="margin-left: 20px;"
                runat="server" CssClass="stm" GridLines="None" EmptyDataText="No Room added in this branch">
                <Columns>

                    <asp:TemplateField HeaderText="Select All">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkhead" runat="server" CssClass="chkHeader" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkclass1" runat="server" Class="chkItem" />
                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("roomid") %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Room">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("Room") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Stregth">
                        <ItemTemplate>
                            <asp:Label ID="lblsubject1232" runat="server" Text='<%# Bind("Stregth") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="stm_dark" />
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <AlternatingRowStyle CssClass="stm_light" />
            </asp:GridView>
        </div>
        <div class="for_sigle_row_form">

            <label>
            </label>

            <asp:Button ID="btnsubmit" runat="server" Text="View Seat Allotment" CssClass="button_save" OnClick="btnsubmit_Click" OnClientClick="return validateCheckBoxes();" />
        </div>

        <asp:GridView ShowHeader="true" CssClass="stm drag_drop_grid GridSrc" HeaderStyle-BackColor="Black" ID="grd1" Style="margin-left: 10px;" CellPadding="0" HeaderStyle-Height="30px" Width="100%" BorderWidth="0" runat="server" OnRowDataBound="grd1_RowDataBound"></asp:GridView>
    </div>
</asp:Content>