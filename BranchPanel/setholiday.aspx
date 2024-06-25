<%@ Page Title="Set Holiday" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="setholiday.aspx.cs" Inherits="BranchPanel_setholiday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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

     <script type="text/javascript">
         function valid() {
             if (document.getElementById('<%=txtDate.ClientID %>').value.trim() == "") {
                 alert("Please select date !");
                 document.getElementById('<%=txtDate.ClientID %>').focus();
                 return false;

             }
             if (document.getElementById('<%=txt1.ClientID%>').value.trim() == "") {
                 alert("Please enter reason  !");
                 document.getElementById('<%=txt1.ClientID%>').focus();

                 return false;

             }
         }
</script>
     <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Holidays </a></li>
            <%--<li style="background: none;"><a class="active">--%>
               <%-- <asp:Label runat="server" Text="" ID="lblhead">Holidays</asp:Label></a></li>--%>
        </ul>
        <div class="arrowt">
            <a href="StaffAttendance.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>
     <div id="dvnhh" runat="server">
        <asp:Button ID="btnadd" runat="server" Text="Add Holiday" CssClass="button_save" OnClick="btnadd_Click" />

         <%--<asp:Button ID="btnbck" runat="server" Text="Back" CssClass="button_save" OnClick="btnbck_Click"  />--%>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px;
            padding-top: 0px;" class="containerHeadline">

              <asp:Label ID="lbl"  runat="server">
            List Of Holidays
             </asp:Label>

            <div runat="server" id="div2" style="float: right; width: 210px; position: relative;
                left: -19px;">
                <asp:DropDownList ID="ddlsearchoption" runat="server" Height="24px"  Width="150px" OnSelectedIndexChanged="ddlsearchoption_SelectedIndexChanged">
                            <asp:ListItem Value="0">--Select month--</asp:ListItem>
                           <asp:ListItem Value="1">January</asp:ListItem>
                         <asp:ListItem Value="2">February</asp:ListItem>
                         <asp:ListItem Value="3">March</asp:ListItem>
                          <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                             <asp:ListItem Value="6">June</asp:ListItem>
                             <asp:ListItem Value="7">July</asp:ListItem>
                             <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                        </asp:DropDownList>

                <asp:Button ID="btn" runat="server" Text="Go" CssClass="view-enquiry" OnClick="btn_Click" />
                </div>
               </div>

      <div id="dd1" runat="server">
         <table style="width: 100%" ">

      <tr>
                <td>
                    <div class="for_sigle_row_form">
                       <label>
                            Select Date<span style="color: Red;">* </span>
                        </label>

                     <asp:TextBox runat="server" ID="txtDate" placeholder="Select Date"
                     Height="24px" onkeypress="return noAlphabets(event)"
                    ></asp:TextBox></div>
                </td>
            </tr>
             <tr>
                 <td>

                     <div class="for_sigle_row_form">

                         <label>
                             Reason<span style="color: Red;">* </span>
                         </label>

                     <asp:TextBox runat="server" ID="txt1"

                     Height="79px" TextMode="MultiLine" Width="342px"
                    ></asp:TextBox>
                     </div>
                 </td>
             </tr>

               <tr>
                <td>
                    <div class="for_sigle_row_form">
                       <label> Status<span style="color: Red;">* </span> </label>
              <asp:checkbox ID ="chkstatus" runat="server" Height="20px" Width="20px"  /></div>
                </td>
                </tr>

              <tr>
                <td>                <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save" OnClick="btnsubmit_Click" OnClientClick="return valid();" />
                          <asp:Button ID="btnupd" runat="server" Text="Update" CssClass="button_save" OnClick="btnupd_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_save" OnClick="Button1_Click" />
                            </div>
                </td>
                </tr>
                </table>
        </div>

    <div id="dvn" runat="server">

         <table style="width: 100%; border-left: none !important;">
            <tr>
                <td>
                    <asp:GridView ID="Grid_holiday" AutoGenerateColumns="false" Width="100%" BorderWidth="0" Visible="false"
                        runat="server"   CssClass="stm" GridLines="None" OnRowCommand="Grid_holiday_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="S No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" Text='<%# Eval("date") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reason">
                                <ItemTemplate>
                                    <asp:Label ID="lblreason" Text='<%# Eval("reason") %>' runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Edit">

                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit5" CommandArgument='<%# Eval("snp") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>

                               <asp:TemplateField HeaderText=" Option">
                                <ItemTemplate>
                                    <asp:LinkButton ID="viewoption" class="gridViewToolTip" runat="server"  CommandName="edit12" Text="Delete" CommandArgument='<%# Eval("snp") %>' onclientclick="return confirm('Are you sure you want to delete this Holiday?');" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                        <AlternatingRowStyle CssClass="stm_light" />
                   </asp:GridView>
                </td>
            </tr>
        </table>
        </div>
     </div>
</asp:Content>