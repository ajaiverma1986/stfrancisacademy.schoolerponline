<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="discount-list.aspx.cs" Inherits="BranchPanel_DiscountManagement_discount_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="clear"></div>
    <div class="branch-div-tbl">
    <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Student Discount List</h2>
                <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
            </div>
        <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="65px" ></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="60px"></asp:TextBox>
             <asp:TextBox ID="txtdiscountcode" Width="60px" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Discount Code"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="99px" Height="25px"></asp:TextBox>
            <asp:TextBox ID="txtstuname" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Student Name" Width="60px"></asp:TextBox>          
            <asp:TextBox ID="txtfathername" onkeypress="return lettersOnly(event)" MaxLength="15" runat="server" placeholder="Parent Name" Width="60px"></asp:TextBox>
            <asp:TextBox ID="txtgaurdianmobileno" onkeypress="return isNumberKey(event)" MaxLength="10"  runat="server" placeholder="Parent Mobile No" Width="60px"></asp:TextBox>
            <asp:DropDownList ID="ddldiscountgivenbyuser" runat="server" Width="93px" Height="31px" >     
            </asp:DropDownList>
            <asp:DropDownList ID="ddlclass" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>  
            <asp:DropDownList ID="ddlSection" runat="server" Width="105px" Height="31px">     
            </asp:DropDownList>     
            <asp:DropDownList ID="ddlfyear" runat="server" Width="105px" Height="31px" AutoPostBack="true">     
            </asp:DropDownList>     
            <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="../../images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>
        </div>
            <div class="divforstm">
            <table width="100%" class="stm stmdetail" border="0" cellspacing="0" cellpadding="0" runat="server" id="CourseGrid">
                <tr class="stm_head">
                    <th align="center">S.No.</th>
                    <th align="center">Discount Code</th>
                    <th align="center">Registration No</th>
                    <th align="center">Student Name</th>
                    <th align="center">Apply Class</th>
                    <th align="center">Parent Name</th>
                     <th align="center">Parent Mob No</th>
                     <th align="center">Discount Implemented</th>
                    <th align="center">Given By</th>
                    <th align="center">Comment/Remark</th>
                    <th align="center">Detail</th>
                    <th align="center">Delete</th>                   
                </tr>
            </table>
             <div class="clear"></div>
        <div class="divnorecordfound" style="margin-left: 480px; display: none">           
        <label style="font-size: 15px; color: red">Sorry Discount list not found.</label>
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
         <div class="DivForDailyStockListDetails" style="display: none">
                <div class="pop-headng-sty">
                   Student Discount Detail (<asp:Label ID="lblstudentname" runat="server" Text="hello.."></asp:Label>)              
        <a id="A1" title="Close this from here" class="btnClose">
            <img src="../../images/no.png" alt="No Image" class="ImgCloseStockDetails" /></a>
                </div>
                <table style="width: 98%;" class="stm1">
                    <tr class="stm_head">
                        <td>SNo.</td>
                        <td>Fee Category</td>
                        <td>Fee Head</td>
                        <td>Discount Type</td>
                        <td>Discount Month</td>
                        <td>Actual Fee</td>
                          <td>Discount</td>
                        <td>Fee After Discount</td>
                    </tr>
                </table>
               <table class="GridSum" style="width: 100%">
                <tr class="stm_head" >
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                <td style="color:red;">Total Actual Amount:</td>
                <td>
                <label id="lblTotalActualAmount"></label>
                </td>
                   <td style="color:red;">Total Discount Amount:</td>
                <td>
                <label id="lblTotalDiscountAmount"></label>
                </td>
                   <td style="color:red;">Total Fee After Discount:</td>
                <td>
                <label id="lblFeeAfterDiscount"></label>
                </td>
                </tr>
            </table>
            </div>
        </div>
    <script type="text/javascript">
        var pagesize = 500, pageno = 1, Fromdate = '', admissionno = '', Todate = '', TotalActualAmount = 0, TotalDiscountAmount = 0, TotalFeeAfterDiscount = 0, Discountcode = '', Registrationnumber = '', StudentName = '', Applyingforclass = 0,SectionID=0, Parentname = '', checkNo = '', studentid = 0, paymentmode = 0, Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val(), discountcode = '', discountid = 0, ParentMobileNo = '', discountgivenbyuser = 0;
        $(document).ready(function () {
            Bindclassddl();
            Bindstudentdiscount();
            var year = 2025;
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '2010:' + year
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                FillField();
                Bindstudentdiscount();
                return false;
            });           
            $("#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtdiscountcode,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno").keyup(function () {                
                FillField();
                Bindstudentdiscount();
                return false;
            });            
            $("#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddldiscountgivenbyuser").on('change keyup paste', function () {
                FillField();               
                Bindstudentdiscount();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlclass").on('change keyup paste', function () {
                FillField();               
                Bindstudentdiscount();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                    data: "{'ClassID':'" + ClassID + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                        $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                        $.each(data.d, function (key, value) {
                            $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                        });
                        call_progressbar("end");
                    }
                });
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlSection").on('change keyup paste', function () {
                FillField();                
                Bindstudentdiscount();
                return false;
            });
            $(".BtnExcel").click(function (e) {
                alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                    if (e) {
                        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                        e.preventDefault();
                    }
                });
                return false;
            });
            $('.showdiscount').live('click', function () {
                
                discountcode = $(this).parent('td').parent('tr').find('td:eq(1)').text();
                $('.DivForDailyStockListDetails').show(500);
                $('html, body').animate({
                    scrollTop: $(".DivForDailyStockListDetails").offset().top
                }, 1000);
                Binddiscountdetail();
                return false;
            });
            $('.ImgCloseStockDetails').click(function () { $('.DivForDailyStockListDetails').css("display", "none"); });
            $('.Delete').live('click', function () {
                discountid = $(this).closest('tr').find('input[type=hidden]').val();
                alertify.confirm("Are You Sure You Want To Delete Discount.", function (e) {
                    if (e) {
                        deletediscount();
                    }
                });
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                ClearAll();
                Bindstudentdiscount();
                return false;
            });
            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                FillField();
                Bindstudentdiscount();
                alertify.success('You Are On The First Page.');
                return false;
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    FillField();
                    Bindstudentdiscount();
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
                    Bindstudentdiscount();
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
                Bindstudentdiscount();
                alertify.success('You Are On The Last Page.');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlfyear').change(function () {
                Bindclassddl();
            });
        });
        function Bindclassddl() {
            $('#ctl00_ContentPlaceHolder1_ddlclass').html('');
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "../Student-Registration/student-registration-list.aspx/BindClassDDL",
                data: "{'Fyid':'" + $('#ctl00_ContentPlaceHolder1_ddlfyear').val() + "'}",
                dataType: "json",
                success: function (data) {
                    $('#ctl00_ContentPlaceHolder1_ddlclass').html('<option value="0">--Select Class--</option>');
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            $('#ctl00_ContentPlaceHolder1_ddlclass').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                        }
                    }
                }
            });
        }
        function BindSection() {          
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../Fee Management/overdue-fee.aspx/BindSectionMethod",
                data: "{'ClassID':'1'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_ddlSection").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val('0').html('Select Section'));
                    $.each(data.d, function (key, value) {
                        $("#ctl00_ContentPlaceHolder1_ddlSection").append($("<option></option>").val(value.courseID).html(value.courseName));

                    });
                    call_progressbar("end");
                }
            });
        }
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                alertify.error("Please Enter Character Only.");
                return false;
            }
            else
                return true;
        };
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        function FillField() {
            var ClassID = 0;
            Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
            Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
            Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
            StudentName = $('#ctl00_ContentPlaceHolder1_txtstuname').val();
            Parentname = $('#ctl00_ContentPlaceHolder1_txtfathername').val();
            ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
            Discountcode = $('#ctl00_ContentPlaceHolder1_txtdiscountcode').val();
            Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
            ClassID = Applyingforclass;
            if (ClassID > 0) {
                if ($('#ctl00_ContentPlaceHolder1_ddlSection').val() != null) {
                    SectionID = $('#ctl00_ContentPlaceHolder1_ddlSection').val();
                }
                else {
                    SectionID = 0;
                }
            }
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
            discountgivenbyuser = $('#ctl00_ContentPlaceHolder1_ddldiscountgivenbyuser').val();            
        }
        function ClearAll() {
            Fromdate = '', Todate = '', Registrationnumber = '', StudentName = '', Parentname = '', ParentMobileNo = '', Discountcode = '', ParentMobileNo, Applyingforclass = 0, Fyid = 1, discountgivenbyuser=0;
            Applyingforclass = 0, Status = 0, Fyid = 0; 
            $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txtgivenbyuser,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtdiscountcode,#ctl00_ContentPlaceHolder1_txtfathername,#ctl00_ContentPlaceHolder1_txtstuname,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber').val('');         
            $('#ctl00_ContentPlaceHolder1_ddldiscountgivenbyuser').val('0');
            $('#ctl00_ContentPlaceHolder1_ddlfyear').val('1');
            Bindclassddl();
        }
        function Bindstudentdiscount() {     
            $('.stm tr:gt(0)').remove();
            call_progressbar('start')
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "discount-list.aspx/BindGridByJs",
                data: "{'SectionID':'"+ SectionID +"','Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','StudentName':'" + StudentName + "','Parentname':'" + Parentname + "','Discountcode':'" + Discountcode + "','ParentMobileNo':'" + ParentMobileNo + "','Applyingforclass':'" + Applyingforclass + "','Fyid':'" + Fyid + "','discountgivenbyuser':'" + discountgivenbyuser + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
                dataType: "json",
                success: function (data) {
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 0) {
                        pagecount = data.d[0].pagecount;
                        $('.lbltotalpage').html(data.d[0].pagecount);
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                        for (var i = 0; i < data.d.length; i++) {
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td><input type='hidden' value='" + data.d[i].DSID + "' />" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].DiscountCode + " </td>" +
                            "<td>" + data.d[i].RegistrationNo + " </td>" +
                            "<td>" + data.d[i].StudentName + " </td>" +
                            "<td>" + data.d[i].ApplyClass + " </td>" +
                            "<td>" + data.d[i].ParentName + " </td>" +
                            "<td>" + data.d[i].Parentmobile + " </td>" +
                            "<td>" + data.d[i].IsDiscountImplemented + " </td>" +
                            "<td>" + data.d[i].discountgivenbyuser + " </td>" +
                            "<td>" + data.d[i].Comment_Remark + " </td>" +
                              "<td><img src='../../images/viewquestion.png' style='border-width:0px;height:15px;width:15px;border-width:0px;' title='Click here to show detail.' class='showdiscount'></img></td>" +
                               "<td><img src='../../images/delete.gif' style='cursor:pointer' title='Click here to delete.' class='Delete'></img></td>" +
                            "</tr>"
                        }
                        $('.stm').append(trforappend);
                    }
                    else {
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
        function Binddiscountdetail() {
            $('.stm1 tr:gt(0)').remove();
            call_progressbar('start')
            var trforappend = '', trclass = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "discount-list.aspx/BindGridByJsfordiscountdetail",
                data: "{'discountcode':'" + discountcode + "'}",
                dataType: "json",
                success: function (data) {
                   
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length - 1; i++) {
                            TotalActualAmount = parseFloat(TotalActualAmount) + parseFloat(data.d[i].ActualFeeBeforeDiscount);
                            trforappend = trforappend + "<tr class=" + trclass + ">" +
                            "<td>" + (i + 1) + "</td>" +
                            "<td>" + data.d[i].FeeCategoryName + " </td>" +
                            "<td>" + data.d[i].FeeHeadName + " </td>" +
                            "<td>" + data.d[i].DiscountTypeName + " </td>" +
                            "<td>" + data.d[i].DiscountInMonthName + " </td>" +
                            "<td>" + data.d[i].ActualFeeBeforeDiscount + " </td>" +
                            "<td>" + data.d[i].Discount1 + " </td>" +
                            "<td>" + data.d[i].FeeAfterDiscount + " </td>" +                            
                            "</tr>"
                        }                        
                        $('.stm1').append(trforappend);
                        //for (var i = 0; i < data.d.length; i++) {
                        //    //TotalActualAmount += parseFloat(data.d[i].ActualFeeBeforeDiscount);
                        //    TotalDiscountAmount += parseFloat(data.d[i].Discount1);
                        //    TotalFeeAfterDiscount += parseFloat(data.d[i].FeeAfterDiscount);
                        //    $('#ctl00_ContentPlaceHolder1_lblstudentname').text(data.d[i].studentname);
                        //}
                        //TotalActualAmount = parseFloat(data.d[data.d.length - 1].ActualFeeBeforeDiscount);
                        TotalDiscountAmount = parseFloat(data.d[data.d.length - 1].Discount1);
                        TotalFeeAfterDiscount = parseFloat(TotalActualAmount - TotalDiscountAmount);

                        $('#ctl00_ContentPlaceHolder1_lblstudentname').text(data.d[0].studentname);
                        $('#lblTotalActualAmount').text(TotalActualAmount.toFixed(2));
                        $('#lblTotalDiscountAmount').text(TotalDiscountAmount.toFixed(2));
                        $('#lblFeeAfterDiscount').text(TotalFeeAfterDiscount.toFixed(2));

                       
                    }
                    
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error("Error While Grid Is Binding");
                    call_progressbar("end");
                }
            });
        }
        function deletediscount() {
            call_progressbar('start')
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "discount-list.aspx/Deletediscount",
                data: "{'discountid':'" + discountid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Deleted Successfully.");
                        Bindstudentdiscount();
                        call_progressbar("end");
                    }    
                },
                error: function (result) {
                    alertify.error("Error While Deleting.");
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
      <div id="divProgressBar" class="progress"></div>
</asp:Content>

