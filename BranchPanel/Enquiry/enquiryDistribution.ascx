<%@ Control Language="C#" AutoEventWireup="true" CodeFile="enquiryDistribution.ascx.cs" Inherits="BranchPanel_enquiry_enquiry" %>

<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">

        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/enq.jpg" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Enquiries</asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt></dt>
            <span></span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt></dt>
            <span></span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">

        <%-- Add Enquiry--%>
       <%-- <asp:Button ID="btn_addenquiry" runat="server" Text="Add Enquiry" class="sgpt1 active0" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="enquiry.aspx" />--%>
            
        <%-- View enquiry List--%>
        <asp:Button ID="btnOverallenquiry" runat="server" Text="Overall Enquiry" class="sgpt1 active2" ToolTip="Click here to Overall enquiry"
            CausesValidation="false" PostBackUrl="enquiryDetail.aspx" /><%--enquiryDetail.aspx--%>

        <%-- Follow Up Enquiry--%>

          <asp:Button ID="btnEnquiryReport" runat="server" Text="User's Rights Report" class="sgpt1 active22" ToolTip="Click here to User's Writes Report"
            CausesValidation="false" PostBackUrl="selectequdis.aspx"  />

          <%-- Add Enquiry--%>
   <%--     <asp:Button ID="btncontactenquiry" runat="server" Text="Contact Enquiry" class="sgpt1 active222" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="contact-enquiry.aspx" />--%>

         <%-- Add Enquiry--%>
        <%--<asp:Button ID="btnEnquiryDistribution" runat="server" Text="Enquiry Distribution" class="sgpt1 active222" ToolTip="Click here to Enquiry Distribution"
            CausesValidation="false" PostBackUrl="edistribution.aspx" />--%>

         
      
       
    </div>
</div>