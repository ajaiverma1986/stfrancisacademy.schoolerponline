<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="transportFeeCollection.aspx.cs" Inherits="BranchPanel_Fee_Management_transportFeeCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">

         <div class="tbl-top-heading"><h2>Transport Fee Collection List </h2>
              <div class="upload">
                  <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i> <asp:Button ID="btnPdf"  runat="server"  Visible="true" Text="Download Pdf File"
                CausesValidation="false" Height="20px" CssClass="BtnExcel1"
                ToolTip="Click here to download Pdf"  ClientIDMode="Static"/> 
                 
                  </div>

               <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i> <asp:Button ID="IBExcel" runat="server"  Visible="true" Text="Download Excel File"
                CausesValidation="false" Height="20px" CssClass="BtnExcel"
                ToolTip="Click here to download Excel sheet"  ClientIDMode="Static"/>  
                      </div>
        </div>
            <input type="hidden" value="" id="hdnFile"/>
        <div class="clear"></div>
              <div class="grid-data-resposive">
                   <div class="for_sigle_row_form" style="margin-top:-12px !important;">
           <div class="searchbar containerHeadline" id="GridBatch">
                 <div class="clear"></div>
               <asp:TextBox ID="txtfromdate" runat="server" Placeholder="From Date" Width="100px" Height="25px" onkeypress="return false"></asp:TextBox>
               <asp:TextBox ID="txttodate" runat="server" Placeholder="To Date" Width="100px" Height="25px" onkeypress="return false"></asp:TextBox>
               <asp:TextBox ID="txtname" runat="server" Placeholder="Name" Width="130px" Height="25px"></asp:TextBox>
               <asp:TextBox ID="txtmobile" runat="server" Placeholder="Parent Mobile No. " Width="140px" Height="25px"></asp:TextBox>
               <asp:TextBox ID="txtreciptno" runat="server" Placeholder="Receipt No." Width="140px" Height="25px"></asp:TextBox>
               <asp:DropDownList runat="server" ID="ddlkPayment" Width="128px" Height="31px">
                   <asp:ListItem Value="0">---Select One---</asp:ListItem>
                   <asp:ListItem Value="1">Cash</asp:ListItem>
                   <asp:ListItem Value="2">Cheque</asp:ListItem>
                   <asp:ListItem Value="3">DD</asp:ListItem>
                   <asp:ListItem Value="4">Card</asp:ListItem>
                   <asp:ListItem Value="5">NEFT</asp:ListItem>
               </asp:DropDownList>
               <asp:DropDownList ID="ddlVehicle" runat="server" Width="105px" Height="31px"></asp:DropDownList>
                <asp:DropDownList ID="ddlfyear" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>
                <asp:ImageButton ID="btnclear" Width="25px" ImageUrl="~/images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
                  <div class="clear"></div>
      </div>
                       </div>
             <div class="divTableDataHolder m-l-sm m-r-sm">
                 <table class="stm" width="100%" cellpadding="0" cellspacing="0">
                     <tr class="stm_head" align="center">
                         <th align="center" scope="col">S.No.</th>
                         <th align="center" scope="col">Date</th>
                         <th align="center" scope="col">Adm No</th>
                         <th align="center" scope="col">Name</th>
                         <th align="center" scope="col">Parent Name</th>
                         <th align="center" scope="col">Mob No</th>
                         <th align="center" scope="col">Class</th>
                         <th align="center" scope="col">Sec</th>
                         <th align="center" scope="col">Trans Name</th>
                         <th align="center" scope="col">Trip</th>
                         <th align="center" scope="col">Area</th>
                         <th align="center" scope="col">Trans Fee </th>                         
                         <th align="center" scope="col">Cal Amount</th>
                         <th align="center" scope="col">Rec Amount</th>
                         <th align="center" scope="col">FeeMonth</th>
                         <th align="center" scope="col">Fine</th>
                         <th align="center" scope="col">Receipt No</th>
                         <th align="center" scope="col">LoggedInUser</th>
                     </tr>
                 </table>
                
                 <table class="GridSum" style="width: 100%" cellpadding="0" cellspacing="0">
                     <tr class="stm_head" align="center">
                         <td align="center" scope="col"></td>
                         <td align="center" scope="col"></td>
                         <td align="center" scope="col"></td>
                         <td align="center" scope="col"></td>
                         <td align="center" scope="col"></td>
                          <td align="center" scope="col"></td>
                         <td align="center" scope="col">Total</td>
                         <td align="center" scope="col">
                             <label id="SumOfFee"></label>

                         </td>
                         <td align="center" scope="col">
                             <label id="SumOfTax"></label>

                         </td>
                         <td align="center" scope="col">
                             <label id="SumOfTotalFee"></label>

                         </td>
                     </tr>
                 </table>
                   <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">           
        <label style="font-size: 15px; color: red">Sorry collection list not found.</label>
        </div>
