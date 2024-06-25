<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="expense-manager.aspx.cs" Inherits="BranchPanel_Expence_Management_expense_manager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script type="text/javascript">
         function checkDec(el) {
             var ex = /^[0-9]+\.?[0-9]*$/;
             if (ex.test(el.value) == false) {
                 el.value = el.value.substring(0, el.value.length - 1);
             }
         }
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
         function ShowpImagePreview(input) {
             if (input.files && input.files[0]) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $('#ctl00_ContentPlaceHolder1_imguser').attr('src', e.target.result);
                 }
                 reader.readAsDataURL(input.files[0]);
             }
         }
    </script>
    <script type="text/javascript">
        function valid() {
            if (document.getElementById('<%=ddltitle.ClientID %>').value == 0) {
                alert("Select Category Please.");
                document.getElementById('<%=ddltitle.ClientID %>').focus();
                return false;
            }
            var ddl = document.getElementById("<%=ddltitle.ClientID%>");
            var SelVal = ddl.options[ddl.selectedIndex].text;
            if (SelVal == "other") {
                if (document.getElementById('<%=txtdetails.ClientID %>').value.trim() == "") {
                    alert("Enter Details Please.");
                    document.getElementById('<%=txtdetails.ClientID %>').focus();
                     return false;
                 }
             }
             if (document.getElementById('<%=txtToDate.ClientID %>').value.trim() == "") {
                alert("Select Date Please.");
                document.getElementById('<%=txtToDate.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtAmount.ClientID %>').value.trim() == "") {
                alert("Enter Amount Please.");
                document.getElementById('<%=txtAmount.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtdescription.ClientID %>').value.trim() == "") {
                alert("Enter Descriptiopn Please.");
                document.getElementById('<%=txtdescription.ClientID %>').focus();
                return false;
            }
        }
        $(document).ready(function () {
            var amount = 0, taxservice = 0, total = 0, year = 2015;
            $("#ctl00_ContentPlaceHolder1_txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1970:' + year,
                dateFormat: 'dd MM yy'
            });
            $('#ctl00_ContentPlaceHolder1_buttonclear').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddltitle').val('0');
                $('#ctl00_ContentPlaceHolder1_txtToDate,#ctl00_ContentPlaceHolder1_txtAmount,#ctl00_ContentPlaceHolder1_txtservicetax,#ctl00_ContentPlaceHolder1_txtincludingtax,#ctl00_ContentPlaceHolder1_txtdescription,#ctl00_ContentPlaceHolder1_fileuploadExcel').val('');
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddltitle').change(function () {
                if ($(this).val() == 7) {
                    $('#ctl00_ContentPlaceHolder1_divtitle').css("display", "block");
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_divtitle').css("display", "none");
                }
            });
            $('#ctl00_ContentPlaceHolder1_txtAmount,#ctl00_ContentPlaceHolder1_txtservicetax').keyup(function () {
                amount = $('#ctl00_ContentPlaceHolder1_txtAmount').val();
                taxservice = $('#ctl00_ContentPlaceHolder1_txtservicetax').val();
                if (amount == '')
                    amount = '0.00';
                if (taxservice == '')
                    taxservice = '0.00';
                $('#ctl00_ContentPlaceHolder1_txtincludingtax').val(parseFloat(parseFloat(amount) + parseFloat(taxservice)).toFixed(2));
            });
        });
    </script>

     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
         <div  class="clear"></div>

      <div class="tbl-top-heading">
        <h2>Expense Manager</h2>
    </div>
    <div class="clear"></div>
                                        
    <div class="new-registration pull-left">
                <div class="for_sigle_row_form">
                    <label>
                        Select Category <span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddltitle" runat="server"></asp:DropDownList>
            </div>
                 <div class="for_sigle_row_form" id="divtitle" style="display:none" runat="server">                     
                    <label>
                        Enter Details <span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtdetails" runat="server" placeholder="Enter The Details About Other Category"></asp:TextBox>&nbsp;             
                      </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Date <span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtToDate" runat="server" ReadOnly="true" onkeypress="return noAlphabets(event)" placeholder="Select Date Please"></asp:TextBox>&nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Enter Amount<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtAmount" runat="server" onkeypress="return noAlphabets(event)" onkeyup="checkDec(this);" MaxLength="6" placeholder="Enter Amount Please"></asp:TextBox>
                </div>
                       <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label>Enter VAT & TAX</label>
                    <asp:TextBox ID="txtservicetax" runat="server" onkeypress="return noAlphabets(event)" onkeyup="checkDec(this);" MaxLength="6" placeholder="Enter Service Tax Please"></asp:TextBox>
                </div>
                    <div class="clear"></div>
                 <div class="for_sigle_row_form">
                    <label>Total Amount</label>
                    <asp:TextBox ID="txtincludingtax" runat="server" ReadOnly="true" onkeypress="return noAlphabets(event)" placeholder="0.00" onkeyup="checkDec(this);" ></asp:TextBox>
                </div>          
                       <div class="clear"></div>
                        <div class="for_sigle_row_form">
                    <label>Description <span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtdescription" runat="server" TextMode="MultiLine" placeholder="Enter Description Please"></asp:TextBox>
                </div>
                     <div class="clear"></div>
                    <div class="for_sigle_row_form">
                            <label style="margin-top: 4px !important">
                                Upload Attachment</label>
                         <asp:Label ID="lbltopic"  Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label>                              
                            <asp:FileUpload ID="fileuploadExcel" runat="server"  ToolTip="Select"  onchange="ShowpImagePreview(this);" />   
                        </div>
                     <div class="clear"></div>
                <div class="for_sigle_row_form">
                    <label>
                    </label>
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" ToolTip="Click here to add this expense." OnClientClick="return valid() ; " CssClass="button_save"  Style="padding-top: 4px; padding-bottom: 4px;"></asp:Button>&nbsp;
                    <asp:Button ID="buttonclear" runat="server" Text="Clear" ToolTip="Click here for clear" CssClass="button_cancel" />
                   <asp:Button ID="btnclear" runat="server" Text="cancel" OnClick="btnclear_Click1" ToolTip="Click here for cancel" CssClass="button_cancel" Visible="false"  Style="padding-top: 4px; padding-bottom: 4px;"></asp:Button>                 
                </div>
                    </div>       
   <div id="divbgcolorforlogo" class="navbar-header aside-md expense-image-sty pull-right" style="background: #25405D;">
                    <div class="user_phot_frame">
                              <asp:Image ID="imguser" runat="server" ImageUrl="~/images/9update.png"  AlternateText="No Attachment" Height="170px" Style="position: absolute"/>
                        </div>     
                    </div>   
          
        <div  class="clear"></div>
    </div>
</asp:Content>

