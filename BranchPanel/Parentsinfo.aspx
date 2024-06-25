<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Parentsinfo.aspx.cs" Inherits="BranchPanel_Parentsinfo" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .active5 {
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
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">View Admission</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="Div1">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="for_sigle_row_form" style="position: relative; margin-left: -70px">
            <div class="separator bg-blue"></div>

            <div id="cont123" style="display: block;">

                <div class="for_sigle_row_form">
                    <div class="user_phot_frame">
                        <asp:Image runat="server" ID="imgFather" />
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label style="font-weight: bold;">
                        Father Details</label>
                    <br />
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Father's Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtFMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtFLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                </div>
                <div class="for_sigle_row_form">
                    <%--<label>
                                                    Date of Birth</label>--%>
                    <asp:TextBox ID="txtDate" runat="server" Visible="false"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Nationality</label>
                    <asp:TextBox ID="txtFNation" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Academic Qualification<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlQualifiaction1">
                        <asp:ListItem Value="0">--Select one--</asp:ListItem>
                        <asp:ListItem Value="1">10th</asp:ListItem>
                        <asp:ListItem Value="2">12th</asp:ListItem>
                        <asp:ListItem Value="3">Graduate</asp:ListItem>
                        <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Occupation<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtFOccup" runat="server"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtFDesig" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name of Organization</label>
                    <asp:TextBox ID="txtFON" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Office/Business Address</label>
                    <asp:TextBox runat="server" ID="txtAddressF" TextMode="MultiLine"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtFPhone"
                            MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtFPhone"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mobile No.<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtFMobile" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="rqd" ControlToValidate="txtFMobile"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <asp:UpdatePanel runat="server" ID="upd123">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <label>
                                EmailId</label>
                            <asp:TextBox ID="txtFEmailid" runat="server"></asp:TextBox>&nbsp;
                                        <asp:Label runat="server" ID="lblFemail" ForeColor="Red"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="for_sigle_row_form">
                    <label>
                        Upload photo</label>
                    <asp:FileUpload runat="server" ID="fuFather1" />&nbsp;
                                        <asp:Label ID="LBLIMG2" runat="server" ForeColor="Red">Upload only .jpg,.jpeg,.png,.gif Image file"</asp:Label>
                    <asp:Label runat="server" ID="lblFather" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label style="font-weight: bold;">
                        Mother Details</label>
                    <br />
                </div>
                <%--   <div class="for_sigle_row_form">--%>
                <%--<%--<%-- <%--  <div class="user_phot_frame">
                                                <asp:Image runat="server" ID="Image1" />
                                            </div>--%>
                <div class="for_sigle_row_form">
                    <div class="user_phot_frame">
                        <asp:Image runat="server" ID="imgMother" />
                    </div>
                    <%-- <div class="student-photo_frame_img" style="position: absolute; left: 800px; top: -9px;">
                                                <asp:Image runat="server" ID="imgstu" />
                                                    </div>--%>

                    <label>
                        Mother's Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtMFname" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMMname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtMLname" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Date of Birth</label>
                    <asp:TextBox ID="txtMDOB" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Nationality</label>
                    <asp:TextBox ID="txtMNation" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Academic Qualification<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="DropDownList1">
                        <asp:ListItem Value="0">--Select one--</asp:ListItem>
                        <asp:ListItem Value="1">10th</asp:ListItem>
                        <asp:ListItem Value="2">12th</asp:ListItem>
                        <asp:ListItem Value="3">Graduate</asp:ListItem>
                        <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Occupation<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtMOccup" runat="server"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Designation</label>
                    <asp:TextBox ID="txtMDesig" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name of Organization</label>
                    <asp:TextBox ID="txtMON" runat="server"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Office/Business Address</label>
                    <asp:TextBox runat="server" ID="txtAddressM" TextMode="MultiLine"></asp:TextBox>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtMPhone"
                            MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" CssClass="rqd" ControlToValidate="txtMPhone"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Mobile No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="txtMMobile"
                            runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtMMobile"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <asp:UpdatePanel runat="server" ID="upd1234">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <%--<div class="student-photo_frame_img" style="position: absolute; left: 800px; top: -9px;">
                                                <asp:Image runat="server" ID="Image1" />
                                                    </div>--%>
                            <label>
                                EmailId</label>
                            <asp:TextBox ID="txtMEmailid" runat="server"></asp:TextBox>&nbsp;
                                        <asp:Label runat="server" ID="lblMemail" ForeColor="Red"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="for_sigle_row_form">
                    <label>
                        Upload photo</label>
                    <asp:FileUpload runat="server" ID="FileUpload1" />&nbsp;
                                        <asp:Label ID="lblimg3" runat="server" ForeColor="Red">Upload only .jpg,.jpeg,.png,.gif Image file"</asp:Label>
                    <asp:Label runat="server" ID="lblmother" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
                </div>

                <div class="for_sigle_row_form">
                    <asp:UpdatePanel ID="up12" runat="server">
                        <ContentTemplate>
                            <label style="font-weight: bold;">
                                Guardian(if any)</label>
                            <asp:CheckBox runat="server" ID="CheckBox1" ToolTip="Check this if the details are same." AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:UpdatePanel runat="server" ID="UP1">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">

                            <label runat="server" id="l1">
                                Guardian's Name<span style="color: Red">*</span></label>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="fname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtmidnameg" runat="server" CssClass="mname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtlastg" runat="server" CssClass="lname"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">

                            <label runat="server" id="l2">
                                Nationality</label>
                            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l3">
                                Academic Qualification<%--<span style="color:Red">*</span>--%></label><asp:DropDownList
                                    runat="server" ID="DropDownList2">
                                    <asp:ListItem Value="0">--Select one--</asp:ListItem>
                                    <asp:ListItem Value="1">10th</asp:ListItem>
                                    <asp:ListItem Value="2">12th</asp:ListItem>
                                    <asp:ListItem Value="3">Graduate</asp:ListItem>
                                    <asp:ListItem Value="4">Post Graduate and higher</asp:ListItem>
                                </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l4">
                                Occupation<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="TextBox4"
                                    runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l5">
                                Designation</label>
                            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l6">
                                Name of Organization</label>
                            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l7">
                                Office/Business Address</label>
                            <asp:TextBox runat="server" ID="TextBox7" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l8">
                                Phone No.<%--<span style="color:Red">*</span>--%></label><asp:TextBox ID="TextBox8"
                                    MaxLength="10" runat="server"></asp:TextBox>&nbsp;
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator8" CssClass="rqd" ControlToValidate="TextBox8"
                                                    runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l9">
                                Mobile No.<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtGISD" runat="server" Width="43px" ToolTip="Enter your country code here"></asp:TextBox>
                            <asp:TextBox ID="TextBox9" runat="server" MaxLength="10" Width="239px"></asp:TextBox>&nbsp;
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="rqd" ControlToValidate="TextBox9"
                                                    runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                        </div>
                        <div class="for_sigle_row_form">
                            <label runat="server" id="l10">
                                EmailId</label>
                            <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>&nbsp;
                                               <asp:Label runat="server" ID="lblGemail" ForeColor="Red"></asp:Label>
                        </div>
                        <label>
                            <asp:Button ID="btnupdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnupdate_Click" /></label>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <%--   </div>--%>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <br />
                </div>
            </div>
</asp:Content>