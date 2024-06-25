<%@ Page Title="Admission Form" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="admissionform.aspx.cs" Inherits="BranchPanel_admissionform" EnableEventValidation="false" %>
<%@ OutputCache Duration='520'
                VaryByParam='none' %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<script src="../js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>--%>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
      <style type="text/css">
          #hb-gotop {
              -moz-border-radius: 0px;
              -webkit-border-radius: 0px;
              border-radius: 0px;
              filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#99EEEEEE',EndColorStr='#99EEEEEE');
              text-align: center;
              padding: 5px;
              position: fixed;
              bottom: 32px;
              right: 13px;
              cursor: pointer;
              color: #444;
              text-decoration: none;
              border: 0px solid #C9C9C9;
          }

          .student-photo_frame_img1 {
              border: 1px solid #ccc;
              float: left;
              height: 70px;
              margin: 10px;
              padding: 3px;
              width: 270px;
          }
      </style>

<script type='text/javascript'>
    $(function () {
        $.fn.scrollToTop = function () {
            $(this).hide().removeAttr("href");
            if ($(window).scrollTop() != "0") {
                $(this).fadeIn("slow")
            }
            var scrollDiv = $(this);
            $(window).scroll(function () {
                if ($(window).scrollTop() == "0") {
                    $(scrollDiv).fadeOut("slow")

                } else {
                    $(scrollDiv).fadeIn("slow")
                }
            });
            $(this).click(function () {
                $("html, body").animate({
                    scrollTop: 0
                }, "slow")
            })
        }
    });
    $(function () {
        $("#hb-gotop").scrollToTop();
    });