</div>
</div>
        <table style="width: 100%">
                <tr>
                    <td style="padding: 5px; " class="containerHeadline" colspan="10">
                        <table border="0" width="100%">
                                <tr>
                                    <td>
                        <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>                         </td>

                  <td>      <div style="margin-left: 0px; float: left; width: 500px;">
                            <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div> </td>
                                    </tr> </table>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="hfpages" />
        <script type="text/javascript">
            var year = 2028;
            var fromdate = "", todate = "", name = "", Total = 0, VehicleID=0, TotalFeePaid=0,Fyid=1, TotalServiceTax=0, PaidTaxAmount=0, mobileno = '', receiptno = "", pagesize = 1000, pageno = 1, pagecount = 1, paymentmode = 0;
            $(document).ready(function () {
                BindGrid();
                BindVehicle();
                $(".lblpage").html(1);
                $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd MM yy',
                    yearRange: '2023:' + year
                });
                $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                    FillField();
                    BindGrid();
                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_txtname,#ctl00_ContentPlaceHolder1_txtmobile,#ctl00_ContentPlaceHolder1_txtreciptno").keyup(function () {
                    FillField();
                    BindGrid();
                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_ddlkPayment,#ctl00_ContentPlaceHolder1_ddlfyear").on('change', function () {
                    FillField();
                    BindGrid();
                    return false;
                });

                $("#ctl00_ContentPlaceHolder1_ddlVehicle").on('change', function () {
                    FillField();
                    BindGrid();
                    return false;
                });

                $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                    ClearField();
                    BindGrid();
                    return false;
                });
                $('.btnfirst').live('click', function () {
                    pageno = 1;
                    $(".lblpage").html(pageno);
                    FillField();
                    BindGrid();
                    alertify.success('You Are On The First Page.');
                    return false;
                });
                $('.btnprev').live('click', function () {
                    if (parseInt(pageno) > 1) {
                        pageno = parseInt(pageno) - 1;
                        $(".lblpage").html(pageno);
                        FillField();
                        BindGrid();
                        return false;
                    }
                    else {
                        alertify.error('No More Prevoius Page Is There.');
                        return false;
                    }
                });
                $('.btnnext').live('click', function () {

                    if (parseInt(pageno) < parseInt(pagecount)) {
                        pageno = parseInt(pageno) + 1;
                        $(".lblpage").html(pageno);
                        FillField();
                        BindGrid();
                        return false;
                    }
                    else {
                        alertify.error('No More Next Page Is There.');
                        return false;
                    }
                });
                $('.btnlast').live('click', function () {
                    pageno = pagecount;
                    $(".lblpage").html(pageno);
                    FillField();
                    BindGrid();
                    alertify.success('You Are On The Last Page.');
                    return false;
                });
                $(".BtnExcel").click(function (e) {
                    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                        if (e) {
                            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divTableDataHolder').html()));
                            e.preventDefault();
                        }
                    });
                    return false;
                });

                $("#btnPdf").click(function (e) {
                    alertify.confirm("Are You Sure You Want To Download The Pdf.", function (e) {
                        if (e) {
                            download_file($('#hdnFile').val(), "collection.pdf")
                            e.preventDefault();
                        }
                    });
                    return false;
                });
            });

            function download_file(fileURL, fileName) {
                // for non-IE
                if (!window.ActiveXObject) {
                    var save = document.createElement('a');
                    save.href = fileURL;
                    save.target = '_blank';
                    var filename = fileURL.substring(fileURL.lastIndexOf('/') + 1);
                    save.download = fileName || filename;
                    if (navigator.userAgent.toLowerCase().match(/(ipad|iphone|safari)/) && navigator.userAgent.search("Chrome") < 0) {
                        document.location = save.href;
                        // window event not working here
                    } else {
                        var evt = new MouseEvent('click', {
                            'view': window,
                            'bubbles': true,
                            'cancelable': false
                        });
                        save.dispatchEvent(evt);
                        (window.URL || window.webkitURL).revokeObjectURL(save.href);
                    }
                }

                // for IE < 11
                else if (!!window.ActiveXObject && document.execCommand) {
                    var _window = window.open(fileURL, '_blank');
                    _window.document.close();
                    _window.document.execCommand('SaveAs', true, fileName || fileURL)
                    _window.close();
                }
            }

            function BindVehicle() {
                var trforappend = "";
                $('.BindVehicle tr:gt(0)').remove();
                call_progressbar("start");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../transportmanagment/vehicle-list.aspx/BindGridByjsVehicle",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddlVehicle').html('<option value="0">--Select Vehicle--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddlVehicle').append('<option value="' + data.d[i].vehicleid + '">' + data.d[i].Vehiclename + '</option>');
                            }
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

            function FillField() {
                fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
                todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
                name = $('#ctl00_ContentPlaceHolder1_txtname').val();
                mobileno = $('#ctl00_ContentPlaceHolder1_txtmobile').val();
                receiptno = $('#ctl00_ContentPlaceHolder1_txtreciptno').val();
                paymentmode = $('#ctl00_ContentPlaceHolder1_ddlkPayment').val();
                Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
                VehicleID = $('#ctl00_ContentPlaceHolder1_ddlVehicle').val();
            }

            function ClearField() {
                fromdate = "", todate = "", name = "", mobileno = "", receiptno = "", paymentmode = 0, Fyid = 0;
                $(".lblpage").html(1);
                $('#ctl00_ContentPlaceHolder1_txtfromdate').val('');
                $('#ctl00_ContentPlaceHolder1_txttodate').val('');
                $('#ctl00_ContentPlaceHolder1_txtname').val('');
                $('#ctl00_ContentPlaceHolder1_txtmobile').val('');
                $('#ctl00_ContentPlaceHolder1_txtreciptno').val('');
                $('#ctl00_ContentPlaceHolder1_ddlkPayment').val('0');
                $('#ctl00_ContentPlaceHolder1_ddlfyear').val('0');
            }

            function BindGrid() {
                $('.stm tr:gt(0)').remove();
                call_progressbar('start')
                var trforappend = '', trclass = '';
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "transportFeeCollection.aspx/BindGridByJs",
                    data: "{'fromdate':'" + fromdate + "','todate':'" + todate + "','name':'" + name + "','receiptno':'" + receiptno + "','mobileno':'" + mobileno + "','paymentmode':'" + paymentmode + "','Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "','VehicleID':'" + VehicleID + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#hdnFile').val('');
                        $('.divnorecordfound').css('display', 'none');
                        if (data.d.length > 0) {
                            $('#hdnFile').val(data.d[0].filePath);
                            pagecount = data.d[0].pagecount;
                            $('.lbltotalpage').html(data.d[0].pagecount);
                            if ($(".lblpage").html() == 0) {
                                $(".lblpage").html(1);
                            }
                            for (var i = 0; i < data.d.length; i++) {
                                trforappend = trforappend + "<tr class='stm_light'>" +
                                    "<td>" + (i + 1) + "</td>" +
                                    "<td>" + data.d[i].PaidDate + " </td>" +
                                    "<td>" + data.d[i].RegNewNo + " </td>" +
                                    "<td>" + data.d[i].studentname + " </td>" +
                                    "<td>" + data.d[i].ParentName + " </td>" +
                                    "<td>" + data.d[i].PrimaryMobileNo + " </td>" +
                                    "<td>" + data.d[i].Classname + " </td>" +
                                    "<td>" + data.d[i].Sectionname + " </td>" +
                                    "<td>" + data.d[i].TransportName + " </td>" +
                                    "<td>" + data.d[i].Trip + " </td>" +
                                    "<td>" + data.d[i].AreaName + " </td>" +
                                    "<td>" + data.d[i].PaidAmountWithOutTax + " </td>" +
                                    "<td>" + data.d[i].PaidAmountWithOutTax + " </td>" +
                                    "<td>" + data.d[i].PaidAmountWithOutTax + " </td>" +
                                    "<td>" + data.d[i].FeeMonth + " </td>" +
                                    "<td>" + data.d[i].FineAmount + " </td>" +
                                    "<td>" + data.d[i].ReciptNo + " </td>" +
                                    "<td>" + data.d[i].UserName + " </td>" +
                                    "</tr>"
                            }
                            $('.stm').append(trforappend);
                            $('.GridSum').show();
                            Total = 0, TotalFeePaid = 0, TotalServiceTax = 0, totalAmount1 = 0;
                            for (var i = 0; i < data.d.length; i++) {
                                 totalAmount1 = totalAmount1 + parseFloat(data.d[i].PaidAmountWithOutTax) + parseFloat(data.d[i].FineAmount);
                            }
                            $('#SumOfFee').text(parseFloat(totalAmount1).toFixed(2));
                            $('#SumOfTax').text(parseFloat(totalAmount1).toFixed(2));
                            $('#SumOfTotalFee').text(parseFloat(totalAmount1).toFixed(2));
                        }
                        else {
                            $('.GridSum').hide();
                            $('.divnorecordfound').css('display', 'inline');
                            $(".lblpage").html(0);
                            $('.lbltotalpage').html(0);
                        }
                        call_progressbar("end");
                    },
                    error: function (result) {
                        alertify.error("Error While Grid Is Binding");
                        call_progressbar("end");
                    }
                });
            }

        </script>
            <div id="divProgressBar" class="progress"></div>
    </div>
    </div>
</asp:Content>

