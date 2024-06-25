<%@ Page Title="Generate Sechedule" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="examsession.aspx.cs" Inherits="BranchPanel_Exams_examsession" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function validateCheckBoxes() {

            var isValid = false;
            var cnt = 0;

            if (document.getElementById('<%=ddlexamname.ClientID %>').value.trim() == 0) {
                alert("Please select exam name.");
                document.getElementById('<%=ddlexamname.ClientID %>').focus();
                return false;
            }

            if (document.getElementById('<%=txtDate.ClientID %>').value.trim() == "") {
                alert("please select start Date.");
                document.getElementById('<%=txtDate.ClientID %>').focus();
                 return false;
             }
             if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == "") {
                alert("please select End Date.");
                document.getElementById('<%=txtToDate.ClientID %>').focus();
                 return false;
             }

             var gridView = document.getElementById('<%= grdclass.ClientID %>');
            for (var i = 0; i < gridView.rows.length; i++) {

                var inputs = gridView.rows[i].getElementsByTagName('input');
                if (inputs != null) {
                    if (inputs[0].type == "checkbox") {
                        if (inputs[0].checked) {
                            isValid = true;
                            cnt++;

                        }
                    }
                }
            }

            if (cnt == 0) {
                alert("Please select atleast one class for exam.");
                return false;
            }
            return true;
        }
    </script>

    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" />
    <script src="../../js/jquery-ui.js"></script>

    <script>
        $(function () {

            debugger;
            $("#ctl00_ContentPlaceHolder1_grd1").find("td").draggable({
                revert: "valid", cursor: "move"
            });

            $("#ctl00_ContentPlaceHolder1_grd1").find("td").droppable({
                drop: function (event, ui) {
                    var thisindex = $(this).index();
                    var dragindex = $(ui.draggable).index();
                    if (thisindex == dragindex && thisindex > 2) {
                        var a = $(this).html();

                        $(this).html($(ui.draggable).html());
                        $(ui.draggable).html(a)
                    }
                }
            });

        })
    </script>
    <style>
        #ctl00_ContentPlaceHolder1_grd1 td {
            cursor: move;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                var data0 = "";
                var data1 = "";
                var data2 = "";
                var data3 = "";
                var data4 = "";
                var data5 = "";
                var data6 = "";
                var data7 = "";
                var data8 = "";
                var data9 = "";
                var data10 = "";
                var data11 = "";
                var data12 = "";
                var data13 = "";
                var data14 = "";
                var data15 = "";
                var data16 = "";

                var i, k;
                var j;
                var header = "";
                var columnCount = ($("#ctl00_ContentPlaceHolder1_grd1").find('tr')[0].cells.length).toString();

                for (k = 1; k <= columnCount; k++) {

                    $("#<%=grd1.ClientID %> tr").each(function () {
                        if (!this.rowIndex) return;

                        var product = $(this).find("td:nth-child(" + k + ")").html();
                        if (k == 1) {
                            data0 = data0 + "," + product;
                        }

                    });

                }

                for (i = 2; i <= columnCount; i++) {
                    var headertext = $("table[id*=grd1] th").eq(i - 1).text();
                    header = header + "," + headertext;

                    $("#<%=grd1.ClientID %> tr").each(function () {

                    if (!this.rowIndex) return;

                    var product = $(this).find("td:nth-child(" + i + ")").html();

                    if (i == 1) {
                        data0 = data0 + "," + product;

                    }
                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'Date') {
                        data1 = data1 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'DayName') {
                        data2 = data2 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'LKG') {
                        data3 = data3 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'UKG') {

                        data4 = data4 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'Ist') {

                        data5 = data5 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'IInd') {

                        data6 = data6 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'IIIrd') {
                        data7 = data7 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'IVth') {
                        data8 = data8 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'Vth') {
                        data9 = data9 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'VIth') {
                        data10 = data10 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'VIIth') {
                        data11 = data11 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'VIIIth') {
                        data12 = data12 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'IXth') {
                        data13 = data13 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'Xth') {
                        data14 = data14 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'XIth') {
                        data15 = data15 + "," + product;
                    }

                    if ($("table[id*=grd1] th").eq(i - 1).text() == 'XIIth') {
                        data16 = data16 + "," + product;
                    }

                });

            }

                for (j = 1; j <= 17; j++) {

                    if (j == 1)
                        data0 = data0.substring(1, data0.length);

                    if (j == 2)
                        data1 = data1.substring(1, data1.length); //date
                    if (j == 3)
                        data2 = data2.substring(1, data2.length); //dayname
                    if (j == 4)
                        data3 = data3.substring(1, data3.length); //LKG
                    if (j == 5)
                        data4 = data4.substring(1, data4.length);  //UKG
                    if (j == 6)
                        data5 = data5.substring(1, data5.length);  //Ist
                    if (j == 7)
                        data6 = data6.substring(1, data6.length); //IInd
                    if (j == 8)
                        data7 = data7.substring(1, data7.length); //IIIrd
                    if (j == 9)
                        data8 = data8.substring(1, data8.length); //IVth
                    if (j == 10)
                        data9 = data9.substring(1, data9.length); //Vth
                    if (j == 11)
                        data10 = data10.substring(1, data10.length); //VIth
                    if (j == 12)
                        data11 = data11.substring(1, data11.length); //VIIth
                    if (j == 13)
                        data12 = data12.substring(1, data12.length); //VIIIth
                    if (j == 14)
                        data13 = data13.substring(1, data13.length);  //IXth

                    if (j == 15)
                        data14 = data14.substring(1, data14.length);  //Xth
                    if (j == 16)
                        data15 = data15.substring(1, data15.length);  //XIth
                    if (j == 17)
                        data16 = data16.substring(1, data16.length); //XIIth

                }
                //data0 = data0.substring(1, data0.length);
                header = header.substring(1, header.length);
                // alert(data3);
                if (data2 == "")
                    data2 = data0;
                if (data3 == "")
                    data3 = data0;
                if (data4 == "")
                    data4 = data0;
                if (data5 == "")
                    data5 = data0;
                if (data6 == "")
                    data6 = data0;
                if (data7 == "")
                    data7 = data0;
                if (data8 == "")
                    data8 = data0;
                if (data9 == "")
                    data9 = data0;
                if (data10 == "")
                    data10 = data0;
                if (data11 == "")
                    data11 = data0;
                if (data12 == "")
                    data12 = data0;
                if (data13 == "")
                    data13 = data0;
                if (data14 == "")
                    data14 = data0;
                if (data15 == "")
                    data15 = data0;
                if (data16 === "")
                    data16 = data0;

                debugger;

                $.ajax({

                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "examsession.aspx/generateschem",
                    data: "{'date':'" + data1 + "','C1':'" + data2 + "','C2':'" + data3 + "','C3':'" + data4 + "','C4':'" + data5 + "','C5':'" + data6 + "','C6':'" + data7 + "','C7':'" + data8 + "','C8':'" + data9 + "','C9':'" + data10 + "','C10':'" + data11 + "','C11':'" + data12 + "','C12':'" + data13 + "','C13':'" + data14 + "','C14':'" + data15 + "','C15':'" + data16 + "'}",
                    dataType: "json",
                    success: function (data) {
                        alert("submit");
                        var couponprice = data.d
                        if (data.d == '') {
                            alert(data.d);

                            return false;
                        }
                    },
                    error: function (result) {

                    },

                });

                return false;
            });
        });
    </script>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>

    <script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,
                    dateFormat: "d MM yy"
                });
            });

        });
    </script>

    <script src="jquery-1.2.6.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).bind('load', function () {
            var status = 0
            var headerChk = $(".chkHeader input");
            var itemChk = $(".chkItem input");
            headerChk.bind("click", function () {
                itemChk.each(function () { this.checked = headerChk[0].checked; })
                status++;
                //alert(status);
            });
            itemChk.bind("click", function () { if ($(this).checked == false) headerChk[0].checked = false; });
        });
    </script>

    <script type="text/javascript">
        var headerChk = $(".button_save input");
        headerChk.bind("click", function () {

        });
    </script>
    

    <div class="content_pane_cont input_content" id="contentPane">

        <div id="abc" runat="server">
            <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>

            <li style="background: none;"><a class="active" href="#">Generate Sechedule</a></li>

            <div class="arrowt">
                <a href="testlist.aspx">
                    <img src="../images/back-button.png" /></a>
            </div>
        </ul>
    </div>

            <div class="for_sigle_row_form">
                <label>
                    Exam Name<span style="color: Red">*</span>
                </label>
                <asp:DropDownList ID="ddlexamname" runat="server" Style="width: 313px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ddltest13" runat="server" ControlToValidate="ddlexamname"
                    ErrorMessage="Please Select Exam Name." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    From Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDate"
                    ErrorMessage="Please Select Exam from date." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    To Date<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtToDate"
                    ErrorMessage="Please Select Exam from date." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            </div>

            <div class="for_sigle_row_form">
                <label>
                    From Time</label>
                <asp:DropDownList ID="ddlftime" Width="100px" runat="server">
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;To Time
        <asp:DropDownList ID="ddltotime" Width="100px" runat="server">
        </asp:DropDownList>
            </div>

            <div class="for_sigle_row_form">

                <label>
                    Select Classes for exam</label>
                <asp:GridView ID="grdclass" AutoGenerateColumns="false" BorderWidth="0" Style="margin-left: 20px;"
                    runat="server" CssClass="stm" GridLines="None" EmptyDataText="No class added in this branch">
                    <Columns>

                        <asp:TemplateField HeaderText="Select All">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkhead" runat="server" CssClass="chkHeader" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkclass1" runat="server" CssClass="chkItem" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Class">
                            <ItemTemplate>
                                <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("Classname") %>'></asp:Label>
                                <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("classid") %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="stm_dark" />
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <AlternatingRowStyle CssClass="stm_light" />
                </asp:GridView>
            </div>

            <asp:UpdatePanel ID="update11" runat="server">
                <ContentTemplate>
                    <div class="for_sigle_row_form">

                        <label>
                        </label>

                        <asp:Button ID="btnsubmit" runat="server" Text="Generate Schedule" CssClass="button_save" OnClientClick="return validateCheckBoxes();" OnClick="btnsubmit_Click" />
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnsubmit" />
                </Triggers>
            </asp:UpdatePanel>
        </div>

        <div class="clear"></div>
        <div>            
            <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width: 700px; padding: 5px 20px; background: #fff; margin: 0px auto;"
                runat="server" id="tblMain">
                <tr>
                    <td>
                        <div>
                            <ul>                                

                                <div class="arrowt">
                                    <a href="testlist.aspx">
                                        <img src="../images/back-button.png" /></a>
                                </div>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>
                                <asp:Label ID="lblexma" runat="server"
                                    Font-Size="13px" Style="color: SlateBlue;"></asp:Label></b>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Class:</b>&nbsp;<asp:Label ID="lblclss" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Exam Date:</b>&nbsp;<asp:Label ID="lbfdate" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label><b> To </b>
                            <asp:Label ID="lbtdate" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <b>Exam Time:</b>&nbsp;<asp:Label ID="lbftime" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label><b> To </b>
                            <asp:Label ID="lbtotme" runat="server" Font-Size="13px"
                                ForeColor="SlateBlue"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>
            <br />
        </div>

        <asp:Label ID="lblmsg" runat="server" CssClass="bharat"></asp:Label>

        <asp:GridView ShowHeader="true" CssClass="stm drag_drop_grid GridSrc" HeaderStyle-BackColor="Black" ID="grd1" Style="margin-left: 10px;" CellPadding="0" HeaderStyle-Height="30px" Width="100%" BorderWidth="0" runat="server"></asp:GridView>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="Button1" runat="server" Text="save" CssClass="button_save" />
        </div>
    </div>
</asp:Content>