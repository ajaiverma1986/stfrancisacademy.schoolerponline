<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="rejected-candidate-list.aspx.cs" Inherits="BranchPanel_ShorlistingProcess_rejected_candidate_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clear"></div>
    <div class="branch-div-tbl">
        <div class="content_pane_cont input_content" id="contentPane">
            <div class="tbl-top-heading">
                <h2>Rejected Candidate List</h2>
                <div class="upload">
                    <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                    <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                        CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                        ToolTip="Click here to download Excel sheet" />
                </div>
            </div>
            <div class="for_sigle_row_form" style="margin-top:-12px !important;">
                <input id="btnselectandsendsms" class="button_save" type="submit" style="border-radius: 0px ! important; display: block; float: left;" onclick="return false;" value="Shortlist & Send Message" />
                <input id="btnonlyshortlist" class="button_save" type="submit" style="border-radius: 0px ! important; display: block; float: left;margin-left:10px" onclick="return false;" value="Shortlist" />
                <input id="btnwaiting" class="button_save" type="submit" style="border-radius: 0px ! important; display: block; float: left;margin-left:10px" onclick="return false;" value="Waiting" />
            </div>
            <div class="clear"></div>           
              <div class="for_sigle_row_form" style="margin-top:-12px !important;">
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" onkeypress="return false" placeholder="From Date" Width="70px" ></asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" onkeypress="return false" placeholder="To Date" Width="70px"></asp:TextBox>
             <asp:TextBox ID="txtregnumber" runat="server" placeholder="Registration No" Width="111px"></asp:TextBox>
            <asp:DropDownList ID="ddlparentqualification" runat="server" Width="208" Height="31px">
                    </asp:DropDownList>
            <asp:DropDownList ID="ddlsecondaryparenthighestqualification" runat="server" Width="225px" Height="31px">
                    </asp:DropDownList>
            <asp:TextBox ID="txtgaurdianmobileno" onkeypress="return isNumberKey(event)" MaxLength="10" runat="server" placeholder="Parent Mobile No" Width="111px"></asp:TextBox>
             <asp:TextBox ID="txtpreviouspercentage" onkeypress="return isNumberKey(event)" MaxLength="3" runat="server" placeholder="Previous Percentage" Width="135px"></asp:TextBox>
            <asp:DropDownList ID="ddlclass" runat="server" Width="113px" Height="31px">     
            </asp:DropDownList>
                        <asp:ImageButton ID="btnclear" style="height:25px;width:25px;margin-top:2px" ImageUrl="../../images/clearsearch.png" runat="server" ToolTip="Click Here For Reset The Search." />
            <asp:DropDownList ID="ddlpparentincome" runat="server" Width="209px" Height="31px" style="margin-left:0px">
                <asp:ListItem Value="0" Text="Select Primary Parent Income"></asp:ListItem>
                <asp:ListItem Value="1" Text="0 to 50,000"></asp:ListItem>
                <asp:ListItem Value="2" Text="50,000 to 100000"></asp:ListItem>
                <asp:ListItem Value="3" Text="100000 to 150000"></asp:ListItem>
                <asp:ListItem Value="4" Text="150000 to 200000"></asp:ListItem>
                <asp:ListItem Value="5" Text="200000 to 250000"></asp:ListItem>
                <asp:ListItem Value="6" Text="250000 to 300000"></asp:ListItem>
                <asp:ListItem Value="7" Text="300000 to 350000"></asp:ListItem>
                <asp:ListItem Value="8" Text="350000 to 400000"></asp:ListItem>
                <asp:ListItem Value="9" Text="400000 to 450000"></asp:ListItem>
                <asp:ListItem Value="10" Text="450000 to 500000"></asp:ListItem>
                <asp:ListItem Value="11" Text="500000 to More"></asp:ListItem>              
                </asp:DropDownList>
              <asp:DropDownList ID="ddlsincome" runat="server" Width="235px" Height="33px">
                <asp:ListItem Value="0" Text="Select Secondary Parent Income"></asp:ListItem>
                <asp:ListItem Value="1" Text="0 to 50,000"></asp:ListItem>
                <asp:ListItem Value="2" Text="50,000 to 100000"></asp:ListItem>
                <asp:ListItem Value="3" Text="100000 to 150000"></asp:ListItem>
                <asp:ListItem Value="4" Text="150000 to 200000"></asp:ListItem>
                <asp:ListItem Value="5" Text="200000 to 250000"></asp:ListItem>
                <asp:ListItem Value="6" Text="250000 to 300000"></asp:ListItem>
                <asp:ListItem Value="7" Text="300000 to 350000"></asp:ListItem>
                <asp:ListItem Value="8" Text="350000 to 400000"></asp:ListItem>
                <asp:ListItem Value="9" Text="400000 to 450000"></asp:ListItem>
                <asp:ListItem Value="10" Text="450000 to 500000"></asp:ListItem>
                <asp:ListItem Value="11" Text="500000 to More"></asp:ListItem>              
                </asp:DropDownList>
              <asp:DropDownList ID="ddlcategory" runat="server" Width="150px" Height="33px">
                <asp:ListItem Value="0" Text="Select Category"></asp:ListItem>
                <asp:ListItem Value="1" Text="General"></asp:ListItem>
                <asp:ListItem Value="2" Text="OBC"></asp:ListItem>
                <asp:ListItem Value="3" Text="SC"></asp:ListItem>
                <asp:ListItem Value="4" Text="ST"></asp:ListItem>
                <asp:ListItem Value="5" Text="Minority"></asp:ListItem>                          
            </asp:DropDownList>
            <asp:DropDownList ID="ddlstatus" runat="server" Width="170px" Height="31px">              
                <asp:ListItem Value="1" Text="Addmision Not Taken"></asp:ListItem>
				<asp:ListItem Value="2" Text="Addmision Taken"></asp:ListItem>
            </asp:DropDownList>
             <asp:DropDownList ID="ddlfyear" runat="server" Width="102px" Height="31px">     
            </asp:DropDownList>
            <div class="clear"></div>
        </div>
 </div>
            <div class="grid-data-resposive">
                <div class="divTableDataHolder">
                    <div class="divforstm">
                        <table class="stm" style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr class="stm_head" align="center">
                                <th align="center" scope="col">S.No.</th>
                                <th align="center" scope="col">Registartion Date</th>
                                <th align="center" scope="col">Registration No.</th>
                                <th align="center" scope="col">Student Name</th>
                                <th align="center" scope="col">Parent Name</th>
                                <th align="center" scope="col">Parent Mobile</th>
                                <th align="center" scope="col">Apply For Class</th>
                                <th align="center" scope="col">Admission Status</th>
                                <th align="center" scope="col">
                                <input type="checkbox" class="checkall" />Check All</th>
                            </tr>
                        </table>
                         <div class="divnorecordfound" style="margin-left: 480px; display: none">
            <label style="font-size: 15px; color: red">Sorry there is no rejected candidate found.</label>
        </div>
                    </div>                
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
                        </div>
                                    </td>
                             <td><div style="margin-left: 0px; float: left; width: 500px;">
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
        </div>
  
    <script type="text/javascript">
        var pagesize = 100,IsAdmissionTaken=1, pageno = 1,Fyid = 1, ClassId = 0, CssClass = '', IsShortListed = 0, IsRejected = 0, IsWaiting = 0, TrForAppend = '', AllRID = '', IsUpdate = 0, Fromdate = '', maxincome = '', minincome = '', Primaryparentincome = 0, Secondaryparentincome = 0, percentage = '', PrimaryHighestQualification = 0, Secondaryparentqualification = 0, Todate = '', cast = 0, Applyingforclass = 0, ParentMobileNo = '', Registrationnumber = '';
        //When 
        //IsUpdate=1 Then Shortlisted
        //IsUpdate=2 Then Rejected
        //IsUpdate=3 Then Waiting
        $(document).ready(function () {
            Bindclassddl();
            BindGrid();
            var year = 2015;
            $("#ctl00_ContentPlaceHolder1_txtgaurdianmobileno").keyup(function () {
                FillField();
                BindGrid();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy',
                yearRange: '1970:' + year
            });
            $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").on('change keyup paste', function () {
                FillField();
                BindGrid();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtpreviouspercentage").keyup(function () {
                FillField();
                BindGrid();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlsincome,#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlpparentincome,#ctl00_ContentPlaceHolder1_ddlclass,#ctl00_ContentPlaceHolder1_ddlcategory,#ctl00_ContentPlaceHolder1_ddlparentqualification,#ctl00_ContentPlaceHolder1_ddlsecondaryparenthighestqualification").on('change keyup paste', function () {
                FillField();
                BindGrid();
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
            $('.checkall').change(function () {
                $('.ckhforselect').prop('checked', $(this).prop('checked'));
            });
            $('#btnselectandsendsms').click(function () {
                var confirmstatus = confirm('Are you sure you want to  send the sms to the checked student\nfor admission.?');
                if (confirmstatus == true) {
                    IsUpdate = 1;
                    GetAllRID();
                    alertify.error('Sms feature not acivated now.');
                }
            });
            $('#btnonlyshortlist').click(function () {
                var confirmstatus = confirm('Are you sure you want to shortlist the selected student\nfor admission.?');
                if (confirmstatus == true) {
                    IsUpdate = 1;
                    GetAllRID();
                    BindGrid();
                }
            });
            $('#btnwaiting').click(function () {
                var confirmstatus = confirm('Are you sure you want to send in waiting list.?');
                if (confirmstatus == true) {
                    IsUpdate = 3;
                    GetAllRID();
                    BindGrid();
                }
            });
            $('#ctl00_ContentPlaceHolder1_btnclear').click(function () {
                ClearAll();
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
        function FillField() {
            IsAdmissionTaken = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();
            Fyid = $('#ctl00_ContentPlaceHolder1_ddlfyear').val();
            Fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
            Todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
            Registrationnumber = $('#ctl00_ContentPlaceHolder1_txtregnumber').val();
            ParentMobileNo = $('#ctl00_ContentPlaceHolder1_txtgaurdianmobileno').val();
            Applyingforclass = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
            cast = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
            percentage = $('#ctl00_ContentPlaceHolder1_txtpreviouspercentage').val();
            PrimaryHighestQualification = $('#ctl00_ContentPlaceHolder1_ddlparentqualification').val();
            Secondaryparentqualification = $('#ctl00_ContentPlaceHolder1_ddlsecondaryparenthighestqualification').val();
            Primaryparentincome = $('#ctl00_ContentPlaceHolder1_ddlpparentincome').val();
            Secondaryparentincome = $('#ctl00_ContentPlaceHolder1_ddlsincome').val();
            if (Primaryparentincome == 1 || Secondaryparentincome == 1) {
                maxincome = '0'
                minincome = '50000'
            }
            else if (Primaryparentincome == 2 || Secondaryparentincome == 2) {
                maxincome = '50000'
                minincome = '100000'
            }
            else if (Primaryparentincome == 3 || Secondaryparentincome == 3) {
                maxincome = '100000'
                minincome = '150000'
            }
            else if (Primaryparentincome == 4 || Secondaryparentincome == 4) {
                maxincome = '150000'
                minincome = '200000'
            }
            else if (Primaryparentincome == 5 || Secondaryparentincome == 5) {
                maxincome = '200000'
                minincome = '250000'
            }
            else if (Primaryparentincome == 6 || Secondaryparentincome == 6) {
                maxincome = '250000'
                minincome = '300000'
            }
            else if (Primaryparentincome == 7 || Secondaryparentincome == 7) {
                maxincome = '300000'
                minincome = '350000'
            }
            else if (Primaryparentincome == 8 || Secondaryparentincome == 8) {
                maxincome = '350000'
                minincome = '400000'
            }
            else if (Primaryparentincome == 9 || Secondaryparentincome == 9) {
                maxincome = '450000'
                minincome = '500000'
            }
            else if (Primaryparentincome == 10 || Secondaryparentincome == 10) {
                maxincome = '500000'
                minincome = '1000000'
            }
            else if (Primaryparentincome == 11 || Secondaryparentincome == 11) {
                maxincome = '1000000'
                minincome = '10000000000'
            }
        }
        function ClearAll() {
            Fromdate = '', IsAdmissionTaken=0,Fyid = 0, Primaryparentincome = 0, Secondaryparentincome = 0, percentage = '', PrimaryHighestQualification = 0, Secondaryparentqualification = 0, Todate = '', cast = 0, Applyingforclass = 0, ParentMobileNo = '', Registrationnumber = '';
            $('#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtregnumber,#ctl00_ContentPlaceHolder1_txtgaurdianmobileno,#ctl00_ContentPlaceHolder1_txtpreviouspercentage').val('');
            $('#ctl00_ContentPlaceHolder1_ddlstatus,#ctl00_ContentPlaceHolder1_ddlfyear,#ctl00_ContentPlaceHolder1_ddlsincome,#ctl00_ContentPlaceHolder1_ddlpparentincome,#ctl00_ContentPlaceHolder1_ddlcategory,#ctl00_ContentPlaceHolder1_ddlparentqualification,#ctl00_ContentPlaceHolder1_ddlsecondaryparenthighestqualification').val('0');
            Bindclassddl();
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alertify.error("Please Enter Only Numeric Value.");
                return false;
            }
            else
                return true;
        }
        function GetAllRID() {
            $('.stm').find('tr:gt(0)').each(function () {
                if ($(this).find('input[type="checkbox"]').prop('checked'))
                    AllRID = AllRID + ',' + $(this).find('input[type="hidden"]').val();
            });
            AllRID = AllRID.slice(1, AllRID.length);
            if (AllRID == '') {
                alertify.error('No Candiate are selected.');
                return false;
            }
            PerformAction()
        }
        function BindGrid() {
            var i = 0;
            $('.stm tr:gt(0)').remove();
            call_progressbar('start')
            var TrForAppend = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-selection.aspx/BindGeneralDetails",
                data: "{'Fyid':'" + Fyid + "','Classid':'" + ClassId + "','IsShortListed':'" + IsShortListed + "','IsRejected':'" + 1 + "','IsWaiting':'" + IsWaiting + "','Fromdate':'" + Fromdate + "','Todate':'" + Todate + "','Registrationnumber':'" + Registrationnumber + "','ParentMobileNo':'" + ParentMobileNo + "','Applyingforclass':'" + Applyingforclass + "','cast':'" + cast + "','percentage':'" + percentage + "','PrimaryHighestQualification':'" + PrimaryHighestQualification + "','Secondaryparentqualification':'" + Secondaryparentqualification + "','Primaryparentincome':'" + Primaryparentincome + "','Secondaryparentincome':'" + Secondaryparentincome + "','maxincome':'" + maxincome + "','minincome':'" + minincome + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "','IsAdmissionTaken':'" + IsAdmissionTaken + "'}",
                dataType: "json",
                async: false,
                success: function (data) {                
                    $('.divnorecordfound').css('display', 'none');
                    if (data.d.length > 14) {
                    var xmlDocGeneralDetails = $.parseXML(data.d);
                    var xmlGeneralDetails = $(xmlDocGeneralDetails);
                    var TableGeneralDetails = xmlGeneralDetails.find("Table");
                    TableGeneralDetails.each(function () {
                        if (i % 2 == 0)
                            CssClass = 'stm_dark';
                        else
                            CssClass = 'stm_light';
                        var CurrentDeailsRow = $(this);
                        TrForAppend = TrForAppend + '<tr class=' + CssClass + '><td><input type="hidden" value=' + CurrentDeailsRow.find("RID").text() + '>' + (i+1) + '</td>' +
                            '<td>' + CurrentDeailsRow.find("RegistrationDate").text() + '</td>' +
                             '<td>' + CurrentDeailsRow.find("Registration_No").text() + '</td>' +
                              '<td>' + CurrentDeailsRow.find("StudentName").text() + '</td>' +
                               '<td>' + CurrentDeailsRow.find("ParentName").text() + '</td>' +
                                '<td>' + CurrentDeailsRow.find("ParentMobileNo").text() + '</td>' +
                                 '<td>' + CurrentDeailsRow.find("ClassName").text() + '</td>' +
                                   '<td>' + CurrentDeailsRow.find("AdmissionStatus").text() + '</td>' +
                                  '<td><input type="checkbox" class="ckhforselect" /></td></tr>'
                        i = i + 1;
                        pagecount = CurrentDeailsRow.find("Pages").text();
                        $('.lbltotalpage').html(CurrentDeailsRow.find("Pages").text());
                        if ($(".lblpage").html() == 0) {
                            $(".lblpage").html(1);
                        }
                    });
                    $('.stm').append(TrForAppend);
                    }

                    else {
                        $('.divnorecordfound').css('display', 'inline');
                        $(".lblpage").html(0);
                        $('.lbltotalpage').html(0);
                    }
                    call_progressbar("end");
                },
                error: function (response) {
                    alert('Unable To Access Server.');
                    call_progressbar("end");
                }
            });
        }
        function PerformAction() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "student-selection.aspx/PeformActionOnCandidate",
                data: "{'AllRID':'" + AllRID + "','IsUpdate':'" + IsUpdate + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        if (parseInt(IsUpdate) == 1) {
                            alertify.success('Selected Candidate shortlisted successfully.');
                            AllRID = '', IsUpdate = 0;
                            return false;
                        }
                        else if (parseInt(IsUpdate) == 2) {
                            alertify.success('Selected Candidate rejected successfully.');
                            AllRID = '', IsUpdate = 0;
                            return false;
                        }
                        else if (parseInt(IsUpdate) == 3) {
                            alertify.success('Selected Candidate send in waiting list successfully.');
                            AllRID = '', IsUpdate = 0;
                            return false;
                        }
                        else {
                            alertify.success('Nothing Happen....!!!!.');
                            AllRID = '', IsUpdate = 0;
                            return false;
                        }
                        BindGrid();
                    }
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

