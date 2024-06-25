<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="~/BranchPanel/transportmanagment/transportation-master-setting.aspx.cs" Inherits="BranchPanel_transportation_master_setting" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        th {
            border-bottom: 1px solid #CDCDCD !important;
        }
        .stm1 td {
            text-align: center;
            border-top: 0px;
        }
        input[type="text"], select, input[type="Password"] {
        }
        .stm1 {
            border-right: 1px solid #ddd;
            padding-bottom: 0px !important;
        }
        .inputtopictime {
            margin-bottom: 10px;
        }
        .showpopuparea, .showpopupBlock, .showpopupAddRoad, .showpopupAddStoppage {
            position: fixed;
            border-radius: 5px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: rgb(0, 0, 0);
            font-family: sans-serif;
            left: 50%;
            opacity: 1;
            max-height: 480px;
            display: block;
            overflow: auto;
            padding-bottom: 8px !important;
            top: 15%;
            width: 500px !important;
            margin-left: -250px !important;
        }   
        .showpopup2 span {
            float: right;
            padding-left: 0;
            height: 1px;
            width: 1px;
        }
  .showpopup2 .for_sigle_row_form input[type="text"] {
    height: 24px;
    width: 228px;
  } 
        .t1 {
        }
        .t2 {
        }
            .t2 input {
                float: left;
                margin-top: 10px;
            }
            .t2 select {
                float: left;
                margin-top: 10px;
            }
    </style>
 <div class="content_pane_cont input_content branch-div-tbl" id="contentPane" >
          <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;" class="tbl-top-heading">
              <h2>Region Master</h2>
        </div>
      <div class="for_sigle_row_form" id="searcharea">
           <asp:DropDownList ID="ddlsearchingcity" runat="server" style="width:150px" CssClass="srchcityswhd"></asp:DropDownList>
          <asp:TextBox ID="txtsearchbyarea" onkeypress="return lettersOnly(event)" MaxLength="20" runat="server" placeholder="Search By Area Name" style="margin-left:5px;width:150px;"></asp:TextBox>&nbsp; 
          <input id="ImageButton1" class="btnclear" type="image" style="width:25px;" src="../../images/clearsearch.png" title="Click Here For Reset The Search."/> 
          <input type="submit" class="button_save backtransport" value="Back" style="float:right;display:none"/>   
          <input type="submit" class="button_save backtranssecgrd" value="Back" style="float:right;display:none" />  
          <input type="submit" class="button_save backtranslast" value="Back" style="float:right;display:none" />                
    </div>
      <div class="divforstm bindtrans">
                <table class="stm bindareatype" style="width: 100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width: 2%;">S.No.</th>
                        <th align="center" scope="col" style="width: 12%">City</th>
                        <th align="center" scope="col" style="width: 12%">Area<a class="addarea1" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                        <th align="center" scope="col" style="width: 3%;">Block<a class="addBlockontheBehalfofthecityarea" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                    </tr>
                </table>
            </div>
    <div class="divforstm bindroadtype" id="rdtype" style="display:none">
                <table class="stm bindroadtypess" style="width: 100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width: 3%;">S.No.</th>
                        <th align="center" scope="col" style="width: 12%">City</th>
                        <th align="center" scope="col" style="width: 12%">Area</th>
                        <th align="center" scope="col" style="width: 8%;">Block<a class="addBlockontheBehalfofthecityarea" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                        <th align="center" scope="col" style="width: 8%;">Road<a class="addotherRoadbyheader" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                    </tr>
                </table>
            </div>
    <div class="divforstm bindstgtype" id="stgtype" style="display:none">
                <table class="stm bindstoppagetype" style="width: 100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width: 3%;">S.No.</th>
                        <th align="center" scope="col" style="width: 12%">City</th>
                        <th align="center" scope="col" style="width: 12%">Area</th>
                        <th align="center" scope="col" style="width: 8%;">Block</th>
                        <th align="center" scope="col" style="width: 5%;">Road</th>
                        <th align="center" scope="col" style="width: 5%;">Stoppage<a class="addotherStoppagebyheader" style="cursor:pointer;margin-left:10px;">(Add)</a></th>
                    </tr>
                </table>
            </div>

     <div class="divforstm bindStoppagegtype" id="DivForStpg" style="display:none">
                <table class="stm bindstoppage" style="width: 100%">
                    <tr class="stm_head" align="center">
                        <th align="center" scope="col" style="width: 3%;">S.No.</th>
                        <th align="center" scope="col" style="width: 12%">City</th>
                        <th align="center" scope="col" style="width: 12%">Area</th>
                        <th align="center" scope="col" style="width: 8%;">Block</th>
                        <th align="center" scope="col" style="width: 5%;">Road</th>
                        <th align="center" scope="col" style="width: 5%;">Stoppage</th>
                    </tr>
                </table>
            </div>


         <div id="divaddarea" style="text-align: center; display: none;" class="">
            <div class="">
               <table class="showpopuparea showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="4" class="pop-headng-sty">Add Area
                            <a id="BtnCancelArea" title="Close this from here"
                                class="btnClose">
                                <img src="../../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form" id="cityshow">
                        <td class="lblcity">
                            <label>Select City:<span style="color: red">*</span></label>
                        </td>
                        <td class="ddlct">
                            <asp:DropDownList ID="ddlclassforaddcity" runat="server"></asp:DropDownList>
                        </td>
                        <td>
                           <a style="cursor:pointer;margin-left:2px;color:blue" runat="server" ID="addothecity">(Add)</a>
                        </td>
                        <td>
                             <a style="cursor:pointer;margin-left:10px;display:none;color:red;float:right" runat="server" ID="Cancelcity">Cancel</a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form" style="display:none" id="othercity">
                        <td class="t1">
                            <label>
                                Add Other City:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="addothercity" runat="server" placeholder="City Name Please." style="display:none"></asp:TextBox>
                        </td>
                      </tr>
                      <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Area Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="txtareaname" runat="server" placeholder="Area Name Please."></asp:TextBox>
                        </td>
                      </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>Block Name:</label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="txtBlockAddname" runat="server" placeholder="Block Name Please." CssClass="inputfortxtBlock"></asp:TextBox>
                            <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgfroaddBlock"/>
                        </td>
                      </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="BtnSubmitdata" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
       <div id="divaddBlock" style="text-align: center; display: none;" class="">
            <div class="">
                <table class="showpopupBlock showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="4" class="pop-headng-sty">Add Block
                            <a id="A1" title="Close this from here"
                                class="btnClose btnCloseBlock">
                                <img src="../../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form" id="Tr1">
                        <td class="t1">
                            <label>City:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="othercities" runat="server" CssClass="ddlcity"></asp:DropDownList>
                        </td>
                    </tr>
                   <tr class="for_sigle_row_form" id="Tr2">
                        <td class="t1">
                            <label>Area:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="otherarea" runat="server" CssClass="ddlarea"></asp:DropDownList>
                        </td>
                    </tr>
                      <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                               Block Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="othertxtBlock" runat="server" placeholder="Block Name Please." CssClass="othertxtBlock"></asp:TextBox>
                            <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgfroaddBlockother"/>
                        </td>
                      </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="addroadbutton" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
     <div id="divforAddRoad" style="text-align: center; display: none;" class="">
            <div class="">
                <table class="showpopupAddRoad showpopup2" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="4" class="pop-headng-sty">Add Road
                            <a id="A2" title="Close this from here"
                                class="btnClose btnCloseRoad">
                                <img src="../../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form" id="Tr3">
                        <td class="t1">
                            <label>City:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="DDLCityForAddRoad" runat="server" CssClass="ShowCityDDLForAddRoad"></asp:DropDownList>
                        </td>
                    </tr>
                   <tr class="for_sigle_row_form" id="Tr4">
                        <td class="t1">
                            <label>Area:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="DDLAreaForAddRoad" runat="server" CssClass="ShowAreaDDLForAddRoad"></asp:DropDownList>
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form" id="Tr5">
                        <td class="t1">
                            <label>Block:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="DDLBlockForAddRoad" runat="server" CssClass="ShowBlockDDLForAddRoad"></asp:DropDownList>
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Road Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="AddRoadName" runat="server" placeholder="Road Name Please." CssClass="AddRoadName"></asp:TextBox>
                            <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgfroaddRoad" />
                        </td>
                      </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
      <div id="divForAddAndShowStoppage" style="text-align: center; display: none;" class="">
                <table class="showpopupAddStoppage showpopup2" width="100%" style="background-color: white; vertical-align: top">
                    <tr>
                        <td colspan="4" class="pop-headng-sty">Add Stoppage
                            <a id="A3" title="Close this from here"
                                class="btnClose btnClosestopg">
                                <img src="../../images/popupcross.png"></a>
                        </td>
                    </tr>
                    <tr class="for_sigle_row_form">
                        <td>
                            <label>City:<span style="color: red">*</span></label>
                        </td>
                        <td >
                            <asp:DropDownList ID="DropDownListCity" runat="server" CssClass="ShowCityDDLForAddStoppage"></asp:DropDownList>
                        </td>
                    </tr>
                   <tr class="for_sigle_row_form">
                        <td>
                            <label>Area:<span style="color: red">*</span></label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownListArea" runat="server" CssClass="ShowAreaDDLForAddStoppage"></asp:DropDownList>
                        </td>
                    </tr>
                     <tr class="for_sigle_row_form">
                        <td>
                            <label>Block:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="DropDownListBlock" runat="server" CssClass="ShowBlockDDLForAddStoppage"></asp:DropDownList>
                        </td>
                     </tr>
                    <tr class="for_sigle_row_form">
                        <td>
                            <label>Road:<span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:DropDownList ID="DropDownListRoad" runat="server" CssClass="ShowRoadDDLForAddStoppage">
                                <asp:ListItem value="0">--Select Road--</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                     </tr>
                     <tr class="for_sigle_row_form">
                        <td class="t1">
                            <label>
                                Stoppage Name:
                            <span style="color: red">*</span></label>
                        </td>
                        <td class="t2">
                            <asp:TextBox ID="txtaddStoppage" runat="server" placeholder="Stoppage Name Please." CssClass="AddStopgName"></asp:TextBox>
                            <img src="../../images/add.png" style="width: 16px; margin-top: 17px; cursor: pointer;" alt="No Image" class="imgfroaddstopage" />
                        </td>
                      </tr>
                    <tr class="for_sigle_row_form">
                        <td></td>
                        <td align="left">
                            <asp:Button ID="Button2" runat="server" Text="Submit" CssClass="button_save" style="margin-top:10px;"/>
                        </td>
                    </tr>
                </table>
        </div>
     <div id="divProgressBar" class="progress"></div>
     </div>
    <script type="text/javascript">    
        var allareaname = '', allstoppagename = '', AllBlockNmaes = '', AllRoadNames = '', allStopsnames = '', searcharea = '', selectcityid = 0, idtype = 0;
        var ctyids = 0, areid = 0, BlockID = 0, searchcity = 0, ctid = 0, ChangeBlockiId = 0;
        var cityids = 0, areaidforupdt = 0, Blockupdateid = 0, changecityid = 0, changeareaid = 0, changcityname = 0;
        var ctyid = 0, aridtype = 0;
        var RdCityID = 0, RDAreaId = 0, RdBlockId = 0, RdRoadId = 0; 
        $(document).ready(function () {      
            BindGrid();
            Bindcitysearchddl()
            $('.btnclear').click(function () {
                $('#ctl00_ContentPlaceHolder1_ddlsearchingcity').val('0')
                $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').val('');
                searchcity = $('#ctl00_ContentPlaceHolder1_ddlsearchingcity').val();
                searcharea = $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').val();
                BindGrid();
                return false;
            });
            $('.addarea1').click(function () {
                $('#divaddarea').show();
                $('#ctl00_ContentPlaceHolder1_ddlclassforaddcity').val('0');
                $('#ctl00_ContentPlaceHolder1_addothercity').val('');
                $('#ctl00_ContentPlaceHolder1_txtareaname').val('');
                $('.lblcity').show();
                $('.ddlct').show();
                $('#ctl00_ContentPlaceHolder1_addothecity').show();
                $('#ctl00_ContentPlaceHolder1_Cancelcity').hide();
                $('#ctl00_ContentPlaceHolder1_txtBlockAddname').val('');
                $('#othercity').hide();
                allareaname = '';
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                return false;
            });
            $('#BtnCancelArea').click(function () {
                var lasttroftable = $('.showpopuparea').find('tbody').find('tr:last').prop('outerHTML');
                $('#divaddarea').hide(500);
                $('#divaddarea').find('table tr:gt(4)').remove();
                $('#divaddarea .showpopuparea').append(lasttroftable);
                $('#divaddarea').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });            
            $('#ctl00_ContentPlaceHolder1_addothecity').click(function () {
                $('#ctl00_ContentPlaceHolder1_addothercity').css('display', 'block');
                $('#ctl00_ContentPlaceHolder1_addothecity').hide();
                $('#ctl00_ContentPlaceHolder1_Cancelcity').show();
                $('.lblcity').hide();
                $('.ddlct').hide()
                $('#othercity').show(700);
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_Cancelcity').click(function () {
                $('#ctl00_ContentPlaceHolder1_addothercity').css('display', 'none');
                $('.lblcity').show();
                $('.ddlct').show()
                $('#ctl00_ContentPlaceHolder1_addothecity').show();
                $('#ctl00_ContentPlaceHolder1_Cancelcity').hide();
                $('#othercity').hide(200);
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_othercities').live('change',function () {
               changecityid = $(this).val();
               changcityname = $('#ctl00_ContentPlaceHolder1_othercities').val()
               Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
               return false;
           });
            $('#ctl00_ContentPlaceHolder1_DDLCityForAddRoad').change(function () {
              changecityid = $(this).val();
              Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
          return false;
           });
            $('#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad').change(function () {
               changeareaid = $(this).val();
               Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
              return false;
            });
            $('#ctl00_ContentPlaceHolder1_DropDownListCity').change(function () {
                changecityid = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_DropDownListArea').change(function () {
                changeareaid = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_DropDownListBlock').change(function () {
                ChangeBlockiId = $(this).val();
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlclassforaddcity').change(function () {
                selectcityid = $(this).val();
                if (selectcityid > 0) {
                    $('#ctl00_ContentPlaceHolder1_addothecity').hide();
                    return false;
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_addothecity').show();
                    return false;
                }
                return false;
            });
            $('.addotherRoadbyheader').click(function () {
                $('#divforAddRoad').show(500);
                $('#ctl00_ContentPlaceHolder1_DDLCityForAddRoad').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_DDLCityForAddRoad').val('0');
                $('#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad').val('0');
                $('#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad').val('0');
                $('.AddRoadName').val('');
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                ctyids = 0, areid = 0, BlockID = 0, changeareaid = 0, changeareaid = 0;
                AllRoadNames = '';
                return false;
            });
            $('.imgfroaddBlock').click(function () {              
                var lasttroftable = $('.showpopuparea').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopuparea').find('tbody').find('tr:last').remove();
                var trforadd = '<tr class="for_sigle_row_form"><td class="t1"><div><div style=""><label>Block Name:</label></div></div></td><td class="t2"><div><div style="float: left; "><input  type="text" class="inputfortxtBlock"  placeholder="Block Name Please." ><img class="imageforRomoveBlock" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px; margin-top:17px;" src="../../images/minus.png"></div></div></td></tr>'
                $('#divaddarea .showpopuparea').append(trforadd);
                $('#divaddarea .showpopuparea').append(lasttroftable);
                return false;
            });
            $('.imgfroaddBlockother').click(function () {
                var lasttroftableRoad = $('.showpopupBlock').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopupBlock').find('tbody').find('tr:last').remove();
                var trforadd = '<tr class="for_sigle_row_form"><td class="t1"><div><div style=""><label>Block Name:</label></div></div></td><td class="t2"><div><div style="float: left; "><input  type="text" class="othertxtBlock"  placeholder="Block Name Please." ><img class="imageforotherRemoveBlock" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px; margin-top:17px;" src="../../images/minus.png"></div></div></td></tr>'
                $('#divaddBlock .showpopupBlock').append(trforadd);
                $('#divaddBlock .showpopupBlock').append(lasttroftableRoad);
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_BtnSubmitdata').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlclassforaddcity').val() == ('0') && $('#ctl00_ContentPlaceHolder1_addothercity').val() =='')
                {
                    alertify.error('Enter the City name');
                    return false;
                }
               else if ($('#ctl00_ContentPlaceHolder1_txtareaname').val() == '') {
                    alertify.error('Please Enter Area Name')
                    return false;
                }
                else {
                   $('.showpopuparea').find('tr').find('td,.inputfortxtBlock').each(function () {
                        if ($(this).val() != "") {
                            allareaname = allareaname + '~' + $(this).val();
                        }
                    });
                   
                    allareaname = allareaname.slice(1, allareaname.length);
                    allareaname = allareaname.split("'").join("`")
                    SaveTransPortation(allareaname)
                    BindGrid();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_addroadbutton').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_othercities').val() == '0') {
                    alertify.error('Please Select City')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_otherarea').val() == '0') {
                    alertify.error('Please Select Area')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_othertxtBlock').val() == '') {
                    alertify.error('Please Enter Block Name')
                    return false;
                }
                else {
                    $('.showpopupBlock').find('tr').find('td,.othertxtBlock').each(function () {
                        if ($(this).val() != "") {
                            AllBlockNmaes = AllBlockNmaes + '~' + $(this).val();
                        }
                    });
                    AllBlockNmaes = AllBlockNmaes.slice(1, AllBlockNmaes.length);
                    AllBlockNmaes = AllBlockNmaes.split("'").join("`")
                    SaveBlock(AllBlockNmaes)
                    BindGrid();
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_Button2').live('click', function () {
                if ($('#ctl00_ContentPlaceHolder1_DropDownListCity').val() == '0') {
                    alertify.error('Please Select City')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_DropDownListArea').val() == '0') {
                    alertify.error('Please Select Area')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_DropDownListBlock').val() == '0') {
                    alertify.error('Please Select Block')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_DropDownListRoad').val() == '0') {
                    alertify.error('Please Enter Road Name')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_txtaddStoppage').val() == '') {
                    alertify.error('Please Enter Stoppage Name')
                    return false;
                }
                else {
                    $('.showpopupAddStoppage').find('tr').find('td,.AddStopgName').each(function () {
                        if ($(this).val() != "") {
                            allStopsnames = allStopsnames + '~' + $(this).val();
                        }
                    });
                    allStopsnames = allStopsnames.slice(1,allStopsnames.length);
                    allStopsnames = allStopsnames.split("'").join("`")
                    SaveStoppage(allStopsnames)
                    BindRoadDetailsGrid(ctyids, areid, BlockID)
                }
                return false;
            });
            $('.AddStoppage').live('click', function () {
                allStopsnames = '';
                $('#divForAddAndShowStoppage').show(500);
                RdCityID = $(this).parent('td').parent('tr').find('input[id*=RdCityId]').val();
                RDAreaId = $(this).parent('td').parent('tr').find('input[id*=RdAreadId]').val();
                RdBlockId = $(this).parent('td').parent('tr').find('input[id*=RdBlockId]').val();
                RdRoadId = $(this).parent('td').parent('tr').find('input[id*=RealROadid]').val();
                Bindalltypeddlcon()
                $('.ShowCityDDLForAddStoppage').val(RdCityID);
                $('.ShowAreaDDLForAddStoppage').val(RDAreaId);
                $('.ShowBlockDDLForAddStoppage').val(RdBlockId);
                $('.ShowRoadDDLForAddStoppage').val(RdRoadId);
                $('.ShowCityDDLForAddStoppage').attr('disabled', true)
                $('.ShowAreaDDLForAddStoppage').attr('disabled', true)
                $('.ShowBlockDDLForAddStoppage').attr('disabled', true)
                $('.ShowRoadDDLForAddStoppage').attr('disabled', true)
                Bindalltypeddlcon()
                return false;
            });
            $('.AddBlockName').live('click', function () {
                changecityid = 0, changeareaid = 0;
                ctid = $(this).parent('td').parent('tr').find('input[id*=cityid]').val();
                idtype = $(this).parent('td').parent('tr').find('input[id*=areasid]').val();
                Bindalltypeddlcon()
                $('#divaddBlock').show(500);
                $('.ddlcity').val(ctid)
                $('.ddlarea').val(idtype);
                $('.ddlcity').attr('disabled', true)
                $('.ddlarea').attr('disabled', true)
                $('.srchcityswhd').show(500);
                AllBlockNmaes = '';
                ctid = 0, idtype = 0;
                return false;
            });
            //$('.AddBlockName').live('click', function () {
            //    ctyid = $(this).parent('td').parent('tr').find('input[id*=cityid]').val();
            //    aridtype = $(this).parent('td').parent('tr').find('input[id*=areasid]').val();
            //    $('.bindtrans').hide(500);
            //    $('.backtransport').show();
            //    $('#rdtype').show(500);
            //    $('.srchcityswhd').hide();
            //    $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').hide();
            //    $('#ImageButton1').hide()
            //    BindBlockGrid(ctyid, aridtype)
            //    return false;
            //});
            $('.ViewBlock').live('click', function () {
                ctyid = $(this).parent('td').parent('tr').find('input[id*=cityid]').val();
                aridtype = $(this).parent('td').parent('tr').find('input[id*=areasid]').val();
                $('.bindtrans').hide(500);
                $('.backtransport').show();
                $('#rdtype').show(500);
                $('.srchcityswhd').hide();
                $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').hide();
                $('#ImageButton1').hide()                
                BindBlockGrid(ctyid, aridtype)          
                return false;
            });
            $('.backtranssecgrd').click(function () {
                $('#rdtype').show(500);
                $('#stgtype').hide(500);
                $('.backtranssecgrd').hide();
                $('.backtransport').show();
                $('#DivForStpg').hide(500);
                return false;
            });
            $('.backtransport').click(function () {
                $('.backtransport').hide();
                $('.bindtrans').show(500);
                $('#rdtype').hide(500);
                $('#stgtype').hide(500)
                $('.srchcityswhd').show(500);
                $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').show();
                $('#ImageButton1').show()
                $('#DivForStpg').hide(500);
                return false;
            })
            $('.ViewStoppageName').live('click', function () {
                RdCityID = $(this).parent('td').parent('tr').find('input[id*=RdCityId]').val();
                RDAreaId = $(this).parent('td').parent('tr').find('input[id*=RdAreadId]').val();
                RdRoadId = $(this).parent('td').parent('tr').find('input[id*=RealROadid]').val();
                $('#DivForStpg').show(500)
                $('#stgtype').hide(500);
                $('.backtranslast').show();
                $('.backtranssecgrd').hide();
                BindStoppageDetailsGrid(RdCityID, RDAreaId, RdRoadId)
                return false;
            });
            $('.backtranslast').click(function () {
                $('.backtranslast').hide();
                $('.backtranssecgrd').show();
                $('#stgtype').show(500);
                $('#DivForStpg').hide(500);
                return false;
            });
            $('.btnCloseBlock').click(function () {
                var lasttroftable = $('.showpopupBlock').find('tbody').find('tr:last').prop('outerHTML');
                $('#divaddBlock').hide(500);
                $('#divaddBlock').find('table tr:gt(3)').remove();
                $('#divaddBlock .showpopupBlock').append(lasttroftable);
                $('#divaddBlock').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });
            $('.AddRoad').live('click', function () {
                ctyids = $(this).parent('td').parent('tr').find('input[id*=CityidForBlockUpdate]').val();
                areid = $(this).parent('td').parent('tr').find('input[id*=AreaIDForUpdateRoad]').val();
                BlockID = $(this).parent('td').parent('tr').find('input[id*=BlockUpdate]:last').val();
                Bindalltypeddlcon()
                $('#divforAddRoad').show(500);
                $('.ShowCityDDLForAddRoad').val(ctyids)
                $('.ShowAreaDDLForAddRoad').val(areid)
                $('.ShowBlockDDLForAddRoad').val(BlockID)
                $('.ShowCityDDLForAddRoad').attr('disabled', true)
                $('.ShowAreaDDLForAddRoad').attr('disabled', true)
                $('.ShowBlockDDLForAddRoad').attr('disabled', true)
                $('#ctl00_ContentPlaceHolder1_stopgname').val('');
                AllRoadNames = '';
                ctyids = 0, areid = 0, BlockID = 0;
                return false;
            });
            $('.btnCloseRoad').click(function () {
                var lasttroftableRoad = $('.showpopupAddRoad').find('tbody').find('tr:last').prop('outerHTML');
                $('#divforAddRoad').hide(500);
                $('#divforAddRoad').find('table tr:gt(4)').remove();
                $('#divforAddRoad .showpopupAddRoad').append(lasttroftableRoad);
                $('#divforAddRoad').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });
            $('.btnClosestopg').click(function () {
            var lasttroftablestoppage = $('.showpopupAddStoppage').find('tbody').find('tr:last').prop('outerHTML');
            $('#divForAddAndShowStoppage').hide(500);
            $('#divForAddAndShowStoppage').hide(500);
            $('#divForAddAndShowStoppage').find('table tr:gt(5)').remove();
            $('#divForAddAndShowStoppage .showpopupAddStoppage').append(lasttroftablestoppage);
            $('#divForAddAndShowStoppage').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });
            $('.ViewRoad').live('click', function () {
                ctyids = $(this).parent('td').parent('tr').find('input[id*=CityidForBlockUpdate]').val();
                areid = $(this).parent('td').parent('tr').find('input[id*=AreaIDForUpdateRoad]').val();
                //var RoadIDGR = $(this).parent('td').parent('tr').find('input[id*=RdIDUpdate]').val();
                BlockID = $(this).parent('td').parent('tr').find('input[id*=BlockUpdate]:last').val();
                BindRoadDetailsGrid(ctyids, areid, BlockID)
                $('#stgtype').show(500);
                $('#rdtype').hide();
                $('.backtranssecgrd').show();
                $('.backtransport').hide();
                return false;
            });
            $('.imgfroaddRoad').click(function () {
                var lasttroftableRoad = $('.showpopupAddRoad').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopupAddRoad').find('tbody').find('tr:last').remove();
                var trforadd = '<tr class="for_sigle_row_form"><td class="t1"><div><div style=""><label>Road Name:</label></div></div></td><td class="t2"><div><div style="float: left; "><input  type="text" class="AddRoadName"  placeholder="Road Name Please." ><img class="imageforRomoveRoad" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px; margin-top:17px;" src="../../images/minus.png"></div></div></td></tr>'
                $('#divforAddRoad .showpopupAddRoad').append(trforadd);
                $('#divforAddRoad .showpopupAddRoad').append(lasttroftableRoad);
                return false;
            });
            $('.imgfroaddstopage').click(function () {
                var lasttroftablestoppage = $('.showpopupAddStoppage').find('tbody').find('tr:last').prop('outerHTML');
                $('.showpopupAddStoppage').find('tbody').find('tr:last').remove();
                var trforadd = '<tr class="for_sigle_row_form"><td><div><div style=""><label>Stoppage Name:</label></div></div></td><td class="t2"><div><div style="float: left; "><input  type="text" class="AddStopgName"  placeholder="Stoppage Name Please." ><img class="imageforRomoveStoppage" alt="No Image" style="width: 16px; cursor: pointer; margin-left: 2px; margin-top:17px;" src="../../images/minus.png"></div></div></td></tr>'
                $('#divForAddAndShowStoppage .showpopupAddStoppage').append(trforadd);
                $('#divForAddAndShowStoppage .showpopupAddStoppage').append(lasttroftablestoppage);
                return false;
            });
            $('.btnClosestopg').click(function () {
                var lasttroftablestoppage = $('.showpopupAddStoppage').find('tbody').find('tr:last').prop('outerHTML');
                $('#divForAddAndShowStoppage').hide(500);
                $('#divForAddAndShowStoppage').find('table tr:gt(5)').remove();
                $('#divForAddAndShowStoppage .showpopupAddStoppage').append(lasttroftablestoppage);
                $('#divForAddAndShowStoppage').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                return false;
            });
            $('.addBlockontheBehalfofthecityarea').click(function () {
                $('#divaddBlock').show(500);
                $('#ctl00_ContentPlaceHolder1_othercities').val('0');
                $('#ctl00_ContentPlaceHolder1_otherarea').val('0');
                $('#ctl00_ContentPlaceHolder1_othercities').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_otherarea').attr('disabled', false)
                $('.othertxtBlock').val('');
                ctid = 0, idtype = 0, AllBlockNmaes = '';
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                changecityid = 0, changeareaid = 0;
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_Button1').live('click',function () {
                if ($('#ctl00_ContentPlaceHolder1_DDLCityForAddRoad').val() == '0') {
                    alertify.error('Please Select City')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad').val() == '0') {
                    alertify.error('Please Select Area')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad').val() == '0') {
                    alertify.error('Please Select Block')
                    return false;
                }
                else if ($('#ctl00_ContentPlaceHolder1_AddRoadName').val() == '') {
                    alertify.error('Please Enter Road Name')
                    return false;
                }
                else {
                   $('.showpopupAddRoad').find('tr').find('td,.AddRoadName').each(function () {
                        if ($(this).val() != "") {
                            AllRoadNames = AllRoadNames + '~' + $(this).val();
                        }
                    });
                   AllRoadNames = AllRoadNames.slice(1, AllRoadNames.length);
                   AllRoadNames = AllRoadNames.split("'").join("`")
                   SaveRoad(AllRoadNames)
                    BindBlockGrid(ctyid, aridtype)
                }
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_ddlsearchingcity').change(function () {
                searchcity = $(this).val();
                BindGrid();
                return false;
            });
            $('#ctl00_ContentPlaceHolder1_txtsearchbyarea').keyup(function () {
                searcharea = $(this).val();           
                BindGrid();
                return false;
            });
        //************REMOVE DYNAMIC TEXTBOXES***************//
            $('.imageforRomoveBlock').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('.imageforotherRemoveBlock').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });
            $('.imageforRomoveRoad').live("click", function () {
                $(this).parent('div').parent('div').parent('td').parent('tr').remove();
                return false;
            });            
       //************END OF CODE**************//
       //************IMAGES(BUTTON)(CITY,AREA,ROAD,STOPPAGE) FOR INSERT UODATE AND CANCEL**************//
            $('.imgforeditcity').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnupdate').show(500);
                $(this).parent('td').find('.sbtncancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            });
            $('.sbtncancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnupdate').hide(500);
                $(this).parent('td').find('.sbtncancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditcity').show(500);
                return false;
            });
            $('.imgforeditarea').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnareaupdate').show(500);
                $(this).parent('td').find('.sbtnareacancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            });
            $('.sbtnareacancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnareaupdate').hide(500);
                $(this).parent('td').find('.sbtnareacancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditarea').show(500);
                return false;
            });
            $('.imgforeditBlock').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnblockupdate').show(500);
                $(this).parent('td').find('.sbtnBlockcancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            });
            $('.sbtnBlockcancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnblockupdate').hide(500);
                $(this).parent('td').find('.sbtnBlockcancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditBlock').show(500);
                return false;
            });
            $('.imgforeditRoad').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnRoadupdate').show(500);
                $(this).parent('td').find('.sbtnRoadcancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            });
            $('.sbtnRoadcancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnRoadupdate').hide(500);
                $(this).parent('td').find('.sbtnRoadcancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditRoad').show(500);
                return false;
            });
            $('.imgforeditStoppage').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').hide(500);
                $(this).parent('td').find('.sbtnStoppageupdate').show(500);
                $(this).parent('td').find('.sbtnStoppagecancel').show(500);
                $(this).parent('td').find('input[type=text]').show(500);
                return false;
            });
            $('.sbtnStoppagecancel').live('click', function () {
                $(this).hide(500)
                $(this).parent('td').find('span').show(500);
                $(this).parent('td').find('.sbtnStoppageupdate').hide(500);
                $(this).parent('td').find('.sbtnStoppagecancel').hide(500);
                $(this).parent('td').find('input[type=text]').hide(500);
                $(this).parent('td').find('.imgforeditStoppage').show(500);
                return false;
            });
            $('.addotherStoppagebyheader').click(function () {
                allStopsnames = '';
                $('#divForAddAndShowStoppage').show(500);
                Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId)
                $('#ctl00_ContentPlaceHolder1_DropDownListCity').val('0');
                $('#ctl00_ContentPlaceHolder1_DropDownListArea').val('0');
                $('#ctl00_ContentPlaceHolder1_DropDownListBlock').val('0');
                $('#ctl00_ContentPlaceHolder1_DropDownListRoad').val('0');
                $('#ctl00_ContentPlaceHolder1_DropDownListCity').attr('disabled',false)
                $('#ctl00_ContentPlaceHolder1_DropDownListArea').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_DropDownListBlock').attr('disabled', false)
                $('#ctl00_ContentPlaceHolder1_DropDownListRoad').attr('disabled', false)
                RdCityID = 0, RDAreaId = 0, RdBlockId = 0, RdRoadId = 0;
                return false;
            });
            //************UPDATE CITY**************//
            $('.sbtnupdate').live("click", function () {
                var data = $(this).parents('tr').children('td:eq(1)').find('input[type=text]').val()
                if (data == '') {
                    alertify.error("Please Insert City Name")
                    return false;
                }
                var value = $(this).parents('tr').find('input[id*=cityid]').val();
                if (data != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transportation-master-setting.aspx/updatecities",
                        data: "{'updatecityid':'" + value + "','updatecitydata':'" + data.split("'").join("`") + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {

                            if (data.d == 1) {
                                alertify.success('City Updated Successfully');
                                BindGrid();
                                Bindcitysearchddl();
                            }
                            if (data.d == 2) {
                                alertify.error('City ALready Exist');
                            }
                            call_progressbar("end");
                            value = 0, data = '';
                        },

                        error: function (result) {
                            call_progressbar("end");
                        }

                    });
                }
                else {
                    alertify.error('Some NetWork Issue');
                    return false
                }
            })
            //************END OF CODE HERE**************//
            //************UPDATE AREA**************//
            $('.sbtnareaupdate').live("click", function () {
                var areadata = $(this).parent('td').find('input[type=text]').val()
                if (areadata == '') {
                    alertify.error("Please Insert Area Name");
                    return false;
                }
                cityids = $(this).parents('tr').find('input[id*=cityid]').val();
                areaidforupdt = $(this).parent('td').find('input[id*=areasid]').val();
                if (areadata != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transportation-master-setting.aspx/updateareas",
                        data: "{'areadata':'" + areadata.split("'").join("`") + "','cityids':'" + cityids + "','areaidforupdt':'" + areaidforupdt + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 2) {
                                alertify.success('Area Updated Successfully');
                                BindGrid();
                            }
                            if (data.d == 3) {
                                alertify.error('Area Already Exist');
                            }
                            call_progressbar("end");
                            cityids = 0, areadata = '';
                        },
                        error: function (result) {
                            call_progressbar("end");
                        }
                    });
                }
                else {
                    alertify.error('Some NetWork Issue');
                    return false
                }
            })
            //************END OF CODE HERE**************//
            //************UPDATE ROAD**************//
            $('.sbtnblockupdate').live("click", function () {
                var Blockdata = $(this).parent('td').find('input[type=text]').val()
                if (Blockdata == '') {
                    alertify.error("Please Insert Block Name");
                    return false;
                }
                ctyid = $(this).parents('tr').find('input[id*=CityidForBlockUpdate]').val();
                aridtype = $(this).parents('tr').find('input[id*=AreaIDForUpdateRoad]').val();
                Blockupdateid = $(this).parent('td').find('input[id*=BlockUpdate]:last').val();
                if (Blockdata != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transportation-master-setting.aspx/UpdateBlock",
                        data: "{'Blockdata':'" + Blockdata.split("'").join("`") + "','cityidForRoadupdate':'" + ctyid + "','areaidforRoadupdt':'" + aridtype + "','Blockupdateid':'" + Blockupdateid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 3) {
                                alertify.success('Block Updated Successfully');
                                $('.sbtnBlockcancel').css('display', 'none');
                                $('.sbtnblockupdate').css('display', 'none');
                                $('.imgforeditBlock').css('display', 'block');
                                $('.txtBlockupdate').css('display', 'none');
                                $('.Blockspnshow').css('display', 'block');
                                BindBlockGrid(ctyid, aridtype)
                            }
                            else if (data.d == 4) {
                                alertify.error("This Block Already Exist");
                            }
                            call_progressbar("end");
                        },
                        error: function (result) {
                            call_progressbar("end");
                        }
                    });
                }
                else {
                    alertify.error('Please Enter Location First');
                    return false
                }
            })
            //************END OF CODE HERE**************//
            //************UPDATE STOPPAGE**************//
            $('.sbtnRoadupdate').live("click", function () {
                var Roaddata = $(this).parents('tr').find('input[type=text]').val()
                if (Roaddata == '') {
                    alertify.error("Please Insert Road Name");
                    return false;
                }
                var Roadupdateid = $(this).parent('td').find('input[id*=RealROadid]').val();
                if (Roaddata != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transportation-master-setting.aspx/UpdateRoads",
                        data: "{'Roaddata':'" + Roaddata.split("'").join("`") + "','Roadupdateid':'" + Roadupdateid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 4) {
                                alertify.success('Road Updated Successfully');
                                $('.sbtnRoadcancel').css('display', 'none');
                                $('.sbtnRoadupdate').css('display', 'none');
                                $('.imgforeditRoad').css('display', 'block');
                                $('.txtRdgupdate').css('display', 'none');
                                $('.stoppagespnshow').css('display', 'block');
                                BindRoadDetailsGrid(ctyids, areid, BlockID)
                            }
                            else if (data.d == 5) {
                                alertify.error("This Road Already Exist");

                            }
                            call_progressbar("end");

                        },
                        error: function (result) {
                            call_progressbar("end");
                        }
                    });
                }
                else {
                    alertify.error('Some NetWork Issue');
                    return false
                }
            })
            $('.sbtnStoppageupdate').live("click", function () {
                var StoppageData = $(this).parents('tr').find('input[type=text]').val()
                if (StoppageData == '') {
                    alertify.error("Please Insert Stoppage Name");
                    return false;
                }
                var Stoppageupdateid = $(this).parent('td').find('input[id*=StPGId]').val();
                if (StoppageData != '') {
                    call_progressbar("start");
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "transportation-master-setting.aspx/UpdateStoppage",
                        data: "{'StoppageData':'" + StoppageData.split("'").join("`") + "','Stoppageupdateid':'" + Stoppageupdateid + "'}",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == 5) {
                                alertify.success('Stoppage Updated Successfully');
                                $('.sbtnStoppagecancel').css('display', 'none');
                                $('.sbtnStoppageupdate').css('display', 'none');
                                $('.imgforeditStoppage').css('display', 'block');
                                $('.txtstpgupdate').css('display', 'none');
                                $('.stoppagespnshowspn').css('display', 'block');
                                BindStoppageDetailsGrid(RdCityID, RDAreaId, RdRoadId)
                            }
                            else if (data.d == 6) {
                                alertify.error("This Stoppage Already Exist");
                            }
                            call_progressbar("end");

                        },
                        error: function (result) {
                            call_progressbar("end");
                        }
                    });
                }
                else {
                    alertify.error('Some NetWork Issue');
                    return false
                }
            })
            //************END OF CODE HERE**************//        
            return false;
        });   
        //************SAVE TRANSPORTATION**************//
        function SaveTransPortation(allareaname) {
            var citytype = $('#ctl00_ContentPlaceHolder1_ddlclassforaddcity').val();
            var cityname = $('#ctl00_ContentPlaceHolder1_addothercity').val().split("'").join("`");
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/Addarea",
                data: "{'cityid':'" + citytype + "','Area':'" + $('#ctl00_ContentPlaceHolder1_txtareaname').val().split("'").join("~") + "','Roadname':'" + allareaname + "','cityname':'" + cityname + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("City And Area Added Successfully.");
                        var lasttroftable = $('.showpopuparea').find('tbody').find('tr:last').prop('outerHTML');
                        $('#divaddarea').css('display', 'none');
                        $('#divaddarea').find('table tr:gt(4)').remove();
                        $('#divaddarea .showpopuparea').append(lasttroftable);
                        $('#divaddarea').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                        $('#divaddarea').hide();
                        Bindcitysearchddl();
                        call_progressbar("end");
                    }
                    else if (data.d == 2) {
                        alertify.error("City OR Area Already Exists.");
                        call_progressbar("end");
                    }
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        //************END OF CODE**************//
        //************SAVE ON BEHALF OF Block (UPDATE) TRANSPORTATION**************//
        function SaveBlock(AllBlockNmaes) {
            changcityname = $('#ctl00_ContentPlaceHolder1_othercities').val()
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/addBlock",
                data: "{'citynamesid':'" + changcityname + "','Areanamesid':'" + $('#ctl00_ContentPlaceHolder1_otherarea').val() + "','BlockNames':'" + AllBlockNmaes + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Block Added Successfully.");
                        BindBlockGrid(ctyid, aridtype)
                        call_progressbar("end");
                        var lasttroftableRoad = $('.showpopupBlock').find('tbody').find('tr:last').prop('outerHTML');
                        $('#divaddBlock').css('display', 'none');
                        $('#divaddBlock').hide();
                        $('#divaddBlock').find('table tr:gt(3)').remove();
                        $('#divaddBlock .showpopupBlock').append(lasttroftableRoad);
                        $('#divaddBlock').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Road Is Adding.");
                        call_progressbar("end");
                    }
                    ctid = 0, idtype = 0;
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });
        }
        //************END OF CODE**************//
        //************SAVE Road**************//
        function SaveRoad(AllRoadNames) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/addRoadOnCondition",
                data: "{'citynameid':'" + $('#ctl00_ContentPlaceHolder1_DDLCityForAddRoad').val() + "','Areanameid':'" + $('#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad').val() + "','AllRoadNames':'" + AllRoadNames + "','BlockID':'" + $('#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Road Added Successfully.");
                        call_progressbar("end");
                        var lasttroftableRoad = $('.showpopupAddRoad').find('tbody').find('tr:last').prop('outerHTML');
                        $('#divforAddRoad').css('display', 'none');
                        $('#divforAddRoad').hide();
                        $('#divforAddRoad').find('table tr:gt(4)').remove();
                        $('#divforAddRoad .showpopupAddRoad').append(lasttroftableRoad);
                        $('#divforAddRoad').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Area Is Adding.");
                        call_progressbar("end");
                    }
                    ctyids = 0, areid = 0, BlockID = 0;
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }
        //************END OF CODE**************//
        //************SAVE Road**************//
        function SaveStoppage(allStopsnames) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/addStoppage",
                data: "{'cityNameDDl':'" + $('#ctl00_ContentPlaceHolder1_DropDownListCity').val() + "','AreanameDDL':'" + $('#ctl00_ContentPlaceHolder1_DropDownListArea').val() + "','allStopsnames':'" + allStopsnames + "','BlockIDDDL':'" + $('#ctl00_ContentPlaceHolder1_DropDownListBlock').val() + "','RoadIDDDL':'" + $('#ctl00_ContentPlaceHolder1_DropDownListRoad').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == 1) {
                        alertify.success("Stoppage Added Successfully.");
                        call_progressbar("end");
                        var lasttroftablestoppage = $('.showpopupAddStoppage').find('tbody').find('tr:last').prop('outerHTML');
                        $('#divForAddAndShowStoppage').hide(500);
                        $('#divForAddAndShowStoppage').hide(500);
                        $('#divForAddAndShowStoppage').find('table tr:gt(5)').remove();
                        $('#divForAddAndShowStoppage .showpopupAddStoppage').append(lasttroftablestoppage);
                        $('#divForAddAndShowStoppage').find('table tr:gt(0)').find('td').find('input[type=text]').val('');
                    }
                    else if (data.d == 0) {
                        alertify.error("Some Error While Area Is Adding.");
                        call_progressbar("end");
                    }
                    RdCityID = 0, RDAreaId = 0, RdBlockId = 0, RdRoadId = 0;
                    return false;
                },
                error: function (result) {
                    alertify.error("Some Internal Error");
                    call_progressbar("end");
                    return false;
                }
            });

        }
        //************END OF CODE**************//
        //*********BIND GRID ON THE BEHALF OF THE CITY AND AREA*************//
        function BindGrid() {        
            var trforappend = "";
            $('.bindareatype tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindGridByJs",
                data: "{'searchcity':'" + searchcity + "','searcharea':'" + searcharea + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '<input type="hidden" id="arid" value="' + data.d[i].rdid + '"/></td><td style="width:15%;"><span class="subjectname">' + data.d[i].cityname + '</span><input value="' + data.d[i].cityname + '" class="txtcityupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtncancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditcity"><input id="cityid" type="hidden" value="' + data.d[i].cityid + '"/></td><td style="width:15%;"><span>' + data.d[i].area + '</span><input value="' + data.d[i].area + '" class="txtareaupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnareacancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnareaupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditarea"><input id="areasid" type="hidden" value="' + data.d[i].areaid + '"/></td><td>' + data.d[i].Block + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '<input type="hidden" id="arid" value="' + data.d[i].rdid + '"/></td><td style="width:15%;"><span class="subjectname">' + data.d[i].cityname + '</span><input value="' + data.d[i].cityname + '" class="txtcityupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtncancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditcity"><input id="cityid" type="hidden" value="' + data.d[i].cityid + '"/></td><td style="width:15%;"><span>' + data.d[i].area + '</span><input value="' + data.d[i].area + '" class="txtareaupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnareacancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnareaupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditarea"><input id="areasid" type="hidden" value="' + data.d[i].areaid + '"/></td><td>' + data.d[i].Block + '</td></tr>';
                            $('.bindareatype').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    else {
                        alertify.error("No Any Record on the behalf Of Your Advance Searching");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                  
                    call_progressbar("end");
                }
            });
        }
        //************END OF CODE HERE**************//
        //************BIND GRID ON THE BEHALF OF THE ROAD**************//
        function BindBlockGrid(ctyid, aridtype) {
            var trforappend = "";
            $('.bindroadtypess tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindGridByJsforroad",
                data: "{'ctyid':'" + ctyid + "','aridtype':'" + aridtype + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].cityname + '<input id="CityidForBlockUpdate" type="hidden" value="' + data.d[i].cityid + '"/></td><td>' + data.d[i].area + '<input id="AreaIDForUpdateRoad" type="hidden" value="' + data.d[i].areaid + '"/></td><td style="width:15%;"><span class="Blockspnshow">' + data.d[i].Block + '</span><input value="' + data.d[i].Block + '" class="txtBlockupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnBlockcancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnblockupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditBlock"><input id="BlockUpdate" type="hidden" value="' + data.d[i].BlockID + '"></td><td>' + data.d[i].RoadName + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].cityname + '<input id="CityidForBlockUpdate" type="hidden" value="' + data.d[i].cityid + '"/></td><td>' + data.d[i].area + '<input id="AreaIDForUpdateRoad" type="hidden" value="' + data.d[i].areaid + '"/></td><td style="width:15%;"><span class="Blockspnshow">' + data.d[i].Block + '</span><input value="' + data.d[i].Block + '" class="txtBlockupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnBlockcancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnblockupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditBlock"><input id="BlockUpdate" type="hidden" value="' + data.d[i].BlockID + '"></td><td>' + data.d[i].RoadName + '</td></tr>';
                            $('.bindroadtypess').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        //************END OF CODE HERE**************//
        //************BIND GRID ON THE BEHALF OF THE STOPPAGE**************//
        function BindRoadDetailsGrid(ctyids, areid, BlockID) {
            var trforappend = "";
            $('.bindstoppagetype tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindGridByJsforRoadDetails",
                data: "{'ctyids':'" + ctyids + "','areid':'" + areid + "','BlockID':'" + BlockID + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td><input id="RdCityId" type = "hidden" value="' + data.d[i].Zoneid + '">' + data.d[i].cityname + '</td><td><input id="RdAreadId" type = "hidden" value="' + data.d[i].areaid + '">' + data.d[i].areaname + '</td><td><input id="RdBlockId" type = "hidden" value="' + data.d[i].BlockID + '">' + data.d[i].BlockName + '</td><td style="width:15%;"><span class = "stoppagespnshow">' + data.d[i].Roadname + '</span><input value="' + data.d[i].Roadname + '" class="txtRdgupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnRoadcancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnRoadupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditRoad"><input id="RealROadid" type = "hidden" value="' + data.d[i].RoadID + '"></td><td>' + data.d[i].Stoppage + '</td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td><input id="RdCityId" type = "hidden" value="' + data.d[i].Zoneid + '">' + data.d[i].cityname + '</td><td><input id="RdAreadId" type = "hidden" value="' + data.d[i].areaid + '">' + data.d[i].areaname + '</td><td><input id="RdBlockId" type = "hidden" value="' + data.d[i].BlockID + '">' + data.d[i].BlockName + '</td><td style="width:15%;"><span class = "stoppagespnshow">' + data.d[i].Roadname + '</span><input value="' + data.d[i].Roadname + '" class="txtRdgupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnRoadcancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnRoadupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditRoad"><input id="RealROadid" type = "hidden" value="' + data.d[i].RoadID + '"></td><td>' + data.d[i].Stoppage + '</td></tr>';
                            $('.bindstoppagetype').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
        //************END OF CODE HERE**************//
        function BindStoppageDetailsGrid(RdCityID, RDAreaId, RdRoadId) {
            var trforappend = "";
            $('.bindstoppage tr:gt(0)').remove();
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindGridByJsforStoppageDetails",
                data: "{'RdCityID':'" + RdCityID + "','RDAreaId':'" + RDAreaId + "','RdRoadId':'" + RdRoadId + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            if (i % 2 != 0)
                                trforappend = '<tr class="stm_light"><td>' + (i + 1) + '</td><td>' + data.d[i].cityname + '</td><td>' + data.d[i].areaname + '</td><td>' + data.d[i].BlockName + '</td><td>' + data.d[i].Roadname + '</td><td style="width:15%;"><span class = "stoppagespnshowspn">' + data.d[i].Stoppage + '</span><input value="' + data.d[i].Stoppage + '" class="txtstpgupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnStoppagecancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnStoppageupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditStoppage"><input id="StPGId" type = "hidden" value="' + data.d[i].stoppageid + '"></td></tr>';
                            else
                                trforappend = '<tr class="stm_dark"><td>' + (i + 1) + '</td><td>' + data.d[i].cityname + '</td><td>' + data.d[i].areaname + '</td><td>' + data.d[i].BlockName + '</td><td>' + data.d[i].Roadname + '</td><td style="width:15%;"><span class = "stoppagespnshowspn">' + data.d[i].Stoppage + '</span><input value="' + data.d[i].Stoppage + '" class="txtstpgupdate" type="text" style="width:200px; display:none; height:20px;padding: 3px;"><img style="display: none; float: right;cursor:pointer" src="../../images/ic.png" title="Click here for cancel" class="sbtnStoppagecancel"><img style="display: none; margin-right:2px; float: right;cursor:pointer" src="../../images/update.png" title="Click here for update" class="sbtnStoppageupdate"><img src="../../images/edit.png" style="float:right;cursor:pointer" class="imgforeditStoppage"><input id="StPGId" type = "hidden" value="' + data.d[i].stoppageid + '"></td></tr>';
                            $('.bindstoppage').append(trforappend);
                        }
                        call_progressbar("end");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
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
        var checkddl = "";
        function Bindalltypeddl(changecityid, changeareaid, ChangeBlockiId) {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindDDLOFAddRoadByHeader",
                data: "{'changecityid':'" + changecityid + "','changeareaid':'" + changeareaid + "','ChangeBlockiId':'" + ChangeBlockiId + "'}",
                dataType: "json",
                async:false,
                success: function (data) {
                    $("#ctl00_ContentPlaceHolder1_othercities").html("");
                    $("#ctl00_ContentPlaceHolder1_ddlclassforaddcity").html("");
                    $("#ctl00_ContentPlaceHolder1_DDLCityForAddRoad").html("");
                    $("#ctl00_ContentPlaceHolder1_otherarea").html("");
                    $("#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad").html("");
                    $("#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad").html("");
                    $("#ctl00_ContentPlaceHolder1_DropDownListCity").html("");
                    $("#ctl00_ContentPlaceHolder1_DropDownListArea").html("");
                    $("#ctl00_ContentPlaceHolder1_DropDownListBlock").html("");
                    $("#ctl00_ContentPlaceHolder1_DropDownListRoad").html(" ");
                    $.each(data.d, function (key, value) {
                        if (value.zonename != null) {
                            $("#ctl00_ContentPlaceHolder1_othercities").append($("<option></option>").val(value.zoneid).html(value.zonename));
                            $("#ctl00_ContentPlaceHolder1_ddlclassforaddcity").append($("<option></option>").val(value.zoneid).html(value.zonename));
                            $("#ctl00_ContentPlaceHolder1_DDLCityForAddRoad").append($("<option></option>").val(value.zoneid).html(value.zonename));
                            $("#ctl00_ContentPlaceHolder1_DropDownListCity").append($("<option></option>").val(value.zoneid).html(value.zonename));
                        }
                        if (value.areaname != null) {
                                $("#ctl00_ContentPlaceHolder1_otherarea").append($("<option></option>").val(value.areaid).html(value.areaname));
                                $("#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad").append($("<option></option>").val(value.areaid).html(value.areaname));
                                $("#ctl00_ContentPlaceHolder1_DropDownListArea").append($("<option></option>").val(value.areaid).html(value.areaname));
                        }
                        if (value.BlockName != null) {
                            $("#ctl00_ContentPlaceHolder1_DDLBlockForAddRoad").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                            $("#ctl00_ContentPlaceHolder1_DropDownListBlock").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                        }
                        if (value.roadname != null) {
                            $("#ctl00_ContentPlaceHolder1_DropDownListRoad").append($("<option></option>").val(value.roadid).html(value.roadname));
                        }
                    });
                    $("#ctl00_ContentPlaceHolder1_othercities").val(changecityid);
                    $("#ctl00_ContentPlaceHolder1_DDLCityForAddRoad").val(changecityid)
                    $("#ctl00_ContentPlaceHolder1_DDLAreaForAddRoad").val(changeareaid)
                    $("#ctl00_ContentPlaceHolder1_DropDownListCity").val(changecityid)
                    $("#ctl00_ContentPlaceHolder1_DropDownListArea").val(changeareaid)
                    $("#ctl00_ContentPlaceHolder1_DropDownListBlock").val(ChangeBlockiId)
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Bindalltypeddlcon() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/BindDDLFORAddRoad",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    $(".ddlcity").html("");
                    $(".ddlarea").html("");
                    $(".ShowCityDDLForAddRoad").html("");
                    $(".ShowAreaDDLForAddRoad").html("");
                    $(".ShowBlockDDLForAddRoad").html("");
                    $.each(data.d, function (key, value) {
                        if (value.zonename != null) {
                            $(".ddlcity").append($("<option></option>").val(value.zoneid).html(value.zonename));
                            $(".ShowCityDDLForAddRoad").append($("<option></option>").val(value.zoneid).html(value.zonename));
                            $(".ShowCityDDLForAddStoppage").append($("<option></option>").val(value.zoneid).html(value.zonename));
                        }
                        if (value.areaname != null) {
                            $(".ddlarea").append($("<option></option>").val(value.areaid).html(value.areaname));
                            $(".ShowAreaDDLForAddRoad").append($("<option></option>").val(value.areaid).html(value.areaname));
                            $(".ShowAreaDDLForAddStoppage").append($("<option></option>").val(value.areaid).html(value.areaname));
                        }
                        if (value.BlockName != null) {
                            $(".ShowBlockDDLForAddRoad").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                            $(".ShowBlockDDLForAddStoppage").append($("<option></option>").val(value.BlockID).html(value.BlockName));
                        }
                        if (value.roadname != null) {
                            $(".ShowRoadDDLForAddStoppage").append($("<option></option>").val(value.Roadid).html(value.roadname));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        function Bindcitysearchddl() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "transportation-master-setting.aspx/searchcity",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                  
                    $("#ctl00_ContentPlaceHolder1_ddlsearchingcity").html("");
                    $.each(data.d, function (key, value) {
                        if (value.zonename != null) {
                            $("#ctl00_ContentPlaceHolder1_ddlsearchingcity").append($("<option></option>").val(value.zoneid).html(value.zonename));
                        }
                    });
                    call_progressbar("end");
                },
                error: function (result) {
                    alertify.error('error');
                },
            });
        }
        //********************** END OF CODE HERE **********************//
    </script>
</asp:Content>

