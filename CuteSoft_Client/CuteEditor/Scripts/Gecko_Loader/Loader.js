var OxO6a5b=["ua","userAgent","isOpera","opera","isSafari","safari","isGecko","gecko","isWinIE","msie","compatMode","document","CSS1Compat","undefined","Microsoft.XMLHTTP","readyState","onreadystatechange","","length","all","childNodes","nodeType","\x0D\x0A","caller","onchange","oninitialized","command","commandui","commandvalue","returnValue","oncommand","string","_fireEventFunction","event","parentNode","_IsCuteEditor","True","value","arguments","target","nodeName","SELECT","OPTION","readOnly","_IsRichDropDown","null","selectedIndex","TR","cells","display","style","nextSibling","innerHTML","\x3Cimg src=\x22","/Load.ashx?type=image\x26file=t-minus.gif\x22\x3E","onclick","CuteEditor_CollapseTreeDropDownItem(this,\x22","\x22)","none","/Load.ashx?type=image\x26file=t-plus.gif\x22\x3E","CuteEditor_ExpandTreeDropDownItem(this,\x22","contains","UNSELECTABLE","on","tabIndex","-1","//TODO: event not found? throw error ?","contentWindow","contentDocument","parentWindow","id","frames","frameElement","//TODO:frame contentWindow not found?","preventDefault","parent","top","opener","head","script","language","javascript","type","text/javascript","src","srcElement","//TODO: srcElement not found? throw error ?","fromElement","relatedTarget","toElement","keyCode","clientX","clientY","offsetX","offsetY","button","ctrlKey","altKey","shiftKey","cancelBubble","stopPropagation","CuteEditor_GetEditor(this).ExecImageCommand(this.getAttribute(\x27Command\x27),this.getAttribute(\x27CommandUI\x27),this.getAttribute(\x27CommandArgument\x27),this)","CuteEditor_GetEditor(this).PostBack(this.getAttribute(\x27Command\x27))","this.onmouseout();CuteEditor_GetEditor(this).DropMenu(this.getAttribute(\x27Group\x27),this)","ResourceDir","Theme","/Load.ashx?type=theme\x26theme=","\x26file=all.png","/Images/blank2020.gif","IMG","alt","title","Command","Group","ThemeIndex","width","20px","height","backgroundImage","url(",")","backgroundPosition","0 -","px","onload","className","separator","CuteEditorButton","onmouseover","CuteEditor_ButtonCommandOver(this)","onmouseout","CuteEditor_ButtonCommandOut(this)","onmousedown","CuteEditor_ButtonCommandDown(this)","onmouseup","CuteEditor_ButtonCommandUp(this)","oncontextmenu","ondragstart","PostBack","ondblclick","_ToolBarID","_CodeViewToolBarID","_FrameID"," CuteEditorFrame"," CuteEditorToolbar","cursor","no-drop","ActiveTab","Edit","Code","View","buttonInitialized","isover","CuteEditorButtonOver","CuteEditorButtonDown","CuteEditorDown","border","solid 1px #0A246A","backgroundColor","#b6bdd2","padding","1px","solid 1px #f5f5f4","inset 1px","IsCommandDisabled","CuteEditorButtonDisabled","IsCommandActive","CuteEditorButtonActive","cmd_fromfullpage","(","href","location",",DanaInfo=",",","+","scriptProperties","initfuncbecalled","GetScriptProperty","/Load.ashx?type=scripts\x26file=Gecko_Implementation\x26culture=","Culture","CuteEditorImplementation","function","POST","\x26getModified=1\x26_temp=","status","responseText","GET","\x26modified=","body","block","contentEditable","InitializeCode","inittime","CuteEditorInitialize"];var _Browser_TypeInfo=null;function Browser__InitType(){if(_Browser_TypeInfo!=null){return ;} ;var Ox4={};Ox4[OxO6a5b[0]]=navigator[OxO6a5b[1]].toLowerCase();Ox4[OxO6a5b[2]]=(Ox4[OxO6a5b[0]].indexOf(OxO6a5b[3])>-1);Ox4[OxO6a5b[4]]=(Ox4[OxO6a5b[0]].indexOf(OxO6a5b[5])>-1);Ox4[OxO6a5b[6]]=(!Ox4[OxO6a5b[2]]&&Ox4[OxO6a5b[0]].indexOf(OxO6a5b[7])>-1);Ox4[OxO6a5b[8]]=(!Ox4[OxO6a5b[2]]&&Ox4[OxO6a5b[0]].indexOf(OxO6a5b[9])>-1);_Browser_TypeInfo=Ox4;} ;Browser__InitType();function Browser_IsWinIE(){return _Browser_TypeInfo[OxO6a5b[8]];} ;function Browser_IsGecko(){return _Browser_TypeInfo[OxO6a5b[6]];} ;function Browser_IsOpera(){return _Browser_TypeInfo[OxO6a5b[2]];} ;function Browser_IsSafari(){return _Browser_TypeInfo[OxO6a5b[4]];} ;function Browser_UseIESelection(){return _Browser_TypeInfo[OxO6a5b[8]];} ;function Browser_IsCSS1Compat(){return window[OxO6a5b[11]][OxO6a5b[10]]==OxO6a5b[12];} ;function CreateXMLHttpRequest(){try{if( typeof (XMLHttpRequest)!=OxO6a5b[13]){return  new XMLHttpRequest();} ;if( typeof (ActiveXObject)!=OxO6a5b[13]){return  new ActiveXObject(OxO6a5b[14]);} ;} catch(x){return null;} ;} ;function LoadXMLAsync(Oxa5d,Ox288,Ox235,Oxa5e){var Oxe7=CreateXMLHttpRequest();function Oxa5f(){if(Oxe7[OxO6a5b[15]]!=4){return ;} ;Oxe7[OxO6a5b[16]]= new Function();var Ox290=Oxe7;Oxe7=null;if(Ox235){Ox235(Ox290);} ;} ;Oxe7[OxO6a5b[16]]=Oxa5f;Oxe7.open(Oxa5d,Ox288,true);Oxe7.send(Oxa5e||OxO6a5b[17]);} ;function Element_GetAllElements(p){var arr=[];if(Browser_IsWinIE()){for(var i=0;i<p[OxO6a5b[19]][OxO6a5b[18]];i++){arr.push(p[OxO6a5b[19]].item(i));} ;return arr;} ;Ox242(p);function Ox242(Ox29){var Ox217=Ox29[OxO6a5b[20]];var Ox11=Ox217[OxO6a5b[18]];for(var i=0;i<Ox11;i++){var Ox27=Ox217.item(i);if(Ox27[OxO6a5b[21]]!=1){continue ;} ;arr.push(Ox27);Ox242(Ox27);} ;} ;return arr;} ;var __ISDEBUG=false;function Debug_Todo(msg){if(!__ISDEBUG){return ;} ;throw ( new Error(msg+OxO6a5b[22]+Debug_Todo[OxO6a5b[23]]));} ;function Window_GetElement(Ox1a8,Ox9a,Ox240){var Ox29=Ox1a8[OxO6a5b[11]].getElementById(Ox9a);if(Ox29){return Ox29;} ;var Ox31=Ox1a8[OxO6a5b[11]].getElementsByName(Ox9a);if(Ox31[OxO6a5b[18]]>0){return Ox31.item(0);} ;return null;} ;function CuteEditor_AddMainMenuItems(Ox66a){} ;function CuteEditor_AddDropMenuItems(Ox66a,Ox671){} ;function CuteEditor_AddTagMenuItems(Ox66a,Ox673){} ;function CuteEditor_AddVerbMenuItems(Ox66a,Ox673){} ;function CuteEditor_OnInitialized(editor){} ;function CuteEditor_OnCommand(editor,Ox4d,Ox4e,Ox4f){} ;function CuteEditor_OnChange(editor){} ;function CuteEditor_FilterCode(editor,Ox26b){return Ox26b;} ;function CuteEditor_FilterHTML(editor,Ox283){return Ox283;} ;function CuteEditor_FireChange(editor){window.CuteEditor_OnChange(editor);CuteEditor_FireEvent(editor,OxO6a5b[24],null);} ;function CuteEditor_FireInitialized(editor){window.CuteEditor_OnInitialized(editor);CuteEditor_FireEvent(editor,OxO6a5b[25],null);} ;function CuteEditor_FireCommand(editor,Ox4d,Ox4e,Ox4f){var Ox13e=window.CuteEditor_OnCommand(editor,Ox4d,Ox4e,Ox4f);if(Ox13e==true){return true;} ;var Ox67c={};Ox67c[OxO6a5b[26]]=Ox4d;Ox67c[OxO6a5b[27]]=Ox4e;Ox67c[OxO6a5b[28]]=Ox4f;Ox67c[OxO6a5b[29]]=true;CuteEditor_FireEvent(editor,OxO6a5b[30],Ox67c);if(Ox67c[OxO6a5b[29]]==false){return true;} ;} ;function CuteEditor_FireEvent(editor,Ox67e,Ox67f){if(Ox67f==null){Ox67f={};} ;var Ox680=editor.getAttribute(Ox67e);if(Ox680){if( typeof (Ox680)==OxO6a5b[31]){editor[OxO6a5b[32]]= new Function(OxO6a5b[33],Ox680);} else {editor[OxO6a5b[32]]=Ox680;} ;editor._fireEventFunction(Ox67f);} ;} ;function CuteEditor_GetEditor(element){for(var Ox43=element;Ox43!=null;Ox43=Ox43[OxO6a5b[34]]){if(Ox43.getAttribute(OxO6a5b[35])==OxO6a5b[36]){return Ox43;} ;} ;return null;} ;function CuteEditor_DropDownCommand(element,Oxa61){var Ox142=element[OxO6a5b[37]];if(CuteEditor_DropDownCommand[OxO6a5b[23]]){var Ox43=CuteEditor_DropDownCommand[OxO6a5b[23]][OxO6a5b[38]][0];if(Ox43&&Ox43[OxO6a5b[39]]){if(Ox43[OxO6a5b[39]][OxO6a5b[40]]==OxO6a5b[41]){return ;} ;if(Ox43[OxO6a5b[39]][OxO6a5b[40]]==OxO6a5b[42]){Ox142=Ox43[OxO6a5b[39]][OxO6a5b[37]];} ;} ;} ;var editor=CuteEditor_GetEditor(element);if(editor[OxO6a5b[43]]){return ;} ;if(element.getAttribute(OxO6a5b[44])==OxO6a5b[36]){var Ox142=element.GetValue();if(Ox142==OxO6a5b[45]){Ox142=OxO6a5b[17];} ;var Ox201=element.GetText();if(Ox201==OxO6a5b[45]){Ox201=OxO6a5b[17];} ;element.SetSelectedIndex(0);editor.ExecCommand(Oxa61,false,Ox142,Ox201);} else {if(Ox142){if(Ox142==OxO6a5b[45]){Ox142=OxO6a5b[17];} ;element[OxO6a5b[46]]=0;editor.ExecCommand(Oxa61,false,Ox142,Ox201);} else {element[OxO6a5b[46]]=0;} ;} ;editor.FocusDocument();} ;function CuteEditor_ExpandTreeDropDownItem(src,Ox740){var Oxba=null;while(src!=null){if(src[OxO6a5b[40]]==OxO6a5b[47]){Oxba=src;break ;} ;src=src[OxO6a5b[34]];} ;var Ox1e4=Oxba[OxO6a5b[48]].item(0);Oxba[OxO6a5b[51]][OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[17];Ox1e4[OxO6a5b[52]]=OxO6a5b[53]+Ox740+OxO6a5b[54];Oxba[OxO6a5b[55]]= new Function(OxO6a5b[56]+Ox740+OxO6a5b[57]);} ;function CuteEditor_CollapseTreeDropDownItem(src,Ox740){var Oxba=null;while(src!=null){if(src[OxO6a5b[40]]==OxO6a5b[47]){Oxba=src;break ;} ;src=src[OxO6a5b[34]];} ;var Ox1e4=Oxba[OxO6a5b[48]].item(0);Oxba[OxO6a5b[51]][OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[58];Ox1e4[OxO6a5b[52]]=OxO6a5b[53]+Ox740+OxO6a5b[59];Oxba[OxO6a5b[55]]= new Function(OxO6a5b[60]+Ox740+OxO6a5b[57]);} ;function Element_Contains(element,Ox183){if(!Browser_IsOpera()){if(element[OxO6a5b[61]]){return element.contains(Ox183);} ;} ;for(;Ox183!=null;Ox183=Ox183[OxO6a5b[34]]){if(element==Ox183){return true;} ;} ;return false;} ;function Element_SetUnselectable(element){element.setAttribute(OxO6a5b[62],OxO6a5b[63]);element.setAttribute(OxO6a5b[64],OxO6a5b[65]);var arr=Element_GetAllElements(element);var len=arr[OxO6a5b[18]];if(!len){return ;} ;for(var i=0;i<len;i++){arr[i].setAttribute(OxO6a5b[62],OxO6a5b[63]);arr[i].setAttribute(OxO6a5b[64],OxO6a5b[65]);} ;} ;function Event_GetEvent(Ox245){Ox245=Event_FindEvent(Ox245);if(Ox245==null){Debug_Todo(OxO6a5b[66]);} ;return Ox245;} ;function Frame_GetContentWindow(Ox349){if(Ox349[OxO6a5b[67]]){return Ox349[OxO6a5b[67]];} ;if(Ox349[OxO6a5b[68]]){if(Ox349[OxO6a5b[68]][OxO6a5b[69]]){return Ox349[OxO6a5b[68]][OxO6a5b[69]];} ;} ;var Ox1a8;if(Ox349[OxO6a5b[70]]){Ox1a8=window[OxO6a5b[71]][Ox349[OxO6a5b[70]]];if(Ox1a8){return Ox1a8;} ;} ;var len=window[OxO6a5b[71]][OxO6a5b[18]];for(var i=0;i<len;i++){Ox1a8=window[OxO6a5b[71]][i];if(Ox1a8[OxO6a5b[72]]==Ox349){return Ox1a8;} ;if(Ox1a8[OxO6a5b[11]]==Ox349[OxO6a5b[68]]){return Ox1a8;} ;} ;Debug_Todo(OxO6a5b[73]);} ;function Array_IndexOf(arr,Ox247){for(var i=0;i<arr[OxO6a5b[18]];i++){if(arr[i]==Ox247){return i;} ;} ;return -1;} ;function Array_Contains(arr,Ox247){return Array_IndexOf(arr,Ox247)!=-1;} ;function Event_FindEvent(Ox245){if(Ox245&&Ox245[OxO6a5b[74]]){return Ox245;} ;if(Browser_IsGecko()){return Event_FindEvent_FindEventFromCallers();} else {if(window[OxO6a5b[33]]){return window[OxO6a5b[33]];} ;return Event_FindEvent_FindEventFromWindows();} ;return null;} ;function Event_FindEvent_FindEventFromCallers(){var Ox18f=Event_GetEvent[OxO6a5b[23]];for(var i=0;i<100;i++){if(!Ox18f){break ;} ;var Ox245=Ox18f[OxO6a5b[38]][0];if(Ox245&&Ox245[OxO6a5b[74]]){return Ox245;} ;Ox18f=Ox18f[OxO6a5b[23]];} ;} ;function Event_FindEvent_FindEventFromWindows(){var arr=[];return Ox24e(window);function Ox24e(Ox1a8){if(Ox1a8==null){return null;} ;if(Ox1a8[OxO6a5b[33]]){return Ox1a8[OxO6a5b[33]];} ;if(Array_Contains(arr,Ox1a8)){return null;} ;arr.push(Ox1a8);var Ox24f=[];if(Ox1a8[OxO6a5b[75]]!=Ox1a8){Ox24f.push(Ox1a8.parent);} ;if(Ox1a8[OxO6a5b[76]]!=Ox1a8[OxO6a5b[75]]){Ox24f.push(Ox1a8.top);} ;if(Ox1a8[OxO6a5b[77]]){Ox24f.push(Ox1a8.opener);} ;for(var i=0;i<Ox1a8[OxO6a5b[71]][OxO6a5b[18]];i++){Ox24f.push(Ox1a8[OxO6a5b[71]][i]);} ;for(var i=0;i<Ox24f[OxO6a5b[18]];i++){try{var Ox245=Ox24e(Ox24f[i]);if(Ox245){return Ox245;} ;} catch(x){} ;} ;return null;} ;} ;function include(Oxc9,Ox288){var Ox289=document.getElementsByTagName(OxO6a5b[78]).item(0);var Ox28a=document.getElementById(Oxc9);if(Ox28a){Ox289.removeChild(Ox28a);} ;var Ox28b=document.createElement(OxO6a5b[79]);Ox28b.setAttribute(OxO6a5b[80],OxO6a5b[81]);Ox28b.setAttribute(OxO6a5b[82],OxO6a5b[83]);Ox28b.setAttribute(OxO6a5b[84],Ox288);Ox28b.setAttribute(OxO6a5b[70],Oxc9);Ox289.appendChild(Ox28b);} ;function Event_GetSrcElement(Ox245){Ox245=Event_GetEvent(Ox245);if(Ox245[OxO6a5b[85]]){return Ox245[OxO6a5b[85]];} ;if(Ox245[OxO6a5b[39]]){return Ox245[OxO6a5b[39]];} ;Debug_Todo(OxO6a5b[86]);return null;} ;function Event_GetFromElement(Ox245){Ox245=Event_GetEvent(Ox245);if(Ox245[OxO6a5b[87]]){return Ox245[OxO6a5b[87]];} ;if(Ox245[OxO6a5b[88]]){return Ox245[OxO6a5b[88]];} ;return null;} ;function Event_GetToElement(Ox245){Ox245=Event_GetEvent(Ox245);if(Ox245[OxO6a5b[89]]){return Ox245[OxO6a5b[89]];} ;if(Ox245[OxO6a5b[88]]){return Ox245[OxO6a5b[88]];} ;return null;} ;function Event_GetKeyCode(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[90]];} ;function Event_GetClientX(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[91]];} ;function Event_GetClientY(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[92]];} ;function Event_GetOffsetX(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[93]];} ;function Event_GetOffsetY(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[94]];} ;function Event_IsLeftButton(Ox245){Ox245=Event_GetEvent(Ox245);if(Browser_IsWinIE()){return Ox245[OxO6a5b[95]]==1;} ;if(Browser_IsGecko()){return Ox245[OxO6a5b[95]]==0;} ;return Ox245[OxO6a5b[95]]==0;} ;function Event_IsCtrlKey(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[96]];} ;function Event_IsAltKey(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[97]];} ;function Event_IsShiftKey(Ox245){Ox245=Event_GetEvent(Ox245);return Ox245[OxO6a5b[98]];} ;function Event_PreventDefault(Ox245){Ox245=Event_GetEvent(Ox245);Ox245[OxO6a5b[29]]=false;if(Ox245[OxO6a5b[74]]){Ox245.preventDefault();} ;} ;function Event_CancelBubble(Ox245){Ox245=Event_GetEvent(Ox245);Ox245[OxO6a5b[99]]=true;if(Ox245[OxO6a5b[100]]){Ox245.stopPropagation();} ;return false;} ;function Event_CancelEvent(Ox245){Ox245=Event_GetEvent(Ox245);Event_PreventDefault(Ox245);return Event_CancelBubble(Ox245);} ;function CuteEditor_BasicInitialize(editor){var Ox158=Browser_IsOpera();var Ox709= new Function(OxO6a5b[101]);var Oxa65= new Function(OxO6a5b[102]);var Oxa66= new Function(OxO6a5b[103]);var Oxa67=editor.GetScriptProperty(OxO6a5b[104]);var Oxa68=editor.GetScriptProperty(OxO6a5b[105]);var Oxa69=Oxa67+OxO6a5b[106]+Oxa68+OxO6a5b[107];var Oxa6a=Oxa67+OxO6a5b[108];var images=editor.getElementsByTagName(OxO6a5b[109]);var len=images[OxO6a5b[18]];for(var i=0;i<len;i++){var img=images[i];if(img.getAttribute(OxO6a5b[110])&&!img.getAttribute(OxO6a5b[111])){img.setAttribute(OxO6a5b[111],img.getAttribute(OxO6a5b[110]));} ;var Ox135=img.getAttribute(OxO6a5b[112]);var Ox671=img.getAttribute(OxO6a5b[113]);if(!(Ox135||Ox671)){continue ;} ;var Oxa6b=img.getAttribute(OxO6a5b[114]);if(parseInt(Oxa6b)>=0){img[OxO6a5b[50]][OxO6a5b[115]]=OxO6a5b[116];img[OxO6a5b[50]][OxO6a5b[117]]=OxO6a5b[116];img[OxO6a5b[84]]=Oxa6a;img[OxO6a5b[50]][OxO6a5b[118]]=OxO6a5b[119]+Oxa69+OxO6a5b[120];img[OxO6a5b[50]][OxO6a5b[121]]=OxO6a5b[122]+(Oxa6b*20)+OxO6a5b[123];img[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[17];} ;if(!Ox135&&!Ox671){if(Ox158){img[OxO6a5b[124]]=CuteEditor_OperaHandleImageLoaded;} ;continue ;} ;if(img[OxO6a5b[125]]!=OxO6a5b[126]){img[OxO6a5b[125]]=OxO6a5b[127];img[OxO6a5b[128]]= new Function(OxO6a5b[129]);img[OxO6a5b[130]]= new Function(OxO6a5b[131]);img[OxO6a5b[132]]= new Function(OxO6a5b[133]);img[OxO6a5b[134]]= new Function(OxO6a5b[135]);} ;if(!img[OxO6a5b[136]]){img[OxO6a5b[136]]=Event_CancelEvent;} ;if(!img[OxO6a5b[137]]){img[OxO6a5b[137]]=Event_CancelEvent;} ;if(Ox135){var Ox18f=img.getAttribute(OxO6a5b[138])==OxO6a5b[36]?Oxa65:Ox709;if(img[OxO6a5b[55]]==null){img[OxO6a5b[55]]=Ox18f;} ;if(img[OxO6a5b[139]]==null){img[OxO6a5b[139]]=Ox18f;} ;} else {if(Ox671){if(img[OxO6a5b[55]]==null){img[OxO6a5b[55]]=Oxa66;} ;} ;} ;} ;var Ox776=Window_GetElement(window,editor.GetScriptProperty(OxO6a5b[140]),true);var Ox777=Window_GetElement(window,editor.GetScriptProperty(OxO6a5b[141]),true);var Ox772=Window_GetElement(window,editor.GetScriptProperty(OxO6a5b[142]),true);Ox772[OxO6a5b[125]]+=OxO6a5b[143];Ox776[OxO6a5b[125]]+=OxO6a5b[144];Ox777[OxO6a5b[125]]+=OxO6a5b[144];Element_SetUnselectable(Ox776);Element_SetUnselectable(Ox777);try{editor[OxO6a5b[50]][OxO6a5b[145]]=OxO6a5b[146];} catch(x){} ;var Ox7ff=editor.GetScriptProperty(OxO6a5b[147]);switch(Ox7ff){case OxO6a5b[148]:Ox776[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[17];break ;;case OxO6a5b[149]:Ox777[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[17];break ;;case OxO6a5b[150]:break ;;} ;} ;function CuteEditor_OperaHandleImageLoaded(){var img=this;if(img[OxO6a5b[50]][OxO6a5b[49]]){img[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[58];setTimeout(function Oxa6d(){img[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[17];} ,1);} ;} ;function CuteEditor_ButtonOver(element){if(!element[OxO6a5b[151]]){element[OxO6a5b[136]]=Event_CancelEvent;element[OxO6a5b[130]]=CuteEditor_ButtonOut;element[OxO6a5b[132]]=CuteEditor_ButtonDown;element[OxO6a5b[134]]=CuteEditor_ButtonUp;Element_SetUnselectable(element);element[OxO6a5b[151]]=true;} ;element[OxO6a5b[152]]=true;element[OxO6a5b[125]]=OxO6a5b[153];} ;function CuteEditor_ButtonOut(){var element=this;element[OxO6a5b[125]]=OxO6a5b[127];element[OxO6a5b[152]]=false;} ;function CuteEditor_ButtonDown(){if(!Event_IsLeftButton()){return ;} ;var element=this;element[OxO6a5b[125]]=OxO6a5b[154];} ;function CuteEditor_ButtonUp(){if(!Event_IsLeftButton()){return ;} ;var element=this;if(element[OxO6a5b[152]]){element[OxO6a5b[125]]=OxO6a5b[153];} else {element[OxO6a5b[125]]=OxO6a5b[155];} ;} ;function CuteEditor_ColorPicker_ButtonOver(element){if(!element[OxO6a5b[151]]){element[OxO6a5b[136]]=Event_CancelEvent;element[OxO6a5b[130]]=CuteEditor_ColorPicker_ButtonOut;element[OxO6a5b[132]]=CuteEditor_ColorPicker_ButtonDown;Element_SetUnselectable(element);element[OxO6a5b[151]]=true;} ;element[OxO6a5b[152]]=true;element[OxO6a5b[50]][OxO6a5b[156]]=OxO6a5b[157];element[OxO6a5b[50]][OxO6a5b[158]]=OxO6a5b[159];element[OxO6a5b[50]][OxO6a5b[160]]=OxO6a5b[161];} ;function CuteEditor_ColorPicker_ButtonOut(){var element=this;element[OxO6a5b[152]]=false;element[OxO6a5b[50]][OxO6a5b[156]]=OxO6a5b[162];element[OxO6a5b[50]][OxO6a5b[158]]=OxO6a5b[17];element[OxO6a5b[50]][OxO6a5b[160]]=OxO6a5b[161];} ;function CuteEditor_ColorPicker_ButtonDown(){var element=this;element[OxO6a5b[50]][OxO6a5b[156]]=OxO6a5b[163];element[OxO6a5b[50]][OxO6a5b[158]]=OxO6a5b[17];element[OxO6a5b[50]][OxO6a5b[160]]=OxO6a5b[161];} ;function CuteEditor_ButtonCommandOver(element){element[OxO6a5b[152]]=true;if(element[OxO6a5b[164]]){element[OxO6a5b[125]]=OxO6a5b[165];} else {element[OxO6a5b[125]]=OxO6a5b[153];} ;} ;function CuteEditor_ButtonCommandOut(element){element[OxO6a5b[152]]=false;if(element[OxO6a5b[166]]){element[OxO6a5b[125]]=OxO6a5b[167];} else {if(element[OxO6a5b[164]]){element[OxO6a5b[125]]=OxO6a5b[165];} else {if(element[OxO6a5b[70]]!=OxO6a5b[168]){element[OxO6a5b[125]]=OxO6a5b[127];} ;} ;} ;} ;function CuteEditor_ButtonCommandDown(element){if(!Event_IsLeftButton()){return ;} ;element[OxO6a5b[125]]=OxO6a5b[154];} ;function CuteEditor_ButtonCommandUp(element){if(!Event_IsLeftButton()){return ;} ;if(element[OxO6a5b[164]]){element[OxO6a5b[125]]=OxO6a5b[165];return ;} ;if(element[OxO6a5b[152]]){element[OxO6a5b[125]]=OxO6a5b[153];} else {if(element[OxO6a5b[166]]){element[OxO6a5b[125]]=OxO6a5b[167];} else {element[OxO6a5b[125]]=OxO6a5b[127];} ;} ;} ;var CuteEditorGlobalFunctions=[CuteEditor_GetEditor,CuteEditor_ButtonOver,CuteEditor_ButtonOut,CuteEditor_ButtonDown,CuteEditor_ButtonUp,CuteEditor_ColorPicker_ButtonOver,CuteEditor_ColorPicker_ButtonOut,CuteEditor_ColorPicker_ButtonDown,CuteEditor_ButtonCommandOver,CuteEditor_ButtonCommandOut,CuteEditor_ButtonCommandDown,CuteEditor_ButtonCommandUp,CuteEditor_DropDownCommand,CuteEditor_ExpandTreeDropDownItem,CuteEditor_CollapseTreeDropDownItem,CuteEditor_OnInitialized,CuteEditor_OnCommand,CuteEditor_OnChange,CuteEditor_AddVerbMenuItems,CuteEditor_AddTagMenuItems,CuteEditor_AddMainMenuItems,CuteEditor_AddDropMenuItems,CuteEditor_FilterCode,CuteEditor_FilterHTML];function SetupCuteEditorGlobalFunctions(){for(var i=0;i<CuteEditorGlobalFunctions[OxO6a5b[18]];i++){var Ox18f=CuteEditorGlobalFunctions[i];var name=Ox18f+OxO6a5b[17];name=name.substr(8,name.indexOf(OxO6a5b[169])-8).replace(/\s/g,OxO6a5b[17]);if(!window[name]){window[name]=Ox18f;} ;} ;} ;SetupCuteEditorGlobalFunctions();var __danainfo=null;var danaurl=window[OxO6a5b[171]][OxO6a5b[170]];var danapos=danaurl.indexOf(OxO6a5b[172]);if(danapos!=-1){var pluspos1=danaurl.indexOf(OxO6a5b[173],danapos+10);var pluspos2=danaurl.indexOf(OxO6a5b[174],danapos+10);if(pluspos1!=-1&&pluspos1<pluspos2){pluspos2=pluspos1;} ;__danainfo=danaurl.substring(danapos,pluspos2)+OxO6a5b[174];} ;function CuteEditor_GetScriptProperty(name){var Ox142=this[OxO6a5b[175]][name];if(Ox142&&__danainfo){if(name==OxO6a5b[104]){return Ox142+__danainfo;} ;var Ox382=this[OxO6a5b[175]][OxO6a5b[104]];if(Ox142.substr(0,Ox382.length)==Ox382){return Ox382+__danainfo+Ox142.substring(Ox382.length);} ;} ;return Ox142;} ;function CuteEditor_SetScriptProperty(name,Ox142){if(Ox142==null){this[OxO6a5b[175]][name]=null;} else {this[OxO6a5b[175]][name]=String(Ox142);} ;} ;function CuteEditorInitialize(Oxa78,Oxa79){var editor=Window_GetElement(window,Oxa78,true);if(editor[OxO6a5b[176]]){return ;} ;editor[OxO6a5b[176]]=1;editor[OxO6a5b[175]]=Oxa79;editor[OxO6a5b[177]]=CuteEditor_GetScriptProperty;var Ox772=Window_GetElement(window,editor.GetScriptProperty(OxO6a5b[142]),true);var editwin,editdoc;try{editwin=Frame_GetContentWindow(Ox772);editdoc=editwin[OxO6a5b[11]];} catch(x){} ;var Oxa7a=false;var Oxa7b;var Oxa7c=false;var Oxa7d=editor.GetScriptProperty(OxO6a5b[104])+OxO6a5b[178]+editor.GetScriptProperty(OxO6a5b[179]);function Oxa7e(){if( typeof (window[OxO6a5b[180]])==OxO6a5b[181]){return ;} ;LoadXMLAsync(OxO6a5b[182],Oxa7d+OxO6a5b[183]+ new Date().getTime(),Oxa7f);} ;function Oxa7f(Ox290){var Ox889= new Date().getTime();if(Ox290[OxO6a5b[184]]!=200){} else {Ox889=Ox290[OxO6a5b[185]];} ;LoadXMLAsync(OxO6a5b[186],Oxa7d+OxO6a5b[187]+Ox889,Oxa80);} ;function Oxa80(Ox290){if(Ox290[OxO6a5b[184]]!=200){return ;} ;CuteEditorInstallScriptCode(Ox290.responseText,OxO6a5b[180]);if(Oxa7a){Oxa81();} ;} ;function Oxa81(){if(Oxa7c){return ;} ;Oxa7c=true;try{editor[OxO6a5b[50]][OxO6a5b[145]]=OxO6a5b[17];} catch(x){} ;try{editdoc[OxO6a5b[188]][OxO6a5b[50]][OxO6a5b[145]]=OxO6a5b[17];} catch(x){} ;Ox772[OxO6a5b[50]][OxO6a5b[49]]=OxO6a5b[189];if(Browser_IsOpera()){editdoc[OxO6a5b[188]][OxO6a5b[190]]=true;} else {} ;window.CuteEditorImplementation(editor);var Oxa82=editor.GetScriptProperty(OxO6a5b[191]);if(Oxa82){editor.Eval(Oxa82);} ;} ;function Oxa83(){if(!Element_Contains(window[OxO6a5b[11]].body,editor)){return ;} ;try{Ox772=Window_GetElement(window,editor.GetScriptProperty(OxO6a5b[142]),true);if(!Ox772.getAttribute(OxO6a5b[192])){Ox772.setAttribute(OxO6a5b[192], new Date().getTime());} ;editwin=Frame_GetContentWindow(Ox772);editdoc=editwin[OxO6a5b[11]];var y=editdoc[OxO6a5b[188]];} catch(x){if(Ox772!=null){Ox772.setAttribute(OxO6a5b[84],Ox772.src);} ;setTimeout(Oxa83,100);return ;} ;if(!editdoc[OxO6a5b[188]]){setTimeout(Oxa83,100);return ;} ;if(!Oxa7a){Oxa7a=true;setTimeout(Oxa83,50);return ;} ;if( typeof (window[OxO6a5b[180]])==OxO6a5b[181]){Oxa81();} else {try{editdoc[OxO6a5b[188]][OxO6a5b[50]][OxO6a5b[145]]=OxO6a5b[146];} catch(x){} ;} ;} ;var Oxa84=0;var Ox43=CuteEditor_Find_DisplayNone(editor);if(Ox43){function Oxa85(){if(Ox43[OxO6a5b[50]][OxO6a5b[49]]!=OxO6a5b[58]){window.clearInterval(Oxa84);Oxa84=OxO6a5b[17];editor[OxO6a5b[176]]=false;CuteEditorInitialize(Oxa78,Oxa79);} ;} ;Oxa84=setInterval(Oxa85,1000);} else {CuteEditor_BasicInitialize(editor);Oxa7e();Oxa83();} ;function CuteEditor_Find_DisplayNone(element){var Oxa87;for(var Ox43=element;Ox43!=null;Ox43=Ox43[OxO6a5b[34]]){if(Ox43[OxO6a5b[50]]&&Ox43[OxO6a5b[50]][OxO6a5b[49]]==OxO6a5b[58]){Oxa87=Ox43;break ;} ;} ;return Oxa87;} ;} ;function CuteEditorInstallScriptCode(Ox9c3,Ox9c4){eval(Ox9c3);window[Ox9c4]=eval(Ox9c4);} ;window[OxO6a5b[193]]=CuteEditorInitialize;