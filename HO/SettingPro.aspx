<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SettingPro.aspx.cs" Inherits="HO_SettingPro" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function pageLoad() {
            $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "d MM yy"
            });

            $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '2000:2050',
                dateFormat: "d MM yy"
            });
        };
    </script>
    <script type="text/javascript">
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
    </script>
    <style>
        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 355px;
        }
        .for_sigle_row_form label {
            width:183px !important;
        }

        .error {
            border-color: red !important;
            background-color: red;
        }
    </style>

    <div class="content_pane_cont input_content main-div-tbl" id="contentPane">

        <div class="student-photo_frame content_top1" style="height: 128px;">
            <div class="clear">
            </div>
            <div class="student-photo_frame_img">

                <img id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_imgstu" src="../images/tax.png" style="border-width: 0px;">
            </div>

            <div style="float: left;">
                <div class="user-deatils">
                    <dl>
                        <span id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname">Tax Setting </span>
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
            <div style="margin-bottom: -3px; margin-top: 10.5px;">
                <a style="cursor: pointer" id="txsettings" class="active3">Tax List </a>
                <a style="cursor: pointer" class="sgpt1 active7" id="btnaddnewtax">Add New Tax</a>
            </div>
        </div>

        <div class="clear"></div>

        <div id="divgrid" runat="server">

            <asp:GridView runat="server" ID="gvdetails" AllowPaging="true" PageSize="20" AutoGenerateColumns="false"
                Width="98.2%" CssClass="stm" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S.No." ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="servicetax" HeaderText="Service TAX" runat="server"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="educationcess" HeaderText="Edu. Cess" runat="server"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="HigherEdu_and_educess" HeaderText="Higher Edu. Cess" runat="server"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Current Rate"
                        ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:Label ID="lblRate" runat="server" Text='<%#Eval("limit","{0:f}") %>'> </asp:Label>
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="applyfromdate" HeaderText="Applicable From" runat="server"
                        ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="todate" HeaderText="Applicable Till" runat="server" ItemStyle-Width="15%"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btnEdit" CssClass="checkgrid"
                                ToolTip="Click here to edit this tax setting." Font-Underline="true" ForeColor="Chocolate">
                                <input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' />
                            </asp:LinkButton>
                            <asp:HiddenField ID="hd1" runat="server" Value='<%#Eval("tax_id") %>' />
                        </ItemTemplate>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                <RowStyle CssClass="stm_light" />
                <AlternatingRowStyle CssClass="stm_dark" />
                <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
        <br />
        <div id="missing_detail" runat="server">
        </div>

        <div id="divall" runat="server" style="display:none;">

            <div class="for_sigle_row_form">
                <label>
                    Service Tax <span style="color: Red">*</span></label>
                <asp:TextBox ID="txt_servicetax" runat="server" onkeypress="return noAlphabets(event)" placeholder="Enter Service Tax"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Edu. Cess <span style="color: Red">*</span></label>
                <asp:TextBox ID="txt_edycess" runat="server" onkeypress="return noAlphabets(event)" placeholder="Enter Edu. Cess"></asp:TextBox><span class="spaneducationcess"></span>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Sec. & Higher Edu. Cess  <span style="color: Red">*</span></label>
                <asp:TextBox ID="txtLimit" runat="server" onkeypress="return noAlphabets(event)" placeholder="Enter Sec. & Higher Edu. Cess"></asp:TextBox><span class="highereducationcess"></span>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>
                    Effective Rate</label>
                <asp:TextBox ID="txtactualeffectiverate" runat="server" Enabled="false" placeholder="Effective Rate"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    From Date <span style="color: Red">*</span></label>
                <asp:TextBox ID="txtDate" runat="server" onkeypress="return false" placeholder="Enter From Date"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    To Date
                </label>
                <asp:TextBox ID="txtToDate" runat="server" onkeypress="return false" placeholder="Enter To Date"></asp:TextBox>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" ToolTip="Click here to submit details." OnClick="btnSubmit_Click" />
                <a id="update" class="button_save">Update</a>
                <a id="back" class="button2">Back</a>
            </div>
        </div>
        <asp:HiddenField ID="educationcess" runat="server" />
        <asp:HiddenField ID="highereducationcess" runat="server" />
    </div>

    <script type="text/javascript">
        var taxid = 0, st = 0, fromdate = '', todate = '';
        var err = 0;
        var msg = '';
        var table = "<table id='mytbl' class='stm' style='width:98.2%;border-collapse:collapse;'><tr class='stm_head'><th> S.no.</th><th>MissingTax FromDate</th><th>MissingTax ToDate</th></tr>"
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat:'dd MM yy'
            });

            $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat:'dd MM yy'
            });

            $("#ctl00_ContentPlaceHolder1_missing_detail").find("table").find("th:eq(0)").css("width", "5%")
            var st = 0, ec = 0, hec = 0
            $("#ctl00_ContentPlaceHolder1_divgrid").show(500);

            $("#ctl00_ContentPlaceHolder1_divall").hide(500);
            //when enter service tax this line will be executed.
            $("#<%=txt_servicetax.ClientID%>").change(function () {
                var educationcess = '', highereducationcess = '';
                st = $("#<%=txt_servicetax.ClientID%>").val();
                ec = 0.00;
                hec = 0.00;
                $("#ctl00_ContentPlaceHolder1_txt_edycess").val('0.00');
                $("#ctl00_ContentPlaceHolder1_txtLimit").val('0.00');

                $('#ctl00_ContentPlaceHolder1_txtactualeffectiverate').val(parseFloat(parseFloat(st) + parseFloat(ec) + parseFloat(hec)).toFixed(2))

            });
            $('#ctl00_ContentPlaceHolder1_txt_edycess').change(function () {
                if ($("#<%=txt_servicetax.ClientID%>").val() == "") {
                    alertify.error("please enter service tax first");
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').focus();
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').addClass("error");
                    return false;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').removeClass("error");
                }
                st = $("#<%=txt_servicetax.ClientID%>").val();
                if ($("#ctl00_ContentPlaceHolder1_txt_edycess").val() != '') {
                    ec = $("#ctl00_ContentPlaceHolder1_txt_edycess").val();
                }
                else {
                    ec = 0;
                }
                if ($("#ctl00_ContentPlaceHolder1_txtLimit").val() != '') {
                    hec = $("#ctl00_ContentPlaceHolder1_txtLimit").val();
                }
                else {
                    hec = 0;
                }
                $('#ctl00_ContentPlaceHolder1_txtactualeffectiverate').val(parseFloat(parseFloat(st) + parseFloat(ec) + parseFloat(hec)).toFixed(2));
            });

            // when change higher edu ecss
            $('#ctl00_ContentPlaceHolder1_txtLimit').change(function () {
                if ($("#<%=txt_servicetax.ClientID%>").val() == "") {
                    alertify.error("please enter service tax first");
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').focus();
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').addClass("error");
                    return false;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').removeClass("error");
                }
                st = $("#<%=txt_servicetax.ClientID%>").val();
                if ($("#ctl00_ContentPlaceHolder1_txt_edycess").val() != '') {
                    ec = $("#ctl00_ContentPlaceHolder1_txt_edycess").val();
                }
                else {
                    ec = 0;
                }
                if ($("#ctl00_ContentPlaceHolder1_txtLimit").val() != '') {
                    hec = $("#ctl00_ContentPlaceHolder1_txtLimit").val();
                }
                else {
                    hec = 0;
                }
                $('#ctl00_ContentPlaceHolder1_txtactualeffectiverate').val(parseFloat(parseFloat(st) + parseFloat(ec) + parseFloat(hec)).toFixed(2));
            });

            $('#ctl00_ContentPlaceHolder1_txt_servicetax').keyup(function () {
                if ($(this).val() >= 101) {
                    alertify.error("The Service tax value can't be more than 100");
                    $('#ctl00_ContentPlaceHolder1_txt_servicetax').val('');
                    return false;
                }
               
            });
            $('#ctl00_ContentPlaceHolder1_txt_edycess').keyup(function () {
                if ($(this).val() >= 101) {
                    alertify.error("The Edu. Cess value can't be more than 100");
                    $('#ctl00_ContentPlaceHolder1_txt_edycess').val('');
                    return false;
                }
            });
            $('#ctl00_ContentPlaceHolder1_txtLimit').keyup(function () {
                if ($(this).val() >= 101) {
                    alertify.error("The Sec. & Higher Edu. Cess value can't be more than 100");
                    $('#ctl00_ContentPlaceHolder1_txtLimit').val('');
                    return false;
                }
            });

        });

        $("#txsettings").click(function () {
            $(this).addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#btnaddnewtax").addClass("sgpt1").addClass("active7").removeClass("active3");
            $("#ctl00_ContentPlaceHolder1_divgrid").show(500);
            $("#ctl00_ContentPlaceHolder1_divall").hide(500);
            $("#ctl00_ContentPlaceHolder1_missing_detail").show(500);
            $('#update').show(100);
            $('#ctl00_ContentPlaceHolder1_btnSubmit').hide();
        });
        $("#btnaddnewtax").click(function () {
            $(this).addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#txsettings").addClass("sgpt1").addClass("active7").removeClass("active3");
            //reset all feild start
            $("#ctl00_ContentPlaceHolder1_txt_servicetax").val('');
            $("#ctl00_ContentPlaceHolder1_txt_edycess").val('');
            $("#ctl00_ContentPlaceHolder1_txtLimit").val('');
            $("#ctl00_ContentPlaceHolder1_txtDate").val('');
            $("#ctl00_ContentPlaceHolder1_txtToDate").val('');
            $("#ctl00_ContentPlaceHolder1_txtactualeffectiverate").val('');
            $("#ctl00_ContentPlaceHolder1_btnSubmit").val("Submit");
            $(":input").removeClass("error");
            //reset all feild  end
            $("#ctl00_ContentPlaceHolder1_divgrid").hide(500);
            $("#ctl00_ContentPlaceHolder1_divall").show(500);
            $("#ctl00_ContentPlaceHolder1_missing_detail").hide(500);
            $('#update').hide(100);
            $('#ctl00_ContentPlaceHolder1_btnSubmit').show();
            return false;
        });
        $('#back').click(function () {
            $("#txsettings").addClass("active3").removeClass("sgpt1").removeClass("active7");;
            $("#btnaddnewtax").addClass("sgpt1").addClass("active7").removeClass("active3");
            $("#ctl00_ContentPlaceHolder1_divgrid").show(500);
            $("#ctl00_ContentPlaceHolder1_divall").hide(500);
            $("#ctl00_ContentPlaceHolder1_missing_detail").show(500);
        });
        $('.checkgrid').live('click', function () {
            $(":input").removeClass("error");
            taxid = $(this).parent().find("input[type='hidden']").val();
            viewdata(taxid);
            return false;
        });
        function viewdata(tid) {
            $.ajax({
                type: "POST",
                url: "SettingPro.aspx/viewtax",
                data: '{taxid: "' + tid + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alertify.error(response.d);
                }
            });
            function OnSuccess(response) {
                $("#ctl00_ContentPlaceHolder1_divgrid").hide(500);
                $("#ctl00_ContentPlaceHolder1_divall").show(500);
                $("#ctl00_ContentPlaceHolder1_missing_detail").hide(500);
                $('#update').show(100);
                $('#ctl00_ContentPlaceHolder1_btnSubmit').hide();
                $("#ctl00_ContentPlaceHolder1_txt_servicetax").val(response.d.ST);
                $("#ctl00_ContentPlaceHolder1_txt_edycess").val(response.d.ES);
                $("#ctl00_ContentPlaceHolder1_txtLimit").val(response.d.HES);
                $("#ctl00_ContentPlaceHolder1_txtDate").val(response.d.FD);
                $("#ctl00_ContentPlaceHolder1_txtToDate").val(response.d.TD);
                $("#ctl00_ContentPlaceHolder1_btnSubmit").val("Update Tax");

                var effectiverate = parseInt(response.d.ST) + parseInt(response.d.ES) + parseInt(response.d.HES);
                $("#ctl00_ContentPlaceHolder1_txtactualeffectiverate").val(effectiverate);
            }
        }
        $('#ctl00_ContentPlaceHolder1_btnSubmit').click(function () {
            err = 0;
            msg = '';
            validate();
            if (err == 1) {
                alert(msg);
                return false;
            }
        });
        $('#update').click(function () {
           
            err = 0;
            msg = '';
            validate();
            if (err == 1) {
                alert(msg);
                return false;
            }
            updatetax();
        });

        $('#ctl00_ContentPlaceHolder1_txt_servicetax').focus(function () { $('#ctl00_ContentPlaceHolder1_txt_servicetax').removeClass("error"); });
        $('#ctl00_ContentPlaceHolder1_txtDate').focus(function () { $('#ctl00_ContentPlaceHolder1_txtDate').removeClass("error"); });
        $('#ctl00_ContentPlaceHolder1_txtLimit').focus(function () { $('#ctl00_ContentPlaceHolder1_txtLimit').removeClass("error"); });
        $('#ctl00_ContentPlaceHolder1_txt_edycess').focus(function () { $('#ctl00_ContentPlaceHolder1_txt_edycess').removeClass("error"); });
        function validate() {
            msg = '';
            if ($('#ctl00_ContentPlaceHolder1_txt_servicetax').val() == '') {
                $('#ctl00_ContentPlaceHolder1_txt_servicetax').addClass("error");
                msg += '\r\n Please enter service tax amount.';
                err = 1;
            }
            if ($('#ctl00_ContentPlaceHolder1_txt_edycess').val() == '') {
                $('#ctl00_ContentPlaceHolder1_txt_edycess').addClass("error");
                msg += '\r\n Please enter edu cess.';
                err = 1;
            }
            if ($('#ctl00_ContentPlaceHolder1_txtLimit').val() == '') {
                $('#ctl00_ContentPlaceHolder1_txtLimit').addClass("error");
                msg += '\r\n Please enter Sec. & Higher Edu. Cess .';
                err = 1;
            }
            if ($('#ctl00_ContentPlaceHolder1_txtDate').val() == '') {
                $('#ctl00_ContentPlaceHolder1_txtDate').addClass("error");
                msg += '\r\n Please enter from date.';
                err = 1;
            }
        }

        function updatetax() {
          
            st = $('#ctl00_ContentPlaceHolder1_txt_servicetax').val();
            ec = $('#ctl00_ContentPlaceHolder1_txt_edycess').val();
            hec = $('#ctl00_ContentPlaceHolder1_txtLimit').val()
            fromdate = $('#ctl00_ContentPlaceHolder1_txtDate').val();
            todate = $('#ctl00_ContentPlaceHolder1_txtToDate').val();
            $.ajax({
                type: "POST",
                url: "SettingPro.aspx/updatetax",
                data: "{'taxid':'" + taxid + "', 'st':'" + st + "', 'fmdt':'" + fromdate + "','ec':'" + ec + "','hec':'" + hec + "', 'tdt':'" + todate + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alertify.error("Tax Not Updated Due To Network Congestion.");
                }
            });
            function OnSuccess(response) {
                if (response.d[0].result == 3) {
                    alertify.error("insert to date already exists in system");
                    return false;
                }

                if (response.d[0].result == 2) {
                    alertify.error("update from date already exists in system");
                    return false;
                }

                var tr = "";
                table.find("tr:gt(0)").remove();
                $('#ctl00_ContentPlaceHolder1_gvdetails').empty();
                $("#ctl00_ContentPlaceHolder1_divgrid").show(500);
                $("#ctl00_ContentPlaceHolder1_divall").hide(500);
                $('#ctl00_ContentPlaceHolder1_gvdetails').append("<tr class='stm_head'><th>S. No. </th><th>Service Tax </th><th>Edu. Cess </th><th>Higher Edu. Cess </th><th>Current Rate</th><th>Applicable From </th><th>Applicable Till </th><th>Edit</th></tr>")
                for (var i = 0; i < response.d.length; i++) {
                    var class1
                    if (i % 2 == 0) {
                        class1 = 'stm_light';
                    }
                    else {
                        class1 = 'stm_dark';
                    }
                    $('#ctl00_ContentPlaceHolder1_gvdetails').append("<tr class='" + class1 + "'><td>" + (i + 1) + "</td><td>" + response.d[i].ST + "</td><td>" + response.d[i].ES + "</td><td>" + response.d[i].HES + "</td><td>" + response.d[i].LIMIT + "</td><td>" + response.d[i].FD + "</td><td>" + response.d[i].TD + "</td><td>" + "<a class='checkgrid' style='color:Chocolate;text-decoration:underline;cursor:pointer'><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /></a><input type='hidden' value=" + response.d[i].taxid + ">" + "</td></tr>")
                    if (response.d[i].missingfromdate != null) {
                        table = table + "<tr class='" + class1 + "'><td>" + (i + 1) + "</td><td>" + response.d[i].missingfromdate + " </td><td>" + response.d[i].missingtodate + "</td></tr>";
                        $("#ctl00_ContentPlaceHolder1_missing_detail").show();
                        $("#ctl00_ContentPlaceHolder1_missing_detail").empty()
                        $("#ctl00_ContentPlaceHolder1_missing_detail").append(table);
                    }
                };
                alertify.success("Tax Detail Updated Successfully.");
            }
        }
    </script>
</asp:Content>