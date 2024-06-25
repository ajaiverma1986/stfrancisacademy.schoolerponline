<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="Demo.aspx.cs" Inherits="EmployeePanel_Demo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/jquery-1.11.1.min.js"></script>
    <style>
        .leaveactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        #ctl00_head_PnlCust::-webkit-scrollbar-thumb {
            background-color: #B03C3F;
            border-radius: 10px;
        }

            #ctl00_head_PnlCust::-webkit-scrollbar-thumb:hover {
                background-color: #BF4649;
                border: 1px solid #333333;
            }

            #ctl00_head_PnlCust::-webkit-scrollbar-thumb:active {
                background-color: #A6393D;
                border: 1px solid #333333;
            }

        #chklistboxID {
            overflow: scroll;
        }

        .PnlDesign {
            width: 154px;
            height: auto;
            min-height: 200px;
            overflow: scroll;
            z-index: 1;
            overflow-x: hidden;
            border-radius: 10px;
            border: 3px solid #82403B;
        }

        #chklistboxID tr {
            border-top: 1px solid #82403B !important;
            border-bottom: 1px solid #82403B !important;
        }

        .drop-down {
            background: none repeat scroll 0 0 #e1f8f8;
            border: 1px solid #ddd;
            max-height: 400px;
            overflow-x: hidden;
            overflow-y: scroll;
            position: absolute;
            width: 247px;
            z-index: 2147483647;
        }

        .lblforclass {
            padding-left: 40px !important;
        }
        #ctl00_head_txtboxID {
            color:#000 !important;
            Width:100px !important;
            margin-left:25px !important;
            margin-bottom:5px !important;
            border:1px solid #D0D1D7 !important;
            text-align:center;
        }
    </style>
    <script type="text/ecmascript">
        var classname = "", classid = 0;
        $(document).ready(function () {
            BindClassByJquery();
            $('#ctl00_head_txtboxID').keyup(function () {
                classname = $(this).val();
                $("#chklistboxID tr").remove();
                BindClassByJquery();
            });
            $('#chklistboxID').on('click', 'tr label', function () {
                $('.searchicon ').val($(this).text());
                classid = $(this).parent('td').find('input').val();
            });
        });
        function BindClassByJquery() {
            $.ajax({
                type: "POST",
                url: "Demo.aspx/BindClass",
                data: "{'classname':'" + classname + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $.each(data.d, function (key, value) {
                        $("#chklistboxID").append("<tr class='classcategory'><td style='font:bold'><input class='inputhidden' type='checkbox' value='" + value.ClassID + "'><label class='lblforclass' for='lblfor" + value.ClassName + "'>" + value.ClassName + "</label></td></tr>")
                    });
                },
                failure: function (response) {
                },
            });
        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="javascript:__doPostBack('ctl00$lbLogOut','')">
                            <i class="icon-signout"></i>
                            Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Work Report
                    </h1>
                </div>
                <div class="main-content">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 50px !important;" id="tablemaingrid" runat="server">
                        <tr id="trmaingridrecord" runat="server" style="display: block">
                            <td colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                                <div class="form-row clearfix">
                                    <div style="float: left; padding-bottom: 13px;">
                                        <asp:TextBox ID="txtboxID" class="opendivcheckboxlist" runat="server" onkeyup="KeyUp(this,'#chklistboxID')" TabIndex="2"
                                            CssClass="searchicon forminput" placeholder="Search Class"> </asp:TextBox>
                                        <cc1:PopupControlExtender ID="PceSelectCustomer" runat="server" PopupControlID="PnlCust" Position="Bottom" TargetControlID="txtboxID">
                                        </cc1:PopupControlExtender>
                                    </div>
                                    <div id="checkboxlist" class="checkboxlist" runat="server">
                                        <asp:Panel ID="PnlCust" runat="server" CssClass="PnlDesign" Style="display: none">
                                            <table id="chklistboxID" class="drop-down">
                                            </table>
                                            <asp:HiddenField ID="hfcity" runat="server" Value='<%#Eval("catId") %>' />
                                        </asp:Panel>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>