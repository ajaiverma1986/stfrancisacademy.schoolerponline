<%@ Control Language="C#" AutoEventWireup="true" CodeFile="enquiry.ascx.cs" Inherits="BranchPanel_enquiry_enquiry" %>

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
        <asp:Button ID="btn_viewenquiry" runat="server" Text="Raw Enquiry" class="sgpt1 active2" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="viewenquiry.aspx" />

        <%-- Follow Up Enquiry--%>

          <asp:Button ID="impenq_btn" runat="server" Text="Lead's Follow Up Enquiry" class="sgpt1 active22" ToolTip="Click here to View Important enquiry "
            CausesValidation="false" PostBackUrl="follow-up-enquiry.aspx"  />

          <%-- Add Enquiry--%>
   <%--     <asp:Button ID="btncontactenquiry" runat="server" Text="Contact Enquiry" class="sgpt1 active222" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="contact-enquiry.aspx" />--%>

         <%-- Add Enquiry--%>
        <asp:Button ID="btnarchiveenqiry" runat="server" Text="Approved Enquiry" class="sgpt1 active2222" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="business-enquiry.aspx" />

         <%-- Add Enquiry--%>
          <%--  <asp:Button ID="btnbusiness" runat="server" Text="Archive Enquiry" class="sgpt1 active22222" ToolTip="Click here to add enquiry"
            CausesValidation="false" PostBackUrl="archive-enquiry.aspx" />--%>

         <%-- Add Enquiry--%>
        <%--<asp:Button ID="btnWrongDetail" runat="server" Text="Wrong Detail" class="sgpt1 active222222" ToolTip="Click here to Get Wrong enquiry"
            CausesValidation="false" PostBackUrl="wrongDetail.aspx" />--%>
        <%-- <asp:Button ID="btnOverallEnquiry" runat="server" Text="Overall Enquiry" class="sgpt1 active2222222" ToolTip="Click here to Get Wrong enquiry"
            CausesValidation="false" PostBackUrl="enquiryDetail.aspx" />--%>
        <%-- upload Enquiry--%>
        <%--  <asp:Button ID="btuploadenq" runat="server" Text="Upload Enquiry" class="sgpt1 active1" PostBackUrl="upload-enquiries.aspx"
            ToolTip="Click here to upload enquiry" CausesValidation="false" />--%>
      
       
    </div>
</div>