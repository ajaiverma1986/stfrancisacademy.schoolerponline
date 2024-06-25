<%@ Page Title="Student Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="getDistID.aspx.cs" Inherits="adminPanel_Default4" %>

<%--<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>--%>
    <link href="../js/1.8-themes-base-jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../js/1.8-jquery-ui.min.js"></script>

    <style type="text/css">
        .cssnew {
            font-size: 16px;
            color: blue;
            font-family: 'Bookman Old Style';
        }

        .active7 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>
    <style>
        .f_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }

        .shadow1 {
            -webkit-box-shadow: 0 0 3px rgba(0,0,0, .35);
            -moz-box-shadow: 0 0 3px rgba(0,0,0, .35);
            box-shadow: 0 0 3px rgba(0,0,0, .35);
        }

        #errmsg {
            color: red;
        }

        #errmsg1 {
            color: red;
        }

        .labelfor_radio {
            margin-bottom: -12px;
            margin-left: 24.4%;
            margin-top: -4%;
        }

            .labelfor_radio label {
                float: left;
                margin: 5px 0 6px;
                min-height: 20px;
                padding-left: 0;
                text-align: left !important;
                width: 68px !important;
            }

        #ctl00_ContentPlaceHolder1_rfineadjust_0 {
            margin-top: 4px;
        }

        #ctl00_ContentPlaceHolder1_rfineadjust_1 {
            margin-top: 4px;
        }
    </style>

    <style>
        .button_save7 {
            background-color: green;
            background-image: linear-gradient(to bottom, #49C0F0 );
            border: 1px solid #2D9FDD;
            border-radius: 3px;
            color: #FFFFFF;
            display: inline-block;
            font-family: arial,helvetica,sans-serif;
            font-size: 12px;
            font-weight: bold;
            height: 33px;
            margin-bottom: 5px;
            margin-right: 5px;
            padding: 5px 13px;
            text-decoration: none;
            text-shadow: 0 -1px rgba(0, 0, 0, 0.3);
        }
    </style>

    <%--<script type="text/javascript">
    $(function () {
        $(document).bind('contextmenu', function (e) {
            e.preventDefault();
            alert('Right Click is not allowed');
        });

    });
  </script>--%>

    <script type="text/javascript">

        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65) && (charCode <= 90) || ((charCode >= 48 && charCode <= 57) || (charCode == 8 || charCode == 127)))
                return false;

        };
        function ValidateAlpha() {
            var keyCode = window.event.keyCode;
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32) {
                window.event.returnValue = false;
                alert("Enter only letters");
            }
            function NumberOnly() {
                var AsciiValue = event.keyCode
                if ((AsciiValue >= 48 && AsciiValue <= 57) || (AsciiValue == 8 || AsciiValue == 127))
                    event.returnValue = true;
                else
                    event.returnValue = false;
            }

        }
    </script>

    <script type="text/javascript">

        function alertTest() {
            var admno = "";
            var monid = "";
            var ftype = "";
            var monthid = "";
            var allmonthid = "";
            $(document).ready(function () {

                $('#ctl00_ContentPlaceHolder1_btnSubmit').click(function () {

                    admno = $("#ctl00_ContentPlaceHolder1_txtMemId").val();

                    //$('#ctl00_ContentPlaceHolder1_divstudentadno').fadeTo('slow', .15);
                    $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                    setTimeout(function () {
                        //$('#ctl00_ContentPlaceHolder1_divstudentadno1').remove();

                        if ((admno.length == 0)) {
                            $("#ctl00_ContentPlaceHolder1_lblmsg").text("please enter student id.");
                            $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                            return false;

                        }
                        if (ftype == "0") {
                            $("#ctl00_ContentPlaceHolder1_lblmsg").text("please Select Fee Type.");
                            return false;
                        }
                        if (admno.length != 0) {
                            $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "getDistID.aspx/getadmission",
                                    data: "{'admno':'" + admno.trim() + "'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d == 0) {
                                            $("#ctl00_ContentPlaceHolder1_lblmsg").text("Invalid Student Rollno !");
                                            $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                            return false;

                                        }
                                        else {

                                            $.ajax(
                                             {
                                                 type: "POST",
                                                 contentType: "application/json; charset=utf-8",
                                                 url: "getDistID.aspx/getregno",
                                                 data: "{'admno':'" + admno.trim() + "'}",
                                                 dataType: "json",
                                                 success: function (data) {
                                                     if (data.d == "0") {
                                                         alert("Error");
                                                         return false;

                                                     }
                                                     else {
                                                         window.location.replace("studentpayfee.aspx?adid=" + parseInt(data.d));
                                                         $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                                         return false;

                                                     }
                                                 }
                                             });
                                            return false;
                                        }

                                        //window.location.replace("feeinfo.aspx?adno=" + admno);
                                        //return false;

                                    }
                                });
                        }

                    }, 1000);
                    return false
                });

                $('#ctl00_ContentPlaceHolder1_btnback').click(function () {
                    $("#ctl00_ContentPlaceHolder1_txtbookid").val('');
                    $("#ctl00_ContentPlaceHolder1_dlmsg").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_divstudentadno").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_divdetls").css("display", "none");
                    $('#t1').css("display", "none");
                    $('#divT2').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_divpay').css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtMemId").val('');
                    $("#ctl00_ContentPlaceHolder1_lbfmsg").text("");
                    //   $("#ctl00_ContentPlaceHolder1_btnback").css("display", "none");
                    return false;

                });

                $('#ctl00_ContentPlaceHolder1_btnCancel').click(function () {

                    $("#ctl00_ContentPlaceHolder1_dlmsg").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_divstudentadno").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_divdetls").css("display", "none");
                    $('#t1').css("display", "none");
                    $('#ctl00_ContentPlaceHolder1_divpay').css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtMemId").val('');
                    $("#ctl00_ContentPlaceHolder1_lbfmsg").text("");
                    $("#ctl00_ContentPlaceHolder1_txtbookid").val('');
                    $('#divT2').css("display", "none");
                    //  $("#ctl00_ContentPlaceHolder1_btnback").css("display", "none");
                    return false;

                });

                //rizwan

                $("#ctl00_ContentPlaceHolder1_btnserach").click(function () {

                    $("#ctl00_ContentPlaceHolder1_divsearchtp").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_txtsearchname").val('');
                    $("#ctl00_ContentPlaceHolder1_txtclass").val('');
                    $("#ctl00_ContentPlaceHolder1_divstudentadno").css("display", "none");
                    return false;

                });

                $("#ctl00_ContentPlaceHolder1_btngosearch").click(function () {
                    // var searvalue = $("#ctl00_ContentPlaceHolder1_txtsearchname").val();
                    var searvalue = $("#ctl00_ContentPlaceHolder1_hfrid").val();
                    var classname = $("#ctl00_ContentPlaceHolder1_txtclass").val();
                    if (searvalue == "" && classname == "") {
                        alert("Please enter atleast one search critarea.");
                        return false;
                    }
                    else {
                        $.ajax(
                              {
                                  type: "POST",
                                  contentType: "application/json; charset=utf-8",
                                  url: "getDistID.aspx/BindDataList",
                                  data: "{'searchvalue':'" + searvalue + "','classid':'" + classname + "'}",
                                  dataType: "json",
                                  success: function (data) {
                                      if (data.d.length == 0) {
                                          $("#ctl00_ContentPlaceHolder1_dlmsg").text("No Record Found.!");
                                          $("#ctl00_ContentPlaceHolder1_dlist").css("display", "none");
                                          $("#ctl00_ContentPlaceHolder1_dlmsg").css("display", "block");
                                          $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                          return false;
                                      }
                                      $("[id*=DataList2] tr").not($("[id*=DataList2] tr:first-child")).remove();
                                      for (var i = 0; i < data.d.length; i++) {
                                          var row = $("[id*=DataList2] tr:last-child").clone(true);
                                          $("[id$=DataList2]").append(row);
                                          $(row).find(".imgphoto").attr("src", data.d[i].image);
                                          $(row).find(".stuname").html(data.d[i].name);
                                          $(row).find(".apclass").html(data.d[i].applyclass);
                                          $(row).find(".fname").html(data.d[i].Fname);
                                          $(row).find(".admo").html(data.d[i].adno);
                                          $(row).find(".admo1").html(data.d[i].adid);
                                      }
                                      $("[id*=DataList2] tr").show();
                                      $("[id*=DataList2] tr:first-child").hide();
                                      $("#ctl00_ContentPlaceHolder1_dlist").css("display", "block");
                                      $("#ctl00_ContentPlaceHolder1_dlmsg").css("display", "none");
                                  },
                                  error: function (result) {
                                      alert("Sorry");
                                  }
                              });
                        return false;
                    }
                    return false;

                });

                $("#ctl00_ContentPlaceHolder1_btbacksrch").click(function () {

                    $("#ctl00_ContentPlaceHolder1_divsearchtp").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_divstudentadno").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_dlist").css("display", "none");
                    return false;
                });

                //------

            });
        }
    </script>

    <script type="text/javascript">
        var brid = 0;
        function pageLoad() {
            brid = '<%= Session["BrBrid"] %>'

            $("#<%=txtclass.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/searchclass") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {

                    $("#<%=HiddenField1.ClientID %>").val(i.item.val);

                },
                minLength: 1

            });

                $("#<%=txtsearchname.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/getstudentdashboard") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                    select: function (e, i) {
                        $("#<%=hfrid.ClientID %>").val(i.item.val);

                         },
                         minLength: 1
                });

                         $("#<%=txtMemId.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/TimeTable.asmx/admissionsearch") %>',
                        data: "{ 'prefix': '" + request.term + "','brid':'" + brid + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.length > 0) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('-')[0],
                                        val: item.split('-')[1],
                                        val1: item.split('-')[2]

                                    };
                                }))
                            }
                            else {
                                response([{ label: 'No results found.', val: -1 }]);
                            }

                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {

                },
                minLength: 1
            });

        };
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('.stuname').click(function () {
                var id;
                id = $(this).closest("td").find("[id*=lblbt2]").text();

                window.location.replace("studentpayfee.aspx?adid=" + id);
                return false;
            });

        });
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

    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 100px;
            height: 750px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }

        .for_sigle_row_form {
            margin-bottom: 0;
            margin-left: -6%;
            margin-right: auto;
            padding: 5px 0;
            width: 56%;
        }

        /*.for_sigle_row_form1 {
            margin-bottom: 0;
            margin-left: 13%;
            margin-right: auto;
            padding: 5px 0;
            width: 100%;
        }*/

        .chkItem {
            margin-left: 2px;
            margin-top: -26px;
            width: 18px;
        }

        .lblItem {
            width: 25px;
            margin-left: 20px;
        }
    </style>

    <script type="text/javascript" lang="javascript">
        Sys.Application.add_load(alertTest);
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Management</a></li>
            <li style="background: none;"><a class="active">
                <asp:Label ID="lblHeading" runat="server"></asp:Label></a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline stripheading">
            <asp:Label ID="tblheading" runat="server" Text="Collect Fee Here"></asp:Label>
        </div>
        <div class="for_sigle_row_form" style="min-height: 10px;">
        </div>

        <div id="divstudentadno1" runat="server">
        </div>
        <div id="divstudentadno" runat="server">

            <div class="for_sigle_row_form">
                <label>
                    Enter Student ID<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtMemId" onkeypress="return noAlphabets(event)" runat="server"></asp:TextBox>
            </div>
            <div class="for_sigle_row_form" id="divname" runat="server" style="width: 548px; float: right; margin-top: -45px;">
                <asp:Button ID="btnserach" runat="server" CssClass="button_save" Text="Advance Search" />
            </div>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="button_save" />&nbsp;&nbsp;
            <asp:Button runat="server" ID="btnback" Text="Back" CssClass="button_cancel" />
            </div>
        </div>
        <div id="divsearchtp" runat="server" style="display: none;">

            <div class="for_sigle_row_form">
                <label id="lbnme">
                    Name<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtsearchname" onkeypress="return lettersOnly(event)" runat="server"></asp:TextBox>
                <asp:HiddenField ID="hfrid" runat="server" />
            </div>

            <div class="for_sigle_row_form">
                <label>
                    Class<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtclass" runat="server"></asp:TextBox>
                <asp:HiddenField ID="HiddenField1" runat="server" />
            </div>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Button ID="btngosearch" runat="server" CssClass="button_save" Text="Search" />
                <asp:Button ID="btbacksrch" runat="server" CssClass="button_cancel" Text="Back" />
            </div>
            <asp:Label ID="dlmsg" runat="server" Style="display: none;" ForeColor="Red"></asp:Label>
        </div>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red"></asp:Label>
            <asp:HiddenField ID="hd2" runat="server" />
        </div>
    </div>

    <div class="clear">
    </div>

    <div style="margin-right: 6%; display: none;" id="dlist" runat="server">

        <div style="background-color: #40D5D6; padding: 8px; margin: 0 auto -46px; width: 65%; border-top-left-radius: 6px; border-top-right-radius: 6px;">

            <span style="color: black; font-size: 16px;">Student Details </span>
        </div>
        <div style="border: 1px solid #ddd; width: 66.5%; height: 379px; margin: 4.5% auto; background: #FCFCFC; overflow: scroll; overflow-x: hidden;">

            <%-- <asp:Panel ID="Panel1" runat="server">--%>

            <asp:DataList ID="DataList2" runat="server" RepeatColumns="1" RepeatDirection="Horizontal">
                <ItemTemplate>
                    <div class="carda" style="padding: 8px; width: 137%;">
                        <br>
                        <div style="float: left; margin-left: 8%;">
                            <div class="student_img" style="width: 85px; margin: 0px auto; margin-bottom: 5px; padding: 2px; border: 1px solid #ccc;">
                                <%-- <asp:HyperLink ID="HyperLink1" runat="server"  NavigateUrl='<%#Eval("id","bookinformation.aspx?id={0}")  %>' >--%>
                                <asp:Image runat="server" ID="imgsource" Width="85" Height="90" ImageUrl='<%# Eval("photo") %>' CssClass="imgphoto" />
                                <%--</asp:HyperLink>--%>
                                <br />
                            </div>
                        </div>

                        <div style="float: left;">
                            <div class="id_student " style="text-align: left; padding-left: 20%; padding-top: 6%; line-height: 21px;">
                                <b>Name : </b>
                                <%-- <asp:LinkButton ID="Label1" runat="server" Text='<%# Eval("title") %>'></asp:LinkButton>--%>
                                <asp:LinkButton ID="linkscatname" Text='<%# Eval("name") %>' runat="server" CssClass="stuname"></asp:LinkButton>
                                <asp:Label ID="lblbt2" runat="server" Text='<%# Bind("adid") %>' CssClass="admo1" Style="display: none;"></asp:Label>
                                <br />
                                <b>Class :</b>
                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("applyclass") %>' CssClass="apclass"></asp:Label>
                                <br />
                                <b>Father Name :</b>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("FatherName") %>' CssClass="fname"></asp:Label>
                                <br />
                                <b>Admission No. :</b>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("ADNO") %>' CssClass="admo"></asp:Label>
                                <br />

                                <div style="display: none">
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <%--  </asp:Panel>--%>
        </div>
    </div>

    <div class="clear">
    </div>
    <asp:Label ID="lbfmsg" runat="server" Style="display: none;" Font-Bold="true" ForeColor="Red"></asp:Label>
</asp:Content>