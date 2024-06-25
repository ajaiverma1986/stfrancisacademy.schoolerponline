<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="viewtimetableschedule.aspx.cs" Inherits="HO_viewtimetableschedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="main-div-tbl">
        <div class="student-photo_frame content_top1" style="height: 128px;">
            <div class="clear">
            </div>
            <div class="student-photo_frame_img">
                <img id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_imgstu" src="../images/smaster.png" style="border-width: 0px;">
            </div>
            <div style="float: left;">
                <div class="user-deatils">
                    <dl>
                        <span id="ctl00_ContentPlaceHolder1_MyUserInfoBoxControl_lblname">Time Table View</span>
                    </dl>
                </div>
                <div class="clear">
                </div>
            </div>
            <div class="clear">
            </div>
            <div style="margin-bottom: -3px; margin-top: 10.5px;">
                <a style="cursor: pointer" id="btnclass" class="active3">Class Wise View</a>&nbsp;&nbsp;&nbsp;

                <a style="cursor: pointer" id="btnteacher" class="active7 sgpt1">Teacher Wise View</a>&nbsp;&nbsp;&nbsp;

                <a style="cursor: pointer" id="btnday" class="active7 sgpt1">Day Wise View</a>
            </div>
        </div>
        <asp:UpdatePanel ID="UPModulePermission" runat="server">
            <ContentTemplate>
      
        <div class="clear"></div>
       <div id="divforclass" runat="server" class="divforclass">
            <div class="for_sigle_row_form">
            <label>Select Branch<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlbranch" runat="server" OnSelectedIndexChanged="ddlbranch_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
        </div>
           <div id="divclass" runat="server" style="display:none">
           <div class="for_sigle_row_form">
                    <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                    <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Class:<span style="color: red">*</span></label>
                    <asp:DropDownList ID="ddlclass" runat="server" OnSelectedIndexChanged="ddlclass_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>Select Section:<span style="color: red">*</span></label>
                    <asp:DropDownList ID="ddlsection" runat="server" OnSelectedIndexChanged="ddlsection_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="0">--Select Section--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div id="divfordownload" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="btnprint" runat="server" Text="Print"
                        CausesValidation="false" Height="20px" CssClass="btnprint" Style="float: right;"
                        ToolTip="Click here to Print sheet" />
                </div>
                <div id="divforprint" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
                <div class="for_sigle_row_form divforgrid">
                    <asp:GridView ID="grdtimetable" runat="server" CssClass="stm" AutoGenerateColumns="true" GridLines="None" Width="100%">
                    </asp:GridView>
                </div>
               </div>
       </div>
                <div class="clear"></div>
                <div id="divforteacher" class="divforteacher" runat="server" style="display:none">
                     <div class="for_sigle_row_form">
            <label>Select Branch<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlbranch1" runat="server" OnSelectedIndexChanged="ddlbranch1_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
        </div>
                    <div id="divteacher" runat="server" style="display:none">
                    <div class="for_sigle_row_form">
                    <label>Select Teacher<span style="font-weight: bold; color: red">*</span></label>
                    <asp:DropDownList ID="ddlteacher" runat="server" OnSelectedIndexChanged="ddlteacher_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div id="div1" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="Button1" runat="server" Text="Print" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="btnprint" Style="float: right;"
                        ToolTip="Click here to Print sheet" />
                </div>
                <div id="div2" runat="server" class="upload" style="display:none">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="Button2" runat="server" Text="Download Excel file" 
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
                <div class="for_sigle_row_form divforgrid">
                    <asp:GridView ID="GridView1" runat="server" CssClass="stm" AutoGenerateColumns="true" GridLines="None" Width="100%">
                    </asp:GridView>
                </div>
                        </div>
                </div>
                <div class="divforday" style="display: none">
                    <div class="for_sigle_row_form">
                        <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                        <asp:DropDownList ID="ddlfyear1" runat="server">
                        </asp:DropDownList>
                    </div>
                     <div class="for_sigle_row_form">
            <label>Select Branch<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlbranch2" runat="server">
            </asp:DropDownList>
        </div>
                    <div class="for_sigle_row_form">
                        <label>Select Day:<span style="color: red">*</span></label>
                        <asp:DropDownList ID="ddldays" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="divday">
                         <div class="binddays" style="display: none">
          <table width="100%" class="stm stmdetail">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">class</th>
                    <th align="center">Details</th>
                </tr>
            </table>         
            </div>
      <div class="divforsection" style="display: none">
          <table width="100%" class="stm sectiondetail">
          <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">class</th>
                    <th align="center">Section</th>
                    <th align="center">Details</th>
                </tr>
              </table>    
      </div>
     <div id="divfordetail" style="display: none">
            <table width="100%" class="stm showdetail">
                <tr class="stm_head">
                    <th>S.No.</th>
                    <th>Period</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Subject</th>
                     <th>Teacher</th>
                </tr>
            </table>
            <div class="for_sigle_row_form">
            <asp:Button ID="btnbackfordetail" runat="server" Text="Back" CssClass="button_cancel" />
                </div>
        </div>
                        </div>
                </div>
                </ContentTemplate>
        </asp:UpdatePanel>
    </div>
   
    <script type="text/javascript">
        //$(document).ready(function () {
           
            
        //});
        $(function () {
            var id = 0, classid = 0, sectionid = 0;
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                Bindviewtimetable();
                //$("[id*=grdtimetable]").find('tr:eq(1)').remove();
                $("[id*=grdtimetable]").find('tr:eq(0)').addClass('stm_head');
                $("[id*=grdtimetable]").find('tr:gt(0):odd').addClass('stm_dark');
                $("[id*=grdtimetable]").find('tr:gt(0):even').addClass('stm_light');
                $("[id*=grdtimetable]").find('tr').find('td:nth-child(2)').remove();
                $("[id*=grdtimetable]").find('tr').find('th:eq(1)').remove();
                $("[id*=grdtimetable]").find('tr').find('th:eq(0)').html('S.NO');
                $("[id*=grdtimetable]").find('tr').find('th:eq(2)').html('PeriodTime');
                $("[id*=grdtimetable]").find('tr').find('th:eq(1)').html('PeriodName');
                var i = 1;
                $("[id*=GridView1]").find('tr:gt(0)').each(function () {
                    $(this).find('td:eq(0)').html(i);
                    i++;
                });
                $("[id*=GridView1]").find('tr:eq(0)').addClass('stm_head');
                $("[id*=GridView1]").find('tr:gt(0):odd').addClass('stm_dark');
                $("[id*=GridView1]").find('tr:gt(0):even').addClass('stm_light');
                $("[id*=GridView1]").find('tr').find('td:nth-child(2)').remove();
                $("[id*=GridView1]").find('tr').find('th:eq(1)').remove();
                $("[id*=GridView1]").find('tr').find('th:eq(0)').html('S.NO');
                $("[id*=GridView1]").find('tr').find('th:eq(2)').html('PeriodTime');
                $("[id*=GridView1]").find('tr').find('th:eq(1)').html('PeriodName');
                var i = 1;
                $("[id*=GridView1]").find('tr:gt(0)').each(function () {
                    $(this).find('td:eq(0)').html(i);
                    i++;
                });
                $(".BtnExcel").click(function (e) {
                    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                        if (e) {
                            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforgrid').html()));
                            e.preventDefault();
                        }
                    });
                    return false;
                });
                $('.btnprint').click(function () {
                    var printWindow = window.open('left=500,top=500,width=500,height=500');
                    printWindow.document.write($('.divforgrid').html());
                    printWindow.document.close();
                    printWindow.focus();
                    printWindow.print();
                    printWindow.close();
                });
                $('#ctl00_ContentPlaceHolder1_ddlsection').change(function () {
                    $('#divfordownload').show();
                    $('#divforprint').show();
                });
                $('#btnclass').click(function () {
                    $('#btnclass').addClass('active3').removeClass('active7').removeClass('sgpt1');
                    $('#btnteacher,#btnday').removeClass('active3').addClass('active7').addClass('sgpt1');
                    //$('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
                    $('.divforclass').show();
                    $("[id*=grdtimetable]").find('tr').remove();
                    $('#ctl00_ContentPlaceHolder1_ddlclass').val(0);
                    $('.divforteacher').hide();
                    $('#ctl00_ContentPlaceHolder1_divteacher').hide();
                    $('#ctl00_ContentPlaceHolder1_divclass').hide();
                    $('.divforday').hide();
                });
                $('#btnteacher').click(function () {
                    $('#btnteacher').addClass('active3').removeClass('active7').removeClass('sgpt1');
                    $('#btnclass,#btnday').removeClass('active3').addClass('active7').addClass('sgpt1');
                    $('#ctl00_ContentPlaceHolder1_ddlteacher').val('0');
                    $('.divforclass').hide();
                    $('.divforteacher').show();
                    $("[id*=GridView1]").find('tr').remove();
                    //$('#ctl00_ContentPlaceHolder1_ddlbranch1').val('0');
                    $('#ctl00_ContentPlaceHolder1_divteacher').hide();
                    $('.divforday').hide();
                });
                $('#btnday').click(function () {
                    $('#btnday').addClass('active3').removeClass('active7').removeClass('sgpt1');
                    $('#btnclass,#btnteacher').removeClass('active3').addClass('active7').addClass('sgpt1');
                    //$('#ctl00_ContentPlaceHolder1_ddlbranch').val('0');
                    $('.divforclass').hide();
                    $('.divforteacher').hide();
                    $('.divforday').show();
                });
                $('.viewimage').live('click', function () {
                    classid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    $('.divforsection').show();
                    var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                    $('.stmdetail tr:gt(0)').remove();
                    $('.stmdetail').append(gettr);
                    BindClassSection();
                    return false;
                });
                $('.viewdetail').live('click', function () {
                    $('#divfordetail').show();
                    sectionid = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
                    var gettr = '<tr>' + $(this).parent('td').parent('tr').html() + '</tr>';
                    $('.sectiondetail tr:gt(0)').remove();
                    $('.sectiondetail').append(gettr);
                    showDetails();
                    return false;
                });
                $('#ctl00_ContentPlaceHolder1_btnbackfordetail').click(function () {
                    $('.binddays').hide();
                    $('.divforsection').hide();
                    $('#divfordetail').hide();
                    $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                    return false;
                });
                $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                    $('.binddays').hide();
                    $('.divforsection').hide();
                    $('#divfordetail').hide();
                    $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                    return false;
                });
                $('#ctl00_ContentPlaceHolder1_ddlfyear1').change(function () {
                    $('#ctl00_ContentPlaceHolder1_ddlbranch2').val('0');
                    $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                    $('.binddays').hide();
                    $('.divforsection').hide();
                    $('#divfordetail').hide();
                });
                $('#ctl00_ContentPlaceHolder1_ddlbranch2').change(function () {
                    $('.binddays').hide();
                    $('.divforsection').hide();
                    $('#divfordetail').hide();
                    $('#ctl00_ContentPlaceHolder1_ddldays').val('0');
                });
            });
           
            $('#ctl00_ContentPlaceHolder1_ddldays').change(function () {
                
                id = $('#ctl00_ContentPlaceHolder1_ddldays').val();
                if (id > 0) {
                    $('.binddays').show();
                    $('#divfordetail').hide();
                    BindGrid();
                }
                else {
                    $('.binddays').hide();
                    $('#divfordetail').hide();
                }
                return false;
            });
            function BindGrid() {
               
                $('.stmdetail tr:gt(0)').remove();
                var trforappend = '', trclass = '';
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../BranchPanel/Timetable/viewtimetable_daywise.aspx/BindGriddays",
                    data: "{'fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear1').val() + "'}",
                    dataType: "json",
                    async:false,
                    success: function (data) {
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 == 0) {
                                    trclass = 'stm_dark';
                                }
                                else {
                                    trclass = 'stm_light';
                                }
                                trforappend = trforappend + "<tr class=" + trclass + ">" +
                                "<td><input type='hidden' value=" + data.d[i].Classid + " />" + (i + 1) + "</td>" +
                                "<td>" + data.d[i].Classname + " </td>" +
                                "<td><input class=viewimage type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../images/viewquestion.png /></td>"
                                "</tr>";
                            }
                            $('.stmdetail').append(trforappend);
                        }
                        else {
                            alertify.error("No Record Found");
                        }

                    },
                    error: function (result) {
                        alertify.error("Error While Grid Is Binding");

                    }

                });
            }

            function BindClassSection() {
                $('.sectiondetail tr:gt(0)').remove();
                var trforappend = '', trclass = '';
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../BranchPanel/Timetable/viewtimetable_daywise.aspx/BindClassSection",
                    data: "{'classid':'" + classid + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 == 0) {
                                    trclass = 'stm_dark';
                                }
                                else {
                                    trclass = 'stm_light';
                                }
                                trforappend = trforappend + "<tr class=" + trclass + ">" +
                                "<td><input type='hidden' value=" + data.d[i].Sectionid + ">" + (i + 1) + "</td>" +
                                "<td>" + data.d[i].Classname + " </td>" +
                                "<td>" + data.d[i].Sectionname + " </td>" +
                                "<td><input class='viewdetail' type=image style=height:15px;width:15px;border-width:0px; alt=No Image src=../images/viewquestion.png /></td>"
                                "</tr>";
                            }
                            $('.sectiondetail').append(trforappend);
                        }
                        else {
                            alertify.error("No Record Found");
                        }

                    },
                    error: function (result) {
                        alertify.error("Error While Grid Is Binding");

                    }

                });
            }

            function Bindviewtimetable() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../BranchPanel/Timetable/viewtimetable_daywise.aspx/viewtimetable",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#ctl00_ContentPlaceHolder1_ddldays").html("");
                        $("#ctl00_ContentPlaceHolder1_ddldays").append($("<option></option>").val('0').html('--Select Day--'));
                        $.each(data.d, function (key, value) {
                            $("#ctl00_ContentPlaceHolder1_ddldays").append($("<option></option>").val(value.did).html(value.dayname));
                        });
                    },
                    error: function (result) {
                        alertify.error("Some Error");
                    }
                });

            }

            function showDetails() {
                $('.showdetail tr:gt(0)').remove();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "viewtimetableschedule.aspx/PeriodDetail",
                    data: "{'classid':'" + classid + "','fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear1').val() + "','sectionid':'" + sectionid + "','dayid':'" + $('#ctl00_ContentPlaceHolder1_ddldays').val() + "','brid':'" + $('#ctl00_ContentPlaceHolder1_ddlbranch2').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                if (i % 2 != 0)
                                    trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                        '<td>' + data.d[i].Periodname + '</td>' +
                                        '<td>' + data.d[i].StartTime + '</td>' +
                                        '<td>' + data.d[i].EndTime + '</td>' +
                                        '<td>' + data.d[i].Subjectname + '</td>' +
                                        '<td>' + data.d[i].Facultyname + '</td></tr>';
                                else
                                    trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" value="' + data.d[i].Pid + '" /></td>' +
                                        '<td>' + data.d[i].Periodname + '</td>' +
                                        '<td>' + data.d[i].StartTime + '</td>' +
                                        '<td>' + data.d[i].EndTime + '</td>' +
                                        '<td>' + data.d[i].Subjectname + '</td>' +
                                          '<td>' + data.d[i].Facultyname + '</td></tr>';
                                $('.showdetail').append(trforappend);
                            }
                        }
                        else {
                            alertify.error("No Record Found");
                        }
                    },
                    error: function (result) {
                        alertify.error('Some Error');
                    }
                });
            }
        });
        
    </script>
</asp:Content>