</script>

    <link href="../css/admissionform.css" rel="stylesheet" />

    <style type="text/css">
        #dvPreview {
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
            min-height: 183px;
            /*min-width: 400px;*/
            display: block;
        }

        #dvPreview1 {
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
            /*min-height: 400px;*/
            /*min-width: 400px;*/
            display: block;
        }
    </style>

    <style type="text/css">
        .form-box-heading {
            position: absolute;
            left: 30px;
            height: 30px;
            top: -15px;
            z-index: 99999999999999;
            background: #191E21;
            color: #fff;
            line-height: 30px;
            font: bold;
            font-size: 15px;
            padding: 0px 15px 0px 15px;
            -moz-border-radius: 1em 4em 1em 4em;
            border-radius: 1em 4em 1em 4em;
        }

        .form-box-heading1 {
            position: relative;
            left: 20px;
            height: auto;
            top: -16px;
            z-index: 99999999999999;
            background: #1C94C6;
            color: #fff;
            line-height: 30px;
            font: bold;
            font-size: 15px;
            padding: 0px 15px 0px 15px;
            -moz-border-radius: 1em 4em 1em 4em;
            border-radius: 1em 4em 1em 4em;
            margin-top: 30px;
        }

        #ctl00_ContentPlaceHolder1_rbgender_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_rbgender_1 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList1_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList1_1 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList4_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList4_1 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList2_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList2_1 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList3_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_RadioButtonList3_1 {
            margin-top: -4px;
        }

        .labelfor_radio label {
            margin: -13px 0 6px;
        }

        .labelfor_radio {
            margin-top: 12px;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 324px;
        }

        .for_sigle_row_form input[type="text"], input[type="select"], input[type="Password"] {
            width: 311px;
        }

        .fname {
            width: 47px !important;
        }

        .fname1 {
            width: 100px !important;
        }

        .sname {
            width: 91px !important;
        }

        .stm_head th {
            border: 1px solid #DDDDDD;
            /*color: #fff !important;*/
            font-size: 12px;
        }

        .stm td {
            border: 1px solid #DDDDDD;
            color: #333333;
            line-height: 27px;
            padding: 7px;
            /*padding-left: 10px;
            padding-right: 5px;*/
        }

        .stm_head th {
            border-top: 1px solid #DDDDDD;
            color: #3A3A3A !important;
            font-size: 13px;
            padding-left: 8px;
            padding-right: 14px;
            text-align: left;
        }

        .labelfor_radio td {
            width: 75px;
            border: none!important;
        }

        .mainbg {
            background-color: rgb(252, 253, 254);
        }

        #ctl00_ContentPlaceHolder1_rtransportation_0 {
            margin-top: -4px;
        }

        #ctl00_ContentPlaceHolder1_rtransportation_1 {
            margin-top: -4px;
        }

        /*#ctl00_ContentPlaceHolder1_chkenglish {

             margin-top: -4px;
        }*/

        #uniform-ctl00_ContentPlaceHolder1_chkenglish {
            margin-bottom: -15px;
            width: 13px;
        }

        #uniform-ctl00_ContentPlaceHolder1_chkhindi {
            margin-bottom: -15px;
            width: 13px;
        }

        #uniform-ctl00_ContentPlaceHolder1_CheckBox1 {
            margin-bottom: -15px;
            width: 13px;
        }
    </style>
    <%--<script type="text/javascript">
        $(function () {
            var d = new Date();
            var y = d.getFullYear();
            //  var date = $('#datepicker').datepicker({ dateFormat: 'dd-mm-yy' }).val();
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
                $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '1970:' + y,

                });
            });

        });
    </script>--%>

    <%--<script type="text/javascript">
        $(function () {
            $(document).bind('contextmenu', function (e) {
                e.preventDefault();
                alert('Right Click is not allowed');
            });

        });
  </script>--%>

    <style>
        .frmde {
            color: #676767;
            font-size: 13px;
            font-weight: bold;
            padding: 5px 12px 5px 5px;
            width: 50px;
        }

        .frmdelabel {
            color: #676767;
            font-size: 13px;
            padding: 5px;
            width: 50px;
        }

        .shadow1 {
            -webkit-box-shadow: 0 0 3px rgba(0,0,0, .35);
            -moz-box-shadow: 0 0 3px rgba(0,0,0, .35);
            box-shadow: 0 0 3px rgba(0,0,0, .35);
        }
    </style>

      <%--<script type="text/javascript">

          function toggle5(showHideDiv, switchImgTag) {
              var ele = document.getElementById(showHideDiv);
              var imageEle = document.getElementById(switchImgTag);

              if (ele.style.display == "block") {
                  ele.style.display = "none";

                  imageEle.innerHTML = '<img src="../images/addd11.png"  style="padding: 13px;position: absolute;" />';

              }
              else {
                  ele.style.display = "block";
                  imageEle.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
              }
          }
    </script>--%>

    <%-----------------Validation with submit--%>

    <script type="text/javascript">
        $(document).ready(function () {

            var text_max = 500;
            var text_max1 = 500;
            $('#textarea_feedback').css("color", "red");
            $('#textarea_feedback1').css("color", "red");
            $('#textarea_feedback').html(text_max + ' characters remaining');
            $('#textarea_feedback1').html(text_max + ' characters remaining');

            $('#ctl00_ContentPlaceHolder1_txtemergencyaddress1').keyup(function () {
                var text_length = $('#ctl00_ContentPlaceHolder1_txtemergencyaddress1').val().length;
                var text_remaining = text_max - text_length;

                $('#textarea_feedback').html(text_remaining + ' characters remaining');
            });

            $('#ctl00_ContentPlaceHolder1_txtemergencyaddress2').keyup(function () {
                var text_length = $('#ctl00_ContentPlaceHolder1_txtemergencyaddress2').val().length;
                var text_remaining = text_max - text_length;

                $('#textarea_feedback1').html(text_remaining + ' characters remaining');
            });

            $("#imageDivLink").click(function () {

                if ($("#contentDivImg").css('display') == "block") {
                    $("#imageDivLink").removeAttr('img');

                    $("#imageDivLink").append('<img src="../images/addd11.png"  style="padding: 13px;position: absolute;" />');
                }
                else {
                    $("#imageDivLink").append('<img src="../images/Green_Minus.gif"  style="padding: 13px;position: absolute;" />');
                }
                $('#contentDivImg').slideToggle(1500, 'linear', function () {

                });

            });

            $("#A3").click(function () {

                if ($("#cont123").css('display') == "none") {
                    $("#A3").removeAttr('img');
                    $("#A3").append('<img src="../images/Green_Minus.gif"  style="padding: 13px;position: absolute;" />');

                }
                else {
                    $("#A3").append('<img src="../images/addd11.png"  style="padding: 13px;position: absolute;" />');

                }
                // $('#cont123').animate({ width: 'toggle' }, "slow")
                $("#cont123").slideToggle(1500, 'linear', function () {

                });
            });

            $("#A2").click(function () {

                if ($("#contentDivImgA2").css('display') == "none") {
                    $("#A2").removeAttr('img');
                    $("#A2").append('<img src="../images/Green_Minus.gif"  style="padding: 13px;position: absolute;" />');

                }
                else {
                    $("#A2").append('<img src="../images/addd11.png"  style="padding: 13px;position: absolute;" />');

                }
                $("#contentDivImgA2").slideToggle(1500, 'linear', function () {

                });
            });

            $("#A1").click(function () {

                if ($("#contentDivImgA1").css('display') == "none") {
                    $("#A1").removeAttr('img');
                    $("#A1").append('<img src="../images/Green_Minus.gif"  style="padding: 13px;position: absolute;" />');

                }
                else {
                    $("#A1").append('<img src="../images/addd11.png"  style="padding: 13px;position: absolute;" />');

                }
                $("#contentDivImgA1").slideToggle(1500, 'linear', function () {

                });
            });

            $("#ctl00_ContentPlaceHolder1_Button1").click(function () {
                var status = validation();

                if (status == 0)

                    return false;
                else {

                    $("#f1").css("display", "none");
                    $("#preview").css("display", "none");
                    $("#fee").css("display", "block");

                    //  var ar = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();

                    return false;

                }
            });

            $("#ctl00_ContentPlaceHolder1_Button6").click(function () {
                var status = validation();

                if (status == 0)

                    return false;
                else {

                    var month = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                    var dte = $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text();

                    $("#ctl00_ContentPlaceHolder1_hdate").val(dte);
                    var year = $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text();

                    var admdate = year + "-" + month + "-" + dte;
                    var classid = "", classname = "";

                    classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlstclass").value;
                    classname = $("#ctl00_ContentPlaceHolder1_ddlstclass option:selected").text();

                    var tansptype = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();

                    var sfname = $("#ctl00_ContentPlaceHolder1_txtName").val();

                    var smname = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
                    var slname = $("#ctl00_ContentPlaceHolder1_txtLName").val();

                    var sgender = $("#ctl00_ContentPlaceHolder1_rbgender :checked").val();
                    var snationality = $("#ctl00_ContentPlaceHolder1_txtFname").val();
                    var sdob = $("#ctl00_ContentPlaceHolder1_txtToDate").val();

                    var sheight = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                    var sweight = $("#ctl00_ContentPlaceHolder1_TextBox2").val();

                    var houseno = $("#ctl00_ContentPlaceHolder1_txthouseno").val();
                    var appartment = $("#ctl00_ContentPlaceHolder1_txtappartment").val();
                    var street = $("#ctl00_ContentPlaceHolder1_txtstreet").val();
                    var land = $("#ctl00_ContentPlaceHolder1_txtland").val();
                    var pincode = $("#ctl00_ContentPlaceHolder1_txtPZIP").val();

                    var lang = "";

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked") {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('English');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('Hindi');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked")) {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('English,Hindi');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text($("#ctl00_ContentPlaceHolder1_txtlan").val());
                        $("#ctl00_ContentPlaceHolder1_lblangid").val($("#ctl00_ContentPlaceHolder1_txtlan").val());
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked")) {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi, ' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('English,Hindi, ' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('English,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked")) {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('Hindi,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") != "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                        lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('');
                    }

                }
            });

            //--------------------------------Image Upload Here

            $("#ctl00_ContentPlaceHolder1_fileupload").change(function () {

                // alert(($("#ctl00_ContentPlaceHolder1_fileupload")[0].files[0].height));

                var iSize = ($("#ctl00_ContentPlaceHolder1_fileupload")[0].files[0].size / 1024);
                //var screenImage = $("#dvPreview1");

                //// Create new offscreen image to test
                //var theImage = new Image();
                //theImage.src = screenImage.attr("src");

                //// Get accurate measurements from that.
                //var imageWidth = theImage.width;

                //alert($(this).attr('height', $(this).height()));
                //alert(("#ctl00_ContentPlaceHolder1_fileupload").height());
                if (iSize / 1024 > 1) {
                    if (((iSize / 1024) / 1024) > 1) {
                        iSize = (Math.round(((iSize / 1024) / 1024) * 100) / 100);
                        alert("image size" + iSize + "Gb");
                        //$("#lblSize").html(iSize + "Gb");
                    }
                    else {
                        iSize = (Math.round((iSize / 1024) * 100) / 100)
                        //$("#lblSize").html(iSize + "Mb");
                        alert("image size" + iSize + "Mb");
                    }
                }
                else {
                    iSize = (Math.round(iSize * 100) / 100)
                    alert("image size" + iSize + "kb");
                    //$("#lblSize").html( iSize  + "kb");
                }

                $("#dvPreview1").html("");
                $("#dvPreview").html("");

                $("#dvp1").removeAttr("style");
                //$("#dvp").removeAttr("style");

                $("#dvPreview1").css("border", "3px solid rgb(123, 127, 135)").css("width", "183px").css("height", "103px").css("float", "right").css("margin-right", "2%");

                // $("#dvPreview").css("border", "31px solid #ccc").css("width", "70px").css("height", "70px").css("float", "right").css("margin", "10px");
                var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                if (regex.test($(this).val().toLowerCase())) {
                    if ($.browser.msie && parseFloat(jQuery.browser.version) <= 9.0) {

                        $("#dvPreview1").show();
                        $("#dvPreview").show();

                        $("#dvPreview1")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();

                        $("#dvPreview")[0].filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = $(this).val();
                        //alert($(this).naturalHeight());

                    }
                    else {
                        if (typeof (FileReader) != "undefined") {

                            $("#dvPreview1").show();
                            $("#dvPreview").show();

                            $("#dvPreview1").append("<img />");
                            $("#dvPreview").append("<img />");
                            var reader = new FileReader();
                            reader.onload = function (e) {

                                $("#dvPreview1 img").attr("src", e.target.result);
                                $("#dvPreview img").attr("src", e.target.result);
                            }
                            reader.readAsDataURL($(this)[0].files[0]);
                        } else {
                            alert("This browser does not support FileReader.");
                            $("#ctl00_ContentPlaceHolder1_fileupload").val('');
                        }
                    }
                } else {
                    alert("Please upload a valid image file.");
                    $("#ctl00_ContentPlaceHolder1_fileupload").val('');
                }
            });

            //-----------Check class is checked or not and show fee structure with discount

            $("#ctl00_ContentPlaceHolder1_ddlstclass").change(function () {
                $("#ctl00_ContentPlaceHolder1_ddlstclass").css("border", "1px solid #cccccc");
                $("#ctl00_ContentPlaceHolder1_ddlstclass").css("border", "1px solid #cccccc");
                var classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlstclass").value;

                var ar = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                if (classid == "--Select Class--") {
                    alert("Please Select Admission Sought");
                    return;
                }

                // alert($(this).closest('tr').find('td:eq(1) span:last-child').text());
                //  -----------bind discount gridview here

                $.ajax({
                    type: "POST",
                    url: "admissionform.aspx/BindDatatable",
                    data: "{'classid':'" + classid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var srno = 1;
                        $("[id*=grdDetails] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=grdDetails] tr:eq(1)").clone(true);
                            var hdval = data.d[i].cfid;
                            var hdid = "";
                            if (srno < 10) {
                                hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl0" + srno + "_HD1";
                            }
                            else {
                                hdid = "ctl00_ContentPlaceHolder1_grdDetails_ctl" + srno + "_HD1";
                            }

                            $("[id$=grdDetails]").append(row);

                            $(row).find(".clslblSrNo").html(srno);
                            $(row).find(".clslblfeename").html(data.d[i].feename);
                            if (data.d[i].feename == "Registration Fee" || data.d[i].feename == "Annual Charges" || data.d[i].feename == "Students Kit") {
                                $(row).find(".chekc").css("display", "none");
                            }
                            $(row).find(".clslblfeename").html(data.d[i].feename);
                            $(row).find(".clslblfeenamefeeid").html(data.d[i].cfid);
                            $(row).find("td:eq(1) input").attr("id", hdid);
                            $(row).find("td:eq(1) input").val(hdval);
                            $(row).find(".clslblfeeamount").html(parseFloat(data.d[i].fees).toFixed(2));
                            srno = parseInt(srno) + 1;
                        }
                        $("[id*=grdDetails] tr").show();
                        $("[id*=grdDetails] tr:eq(1)").hide();
                        $("#ctl00_ContentPlaceHolder1_grdDetails").css("display", "block");
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                $.ajax({
                    type: "POST",
                    url: "admissionform.aspx/Bindfeestructure",
                    data: "{'classid':'" + classid + "','trantype':'" + ar + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var srno = 1;
                        //$("[id*=grdclass] tr:gt(1)").remove();
                        $("[id*=grdclass] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=grdclass] tr:eq(1)").clone(true);

                            $("[id$=grdclass]").append(row);

                            $(row).find(".clslblSrNo1").html(srno);

                            $(row).find(".clslblmonth1").html(data.d[i].month);
                            $(row).find(".clslblfeename1").html(data.d[i].feename);
                            $(row).find(".clslblfee1").html(parseFloat(data.d[i].fees).toFixed(2));
                            srno = parseInt(srno) + 1;
                        }
                        $("[id*=grdclass] tr").show();
                        $("[id*=grdclass] tr:eq(1)").hide();

                        $("#ctl00_ContentPlaceHolder1_grdclass").css("display", "block");

                        //$("#ctl00_ContentPlaceHolder1_Table1").css("display", "none");

                    },
                    error: function (result) {
                        alert("Error");
                    }
                });

                // ---------------Bind Pay gridview here
                $.ajax({
                    type: "POST",
                    url: "admissionform.aspx/bindpay",
                    data: "{'classid':'" + classid + "','trantype':'" + ar + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (data) {

                        $("[id*=grd1] tr:gt(1)").remove();
                        var hdid = "";
                        var srno = 1;
                        for (var i = 0; i < data.d.length; i++) {
                            var row = $("[id*=grd1] tr:eq(1)").clone(true);

                            $("[id$=grd1]").append(row);
                            $(row).find(".clsmonthname2").html(data.d[i].month);
                            $(row).find(".clsmonthid2").html(data.d[i].monthid);

                            if (srno < 10) {
                                hdid = "ctl00_ContentPlaceHolder1_grd1_ctl0" + srno + "_chkclass1";
                            }
                            else {
                                hdid = "ctl00_ContentPlaceHolder1_grd1_ctl" + srno + "_chkclass1";
                            }
                            //alert(hdid);
                            $(row).find("td:eq(0) input").attr("id", hdid);

                            if (srno > 1) {

                                //$(row).find("#"+hdid+"").prop('disabled', true);
                            }

                            // $(row).find("td:eq(1) input").attr("id", hdid);

                            $(row).find(".clspay2").html(parseFloat(data.d[i].fees).toFixed(2));
                            srno = parseInt(srno) + 1;
                        }
                        $("[id*=grd1] tr").show();
                        $("[id*=grd1] tr:eq(1)").hide();

                        $('#ctl00_ContentPlaceHolder1_grd1').css("display", "block");

                    },
                    error: function (result) {

                        alert("Error");
                    }
                });

            });

            //---------if yes textbox show

            $('[id*=RadioButtonList1] input').unbind().click(function (e) {
                var rad = $('[id*=RadioButtonList1]').find('input:checked').val();
                if (rad == "1") {
                    $("#divprevious").css("display", "block");

                }
                else {
                    $("#divprevious").css("display", "none");
                }
            });

            // --------(Is the child presently on any regular medication) If yes then textbox show

            $('[id*=RadioButtonList2] input').unbind().click(function (e) {
                var rad1 = $('[id*=RadioButtonList2]').find('input:checked').val();
                if (rad1 == "1") {
                    $("#divspecify").css("display", "block");

                }
                else {
                    $("#divspecify").css("display", "none");
                }
            });

            //--------If Other language then show text box

            $("#ctl00_ContentPlaceHolder1_CheckBox1").change(function () {
                if ($(this).is(":checked")) {
                    $("#divlang").css("display", "block");
                }
                else {

                    $("#divlang").css("display", "none");
                }
            });

            //----------------(Does your child suffer from any phobias)If yes then textbox show

            $('[id*=RadioButtonList3] input').unbind().click(function (e) {
                var rad1 = $('[id*=RadioButtonList3]').find('input:checked').val();
                if (rad1 == "1") {
                    $("#divsuffer").css("display", "block");

                }
                else {
                    $("#divsuffer").css("display", "none");
                }
            });

            //-------------bind days with respective month
            $("#ctl00_ContentPlaceHolder1_ddlMonth").change(function () {

                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {

                    var mid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;

                    if (mid != "--Month--") {
                        $("#ctl00_ContentPlaceHolder1_ddlMonth").css("border", "1px solid #cccccc");
                        $("#ctl00_ContentPlaceHolder1_ddlDate").prop('disabled', false);

                        $.ajax({
                            type: "POST",
                            url: "admissionshort.aspx/monthdetails",
                            data: "{'mid':'" + mid + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {

                                for (var i = 1; i <= data.d; i++) {

                                    $("#ctl00_ContentPlaceHolder1_ddlDate").append($("<option />").text(i));
                                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                                }

                            }

                        });

                    }
                }, 200);

                return false;
            });

        });
    </script>

    <%--------To preview form details--%>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_Button2").click(function () {
                var status = validation();

                if (status == 0) {

                    return false;
                }
                else {
                    $("#preview").css("display", "block");
                    $("#f1").css("display", "none");
                    $("#fee").css("display", "none");

                    var month = $("#ctl00_ContentPlaceHolder1_ddlMonth option:selected").text();
                    var dte = $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text();
                    var year = $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text();
                    var admdate = dte + "-" + month + "-" + year;
                    $("#ctl00_ContentPlaceHolder1_lbladmissiondate").text(admdate);

                    var admission = $("#ctl00_ContentPlaceHolder1_ddlstclass option:selected").text()
                    $("#ctl00_ContentPlaceHolder1_lblsought").text(admission);
                    var admission = $("#ctl00_ContentPlaceHolder1_ddlssection option:selected").text()
                    $("#ctl00_ContentPlaceHolder1_lblsection1").text(admission);

                    $("#ctl00_ContentPlaceHolder1_lblappname1").text($("#ctl00_ContentPlaceHolder1_txtName").val() + " " + $("#ctl00_ContentPlaceHolder1_txtmidname").val() + " " + $("#ctl00_ContentPlaceHolder1_txtLName").val());

                    if ($("#ctl00_ContentPlaceHolder1_rbgender :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Mail');

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblgnder1").text('Femail');
                    }

                    $("#ctl00_ContentPlaceHolder1_lblnation").text($("#ctl00_ContentPlaceHolder1_txtFname").val());
                    $("#ctl00_ContentPlaceHolder1_lbldob1").text($("#ctl00_ContentPlaceHolder1_txtToDate").val());

                    $("#ctl00_ContentPlaceHolder1_lblheight").text($("#ctl00_ContentPlaceHolder1_TextBox1").val());
                    $("#ctl00_ContentPlaceHolder1_lblweight").text($("#ctl00_ContentPlaceHolder1_TextBox2").val());
                    $("#ctl00_ContentPlaceHolder1_lblhouseno").text($("#ctl00_ContentPlaceHolder1_txthouseno").val());
                    $("#ctl00_ContentPlaceHolder1_lblappt").text($("#ctl00_ContentPlaceHolder1_txtappartment").val());
                    $("#ctl00_ContentPlaceHolder1_lblstreet").text($("#ctl00_ContentPlaceHolder1_txtstreet").val());

                    $("#ctl00_ContentPlaceHolder1_lblland").text($("#ctl00_ContentPlaceHolder1_txtland").val());

                    $("#ctl00_ContentPlaceHolder1_lblpin").text($("#ctl00_ContentPlaceHolder1_txtPZIP").val());

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked") {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('English');

                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('Hindi');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked")) {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi');
                        $("#ctl00_ContentPlaceHolder1_lblangid").val('English,Hindi');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text($("#ctl00_ContentPlaceHolder1_txtlan").val());
                        $("#ctl00_ContentPlaceHolder1_lblangid").val($("#ctl00_ContentPlaceHolder1_txtlan").val());

                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked")) {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi, ' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('English,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked")) {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") != "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                        $("#ctl00_ContentPlaceHolder1_lbllang").text('');
                    }

                    //  $("#ctl00_ContentPlaceHolder1_lbllang").text($("#ctl00_ContentPlaceHolder1_chkenglish").closest('span').html());

                    if ($("#ctl00_ContentPlaceHolder1_rtransportation :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lbltrans").text('Yes');

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lbltrans").text('No');
                    }
                    $("#ctl00_ContentPlaceHolder1_lblfather1").text($("#ctl00_ContentPlaceHolder1_txtfather").val());

                    if ($("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1 option:selected").text() == "--Select one--") {
                        $("#ctl00_ContentPlaceHolder1_lblfqualification").text('');
                    }
                    if ($("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1 option:selected").text() == "other") {
                        $("#ctl00_ContentPlaceHolder1_lblfqualification").text($("#ctl00_ContentPlaceHolder1_txtqualification").val());
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblfqualification").text($("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1 option:selected").text());
                    }

                    $("#ctl00_ContentPlaceHolder1_lbloccupation").text($("#ctl00_ContentPlaceHolder1_txtprofession").val());

                    $("#ctl00_ContentPlaceHolder1_lbloragF").text($("#ctl00_ContentPlaceHolder1_TextBox3").val());
                    // $("#ctl00_ContentPlaceHolder1_lbloragF").text($("#ctl00_ContentPlaceHolder1_txtpcode").val() + " " + $("#ctl00_ContentPlaceHolder1_txtphoneno").val());
                    $("#ctl00_ContentPlaceHolder1_lblFresO").text($("#ctl00_ContentPlaceHolder1_txtphoneno").val());
                    $("#ctl00_ContentPlaceHolder1_lblFrespR").text($("#ctl00_ContentPlaceHolder1_TextBox4").val() + " " + $("#ctl00_ContentPlaceHolder1_TextBox5").val());
                    $("#ctl00_ContentPlaceHolder1_lblfathermobile").text($("#ctl00_ContentPlaceHolder1_TextBox6").val());
                    $("#ctl00_ContentPlaceHolder1_lblemaiF").text($("#ctl00_ContentPlaceHolder1_txtemail").val());

                    $("#ctl00_ContentPlaceHolder1_lblmother1").text($("#ctl00_ContentPlaceHolder1_txtfather").val());

                    if ($("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1 option:selected").text() == "--Select one--") {
                        $("#ctl00_ContentPlaceHolder1_lblmqual").text('');
                    }
                    if ($("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1 option:selected").text() == "other") {
                        $("#ctl00_ContentPlaceHolder1_lblmqual").text($("#ctl00_ContentPlaceHolder1_txtmqualification").val());
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblmqual").text($("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1 option:selected").text());
                    }

                    $("#ctl00_ContentPlaceHolder1_lblmprofession").text($("#ctl00_ContentPlaceHolder1_TextBox9").val());

                    $("#ctl00_ContentPlaceHolder1_lblmorg").text($("#ctl00_ContentPlaceHolder1_TextBox10").val());
                    $("#ctl00_ContentPlaceHolder1_lblmotheresphone").text($("#ctl00_ContentPlaceHolder1_TextBox11").val() + " " + $("#ctl00_ContentPlaceHolder1_TextBox12").val());
                    $("#ctl00_ContentPlaceHolder1_lblmotheroffp").text($("#ctl00_ContentPlaceHolder1_TextBox13").val() + " " + $("#ctl00_ContentPlaceHolder1_TextBox14").val());
                    $("#ctl00_ContentPlaceHolder1_lblmobileM").text($("#ctl00_ContentPlaceHolder1_TextBox15").val());
                    $("#ctl00_ContentPlaceHolder1_lblfathermobile").text($("#ctl00_ContentPlaceHolder1_TextBox6").val());
                    $("#ctl00_ContentPlaceHolder1_lblMemail").text($("#ctl00_ContentPlaceHolder1_TextBox16").val());

                    if ($("#ctl00_ContentPlaceHolder1_RadioButtonList1 :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_Label4").text($("#ctl00_ContentPlaceHolder1_txtprevious").val());

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_Label4").text('No');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_RadioButtonList4 :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lblateended").text('Yes');

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblateended").text('No');
                    }
                    if ($("#ctl00_ContentPlaceHolder1_ddlblood option:selected").text() == "--Select Group--") {

                        $("#ctl00_ContentPlaceHolder1_lblbloddgroup").text('');
                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblbloddgroup").text($("#ctl00_ContentPlaceHolder1_ddlblood option:selected").text());
                    }
                    $("#ctl00_ContentPlaceHolder1_lblaliments").text($("#ctl00_ContentPlaceHolder1_txtaliment").val());
                    $("#ctl00_ContentPlaceHolder1_lblsurgery").text($("#ctl00_ContentPlaceHolder1_txtSurgery").val());
                    $("#ctl00_ContentPlaceHolder1_lblalergies").text($("#ctl00_ContentPlaceHolder1_txtAllergies").val());

                    if ($("#ctl00_ContentPlaceHolder1_RadioButtonList2 :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lblregularmedication").text($("#ctl00_ContentPlaceHolder1_txtspecify").val());

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblateended").text('No');
                    }

                    if ($("#ctl00_ContentPlaceHolder1_RadioButtonList3 :checked").val() == 1) {
                        $("#ctl00_ContentPlaceHolder1_lblphobias").text($("#ctl00_ContentPlaceHolder1_txtspecify1").val());

                    }
                    else {
                        $("#ctl00_ContentPlaceHolder1_lblphobias").text('No');
                    }

                    $("#ctl00_ContentPlaceHolder1_lblnaem1").text($("#ctl00_ContentPlaceHolder1_txtinstruments").val());

                    $("#ctl00_ContentPlaceHolder1_lblemaergencyname").text($("#ctl00_ContentPlaceHolder1_txtname1").val());

                    $("#ctl00_ContentPlaceHolder1_lblemaergencycontactno").text($("#ctl00_ContentPlaceHolder1_txtcontact1").val());

                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "none");
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';

                    return false;
                }

            });

            $('[id*=rtransportation] input').unbind().click(function (e) {

                $("#ctl00_ContentPlaceHolder1_ddlstclass").html('');
                $('#ctl00_ContentPlaceHolder1_divstudentadno1').append('<div style="background-color:#E6E6E6;position: absolute;top:0;left:0;width:100%;height:100%;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);"><img src="../images/load_process.gif" style="background-color:Aqua;position:absolute; top:10%; margin-left: 400px;" /></div>');
                setTimeout(function () {

                    $.ajax(
                                           {
                                               type: "POST",
                                               contentType: "application/json; charset=utf-8",
                                               url: "admissionform.aspx/binclass",

                                               dataType: "json",
                                               success: function (data) {
                                                   $("#ctl00_ContentPlaceHolder1_ddlstclass").html("");
                                                   $.each(data.d, function (key, value1) {
                                                       $("#ctl00_ContentPlaceHolder1_ddlstclass").append($("<option></option>").val(value1.SID).html(value1.statename));
                                                       $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();
                                                   });
                                                   // $('#ctl00_ContentPlaceHolder1_ddlCity1').val(value.cityid);
                                               },
                                               error: function (result) {
                                                   alert("Error");
                                               }
                                           });

                    $("#ctl00_ContentPlaceHolder1_bankdetail").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_ddlPayMode").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0);
                    $("#ctl00_ContentPlaceHolder1_txtBankName").val('');
                    $("#ctl00_ContentPlaceHolder1_txtCheque").val('');
                    $('#ctl00_ContentPlaceHolder1_divstudentadno1 div').remove();

                }, 700);

            });

            $("#ctl00_ContentPlaceHolder1_Button5").click(function () {
                $("#fee").css("display", "none");
                $("#f1").css("display", "block");
                $("#preview").css("display", "none");
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_Button4").click(function () {
                $("#fee").css("display", "none");
                $("#f1").css("display", "block");

                $("#preview").css("display", "none");
                return false;

            });

            $("#ctl00_ContentPlaceHolder1_txtpaimat").on('change', function () {

                var amt1 = $('#<%=grd1.ClientID%>  tr:eq(2)').find('td:eq(2)').text();
                var amt = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
                var tamount = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();

                if (parseFloat(amt) < parseFloat(tamount)) {
                    alert("Amount should be greater or equal to first month fee amount.");
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
                    return false;
                }

                else if (parseFloat(amt) <= parseFloat(tamount)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text(parseFloat(tamount) - parseFloat(amt));
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "block");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                    return;
                }
                else if (parseFloat(amt) > parseFloat(tamount)) {
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").text("amount can not be greater than payable fee amount.");
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "block");
                    return;
                }

            });

        });
    </script>

    <%------validation function declaration --%>

    <script type="text/javascript">
        function validation() {
            var status = 1;

            //-------------Here student details

            if (document.getElementById('<%=ddlMonth.ClientID %>').value == "--Month--") {
                alert("Please select month.");
                document.getElementById('<%=ddlMonth.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_ddlMonth").css("border-color", "red");
                $("#contentDivImg").css("display", "block");
                $("#cont123").css("display", "none");
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0

                return status;

            }

            if (document.getElementById('<%=ddlDate.ClientID %>').value == "--Date--") {
                alert("Please select date.");
                document.getElementById('<%=ddlDate.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_ddlDate").css("border-color", "red");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;

            }

            if (document.getElementById('<%=ddlYear.ClientID %>').value == "--Year--") {
                alert("Please select year.");
                document.getElementById('<%=ddlYear.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#ctl00_ContentPlaceHolder1_ddlYear").css("border-color", "red");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;

            }

            if (document.getElementById("ctl00_ContentPlaceHolder1_rtransportation_0").value.trim() == 1) {

                if (document.getElementById('<%=ddlstclass.ClientID %>').value.trim() == 0) {
                    alert("Please select Class.");
                    document.getElementById('<%=ddlstclass.ClientID %>').focus();
                    $("#contentDivImg").css("display", "block");
                    imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    $("#ctl00_ContentPlaceHolder1_ddlstclass").css("border-color", "red");
                    $("#cont123").css("display", "none");
                    A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;

                }
            }

            if (document.getElementById('<%=ddlstclass.ClientID %>').value.trim() == "--Select Class--") {
                alert("Please select Class.");
                document.getElementById('<%=ddlstclass.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#ctl00_ContentPlaceHolder1_ddlstclass").css("border-color", "red");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;

            }

            //if (document.getElementById('<%=ddlssection.ClientID %>').value.trim() == 0) {
            //  alert("Please select Section.");
            //document.getElementById('<%=ddlssection.ClientID %>').focus();
            // $("#contentDivImg").css("display", "block");
            // imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
            // $("#ctl00_ContentPlaceHolder1_ddlssection").css("border-color", "red");
            // $("#cont123").css("display", "none");
            //  A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            // $("#contentDivImgA2").css("display", "none");
            //$("#contentDivImgA1").css("display", "none");
            //A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            // A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            // status = 0
            //  return status;

            // }

            if (document.getElementById('<%=txtName.ClientID %>').value.trim() == 0) {
                alert("Please enter student first name.");
                document.getElementById('<%=txtName.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtName").css("border-color", "red");
                $("#contentDivImg").css("display", "block");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtLName.ClientID %>').value.trim() == 0) {
                alert("Please enter student last name.");
                document.getElementById('<%=txtLName.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_txtLName").css("border-color", "red");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtFname.ClientID %>').value.trim() == 0) {
                alert("Please enter Nationality.");
                document.getElementById('<%=txtFname.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_txtFname").css("border-color", "red");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == 0) {
                alert("Please Enter Date of Birth.");
                document.getElementById('<%=txtToDate.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#ctl00_ContentPlaceHolder1_txtToDate").css("border-color", "red");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txthouseno.ClientID %>').value.trim() == 0) {
                alert("Please Enter House No.");
                document.getElementById('<%=txthouseno.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txthouseno").css("border-color", "red");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImg").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }
            if (document.getElementById('<%=txtappartment.ClientID %>').value.trim() == 0) {
                alert("Please Enter appartment.");
                document.getElementById('<%=txtappartment.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtappartment").css("border-color", "red");
                $("#contentDivImg").css("display", "block");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtland.ClientID %>').value.trim() == 0) {
                alert("Please Enter LandMark.");
                document.getElementById('<%=txtland.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtland").css("border-color", "red");
                $("#contentDivImg").css("display", "block");
                $("#cont123").css("display", "none");
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtPZIP.ClientID %>').value.trim() == 0) {
                alert("Please Enter Pincode.");
                document.getElementById('<%=txtPZIP.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtPZIP").css("border-color", "red");
                $("#contentDivImg").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            //--------For Other language textbox
            if ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") {
                if (document.getElementById('<%=txtlan.ClientID %>').value.trim() == 0) {
                    alert("Please enter other language.");
                    document.getElementById('<%=txtlan.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtlan").css("border-color", "red");
                    $("#contentDivImg").css("display", "block");
                    $("#cont123").css("display", "none");
                    imageDivLink.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;

                }
            }

            //-----------here father details

            if (document.getElementById('<%=txtfather.ClientID %>').value.trim() == 0) {
                alert("Please Enter Father name.");
                document.getElementById('<%=txtfather.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtfather").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=ddlFQualifiaction1.ClientID %>').value.trim() == 0) {
                alert("Please Select  Father Qualification.");
                document.getElementById('<%=ddlFQualifiaction1.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById("ctl00_ContentPlaceHolder1_ddlFQualifiaction1").value.trim() == 5) {

                if (document.getElementById('<%=txtqualification.ClientID %>').value.trim() == 0) {
                    alert("Please enter Father Qualification.");
                    document.getElementById('<%=txtqualification.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtqualification").css("border-color", "red");
                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "block");
                    imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;
                }
            }
            if (document.getElementById('<%=txtprofession.ClientID %>').value.trim() == 0) {
                alert("Please enter Father occupation.");
                document.getElementById('<%=txtprofession.ClientID %>').focus();
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }
            if (document.getElementById('<%=TextBox3.ClientID %>').value.trim() == 0) {
                alert("Please Enter Father Organization Name.");
                document.getElementById('<%=TextBox3.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox3").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            //if (document.getElementById('<%=txtphoneno.ClientID %>').value.trim() == 0) {
            //  alert("Please enter Residence Phone Number.");
            // document.getElementById('<%=txtphoneno.ClientID %>').focus();
            // $("#contentDivImg").css("display", "none");
            //$("#cont123").css("display", "block");
            // imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            //A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
            //$("#contentDivImgA2").css("display", "none");
            // $("#contentDivImgA1").css("display", "none");
            // A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            // A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
            // status = 0
            // return status;
            //}

            if (document.getElementById('<%=TextBox6.ClientID %>').value.trim() == 0) {
                alert("Please Select Father Mobile Number.");
                document.getElementById('<%=TextBox6.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox6").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtemail.ClientID %>').value.trim() == 0) {
                alert("Please Enter Father Email Id.");
                document.getElementById('<%=txtemail.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtemail").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            //--------here mother details
            if (document.getElementById('<%=TextBox7.ClientID %>').value.trim() == 0) {
                alert("Please Enter mother name.");
                document.getElementById('<%=TextBox7.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox7").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }
            if (document.getElementById('<%=ddlMQualifiaction1.ClientID %>').value.trim() == 0) {
                alert("Please Select  Mother Qualification.");
                document.getElementById('<%=ddlMQualifiaction1.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }
            if (document.getElementById("ctl00_ContentPlaceHolder1_ddlMQualifiaction1").value.trim() == 5) {
                if (document.getElementById('<%=txtmqualification.ClientID %>').value.trim() == 0) {
                    alert("Please enter Mother Qualification.");
                    document.getElementById('<%=txtmqualification.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtmqualification").css("border-color", "red");
                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "block");
                    imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;
                }
            }
            if (document.getElementById('<%=TextBox15.ClientID %>').value.trim() == 0) {
                alert("Please Enter mother Mobile Number.");
                document.getElementById('<%=TextBox15.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox15").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "block");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            //------Previous schooling
            var targlist = "";
            var rbList = document.getElementById('<%= RadioButtonList1.ClientID %>');
            var rbCount = rbList.getElementsByTagName("input");

            for (var i = 0; i < rbCount.length; i++) {
                if (rbCount[i].checked == true) {

                    targlist = rbCount[i].value;
                }
            }

            if (targlist == "1") {
                if (document.getElementById('<%=txtprevious.ClientID %>').value.trim() == 0) {
                    alert("Please enter previous schooling.");
                    document.getElementById('<%=txtprevious.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtprevious").css("border-color", "red");
                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "block");
                    imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "none");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;
                }
            }

            //---------regular medication

            if (document.getElementById('<%=ddlblood.ClientID %>').value.trim() == 0) {
                alert("Please Select Child Blood group.");
                document.getElementById('<%=ddlblood.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_ddlblood").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "block");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtaliment.ClientID %>').value.trim() == 0) {
                alert("Please enter ailments suffered in the past.");
                document.getElementById('<%=txtaliment.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtaliment").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "block");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }
            if (document.getElementById('<%=txtSurgery.ClientID %>').value.trim() == 0) {
                alert("Please enter Surgery undergone if any.");
                document.getElementById('<%=txtSurgery.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtSurgery").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "block");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            if (document.getElementById('<%=txtAllergies.ClientID %>').value.trim() == 0) {
                alert("Please enter Allergies.");
                document.getElementById('<%=txtAllergies.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtAllergies").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "block");
                $("#contentDivImgA1").css("display", "none");
                A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                status = 0
                return status;
            }

            var targlist1 = "";
            var rbList1 = document.getElementById('<%= RadioButtonList2.ClientID %>');
            var rbCount1 = rbList1.getElementsByTagName("input");

            for (var i = 0; i < rbCount1.length; i++) {

                if (rbCount1[i].checked == true) {

                    targlist1 = rbCount1[i].value;
                }
            }

            if (targlist1 == "1") {
                if (document.getElementById('<%=txtspecify.ClientID %>').value.trim() == 0) {
                    alert("Please enter regular medication.");
                    document.getElementById('<%=txtspecify.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtspecify").css("border-color", "red");
                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "none");
                    imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "block");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;
                }
            }
            //........phoblas

            var targlist2 = "";
            var rbList2 = document.getElementById('<%= RadioButtonList3.ClientID %>');
            var rbCount2 = rbList2.getElementsByTagName("input");

            for (var i = 0; i < rbCount2.length; i++) {

                if (rbCount2[i].checked == true) {

                    targlist2 = rbCount2[i].value;
                }
            }

            if (targlist2 == "1") {
                if (document.getElementById('<%=txtspecify1.ClientID %>').value.trim() == 0) {
                    alert("Please enter phoblas.");
                    document.getElementById('<%=txtspecify.ClientID %>').focus();
                    $("#ctl00_ContentPlaceHolder1_txtspecify1").css("border-color", "red");
                    $("#contentDivImg").css("display", "none");
                    $("#cont123").css("display", "none");
                    imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    $("#contentDivImgA2").css("display", "block");
                    $("#contentDivImgA1").css("display", "none");
                    A1.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                    A2.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                    status = 0
                    return status;
                }
            }

            if (document.getElementById('<%=txtname1.ClientID %>').value.trim() == 0) {
                alert("Please enter emergency contact person Name.");
                document.getElementById('<%=txtname1.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_txtname1").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;

            }
            if (document.getElementById('<%=txtcontact1.ClientID %>').value.trim() == 0) {
                alert("Please enter emergency Contact Number.");
                document.getElementById('<%=txtcontact1.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtcontact1").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;
            }
            if (document.getElementById('<%=txtemergencyaddress1.ClientID %>').value.trim() == 0) {
                alert("Please enter emergency contact paerson Address!!");
                document.getElementById('<%=txtemergencyaddress1.ClientID %>').focus();
                $("#contentDivImg").css("display", "block");
                $("#ctl00_ContentPlaceHolder1_txtemergencyaddress1").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;

            }

            if (document.getElementById('<%=TextBox30.ClientID %>').value.trim() == 0) {
                alert("Please enter signee name.");
                document.getElementById('<%=TextBox30.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox30").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;
            }

            //........here relation with student

            if (document.getElementById('<%=TextBox28.ClientID %>').value.trim() == 0) {
                alert("Please enter relation.");
                document.getElementById('<%=TextBox28.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_TextBox28").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;
            }

            if (document.getElementById('<%=txtDate.ClientID %>').value.trim() == 0) {
                alert("Please enter date.");
                document.getElementById('<%=txtDate.ClientID %>').focus();
                $("#ctl00_ContentPlaceHolder1_txtDate").css("border-color", "red");
                $("#contentDivImg").css("display", "none");
                $("#cont123").css("display", "none");
                imageDivLink.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                A3.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';
                $("#contentDivImgA2").css("display", "none");
                $("#contentDivImgA1").css("display", "block");
                A1.innerHTML = '<img src="../images/Green_Minus.gif" style="padding: 13px;position: absolute;" >';
                A2.innerHTML = '<img src="../images/addd11.png" style="padding: 13px;position: absolute;" >';

                status = 0
                return status;
            }

        }
    </script>

    <%--  Here remove style (border)   --%>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#ctl00_ContentPlaceHolder1_ddlDate").change(function () {
                var dateid = document.getElementById("ctl00_ContentPlaceHolder1_ddlDate").value;

                if (dateid != "--Date--") {
                    $("#ctl00_ContentPlaceHolder1_ddlDate").css("border", "1px solid #cccccc");

                }
            });

            $("#ctl00_ContentPlaceHolder1_ddlYear").change(function () {
                var dateid = document.getElementById("ctl00_ContentPlaceHolder1_ddlYear").value;

                if (dateid != "--Year--") {
                    $("#ctl00_ContentPlaceHolder1_ddlYear").css("border", "1px solid #cccccc");

                }
            });
            $("#ctl00_ContentPlaceHolder1_txtName").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtName").css("border", "1px solid #cccccc");
            }));

            $("#ctl00_ContentPlaceHolder1_txtFname").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtFname").css("border", "1px solid #cccccc");

            }));
            $("#ctl00_ContentPlaceHolder1_txtLName").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtLName").css("border", "1px solid #cccccc");
            }));
            $("#ctl00_ContentPlaceHolder1_TextBox7").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox7").css("border", "1px solid #cccccc");
            }));

            $('#ctl00_ContentPlaceHolder1_TextBox7').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox7").css("border", "1px solid #cccccc");
            });

            $('#ctl00_ContentPlaceHolder1_txtName').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtName").css("border", "1px solid #cccccc");
            });
            //   $('#ctl00_ContentPlaceHolder1_txtmidname').keyup(function () {
            //     $("#ctl00_ContentPlaceHolder1_txtmidname").css("border", "1px solid #cccccc");

            $('#ctl00_ContentPlaceHolder1_txtLName').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtLName").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtLName").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtLName").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtName').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtName").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtToDate").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtToDate").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtToDate').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtName").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txthouseno").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txthouseno").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txthouseno').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txthouseno").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txthouseno").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_ttxtappartment").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtappartment').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtappartment").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtstreet").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtstreet").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtstreet').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtstreet").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtPZIP").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtPZIP").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtPZIP').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtPZIP").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtlan").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtlan").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtlan').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtlan").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtfather").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtfather").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtfather').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtfather").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtqualification").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtqualification").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtqualification').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtqualification").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_TextBox6").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox6").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_TextBox6').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox6").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtphoneno").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtphoneno").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtphoneno').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtphoneno").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_TextBox15").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox15").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_TextBox15').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox15").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtland").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtland").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtland').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtland").css("border", "1px solid #cccccc");
            });

            $('#ctl00_ContentPlaceHolder1_ddlMQualifiaction1').change(function () {
                var dateid = document.getElementById("ctl00_ContentPlaceHolder1_ddlMQualifiaction1").value;

                if (dateid != "--Year--") {
                    $("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1").css("border", "1px solid #cccccc");
                    $("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1").css("border", "1px solid #cccccc");

                }

            });

            $('#ctl00_ContentPlaceHolder1_ddlFQualifiaction1').change(function () {
                var dateid = document.getElementById("ctl00_ContentPlaceHolder1_ddlYear").value;

                if (dateid != "--Year--") {
                    $("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1").css("border", "1px solid #cccccc");
                    $("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1").css("border", "1px solid #cccccc");

                }

            });

            $('#ctl00_ContentPlaceHolder1_ddlssection').change(function () {

                $("#ctl00_ContentPlaceHolder1_ddlssection").css("border", "1px solid #cccccc");
                $("#ctl00_ContentPlaceHolder1_ddlssection").css("border", "1px solid #cccccc");

            });

            $('#ctl00_ContentPlaceHolder1_ddlblood').change(function () {

                $("#ctl00_ContentPlaceHolder1_ddlblood").css("border", "1px solid #cccccc");
                $("#ctl00_ContentPlaceHolder1_ddlblood").css("border", "1px solid #cccccc");

            });

            $("#ctl00_ContentPlaceHolder1_txtprevious").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtprevious").css("border", "1px solid #cccccc");
            }));

            $('#ctl00_ContentPlaceHolder1_txtprevious').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtprevious").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtspecify").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtspecify").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtspecify').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtspecify").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_txtspecify1").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtspecify1").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtspecify1').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtspecify1").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_TextBox30").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox30").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_TextBox30').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox30").css("border", "1px solid #cccccc");
            });

            $("#ctl00_ContentPlaceHolder1_TextBox28").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox28").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_TextBox28').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox28").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtDate").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtDate").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtDate').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtDate").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtaliment").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtaliment").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtaliment').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtaliment").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtSurgery").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtSurgery").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtSurgery').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtSurgery").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtAllergies").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtAllergies").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtAllergies').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtAllergies").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtname1").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtname1").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtname1').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtname1").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtcontact1").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtcontact1").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtcontact1').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtcontact1").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtemergencyaddress1").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtemergencyaddress1").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtemergencyaddress1').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtemergencyaddress1").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtmqualification").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtmqualification").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtmqualification').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtmqualification").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtemail").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtemail").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtemail').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtemail").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtprofession").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtprofession").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtprofession').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtprofession").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_txtappartment").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_txtappartment").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_txtappartment').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_txtappartment").css("border", "1px solid #cccccc");
            });
            $("#ctl00_ContentPlaceHolder1_TextBox3").bind("mouseover", (function (event) {

                $("#ctl00_ContentPlaceHolder1_TextBox3").css("border", "1px solid #cccccc");
            }));
            $('#ctl00_ContentPlaceHolder1_TextBox3').keyup(function () {
                $("#ctl00_ContentPlaceHolder1_TextBox3").css("border", "1px solid #cccccc");
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

    <%---------------check date of birth--%>

    <script type="text/javascript">
        function CalculateAge(DOB) {

            var inputdob = DOB.value;

            if (inputdob == "") {

                alert("Enter date of Birth");

                document.getElementById('lblAge').innerHTML = '';

                return false;

            }

            var DOBDate = new Date(inputdob);

            var currentDate = new Date();

            var months = currentDate.getMonth() - DOBDate.getMonth();

            var years = currentDate.getFullYear() - DOBDate.getFullYear();

            var days = currentDate.getDate() - DOBDate.getDate();

            if (years < 0) {
                alert("Choose correct date of brith.");
                $('#ctl00_ContentPlaceHolder1_txtToDate').val('');
                document.getElementById('lblAge').innerHTML = "";
                return false;
            }

            if (months < 0) {

                years = parseInt(years, 10) - 1;

                months = 12 + parseInt(months, 10);

                if (days < 0) {
                    alert("f");
                    months = parseInt(months, 10) - 1;

                    days = 30 + parseInt(days, 10);

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                    $('#lblAge').css("color", "red");
                }

                else

                    document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (days) + ' Days';
                $('#lblAge').css("color", "red");
            }

            else {

                if (months == 0) {

                    years = parseInt(years, 10);

                    if (days < 0) {

                        dayDiff = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + (-days) + ' Days';
                        $('#lblAge').css("color", "red");
                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                    $('#lblAge').css("color", "red");
                }

                else {

                    if (days < 0) {

                        months = parseInt(months, 10) - 1;

                        days = 30 + parseInt(days, 10);

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                        $('#lblAge').css("color", "red");
                    }

                    else

                        document.getElementById('lblAge').innerHTML = years + ' Years ' + months + ' Months ' + days + ' Days';
                    $('#lblAge').css("color", "red");
                }

            }

        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            var sum = 0;
            var sum1 = 0;
            var disamt = 0;
            var c1 = 0;

            $("#<%=grd1.ClientID %> input:checkbox[id*=chkclass1]").live('click', function () {

                var cal1 = 0;
                var check = 0;

                if ($(this).is(':checked')) {

                    $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                        if ($(this).is(':checked')) {
                            var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                            cal1 += parseFloat(amt1);
                            check = check + 1;

                        }
                    });

                    disamt = 0;
                    c1 = 0;
                    amt = 0;

                    var GridId = "<%=grdDetails.ClientID %>";
                    var grid = document.getElementById(GridId);
                    rowscount = grid.rows.length;
                    //alert($(this).closest('tr').find('td:eq(2)').text());
                    var amt = $(this).closest('tr').find('td:eq(2)').text();
                    sum += parseFloat(amt);
                    for (var i = 3; i <= rowscount; i++) {

                        if ($('tr:nth-child(' + i + ') td:nth-child(2) input').val() == 6) {
                            c1 = parseFloat(check) * parseFloat($('tr:nth-child(' + i + ') td:nth-child(4) input').val());
                            // alert(check);

                        }
                        else {
                            c1 = $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                        }

                        disamt = parseFloat(disamt) + parseFloat(c1);

                    }
                    //alert(sum);

                    if ((parseFloat((cal1)) - parseFloat(disamt)) < 0) {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00);
                    } else {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat((cal1)) - parseFloat(disamt));
                    }
                    disamt = 0;

                    var checkvalue = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                    $(this).closest('tr').find('td:eq(1)').css("background-color", "#ffe8a1");
                    $(this).closest('tr').find('td:eq(2)').css("background-color", "#ffe8a1");
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);

                    //alert(parseFloat(amt) - parseFloat(disamt));
                    //alert(parseFloat(c1));
                    //alert($('#ctl00_ContentPlaceHolder1_txtpayablefee').val());

                    if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00')
                        // return;
                    }

                    $("#ctl00_ContentPlaceHolder1_grdclass tr:has(td)").each(function () {

                        $(this).closest('tr').find('td:contains(' + checkvalue + ')').css("background-color", "#ffe8a1");

                    });

                }

                else {

                    checkvalue = $(this).closest('tr').find('td:eq(1) span:first-child').text();

                    $("#ctl00_ContentPlaceHolder1_grdclass tr:has(td)").each(function () {

                        $(this).closest('tr').find('td:contains(' + checkvalue + ')').css("background-color", "White");

                    });

                    $(this).closest('tr').find('td:eq(1)').css("background-color", "White");
                    $(this).closest('tr').find('td:eq(2)').css("background-color", "White");
                    sum = 0;
                    disamt = 0;
                    amt = 0;
                    if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {

                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00');
                    }

                    var amt = $(this).closest('tr').find('td:eq(2)').text();

                    //alert(amt);
                    var GridId = "<%=grdDetails.ClientID %>";
                    var grid = document.getElementById(GridId);
                    rowscount = grid.rows.length;
                    for (var i = 3; i <= rowscount; i++) {

                        // discount = discount + "," + $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                        c1 = $('tr:nth-child(' + i + ') td:nth-child(4) input').val();
                        disamt = parseFloat(disamt) + parseFloat(c1);

                        //alert(disamt);
                    }
                    $("#ctl00_ContentPlaceHolder1_lblremain").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_lblremainbal").css("display", "none");
                    $("#ctl00_ContentPlaceHolder1_txtpaimat").val(0);
                    //alert(parseFloat(amt));

                    if (parseFloat($('#ctl00_ContentPlaceHolder1_txtpayablefee').val()) - parseFloat(amt) < 0) {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00).toFixed(2);

                    }
                    else {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat($('#ctl00_ContentPlaceHolder1_txtpayablefee').val()) - parseFloat(amt)).toFixed(2);
                    }
                    if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                        $('#ctl00_ContentPlaceHolder1_txtpayablefee').val('0.00');
                    }
                }

            });

            $(".txdiscount").on('change', function () {

                var discnt = 0;
                var discnt1 = "";
                var amt = "";
                amt = $(this).closest('tr').find('td:eq(2)').text();
                if ($(this).parent("td").parent("tr").find(".txdiscount").val() == "") {

                    $(this).parent("td").parent("tr").find(".txdiscount").val(0.00);

                }
                discnt1 = $(this).parent("td").parent("tr").find(".txdiscount").val();

                if (parseFloat(discnt1) >= parseFloat(amt)) {

                    //alert("Discount amount cannot be greater than fee amount.!");
                    $(this).val("0.00");

                    //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");

                }

                $(".txdiscount").each(function () {

                    var amt1 = "";
                    var count1 = 1;
                    discnt = parseFloat(discnt) + parseFloat($(this).parent("td").parent("tr").find(".txdiscount").val());
                    //alert(discnt);

                    // alert("hi");

                    // alert(amt);
                    var tot1 = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
                    var cal1 = 0

                    //alert(discnt);
                    if (discnt >= 0) {

                        //$("#<%=grdDetails.ClientID%> input[id*='checkbox']:checkbox").each(function()
                        $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                            //alert($(this).closest('tr').find('td:eq(2)').text());
                            if ($(this).is(':checked')) {
                                count1 = parseInt(count1) + 1;
                                var amt1 = $(this).closest('tr').find('td:eq(2)').text();
                                cal1 += parseFloat(amt1);

                            }

                            if ($('#ctl00_ContentPlaceHolder1_txtpayablefee').val() < 0) {
                                $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(0.00);
                            }

                        });

                        if (discnt == "0.00" || discnt == "0") {

                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat(cal1));
                        }
                        else {
                            //alert(cal1);
                            $('#ctl00_ContentPlaceHolder1_txtpayablefee').val(parseFloat(cal1) - parseFloat(discnt));
                        }
                        if (parseFloat(discnt1) >= parseFloat(amt)) {

                            alert("Discount amount cannot be greater than fee amount.!");
                            //$(this).closest('tr').find('td:eq(2)').find(".txdiscount").val("0.00");
                            //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");

                        }
                        else if (discnt1 < 0) {
                            alert("Discount amount cannot be less than zero.");
                            //$(this).parent("td").parent("tr").find(".txdiscount").val("0.00");
                        }

                    }

                    if ($("#ctl00_ContentPlaceHolder1_txtpayablefee").val() < 0) {
                        $("#ctl00_ContentPlaceHolder1_txtpayablefee").val(0.00);
                    }

                });
            });

            $("#ctl00_ContentPlaceHolder1_ddlPayMode").change(function () {

                var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;
                if (modeid == "0") {
                    $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
                    return;
                }
                else if (modeid == "1") {

                    $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "none");
                    return;
                }
                else if (modeid == "2") {

                    $('#ctl00_ContentPlaceHolder1_bankdetail').css("display", "block");
                    return;
                }
            });

            //-------------Submit here
            $("#ctl00_ContentPlaceHolder1_Button3").click(function () {

                if (document.getElementById('<%=ddlPayMode.ClientID %>').value == 0) {
                    alert("Please select Payment mode.");
                    document.getElementById('<%=ddlPayMode.ClientID %>').focus();
                    return false;
                }

                if (document.getElementById('<%=txtpayablefee.ClientID %>').value.trim() == 0) {
                    alert("Please select months!");
                    document.getElementById('<%=txtpayablefee.ClientID %>').focus();
                    return false;
                }

                if (document.getElementById('<%=txtpaimat.ClientID %>').value.trim() == 0) {
                    alert("Please enter payable amount!");
                    document.getElementById('<%=txtpaimat.ClientID %>').focus();
                    return false;
                }

                if (document.getElementById('<%=ddlpaystatus.ClientID %>').value == 0) {
                    alert("Please select pay type!");
                    document.getElementById('<%=ddlpaystatus.ClientID %>').focus();
                    return false;
                }

                if (parseFloat($("#ctl00_ContentPlaceHolder1_txtpayablefee").val()) < parseFloat($("#ctl00_ContentPlaceHolder1_txtpaimat").val())) {
                    alert("amount cannot greater than payable amount.");
                    $('#ctl00_ContentPlaceHolder1_txtpaimat').val('0.00');
                    return false;
                }

                var month = document.getElementById("ctl00_ContentPlaceHolder1_ddlMonth").value;
                var dte = $("#ctl00_ContentPlaceHolder1_ddlDate option:selected").text();

                $("#ctl00_ContentPlaceHolder1_hdate").val(dte);
                var year = $("#ctl00_ContentPlaceHolder1_ddlYear option:selected").text();

                var admdate = year + "-" + month + "-" + dte;
                var classid = "", classname = "";

                classid = document.getElementById("ctl00_ContentPlaceHolder1_ddlstclass").value;
                classname = $("#ctl00_ContentPlaceHolder1_ddlstclass option:selected").text();

                var tansptype = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();

                var sfname = $("#ctl00_ContentPlaceHolder1_txtName").val();

                var smname = $("#ctl00_ContentPlaceHolder1_txtmidname").val();
                var slname = $("#ctl00_ContentPlaceHolder1_txtLName").val();

                var sgender = $("#ctl00_ContentPlaceHolder1_rbgender :checked").val();
                var snationality = $("#ctl00_ContentPlaceHolder1_txtFname").val();
                var sdob = $("#ctl00_ContentPlaceHolder1_txtToDate").val();

                var sheight = $("#ctl00_ContentPlaceHolder1_TextBox1").val();
                var sweight = $("#ctl00_ContentPlaceHolder1_TextBox2").val();

                var houseno = $("#ctl00_ContentPlaceHolder1_txthouseno").val();
                var appartment = $("#ctl00_ContentPlaceHolder1_txtappartment").val();
                var street = $("#ctl00_ContentPlaceHolder1_txtstreet").val();
                var land = $("#ctl00_ContentPlaceHolder1_txtland").val();
                var pincode = $("#ctl00_ContentPlaceHolder1_txtPZIP").val();

                var lang = "";

                if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked") {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('English');
                }

                if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('Hindi');
                }

                if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked")) {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('English,Hindi');
                }

                if ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text($("#ctl00_ContentPlaceHolder1_txtlan").val());
                    $("#ctl00_ContentPlaceHolder1_lblangid").val($("#ctl00_ContentPlaceHolder1_txtlan").val());
                }

                if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked")) {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,Hindi, ' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('English,Hindi, ' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                }

                if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('English,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('English,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                }

                if ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") == "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") == "checked") && ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked")) {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('Hindi,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                    $("#ctl00_ContentPlaceHolder1_lblangid").val('Hindi,' + $("#ctl00_ContentPlaceHolder1_txtlan").val() + '');
                }

                if ($("#ctl00_ContentPlaceHolder1_chkenglish").attr("checked") != "checked" && ($("#ctl00_ContentPlaceHolder1_CheckBox1").attr("checked") != "checked") && ($("#ctl00_ContentPlaceHolder1_chkhindi").attr("checked") != "checked")) {
                    lang = $("#ctl00_ContentPlaceHolder1_lbllang").text('');
                }

                var transportion = $("#ctl00_ContentPlaceHolder1_rtransportation :checked").val();
                var fathername = $("#ctl00_ContentPlaceHolder1_txtfather").val();
                var fqualificationother = $("#ctl00_ContentPlaceHolder1_txtqualification").val();
                var Fqualification = document.getElementById("ctl00_ContentPlaceHolder1_ddlFQualifiaction1").value;

                if (Fqualification > 0) {
                    Fqualification = document.getElementById("ctl00_ContentPlaceHolder1_ddlFQualifiaction1").value;
                }
                else {
                    Fqualification = 0;
                }

                var Fprofession = $("#ctl00_ContentPlaceHolder1_txtprofession").val();
                var Forganisation = $("#ctl00_ContentPlaceHolder1_TextBox3").val();

                var FStdcodeRes = $("#ctl00_ContentPlaceHolder1_txtpcode").val();
                var FphonenoRes = $("#ctl00_ContentPlaceHolder1_txtphoneno").val();
                var FStdcodeoffice = $("#ctl00_ContentPlaceHolder1_TextBox4").val();
                var Fphoneoffice = $("#ctl00_ContentPlaceHolder1_TextBox5").val();
                var Fmobileno = $("#ctl00_ContentPlaceHolder1_TextBox6").val();
                var Femail = $("#ctl00_ContentPlaceHolder1_txtemail").val();

                var Mothetname = $("#ctl00_ContentPlaceHolder1_TextBox7").val();
                var mqualificationother = $("#ctl00_ContentPlaceHolder1_txtqualification").val();
                var Mqualification = document.getElementById("ctl00_ContentPlaceHolder1_ddlMQualifiaction1").value;

                var Mprofession = $("#ctl00_ContentPlaceHolder1_TextBox9").val();

                var Moragnisation = $("#ctl00_ContentPlaceHolder1_TextBox10").val();

                var MStdcodeRes = $("#ctl00_ContentPlaceHolder1_TextBox11").val();
                var MphonenoRes = $("#ctl00_ContentPlaceHolder1_TextBox12").val();
                var MStdcodeoffice = $("#ctl00_ContentPlaceHolder1_TextBox13").val();
                var Mphoneoffice = $("#ctl00_ContentPlaceHolder1_TextBox14").val();
                var Mmobileno = $("#ctl00_ContentPlaceHolder1_TextBox15").val();
                var Memail = $("#ctl00_ContentPlaceHolder1_TextBox16").val();

                var previousschool_detail = ""
                var previousschoolid = $("#ctl00_ContentPlaceHolder1_rbgender :checked").val();
                if (previousschoolid == "1") {
                    previousschool_detail = $("#ctl00_ContentPlaceHolder1_txtprevious").val();
                }
                else {
                    previousschool_detail = "";
                }

                var sibname1 = $("#ctl00_ContentPlaceHolder1_TextBox17").val();
                var sibnage1 = $("#ctl00_ContentPlaceHolder1_TextBox18").val();
                var sibschool1 = $("#ctl00_ContentPlaceHolder1_TextBox19").val();

                var sibname2 = $("#ctl00_ContentPlaceHolder1_TextBox20").val();
                var sibnage2 = $("#ctl00_ContentPlaceHolder1_TextBox21").val();
                var sibschool2 = $("#ctl00_ContentPlaceHolder1_TextBox22").val();

                var sibname3 = $("#ctl00_ContentPlaceHolder1_TextBox23").val();
                var sibnage3 = $("#ctl00_ContentPlaceHolder1_TextBox24").val();
                var sibschool3 = $("#ctl00_ContentPlaceHolder1_TextBox25").val();

                var Little_IllusionsAttended = $("#ctl00_ContentPlaceHolder1_RadioButtonList4 :checked").val();

                var bloodgroup = document.getElementById("ctl00_ContentPlaceHolder1_ddlblood").value;
                //------------------

                var grdvalue = ""
                $('#<%=grdimmuni.ClientID%>').find("input:radio").each(function () {
                    if ($(this).is(':checked')) {
                        grdvalue = grdvalue + "," + $(this).val();
                    }
                });

                grdvalue = grdvalue.substring(1, grdvalue.length);

                var ailments_suffered = $("#ctl00_ContentPlaceHolder1_txtaliment").val();

                var Surgery = $("#ctl00_ContentPlaceHolder1_txtSurgery").val();
                var Allergies = $("#ctl00_ContentPlaceHolder1_txtAllergies").val();

                var regular_medication = $("#ctl00_ContentPlaceHolder1_RadioButtonList2 :checked").val();
                var reg_medical_detail = "";
                if (regular_medication == "1") {
                    reg_medical_detail = $("#ctl00_ContentPlaceHolder1_txtspecify").val();
                }
                else {
                    reg_medical_detail = "";
                }

                var child_suffer = $("#ctl00_ContentPlaceHolder1_RadioButtonList3 :checked").val();
                var child_suffer_detail = "";
                if (child_suffer == "1") {
                    child_suffer_detail = $("#ctl00_ContentPlaceHolder1_txtspecify1").val();
                }
                else {
                    child_suffer_detail = "";
                }

                var instruction = $("#ctl00_ContentPlaceHolder1_txtinstruments").val();
                var name1 = $("#ctl00_ContentPlaceHolder1_txtname1").val();
                var contact1 = $("#ctl00_ContentPlaceHolder1_txtcontact1").val();
                var name2 = $("#ctl00_ContentPlaceHolder1_txtname2").val();
                var contact2 = $("#ctl00_ContentPlaceHolder1_txtcontact2").val();
                var signee = $("#ctl00_ContentPlaceHolder1_TextBox30").val();
                var relation = $("#ctl00_ContentPlaceHolder1_TextBox28").val();
                var date = $("#ctl00_ContentPlaceHolder1_txtDate").val();

                var paymonthids = "";

                $('#<%=grd1.ClientID%>').find("input:checkbox").each(function () {

                    if ($(this).is(':checked')) {
                        var amt1 = $(this).closest('tr').find('td:eq(1) span:last-child').text();
                        paymonthids = paymonthids + "," + amt1;
                    }
                });

                paymonthids = paymonthids.substring(1, paymonthids.length);
                $("#ctl00_ContentPlaceHolder1_paymonthsidshide").val(paymonthids);

                //var pymode = $("#ctl00_ContentPlaceHolder1_ddlPayMode option:selected").text();

                var ffid = "";
                var feenm = "";
                var feamt = "";

                ///  gridview discount ////////////////

                var feeid = "";
                var feenm = "";
                var feamt = "";
                var discount = "";
                var checkbox1 = "";
                var checkbox2 = "";

                var GridId = "<%=grdDetails.ClientID %>";
                var grid = document.getElementById(GridId);
                rowscount = grid.rows.length;

                for (var i = 3; i <= rowscount; i++) {

                    var row = $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ')'); // skip the header row

                    feeid = feeid + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(2) input').val();
                    feenm = feenm + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(2) span').text();
                    feamt = feamt + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(3) span').text();
                    discount = discount + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) input').val();
                    // checkbox2= checkbox2 + "," + $('tr:nth-child(' + i + ') td:nth-child(4) span.checked');
                    if ($('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) input:checkbox').is(':checked')) {

                        checkbox2 = checkbox2 + "," + $('#ctl00_ContentPlaceHolder1_grdDetails tr:nth-child(' + i + ') td:nth-child(4) span').text();
                    }
                    else {
                        checkbox2 = checkbox2 + "," + 0;
                    }

                }
                feeid = feeid.substring(1, feeid.length);
                feenm = feenm.substring(1, feenm.length);
                feamt = feamt.substring(1, feamt.length);
                discount = discount.substring(1, discount.length);
                checkbox2 = checkbox2.substring(1, checkbox2.length);

                $("#ctl00_ContentPlaceHolder1_lblfeeid1").val(feeid);
                $("#ctl00_ContentPlaceHolder1_lblfeename1").val(feenm);
                $("#ctl00_ContentPlaceHolder1_lblfeeamout1").val(feamt);
                $("#ctl00_ContentPlaceHolder1_lbldis1").val(discount);
                $("#ctl00_ContentPlaceHolder1_lblcheck1").val(checkbox2);

                var paidamount = $("#ctl00_ContentPlaceHolder1_txtpaimat").val();
                var payable = $("#ctl00_ContentPlaceHolder1_txtpayablefee").val();
                var modeid = document.getElementById("ctl00_ContentPlaceHolder1_ddlPayMode").value;

                if (modeid == "1") {

                    var bankname = "";
                    var checkno = "";
                }
                else if (modeid == "2") {
                    var bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                    var checkno = $("ctl00_ContentPlaceHolder1_txtCheque").val();
                }

                else if (modeid == "3") {
                    var bankname = $("#ctl00_ContentPlaceHolder1_txtBankName").val();
                    var checkno = $("ctl00_ContentPlaceHolder1_txtCheque").val();
                }

            });

        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_divqual").css("display", "none");

            $("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1").change(function () {

                if ($("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1 option:selected").text() == "other") {
                    $("#ctl00_ContentPlaceHolder1_divqual").css("display", "block");
                }
                else if ($("#ctl00_ContentPlaceHolder1_ddlFQualifiaction1 option:selected").text() != "other") {
                    $("#ctl00_ContentPlaceHolder1_divqual").css("display", "none");

                }

            });

        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_mqua").css("display", "none");
            $("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1").change(function () {

                if ($("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1 option:selected").text() == "other") {
                    $("#ctl00_ContentPlaceHolder1_mqua").css("display", "block");
                }
                else if ($("#ctl00_ContentPlaceHolder1_ddlMQualifiaction1 option:selected").text() != "other") {
                    $("#ctl00_ContentPlaceHolder1_mqua").css("display", "none");

                }

            });

        });
    </script>

     <script type="text/javascript">

         function check() {

             $('input[type="text"]').keyup(function (evt) {
                 var txt = $(this).val();

                 $(this).val(txt.replace(/^(.)|\s(.)/g, function ($1) { return $1.toUpperCase(); }));
             });
             return false;
         }
