var OxOc0a9=["inp_width","eenheid","alignment","hrcolor","hrcolorpreview","shade","sel_size","width","style","value","px","%","size","align","color","backgroundColor","noShade","noshade","","onclick"];var inp_width=Window_GetElement(window,OxOc0a9[0],true);var eenheid=Window_GetElement(window,OxOc0a9[1],true);var alignment=Window_GetElement(window,OxOc0a9[2],true);var hrcolor=Window_GetElement(window,OxOc0a9[3],true);var hrcolorpreview=Window_GetElement(window,OxOc0a9[4],true);var shade=Window_GetElement(window,OxOc0a9[5],true);var sel_size=Window_GetElement(window,OxOc0a9[6],true);UpdateState=function UpdateState_Hr(){} ;SyncToView=function SyncToView_Hr(){if(element[OxOc0a9[8]][OxOc0a9[7]]){if(element[OxOc0a9[8]][OxOc0a9[7]].search(/%/)<0){eenheid[OxOc0a9[9]]=OxOc0a9[10];inp_width[OxOc0a9[9]]=element[OxOc0a9[8]][OxOc0a9[7]].split(OxOc0a9[10])[0];} else {eenheid[OxOc0a9[9]]=OxOc0a9[11];inp_width[OxOc0a9[9]]=element[OxOc0a9[8]][OxOc0a9[7]].split(OxOc0a9[11])[0];} ;} ;sel_size[OxOc0a9[9]]=element[OxOc0a9[12]];alignment[OxOc0a9[9]]=element[OxOc0a9[13]];hrcolor[OxOc0a9[9]]=element[OxOc0a9[14]];if(element[OxOc0a9[14]]){hrcolor[OxOc0a9[8]][OxOc0a9[15]]=element[OxOc0a9[14]];} ;if(element[OxOc0a9[16]]){shade[OxOc0a9[9]]=OxOc0a9[17];} else {shade[OxOc0a9[9]]=OxOc0a9[18];} ;} ;SyncTo=function SyncTo_Hr(element){if(sel_size[OxOc0a9[9]]){element[OxOc0a9[12]]=sel_size[OxOc0a9[9]];} ;if(hrcolor[OxOc0a9[9]]){element[OxOc0a9[14]]=hrcolor[OxOc0a9[9]];} ;if(alignment[OxOc0a9[9]]){element[OxOc0a9[13]]=alignment[OxOc0a9[9]];} ;if(shade[OxOc0a9[9]]==OxOc0a9[17]){element[OxOc0a9[16]]=true;} else {element[OxOc0a9[16]]=false;} ;if(inp_width[OxOc0a9[9]]){element[OxOc0a9[8]][OxOc0a9[7]]=inp_width[OxOc0a9[9]]+eenheid[OxOc0a9[9]];} ;} ;hrcolor[OxOc0a9[19]]=hrcolorpreview[OxOc0a9[19]]=function hrcolor_onclick(){SelectColor(hrcolor,hrcolorpreview);} ;