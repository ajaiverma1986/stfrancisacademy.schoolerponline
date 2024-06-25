<%@ Page Title="Edit Exam" Language="C#" AutoEventWireup="true" CodeFile="exam-edit.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_Exams_exam_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .active1 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #8CBF26;
            color: #333333;
            padding: 6px 15px 6px 15px;
            margin-right: 10px;
            height: auto;
        }
    </style>
    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 20px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Update Exam</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            <asp:Label runat="server" ID="lblll" Text="Update Exam"></asp:Label>
        </div>
        <br />

        <%--  <asp:UpdatePanel runat="server" ID="upd3"><ContentTemplate>--%>
        <div class="for_sigle_row_form">
            <label>
                Test Name<span style="color: Red">*</span></label>
            <asp:DropDownList ID="ddltest" runat="server">
                <asp:ListItem Value="0">--Select Test--</asp:ListItem>
            </asp:DropDownList>
            <%--  <asp:TextBox ID="txttesname" runat="server"></asp:TextBox>&nbsp;--%>
            <asp:RequiredFieldValidator ID="ddltest13" runat="server" ControlToValidate="ddltest"
                ErrorMessage="Please Select Test Name." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Class<span style="color: #ff0066">*</span></label>
            <asp:DropDownList ID="ddlcourse" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlcourse_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Select Course !"
                ControlToValidate="ddlcourse" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>
        <%--        </ContentTemplate></asp:UpdatePanel>--%>
        <%--     <asp:UpdatePanel runat="server" ID="upd4"><ContentTemplate>--%>
        <div class="for_sigle_row_form">
            <label>
                Select Subject<span style="color: #ff0066">*</span></label>
            <asp:DropDownList ID="ddlsubject" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsubject_SelectedIndexChanged">
            </asp:DropDownList>
            &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select Subject !"
                    ControlToValidate="ddlsubject" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <table class="file_border bkrt" cellpadding="2" cellspacing="0" border="0" style="width: 200px; float: left; background: #F7F7F7; border-radius: 1px; border: 0px solid #8CBF26; margin-bottom: 20px; margin-right: 20px; margin-top: 30px; position: relative; padding-top: 30px;">
            <tr>
                <td>
                    <div class="form-box-heading">
                        Exam Details
                    </div>
                </td>
            </tr>
        </table>
        <div class="clear">
        </div>
        <div class="for_sigle_row_form">
            <label>
                Test Date<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>&nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtToDate"
            ErrorMessage="Please Select Test date." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Test Time</label>
            <asp:DropDownList ID="ddlftime" Width="100px" runat="server">
            </asp:DropDownList>
            &nbsp;To
        <asp:DropDownList ID="ddltotime" Width="100px" runat="server">
        </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label runat="server" id="Label1">
                Marks<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtmarksp" CssClass="fname" runat="server" onFocus="if(this.value=='Passing') this.value=''; "
                onBlur="if(this.value=='') this.value='Passing'; " Text="Passing"></asp:TextBox>
            <asp:TextBox ID="txttotalmarks" CssClass="fname" runat="server" onFocus="if(this.value=='Total') this.value=''; "
                onBlur="if(this.value=='') this.value='Total'; " Text="Total">
            </asp:TextBox><a href="http://cssglobe.com" class="tooltip" title="Web Standards Magazine">Roll
            over for tooltip</a>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtmarksp"
                ErrorMessage="Please enter Test Marks !" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>
        <div id="dov" runat="server" style="margin-left: 90px">
            <div class="for_sigle_row_form">
                <label>
                    <asp:Button ID="Button1" Enabled="false" runat="server" Text="Update" CssClass="button_save" OnClick="btnsubmit_Click"
                        OnClientClick="return validateCheckBoxes()" />
                </label>
            </div>
        </div>
</asp:Content>