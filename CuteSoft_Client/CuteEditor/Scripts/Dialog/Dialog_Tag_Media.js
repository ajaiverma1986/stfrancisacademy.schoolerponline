var OxOb485=["outer","btnbrowse","inp_src","onclick","value","cssText","style","src","FileName"];var outer=Window_GetElement(window,OxOb485[0],true);var btnbrowse=Window_GetElement(window,OxOb485[1],true);var inp_src=Window_GetElement(window,OxOb485[2],true);btnbrowse[OxOb485[3]]=function btnbrowse_onclick(){function Ox35d(Ox13e){if(Ox13e){inp_src[OxOb485[4]]=Ox13e;} ;} ;editor.SetNextDialogWindow(window);editor.ShowSelectFileDialog(Ox35d,inp_src.value);} ;UpdateState=function UpdateState_Media(){outer[OxOb485[6]][OxOb485[5]]=element[OxOb485[6]][OxOb485[5]];outer.mergeAttributes(element);if(element[OxOb485[7]]){outer[OxOb485[8]]=element[OxOb485[8]];} else {outer.removeAttribute(OxOb485[8]);} ;} ;SyncToView=function SyncToView_Media(){inp_src[OxOb485[4]]=element[OxOb485[8]];} ;SyncTo=function SyncTo_Media(element){element[OxOb485[8]]=inp_src[OxOb485[4]];} ;