</script>

 <script type="text/javascript">

     Sys.Application.add_load(check);
     </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active">New Admission</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="divstudentadno1" runat="server">
        </div>
    <asp:UpdatePanel id="up1" runat="server" UpdateMode="Conditional">

        <ContentTemplate>

            <div class="content_pane_cont input_content" id="contentPane">
                <div id="f1">

                    <a  id="imageDivLink" href="javascript:toggle5('contentDivImg', 'imageDivLink');">
                        <img id="divlink1" src="../images/Green_Minus.gif" style="padding: 13px; position: absolute;" />
                    </a>

                    <div class="header">
                        <h1>Particulars of the child
                        </h1>
                    </div>
                    <div class="bgborder" style="margin-top: -16.5px;"></div>
                    <asp:HiddenField ID="paymonthsidshide" runat="server" />
                    <asp:HiddenField ID="lblfeeid1" runat="server" />
                    <%--<asp:Label ID="lblfeeid1" runat="server"></asp:Label>--%>
                    <asp:HiddenField ID="lblfeename1" runat="server" />
                    <asp:HiddenField ID="lblfeeamout1" runat="server" />
                    <asp:HiddenField ID="lbldis1" runat="server" />
                    <asp:HiddenField ID="lblcheck1" runat="server" />
                    <asp:HiddenField ID="hdate" runat="server" />
                    <asp:HiddenField ID="lblangid" runat="server" />

                    <div id="contentDivImg" class="mainbg" style="display: block;">

                        <div id="dvp" style="float: right; margin-right: 2%;">
                            <%--<img src="/currentcode/branchpanel/images/photoimg.png" alt="" />--%>
                            <div id="dvPreview" class="user_phot_frame">

                                <div><img src="../images/9update.png" /> </div>
                                <%--  style="height: 70px; width: 236px; margin: 10px; float: left; border: 1px solid #ccc; padding: 3px; border-radius: 11px;"--%>
                            </div>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Admission Date<span style="color: Red">*</span></label>
                            <asp:DropDownList ID="ddlMonth" runat="server" Width="113px">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlDate" runat="server" Width="96px">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlYear" runat="server" Width="105px">
                                <asp:ListItem Value="1">2014</asp:ListItem>
                                <asp:ListItem Value="2">2015</asp:ListItem>
                                <asp:ListItem Value="3">2016</asp:ListItem>
                                <asp:ListItem Value="4">2017</asp:ListItem>
                                <asp:ListItem Value="5">2018</asp:ListItem>
                                <asp:ListItem Value="6">2019</asp:ListItem>
                                <asp:ListItem Value="7">2020</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="for_sigle_row_form ">
                            <label>
                                Transportation:</label>
                            <asp:RadioButtonList runat="server" ID="rtransportation" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <%--                <div class="for_sigle_row_form">
                    <label>Admission sought in: </label>
                    <asp:GridView ID="grdsounght" runat="server" GridLines="None" AutoGenerateColumns="false">

                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>

                                    <asp:CheckBox ID="chk1" runat="server"></asp:CheckBox>
                                </ItemTemplate>
                                <HeaderStyle />
                                <ItemStyle Width="20px" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblname" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Style="display: none;" Text='<%# Bind("id") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle />
                                <ItemStyle Width="100px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>--%>
                        <div class="for_sigle_row_form">
                            <label>
                                Select Admission Sought<span style="color: Red">*</span></label>
                            <asp:DropDownList ID="ddlstclass" runat="server"></asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Select Section<span style="color: Red"></span></label>
                            <asp:DropDownList ID="ddlssection" runat="server">
                                <asp:ListItem Value="0" Selected="True">--Select Section--</asp:ListItem>
                                <asp:ListItem Value="1">A</asp:ListItem>
                                <asp:ListItem Value="2">B</asp:ListItem>
                                <asp:ListItem Value="3">C</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Name<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="fname" autocomplete="off" onkeypress="return lettersOnly(event)" Style="width: 89px !important;"></asp:TextBox>

                            <asp:TextBox ID="txtmidname" runat="server" CssClass="mname" autocomplete="off" onkeypress="return lettersOnly(event)" Style="width: 93px!important;"></asp:TextBox>

                            <asp:TextBox ID="txtLName" runat="server" CssClass="lname" autocomplete="off" onkeypress="return lettersOnly(event)" Style="width: 93px!important;"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label style="padding-top: 0px;">
                                Upload student Image</label>

                            <asp:FileUpload ID="fileupload" runat="server" class="flUpload" />
                            <%-- <input id="fileupload" type="file" />--%>
                        </div>

                        <div class="for_sigle_row_form ">
                            <label>
                                Gender<span style="color: Red">*</span></label>
                            <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1" Selected="True">Male</asp:ListItem>
                                <asp:ListItem Value="0">Female</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                         <div class="for_sigle_row_form ">
                            <label>
                                Transportation:</label>
                            <asp:RadioButtonList runat="server" ID="RadioButtonList5" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Nationality<span style="color: Red">*</span></label>
                            <asp:TextBox runat="server" ID="txtFname" onkeypress="return lettersOnly(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Date of Birth<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtToDate" runat="server" onchange="CalculateAge(this)"></asp:TextBox>
                            &nbsp;(mm/dd/yy)

                <span id="lblAge"></span>
                        </div>

                        <div class="clear"></div>
                        <div class="for_sigle_row_form">
                            <label>
                                Height (in cm): <span style="color: Red"></span>
                            </label>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="fname" onkeypress="return noAlphabets(event)" Style="width: 99px !important;"></asp:TextBox>
                            &nbsp;

                   Weight (in kg):<span style="color: Red"></span><asp:TextBox ID="TextBox2" runat="server" CssClass="mname" onkeypress="return noAlphabets(event)" Style="width: 100px !important;"></asp:TextBox>
                            &nbsp
                        </div>

                        <div class="clear">
                        </div>
                        <br />
                        <div class="for_sigle_row_form red_sketch widgetpl"><span style="padding: 1%; color: #FC6620; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);font-style: italic;
    margin-left: 186px;">- - - - - - - - - Residential Address - - - - - - - - -  </span></div>

                        <div class="for_sigle_row_form">
                            <label>
                                House No:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txthouseno" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                               Society:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtappartment" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Street:</label>
                            <asp:TextBox ID="txtstreet" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Landmark: <span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtland" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                PIN/ZIP code<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8" onkeypress=" return noAlphabets(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form" style="margin-bottom: 5px;">
                            <label style="padding-top:2px;">
                                Language(s) spoken at home:</label>

                                <div style="float: left; width: 8%;">
                                    <asp:CheckBox ID="chkenglish" runat="server" />
                                    <span style="margin-left: 22px;">English  </span>
                                </div>
                                <div style="float: left; width:7%;">
                                    <asp:CheckBox ID="chkhindi" runat="server" />
                                 <span style="margin-left: 22px;">    Hindi</span>
                                </div>

                                 <div style="float: left; width: 15%;">
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                              <span style="margin-left: 22px;">   Others</span>
                                     </div>
                        </div>
                        <br />
                        <div class="clear"></div>
                        <div class="for_sigle_row_form" id="divlang" style="display: none;">
                            <label>
                                If Other please specify: :<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtlan" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <a id="A3" href="javascript:toggle5('cont123', 'A3');">
                        <img src="../images/addd11.png" style="padding: 13px; position: absolute;" />
                    </a>
                    <div class="header">
                        <h1>Particulars of Parent/Guardian
                        </h1>
                    </div>
                    <div class="bgborder" style="margin-top: -16px;"></div>

                    <div id="cont123" class="mainbg" style="display: none;">
                        <div class="for_sigle_row_form red_sketch widgetpl">
                            <span style="padding: 1%; color: rgb(58, 120, 231); text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);font-style: italic;
    margin-left: 186px;">- - - - - - - - - Father/ Guardian - - - - - - - - -
                            </span>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Name:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtfather" runat="server" onkeypress="return lettersOnly(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Qualification <span style="color: Red">*</span>
                            </label>
                            <asp:DropDownList runat="server" ID="ddlFQualifiaction1">
                            </asp:DropDownList>
                            &nbsp;
                        </div>
                        <div id="divqual" runat="server">
                            <div class="for_sigle_row_form">
                                <label>
                                    Enter Qualification : <span style="color: Red">*</span></label>
                                <asp:TextBox ID="txtqualification" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Occupation/ Profession : <span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtprofession" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Name of the Organisation :<span style="color: Red">*</span>
                            </label>
                            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Tel. No.: {STD Code}:
                            </label>
                            <asp:TextBox ID="txtpcode" runat="server" CssClass="fname" onkeypress="return noAlphabets(event)"></asp:TextBox>
                            <%--{ Res } :<span style="color: Red">*</span>--%>

                            <asp:TextBox ID="txtphoneno" runat="server" Width="245px" onkeypress="return noAlphabets(event)" placeholder="{ Res }"> </asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                {STD Code]:</label>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="fname" onkeypress="return noAlphabets(event)"></asp:TextBox>

                            <asp:TextBox ID="TextBox5" runat="server" Width="245px" placeholder="{ off }" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                <span style="color: Red">*</span>
                            </label>

                            <asp:TextBox ID="TextBox6" runat="server" Width="311px" placeholder="{ Mob }" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Email Address: <span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtemail" runat="server"></asp:TextBox>
                        </div>

                        <br />
                        <div class="for_sigle_row_form green_sketch widgetpl"><span style="padding: 1%; color: rgb(60, 193, 0); text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);font-style: italic;
    margin-left: 186px;"">- - - - - - - - - Mother/ Guardian - - - - - - - - - </span></div>

                        <div class="for_sigle_row_form">
                            <label>
                                Name:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="TextBox7" runat="server" onkeypress="return lettersOnly(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Mother Qualification: <span style="color: Red">*</span></label>
                            <asp:DropDownList runat="server" ID="ddlMQualifiaction1">
                            </asp:DropDownList>
                            &nbsp;
                        </div>
                        <div id="mqua" runat="server">
                            <div class="for_sigle_row_form">
                                <label>
                                    Enter Qualiication: <span style="color: Red">*</span></label>
                                <asp:TextBox ID="txtmqualification" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Occupation/ Profession :</label>
                            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Name of the Organisation :</label>
                            <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Tel. No.: {STD Code}:</label>
                            <asp:TextBox ID="TextBox11" runat="server" CssClass="fname" onkeypress="return noAlphabets(event)"></asp:TextBox>

                            <asp:TextBox ID="TextBox12" runat="server" Width="245px" placeholder="  { Res } " onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                {STD Code]:</label>
                            <asp:TextBox ID="TextBox13" runat="server" CssClass="fname" onkeypress="return noAlphabets(event)"></asp:TextBox>

                            <asp:TextBox ID="TextBox14" runat="server" Width="245px" placeholder=" {Off.}" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                <span style="color: Red">*</span>
                            </label>

                            <asp:TextBox ID="TextBox15" runat="server" Width="311px" placeholder=" {Mob}" onkeypress="return noAlphabets(event)"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>
                                Email Address:</label>
                            <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox>
                        </div>
                        <br />
                        <div class="for_sigle_row_form steelblue_sketch widgetpl"><span style="padding: 1%; color: rgb(246, 9, 194);font-style: italic;
    margin-left: 186px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);">- - - - - - - - - More about the Child - - - - - - - - - </span></div>
                        <div class="for_sigle_row_form">
                            <label style="padding-top: 5px;">
                                Previous Schooling:</label>
                            <asp:RadioButtonList runat="server" ID="RadioButtonList1" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div class="for_sigle_row_form" id="divprevious" style="display: none;">
                            <label>
                                If yes please specify: :<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtprevious" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label>How many siblings does the child have?: </label>

                            <asp:TextBox ID="TextBox17" runat="server" CssClass="fname1" onkeypress="return lettersOnly(event)" placeholder="Name"></asp:TextBox>

                            <asp:TextBox ID="TextBox18" runat="server" CssClass="mname" onkeypress="return noAlphabets(event)" placeholder="Age"></asp:TextBox>

                            <asp:TextBox ID="TextBox19" runat="server" CssClass="sname" onkeypress="return lettersOnly(event)" placeholder="School"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label></label>

                            <asp:TextBox ID="TextBox20" runat="server" CssClass="fname1" onkeypress="return lettersOnly(event)" placeholder="Name"></asp:TextBox>

                            <asp:TextBox ID="TextBox21" runat="server" CssClass="mname" onkeypress="return noAlphabets(event)" placeholder="Age"></asp:TextBox>

                            <asp:TextBox ID="TextBox22" runat="server" CssClass="sname" onkeypress="return lettersOnly(event)" placeholder="School"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label></label>

                            <asp:TextBox ID="TextBox23" runat="server" CssClass="fname1" onkeypress="return lettersOnly(event)" placeholder="Name"></asp:TextBox>

                            <asp:TextBox ID="TextBox24" runat="server" CssClass="mname" onkeypress="return noAlphabets(event)" placeholder="Age"></asp:TextBox>

                            <asp:TextBox ID="TextBox25" runat="server" CssClass="sname" onkeypress="return lettersOnly(event)" placeholder="School"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label style="padding-top: 0px;">
                                Has any of the child’s kin attended Little Illusions before:</label>
                            <asp:RadioButtonList runat="server" ID="RadioButtonList4" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <br />
                    </div>

                    <a id="A2" href="javascript:toggle5('contentDivImgA2', 'A2');">
                        <img src="../images/addd11.png" style="padding: 13px; position: absolute;" />
                    </a>

                    <div class="header">
                        <h1>Medical Record
                        </h1>
                    </div>
                    <div class="bgborder" style="margin-top: -16px;"></div>

                    <div id="contentDivImgA2" class="mainbg" style="display: none;">

                        <div class="for_sigle_row_form steelblue_sketch widgetpl"><span style="padding: 1%; color: rgb(0, 179, 181);font-style: italic;
    margin-left: 186px; text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);">- - - - - - - - -  Immunisation History - - - - - - - - - </span> </div>

                        <div class="for_sigle_row_form">

                            <label>Blood Group: <span style="color: Red">*</span></label>
                            <asp:DropDownList ID="ddlblood" runat="server">
                                <asp:ListItem Value="0">--Select Group--</asp:ListItem>
                                <asp:ListItem Value="1">A+</asp:ListItem>
                                <asp:ListItem Value="2">A-</asp:ListItem>
                                <asp:ListItem Value="3">B+</asp:ListItem>
                                <asp:ListItem Value="4">B-</asp:ListItem>
                                <asp:ListItem Value="5">AB+</asp:ListItem>
                                <asp:ListItem Value="6">AB-</asp:ListItem>
                                <asp:ListItem Value="7">O+</asp:ListItem>
                                <asp:ListItem Value="8">O-</asp:ListItem>
                                <asp:ListItem Value="9">A1+</asp:ListItem>
                                <asp:ListItem Value="10">A1-</asp:ListItem>
                                <asp:ListItem Value="11">A2+</asp:ListItem>
                                <asp:ListItem Value="12">A2-</asp:ListItem>
                                <asp:ListItem Value="13">A1B+</asp:ListItem>
                                <asp:ListItem Value="14">A1B-</asp:ListItem>
                                <asp:ListItem Value="15">A2B+</asp:ListItem>
                                <asp:ListItem Value="16">A2B-</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form" style="margin-left: 26%;">

                            <asp:GridView ID="grdimmuni" HeaderStyle-ForeColor="Black" runat="server" AutoGenerateColumns="false" CssClass="stm" Width="50%" Style="border-left: 1px solid #ddd;">

                                <Columns>
                                    <asp:TemplateField HeaderText="Vaccination" ControlStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:Label ID="lblname" runat="server" Text='<%# Bind("vaccination") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Age" ControlStyle-Font-Bold="true">
                                        <ItemTemplate>

                                            <asp:Label ID="lblage" runat="server" Text='<%# Bind("age") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Yes/No">
                                        <ItemTemplate>
                                            <%--<asp:Label ID="lblid" Style="display: none;" runat="server" Text='<%# Bind("id") %>'></asp:Label>--%>
                                            <asp:HiddenField ID="hd1" runat="server" Value='<%# Bind("id") %>'></asp:HiddenField>
                                            <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="200px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>

                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <RowStyle CssClass="stm_light" />
                                <AlternatingRowStyle CssClass="stm_dark" />
                            </asp:GridView>
                            <br />
                            Note:
