<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="summercampfee-setting.aspx.cs" Inherits="HO_summercampfee_setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Summer Camp Fee Setting</h2>
            
        </div>
        <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server">
            </asp:DropDownList>
             </div>
            <div class="for_sigle_row_form">
                <label>Select Branch<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlbranch" runat="server"></asp:DropDownList>
        </div>
        <div class="divforfee" style="display:none">
        <table class="stm showfee" width="100%">
                <tr class="stm_head" align="center">
                    <th>S.No.</th>
                    <th>Class</th>
                    <th>Fee Amount</th>
                    <th>TaxApplicable</th>
                    <th>Active</th>
                </tr>
            </table>
             <div class="for_sigle_row_form">
                 <label></label>
            <asp:Button ID="btnsave" Text="Submit" CssClass="button_save" runat="server" />
            <asp:Button runat="server" ID="Button1" CssClass="button_cancel" PostBackUrl="~/HO/FeeAmountSetting.aspx" Text="Back"
                    ToolTip="Click For Fee Setting." />
                 </div>
            </div>
        </div>
    <script type="text/javascript">
        var fyid = 0, brid = 0, allclassid = '', allfee = '', alltaxable = '', allactive = '';
        $(document).ready(function () {
            
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                $('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
                $('.divforfee').hide();
            });
            $('#ctl00_ContentPlaceHolder1_ddlbranch').change(function () {
                if ($(this).val() > 0) {
                    $('.divforfee').show();
                    BindListofSummerCampFee();
                }
                else {
                    $('.divforfee').hide();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnsave').click(function () {
                getdata();
                SaveFee();
                allclassid = '', allfee = '', alltaxable = '', allactive = '';
                return false;
            });
        });
        function getdata() {
            $('.showfee').find('tr:gt(0)').each(function () {
                allclassid = allclassid + ',' + $(this).find('input[type=hidden]').val();
                allfee = allfee + ',' + $(this).find('input[type=text]').val();
                if ($(this).find('.taxchecked').is(':checked')) {
                    alltaxable = alltaxable + ',' + 1;
                }
                else {
                    alltaxable = alltaxable + ',' + 0;
                }
                if ($(this).find('.activechecked').is(':checked')) {
                    allactive = allactive + ',' + 1;
                }
                else {
                    allactive = allactive + ',' + 0;
                }
            });
        }

        function BindListofSummerCampFee() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
            $('.showfee tr:gt(0)').remove();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "summercampfee-setting.aspx/FeeDetails",
                data: "{'fyid':'" + fyid + "','brid':'" + brid + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0) {
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td><input type=hidden value="' + data.d[i].id + '" />' + data.d[i].Classname + '</td>' +
                                             '<td class="for_sigle_row_form"><input class="txtfee" value="' + data.d[i].Fee + '" type="text" /></td>' +
                                              '<td><input class="taxchecked" type="checkbox" /></td>' +
                                               '<td><input class="activechecked" type="checkbox" /></td></tr>';
                            }
                            else {
                                trforappend = trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td>' +
                                            '<td><input type=hidden value="' + data.d[i].id + '" />' + data.d[i].Classname + '</td>' +
                                             '<td class="for_sigle_row_form"><input class="txtfee" value="' + data.d[i].Fee + '" type="text" /></td>' +
                                              '<td><input class="taxchecked" type="checkbox" /></td>' +
                                               '<td><input class="activechecked" type="checkbox" /></td></tr>';
                            }
                            $('.showfee').append(trforappend);
                           
                            if (data.d[i].TaxApplicable==1)
                                $('.showfee').find('tr:last').find('.taxchecked').attr('checked', true);
                            if(data.d[i].IsActive == 1)
                            $('.showfee').find('tr:last').find('.activechecked').attr('checked', true);
                        }
                        //call_progressbar("end");
                    }
                    else {
                        //call_progressbar("end");
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                        alertify.error('No Record Found');
                    }
                },
                error: function (result) {
                    // call_progressbar("end");
                    alertify.error('Some Error.');
                }
            });
        }

        function SaveFee() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            brid = $('#ctl00_ContentPlaceHolder1_ddlbranch').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "summercampfee-setting.aspx/SaveFee",
                data: "{'fyid':'" + fyid + "','brid':'" + brid + "','allclassid':'" + allclassid + "','allfee':'" + allfee + "','alltaxable':'" + alltaxable + "','allactive':'" + allactive + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success('Fee is Submited Successfully');
                    }
                },
                error: function (result) {
                    alertify.error("Some Error");
                }
            });
        }
    </script>
</asp:Content>

