var OxOf400=["nodeName","INPUT","TEXTAREA","BUTTON","IMG","SELECT","TABLE","position","style","absolute","relative","|H1|H2|H3|H4|H5|H6|P|PRE|LI|TD|DIV|BLOCKQUOTE|DT|DD|TABLE|HR|IMG|","|","body","document","allanchors","anchor_name","editor","window","name","value","[[ValidName]]","options","length","anchors","OPTION","text","#","images","className","cetempAnchor","anchorname","","--\x3E"," ","trim","prototype"];function Element_IsBlockControl(element){var name=element[OxOf400[0]];if(name==OxOf400[1]){return true;} ;if(name==OxOf400[2]){return true;} ;if(name==OxOf400[3]){return true;} ;if(name==OxOf400[4]){return true;} ;if(name==OxOf400[5]){return true;} ;if(name==OxOf400[6]){return true;} ;var Ox126=element[OxOf400[8]][OxOf400[7]];if(Ox126==OxOf400[9]||Ox126==OxOf400[10]){return true;} ;return false;} ;function Element_CUtil_IsBlock(Ox36f){var Ox370=OxOf400[11];return (Ox36f!=null)&&(Ox370.indexOf(OxOf400[12]+Ox36f[OxOf400[0]]+OxOf400[12])!=-1);} ;function Window_SelectElement(Ox1a8,element){if(Browser_UseIESelection()){if(Element_IsBlockControl(element)){var Ox31=Ox1a8[OxOf400[14]][OxOf400[13]].createControlRange();Ox31.add(element);Ox31.select();} else {var Ox228=Ox1a8[OxOf400[14]][OxOf400[13]].createTextRange();Ox228.moveToElementText(element);Ox228.select();} ;} else {var Ox228=Ox1a8[OxOf400[14]].createRange();try{Ox228.selectNode(element);} catch(x){Ox228.selectNodeContents(element);} ;var Ox136=Ox1a8.getSelection();Ox136.removeAllRanges();Ox136.addRange(Ox228);} ;} ;var allanchors=Window_GetElement(window,OxOf400[15],true);var anchor_name=Window_GetElement(window,OxOf400[16],true);var obj=Window_GetDialogArguments(window);var editor=obj[OxOf400[17]];var editwin=obj[OxOf400[18]];var editdoc=obj[OxOf400[14]];var name=obj[OxOf400[19]];function insert_link(){var Ox375=anchor_name[OxOf400[20]];var Ox376=/[^a-z\d]/i;Ox375=Ox375.trim();if(Ox376.test(Ox375)){alert(OxOf400[21]);} else {Window_SetDialogReturnValue(window,Ox375);Window_CloseDialog(window);} ;} ;function updateList(){while(allanchors[OxOf400[22]][OxOf400[23]]!=0){allanchors[OxOf400[22]].remove(allanchors.options(0));} ;if(Browser_IsWinIE()){for(var i=0;i<editdoc[OxOf400[24]][OxOf400[23]];i++){var Ox378=document.createElement(OxOf400[25]);Ox378[OxOf400[26]]=OxOf400[27]+editdoc[OxOf400[24]][i][OxOf400[19]];Ox378[OxOf400[20]]=editdoc[OxOf400[24]][i][OxOf400[19]];allanchors[OxOf400[22]].add(Ox378);} ;} else {var Ox379=editdoc[OxOf400[28]];if(Ox379){for(var Ox25=0;Ox25<Ox379[OxOf400[23]];Ox25++){var img=Ox379[Ox25];if(img[OxOf400[29]]==OxOf400[30]){var Ox378=document.createElement(OxOf400[25]);Ox378[OxOf400[26]]=OxOf400[27]+img.getAttribute(OxOf400[31]);Ox378[OxOf400[20]]=img.getAttribute(OxOf400[31]);allanchors[OxOf400[22]].add(Ox378);} ;} ;} ;} ;} ;function selectAnchor(Ox37b){editor.FocusDocument();for(var i=0;i<editdoc[OxOf400[24]][OxOf400[23]];i++){if(editdoc[OxOf400[24]][i][OxOf400[19]]==Ox37b){anchor_name[OxOf400[20]]=Ox37b;Window_SelectElement(editwin,editdoc[OxOf400[24]][i]);} ;} ;} ;if(name&&name!=OxOf400[32]){name=name.replace(/[\s]*<!--[\s\S]*?-->[\s]*/g,OxOf400[32]);name=name.replace(OxOf400[33],OxOf400[34]);anchor_name[OxOf400[20]]=name;} ;updateList();String[OxOf400[36]][OxOf400[35]]=function (){return this.replace(/^\s*/,OxOf400[32]).replace(/\s*$/,OxOf400[32]);} ;