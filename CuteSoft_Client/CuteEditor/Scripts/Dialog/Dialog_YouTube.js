var OxOece3=["idSource","TargetUrl","value","","$4","$5","\x26","wmode=\x22transparent\x22","allowfullscreen=\x22true\x22","\x3Cembed src=\x22","\x22 width=\x22","\x22 height=\x22","\x22 "," "," type=\x22application/x-shockwave-flash\x22 pluginspage=\x22http://www.macromedia.com/go/getflashplayer\x22 \x3E\x3C/embed\x3E\x0A","\x3Cobject xcodebase=","\x22http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab\x22"," height=\x22","\x22 classid=","\x22clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\x22 \x3E"," \x3Cparam name=\x22Movie\x22 value=\x22","\x22 /\x3E","\x3Cparam name=\x22wmode\x22 value=\x22transparent\x22/\x3E","\x3Cparam name=\x22allowFullScreen\x22 value=\x22true\x22/\x3E","\x3C/object\x3E"];var idSource=Window_GetElement(window,OxOece3[0],true);var TargetUrl=Window_GetElement(window,OxOece3[1],true);var editor=Window_GetDialogArguments(window);var oldWidth,OldHeight;function do_preview(){var Ox120=GetEmbed();if(Ox120){if(idSource[OxOece3[2]]!=Ox120&&idSource[OxOece3[2]]!=null){idSource[OxOece3[2]]=Ox120;} ;} ;} ;function do_insert(){var Ox120=GetEmbed();if(Ox120){editor.PasteHTML(Ox120);} ;Window_CloseDialog(window);} ;function do_Close(){Window_CloseDialog(window);} ;function GetEmbed(){if(idSource[OxOece3[2]]==OxOece3[3]||idSource[OxOece3[2]]==null){return ;} ;var Ox64c=OxOece3[3];Ox64c=idSource[OxOece3[2]];var Ox64d=/(<iframe[^\>]*?)(\ssrc=\s*)\s*("|')(.+?)\3([^>]*)(.*<\/iframe>)/gi;var Ox64e=/(<object[^\>]*>[\s|\S]*?)(<embed[^\>]*?)(\ssrc=\s*)\s*("|')(.+?)\4([^>]*)(.*<\/embed>)[\s|\S]*?<\/object>/gi;if(Ox64c.match(Ox64d)){Ox64c=Ox64c.replace(Ox64d,OxOece3[4]);TargetUrl[OxOece3[2]]=Ox64c;return idSource[OxOece3[2]];} else {if(Ox64c.match(Ox64e)){oldWidth=Ox64c.replace(/(<object[^\>]*>[\s|\S]*?)(<embed[^\>]*?)(\swidth=\s*)\s*("|')(.+?)\4([^>]*)(.*<\/embed>)[\s|\S]*?<\/object>/gi,OxOece3[5]);oldHeight=Ox64c.replace(/(<object[^\>]*>[\s|\S]*?)(<embed[^\>]*?)(\sheight=\s*)\s*("|')(.+?)\4([^>]*)(.*<\/embed>)[\s|\S]*?<\/object>/gi,OxOece3[5]);Ox64c=Ox64c.replace(Ox64e,OxOece3[5]);if(Ox64c.indexOf(OxOece3[6])!=-1){TargetUrl[OxOece3[2]]=Ox64c.substring(0,Ox64c.indexOf(OxOece3[6]));} ;var Ox64f=OxOece3[3];var Oxe1=425;var Ox2d=344;var Ox3e4,Ox3e5;oldWidth=parseInt(oldWidth);if(oldWidth){Oxe1=oldWidth;} ;oldHeight=parseInt(oldHeight);if(oldHeight){Ox2d=oldHeight;} ;Ox3e4=true;if(Ox64c==OxOece3[3]){return ;} ;var Ox3e8,Ox3ea;Ox3ea=OxOece3[3];Ox3e8=true?OxOece3[7]:OxOece3[3];Ox3ea=true?OxOece3[8]:OxOece3[3];var Ox3f0=OxOece3[9]+Ox64c+OxOece3[10]+Oxe1+OxOece3[11]+Ox2d+OxOece3[12]+Ox3ea+OxOece3[13]+Ox3e8+OxOece3[14];var Ox3f1=OxOece3[15]+OxOece3[16]+OxOece3[17]+Ox2d+OxOece3[10]+Oxe1+OxOece3[18]+OxOece3[19]+OxOece3[20]+Ox64c+OxOece3[21];if(true){Ox3f1=Ox3f1+OxOece3[22];} ;if(true){Ox3f1=Ox3f1+OxOece3[23];} ;Ox3f1=Ox3f1+Ox3f0+OxOece3[24];return Ox3f1;} ;} ;} ;