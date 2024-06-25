<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="advance-studentidcard-settings.aspx.cs" Inherits="HO_advance_studentidcard_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .idcard-setting-radio {
            margin: 0 auto;
            width: 470px;
            height: 28px;
            background: rgb(235, 235, 235) none repeat scroll 0 0;
            float: none;
            clear: both;
            margin-top: 40px;
            display: block;
            border: 1px solid #ddd;
        }

            .idcard-setting-radio dd {
                float: left;
                margin-left: 10px;
                margin-top: 2px;
            }

        .qum {
            border: 1px solid #cdcdcd !important;
            padding: 0 0 8px;
        }

        .student-photo_frame1riz {
            float: right;
            height: 95px;
            width: 100%;
            margin-top: 10px;
            padding-top: 10px;
        }

        .carda {
            width: 250px;
            margin: 5px;
            border: 1px solid #354b8a;
            float: left;
            font-family: Arial;
            height: auto;
            text-transform: capitalize;
            background: #fff;
        }

            .carda input {
                width: 20px;
                float: left;
                margin: 7px;
            }

            .carda .logo_img {
                width: 160px;
                margin: 0 auto;
                margin-top: -10px;
            }

            .carda .student_img {
                margin: 10px auto;
                width: 85px;
                height: 90px;
                padding: 2px;
                border: 1px solid #ccc;
            }

            .carda .id_student {
                width: 208px;
                line-height: 20px;
                font-size: 13px;
                text-align: left;
                margin-left: 23px;
            }

            .carda .text2 {
                background-color: red !important;
                -webkit-print-color-adjust: exact;
                color: white;
                font-size: 12px;
                text-align: center;
                margin-top: 10px;
                line-height: 16px;
                padding-top: 2px;
                margin-bottom: -2px;
            }

        .print-foot {
            background: #ffa120;
            color: #fff;
            font-size: 13px;
            text-align: center;
            line-height: 18px !important;
            margin-top: 5px;
            padding: 5px 0px 1px 0px;
        }

            .print-foot td {
                font-family: Arial;
            }
    </style>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading">
            <h2>Student ID Card List</h2>

            <div class="upload">
                <i class="fa fa-print icon"><b class="bg-info"></b></i>
                <asp:Button ID="btnPrint" runat="server" Text="Print" />
            </div>
            <div class="upload">
                <i class="fa  fa-save icon"><b class="bg-info"></b></i>
                <asp:Button ID="btnsubmit" runat="server" Text="Save" ToolTip="Click here to Save Settings." />
            </div>

            <div class="idcard-setting">

                <span>ID Card BG Color</span>
                <input class="inputforfontcolorcode" type="color" title="Choose Background color for student id card." style="width: 90px" />
                <span>ID Card Font Color</span>
                <input class="fontcolorcodenew" type="color" title="Choose Font color for student id card." style="width: 90px;" />
            </div>
        </div>

        <div class="">

            <asp:Button ID="btnsetting" runat="server" Text="ID Card Setting" CssClass="button_save" Visible="false"
                CausesValidation="false" Style="float: right; border: 1px solid #0A748A; color: #fff; background-color: #2ca8c2; margin-right: 30px;" />

            <div id="divsetting" style="display: none;">
                <div class="for_sigle_row_form" style="display: none;">
                    <label>
                        Photo Width:<span style="color: Red">*</span></label>
                    <input type="text" id="txtwidth" runat="server" placeholder="Width in Pixel" />
                </div>
                <div class="for_sigle_row_form" style="display: none;">
                    <label>
                        Photo Height:<span style="color: Red">*</span></label>
                    <input type="text" id="txtheight" runat="server" placeholder="Height in Pixel" />
                </div>
                <div class="for_sigle_row_form" style="display: none;">
                    <label>
                        Photo Place:<span style="color: Red;">*</span></label>
                    <div style="width: 353px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px">
                        <asp:RadioButtonList ID="rbgender" runat="server" RepeatDirection="Horizontal" Width="200">
                            <asp:ListItem Value="0" Selected="True">Left</asp:ListItem>
                            <asp:ListItem Value="1">Right</asp:ListItem>
                            <asp:ListItem Value="2">Center</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Backgroumd Color:<span style="color: Red">*</span></label>
                </div>
                <div class="for_sigle_row_form" style="display: none;">
                    <label>
                        Logo Place:<span style="color: Red;">*</span></label>
                    <div style="width: 353px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px">
                        <asp:RadioButtonList ID="rblogo" runat="server" RepeatDirection="Horizontal" Width="200">
                            <asp:ListItem Value="0" Selected="True">Top</asp:ListItem>
                            <asp:ListItem Value="1">Bottom</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        ID Card View:<span style="color: Red;">*</span></label>
                    <div style="width: 353px; border: 1px solid; border-color: #ccc; margin-left: 239px; height: 24px; padding-top: 3px">
                    </div>
                </div>
                <div class="for_sigle_row_form">
                    <label></label>
                    <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_save" />
                </div>
            </div>

            <div class="clear"></div>

            <div class="searchbar containerHeadline for_sigle_row_form">
                <div class="clear"></div>

                <select style="height: 31px; width: 60px;" runat="server" id="ddlpazesize">
                    <option value="0">Page Size</option>
                    <option value="1">50</option>
                    <option value="2" selected="selected">100</option>
                    <option value="3">200</option>
                </select>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" Style="height: 31px; width: 110px;">
                    <asp:ListItem Value="0">--Select Financialyear--</asp:ListItem>
                </asp:DropDownList>
                <select style="height: 31px; width: 140px;" runat="server" id="ddlbranch">
                    <option value="0">--Select Branch--</option>
                </select>
                <select style="height: 31px; width: 120px;" runat="server" id="ddlclass">
                    <option value="0">--Select Class--</option>
                </select>
                <input type="text" placeholder="Admission No" id="txtrollno" style="width: 140px" />
                <input type="text" placeholder="Parent Mobile No" id="txtmobileno" style="width: 140px" />
                <input type="text" placeholder="Name" id="txtname" style="width: 140px" />
                <input id="btnclear" type="image" style="width: 25px; border-width: 0px; margin-left: 0px;" src="../images/clearsearch.png" title="Click Here For Reset The Search." />
            </div>

            <div class="searchbar containerHeadline">
                <div class="idcard-setting-radio">
                    <dd>ID Card  format</dd>
                    <asp:RadioButtonList ID="rbview" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="0" Selected="True">Horizontal</asp:ListItem>
                        <asp:ListItem Value="1">Vertical</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RadioButtonList ID="rdbtnstandard" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="0" Selected="True">Standard</asp:ListItem>
                        <asp:ListItem Value="1">Details</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="clear"></div>
            </div>

            <div class="clear"></div>
        </div>
        <div id="divvertical">
            <table class="Binddivvertical" style="margin: 0 7px;">
                <tr style="color: rgb(0, 0, 0);">
                    <td style="color: rgb(0, 0, 0);">
                        <div class="carda" style="margin: 5px; height: auto; background-color: rgb(238, 217, 145); color: rgb(0, 0, 0);">
                            <input type="checkbox" checked="checked" />
                            <br />
                            <div class="logo_img" style="margin: 0px auto 23px 21px; color: rgb(0, 0, 0);">
                                <img alt="No Image" src="../images/logo.png" />
                            </div>
                            <div class="student_img" style="width: 85px; margin: 0px auto 5px; padding: 2px; border: 1px solid rgb(204, 204, 204); color: rgb(0, 0, 0);">
                                <img src="../images/9update.png" alt="No Image" style="max-height: 90px; max-width: 85px; border-width: 0px;" />
                                <br />
                            </div>
                            <div class="id_student" style="text-align: center; color: rgb(0, 0, 0);">
                                <b style="color: rgb(0, 0, 0);">Name :
                                <span style="color: rgb(0, 0, 0);">Amit Kumar Kumar</span>
                                </b>
                                <br />
                                <b style="color: rgb(0, 0, 0);">Admission No:
                                <span style="color: rgb(0, 0, 0);">00001</span>
                                </b>
                                <div style="display: none; color: rgb(0, 0, 0);">
                                    <input type="hidden" value="Amit11" />
                                </div>
                                <br />
                                <b style="color: rgb(0, 0, 0);">DOB:
                                <span style="color: rgb(0, 0, 0);">05 Mar 1990</span>
                                </b>
                                <br />
                                <b style="color: rgb(0, 0, 0);">Class :
                                <span style="color: rgb(0, 0, 0);">U.K.G</span>
                                </b>
                                <br />
                                <b style="color: rgb(0, 0, 0);">Valid Till: </b>
                                <span style="color: rgb(0, 0, 0);">2015-2016</span>
                                <br />
                            </div>
                        </div>
                    </td>
                    <td style="color: rgb(0, 0, 0);">
                        <div class="carda" style="margin: 5px; height: auto; background-color: rgb(238, 217, 145); color: rgb(0, 0, 0);">
                            <input type="checkbox" checked="checked" />
                            <br />
                            <table class="print-foot" width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tbody>
                                    <tr style="color: rgb(0, 0, 0);">
                                        <td style="color: rgb(0, 0, 0);">Bhagalpur</td>
                                    </tr>
                                    <tr style="color: rgb(0, 0, 0);">
                                        <td style="color: rgb(0, 0, 0);">Ph.:7827739166</td>
                                    </tr>
                                    <tr style="color: rgb(0, 0, 0);">
                                        <td style="font-size: 10px; font-weight: normal; line-height: 14px ! important; color: rgb(0, 0, 0);">Email : amitsharma@awapal.com</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>