var OxOe5bd=["inp_src","btnbrowse","AlternateText","inp_id","longDesc","Align","optNotSet","optLeft","optRight","optTexttop","optAbsMiddle","optBaseline","optAbsBottom","optBottom","optMiddle","optTop","Border","bordercolor","bordercolor_Preview","inp_width","imgLock","inp_height","constrain_prop","HSpace","VSpace","outer","img_demo","onclick","IMG","src","width","height","value","cssText","style","","src_cetemp","id","vspace","hspace","border","borderColor"," ","backgroundColor","align","alt","[[ValidNumber]]","[[ValidID]]","checked","Load.ashx?type=image\x26file=locked.gif","Load.ashx?type=image\x26file=1x1.gif","length"];var inp_src=Window_GetElement(window,OxOe5bd[0],true);var btnbrowse=Window_GetElement(window,OxOe5bd[1],true);var AlternateText=Window_GetElement(window,OxOe5bd[2],true);var inp_id=Window_GetElement(window,OxOe5bd[3],true);var longDesc=Window_GetElement(window,OxOe5bd[4],true);var Align=Window_GetElement(window,OxOe5bd[5],true);var optNotSet=Window_GetElement(window,OxOe5bd[6],true);var optLeft=Window_GetElement(window,OxOe5bd[7],true);var optRight=Window_GetElement(window,OxOe5bd[8],true);var optTexttop=Window_GetElement(window,OxOe5bd[9],true);var optAbsMiddle=Window_GetElement(window,OxOe5bd[10],true);var optBaseline=Window_GetElement(window,OxOe5bd[11],true);var optAbsBottom=Window_GetElement(window,OxOe5bd[12],true);var optBottom=Window_GetElement(window,OxOe5bd[13],true);var optMiddle=Window_GetElement(window,OxOe5bd[14],true);var optTop=Window_GetElement(window,OxOe5bd[15],true);var Border=Window_GetElement(window,OxOe5bd[16],true);var bordercolor=Window_GetElement(window,OxOe5bd[17],true);var bordercolor_Preview=Window_GetElement(window,OxOe5bd[18],true);var inp_width=Window_GetElement(window,OxOe5bd[19],true);var imgLock=Window_GetElement(window,OxOe5bd[20],true);var inp_height=Window_GetElement(window,OxOe5bd[21],true);var constrain_prop=Window_GetElement(window,OxOe5bd[22],true);var HSpace=Window_GetElement(window,OxOe5bd[23],true);var VSpace=Window_GetElement(window,OxOe5bd[24],true);var outer=Window_GetElement(window,OxOe5bd[25],true);var img_demo=Window_GetElement(window,OxOe5bd[26],true);btnbrowse[OxOe5bd[27]]=function btnbrowse_onclick(){function Ox35d(Ox13e){if(Ox13e){function Actualsize(){var Ox7d=document.createElement(OxOe5bd[28]);Ox7d[OxOe5bd[29]]=Ox13e;if(Ox7d[OxOe5bd[30]]>0&&Ox7d[OxOe5bd[31]]>0){inp_width[OxOe5bd[32]]=Ox7d[OxOe5bd[30]];inp_height[OxOe5bd[32]]=Ox7d[OxOe5bd[31]];FireUIChanged();} else {setTimeout(Actualsize,400);} ;} ;inp_src[OxOe5bd[32]]=Ox13e;FireUIChanged();setTimeout(Actualsize,400);} ;} ;editor.SetNextDialogWindow(window);if(Browser_IsSafari()){editor.ShowSelectImageDialog(Ox35d,inp_src.value,inp_src);} else {editor.ShowSelectImageDialog(Ox35d,inp_src.value);} ;} ;UpdateState=function UpdateState_Image(){img_demo[OxOe5bd[34]][OxOe5bd[33]]=element[OxOe5bd[34]][OxOe5bd[33]];if(Browser_IsWinIE()){img_demo.mergeAttributes(element);} ;if(element[OxOe5bd[29]]){img_demo[OxOe5bd[29]]=element[OxOe5bd[29]];} else {img_demo.removeAttribute(OxOe5bd[29]);} ;} ;SyncToView=function SyncToView_Image(){var src;src=element.getAttribute(OxOe5bd[29])+OxOe5bd[35];if(element.getAttribute(OxOe5bd[36])){src=element.getAttribute(OxOe5bd[36])+OxOe5bd[35];} ;inp_src[OxOe5bd[32]]=src;inp_width[OxOe5bd[32]]=element[OxOe5bd[30]];inp_height[OxOe5bd[32]]=element[OxOe5bd[31]];inp_id[OxOe5bd[32]]=element[OxOe5bd[37]];if(element[OxOe5bd[38]]<=0){VSpace[OxOe5bd[32]]=OxOe5bd[35];} else {VSpace[OxOe5bd[32]]=element[OxOe5bd[38]];} ;if(element[OxOe5bd[39]]<=0){HSpace[OxOe5bd[32]]=OxOe5bd[35];} else {HSpace[OxOe5bd[32]]=element[OxOe5bd[39]];} ;Border[OxOe5bd[32]]=element[OxOe5bd[40]];if(Browser_IsWinIE()){bordercolor[OxOe5bd[32]]=element[OxOe5bd[34]][OxOe5bd[41]];} else {var arr=revertColor(element[OxOe5bd[34]].borderColor).split(OxOe5bd[42]);bordercolor[OxOe5bd[32]]=arr[0];} ;bordercolor[OxOe5bd[34]][OxOe5bd[43]]=bordercolor[OxOe5bd[32]]||OxOe5bd[35];bordercolor[OxOe5bd[34]][OxOe5bd[43]]=bordercolor[OxOe5bd[32]];bordercolor_Preview[OxOe5bd[34]][OxOe5bd[43]]=bordercolor[OxOe5bd[32]];Align[OxOe5bd[32]]=element[OxOe5bd[44]];AlternateText[OxOe5bd[32]]=element[OxOe5bd[45]];longDesc[OxOe5bd[32]]=element.getAttribute(OxOe5bd[4]);} ;SyncTo=function SyncTo_Image(element){element[OxOe5bd[29]]=inp_src[OxOe5bd[32]];element.setAttribute(OxOe5bd[36],inp_src.value);element[OxOe5bd[40]]=Border[OxOe5bd[32]];element[OxOe5bd[39]]=HSpace[OxOe5bd[32]];element[OxOe5bd[38]]=VSpace[OxOe5bd[32]];try{element[OxOe5bd[30]]=inp_width[OxOe5bd[32]];element[OxOe5bd[31]]=inp_height[OxOe5bd[32]];} catch(er){alert(OxOe5bd[46]);return false;} ;if(element[OxOe5bd[34]][OxOe5bd[30]]||element[OxOe5bd[34]][OxOe5bd[31]]){try{element[OxOe5bd[34]][OxOe5bd[30]]=inp_width[OxOe5bd[32]];element[OxOe5bd[34]][OxOe5bd[31]]=inp_height[OxOe5bd[32]];} catch(er){alert(OxOe5bd[46]);return false;} ;} ;var Ox376=/[^a-z\d]/i;if(Ox376.test(inp_id.value)){alert(OxOe5bd[47]);return ;} ;var Ox4f1=longDesc[OxOe5bd[32]];element[OxOe5bd[37]]=inp_id[OxOe5bd[32]];element[OxOe5bd[44]]=Align[OxOe5bd[32]];element[OxOe5bd[45]]=AlternateText[OxOe5bd[32]];if(Ox4f1){element.setAttribute(OxOe5bd[4],Ox4f1);} else {element.removeAttribute(OxOe5bd[4]);} ;element[OxOe5bd[34]][OxOe5bd[41]]=bordercolor[OxOe5bd[32]];if(element[OxOe5bd[30]]==0){element.removeAttribute(OxOe5bd[30]);} ;if(element[OxOe5bd[31]]==0){element.removeAttribute(OxOe5bd[31]);} ;if(element[OxOe5bd[39]]==OxOe5bd[35]){element.removeAttribute(OxOe5bd[39]);} ;if(element[OxOe5bd[38]]==OxOe5bd[35]){element.removeAttribute(OxOe5bd[38]);} ;if(element[OxOe5bd[37]]==OxOe5bd[35]){element.removeAttribute(OxOe5bd[37]);} ;if(element[OxOe5bd[44]]==OxOe5bd[35]){element.removeAttribute(OxOe5bd[44]);} ;if(element[OxOe5bd[40]]==OxOe5bd[35]){element.removeAttribute(OxOe5bd[40]);} ;} ;function toggleConstrains(){if(constrain_prop[OxOe5bd[48]]){imgLock[OxOe5bd[29]]=OxOe5bd[49];checkConstrains(OxOe5bd[30]);} else {imgLock[OxOe5bd[29]]=OxOe5bd[50];} ;} ;var checkingConstrains=false;function checkConstrains(Ox7a){if(checkingConstrains){return ;} ;checkingConstrains=true;try{var Ox8,Ox2d;if(constrain_prop[OxOe5bd[48]]){var Ox7d=document.createElement(OxOe5bd[28]);Ox7d[OxOe5bd[29]]=inp_src[OxOe5bd[32]];var Ox429=Ox7d[OxOe5bd[30]];var Ox42a=Ox7d[OxOe5bd[31]];if((Ox429>0)&&(Ox42a>0)){var Ox74=inp_width[OxOe5bd[32]];var Ox73=inp_height[OxOe5bd[32]];if(Ox7a==OxOe5bd[30]){if(Ox74[OxOe5bd[51]]==0||isNaN(Ox74)){inp_width[OxOe5bd[32]]=OxOe5bd[35];inp_height[OxOe5bd[32]]=OxOe5bd[35];} else {Ox73=parseInt(Ox74*Ox42a/Ox429);inp_height[OxOe5bd[32]]=Ox73;} ;} ;if(Ox7a==OxOe5bd[31]){if(Ox73[OxOe5bd[51]]==0||isNaN(Ox73)){inp_width[OxOe5bd[32]]=OxOe5bd[35];inp_height[OxOe5bd[32]]=OxOe5bd[35];} else {Ox74=parseInt(Ox73*Ox429/Ox42a);inp_width[OxOe5bd[32]]=Ox74;} ;} ;} ;} ;} finally{checkingConstrains=false;} ;} ;bordercolor[OxOe5bd[27]]=bordercolor_Preview[OxOe5bd[27]]=function bordercolor_onclick(){SelectColor(bordercolor,bordercolor_Preview);} ;