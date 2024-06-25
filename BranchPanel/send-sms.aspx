<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="send-sms.aspx.cs" Inherits="BranchPanel_send_sms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<%--   <style type="text/css">
body {
font-family: tahoma;
}
div {
width:200px;
background-color:#FFEEDD;
border: 2px solid #ECCE8E;
padding: 5px;
text-align:center;
}
.samplecss
{
 border-radius: 10px; /*To make the corners rounded in IE*/
-moz-border-radius: 10px;/*this is for mozilla*/
-webkit-border-radius: 10px; /*chrome and other browsers*/
}
</style>--%>
  
  <%--
  <link href="ValidationEngine.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/languages/jquery.validationEngine-en.js"
    charset="utf-8"></script>
<script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/jquery.validationEngine.js"
    charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        //Attach the validate class to each RadioButton.
        $("table[id*=RadioButtonList2]").validationEngine('attach', { promptPosition: "topRight" });
        $("table[id*=RadioButtonList2] input").addClass("validate[required]");
        $("[id*=Button5]").bind("click", function () {
            if (!$("table[id*=RadioButtonList2]").validationEngine('validate')) {
                return false;
            }
            return true;
        });
    });
</script>
--%>
<style type="text/css">
.inline-rb input[type="radio"] {
    width: auto;
}

.inline-rb label {
    display: inline;
}
</style>
<div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat;
                padding-left: 21px;">Home</a></li>
            <li><a href="viewenquiry.aspx">Enquiry</a></li>
            <%--<li><a href="#">/a></li>--%>
            <li style="background: none;"><a class="active" href="enquiry.aspx">Send Enquiry</a></li>
        </ul>
         <div class="arrowt">
              <a href="viewenquiry.aspx"><img src="../images/back-button.png" src="viewenquiry.aspx" ></a>
           

        </div>
    </div>
    <div class="clear">
    </div>
    
     
   
    
    
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px;
            padding-top: 0px;" class="containerHeadline">
            Send Sms
        </div>

       
      
                 
        
     <div runat="server" id="divradio">
         <div class="for_sigle_row_form"><label> Select One<span style="color: Red">*</span></label>
       <div style="margin:0 auto; background-color: #3DB9EB
; -moz-border-radius: 100px; -webkit-border-radius: 50px; border-radius: 20px; padding:15px 15px 15px; width:250px;">
        <asp:RadioButtonList  
             ID="RadioButtonList2"  
             runat="server"  
            TextAlign="Right" Style="list-style=center" align="center"  
               RepeatDirection="Vertical" 
              >  
             <asp:ListItem Value="0">Class Wise Students</asp:ListItem>
     <asp:ListItem Value="1">Course Wise Students</asp:ListItem>
     </asp:RadioButtonList>
    
      </div>
    <div id="a" runat="server" visible="false" style="margin-left:120px;" >
     <asp:Label ID="lblmsg" runat="server" CssClass="rqd"  ></asp:Label></div>
     </div></div>

   
    <div runat="server" id="divcourse" visible="false">
     <div class="for_sigle_row_form"><label>
                Select Course<span style="color: Red">*</span></label>
     <asp:DropDownList runat="server" ID="ddlcourse"  >

    <asp:ListItem Value="0">-Select Course</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rcourse" runat="server" InitialValue="0" CssClass="rqd" ControlToValidate="ddlcourse" ErrorMessage="Please Select One" ></asp:RequiredFieldValidator>
 </div>
 </div>
 <div runat="server" id="divclass" visible="false">
  <div class="for_sigle_row_form"><label>
                Select Class<span style="color: Red">*</span></label>
 <asp:DropDownList runat="server" ID="ddlclass"  >
    <asp:ListItem Value="0">-Select Class</asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" CssClass="rqd" ControlToValidate="ddlclass" ErrorMessage="Please Select One" ></asp:RequiredFieldValidator>
</div>
</div> 

<div class="for_sigle_row_form" id="divmsg" runat="server" visible="false"><label>
                Enter Msg here<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtmsg" runat="server" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rtextmul" runat="server" ControlToValidate="txtmsg" CssClass="rqd" ErrorMessage="Please enter msg here"></asp:RequiredFieldValidator>
                </div>
                
<div class="for_sigle_row_form" runat="server" style="margin-left:290px;">
      <asp:Button ID="Button5" runat="server" Text="Next" 
        CssClass="button_save" onclick="Button5_Click"  /> 
        </div>
         <div id="Div1" class="for_sigle_row_form" runat="server" style="margin-left:230px;">
         <asp:Button ID="Button1" runat="server" Text="Reset"  Visible="false"
        CssClass="button_save" onclick="Button1_Click" CausesValidation="false" />   
         <asp:Button ID="Button2" runat="server" Text="Submit"  Visible="false"
        CssClass="button_save" onclick="Button3_Click" /> 
        </div>
</div>
</asp:Content>