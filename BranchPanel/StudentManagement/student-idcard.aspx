<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-idcard.aspx.cs" Inherits="BranchPanel_StudentManagement_student_idcard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">


         .idcard-setting-radio {
             margin: 0 auto;
             width:470px;
             height:28px;
             background:rgb(235, 235, 235) none repeat scroll 0 0;
             float:none;
             clear:both;
             margin-top:40px;
             display:block;
             border:1px solid #ddd;
         }

         .idcard-setting-radio dd{
             float:left;
             margin-left:10px;
             margin-top:2px;
         }


        .qum {
            border: 1px solid #cdcdcd !important;
            padding:0 0 8px;
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

    <div class="clear"></div>

    <div class="content_pane_cont input_content branch-div-tbl"  id="contentPane">

        <div class="tbl-top-heading">
            <h2>Student ID Card List</h2>

            <div class="upload">
                <i class="fa fa-print icon"><b class="bg-info"></b></i>
                <asp:Button ID="btnPrint" runat="server" Text="Print" />
            </div>
            <div class="upload" style="display:none">
                <i class="fa  fa-save icon"><b class="bg-info"></b></i>
                <asp:Button ID="btnsubmit" runat="server" Text="Save" ToolTip="Click here to Save Settings."/>
            </div>

            <div class="idcard-setting" style="display:none">

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
                 <asp:DropDownList ID="ddlfinancialyear" runat="server" style="height: 31px; width: 110px;">
                    </asp:DropDownList>
                 
                <select style="height: 31px; width: 120px;" runat="server" id="ddlclass"></select>
                <input type="text" placeholder="Profile No" id="txtrollno" style="width:140px" />
                <input type="text" placeholder="Parent Mobile No" id="txtmobileno" style="width:140px" />
                <input type="text" placeholder="Name" id="txtname" style="width:140px" />
                <input id="btnclear" type="image" style="width: 25px; border-width: 0px; margin-left: 0px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search." />
                 </div>

                 
            <div class="searchbar containerHeadline" style="display:none">
                   <div class="idcard-setting-radio">  <dd>ID Card format</dd> 
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
         

            <div id="divhorizontal">
                <table class="Binddivhorizontal" style="margin: 0 13px;">
                </table>
            </div>

            <div id="divvertical">
                <table class="Binddivvertical" style="margin: 0 7px;">
                </table>
            </div>
            <div class="clear"></div>
             <div style="margin-left: 0px; float: left; width: 500px;" class="page-number">
                            <asp:Label ID="lblpage" CssClass="lblpage"
                                runat="server"></asp:Label>
                           <span> of</span>
                        <asp:Label ID="lblTotalPages" CssClass="lbltotalpage"
                            runat="server"></asp:Label>
                            <span">Page</span>
                        </div>  
             <div class="clear"></div>
            <div style="margin-left: 500px; float: left; width: 500px;">
                            <img src="../../images/first.gif" id="btnfirst" class="btnfirst" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/previous.gif" id="btnprev" class="btnprev" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/next.gif" id="btnnext" class="btnnext" style="cursor: pointer; "
                                alt="" />
                            <img src="../../images/last.gif" id="btnlast" class="btnlast" style="cursor: pointer; "
                                alt="" />
                        </div> 
             <div class="clear"></div>
              <input type="hidden" id="hfpages" />
            <div id="divProgressBar" class="progress"></div>
        </div>
    </div>

    <script type="text/javascript">
        var width = "", height = "", photoplace = "", bgcolor = "", logoplace = "", view_type = 0, printview_type = 0,
            classid = 0, AdmissionNo = '', fyid = 0, pagesize = 100, standard_type = 0, fontcolor = "", Brid = 0, RollNo = '', Mobileno = '', Name = '',
             pageno = 1, pagecount = 1;

        $(document).ready(function () {
            BindClass();
            Brid = "<%= Session["BrBrid"] %>"
            Fillsetting();
            View_Type();
            $("#ctl00_ContentPlaceHolder1_btnback").click(function () {
                $("#divsetting").hide(500);
                View_Type();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnsetting").click(function () {
                Fillsetting();
                $("#divsetting").show(500);
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_btnsubmit").click(function () {
                alertify.confirm("Are You Sure To Submit Student ID Card Settings.?", function (e) {
                    if (e) {
                        if ($('#<%=rbgender.ClientID %> input[type=radio]:checked').val() == 0) {
                            photoplace = "Left";
                        }
                        else if ($('#<%=rbgender.ClientID %> input[type=radio]:checked').val() == 1) {
                            photoplace = "Right";
                        }
                        else {
                            photoplace = "Center";
                        }
                        if ($('#<%=rblogo.ClientID %> input[type=radio]:checked').val() == 0) {
                            logoplace = "Top";
                        }
                        else {
                            logoplace = "Bottom";
                        }
                        view_type = $('#<%=rbview.ClientID %> input[type=radio]:checked').val();
                        standard_type = $('#<%=rdbtnstandard.ClientID %> input[type=radio]:checked').val();
                        width = $("#ctl00_ContentPlaceHolder1_txtwidth").val();
                        height = $("#ctl00_ContentPlaceHolder1_txtheight").val();
                        bgcolor = $('.inputforfontcolorcode').val();
                        fontcolor = $('.fontcolorcodenew').val();
                        Savesetting();
                    }
                });
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_btnPrint").click(function () {
                return false;
            });
            $("#btnclear").click(function () {
                classid = 0, AdmissionNo = '', Mobileno = '', Name = '';
                $("#ctl00_ContentPlaceHolder1_ddlclass").val('0');
                $('#txtrollno').val('');
                $('#txtmobileno').val('');
                $('#txtname').val('');
                FillFeild();
                View_Type();
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_ddlfinancialyear,#ctl00_ContentPlaceHolder1_ddlclass,#txtrollno,#txtmobileno,#txtname").change(function () {
                FillFeild();
                View_Type();
                return false;
            });

            $('.inputforfontcolorcode').change(function () {
                bgcolor = '';
                bgcolor = $(this).val();
                $('.carda').css("background-color", bgcolor);
                $('.qum').css('background', bgcolor);
                //$('.print-foot').css("background-color", bgcolor);
            });
            $('.fontcolorcodenew').change(function () {
                fontcolor = '';
                fontcolor = $(this).val();
                $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
            });
            $("#ctl00_ContentPlaceHolder1_btnPrint").click(function () {
                if (printview_type == 1) {
                    printdiv_horizontal();
                }
                else if (printview_type == 2) {
                    printdiv_vertical();
                }

                return false;
            });

            $("#ctl00_ContentPlaceHolder1_ddlpazesize").change(function () {
                FillFeild();
                if (pagesize != "Page Size") {
                    View_Type();
                }
                return false;
            });

            $('.btnfirst').live('click', function () {
                pageno = 1;
                $(".lblpage").html(pageno);
                View_Type();
                alertify.success('You Are On The First Page.');
                return false;
            });
            $('.btnprev').live('click', function () {
                if (parseInt(pageno) > 1) {
                    pageno = parseInt(pageno) - 1;
                    $(".lblpage").html(pageno);
                    View_Type();
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
                    View_Type();
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
                View_Type();
                alertify.success('You Are On The Last Page.');
                return false;
            });

            $("#ctl00_ContentPlaceHolder1_rdbtnstandard").change(function () {
                standard_type = $('#<%=rdbtnstandard.ClientID %> input[type=radio]:checked').val();
                if (parseInt(standard_type) == 0 && view_type == 0) {
                    Binddivhorizontal_Standard();
                    printview_type = 1;
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                }
                else if (parseInt(standard_type) == 0 && view_type == 1) {
                    Binddivvertical_Standard();
                    printview_type = 2;
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                }
                else if (parseInt(standard_type) == 1 && view_type == 0) {
                    Binddivhorizontal();
                    printview_type = 1;
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                }
                else if (parseInt(standard_type) == 1 && view_type == 1) {
                    Binddivvertical();
                    printview_type = 2;
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                }
                $('.carda').css("background-color", bgcolor);
                $('.qum').css('background', bgcolor);
                $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                return false;
            });
            $("#ctl00_ContentPlaceHolder1_rbview").change(function () {
                view_type = $('#<%=rbview.ClientID %> input[type=radio]:checked').val();
                if (standard_type == 0 && view_type == 0) {
                    Binddivhorizontal_Standard();
                    printview_type = 1;
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                }
                else if (standard_type == 0 && view_type == 1) {
                    Binddivvertical_Standard();
                    printview_type = 2;
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                }
                else if (standard_type == 1 && view_type == 0) {
                    Binddivhorizontal();
                    printview_type = 1;
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                }
                else if (standard_type == 1 && view_type == 1) {
                    Binddivvertical();
                    printview_type = 2;
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                }
                $('.carda').css("background-color", bgcolor);
                $('.qum').css('background', bgcolor);
                $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                return false;
            });

            ////@@@@@@@  Change DDL Branch List  


        });

        function printdiv_vertical() {
            $('.Binddivvertical').find('tbody').find('tr').find('td').each(function () {
                if ($(this).find('div').find('input[type=checkbox]').attr('checked') != "checked") {
                    $(this).find('div').css("display", "none");
                }
            });
            $('input[type=checkbox]').css("display", "none");
            var printWindow = window.open('left=500,top=500,width=500,height=500');
            printWindow.document.write($('#divvertical').html());
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
            $('input[type=checkbox]').css("display", "block");
            $('.Binddivvertical').find('tbody').find('tr').find('td').find('div').css("display", "block");
        }

        function printdiv_horizontal() {
            $('.Binddivhorizontal').find('tbody').find('tr').find('td').each(function () {
                if ($(this).find('input[type=checkbox]').attr('checked') != "checked") {
                    $(this).find('div').css("display", "none");
                }
            });
            $('input[type=checkbox]').css("display", "none");
            var printWindow = window.open('left=500,top=500,width=500,height=500');
            printWindow.document.write($('#divhorizontal').html());
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
            $('input[type=checkbox]').css("display", "block");
            $('.Binddivhorizontal').find('tbody').find('tr').find('td').find('div').css("display", "block");
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
        
        function Savesetting() {
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../HO/studentidcard-settings.aspx/Addidcartsetting",
                data: "{'width':'" + width + "','height':'" + height + "','photoplace':'" + photoplace + "','bgcolor':'" + bgcolor + "','logoplace':'" + logoplace + "','view_type':'" + view_type + "','standard_type':'" + standard_type + "','fontcolor':'" + fontcolor + "','fyid':'" + fyid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == 1) {
                        call_progressbar("end");
                        alertify.success("Student Id Card Detail Setting Submitted Successfully.");
                        Fillsetting();
                        View_Type();
                    }
                    call_progressbar("end");
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }

        function Fillsetting() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../HO/studentidcard-settings.aspx/Fillsetting",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {

                            $('.inputforfontcolorcode').val(data.d[i].bgcolor);
                            $('.fontcolorcodenew').val(data.d[i].fontcolor);
                            bgcolor = data.d[i].bgcolor;
                            fontcolor = data.d[i].fontcolor;
                            $('.carda').css("background-color", data.d[i].bgcolor);
                            $('.qum').css('background', data.d[i].bgcolor);
                            $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                            $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);

                            if (data.d[i].photo_place == "Left") {
                                $('#<%= rbgender.ClientID %> input[value="0"]').attr('checked', 'checked');
                            }
                            else if (data.d[i].photo_place == "Right") {
                                $('#<%= rbgender.ClientID %> input[value="1"]').attr('checked', 'checked');
                            }
                            else {
                                $('#<%= rbgender.ClientID %> input[value="2"]').attr('checked', 'checked');
                            }
                        if (data.d[i].logo_place == "Top") {
                            $('#<%= rblogo.ClientID %> input[value="0"]').attr('checked', 'checked');
                        }
                        else {
                            $('#<%= rblogo.ClientID %> input[value="1"]').attr('checked', 'checked');
                        }
                        if (data.d[i].view_type == 0) {
                            $('#<%= rbview.ClientID %> input[value="0"]').attr('checked', 'checked');
                              view_type = 0;
                          }
                          else {
                              $('#<%= rbview.ClientID %> input[value="1"]').attr('checked', 'checked');
                              view_type = 1;
                          }
                          if (data.d[i].standard_type == 0) {
                              $('#<%= rdbtnstandard.ClientID %> input[value="0"]').attr('checked', 'checked');
                            standard_type = 0;
                        }
                        else {
                            $('#<%= rdbtnstandard.ClientID %> input[value="1"]').attr('checked', 'checked');
                            standard_type = 1;
                        }

                    }
                }

                },
                error: function (result) {
                    alertify.error("Error");
                }
            });
    }
    function FillFeild() {
        fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
        
        classid = $('#ctl00_ContentPlaceHolder1_ddlclass').val();
        AdmissionNo = $('#txtrollno').val();
        Mobileno = $('#txtmobileno').val();
        Name = $('#txtname').val();
        pagesize = $("#ctl00_ContentPlaceHolder1_ddlpazesize option:selected").text();
    }

    function Binddivhorizontal() {
        $('.Binddivhorizontal').html('');
        var trforappend = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "student-idcard.aspx/BindGridByJs",
            data: "{'fyid':'" + fyid + "','classid':'" + classid + "','AdmissionNo':'" + AdmissionNo + "','Mobileno':'" + Mobileno + "','Name':'" + Name + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                trforappend = '<tr>';
                if (data.d.length > 0) {
                    $('#hfpages').val(data.d[0].pagecount)
                    pagecount = parseInt(data.d[0].pagecount);
                    $(".lbltotalpage").html(pagecount);
                    $(".lblpage").text('1');
                    for (var i = 0; i < data.d.length; i++) {
                        trforappend = trforappend +
                       '<td style="padding:0 8px 10px 0px;"> <div class="qum"  style="color: Black; min-width:340px; height:220px; background-color: #FFFDEA; border-color: #000000; border-width: 1px; border-style: solid;"> ' +
                       '<input type="checkbox" checked="checked" />' +
                       '<div class="student-photo_frame1riz" style="text-align: left; line-height:18px;">' +
                       '<h3 class="iit_h2" style="font-size: 40px;  font-family: Arial; color: #010060; text-align:Left; margin: 0px 0 20px 0;  width: 200px;  height: 42px; padding: 0px; font-weight: bold;"><img src="../images/' + data.d[i].Logo + '" alt="No Image" style="padding-left:8px;" /></h3>' +
                       '<b style="font-family: Arial; color: #010060; font-weight: bold; padding-left:8px;">Profile No: </b> <span>' + data.d[i].AdmissionNo + '</span><br />' +
                       '<b style="padding-left:8px; font-size:13px; font-family:Arial; color:010060;"> Name: </b><span>' + data.d[i].Name + '</span><br />' +
                       '<b style="padding-left:8px; font-size:13px; font-family:Arial; color:010060;">DOB: </b><span>' + data.d[i].StudentDob + '</span><br />' +
                       '<b style="padding-left:8px; font-size:13px; font-family:Arial; color:010060;">Class: </b><span>' + data.d[i].Classname + '</span><br />' +

                          '<b style="font-family: Arial; color: #010060; font-weight: bold; padding-left:8px;">Valid Till: </b><span>' + data.d[i].FYName + '</span><br/>' +
                       '<div class="student-photo_frame_imgr dey" style="height: 100px; width: 100px; margin: 10px; float: right; border: 1px solid #ccc; padding: 3px; position: relative; top: -190px;"><img id="Img1" alt="No Image" style="height: 100px; width: 100px; border-width: 0px;" src="../BranchPanel/Student-Registration/student-registration-document/' + data.d[i].StudentPhotograph + '" /> <br /><div class="clear"></div>' +
                       '<h5 class="iit_h5" style="font-size: 11px; font-family: Arial; color: #000100; margin: 10px 0 0 0; padding: 0px; font-weight: normal; text-align: center; position: relative; top: 10px;">Authorised Signature </h5> </div></div>' +
                       '<div style="text-align: left; "> <span></span><br /> ' +
                       '<div style="clear:both;"></div>' +
                       '<div style="margin-top:76px;"><b style="padding-left:8px; font-size:13px; font-family:Arial; color:010060;">Address:</b>' + data.d[i].BranchAdress + 'Ph:' + data.d[i].BranchMobileNo + '<br />  </div></td>';
                        if (i > 0) {
                            if ((i + 1) % 3 == 0) {
                                trforappend = trforappend + '</tr><tr>'
                            }
                        }
                    }
                    if ((data.d.length - 1) % 1 != 0) {
                        trforappend = trforappend + '</tr>';
                    }
                }
                else {
                    $(".lbltotalpage").html('0');
                    $(".lblpage").text('0');
                }
                $('.Binddivhorizontal').html(trforappend);
                //pagecount = parseInt(data.d[0].pagecount);
                //if (parseInt(pagecount) == 1) {
                //    $(".lbltotalpage").html("1");
                //    $(".lblpage").text("1");
                //}
                //else {
                //    $(".lbltotalpage").html(0);
                //    $(".lblpage").text(0);
                //}
            },
            error: function (response) {
            }
        });

    }

    function Binddivhorizontal_Standard() {
        $('.Binddivhorizontal').html('');
        var trforappend = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../HO/studentidcard-settings.aspx/BindGridByJs",
            data: "{'fyid':'" + fyid + "','Brid':'" + Brid + "','classid':'" + classid + "','AdmissionNo':'" + AdmissionNo + "','Mobileno':'" + Mobileno + "','Name':'" + Name + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                trforappend = '<tr>';
                if (data.d.length > 0) {
                    $('#hfpages').val(data.d[0].pagecount)
                    pagecount = parseInt(data.d[0].pagecount);
                    $(".lbltotalpage").html(pagecount);
                    $(".lblpage").text('1');
                    for (var i = 0; i < data.d.length; i++) {
                        trforappend = trforappend +
                       '<td style="padding:0 8px 10px 0px;"> <div class="qum" style="color: Black; min-width:340px; background-color: #FFFDEA; border-color: #000000; border-width: 1px; border-style: solid;">' +
                       '<input type="checkbox" checked="checked" />' +
                       '<div class="student-photo_frame1riz" style="text-align: left; line-height:18px;">' +
                       '<h3 class="iit_h2" style="font-size: 40px; font-family: Arial; color: #010060; margin: 0px 0 20px 0; width: 200px;  text-align:left;  height: 42px;  padding: 0px; font-weight: bold;"><img src="../../images/' + data.d[i].Logo + '" alt="No Image" style="padding-left:8px;" /></h3>' +
                       ' <b style="font-family: Arial; color: #010060; font-size:13px; padding-left:8px;">Profile No: </b><span style="font-family: Arial; color: #010060; font-size:13px;">' + data.d[i].AdmissionNo + '</span><br />' +
                       '<b style="font-family: Arial; color: #010060; font-size:13px; padding-left:8px;">Name: </b> <span style="font-family: Arial; color: #010060; font-size:13px;">' + data.d[i].Name + '</span><br />' +
                       '<b style="font-family: Arial; color: #010060; font-size:13px; padding-left:8px;">DOB: </b><span style="font-family: Arial; color: #010060; font-size:13px;">' + data.d[i].StudentDob + '</span><br/>' +
                         '<b style="font-family: Arial; color: #010060; font-size:13px; padding-left:8px;">Valid Till: </b><span style="font-family: Arial; color: #010060; font-size:13px;">' + data.d[i].FYName + '</span>' +
                       '<div class="student-photo_frame_imgr dey" style="height: 100px; width: 100px; margin: 10px; float: right; border: 1px solid #ccc; padding: 3px; position: relative; margin-top:-50px;"><img id="Img1" alt="No Image" style="height: 100px; width: 100px; border-width: 0px;" src="../Student-Registration/student-registration-document/' + data.d[i].StudentPhotograph + '" /> <br /><div class="clear"></div>' +
                       '<h5 class="iit_h5" style="font-size: 11px; font-family: Arial; color: #000100; margin: 10px 0 0 0; padding: 0px; font-weight: normal; text-align: center; position: relative; top: 0px;">Authorised Signature </h5> </div></div>' +

                        '<br />' +
                        '<div class="clear"></div> ' +
                       '<div style="margin-top:40px;"><b style="font-family: Arial; color: #010060; font-size:13px; padding-left:8px;">Address: </b>' + data.d[i].BranchAdress + 'Ph:' + data.d[i].BranchMobileNo + '<br /> </div> </div></td>';
                        if (i > 0) {
                            if ((i + 1) % 3 == 0) {
                                trforappend = trforappend + '</tr><tr>'
                            }
                        }
                    }
                    if ((data.d.length - 1) % 1 != 0) {
                        trforappend = trforappend + '</tr>';
                    }
                }
                else {
                    $(".lbltotalpage").html('0');
                    $(".lblpage").text('0');
                }
                $('.Binddivhorizontal').html(trforappend);
                //pagecount = parseInt(data.d[0].pagecount);
                //if (parseInt(pagecount) == 1) {
                //    $(".lbltotalpage").html("1");
                //    $(".lblpage").text("1");
                //}
                //else {
                //    $(".lbltotalpage").html(0);
                //    $(".lblpage").text(0);
                //}
            },
            error: function (response) {
                alert('Error');
            }
        });

    }

    function Binddivvertical() {

        $('.Binddivvertical').html('');
        var trforappend = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../HO/studentidcard-settings.aspx/BindGridByJs",
            data: "{'fyid':'" + fyid + "','Brid':'" + Brid + "','classid':'" + classid + "','AdmissionNo':'" + AdmissionNo + "','Mobileno':'" + Mobileno + "','Name':'" + Name + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                trforappend = '<tr>';
                if (data.d.length > 0) {
                    $('#hfpages').val(data.d[0].pagecount)
                    pagecount = parseInt(data.d[0].pagecount);
                    $(".lbltotalpage").html(pagecount);
                    $(".lblpage").text('1');
                    for (var i = 0; i < data.d.length; i++) {
                        trforappend = trforappend + '<td>' +
                       '<div class="carda" style="margin: 5px;Height:auto"><input type="checkbox" checked="checked" /><br />' +
                       '<div class="logo_img" style="text-align: center;"><img src="../images/' + data.d[i].Logo + '" alt="No Image" height="85px" width="90px" style="text-align: center;" />' +
                       '</div><br /><div class="student_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">' +
                       '<br /><br /><img style="height: 90px; width: 85px; border-width: 0px;" alt="No Image" src="../BranchPanel/Student-Registration/student-registration-document/' + data.d[i].StudentPhotograph + '" /><br /></div>' +
                       '<div class="id_student" style="text-align: center;"><b>Name :<span>' + data.d[i].Name + '</span></b><br />' +

                       '<b>Profile No: <span>' + data.d[i].AdmissionNo + '</span></b><div style="display: none"><input type="hidden" value=' + data.d[i].Registration_No + ' /></div><br />' +
                         '<b>DOB: <span>' + data.d[i].StudentDob + '</span></b><br />' +
                       '<b>Class :<span>' + data.d[i].Classname + '</span></b><br />' +
                         //'<b>Batch Name: </b><span>' + data.d[i].batch + '</span><br />' +
                           '<b>Valid Till: </b><span>' + data.d[i].FYName + '</span><br /></div>' +
                        '<div class="print-foot" style="text-align: center;">' + data.d[i].BranchAdress + '<br />' +
                       'Ph.:' + data.d[i].BranchMobileNo + '<br />Email : ' + data.d[i].EmailId + '<br />' +
                       '</div><div class="clear"></div><div class="clear"></div></div>' +
                       '</td>';
                        if (i > 0) {
                            if ((i + 1) % 3 == 0) {
                                trforappend = trforappend + '</tr><tr>'
                            }
                        }
                    }
                    if ((data.d.length - 1) % 3 != 0) {
                        trforappend = trforappend + '</tr>';
                    }
                }
                else {
                    $(".lbltotalpage").html('0');
                    $(".lblpage").text('0');
                }
                $('.Binddivvertical').html(trforappend);
                //pagecount = parseInt(data.d[0].pagecount);
                //if (parseInt(pagecount) == 1) {
                //    $(".lbltotalpage").html("1");
                //    $(".lblpage").text("1");
                //}
                //else {
                //    $(".lbltotalpage").html(0);
                //    $(".lblpage").text(0);
                //}
            },
            error: function (response) {
            }
        });
    }

    function Binddivvertical_Standard() {

        $('.Binddivvertical').html('');
        var trforappend = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../HO/studentidcard-settings.aspx/BindGridByJs",
            data: "{'fyid':'" + fyid + "','Brid':'" + Brid + "','classid':'" + classid + "','AdmissionNo':'" + AdmissionNo + "','Mobileno':'" + Mobileno + "','Name':'" + Name + "','pagesize':'" + pagesize + "','pageno':'" + pageno + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                trforappend = '<tr>';
                if (data.d.length > 0) {
                    $('#hfpages').val(data.d[0].pagecount)
                    pagecount = parseInt(data.d[0].pagecount);
                    $(".lbltotalpage").html(pagecount);
                    $(".lblpage").text('1');
                    for (var i = 0; i < data.d.length; i++) {
                        trforappend = trforappend + '<td>' +
                       '<div class="carda" style="margin: 5px;"><input type="checkbox" checked="checked" /><br />' +
                       '<div class="logo_img" style="margin: 0px auto 23px 47px;"><img src="../../images/' + data.d[i].Logo + '" alt="No Image" />' +
                       '</div><div class="student_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">' +
                       '<img style="height: 90px; width: 85px; border-width: 0px;" alt="No Image" src="../Student-Registration/student-registration-document/' + data.d[i].StudentPhotograph + '" /><br /></div>' +
                       '<div class="id_student" style="text-align: center;"><b>Name :<span>' + data.d[i].Name + '</span></b><br />' +
                       '<b>Profile No: <span>' + data.d[i].AdmissionNo + '</span></b><div style="display: none"><input type="hidden" value=' + data.d[i].Registration_No + ' /></div><br />' +
                       '<b>DOB: <span>' + data.d[i].StudentDob + '</span></b><br/>' +
                        '<b>Valid Till: </b><span>' + data.d[i].FYName + '</span><br /></div>' +
                       '<table class="print-foot" width="100%" cellspacing="0" cellpadding="0" border="0"><tbody>' +
                       '<tr><td>' + data.d[i].BranchAdress + '</td></tr><tr><td>Ph.:' + data.d[i].BranchMobileNo + '</td></tr><tr><td style="font-size: 10px; font-weight: normal; line-height:14px !important;">Email : ' + data.d[i].EmailId + '</td></tr>' +
                       '</tbody></table><div class="clear"></div></div>' +
                       '</td>';
                        if (i > 0) {
                            if ((i + 1) % 4 == 0) {
                                trforappend = trforappend + '</tr><tr>'
                            }
                        }
                    }
                    if ((data.d.length - 1) % 3 != 0) {
                        trforappend = trforappend + '</tr>';
                    }
                }
                else {
                    $(".lbltotalpage").html('0');
                    $(".lblpage").text('0');
                }
                $('.Binddivvertical').html(trforappend);
                //pagecount = parseInt(data.d[0].pagecount);
                //if (parseInt(pagecount) == 1) {
                //    $(".lbltotalpage").html("1");
                //    $(".lblpage").text("1");
                //}
                //else {
                //    $(".lbltotalpage").html(0);
                //    $(".lblpage").text(0);
                //}
            },
            error: function (response) {
            }
        });
    }

    function View_Type() {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../HO/studentidcard-settings.aspx/Viewtype",
            data: "{}",
            dataType: "json",
            async: false,
            success: function (data) {
                if (view_type == 0 && standard_type == 1) {

                    Binddivhorizontal();
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                    printview_type = 1;
                    $('.carda').css("background-color", bgcolor);
                    $('.qum').css('background', bgcolor);
                    $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    // $('.print-foot').css("background-color", bgcolor);
                    return false;
                }
                else if (view_type == 0 && standard_type == 0) {

                    Binddivhorizontal_Standard();
                    $("#divhorizontal").show(500);
                    $("#divvertical").hide(500);
                    printview_type = 1;
                    $('.carda').css("background-color", bgcolor);
                    $('.qum').css('background', bgcolor);
                    $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    //$('.print-foot').css("background-color", bgcolor);
                    return false;
                }
                else if (view_type == 1 && standard_type == 1) {
                    Binddivvertical();
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                    printview_type = 2;
                    $('.carda').css("background-color", bgcolor);
                    $('.qum').css('background', bgcolor);
                    $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    //$('.print-foot').css("background-color", bgcolor);
                    return false;
                }
                else if (view_type == 1 && standard_type == 0) {
                    Binddivvertical_Standard();
                    $("#divhorizontal").hide(500);
                    $("#divvertical").show(500);
                    printview_type = 2;
                    $('.carda').css("background-color", bgcolor);
                    $('.qum').css('background', bgcolor);
                    $('.Binddivhorizontal').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    $('.Binddivvertical').find('.carda,span,b,label,div,td,tr,h').css("color", fontcolor);
                    //$('.print-foot').css("background-color", bgcolor);
                    return false;
                }

            },
            error: function (result) {
                alertify.error("Some Internal Error Occurs.");
            }
        });
    }

        

    function BindClass() {
        
        fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
        call_progressbar("start");
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../Fee Management/overall-admissions.aspx/BindClassMethod",
            data: "{'fyid':'" + fyid + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                
                $("#ctl00_ContentPlaceHolder1_ddlclass").html("");
                $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val('0').html('-Select Class-'));
                $.each(data.d, function (key, value) {
                    
                    $("#ctl00_ContentPlaceHolder1_ddlclass").append($("<option></option>").val(value.courseID).html(value.courseName));

                });
                call_progressbar("end");
            },
            error: function () {
                call_progressbar("end");
                alertify.error("Some Error");
            }
        });
    }
    </script>
</asp:Content>

