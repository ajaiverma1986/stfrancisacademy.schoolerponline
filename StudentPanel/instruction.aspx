<%@ Page Language="C#" AutoEventWireup="true" CodeFile="instruction.aspx.cs" Inherits="StudentPanel_instruction" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/jquery-1.8.2.min.js"></script>
    <style type="text/css">
        #loader {
            position: relative;
            top: 10%;
        }

        .progress {
            display: none;
        }

        .progressAdd {
            display: block;
            position: fixed;
            background: -moz-linear-gradient(center top, #fff, #fff) repeat scroll 0 0 rgba(0, 0, 0, 0);
            z-index: 2147483647 !important;
            opacity: 0.8;
            overflow: hidden;
            text-align: center;
            top: 0;
            left: 0;
            height: 100%;
            vertical-align: middle;
            width: 100%;
            padding-top: 20%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; padding: 10px; background-color: #808080"><span style="color: white; font-weight: bold">Read All Instruction Carefully</span> </div>
        <div class="InstructionContent" runat="server">
        </div>
        <div style="margin-left: 20px">
            <input type="checkbox" runat="server" id="inputconfirminstruction" /><label>Check If You Read All Instruction Carefully</label>
            <br />
            <br />
            <input type="submit" runat="server" value="Next" id="BtnAccept" />
            <input type="submit" runat="server" value="Go Home" id="BtnBack" />
        </div>
        <div id="divProgressBar" class="progress"></div>
    </form>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        BindInstruction();
        $('#BtnAccept').click(function () {
            if ($('#inputconfirminstruction').prop('checked')) {
                $(this).css("display", "none");
                window.open("exam.aspx", "popupWindow", "width=1366px,height=768px,scrollbars=yes");               
            }
            else {
                alert('Please Read All Instruction Carefully Before The Attempt.');
                return false;
            }
        });
        $('#BtnBack').click(function () {
            window.location.href = "my-test.aspx";
            return false;
        });
    });
    function call_progressbar(progtype) {
        if (progtype == "start") {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
            $("#divProgressBar").addClass("progressAdd");
        }
        if (progtype == "end") {
            $("#divProgressBar").find("#loader").remove();
            $("#divProgressBar").removeClass("progressAdd");
        }
    }
    function BindInstruction() {
        var AllInstruction = '<ul>';
        call_progressbar('start')
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "instruction.aspx/BindInstructionByJs",
            data: "{}",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d.length > 0) {
                    for (var i = 0; i < data.d.length; i++) {
                        AllInstruction = AllInstruction + '<li>' + data.d[i].Instruction + '</li>'
                    }
                }
                AllInstruction = AllInstruction + '</ul> ';
                $('.InstructionContent').html(AllInstruction);
                call_progressbar("end");
            },
            error: function (response) {
                alertify.error('Some Internel Error Occur Instruction Is Binding.')
                call_progressbar("end");
            }
        });
    }
</script>
</html>