Vaccines (1) to (7) are compulsory    &  (8) to (11) are optional, but recommended.
                        </div>
                        <br />
                        <div class="for_sigle_row_form steelblue_sketch widgetpl"><span style="padding: 1%;font-style: italic;
    margin-left: 186px; color: rgb(210, 109, 4); text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.71);">- - - - - - - - -  History of Past illness - - - - - - - - - </span> </div>
                        <br />
                        <div class="for_sigle_row_form" style="margin-left: 18%;">
                            <label>
                                Specific ailments suffered in the past:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtaliment" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form" style="margin-left: 18%;">
                            <label>
                                Surgery undergone (if any):<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtSurgery" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form" style="margin-left: 18%;">
                            <label>
                                Allergies (if any):<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtAllergies" runat="server"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form" style="margin-left: 18%;">
                            <label>
                                Is the child presently on any regular medication<span style="color: Red"></span></label>
                            <asp:RadioButtonList runat="server" ID="RadioButtonList2" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="for_sigle_row_form" style="margin-left: 18%; display: none;" id="divspecify">
                            <label>
                                If yes please specify:  :<span style="color: Red"></span></label>
                            <asp:TextBox ID="txtspecify" runat="server"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form" style="margin-left: 18%;">
                            <label>
                                Does your child suffer from any phobias:<span style="color: Red"></span></label>
                            <asp:RadioButtonList runat="server" ID="RadioButtonList3" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                <asp:ListItem Value="0" Selected="True">No</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="for_sigle_row_form" style="margin-left: 18%; display: none;" id="divsuffer">
                            <label>
                                If yes please specify: <span style="color: Red"></span>
                            </label>
                            <asp:TextBox ID="txtspecify1" runat="server"></asp:TextBox>
                        </div>
                    </div>

                    <a id="A1" href="javascript:toggle5('contentDivImgA1', 'A1');">
                        <img src="../images/addd11.png" style="padding: 13px; position: absolute;" />
                    </a>

                    <div class="header">
                        <h1>Special Instructions
                        </h1>
                    </div>
                    <div class="bgborder" style="margin-top: -16px;"></div>

                    <div id="contentDivImgA1" class="mainbg" style="display: none;">

                        <div class="for_sigle_row_form">
                            <label>
                                ANY SPECIFIC INSTRUCTIONS:<span style="color: Red"></span></label>
                            <asp:TextBox ID="txtinstruments" runat="server" TextMode="MultiLine" Width="306px"></asp:TextBox>
                        </div>

                        <div class="for_sigle_row_form">
                            <label style="width: 220px;">EMERGENCY CONTACT PERSON (OTHER THAN PARENTS): <span style="color: Red">*</span></label>

                            <asp:TextBox ID="txtname1" Width="146px" runat="server" placeholder="Name"></asp:TextBox>

                            <asp:TextBox ID="txtcontact1" runat="server" Width="146px" placeholder="Mobile No" onkeypress="return noAlphabets(event)"></asp:TextBox>
                            </div>

                        <div class="clear"></div>
                            <div class="for_sigle_row_form">
                                <label>
                                   </label>
                                <asp:TextBox ID="txtemergencyaddress1" runat="server" placeholder="max lenght is 500" TextMode="MultiLine" Width="311px" ></asp:TextBox>
                           <span id="textarea_feedback"></span>
                            </div>

                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:TextBox ID="txtname2" runat="server" Width="146px" placeholder="Name"></asp:TextBox>
                            <asp:TextBox ID="txtcontact2" Width="146px" runat="server" placeholder="Mobile No" onkeypress="return noAlphabets(event)"></asp:TextBox>
                           </div>
                            <div class="clear"></div>
                            <div class="for_sigle_row_form">
                                <label>
                                   </label>
                                <asp:TextBox ID="txtemergencyaddress2" runat="server" placeholder="max lenght is 500" TextMode="MultiLine" Width="311px" ></asp:TextBox>
                             <span id="textarea_feedback1"></span>
                            </div>

                        <br />
                        <br />

                        <div style="text-align: center; font-size: 20px; color: cadetblue;font-style: italic;
    margin-left:35px;">- - - - - - - - -  Declaration of Parent/ Guardian - - - - - - - - - </div>
                        <br />

                        <div class="declration_form_outer">
                            <div class="declration-form" style="font-size: 15px;">

                                <p>
                                    I declare that the information given by me is correct and complete
      and I have not withheld any information.
                                </p>
                                <p>
                                    I agree to entrust my child  under the care of the staff at Little Illusions
      Preschool. I shall not hold Little Illusions Preschool responsible for any
      unforeseen mishap or accident.
                                </p>
                                <p>
                                    I am aware that the fees once paid is non-transferable and
      non-refundable under any circumstances.
                                </p>
                                <p>
                                    I have read through the Little Illusions Policies and am in agreement
      with the said policies.
                                </p>

                                <div class="for_sigle_row_form" style="margin-left: 3px;">
                                    <label>
                                        Signature:
                                    </label>
                                    <asp:FileUpload ID="filesig" runat="server" CssClass="signcss" />
                                </div>

                                <div class="for_sigle_row_form" style="margin-left: 3px;">
                                    <label>
                                        Name of signee:<span style="color: Red">*</span>
                                    </label>

                                    <asp:TextBox ID="TextBox30" Width="160px" runat="server"></asp:TextBox>
                                </div>

                                <div class="for_sigle_row_form" style="margin-left: 3px;">
                                    <label>
                                        Relation to the child:<span style="color: Red">*</span>
                                    </label>

                                    <asp:TextBox ID="TextBox28" Width="160px" runat="server"></asp:TextBox>
                                </div>

                                <div class="for_sigle_row_form" style="margin-left: 3px;">
                                    <label>
                                        Date:<span style="color: Red">*</span>
                                    </label>

                                    <asp:TextBox ID="txtDate" Width="160px" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="for_sigle_row_form" style="margin-left: 21%;">
                        <label>
                        </label>
                           <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Preview" />
                        <asp:Button ID="Button6" runat="server" CssClass="view-enquiry1" Text="Pay Later" OnClick="Button6_Click" Style=" height: 33px;" />
                        <asp:Button ID="Button1" runat="server" CssClass="button_save" Text="Make Payment" Style=" height: 33px;" />
                    </div>
                </div>

                <div id="fee" style="display: none;margin-top: 14px;">

                    <div class="feestructurebox">

                          <h2 class="admissionheading">Fee Structure</h2>

                        <asp:GridView ID="grdclass" AutoGenerateColumns="false" BorderWidth="0"
                            runat="server" CssClass="stm" GridLines="None" EmptyDataText="No Month added in this branch" Style="display: none; ">
                            <Columns>

                                <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblperiod" runat="server" Text='<%#Container.DataItemIndex+1 %>' class="clslblSrNo1"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Month">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmonth" runat="server" class="clslblmonth1" Text='<%# Bind("monthname") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Fee Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfeetype" runat="server" class="clslblfeename1" Text='<%# Bind("transtype") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="70%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fee">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfee" runat="server" class="clslblfee1" Text='<%# Bind("credit") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="104.0px" />
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle  CssClass="stm_light" />
                             <AlternatingRowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>

                    <div class="setdiscounthere">

                          <h2 class="admissionheading">Set Discount Here</h2>
                        <asp:GridView ID="grdDetails" AutoGenerateColumns="false"
                            CellPadding="0" CellSpacing="0" runat="server" BorderWidth="0"
                            CssClass="stm" BorderColor="black" class="grdvw" Style="display: none;">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblperiod" runat="server" Text='<%#Container.DataItemIndex+1 %>' class="clslblSrNo"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="FeeName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFee" runat="server" Text='<%# Bind("feename") %>' class="clslblfeename"></asp:Label>
                                        <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("CFid") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="35%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Amount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>

                                        <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("fees","{0:0.00}") %>' class="clslblfeeamount"></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="20%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Set Discount" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        Rs.&nbsp;

                                    <asp:TextBox ID="txtDiscount" class="txdiscount" Width="127px"
                                        runat="server" Text="0" ToolTip="Enter the discount" Style="border-radius: 3px;padding: 5px;"></asp:TextBox>
                                        <asp:CheckBox ID="chkstatus" CssClass="chekc" style="float: right;"
                                            runat="server" ToolTip="Check if you want discount every month"></asp:CheckBox>
                                        <asp:Label ID="lblfeeid" runat="server" Style="display: none;" Text='<%# Bind("CFid") %>' class="clslblfeenamefeeid"></asp:Label>
                                        <%-- <asp:HiddenField ID="HD2" runat="server" Value='<%# Bind("CFid") %>' />--%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="45%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light" />
                            <AlternatingRowStyle CssClass="stm_dark" />
                            <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>

                    <div style="float: left; width:50%; margin-left: 34px; margin-top: 17px;">
                        <asp:GridView ID="grd1" AutoGenerateColumns="false" BorderWidth="0"
                            runat="server" CssClass="stm" GridLines="None" EmptyDataText="No Month added in this branch" Width="100%" Style="margin-top: -1px;  display: none;">
                            <Columns>

                                <asp:TemplateField HeaderText="">

                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkclass1" runat="server" CssClass="chkItem" />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="30%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Month">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmonth" runat="server" CssClass="clsmonthname2" Text='<%# Bind("monthname") %>'></asp:Label>
                                        <asp:Label ID="lblmonthid" runat="server" Style="display: none" CssClass="clsmonthid2" Text='<%# Bind("monthid") %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="30%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Paid amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPaid" runat="server" CssClass="clspay2" Text='<%# Bind("credit") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" Width="40%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="stm_dark" />
                            <AlternatingRowStyle CssClass="stm_light" />
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>

                    <br />
                    <div class="shadow1 newadmissionpay">

                    <div class="clear"></div>
                    <div class="for_sigle_row_form1" style="margin-left: 18%; padding-top: 0px;">

                        <label>
                            Payment Mode:<span style="color: Red">*</span></label>

                        <asp:DropDownList ID="ddlPayMode" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                            <asp:ListItem Value="0">--Select Payment Mode--</asp:ListItem>
                            <asp:ListItem Value="1">Cash</asp:ListItem>
                            <asp:ListItem Value="2">Bank Draft</asp:ListItem>
                            <asp:ListItem Value="3">Cheque</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="clear"></div>
                    <div id="bankdetail" runat="server" style="display: none; margin-left: 20px;">
                        <div class="for_sigle_row_form1" style="margin-left: 19%; padding-top: 0px;">
                            <label runat="server" id="ll1">
                                Bank Name:<span style="color: Red;">*</span></label>
                            <asp:TextBox runat="server" ID="txtBankName" Height="29px" Width="226px" onkeypress="ValidateAlpha()" Style="padding: 2px; margin-left: -2px;"></asp:TextBox>
                        </div>
                        <div class="clear"></div>
                        <div id="Div3" runat="server" style="margin-left: -30px;">
                            <div class="for_sigle_row_form1" style="margin-left:19%; padding-top: 0px;">
                                <label runat="server" id="ll2">
                                    Draft/Check NO:<span style="color: Red;">*</span></label>
                                <asp:TextBox runat="server" Height="29px" Width="226px" ID="txtCheque" Style="padding: 2px;"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="clear"></div>

                    <div id="Div4" runat="server" style="margin-left: 20px;">
                        <div class="for_sigle_row_form1" style="margin-left: 19%; padding-top: 0px;">
                            <label>Payable Fee:</label>
                            <asp:TextBox ID="txtpayablefee" runat="server" Height="29px" Width="220px" Enabled="false" Style="padding: 2px;">0.00</asp:TextBox>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div id="Div5" runat="server" style="margin-left: 40px;">
                        <div class="for_sigle_row_form1" style="margin-left: 20%; padding-top: 0px;">
                            <label>Amount:<span style="color: Red">*</span></label>
                            <asp:TextBox ID="txtpaimat" runat="server" Height="29px" Width="226px" onkeypress="return noAlphabets(event)" Style="padding: 2px;">0.00</asp:TextBox>
                             <asp:Label runat="server" ID="lblremain" Style="display: none; margin-left: 59px; margin-top:8px;" ForeColor="Red">Remaining Blanace:</asp:Label>
                           <asp:Label runat="server" ID="lblremainbal" ForeColor="Red" Style="display: none; margin-left: 178px; margin-top: -11px;"></asp:Label>
                        </div>
                    </div>

                    <div class="clear"></div>
                    <div class="for_sigle_row_form1" style="padding-top: 0px;margin-left:24%;">

                        <label>
                            Pay Type:<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlpaystatus" runat="server" Height="29px" Width="233px" Style="margin-left: -2px;">
                            <asp:ListItem Value="0">--Select Pay Type--</asp:ListItem>
                            <asp:ListItem Value="1">Quarterly</asp:ListItem>
                            <asp:ListItem Value="2">Monthly</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    </div>

                    <div class="clear"></div>
                    <div class="for_sigle_row_form" style="margin-left: 23%;">
                        <label>
                        </label>
                        <asp:Button ID="Button3" runat="server" CssClass="button_save" Text="Pay" OnClick="Button3_Click" />

                        <asp:Button ID="Button4" runat="server" CssClass="button_save" Text="Back" />
                    </div>
                </div>

                <div id="preview" style="display:none;">

                    <div class="shadow1" style="width: 85%; border: 2px solid #FCFAFA; padding: 5px 20px; margin: 10px auto; background: #fff;">

                        <table class="file_border bgborderpreview " cellpadding="2" cellspacing="0" border="0" style="width: 103%; background:url( images/header_bg.png)  ;  border-bottom: 1px dashed #DDDDDD; padding: 5px 20px; margin: 0 auto 0 -15px;">

                            <tr>

                                <td>

                                    <p style="text-align: center; color: #249cdd; font-size: 18px; font-weight: bold; text-align: center;">Form Preview Details</p>
                                </td>
                            </tr>
                        </table>

                        <div id="dvp1" style="border: 1px solid rgb(58, 120, 231); width: 150px; height: 100px; float: right; margin-right: 2%;">

                            <div id="dvPreview1" style="padding: 1%; float: right; margin-top: 5px;">

                                <%--<img src="/currentcode/branchpanel/images/photoimg.png" alt="" />--%>
                            </div>
                        </div>

                        <table class="file_border" cellpadding="2" cellspacing="0" border="0" style="min-width:80%;">

                            <tr>
                                <td class="frmde" style="text-align: right;">Date of Admission :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbladmissiondate" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Class :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblsought" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="frmde" style="text-align: right;">Section :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblsection1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Name of Applicant :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblappname1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Gender :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblgnder1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Nationality :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblnation" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Date of Birth :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbldob1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Height(in cm) :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblheight" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Weight(in kg) :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblweight" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">House No :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblhouseno" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Name of appartment/Building/House :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblappt" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Street :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblstreet" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Landmark :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblland" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Pincode :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblpin" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Languages Spoken at home :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbllang" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Transportation :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbltrans" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Name :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblfather1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Qualification :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblfqualification" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Occupation :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbloccupation" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Oraganisation :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lbloragF" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Telephone No(Res.) :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblFrespR" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Telephone No(Off.) :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblFresO" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Mobile No :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblfathermobile" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Father's Email :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblemaiF" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Mother's Name :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmother1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Qualifiction :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmqual" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Occupation :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmprofession" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Oraganisation :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmorg" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Telephone No(Res.) :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmotheresphone" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Telephone No(Off.) :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmotheroffp" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Mobile No :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblmobileM" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Mother's Email :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblMemail" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">

                                    <b>Previous Schooling :</b>
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="Label4" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Has any of the child’s kin attended Little Illusions before :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblateended" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Blood Group :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblbloddgroup" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">Specific ailments suffered in the past :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblaliments" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">Surgery undergone (if any) :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblsurgery" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="frmde" style="text-align: right;">Allergies (if any) :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblalergies" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td class="frmde" style="text-align: right;">Is the child presently on any regular medication
 :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblregularmedication" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">Does your child suffer from any phobias
 :
                                </td>
                                <td class="frmdelabel">

                                    <asp:Label ID="lblphobias" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">ANY SPECIFIC INSTRUCTIONS :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblnaem1" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">EMERGENCY CONTACT PERSON (OTHER THAN PARENTS) :
                                </td>
                                <td class="frmdelabel">
                                    <asp:Label ID="lblemaergencyname" runat="server"></asp:Label>
                                    <asp:Label ID="lblemaergencycontactno" runat="server"></asp:Label>
                                </td>
                            </tr>

                            <tr>

                                <td class="frmde" style="text-align: right;">Declaration of Parent/ Guardian :
                                </td>
                                <td>

                                    <p style="text-align:justify;">
                                        I declare that the information given by me is correct and complete and I have not withheld any information.

I agree to entrust my child under the care of the staff at Little Illusions Preschool. I shall not hold Little Illusions Preschool responsible for any unforeseen mishap or accident.

I am aware that the fees once paid is non-transferable and non-refundable under any circumstances.

I have read through the Little Illusions Policies and am in agreement with the said policies.
                                    </p>

                                    <p>
                                        <asp:Label ID="lblsignature" runat="server"></asp:Label>
                                    </p>
                                    <p>
                                        <asp:Label ID="lblsignaturename" runat="server"></asp:Label>
                                    </p>
                                    <p>
                                        <asp:Label ID="lblreation" runat="server"></asp:Label>
                                    </p>
                                    <p>
                                        <asp:Label ID="lbldate" runat="server"></asp:Label>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="for_sigle_row_form" style="margin-left: 26%;">
                        <label>
                        </label>
                        <asp:Button ID="Button5" runat="server" CssClass="button_save" Text="Back" />
                    </div>
                </div>

                <a href='#' id='hb-gotop' style='display:none;'><img src="../images/scrolltop.png" />
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="Button3" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>