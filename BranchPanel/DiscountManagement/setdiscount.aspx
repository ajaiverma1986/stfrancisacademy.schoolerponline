<%@ Page Title="Set Discount" EnableViewState="false" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="setdiscount.aspx.cs" Inherits="BranchPanel_setdiscount" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/setdiscount.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                $('#ctl00_ContentPlaceHolder1_ddl_Course').html('');
                $.ajax({
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    url: "../Student-Registration/student-registration.aspx/BindClassDDL",
                    data: "{'Fyid':'" + $(
					
					
this).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        $('#ctl00_ContentPlaceHolder1_ddl_Course').html('<option value="0">--Select Class--</option>');
                        if (data.d.length > 0) {
                            for (var i = 0; i < data.d.length; i++) {
                                $('#ctl00_ContentPlaceHolder1_ddl_Course').append('<option value="' + data.d[i].ID + '">' + data.d[i].ClassName + '</option>');
                            }
                        }
                    }
                });
            });
        });
    </script>
    <style type="text/css">
        br {
            display: none !important;
        }

        .main-div-tbl table {
            margin-left: 0px !important;
        }

        .stm {
            border: 1px solid #dddddd;
        }

        th {
            background-color: #808080;
            color: white;
        }

        #ctl00_ContentPlaceHolder1_griddiscount tr th {
            background-color: #C7C7C7 !important;
        }

        #ddlshowmonth {
            background: #fff none repeat scroll 0 0;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            margin-bottom: 0;
            outline: medium none;
            padding: 6px 5px;
            width: 100px;
        }

        .txdiscount, .cscfeepay {
            -moz-appearance: none;
            background-color: #fcfcfc;
            border: 1px solid #ccc;
            border-radius: 0;
            box-shadow: none;
            color: #676767;
            font-size: 14px;
            height: 24px;
            line-height: 20px;
            outline: medium none;
            padding: 3px 6px;
            text-align: left;
            width: 100px;
        }

        .csspayfee3 {
            Height: 30px;
            Width: 300px;
            color: red;
        }

        .clsdivcheckboxes {
            height: 100px;
            overflow-x: hidden;
            overflow-y: scroll;
            width: 214px;
            display: none;
        }

            .clsdivcheckboxes td {
                line-height: 23px;
            }

        #grdpay {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

            #grdpay td, #grdpay th {
                font-size: 1em;
                border: 1px solid #98bf21;
                padding: 3px 7px 2px 7px;
            }

            #grdpay th {
                font-size: 1.1em;
                text-align: left;
                padding-top: 5px;
                padding-bottom: 4px;
                background-color: #A7C942;
                color: #ffffff;
            }

            #grdpay tr.clsmaintr td {
                color: #000000;
                background-color: #EAF2D3;
            }

        .activeofferlist {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            color: black;
            font-size: 14px !important;
            padding-left: 25px;
            text-align: left !important;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 14px !important;
            padding-left: 10px;
            text-align: left !important;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 13px !important;
            text-align: left !important;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }

        .texthover {
            border: solid 1px red !important;
        }

        #grdpay1 {
            font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
            width: 100%;
            border-collapse: collapse;
        }

            #grdpay1 td, #grdpay th {
                font-size: 1em;
                border: 1px solid #98bf21;
                padding: 3px 7px 2px 7px;
            }

            #grdpay1 th {
                font-size: 1.1em;
                text-align: left;
                padding-top: 5px;
                padding-bottom: 4px;
                background-color: #A7C942;
                color: #ffffff;
            }

            #grdpay1 tr.clsmaintr td {
                color: #000000;
                background-color: #EAF2D3;
            }
    </style>
    <div class="content_pane_cont input_content">
        <div class="main-div-tbl">
            <div class="new-registration">
                <div id="divstudentadno1" runat="server">
                </div>
                <div class="sub-heading">
                    Set Discount
                </div>
                <div id="setdiscount" runat="server" class="divsetdis">
                    <div class="for_sigle_row_form" style="display:none">
                        <label>
                            Admission No.</label>
                        <asp:TextBox ID="txtadmissionno" runat="server" CssClass="checkadmissionno" Placeholder="Enter Valid Admission No If Exists"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Registration No.</label>
                        <asp:TextBox ID="txtRegNo" runat="server" CssClass="checkreg" Placeholder="Enter Valid Registration If Exists"></asp:TextBox>
                        <asp:HiddenField ID="hfrid" runat="server" Value='<%# Bind("rid") %>' />
                        <asp:Label runat="server" ID="lblmsg" ForeColor="Chocolate" Width="150px" Style="margin-left: 30px !important;"></asp:Label>
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Select Session<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddlfinancialyear" runat="server">
                        </asp:DropDownList>
                    </div>
                    <div class="sub-heading">
                        Applicant Details
                    </div>

                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            First Name<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtName" runat="server" onkeypress="return lettersOnly(event)" placeholder="Enter First Name Please"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Middle Name</label>
                        <asp:TextBox ID="txtmidname" runat="server" onkeypress="return lettersOnly(event)" placeholder="Enter Middle Name Please"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Last Name</label>
                        <asp:TextBox ID="txtLName" runat="server" onkeypress="return lettersOnly(event)" placeholder="Enter Last Name Please"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Date of Birth<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtToDate" runat="server" placeholder="Select Date Of Birth Please"></asp:TextBox>
                        <span id="lblAge"></span>
                    </div>
                    <div class="clear"></div>
                    <div class="sub-heading">
                        Applicant Parent Details
                    </div>
                    <div class="clear"></div>
                    <div class="for_sigle_row_form">
                        <label>
                            Parent First Name<span style="color: Red">*</span></label>
                        <asp:TextBox runat="server" ID="txtFname" onkeypress="return lettersOnly(event)" placeholder="Enter Parent First Name"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Parent Middle Name</label>
                        <asp:TextBox runat="server" ID="txtPmidname" onkeypress="return lettersOnly(event)" placeholder="Enter Parent First Name"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Parent Last Name</label>
                        <asp:TextBox runat="server" ID="txtPlastname" onkeypress="return lettersOnly(event)" placeholder="Enter Parent First Name"></asp:TextBox>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                            Parent Mobile No.<span style="color: Red">*</span></label>
                        <asp:TextBox runat="server" ID="txtmob" onkeypress="return noAlphabets(event)" placeholder="Enter Parent Mobile No"></asp:TextBox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Address<span style="color: Red">*</span></label>
                        <asp:textbox id="txtPAddress" runat="server" textmode="MultiLine" placeholder="Enter Parent Address Please"></asp:textbox>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Applying for Class<span style="color: Red">*</span></label>
                        <asp:DropDownList ID="ddl_Course" runat="server">
                        </asp:DropDownList>
                        <asp:Label runat="server" ID="lbclassname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                        <asp:Label runat="server" ID="lbclmsg" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                        <asp:Label runat="server" ID="lbclssname" ForeColor="Chocolate" Text="" Style="display: none;"></asp:Label>
                    </div>
                    <div class="sub-heading">
                        Manage Discount
                    </div>
                    <div id="Container">
                    </div>
                    <div class="sub-heading">
                        Toatl Payable Amount
                    </div>
                    <span id="Span1" style="color: green; font-weight: bold; margin-left: 220px;"></span>
                    <span id="totalfee" style="color: green; font-weight: bold; margin-left: 147px; padding-right: 40px;"></span>
                    <span id="spandiscount" style="color: red; font-weight: bold; margin-left: 417px; padding-right: 190px;"></span>
                    <span id="Span2" style="color: red; margin-right: -2000000px; margin-left: -57px;"></span>
                    <div class="for_sigle_row_form">
                        <label>
                            Discount Date<span style="color: Red">*</span></label>
                        <asp:TextBox ID="txtDate" runat="server" onkeypress="return false" placeholder="Select Discoun Date"></asp:TextBox>
                        <span id="Span3"></span>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Comment/Remark</label>
                        <asp:TextBox ID="txtcommentorremark" runat="server" placeholder="Enter Comment/Remark Please" TextMode="MultiLine"></asp:TextBox>
                        <span id="Span4"></span>
                    </div>
                    <div class="for_sigle_row_form" style="margin-bottom: 20px">
                        <label>
                        </label>
                        <asp:Button ID="Button2" runat="server" CssClass="button_save" Text="Set Discount" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>