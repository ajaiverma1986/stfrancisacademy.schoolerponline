<%@ Page Title="HOME" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="AdminPanel_Login"
    MasterPageFile="../MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clear"></div>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane" style="padding-bottom: 120px !important;">
            <div class="tbl-top-heading">
                <h2>Admin Quick Access </h2>
            </div>
            <div class="studentregt maindahboard">
                <a href="../Ho/ho-user-list.aspx">
                    <img src="../images/a.png" alt="" class="icondashboard" style="width: 41px; margin-top: 3px;" />
                    <h3>User List</h3>
                </a>
            </div>
            <div class="feecollc maindahboard">
                <a href="../Ho/branch-user-list.aspx">
                    <img src="../images/a.png" alt="" class="icondashboard" style="width: 35px; margin-bottom: 0px; margin-top: 5px;" />
                    <h3>Branch List</h3>
                </a>
            </div>
            <div class="timetable maindahboard">
                <a href="../Ho/overall-admissions.aspx">
                    <img src="../images/a.png" alt="" class="icondashboard" style="width: 44px; margin-top: 2px; margin-bottom: 3px;" />
                    <h3>Fee Report</h3>
                </a>
            </div>
            <div class="attenleave maindahboard">
                <a href="../HO/add-new-registration.aspx">
                    <img src="../images/a.png" alt="" style="width: 44px; margin-top: 12px; margin-bottom: 11px;" />
                    <h3>Registration Settings</h3>
                </a>
            </div>
            <div class="tarnsportation maindahboard">
                <a href="#">
                    <img src="../images/a.png" alt="" class="icondashboard" style="width: 44px; margin-top: 3px; margin-bottom: 4px;" />
                    <h3>Staff List</h3>
                </a>
            </div>
        </div>
    </div>
</asp:Content>