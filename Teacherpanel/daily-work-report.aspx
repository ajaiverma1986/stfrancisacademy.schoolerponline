<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="daily-work-report.aspx.cs" Inherits="EmployeePanel_daily_work_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../css/jquery-ui.css" rel="stylesheet" />

    <link href="../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../js/alertify.js" type="text/javascript"></script>

    <style>
        .workreportactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        th {
            border-top: 1px black !important;
        }

        .stm_head1 {
            text-align: left!important;
            padding-left: 5px!important;
        }

        .stm td {
            border-bottom: 1px solid black !important;
        }

        #ctl00_head_tablemaingrid input[type=text] {
            width: 80px !important;
            height: 30px !important;
            border: 1px solid #69C1F1 !important;
            text-align: center !important;
        }

        #ctl00_head_tablemaingrid input[type=file] {
            width: 84px !important;
            height: 35px !important;
        }

        .ui-autocomplete {
            max-height: 150px;
            overflow-x: scroll;
            font-size: 11px;
            min-width: 70px!important;
            width: auto!important;
            border: 2px solid #82403B;
            text-decoration-line: underline;
        }

        .ui-menu-item a {
            border-bottom: 1px solid #82403B!important;
        }

        .clasforworklist {
            width: 150px;
            background-color: #82403B;
            height: 40px;
            color: white;
            cursor: pointer;
            text-align: center;
            margin-left: -13px;
            border: 2px solid #82403B;
        }

        .classforsubmit {
            width: 170px;
            background-color: #F3EEE7;
            height: 40px;
            color: black;
            cursor: pointer;
            text-align: center;
            margin-left: 137px;
            margin-top: -40px;
            border: 2px solid #82403B;
        }

        .showpopup2 {
            background-color: #82403B!important;
            border: 1px solid black;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: white;
            font-family: sans-serif;
            height: auto;
            /*left: 32%;*/
            opacity: 1;
            position: relative;
            /*top: 15%;*/
            width: 100%!important;
            z-index: 2147483647;
        }
    </style>

    <script type="text/javascript">

        var classname = "", section = "", classid = "0", subject = "", subjectid = "0", unitname = "", unitid = "0", topicname = "", sectionid = "0", topicid = "0", description = "", pid = "0", periodname = "", filename = "", homework = "", date = "", dateforreport = "", fileuploadcontrolid = "", ImageLogoByteCode = "";
        var cls = "";

        $(document).ready(function () {
            $(document).on("click", "[id*=gridmain] [id*=btnforinsert]", function () {
                cls = $(this).closest('tr').find('.class').val();
                description = $(this).closest('tr').find('.description').val();

                if (cls != "" && description != "") {
                    classid = $(this).closest('tr').find('.clssid').text();
                    sectionid = $(this).closest('tr').find('.sectionid').text();
                    subjectid = $(this).closest('tr').find('.subjectid').text();
                    unitid = $(this).closest('tr').find('.unitid').text();
                    unitname = $(this).closest('tr').find('.unit').val();
                    topicid = $(this).closest('tr').find('.topicid').text();
                    topicname = $(this).closest('tr').find('.topic').val();
                    date = $("#ctl00_head_txtdate").val();
                    pid = $(this).closest('tr').find('.pid').text();
                    periodname = $(this).closest('tr').find('.periodname').text();
                    homework = $(this).closest('tr').find('.homework').val();

                    alertify.confirm("Are you sure you want to submit the details? Make sure that after submitting the details you can not update.", function (e) {
                        if (e) {
                            add_daily_work_report();
                        }
                    });
                }
                else {
                    alertify.error("Please enter the details of work report first.");
                }

                return false;
            });

            $(document).on("change", "[id*=gridmain] [id*=fileuploadofworksoftcopy]", function () {
                var controlid = $(this).attr('id');
                fileuploadcontrolid = controlid;
                var stat = cv_validation(controlid);
                if (stat != false) {
                    $.each($('#' + controlid + '').prop("files"), function (k, v) {
                        filename = v['name'];
                    });
                }

                return false;
            });

            //==================code for getting class name==========================

            $(document).on("focus keyup", "[id*=gridmain] [id*=txtclass]", function () {

                classname = $(this).val();
                var controlid = $(this).attr('id');

                $(".class").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "daily-work-report.aspx/GetClassname",
                            data: "{'classname':'" + classname + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.split(',')[1],
                                            val: item.split(',')[0]
                                        }
                                    }))
                                }
                                else {
                                    response([{ label: 'No class available.', val: 0 }])
                                }

                            },
                            error: function () {
                                return false;
                            }
                        });
                    },

                    select: function (e, i) {   //classid = i.item.val;
                        $("#" + controlid + "").closest('tr').find('.clssid').text(i.item.val);

                    },
                    minLength: 0
                }).focus(function () { $(this).autocomplete("search", ""); });

            });

            //==================code for getting section name==========================
            $(document).on("focus keyup", "[id*=gridmain] [id*=txtsection]", function () {
                var sectioncotrolid = $(this).attr('id');

                classid = $(this).closest('tr').find('.clssid').text();
                section = $(this).val();
                $(".section").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "daily-work-report.aspx/GetSection",
                            data: "{'classid':'" + classid + "','section':'" + section + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.split(',')[1],
                                            val: item.split(',')[0]
                                        }
                                    }))
                                }
                                else {
                                    response([{ label: 'No section available.', val: 0 }])
                                }

                            },
                            error: function () {
                                return false;
                            }
                        });
                    },
                    select: function (e, i) {   //classid = i.item.val;
                        $("#" + sectioncotrolid + "").closest('tr').find('.sectionid').text(i.item.val);

                    },
                    minLength: 0
                }).focus(function () { $(this).autocomplete("search", ""); });
            });

            //==================code for getting Subject Name==========================
            $(document).on("focus keyup", "[id*=gridmain] [id*=txtsubject]", function () {
                var subjectcontrolid = $(this).attr('id');
                classid = $(this).closest('tr').find('.clssid').text();
                subject = $(this).val();
                $(".subject").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "daily-work-report.aspx/GetSubjectName",
                            data: "{'classid':'" + classid + "','subject':'" + subject + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {
                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.split(',')[1],
                                            val: item.split(',')[0]
                                        }
                                    }))
                                }
                                else {
                                    response([{ label: 'No subject available.', val: 0 }])
                                }

                            },
                            error: function () {
                                return false;
                            }
                        });
                    },
                    select: function (e, i) {
                        //subjectid = i.item.val;
                        $("#" + subjectcontrolid + "").closest('tr').find('.subjectid').text(i.item.val);
                    },
                    minLength: 0
                }).focus(function () { $(this).autocomplete("search", ""); });
            });

            //==================code for getting UNIT Name==========================
            $(document).on("focus keyup", "[id*=gridmain] [id*=txtunit]", function () {
                var unitcontrolid = $(this).attr('id');
                classid = $(this).closest('tr').find('.clssid').text();
                subjectid = $(this).closest('tr').find('.subjectid').text();

                unitname = $(this).val();
                $(".unit").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "daily-work-report.aspx/GetUnitName",
                            data: "{'classid':'" + classid + "','subjectid':'" + subjectid + "','unitname':'" + unitname + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d != "") {

                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.split(',')[1],
                                            val: item.split(',')[0]
                                        }
                                    }))
                                }
                                else {
                                    response([{ label: 'No unit available.', val: 0 }]);

                                }

                            },
                            error: function () {
                                return false;
                            }
                        });
                    },
                    select: function (e, i) {
                        $("#" + unitcontrolid + "").closest('tr').find('.unitid').text(i.item.val);
                    },
                    minLength: 0
                }).focus(function () { $(this).autocomplete("search", ""); });
            });

            //==================code for getting Topic name on behalf of unit==========================
            $(document).on("focus keyup", "[id*=gridmain] [id*=txttopic]", function () {
                var topiccontrolid = $(this).attr('id');
                unitid = $(this).closest('tr').find('.unitid').text();
                topicname = $(this).val();
                $(".topic").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "daily-work-report.aspx/GetTopicName",
                            data: "{'unitid':'" + unitid + "','topicname':'" + topicname + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {

                                if (data.d != "") {

                                    response($.map(data.d, function (item) {
                                        return {
                                            label: item.split(',')[1],
                                            val: item.split(',')[0]
                                        }
                                    }))
                                }
                                else {
                                    response([{ label: 'No topic available.', val: 0 }])
                                }

                            },
                            error: function () {
                                return false;
                            }
                        });
                    },
                    select: function (e, i) {
                        $("#" + topiccontrolid + "").closest('tr').find('.topicid').text(i.item.val);
                    },
                    minLength: 0

                }).focus(function () { $(this).autocomplete("search", ""); });
            });

            $("#ctl00_head_txtdate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: new Date,
            });

            $("#ctl00_head_txtdateforreport").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                maxDate: new Date,
            });

            $("#divforworklist").click(function () {

                $("#ctl00_head_trmaingridrecord").css("display", "none");
                $("#ctl00_head_trforreportgrid").css("display", "block");
                $("#ctl00_head_trfortxtdate").css("display", "none");

                $("#divforworklist").css("background-color", "#82403B");
                $("#divforworklist").css("color", "white");
                $("#divforsubmit").css("background-color", "#F3EEE7");
                $("#divforsubmit").css("color", "black");
                dateforreport = $("#ctl00_head_txtdateforreport").val();
                get_emp_daily_report();

                return false;
            });
            $("#divforsubmit").click(function () {

                $("#ctl00_head_trmaingridrecord").css("display", "block");
                $("#ctl00_head_trforreportgrid").css("display", "none");
                $("#ctl00_head_trfortxtdate").css("display", "block");

                $("#divforworklist").css("background-color", "#F3EEE7");
                $("#divforworklist").css("color", "black");
                $("#divforsubmit").css("background-color", "#82403B");
                $("#divforsubmit").css("color", "white");
                $("#ctl00_head_trformsg").css("display", "none");

                return false;
            });

            $("#ctl00_head_txtdateforreport").change(function () {
                dateforreport = $("#ctl00_head_txtdateforreport").val();
                get_emp_daily_report();
                return false;
            });

            $(document).on("mouseover", "[id*=GridView1] [id*=lnkbtnforclasswork]", function () {
                var claswrk = $(this).closest('td').find('span').text();
                var pos = $(this).position();
                var width = $(this).outerWidth();
                $("#ctl00_head_lblforclassworkmessage").text(claswrk);
                $("#divformessage").show().css({ position: 'absolute', top: pos.top + 14 + "px", right: "295px" });
                return false;
            });

            $(document).on("mouseover", "[id*=GridView1] [id*=lnkbtnforhomework]", function () {
                var homework = $(this).closest('td').find('span').text();
                var pos = $(this).position();
                var width = $(this).outerWidth();
                $("#ctl00_head_lblforclassworkmessage").text(homework);
                $("#divformessage").show().css({ position: 'absolute', top: pos.top + 14 + "px", right: "205px" });
                return false;
            });

            $(document).on("mouseleave", "[id*=GridView1] [id*=lnkbtnforclasswork]", function () {
                $("#divformessage").hide();
                return false;
            });

            $(document).on("mouseleave", "[id*=GridView1] [id*=lnkbtnforhomework]", function () {
                $("#divformessage").hide();
                return false;
            });

            $(document).on("mouseover", "[id*=GridView1] [id*=lnkbtnfordownload]", function () {

                var pos = $(this).position();
                var width = $(this).outerWidth();

                $("#ctl00_head_lblforclassworkmessage").text("Click here for download the uploaded work report file.");
                $("#divformessage").show().css({ position: 'absolute', top: pos.top + 14 + "px", right: "100px" });
                return false;
            });
            $(document).on("mouseleave", "[id*=GridView1] [id*=lnkbtnfordownload]", function () {
                $("#divformessage").hide();
                return false;
            });

        });

        function ShowpImagePreview(input) {

            var getrsc = "";
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    getrsc = e.target.result;
                    ImageLogoByteCode = getrsc;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function add_daily_work_report() {

            if (fileuploadcontrolid != "") {

                var files = $("#" + fileuploadcontrolid + "").get(0);

                filename = cls + "~" + files.value;
            }
            else {
                filename = "";
            }

            $.ajax({
                url: "daily-work-report.aspx/add_daily_workreport",
                data: "{'classid':'" + classid + "','sectionid':'" + sectionid + "','subjectid':'" + subjectid + "','unitid':'" + unitid + "','unitname':'" + unitname + "','topicid':'" + topicid + "','topicname':'" + topicname + "','description':'" + description + "','pid':'" + pid + "','periodname':'" + periodname + "','filename':'" + filename + "','homework':'" + homework + "','date':'" + date + "','ImageLogoByteCode':'" + ImageLogoByteCode + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (parseInt(data.d) == 1) {
                        alertify.success("Record has been successfully submitted.");
                    }
                    else if (parseInt(data.d) == 2) {
                        alertify.error("Your work report of the " + periodname + " lecture has already been submitted for " + date + ".");
                    }
                    filename = "";
                    ImageLogoByteCode = "";
                },
                error: function () {
                    return false;
                }
            });

        }

        function get_emp_daily_report() {

            $.ajax({
                url: "daily-work-report.aspx/Get_Emp_workreport",
                data: "{'dateforreport':'" + dateforreport + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("[id*=GridView1] tr:gt(1)").remove();

                    if (data.d.length > 0) {
                        $("#ctl00_head_divforreportgrid").css("display", "block");
                        $("#ctl00_head_trformsg").css("display", "none");

                        for (var i = 0; i < data.d.length; i++) {

                            var row = $("[id*=GridView1] tr:eq(1)").clone(true);
                            $("[id$=GridView1]").append(row);
                            $(row).find(".Rownumber").html(data.d[i].Rownumber);
                            $(row).find(".topiclecture").html(data.d[i].topiclecture);
                            $(row).find(".Classname").html(data.d[i].Classname);
                            $(row).find(".sectionname").html(data.d[i].sectionname);
                            $(row).find(".subjectname").html(data.d[i].subjectname);
                            $(row).find(".unitname").html(data.d[i].unitname);
                            $(row).find(".topic").html(data.d[i].topic);
                            $(row).find(".classwork").html(data.d[i].classwork);
                            $(row).find(".homework").html(data.d[i].homework);
                            $(row).find(".file_upload").html(data.d[i].file_upload);

                        }

                    }
                    else {
                        $("#ctl00_head_divforreportgrid").css("display", "none");
                        $("#ctl00_head_trformsg").css("display", "block");

                    }

                    $("[id*=GridView1] tr").show();
                    $("[id*=GridView1] tr:eq(1)").hide();

                },
                error: function () {
                    return false;
                }
            });

        }

        function cv_validation(fileuploadforcv) {
            var fuData = document.getElementById(fileuploadforcv);
            var FileUploadPath = fuData.value;
            if (FileUploadPath != '') {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();
                if (Extension == "doc" || Extension == "docx" || Extension == "pdf" || Extension == "jpg" || Extension == "jpeg" || Extension == "odt") {
                    if (Extension == "doc" || Extension == "docx") {
                        var wordlength = document.getElementById(fileuploadforcv).files.length;
                        if (wordlength > 1) {
                            alertify.error("You can not upload multiple " + Extension + " files. You can only upload only single .doc or .docx file.");
                            return false;
                        }
                    }
                }
                else {
                    alertify.error("You can not upload " + Extension + " file for work report. You can only upload .doc, .docx, .jpg, jpeg, or pdf  file.");
                    return false;
                }

            }
        }
    </script>

    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                     <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Work Report
                    </h1>
                </div>
                <div class="main-content">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 50px !important;" id="tablemaingrid" runat="server">
                        <tr style="width: 100%;">
                            <td style="width: 100%;">
                                <div id="divforworklist" class="clasforworklist">
                                    <div style="padding-top: 7px">
                                        <asp:Label runat="server" Text="SHOW REPORT" Style="top: 10px!important; font-family: Arial; font-size: 17px"></asp:Label>
                                    </div>
                                </div>
                                <div id="divforsubmit" class="classforsubmit">
                                    <div style="padding-top: 7px">
                                        <asp:Label ID="Label1" runat="server" Text="SUBMIT REPORT" Style="top: 10px!important; font-family: Arial; font-size: 17px"></asp:Label>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <tr id="trfortxtdate" runat="server" style="display: none">
                            <td>
                                <div class="for_sigle_row_form" style="margin-left: -13px!important; margin-top: 15px!important">
                                    <asp:TextBox ID="txtdate" runat="server" placeholder="Select Date" ReadOnly="true" Style="width: 120px!important; text-align: left!important;"></asp:TextBox>
                                </div>
                            </td>
                        </tr>

                        <tr id="trmaingridrecord" runat="server" style="display: none">
                            <td colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px; border: none!important">
                                <div style="width: 910px; border: 2px solid #82403B; margin-left: -15px">
                                    <asp:GridView runat="server" ID="gridmain" ShowHeader="true" AutoGenerateColumns="false"
                                        Width="100%" CssClass="stm" Style="margin-left: 0px; border-radius: 10px; height: 430px">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="70px" HeaderText="S.No" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblperiodid" runat="server" Text='<%# Eval("rownumber") %>' CssClass="RowNumber" Style="margin-left: -10px!important"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Lecture" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllecturename" runat="server" Text='<%# Eval("LectureName") %>' CssClass="periodname"></asp:Label>
                                                    <asp:Label ID="lblpid" runat="server" Text='<%# Eval("pid") %>' CssClass="pid" Style="display: none"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Class">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtclass" runat="server" CssClass="class" Placeholder="Class" Style="width: 50px!important; margin-left: -10px; font-size: 13px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                    <asp:Label ID="lblforclassid" runat="server" CssClass="clssid" Style="display: none" Text="0"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Section" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtsection" runat="server" CssClass="section" Placeholder="Section" Style="margin-left: -14px; width: 60px!important; font-size: 13px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                    <asp:Label ID="lblforsectionid" runat="server" Text="0" Style="display: none" CssClass="sectionid"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Subject">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtsubject" runat="server" CssClass="subject" Placeholder="Subject" Style="width: 70px!important; margin-left: -14px; font-size: 13px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                    <asp:Label ID="lblforsubjectid" runat="server" CssClass="subjectid" Style="display: none" Text="0"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Unit">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtunit" runat="server" CssClass="unit" Placeholder="Unit" Style="margin-left: -14px; font-size: 13px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                    <asp:Label ID="lblforunitid" runat="server" CssClass="unitid" Style="display: none" Text="0"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Topic">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txttopic" runat="server" CssClass="topic" Placeholder="Topic" Style="margin-left: -14px; font-size: 13px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                    <asp:Label ID="lblfortopicid" runat="server" Text="0" Style="display: none" CssClass="topicid"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Class Work">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdescription" runat="server" CssClass="description" Placeholder="Class Work" Style="font-size: 13px; width: 100px!important; margin-left: -14px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Home Work">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txthomework" runat="server" CssClass="homework" Placeholder="Home Work" Style="font-size: 13px; width: 100px!important; margin-left: -14px; border: 1px solid #82403B!important; font-family: Verdana,Arial,sans-serif;"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Upload">
                                                <ItemTemplate>
                                                    <asp:FileUpload ID="fileuploadofworksoftcopy" onchange="ShowpImagePreview(this);" runat="server" CssClass="fileupload" Style="margin-left: -15px;" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderStyle-Width="60px" HeaderText="">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnforinsert" runat="server" Style="color: white; border-radius: 6px!important; background-color: #82403B; margin-left: -15px; font-family: Verdana,Arial,sans-serif;" Text="Submit" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                        <RowStyle CssClass="stm_light clseveryrow" />
                                        <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>

                        <%--=============================Grid For Work List ============================================--%>

                        <tr id="trforreportgrid" runat="server" style="display: block; margin-top: 20px">

                            <td colspan="12" style="width: 100%; padding-left: 0px; padding-right: 0px; border: none!important">

                                <div class="for_sigle_row_form" style="margin-left: -13px!important; margin-top: 15px!important">
                                    <asp:TextBox ID="txtdateforreport" runat="server" placeholder="Select Date" ReadOnly="true" Style="width: 120px!important; text-align: left!important;"></asp:TextBox>
                                </div>

                                <div id="divforreportgrid" runat="server" style="width: 910px; border: 2px solid #82403B; margin-left: -15px; display: none">
                                    <asp:GridView runat="server" ID="GridView1" ShowHeader="true" AutoGenerateColumns="false"
                                        Width="100%" CssClass="stm" Style="margin-left: 0px; border-radius: 10px;">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="70px" HeaderText="S.No" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblperiodid" runat="server" Text='<%# Eval("Rownumber") %>' CssClass="Rownumber" Style="margin-left: -10px!important"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="65px" HeaderText="Lecture" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllecturename" runat="server" Text='<%# Eval("topiclecture") %>' Style="margin-left: -10px" CssClass="topiclecture"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="50px" HeaderText="Class" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtclass" runat="server" CssClass="Classname" Text='<%# Eval("Classname") %>' Style="width: 50px!important; margin-left: -10px; font-size: 13px; font-family: Verdana,Arial,sans-serif;"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="65px" HeaderText="Section" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtsection" runat="server" CssClass="sectionname"
                                                        Text='<%# Eval("sectionname") %>' Style="margin-left: 0px; width: 60px!important; font-size: 13px; font-family: Verdana,Arial,sans-serif;"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Subject">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtsubject" runat="server" CssClass="subjectname" Text='<%# Eval("subjectname") %>' Style="width: 70px!important; margin-left: 0px; font-size: 13px; font-family: Verdana,Arial,sans-serif;"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Unit">
                                                <ItemTemplate>
                                                    <asp:Label ID="txtunit" runat="server" CssClass="unitname" Text='<%# Eval("unitname") %>' Style="margin-left: -14px; font-size: 13px; font-family: Verdana,Arial,sans-serif;"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="300px" HeaderText="Topic">
                                                <ItemTemplate>
                                                    <asp:Label ID="txttopic" runat="server" CssClass="topic" Text='<%# Eval("topic") %>' Style="margin-left: -14px; font-size: 13px; font-family: Verdana,Arial,sans-serif;"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Class Work" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnforclasswork" Enabled="false" runat="server" Text="Show" Style="color: #82403B; cursor: pointer; font-size: 13px; width: 100px!important; margin-left: 0px; font-family: Verdana,Arial,sans-serif;"></asp:LinkButton>
                                                    <asp:Label ID="lblforclassworkdetails" runat="server" Text='<%#Eval("classwork") %>' CssClass="classwork" Style="display: none"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="130px" HeaderText="Home Work" HeaderStyle-CssClass="stm_head1">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnforhomework" Enabled="false" runat="server" Text="Show" Style="color: #82403B; cursor: pointer; font-size: 13px; width: 100px!important; margin-left: 0px; font-family: Verdana,Arial,sans-serif;"></asp:LinkButton>
                                                    <asp:Label ID="lblforhomeworkdetails" runat="server" Text='<%#Eval("homework") %>' CssClass="homework" Style="display: none"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Download">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="lnkbtnfordownload" runat="server" ImageUrl="~/images/downloadresume.png" OnClick="lnkbtnfordownload_Click" Style="width: 20px!important; height: 20px; margin-left: 10px;"></asp:ImageButton>
                                                    <asp:Label ID="lblforfordownload" runat="server" Text='<%#Eval("file_upload") %>' CssClass="file_upload" Style="display: none"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                        <RowStyle CssClass="stm_light clseveryrow" />
                                        <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>

                        <tr id="trformsg" runat="server" style="display: none; width: 100%">
                            <td style="width: 100%">
                                <div style="width: 100%; border: 2px solid #82403B; background-color: white; height: 200px; margin: 15px 557px 0px -12px; padding-top: 10px">
                                    <asp:Image ID="imgmsg" runat="server" ImageUrl="~/images/noresultfound1.jpg" Style="margin-left: 20px" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="divformessage" style="text-align: center; display: none; position: relative; width: auto; max-width: 300px">
                    <table class="showpopup2">
                        <tr>
                            <td style="padding: 10px 10px 10px 10px">
                                <asp:Label ID="lblforclassworkmessage" Style="font-family: Verdana,Arial,sans-serif;" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>