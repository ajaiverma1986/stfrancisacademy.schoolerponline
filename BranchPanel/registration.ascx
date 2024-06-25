<%@ Control Language="C#" AutoEventWireup="true" CodeFile="registration.ascx.cs" Inherits="BranchPanel_registration" %>
<div class="student-photo_frame">
    <%--   <script src="../EmployeePanel/js/jquery-1.10.1.min.js"></script>--%>
    <script src="../js/1.8-jquery-ui.min.js" type="text/javascript"></script>

    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/registrationlistdetails.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Registration Master</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lnkregistrationlist" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 10px !important" Text="Registration List" class="activereg" ToolTip="Click here to view  Registration list"
                CausesValidation="false" PostBackUrl="registration-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lnkrequestlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="New Registration" class="activeaddregister" ToolTip="Click here to view  Registration list"
                CausesValidation="false"></asp:LinkButton>

            <asp:LinkButton ID="btnallstudentlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="All Candidate List" class="activeall"
                CausesValidation="false" Visible="false" PostBackUrl="all-student-list.aspx"></asp:LinkButton>
            <asp:LinkButton ID="btntotalregistration" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Total Registration" class="activeall"
                CausesValidation="false" PostBackUrl="registrationdetails.aspx"></asp:LinkButton>
        </div>
    </div>
    <script>

        var status = "";
        $(document).ready(function () {
            $(".activeaddregister").click(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../EmployeePanel/requestleave.aspx/getenrollmentdate",
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        status = data.d[0].status;
                        if (status == "1") {
                            window.location.replace("add-new-registration.aspx");
                            return false;
                        }
                        else {
                            alert('Registrations closed for this session');
                            return false;
                        }

                    },
                    error: function (result) {
                        alertify.alert('error');

                    }
                });
                return false;
            });

        });
    </script>
</div>