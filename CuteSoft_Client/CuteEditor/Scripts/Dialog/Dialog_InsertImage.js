var OxOd1b8=["zoomcount","wheelDelta","zoom","style","0%","top","hiddenDirectory","hiddenFile","hiddenAlert","hiddenAction","hiddenActionData","This function is disabled in the demo mode.","disabled","[[Disabled]]","[[SpecifyNewFolderName]]","","value","createdir","[[CopyMoveto]]","/","move","copy","[[AreyouSureDelete]]","parentNode","text","isdir","true",".","[[SpecifyNewFileName]]","rename","True","False",":","path","FoldersAndFiles","TR","length","onmouseover","this.style.backgroundColor=\x27#eeeeee\x27;","onmouseout","this.style.backgroundColor=\x27\x27;","nodeName","INPUT","changedir","url","TargetUrl","htmlcode","onload","getElementsByTagName","table","sortable"," ","className","id","rows","cells","innerHTML","\x3Ca href=\x22#\x22 onclick=\x22ts_resortTable(this);return false;\x22\x3E","\x3Cspan class=\x22sortarrow\x22\x3E\x26nbsp;\x3C/span\x3E\x3C/a\x3E","string","undefined","innerText","childNodes","nodeValue","nodeType","span","cellIndex","TABLE","sortdir","down","\x26uarr;","up","\x26darr;","sortbottom","tBodies","sortarrow","\x26nbsp;","20","19","browse_Frame","Image1","FolderDescription","CreateDir","Copy","Move","img_AutoThumbnail","img_ImageEditor","Delete","DoRefresh","name_Cell","size_Cell","op_Cell","divpreview","img_demo","Align","Border","bordercolor","bordercolor_Preview","inp_width","imgLock","inp_height","constrain_prop","HSpace","VSpace","AlternateText","inp_id","longDesc","fieldsetUpload","Button1","Button2","btn_zoom_in","btn_zoom_out","btn_Actualsize","btn_bestfit","img","editor","documentElement","documentMode","clientHeight","scrollHeight","width","265px","appName","Microsoft Internet Explorer","userAgent","MSIE ([0-9]{1,}[.0-9]{0,})","src","src_cetemp","height","vspace","hspace","border","borderColor","backgroundColor","align","alt","longdesc","file","IMG","complete","../images/1x1.gif","?","\x26time=","?time=","0","onmousewheel",".aspx","display","none","Edit","[[ValidID]]","[[ValidColor]]","[[SelectImagetoInsert]]","=\x22","\x22","checked","../Load.ashx?type=image\x26file=locked.gif","../Load.ashx?type=image\x26file=1x1.gif","[[SelectImagetoThumbnail]]","dir","refresh","Thumbnail.aspx?","dialogWidth:310px;dialogHeight:150px;help:no;scroll:no;status:no;resizable:1;","UseStandardDialog","1","\x26Dialog=Standard","setting=","EditorSetting","\x26Theme=","Theme","\x26","DNNArg","[[SelectImagetoEdit]]","[[_CuteEditorResource_]]","../ImageEditor/ImageEditor.aspx?f=","\x26p=","\x26setting=","dialogWidth:676px;dialogHeight:500px;help:no;scroll:no;status:no;resizable:0;","onclick","wrapupPrompt","iepromptfield","body","div","IEPromptBox","promptBlackout","1px solid #b0bec7","#f0f0f0","position","absolute","330px","zIndex","100","\x3Cdiv style=\x22width: 100%; padding-top:3px;background-color: #DCE7EB; font-family: verdana; font-size: 10pt; font-weight: bold; height: 22px; text-align:center; background:url(Load.ashx?type=image\x26file=formbg2.gif) repeat-x left top;\x22\x3E[[InputRequired]]\x3C/div\x3E","\x3Cdiv style=\x22padding: 10px\x22\x3E","\x3CBR\x3E\x3CBR\x3E","\x3Cform action=\x22\x22 onsubmit=\x22return wrapupPrompt()\x22\x3E","\x3Cinput id=\x22iepromptfield\x22 name=\x22iepromptdata\x22 type=text size=46 value=\x22","\x22\x3E","\x3Cbr\x3E\x3Cbr\x3E\x3Ccenter\x3E","\x3Cinput type=\x22submit\x22 value=\x22\x26nbsp;\x26nbsp;\x26nbsp;[[OK]]\x26nbsp;\x26nbsp;\x26nbsp;\x22\x3E","\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;\x26nbsp;","\x3Cinput type=\x22button\x22 onclick=\x22wrapupPrompt(true)\x22 value=\x22\x26nbsp;[[Cancel]]\x26nbsp;\x22\x3E","\x3C/form\x3E\x3C/div\x3E","100px","left","offsetWidth","px","block","CuteEditor_ColorPicker_ButtonOver(this)"];function OnImageMouseWheel(){var Ox333=Event_GetEvent();var img=Event_GetSrcElement(Ox333);var Ox415=img[OxOd1b8[0]]||3;if(Ox333[OxOd1b8[1]]>=106){Ox415++;} else {if(Ox333[OxOd1b8[1]]<=-106){Ox415--;} ;} ;img[OxOd1b8[0]]=Ox415;img[OxOd1b8[3]][OxOd1b8[2]]=Ox415+OxOd1b8[4];return false;} ;function Window_GetDialogTop(Ox1a8){return Ox1a8[OxOd1b8[5]];} ;var hiddenDirectory=Window_GetElement(window,OxOd1b8[6],true);var hiddenFile=Window_GetElement(window,OxOd1b8[7],true);var hiddenAlert=Window_GetElement(window,OxOd1b8[8],true);var hiddenAction=Window_GetElement(window,OxOd1b8[9],true);var hiddenActionData=Window_GetElement(window,OxOd1b8[10],true);function CreateDir_click(){if(isDemoMode){alert(OxOd1b8[11]);return false;} ;if(Event_GetSrcElement()[OxOd1b8[12]]){alert(OxOd1b8[13]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxOd1b8[14],OxOd1b8[15]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;hiddenAction[OxOd1b8[16]]=OxOd1b8[17];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxOd1b8[14],OxOd1b8[15]);if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Move_click(){if(isDemoMode){alert(OxOd1b8[11]);return false;} ;if(Event_GetSrcElement()[OxOd1b8[12]]){alert(OxOd1b8[13]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxOd1b8[18],OxOd1b8[19]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;hiddenAction[OxOd1b8[16]]=OxOd1b8[20];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxOd1b8[18],OxOd1b8[19]);if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Copy_click(){if(isDemoMode){alert(OxOd1b8[11]);return false;} ;if(Event_GetSrcElement()[OxOd1b8[12]]){alert(OxOd1b8[13]);return false;} ;if(Browser_IsIE7()){IEprompt(Ox221,OxOd1b8[18],OxOd1b8[19]);function Ox221(Ox382){if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;hiddenAction[OxOd1b8[16]]=OxOd1b8[21];window.PostBackAction();return true;} else {return false;} ;} ;return Event_CancelEvent();} else {var Ox382=prompt(OxOd1b8[18],OxOd1b8[19]);if(Ox382){hiddenActionData[OxOd1b8[16]]=Ox382;return true;} else {return false;} ;return false;} ;} ;function Delete_click(){if(isDemoMode){alert(OxOd1b8[11]);return false;} ;if(Event_GetSrcElement()[OxOd1b8[12]]){alert(OxOd1b8[13]);return false;} ;return confirm(OxOd1b8[22]);} ;function EditImg_click(img){if(isDemoMode){alert(OxOd1b8[11]);return false;} ;if(img[OxOd1b8[12]]){alert(OxOd1b8[13]);return false;} ;var Ox387=img[OxOd1b8[23]][OxOd1b8[23]];var Ox388=Ox387.getAttribute(OxOd1b8[24]);var name;var Ox389;Ox389=Ox387.getAttribute(OxOd1b8[25])==OxOd1b8[26];if(Browser_IsIE7()){var Oxca;if(Ox389){IEprompt(Ox221,OxOd1b8[14],Ox388);} else {var i=Ox388.lastIndexOf(OxOd1b8[27]);Oxca=Ox388.substr(i);var Ox12=Ox388.substr(0,Ox388.lastIndexOf(OxOd1b8[27]));IEprompt(Ox221,OxOd1b8[28],Ox12);} ;function Ox221(Ox382){if(Ox382&&Ox382!=Ox387.getAttribute(OxOd1b8[24])){if(!Ox389){Ox382=Ox382+Oxca;} ;hiddenAction[OxOd1b8[16]]=OxOd1b8[29];hiddenActionData[OxOd1b8[16]]=(Ox389?OxOd1b8[30]:OxOd1b8[31])+OxOd1b8[32]+Ox387.getAttribute(OxOd1b8[33])+OxOd1b8[32]+Ox382;window.PostBackAction();} ;} ;} else {if(Ox389){name=prompt(OxOd1b8[14],Ox388);} else {var i=Ox388.lastIndexOf(OxOd1b8[27]);var Oxca=Ox388.substr(i);var Ox12=Ox388.substr(0,Ox388.lastIndexOf(OxOd1b8[27]));name=prompt(OxOd1b8[28],Ox12);if(name){name=name+Oxca;} ;} ;if(name&&name!=Ox387.getAttribute(OxOd1b8[24])){hiddenAction[OxOd1b8[16]]=OxOd1b8[29];hiddenActionData[OxOd1b8[16]]=(Ox389?OxOd1b8[30]:OxOd1b8[31])+OxOd1b8[32]+Ox387.getAttribute(OxOd1b8[33])+OxOd1b8[32]+name;window.PostBackAction();} ;} ;return Event_CancelEvent();} ;setMouseOver();function setMouseOver(){var FoldersAndFiles=Window_GetElement(window,OxOd1b8[34],true);var Ox38c=FoldersAndFiles.getElementsByTagName(OxOd1b8[35]);for(var i=1;i<Ox38c[OxOd1b8[36]];i++){var Ox387=Ox38c[i];Ox387[OxOd1b8[37]]= new Function(OxOd1b8[15],OxOd1b8[38]);Ox387[OxOd1b8[39]]= new Function(OxOd1b8[15],OxOd1b8[40]);} ;} ;function row_click(Ox387){var Ox389;Ox389=Ox387.getAttribute(OxOd1b8[25])==OxOd1b8[26];if(Ox389){if(Event_GetSrcElement()[OxOd1b8[41]]==OxOd1b8[42]){return ;} ;hiddenAction[OxOd1b8[16]]=OxOd1b8[43];hiddenActionData[OxOd1b8[16]]=Ox387.getAttribute(OxOd1b8[33]);window.PostBackAction();} else {var Ox109=Ox387.getAttribute(OxOd1b8[33]);hiddenFile[OxOd1b8[16]]=Ox109;var Ox288=Ox387.getAttribute(OxOd1b8[44]);Window_GetElement(window,OxOd1b8[45],true)[OxOd1b8[16]]=Ox288;var htmlcode=Ox387.getAttribute(OxOd1b8[46]);if(htmlcode!=OxOd1b8[15]&&htmlcode!=null){do_preview(htmlcode);} else {if(Ox288!=OxOd1b8[15]&&Ox288!=null){try{Actualsize();} catch(x){do_preview();} ;} ;} ;} ;} ;function reset_hiddens(){if(hiddenAlert[OxOd1b8[16]]){alert(hiddenAlert.value);} ;if(TargetUrl[OxOd1b8[16]]!=OxOd1b8[15]&&TargetUrl[OxOd1b8[16]]!=null){do_preview();} ;hiddenAlert[OxOd1b8[16]]=OxOd1b8[15];hiddenAction[OxOd1b8[16]]=OxOd1b8[15];hiddenActionData[OxOd1b8[16]]=OxOd1b8[15];} ;Event_Attach(window,OxOd1b8[47],reset_hiddens);function RequireFileBrowseScript(){} ;Event_Attach(window,OxOd1b8[47],sortables_init);var SORT_COLUMN_INDEX;function sortables_init(){if(!document[OxOd1b8[48]]){return ;} ;var Ox391=document.getElementsByTagName(OxOd1b8[49]);for(var Ox392=0;Ox392<Ox391[OxOd1b8[36]];Ox392++){var Ox393=Ox391[Ox392];if(((OxOd1b8[51]+Ox393[OxOd1b8[52]]+OxOd1b8[51]).indexOf(OxOd1b8[50])!=-1)&&(Ox393[OxOd1b8[53]])){ts_makeSortable(Ox393);} ;} ;} ;function ts_makeSortable(Ox395){if(Ox395[OxOd1b8[54]]&&Ox395[OxOd1b8[54]][OxOd1b8[36]]>0){var Ox396=Ox395[OxOd1b8[54]][0];} ;if(!Ox396){return ;} ;for(var i=2;i<4;i++){var Ox397=Ox396[OxOd1b8[55]][i];var Ox219=ts_getInnerText(Ox397);Ox397[OxOd1b8[56]]=OxOd1b8[57]+Ox219+OxOd1b8[58];} ;} ;function ts_getInnerText(Ox29){if( typeof Ox29==OxOd1b8[59]){return Ox29;} ;if( typeof Ox29==OxOd1b8[60]){return Ox29;} ;if(Ox29[OxOd1b8[61]]){return Ox29[OxOd1b8[61]];} ;var Ox24=OxOd1b8[15];var Ox343=Ox29[OxOd1b8[62]];var Ox11=Ox343[OxOd1b8[36]];for(var i=0;i<Ox11;i++){switch(Ox343[i][OxOd1b8[64]]){case 1:Ox24+=ts_getInnerText(Ox343[i]);break ;;case 3:Ox24+=Ox343[i][OxOd1b8[63]];break ;;} ;} ;return Ox24;} ;function ts_resortTable(Ox39a){var Ox2a6;for(var Ox39b=0;Ox39b<Ox39a[OxOd1b8[62]][OxOd1b8[36]];Ox39b++){if(Ox39a[OxOd1b8[62]][Ox39b][OxOd1b8[41]]&&Ox39a[OxOd1b8[62]][Ox39b][OxOd1b8[41]].toLowerCase()==OxOd1b8[65]){Ox2a6=Ox39a[OxOd1b8[62]][Ox39b];} ;} ;var Ox39c=ts_getInnerText(Ox2a6);var Ox1e4=Ox39a[OxOd1b8[23]];var Ox39d=Ox1e4[OxOd1b8[66]];var Ox395=getParent(Ox1e4,OxOd1b8[67]);if(Ox395[OxOd1b8[54]][OxOd1b8[36]]<=1){return ;} ;var Ox39e=ts_getInnerText(Ox395[OxOd1b8[54]][1][OxOd1b8[55]][Ox39d]);var Ox39f=ts_sort_caseinsensitive;if(Ox39e.match(/^\d\d[\/-]\d\d[\/-]\d\d\d\d$/)){Ox39f=ts_sort_date;} ;if(Ox39e.match(/^\d\d[\/-]\d\d[\/-]\d\d$/)){Ox39f=ts_sort_date;} ;if(Ox39e.match(/^[?]/)){Ox39f=ts_sort_currency;} ;if(Ox39e.match(/^[\d\.]+$/)){Ox39f=ts_sort_numeric;} ;SORT_COLUMN_INDEX=Ox39d;var Ox396= new Array();var Ox3a0= new Array();for(var i=0;i<Ox395[OxOd1b8[54]][0][OxOd1b8[36]];i++){Ox396[i]=Ox395[OxOd1b8[54]][0][i];} ;for(var Ox25=1;Ox25<Ox395[OxOd1b8[54]][OxOd1b8[36]];Ox25++){Ox3a0[Ox25-1]=Ox395[OxOd1b8[54]][Ox25];} ;Ox3a0.sort(Ox39f);if(Ox2a6.getAttribute(OxOd1b8[68])==OxOd1b8[69]){var Ox3a1=OxOd1b8[70];Ox3a0.reverse();Ox2a6.setAttribute(OxOd1b8[68],OxOd1b8[71]);} else {Ox3a1=OxOd1b8[72];Ox2a6.setAttribute(OxOd1b8[68],OxOd1b8[69]);} ;for(i=0;i<Ox3a0[OxOd1b8[36]];i++){if(!Ox3a0[i][OxOd1b8[52]]||(Ox3a0[i][OxOd1b8[52]]&&(Ox3a0[i][OxOd1b8[52]].indexOf(OxOd1b8[73])==-1))){Ox395[OxOd1b8[74]][0].appendChild(Ox3a0[i]);} ;} ;for(i=0;i<Ox3a0[OxOd1b8[36]];i++){if(Ox3a0[i][OxOd1b8[52]]&&(Ox3a0[i][OxOd1b8[52]].indexOf(OxOd1b8[73])!=-1)){Ox395[OxOd1b8[74]][0].appendChild(Ox3a0[i]);} ;} ;var Ox3a2=document.getElementsByTagName(OxOd1b8[65]);for(var Ox39b=0;Ox39b<Ox3a2[OxOd1b8[36]];Ox39b++){if(Ox3a2[Ox39b][OxOd1b8[52]]==OxOd1b8[75]){if(getParent(Ox3a2[Ox39b],OxOd1b8[49])==getParent(Ox39a,OxOd1b8[49])){Ox3a2[Ox39b][OxOd1b8[56]]=OxOd1b8[76];} ;} ;} ;Ox2a6[OxOd1b8[56]]=Ox3a1;} ;function getParent(Ox29,Ox3a4){if(Ox29==null){return null;} else {if(Ox29[OxOd1b8[64]]==1&&Ox29[OxOd1b8[41]].toLowerCase()==Ox3a4.toLowerCase()){return Ox29;} else {return getParent(Ox29.parentNode,Ox3a4);} ;} ;} ;function ts_sort_date(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxOd1b8[55]][SORT_COLUMN_INDEX]);var Ox3a7=ts_getInnerText(b[OxOd1b8[55]][SORT_COLUMN_INDEX]);if(Ox3a6[OxOd1b8[36]]==10){var Ox3a8=Ox3a6.substr(6,4)+Ox3a6.substr(3,2)+Ox3a6.substr(0,2);} else {var Ox3a9=Ox3a6.substr(6,2);if(parseInt(Ox3a9)<50){Ox3a9=OxOd1b8[77]+Ox3a9;} else {Ox3a9=OxOd1b8[78]+Ox3a9;} ;var Ox3a8=Ox3a9+Ox3a6.substr(3,2)+Ox3a6.substr(0,2);} ;if(Ox3a7[OxOd1b8[36]]==10){var Ox3aa=Ox3a7.substr(6,4)+Ox3a7.substr(3,2)+Ox3a7.substr(0,2);} else {Ox3a9=Ox3a7.substr(6,2);if(parseInt(Ox3a9)<50){Ox3a9=OxOd1b8[77]+Ox3a9;} else {Ox3a9=OxOd1b8[78]+Ox3a9;} ;var Ox3aa=Ox3a9+Ox3a7.substr(3,2)+Ox3a7.substr(0,2);} ;if(Ox3a8==Ox3aa){return 0;} ;if(Ox3a8<Ox3aa){return -1;} ;return 1;} ;function ts_sort_currency(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxOd1b8[55]][SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,OxOd1b8[15]);var Ox3a7=ts_getInnerText(b[OxOd1b8[55]][SORT_COLUMN_INDEX]).replace(/[^0-9.]/g,OxOd1b8[15]);return parseFloat(Ox3a6)-parseFloat(Ox3a7);} ;function ts_sort_numeric(Oxee,b){var Ox3a6=parseFloat(ts_getInnerText(Oxee[OxOd1b8[55]][SORT_COLUMN_INDEX]));if(isNaN(Ox3a6)){Ox3a6=0;} ;var Ox3a7=parseFloat(ts_getInnerText(b[OxOd1b8[55]][SORT_COLUMN_INDEX]));if(isNaN(Ox3a7)){Ox3a7=0;} ;return Ox3a6-Ox3a7;} ;function ts_sort_caseinsensitive(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxOd1b8[55]][SORT_COLUMN_INDEX]).toLowerCase();var Ox3a7=ts_getInnerText(b[OxOd1b8[55]][SORT_COLUMN_INDEX]).toLowerCase();if(Ox3a6==Ox3a7){return 0;} ;if(Ox3a6<Ox3a7){return -1;} ;return 1;} ;function ts_sort_default(Oxee,b){var Ox3a6=ts_getInnerText(Oxee[OxOd1b8[55]][SORT_COLUMN_INDEX]);var Ox3a7=ts_getInnerText(b[OxOd1b8[55]][SORT_COLUMN_INDEX]);if(Ox3a6==Ox3a7){return 0;} ;if(Ox3a6<Ox3a7){return -1;} ;return 1;} [sortables_init];RequireFileBrowseScript();var browse_Frame=Window_GetElement(window,OxOd1b8[79],true);var hiddenDirectory=Window_GetElement(window,OxOd1b8[6],true);var hiddenFile=Window_GetElement(window,OxOd1b8[7],true);var hiddenAlert=Window_GetElement(window,OxOd1b8[8],true);var hiddenAction=Window_GetElement(window,OxOd1b8[9],true);var hiddenActionData=Window_GetElement(window,OxOd1b8[10],true);var Image1=Window_GetElement(window,OxOd1b8[80],true);var FolderDescription=Window_GetElement(window,OxOd1b8[81],true);var CreateDir=Window_GetElement(window,OxOd1b8[82],true);var Copy=Window_GetElement(window,OxOd1b8[83],true);var Move=Window_GetElement(window,OxOd1b8[84],true);var img_AutoThumbnail=Window_GetElement(window,OxOd1b8[85],true);var img_ImageEditor=Window_GetElement(window,OxOd1b8[86],false);var FoldersAndFiles=Window_GetElement(window,OxOd1b8[34],true);var Delete=Window_GetElement(window,OxOd1b8[87],true);var DoRefresh=Window_GetElement(window,OxOd1b8[88],true);var name_Cell=Window_GetElement(window,OxOd1b8[89],true);var size_Cell=Window_GetElement(window,OxOd1b8[90],true);var op_Cell=Window_GetElement(window,OxOd1b8[91],true);var divpreview=Window_GetElement(window,OxOd1b8[92],true);var img_demo=Window_GetElement(window,OxOd1b8[93],true);var Align=Window_GetElement(window,OxOd1b8[94],true);var Border=Window_GetElement(window,OxOd1b8[95],true);var bordercolor=Window_GetElement(window,OxOd1b8[96],true);var bordercolor_Preview=Window_GetElement(window,OxOd1b8[97],true);var inp_width=Window_GetElement(window,OxOd1b8[98],true);var imgLock=Window_GetElement(window,OxOd1b8[99],true);var inp_height=Window_GetElement(window,OxOd1b8[100],true);var constrain_prop=Window_GetElement(window,OxOd1b8[101],true);var HSpace=Window_GetElement(window,OxOd1b8[102],true);var VSpace=Window_GetElement(window,OxOd1b8[103],true);var TargetUrl=Window_GetElement(window,OxOd1b8[45],true);var AlternateText=Window_GetElement(window,OxOd1b8[104],true);var inp_id=Window_GetElement(window,OxOd1b8[105],true);var longDesc=Window_GetElement(window,OxOd1b8[106],true);var fieldsetUpload=Window_GetElement(window,OxOd1b8[107],true);var Button1=Window_GetElement(window,OxOd1b8[108],true);var Button2=Window_GetElement(window,OxOd1b8[109],true);var btn_zoom_in=Window_GetElement(window,OxOd1b8[110],true);var btn_zoom_out=Window_GetElement(window,OxOd1b8[111],true);var btn_Actualsize=Window_GetElement(window,OxOd1b8[112],true);var btn_bestfit=Window_GetElement(window,OxOd1b8[113],true);var obj=Window_GetDialogArguments(window);var element=obj[OxOd1b8[114]];var editor=obj[OxOd1b8[115]];var ver=getInternetExplorerVersion();if(ver>-1&&ver<=9.0){var needAdjust=true;if(ver>=8.0&&document[OxOd1b8[116]]){if(document[OxOd1b8[117]]>7){needAdjust=false;} ;} ;if(needAdjust&&(browse_Frame[OxOd1b8[118]]<browse_Frame[OxOd1b8[119]])){FoldersAndFiles[OxOd1b8[3]][OxOd1b8[120]]=OxOd1b8[121];} ;} ;function getInternetExplorerVersion(){var Ox3ca=-1;if(navigator[OxOd1b8[122]]==OxOd1b8[123]){var Ox3cb=navigator[OxOd1b8[124]];var Ox296= new RegExp(OxOd1b8[125]);if(Ox296.exec(Ox3cb)!=null){Ox3ca=parseFloat(RegExp.$1);} ;} ;return Ox3ca;} ;var src=OxOd1b8[15];if(element.getAttribute(OxOd1b8[126])){src=element.getAttribute(OxOd1b8[126]);} ;if(element.getAttribute(OxOd1b8[127])){src=element.getAttribute(OxOd1b8[127]);} ;inp_width[OxOd1b8[16]]=element[OxOd1b8[120]]||OxOd1b8[15];inp_height[OxOd1b8[16]]=element[OxOd1b8[128]]||OxOd1b8[15];inp_id[OxOd1b8[16]]=element[OxOd1b8[53]]||OxOd1b8[15];if(element[OxOd1b8[129]]<=0){VSpace[OxOd1b8[16]]=OxOd1b8[15];} else {VSpace[OxOd1b8[16]]=element[OxOd1b8[129]];} ;if(element[OxOd1b8[130]]<=0){HSpace[OxOd1b8[16]]=OxOd1b8[15];} else {HSpace[OxOd1b8[16]]=element[OxOd1b8[130]];} ;Border[OxOd1b8[16]]=element[OxOd1b8[131]]||OxOd1b8[15];if(Browser_IsWinIE()){bordercolor[OxOd1b8[16]]=element[OxOd1b8[3]][OxOd1b8[132]];} else {var arr=revertColor(element[OxOd1b8[3]].borderColor).split(OxOd1b8[51]);bordercolor[OxOd1b8[16]]=arr[0];} ;bordercolor[OxOd1b8[3]][OxOd1b8[133]]=bordercolor[OxOd1b8[16]]||OxOd1b8[15];bordercolor_Preview[OxOd1b8[3]][OxOd1b8[133]]=bordercolor[OxOd1b8[16]]||OxOd1b8[15];Align[OxOd1b8[16]]=element[OxOd1b8[134]]||OxOd1b8[15];AlternateText[OxOd1b8[16]]=element[OxOd1b8[135]]||OxOd1b8[15];longDesc[OxOd1b8[16]]=element.getAttribute(OxOd1b8[136])||OxOd1b8[15];if(TargetUrl[OxOd1b8[16]]){Actualsize();} else {if(element&&src){TargetUrl[OxOd1b8[16]]=src;} ;} ;var sCheckFlag=OxOd1b8[137];function ResetFields(){TargetUrl[OxOd1b8[16]]=OxOd1b8[15];inp_width[OxOd1b8[16]]=OxOd1b8[15];inp_height[OxOd1b8[16]]=OxOd1b8[15];inp_id[OxOd1b8[16]]=OxOd1b8[15];VSpace[OxOd1b8[16]]=OxOd1b8[15];HSpace[OxOd1b8[16]]=OxOd1b8[15];Border[OxOd1b8[16]]=OxOd1b8[15];bordercolor[OxOd1b8[16]]=OxOd1b8[15];bordercolor[OxOd1b8[3]][OxOd1b8[133]]=OxOd1b8[15];Align[OxOd1b8[16]]=OxOd1b8[15];AlternateText[OxOd1b8[16]]=OxOd1b8[15];longDesc[OxOd1b8[16]]=OxOd1b8[15];} ;function do_preview(){var Ox232=TargetUrl[OxOd1b8[16]];if(Ox232==null){TargetUrl[OxOd1b8[16]]=OxOd1b8[15];Ox232==OxOd1b8[15];} ;if(Ox232!=null&&Ox232!=OxOd1b8[15]){var Ox425;var Ox426;var Ox425=document.createElement(OxOd1b8[138]);Ox425[OxOd1b8[126]]=Ox232;function Ox427(){if(Ox425[OxOd1b8[139]]){window.clearInterval(Ox426);var Oxa7= new Date();var Oxa8=Oxa7.getTime();if(Ox232==OxOd1b8[15]){Ox232=OxOd1b8[140];} ;if(Ox232.indexOf(OxOd1b8[141])!=-1){Ox232=Ox232+OxOd1b8[142]+Oxa8;} else {Ox232=Ox232+OxOd1b8[143]+Oxa8;} ;if(inp_width[OxOd1b8[16]]==OxOd1b8[144]||inp_width[OxOd1b8[16]]==OxOd1b8[15]){inp_width[OxOd1b8[16]]=Ox425[OxOd1b8[120]];inp_height[OxOd1b8[16]]=Ox425[OxOd1b8[128]];} ;img_demo[OxOd1b8[126]]=Ox232;if(Browser_IsWinIE()){Event_Attach(img_demo,OxOd1b8[145],OnImageMouseWheel);} ;img_demo[OxOd1b8[135]]=AlternateText[OxOd1b8[16]];img_demo[OxOd1b8[134]]=Align[OxOd1b8[16]];img_demo[OxOd1b8[129]]=VSpace[OxOd1b8[16]];img_demo[OxOd1b8[130]]=HSpace[OxOd1b8[16]];if(parseInt(Border.value)>0){img_demo[OxOd1b8[131]]=Border[OxOd1b8[16]];} ;if(bordercolor[OxOd1b8[16]]!=OxOd1b8[15]){img_demo[OxOd1b8[3]][OxOd1b8[132]]=bordercolor[OxOd1b8[16]];} ;Ox232=Ox232.toLowerCase();if(Ox232.indexOf(OxOd1b8[146])!=-1){img_AutoThumbnail[OxOd1b8[3]][OxOd1b8[147]]=OxOd1b8[148];if(img_ImageEditor){img_ImageEditor[OxOd1b8[3]][OxOd1b8[147]]=OxOd1b8[148];} ;} ;} ;} ;Ox426=window.setInterval(Ox427,100);} ;} ;function do_insert(){var img=element;img[OxOd1b8[126]]=TargetUrl[OxOd1b8[16]];if(editor.GetActiveTab()==OxOd1b8[149]){img.setAttribute(OxOd1b8[127],TargetUrl.value);} ;if(width_height_setted){img[OxOd1b8[120]]=inp_width[OxOd1b8[16]];img[OxOd1b8[128]]=inp_height[OxOd1b8[16]];} ;if(img[OxOd1b8[3]][OxOd1b8[120]]||img[OxOd1b8[3]][OxOd1b8[128]]){img[OxOd1b8[3]][OxOd1b8[120]]=inp_width[OxOd1b8[16]];img[OxOd1b8[3]][OxOd1b8[128]]=inp_height[OxOd1b8[16]];} ;img[OxOd1b8[129]]=VSpace[OxOd1b8[16]];img[OxOd1b8[130]]=HSpace[OxOd1b8[16]];img[OxOd1b8[131]]=Border[OxOd1b8[16]];var Ox376=/[^a-z\d]/i;if(Ox376.test(inp_id.value)){alert(OxOd1b8[150]);return ;} ;img[OxOd1b8[53]]=inp_id[OxOd1b8[16]];try{img[OxOd1b8[3]][OxOd1b8[132]]=bordercolor[OxOd1b8[16]];} catch(er){alert(OxOd1b8[151]);return false;} ;img[OxOd1b8[134]]=Align[OxOd1b8[16]];img[OxOd1b8[135]]=AlternateText[OxOd1b8[16]]||OxOd1b8[15];img.setAttribute(OxOd1b8[106],longDesc.value);if(TargetUrl[OxOd1b8[16]]==OxOd1b8[15]){alert(OxOd1b8[152]);return false;} ;if(img[OxOd1b8[120]]==0){img.removeAttribute(OxOd1b8[120]);} ;if(img[OxOd1b8[128]]==0){img.removeAttribute(OxOd1b8[128]);} ;if(!img.getAttribute(OxOd1b8[136])){img.removeAttribute(OxOd1b8[136]);} ;if(img[OxOd1b8[130]]==OxOd1b8[15]){img.removeAttribute(OxOd1b8[130]);} ;if(img[OxOd1b8[129]]==OxOd1b8[15]){img.removeAttribute(OxOd1b8[129]);} ;if(img[OxOd1b8[53]]==OxOd1b8[15]){img.removeAttribute(OxOd1b8[53]);} ;if(img[OxOd1b8[131]]==OxOd1b8[15]){img.removeAttribute(OxOd1b8[131]);} ;if(img[OxOd1b8[134]]==OxOd1b8[15]){img.removeAttribute(OxOd1b8[134]);} ;if(!img[OxOd1b8[23]]){editor.InsertElement(img);} ;Window_CloseDialog(window);} ;function attr(name,Ox4f){if(!Ox4f||Ox4f==OxOd1b8[15]){return OxOd1b8[15];} ;return OxOd1b8[51]+name+OxOd1b8[153]+Ox4f+OxOd1b8[154];} ;function do_Close(){Window_CloseDialog(window);} ;function Zoom_In(){if(Browser_IsWinIE()){if(divpreview[OxOd1b8[3]][OxOd1b8[2]]!=0){divpreview[OxOd1b8[3]][OxOd1b8[2]]*=1.2;} else {divpreview[OxOd1b8[3]][OxOd1b8[2]]=1.2;} ;} ;} ;function Zoom_Out(){if(Browser_IsWinIE()){if(divpreview[OxOd1b8[3]][OxOd1b8[2]]!=0){divpreview[OxOd1b8[3]][OxOd1b8[2]]*=0.8;} else {divpreview[OxOd1b8[3]][OxOd1b8[2]]=0.8;} ;} ;} ;function BestFit(){var img=img_demo;if(!img){return ;} ;var Ox73=280;var Ox74=290;if(Browser_IsWinIE()){divpreview[OxOd1b8[3]][OxOd1b8[2]]=1/Math.max(img[OxOd1b8[120]]/Ox74,img[OxOd1b8[128]]/Ox73);} ;} ;function Actualsize(){inp_width[OxOd1b8[16]]=OxOd1b8[15];inp_height[OxOd1b8[16]]=OxOd1b8[15];do_preview();if(Browser_IsWinIE()){divpreview[OxOd1b8[3]][OxOd1b8[2]]=1;} ;} ;function toggleConstrains(){if(constrain_prop[OxOd1b8[155]]){imgLock[OxOd1b8[126]]=OxOd1b8[156];checkConstrains(OxOd1b8[120]);} else {imgLock[OxOd1b8[126]]=OxOd1b8[157];} ;} ;var checkingConstrains=false;var width_height_setted;function checkConstrains(Ox7a){if(checkingConstrains){return ;} ;checkingConstrains=true;try{if(constrain_prop[OxOd1b8[155]]){var Ox7d=document.createElement(OxOd1b8[138]);Ox7d[OxOd1b8[126]]=TargetUrl[OxOd1b8[16]];var Ox429=Ox7d[OxOd1b8[120]];var Ox42a=Ox7d[OxOd1b8[128]];if((Ox429>0)&&(Ox42a>0)){var Ox74=inp_width[OxOd1b8[16]];var Ox73=inp_height[OxOd1b8[16]];if(Ox7a==OxOd1b8[120]){if(Ox74[OxOd1b8[36]]==0||isNaN(Ox74)){inp_width[OxOd1b8[16]]=OxOd1b8[15];inp_height[OxOd1b8[16]]=OxOd1b8[15];} else {Ox73=parseInt(Ox74*Ox42a/Ox429);if(inp_height[OxOd1b8[16]]!=Ox73){width_height_setted=true;inp_height[OxOd1b8[16]]=Ox73;} ;} ;} ;if(Ox7a==OxOd1b8[128]){if(Ox73[OxOd1b8[36]]==0||isNaN(Ox73)){inp_width[OxOd1b8[16]]=OxOd1b8[15];inp_height[OxOd1b8[16]]=OxOd1b8[15];} else {Ox74=parseInt(Ox73*Ox429/Ox42a);if(inp_width[OxOd1b8[16]]!=Ox74){width_height_setted=true;inp_width[OxOd1b8[16]]=Ox74;} ;} ;} ;} ;} ;do_preview();} finally{checkingConstrains=false;} ;} ;function AutoThumbnail(){if(TargetUrl[OxOd1b8[16]]==OxOd1b8[15]){alert(OxOd1b8[158]);return false;} ;var obj= new Object();obj[OxOd1b8[126]]=TargetUrl[OxOd1b8[16]];obj[OxOd1b8[159]]=FolderDescription[OxOd1b8[56]]+OxOd1b8[15];function Ox35d(Ox20a){if(Ox20a){TargetUrl[OxOd1b8[16]]=Ox20a;hiddenAction[OxOd1b8[16]]=OxOd1b8[160];window.PostBackAction();} ;} ;editor.SetNextDialogWindow(window);editor.ShowDialog(Ox35d,OxOd1b8[161]+GetDialogQueryString(),obj,OxOd1b8[162]);} ;function GetDialogQueryString(){var Ox120=OxOd1b8[15];if(editor.GetScriptProperty(OxOd1b8[163])==OxOd1b8[164]){Ox120=OxOd1b8[165];} ;return OxOd1b8[166]+editor.GetScriptProperty(OxOd1b8[167])+OxOd1b8[168]+editor.GetScriptProperty(OxOd1b8[169])+Ox120+OxOd1b8[170]+editor.GetScriptProperty(OxOd1b8[171]);} ;function ImageEditor(){var src=TargetUrl[OxOd1b8[16]];if(src==OxOd1b8[15]){alert(OxOd1b8[172]);return false;} ;if(src.charAt(0)!=OxOd1b8[19]){return ;} ;var img=document.createElement(OxOd1b8[138]);img[OxOd1b8[126]]=src;var p=OxOd1b8[173];function Ox35d(arr){TargetUrl[OxOd1b8[16]]=src;do_preview();} ;editor.SetNextDialogWindow(window);editor.ShowDialog(Ox35d,OxOd1b8[174]+src+OxOd1b8[175]+p+OxOd1b8[176]+editor.GetScriptProperty(OxOd1b8[167]),img,OxOd1b8[177]);} ;bordercolor[OxOd1b8[178]]=bordercolor_Preview[OxOd1b8[178]]=function bordercolor_onclick(){SelectColor(bordercolor,bordercolor_Preview);} ;if(!Browser_IsWinIE()){img_ImageEditor[OxOd1b8[3]][OxOd1b8[147]]=btn_zoom_in[OxOd1b8[3]][OxOd1b8[147]]=btn_zoom_out[OxOd1b8[3]][OxOd1b8[147]]=btn_bestfit[OxOd1b8[3]][OxOd1b8[147]]=btn_Actualsize[OxOd1b8[3]][OxOd1b8[147]]=OxOd1b8[148];} ;if(Browser_IsIE7()){var _dialogPromptID=null;function IEprompt(Ox221,Ox222,Ox223){that=this;this[OxOd1b8[179]]=function (Ox224){val=document.getElementById(OxOd1b8[180])[OxOd1b8[16]];_dialogPromptID[OxOd1b8[3]][OxOd1b8[147]]=OxOd1b8[148];document.getElementById(OxOd1b8[180])[OxOd1b8[16]]=OxOd1b8[15];if(Ox224){val=OxOd1b8[15];} ;Ox221(val);return false;} ;if(Ox223==undefined){Ox223=OxOd1b8[15];} ;if(_dialogPromptID==null){var Ox225=document.getElementsByTagName(OxOd1b8[181])[0];tnode=document.createElement(OxOd1b8[182]);tnode[OxOd1b8[53]]=OxOd1b8[183];Ox225.appendChild(tnode);_dialogPromptID=document.getElementById(OxOd1b8[183]);tnode=document.createElement(OxOd1b8[182]);tnode[OxOd1b8[53]]=OxOd1b8[184];Ox225.appendChild(tnode);_dialogPromptID[OxOd1b8[3]][OxOd1b8[131]]=OxOd1b8[185];_dialogPromptID[OxOd1b8[3]][OxOd1b8[133]]=OxOd1b8[186];_dialogPromptID[OxOd1b8[3]][OxOd1b8[187]]=OxOd1b8[188];_dialogPromptID[OxOd1b8[3]][OxOd1b8[120]]=OxOd1b8[189];_dialogPromptID[OxOd1b8[3]][OxOd1b8[190]]=OxOd1b8[191];} ;var Ox226=OxOd1b8[192];Ox226+=OxOd1b8[193]+Ox222+OxOd1b8[194];Ox226+=OxOd1b8[195];Ox226+=OxOd1b8[196]+Ox223+OxOd1b8[197];Ox226+=OxOd1b8[198];Ox226+=OxOd1b8[199];Ox226+=OxOd1b8[200];Ox226+=OxOd1b8[201];Ox226+=OxOd1b8[202];_dialogPromptID[OxOd1b8[56]]=Ox226;_dialogPromptID[OxOd1b8[3]][OxOd1b8[5]]=OxOd1b8[203];_dialogPromptID[OxOd1b8[3]][OxOd1b8[204]]=parseInt((document[OxOd1b8[181]][OxOd1b8[205]]-315)/2)+OxOd1b8[206];_dialogPromptID[OxOd1b8[3]][OxOd1b8[147]]=OxOd1b8[207];var Ox227=document.getElementById(OxOd1b8[180]);try{var Ox228=Ox227.createTextRange();Ox228.collapse(false);Ox228.select();} catch(x){Ox227.focus();} ;} ;} ;if(CreateDir){CreateDir[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(Copy){Copy[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(Move){Move[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(Delete){Delete[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(DoRefresh){DoRefresh[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(btn_zoom_in){btn_zoom_in[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(btn_zoom_out){btn_zoom_out[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(btn_Actualsize){btn_Actualsize[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(img_ImageEditor){img_ImageEditor[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(btn_bestfit){btn_bestfit[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;if(img_AutoThumbnail){img_AutoThumbnail[OxOd1b8[37]]= new Function(OxOd1b8[208]);} ;