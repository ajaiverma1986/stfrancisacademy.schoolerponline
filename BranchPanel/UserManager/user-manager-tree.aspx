<%@ Page Title="Brach User Hirarchy" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="user-manager-tree.aspx.cs" Inherits="branchpanel_user_manager_tree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .UserName {
            font-size: 16px;
            padding: 7px;
            color: #e23131;
        }

        .imgforplusorminus {
            position: relative;
            top: 4px;
            width: 20px;
        }

        .DivForShowTree {
            padding: 6px 6px 8px 30px;
            border: 1px dashed #b6b6b6;
        }
    </style>
    <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">User Tree</span>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
    </div>
    <div align="left" class="input_content" style="border: none; padding: 0px; margin-top: 0px;" id="divCreate" runat="server">
        <div class="DivForShowTreeArchitecture"></div>
        <div id="divProgressBar" class="progress"></div>
    </div>
    <script type="text/javascript">
        var SponserId = 0, DivId = "";
        $(document).ready(function () {
            BinGrid();
            $('.imgforplusorminus').live("click", function () {
                DivId = $(this).parent('div').attr("id");
                if ($(this).attr('src') == "../../images/add.png") {
                    $(this).attr('src', '../../images/minus.png');
                }
                else {
                    $(this).parent('div').find("div").remove();
                    $(this).attr('src', '../../images/add.png');
                    return false;
                }
                SponserId = $(this).parent('div').find('input[type=hidden]').val();
                BinGrid();
                return false;
            });
        });
        function BinGrid() {
            var DivForAppend = "";
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "user-manager-tree.aspx/BindGridByJs",
                data: "{'SponserId':'" + SponserId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            DivForAppend = DivForAppend = DivForAppend + '<div class="DivForShowTree" id="' + data.d[i].Userid + '"><asp:ImageButton runat="server" CssClass="imgforplusorminus" ImageUrl="~/images/add.png" Width="20px" /><asp:Label runat="server" CssClass="UserName">USER NAME: ' + data.d[i].Username + '</asp:Label><input  type="hidden" value="' + data.d[i].Userid + '"></div>'
                        }
                        if ($('.DivForShowTreeArchitecture').html() != "") {
                            var x = document.getElementById('' + DivId + '');
                            $(x).append(DivForAppend);
                        }
                        else
                            $('.DivForShowTreeArchitecture').html(DivForAppend);
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        function call_progressbar(progtype) {
            if (progtype == "start") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                $("#divProgressBar").addClass("progressAdd");
            }
            if (progtype == "end") {
                $("#divProgressBar").find("#loader").remove();
                $("#divProgressBar").removeClass("progressAdd");
            }
        }
    </script>
</asp:Content>