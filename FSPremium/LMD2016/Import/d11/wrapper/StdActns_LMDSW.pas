unit StdActns_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'StdActns' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Windows, SysUtils, Classes, ActnList, StdCtrls,
  Forms, Dialogs, StdActns, Windows_LMDSW, SysUtils_LMDSW, Classes_LMDSW,
  ActnList_LMDSW, StdCtrls_LMDSW, Forms_LMDSW, Dialogs_LMDSW;


{ Type wrappers }

type
  THintAction_sw = class;
  TEditAction_sw = class;
  TEditCut_sw = class;
  TEditCopy_sw = class;
  TEditPaste_sw = class;
  TEditSelectAll_sw = class;
  TEditUndo_sw = class;
  TEditDelete_sw = class;
  TWindowAction_sw = class;
  TWindowClose_sw = class;
  TWindowCascade_sw = class;
  TWindowTileHorizontal_sw = class;
  TWindowTileVertical_sw = class;
  TWindowMinimizeAll_sw = class;
  TWindowArrange_sw = class;
  THelpAction_sw = class;
  THelpContents_sw = class;
  THelpTopicSearch_sw = class;
  THelpOnHelp_sw = class;
  THelpContextAction_sw = class;
  TCommonDialogClass_sw = class;
  TCommonDialogAction_sw = class;
  TFileAction_sw = class;
  TFileOpen_sw = class;
  TFileOpenWith_sw = class;
  TFileSaveAs_sw = class;
  TFilePrintSetup_sw = class;
  TFilePageSetup_sw = class;
  TFileExit_sw = class;
  TSearchAction_sw = class;
  TSearchFind_sw = class;
  TSearchReplace_sw = class;
  TSearchFindFirst_sw = class;
  TSearchFindNext_sw = class;
  TFontEdit_sw = class;
  TColorSelect_sw = class;
  TPrintDlg_sw = class;
  TBrowseForFolder_sw = class;

  THintAction_sc = class of THintAction;
  THintAction_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THintAction): OleVariant;
    class function FromVar(const AValue: OleVariant): THintAction;
    class function ClassToVar(AClass: THintAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THintAction_sc;
  end;

  TEditAction_sc = class of TEditAction;
  TEditAction_sw = class(TAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditAction;
    class function ClassToVar(AClass: TEditAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditAction_sc;
  end;

  TEditCut_sc = class of TEditCut;
  TEditCut_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditCut): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditCut;
    class function ClassToVar(AClass: TEditCut_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditCut_sc;
  end;

  TEditCopy_sc = class of TEditCopy;
  TEditCopy_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditCopy): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditCopy;
    class function ClassToVar(AClass: TEditCopy_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditCopy_sc;
  end;

  TEditPaste_sc = class of TEditPaste;
  TEditPaste_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditPaste): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditPaste;
    class function ClassToVar(AClass: TEditPaste_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditPaste_sc;
  end;

  TEditSelectAll_sc = class of TEditSelectAll;
  TEditSelectAll_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditSelectAll): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditSelectAll;
    class function ClassToVar(AClass: TEditSelectAll_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditSelectAll_sc;
  end;

  TEditUndo_sc = class of TEditUndo;
  TEditUndo_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditUndo): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditUndo;
    class function ClassToVar(AClass: TEditUndo_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditUndo_sc;
  end;

  TEditDelete_sc = class of TEditDelete;
  TEditDelete_sw = class(TEditAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TEditDelete): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditDelete;
    class function ClassToVar(AClass: TEditDelete_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TEditDelete_sc;
  end;

  TWindowAction_sc = class of TWindowAction;
  TWindowAction_sw = class(TAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowAction;
    class function ClassToVar(AClass: TWindowAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowAction_sc;
  end;

  TWindowClose_sc = class of TWindowClose;
  TWindowClose_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowClose): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowClose;
    class function ClassToVar(AClass: TWindowClose_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowClose_sc;
  end;

  TWindowCascade_sc = class of TWindowCascade;
  TWindowCascade_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowCascade): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowCascade;
    class function ClassToVar(AClass: TWindowCascade_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowCascade_sc;
  end;

  TWindowTileHorizontal_sc = class of TWindowTileHorizontal;
  TWindowTileHorizontal_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowTileHorizontal): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowTileHorizontal;
    class function ClassToVar(AClass: TWindowTileHorizontal_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowTileHorizontal_sc;
  end;

  TWindowTileVertical_sc = class of TWindowTileVertical;
  TWindowTileVertical_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowTileVertical): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowTileVertical;
    class function ClassToVar(AClass: TWindowTileVertical_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowTileVertical_sc;
  end;

  TWindowMinimizeAll_sc = class of TWindowMinimizeAll;
  TWindowMinimizeAll_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowMinimizeAll): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowMinimizeAll;
    class function ClassToVar(AClass: TWindowMinimizeAll_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowMinimizeAll_sc;
  end;

  TWindowArrange_sc = class of TWindowArrange;
  TWindowArrange_sw = class(TWindowAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWindowArrange): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowArrange;
    class function ClassToVar(AClass: TWindowArrange_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWindowArrange_sc;
  end;

  THelpAction_sc = class of THelpAction;
  THelpAction_sw = class(TAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THelpAction): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpAction;
    class function ClassToVar(AClass: THelpAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THelpAction_sc;
  end;

  THelpContents_sc = class of THelpContents;
  THelpContents_sw = class(THelpAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THelpContents): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpContents;
    class function ClassToVar(AClass: THelpContents_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THelpContents_sc;
  end;

  THelpTopicSearch_sc = class of THelpTopicSearch;
  THelpTopicSearch_sw = class(THelpAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THelpTopicSearch): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpTopicSearch;
    class function ClassToVar(AClass: THelpTopicSearch_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THelpTopicSearch_sc;
  end;

  THelpOnHelp_sc = class of THelpOnHelp;
  THelpOnHelp_sw = class(THelpAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THelpOnHelp): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpOnHelp;
    class function ClassToVar(AClass: THelpOnHelp_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THelpOnHelp_sc;
  end;

  THelpContextAction_sc = class of THelpContextAction;
  THelpContextAction_sw = class(THelpAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THelpContextAction): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpContextAction;
    class function ClassToVar(AClass: THelpContextAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THelpContextAction_sc;
  end;

  TCommonDialogClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCommonDialogClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonDialogClass;
  end;

  TCommonDialogAction_sc = class of TCommonDialogAction;
  TCommonDialogAction_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCommonDialogAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonDialogAction;
    class function ClassToVar(AClass: TCommonDialogAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCommonDialogAction_sc;
  end;

  TFileAction_sc = class of TFileAction;
  TFileAction_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileAction;
    class function ClassToVar(AClass: TFileAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileAction_sc;
  end;

  TFileOpen_sc = class of TFileOpen;
  TFileOpen_sw = class(TFileAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileOpen): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileOpen;
    class function ClassToVar(AClass: TFileOpen_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileOpen_sc;
  end;

  TFileOpenWith_sc = class of TFileOpenWith;
  TFileOpenWith_sw = class(TFileOpen_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileOpenWith): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileOpenWith;
    class function ClassToVar(AClass: TFileOpenWith_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileOpenWith_sc;
  end;

  TFileSaveAs_sc = class of TFileSaveAs;
  TFileSaveAs_sw = class(TFileAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileSaveAs): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileSaveAs;
    class function ClassToVar(AClass: TFileSaveAs_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileSaveAs_sc;
  end;

  TFilePrintSetup_sc = class of TFilePrintSetup;
  TFilePrintSetup_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFilePrintSetup): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilePrintSetup;
    class function ClassToVar(AClass: TFilePrintSetup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFilePrintSetup_sc;
  end;

  TFilePageSetup_sc = class of TFilePageSetup;
  TFilePageSetup_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFilePageSetup): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilePageSetup;
    class function ClassToVar(AClass: TFilePageSetup_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFilePageSetup_sc;
  end;

  TFileExit_sc = class of TFileExit;
  TFileExit_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFileExit): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileExit;
    class function ClassToVar(AClass: TFileExit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFileExit_sc;
  end;

  TSearchAction_sc = class of TSearchAction;
  TSearchAction_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSearchAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchAction;
    class function ClassToVar(AClass: TSearchAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSearchAction_sc;
  end;

  TSearchFind_sc = class of TSearchFind;
  TSearchFind_sw = class(TSearchAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSearchFind): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchFind;
    class function ClassToVar(AClass: TSearchFind_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSearchFind_sc;
  end;

  TSearchReplace_sc = class of TSearchReplace;
  TSearchReplace_sw = class(TSearchAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSearchReplace): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchReplace;
    class function ClassToVar(AClass: TSearchReplace_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSearchReplace_sc;
  end;

  TSearchFindFirst_sc = class of TSearchFindFirst;
  TSearchFindFirst_sw = class(TSearchFind_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSearchFindFirst): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchFindFirst;
    class function ClassToVar(AClass: TSearchFindFirst_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSearchFindFirst_sc;
  end;

  TSearchFindNext_sc = class of TSearchFindNext;
  TSearchFindNext_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSearchFindNext): OleVariant;
    class function FromVar(const AValue: OleVariant): TSearchFindNext;
    class function ClassToVar(AClass: TSearchFindNext_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSearchFindNext_sc;
  end;

  TFontEdit_sc = class of TFontEdit;
  TFontEdit_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFontEdit): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontEdit;
    class function ClassToVar(AClass: TFontEdit_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFontEdit_sc;
  end;

  TColorSelect_sc = class of TColorSelect;
  TColorSelect_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColorSelect): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorSelect;
    class function ClassToVar(AClass: TColorSelect_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColorSelect_sc;
  end;

  TPrintDlg_sc = class of TPrintDlg;
  TPrintDlg_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrintDlg): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintDlg;
    class function ClassToVar(AClass: TPrintDlg_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrintDlg_sc;
  end;

  TBrowseForFolderOption_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TBrowseForFolderOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrowseForFolderOption;
  end;

  TBrowseOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TBrowseOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrowseOptions;
  end;

  TBrowseForFolderCallbackEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TBrowseForFolder; Wnd: HWND; uMsg: UINT;
      lParam: LPARAM; lpData: LPARAM; var Result: Integer);
  end;

  TBrowseForFolderCallbackEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBrowseForFolderCallbackEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrowseForFolderCallbackEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TBrowseForFolderCallbackEvent;
  end;

  TBrowseForFolder_sc = class of TBrowseForFolder;
  TBrowseForFolder_sw = class(TCommonDialogAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBrowseForFolder): OleVariant;
    class function FromVar(const AValue: OleVariant): TBrowseForFolder;
    class function ClassToVar(AClass: TBrowseForFolder_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBrowseForFolder_sc;
  end;


{ Unit wrapper }

type
  StdActns_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TFileAction_sacc = class(TFileAction);

{ THintAction_sw }

class function THintAction_sw.GetTypeName: WideString;
begin
  Result := 'THintAction';
end;

class function THintAction_sw.GetWrappedClass: TClass;
begin
  Result := THintAction;
end;

class procedure THintAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Hint');
end;

class function THintAction_sw.ToVar(const AValue: THintAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THintAction_sw.FromVar(const AValue: OleVariant): THintAction;
begin
  Result := THintAction(ConvFromVar(AValue, THintAction));
end;

class function THintAction_sw.ClassToVar(AClass: THintAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THintAction_sw.ClassFromVar(
  const AClass: OleVariant): THintAction_sc;
begin
  Result := THintAction_sc(ConvClsFromVar(AClass, THintAction));
end;

{ TEditAction_sw }

function TEditAction_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TCustomEdit read <getter> write <setter>;

  if IsGet then
    Result := TCustomEdit_sw.ToVar(TEditAction(AObj).Control)
  else
    TEditAction(AObj).Control := TCustomEdit_sw.FromVar(AArgs[0]);
end;

class function TEditAction_sw.GetTypeName: WideString;
begin
  Result := 'TEditAction';
end;

class function TEditAction_sw.GetWrappedClass: TClass;
begin
  Result := TEditAction;
end;

class procedure TEditAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Control', TEditAction_Control_si, TCustomEdit_sw, True, True, 0, False);
end;

class function TEditAction_sw.ToVar(const AValue: TEditAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditAction_sw.FromVar(const AValue: OleVariant): TEditAction;
begin
  Result := TEditAction(ConvFromVar(AValue, TEditAction));
end;

class function TEditAction_sw.ClassToVar(AClass: TEditAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditAction_sw.ClassFromVar(
  const AClass: OleVariant): TEditAction_sc;
begin
  Result := TEditAction_sc(ConvClsFromVar(AClass, TEditAction));
end;

{ TEditCut_sw }

class function TEditCut_sw.GetTypeName: WideString;
begin
  Result := 'TEditCut';
end;

class function TEditCut_sw.GetWrappedClass: TClass;
begin
  Result := TEditCut;
end;

class procedure TEditCut_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditCut_sw.ToVar(const AValue: TEditCut): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditCut_sw.FromVar(const AValue: OleVariant): TEditCut;
begin
  Result := TEditCut(ConvFromVar(AValue, TEditCut));
end;

class function TEditCut_sw.ClassToVar(AClass: TEditCut_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditCut_sw.ClassFromVar(const AClass: OleVariant): TEditCut_sc;
begin
  Result := TEditCut_sc(ConvClsFromVar(AClass, TEditCut));
end;

{ TEditCopy_sw }

class function TEditCopy_sw.GetTypeName: WideString;
begin
  Result := 'TEditCopy';
end;

class function TEditCopy_sw.GetWrappedClass: TClass;
begin
  Result := TEditCopy;
end;

class procedure TEditCopy_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditCopy_sw.ToVar(const AValue: TEditCopy): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditCopy_sw.FromVar(const AValue: OleVariant): TEditCopy;
begin
  Result := TEditCopy(ConvFromVar(AValue, TEditCopy));
end;

class function TEditCopy_sw.ClassToVar(AClass: TEditCopy_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditCopy_sw.ClassFromVar(
  const AClass: OleVariant): TEditCopy_sc;
begin
  Result := TEditCopy_sc(ConvClsFromVar(AClass, TEditCopy));
end;

{ TEditPaste_sw }

class function TEditPaste_sw.GetTypeName: WideString;
begin
  Result := 'TEditPaste';
end;

class function TEditPaste_sw.GetWrappedClass: TClass;
begin
  Result := TEditPaste;
end;

class procedure TEditPaste_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditPaste_sw.ToVar(const AValue: TEditPaste): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditPaste_sw.FromVar(const AValue: OleVariant): TEditPaste;
begin
  Result := TEditPaste(ConvFromVar(AValue, TEditPaste));
end;

class function TEditPaste_sw.ClassToVar(AClass: TEditPaste_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditPaste_sw.ClassFromVar(
  const AClass: OleVariant): TEditPaste_sc;
begin
  Result := TEditPaste_sc(ConvClsFromVar(AClass, TEditPaste));
end;

{ TEditSelectAll_sw }

class function TEditSelectAll_sw.GetTypeName: WideString;
begin
  Result := 'TEditSelectAll';
end;

class function TEditSelectAll_sw.GetWrappedClass: TClass;
begin
  Result := TEditSelectAll;
end;

class procedure TEditSelectAll_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditSelectAll_sw.ToVar(
  const AValue: TEditSelectAll): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditSelectAll_sw.FromVar(
  const AValue: OleVariant): TEditSelectAll;
begin
  Result := TEditSelectAll(ConvFromVar(AValue, TEditSelectAll));
end;

class function TEditSelectAll_sw.ClassToVar(
  AClass: TEditSelectAll_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditSelectAll_sw.ClassFromVar(
  const AClass: OleVariant): TEditSelectAll_sc;
begin
  Result := TEditSelectAll_sc(ConvClsFromVar(AClass, TEditSelectAll));
end;

{ TEditUndo_sw }

class function TEditUndo_sw.GetTypeName: WideString;
begin
  Result := 'TEditUndo';
end;

class function TEditUndo_sw.GetWrappedClass: TClass;
begin
  Result := TEditUndo;
end;

class procedure TEditUndo_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditUndo_sw.ToVar(const AValue: TEditUndo): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditUndo_sw.FromVar(const AValue: OleVariant): TEditUndo;
begin
  Result := TEditUndo(ConvFromVar(AValue, TEditUndo));
end;

class function TEditUndo_sw.ClassToVar(AClass: TEditUndo_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditUndo_sw.ClassFromVar(
  const AClass: OleVariant): TEditUndo_sc;
begin
  Result := TEditUndo_sc(ConvClsFromVar(AClass, TEditUndo));
end;

{ TEditDelete_sw }

class function TEditDelete_sw.GetTypeName: WideString;
begin
  Result := 'TEditDelete';
end;

class function TEditDelete_sw.GetWrappedClass: TClass;
begin
  Result := TEditDelete;
end;

class procedure TEditDelete_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TEditDelete_sw.ToVar(const AValue: TEditDelete): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TEditDelete_sw.FromVar(const AValue: OleVariant): TEditDelete;
begin
  Result := TEditDelete(ConvFromVar(AValue, TEditDelete));
end;

class function TEditDelete_sw.ClassToVar(AClass: TEditDelete_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TEditDelete_sw.ClassFromVar(
  const AClass: OleVariant): TEditDelete_sc;
begin
  Result := TEditDelete_sc(ConvClsFromVar(AClass, TEditDelete));
end;

{ TWindowAction_sw }

function TWindowAction_Form_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Form: TCustomForm read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm_sw.ToVar(TWindowAction(AObj).Form)
  else
    TWindowAction(AObj).Form := TCustomForm_sw.FromVar(AArgs[0]);
end;

class function TWindowAction_sw.GetTypeName: WideString;
begin
  Result := 'TWindowAction';
end;

class function TWindowAction_sw.GetWrappedClass: TClass;
begin
  Result := TWindowAction;
end;

class procedure TWindowAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Form', TWindowAction_Form_si, TCustomForm_sw, True, True, 0, False);
end;

class function TWindowAction_sw.ToVar(const AValue: TWindowAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowAction_sw.FromVar(
  const AValue: OleVariant): TWindowAction;
begin
  Result := TWindowAction(ConvFromVar(AValue, TWindowAction));
end;

class function TWindowAction_sw.ClassToVar(
  AClass: TWindowAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowAction_sw.ClassFromVar(
  const AClass: OleVariant): TWindowAction_sc;
begin
  Result := TWindowAction_sc(ConvClsFromVar(AClass, TWindowAction));
end;

{ TWindowClose_sw }

class function TWindowClose_sw.GetTypeName: WideString;
begin
  Result := 'TWindowClose';
end;

class function TWindowClose_sw.GetWrappedClass: TClass;
begin
  Result := TWindowClose;
end;

class procedure TWindowClose_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowClose_sw.ToVar(const AValue: TWindowClose): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowClose_sw.FromVar(const AValue: OleVariant): TWindowClose;
begin
  Result := TWindowClose(ConvFromVar(AValue, TWindowClose));
end;

class function TWindowClose_sw.ClassToVar(AClass: TWindowClose_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowClose_sw.ClassFromVar(
  const AClass: OleVariant): TWindowClose_sc;
begin
  Result := TWindowClose_sc(ConvClsFromVar(AClass, TWindowClose));
end;

{ TWindowCascade_sw }

class function TWindowCascade_sw.GetTypeName: WideString;
begin
  Result := 'TWindowCascade';
end;

class function TWindowCascade_sw.GetWrappedClass: TClass;
begin
  Result := TWindowCascade;
end;

class procedure TWindowCascade_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowCascade_sw.ToVar(
  const AValue: TWindowCascade): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowCascade_sw.FromVar(
  const AValue: OleVariant): TWindowCascade;
begin
  Result := TWindowCascade(ConvFromVar(AValue, TWindowCascade));
end;

class function TWindowCascade_sw.ClassToVar(
  AClass: TWindowCascade_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowCascade_sw.ClassFromVar(
  const AClass: OleVariant): TWindowCascade_sc;
begin
  Result := TWindowCascade_sc(ConvClsFromVar(AClass, TWindowCascade));
end;

{ TWindowTileHorizontal_sw }

class function TWindowTileHorizontal_sw.GetTypeName: WideString;
begin
  Result := 'TWindowTileHorizontal';
end;

class function TWindowTileHorizontal_sw.GetWrappedClass: TClass;
begin
  Result := TWindowTileHorizontal;
end;

class procedure TWindowTileHorizontal_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowTileHorizontal_sw.ToVar(
  const AValue: TWindowTileHorizontal): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowTileHorizontal_sw.FromVar(
  const AValue: OleVariant): TWindowTileHorizontal;
begin
  Result := TWindowTileHorizontal(ConvFromVar(AValue, TWindowTileHorizontal));
end;

class function TWindowTileHorizontal_sw.ClassToVar(
  AClass: TWindowTileHorizontal_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowTileHorizontal_sw.ClassFromVar(
  const AClass: OleVariant): TWindowTileHorizontal_sc;
begin
  Result := TWindowTileHorizontal_sc(ConvClsFromVar(AClass, 
    TWindowTileHorizontal));
end;

{ TWindowTileVertical_sw }

class function TWindowTileVertical_sw.GetTypeName: WideString;
begin
  Result := 'TWindowTileVertical';
end;

class function TWindowTileVertical_sw.GetWrappedClass: TClass;
begin
  Result := TWindowTileVertical;
end;

class procedure TWindowTileVertical_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowTileVertical_sw.ToVar(
  const AValue: TWindowTileVertical): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowTileVertical_sw.FromVar(
  const AValue: OleVariant): TWindowTileVertical;
begin
  Result := TWindowTileVertical(ConvFromVar(AValue, TWindowTileVertical));
end;

class function TWindowTileVertical_sw.ClassToVar(
  AClass: TWindowTileVertical_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowTileVertical_sw.ClassFromVar(
  const AClass: OleVariant): TWindowTileVertical_sc;
begin
  Result := TWindowTileVertical_sc(ConvClsFromVar(AClass, TWindowTileVertical));
end;

{ TWindowMinimizeAll_sw }

class function TWindowMinimizeAll_sw.GetTypeName: WideString;
begin
  Result := 'TWindowMinimizeAll';
end;

class function TWindowMinimizeAll_sw.GetWrappedClass: TClass;
begin
  Result := TWindowMinimizeAll;
end;

class procedure TWindowMinimizeAll_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowMinimizeAll_sw.ToVar(
  const AValue: TWindowMinimizeAll): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowMinimizeAll_sw.FromVar(
  const AValue: OleVariant): TWindowMinimizeAll;
begin
  Result := TWindowMinimizeAll(ConvFromVar(AValue, TWindowMinimizeAll));
end;

class function TWindowMinimizeAll_sw.ClassToVar(
  AClass: TWindowMinimizeAll_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowMinimizeAll_sw.ClassFromVar(
  const AClass: OleVariant): TWindowMinimizeAll_sc;
begin
  Result := TWindowMinimizeAll_sc(ConvClsFromVar(AClass, TWindowMinimizeAll));
end;

{ TWindowArrange_sw }

class function TWindowArrange_sw.GetTypeName: WideString;
begin
  Result := 'TWindowArrange';
end;

class function TWindowArrange_sw.GetWrappedClass: TClass;
begin
  Result := TWindowArrange;
end;

class procedure TWindowArrange_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWindowArrange_sw.ToVar(
  const AValue: TWindowArrange): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWindowArrange_sw.FromVar(
  const AValue: OleVariant): TWindowArrange;
begin
  Result := TWindowArrange(ConvFromVar(AValue, TWindowArrange));
end;

class function TWindowArrange_sw.ClassToVar(
  AClass: TWindowArrange_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWindowArrange_sw.ClassFromVar(
  const AClass: OleVariant): TWindowArrange_sc;
begin
  Result := TWindowArrange_sc(ConvClsFromVar(AClass, TWindowArrange));
end;

{ THelpAction_sw }

class function THelpAction_sw.GetTypeName: WideString;
begin
  Result := 'THelpAction';
end;

class function THelpAction_sw.GetWrappedClass: TClass;
begin
  Result := THelpAction;
end;

class procedure THelpAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function THelpAction_sw.ToVar(const AValue: THelpAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THelpAction_sw.FromVar(const AValue: OleVariant): THelpAction;
begin
  Result := THelpAction(ConvFromVar(AValue, THelpAction));
end;

class function THelpAction_sw.ClassToVar(AClass: THelpAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THelpAction_sw.ClassFromVar(
  const AClass: OleVariant): THelpAction_sc;
begin
  Result := THelpAction_sc(ConvClsFromVar(AClass, THelpAction));
end;

{ THelpContents_sw }

class function THelpContents_sw.GetTypeName: WideString;
begin
  Result := 'THelpContents';
end;

class function THelpContents_sw.GetWrappedClass: TClass;
begin
  Result := THelpContents;
end;

class procedure THelpContents_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function THelpContents_sw.ToVar(const AValue: THelpContents): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THelpContents_sw.FromVar(
  const AValue: OleVariant): THelpContents;
begin
  Result := THelpContents(ConvFromVar(AValue, THelpContents));
end;

class function THelpContents_sw.ClassToVar(
  AClass: THelpContents_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THelpContents_sw.ClassFromVar(
  const AClass: OleVariant): THelpContents_sc;
begin
  Result := THelpContents_sc(ConvClsFromVar(AClass, THelpContents));
end;

{ THelpTopicSearch_sw }

class function THelpTopicSearch_sw.GetTypeName: WideString;
begin
  Result := 'THelpTopicSearch';
end;

class function THelpTopicSearch_sw.GetWrappedClass: TClass;
begin
  Result := THelpTopicSearch;
end;

class procedure THelpTopicSearch_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function THelpTopicSearch_sw.ToVar(
  const AValue: THelpTopicSearch): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THelpTopicSearch_sw.FromVar(
  const AValue: OleVariant): THelpTopicSearch;
begin
  Result := THelpTopicSearch(ConvFromVar(AValue, THelpTopicSearch));
end;

class function THelpTopicSearch_sw.ClassToVar(
  AClass: THelpTopicSearch_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THelpTopicSearch_sw.ClassFromVar(
  const AClass: OleVariant): THelpTopicSearch_sc;
begin
  Result := THelpTopicSearch_sc(ConvClsFromVar(AClass, THelpTopicSearch));
end;

{ THelpOnHelp_sw }

class function THelpOnHelp_sw.GetTypeName: WideString;
begin
  Result := 'THelpOnHelp';
end;

class function THelpOnHelp_sw.GetWrappedClass: TClass;
begin
  Result := THelpOnHelp;
end;

class procedure THelpOnHelp_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function THelpOnHelp_sw.ToVar(const AValue: THelpOnHelp): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THelpOnHelp_sw.FromVar(const AValue: OleVariant): THelpOnHelp;
begin
  Result := THelpOnHelp(ConvFromVar(AValue, THelpOnHelp));
end;

class function THelpOnHelp_sw.ClassToVar(AClass: THelpOnHelp_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THelpOnHelp_sw.ClassFromVar(
  const AClass: OleVariant): THelpOnHelp_sc;
begin
  Result := THelpOnHelp_sc(ConvClsFromVar(AClass, THelpOnHelp));
end;

{ THelpContextAction_sw }

class function THelpContextAction_sw.GetTypeName: WideString;
begin
  Result := 'THelpContextAction';
end;

class function THelpContextAction_sw.GetWrappedClass: TClass;
begin
  Result := THelpContextAction;
end;

class procedure THelpContextAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function THelpContextAction_sw.ToVar(
  const AValue: THelpContextAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THelpContextAction_sw.FromVar(
  const AValue: OleVariant): THelpContextAction;
begin
  Result := THelpContextAction(ConvFromVar(AValue, THelpContextAction));
end;

class function THelpContextAction_sw.ClassToVar(
  AClass: THelpContextAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THelpContextAction_sw.ClassFromVar(
  const AClass: OleVariant): THelpContextAction_sc;
begin
  Result := THelpContextAction_sc(ConvClsFromVar(AClass, THelpContextAction));
end;

{ TCommonDialogClass_sw }

class function TCommonDialogClass_sw.GetTypeName: WideString;
begin
  Result := 'TCommonDialogClass';
end;

class function TCommonDialogClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCommonDialog;
end;

class function TCommonDialogClass_sw.ToVar(
  const AValue: TCommonDialogClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCommonDialogClass_sw.FromVar(
  const AValue: OleVariant): TCommonDialogClass;
begin
  Result := TCommonDialogClass(ConvFromVar(AValue, TCommonDialog));
end;

{ TCommonDialogAction_sw }

function TCommonDialogAction_ExecuteResult_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExecuteResult: Boolean read <getter>;

  Result := TCommonDialogAction(AObj).ExecuteResult;
end;

function TCommonDialogAction_BeforeExecute_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforeExecute: TNotifyEvent read <getter> write ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialogAction(AObj).BeforeExecute)
  else
    TCommonDialogAction(AObj).BeforeExecute := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCommonDialogAction_OnAccept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnAccept: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialogAction(AObj).OnAccept)
  else
    TCommonDialogAction(AObj).OnAccept := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCommonDialogAction_OnCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCancel: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialogAction(AObj).OnCancel)
  else
    TCommonDialogAction(AObj).OnCancel := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCommonDialogAction_sw.GetTypeName: WideString;
begin
  Result := 'TCommonDialogAction';
end;

class function TCommonDialogAction_sw.GetWrappedClass: TClass;
begin
  Result := TCommonDialogAction;
end;

class procedure TCommonDialogAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ExecuteResult', TCommonDialogAction_ExecuteResult_si, Boolean_sw, True, False, 0, False);
  AData.AddProperty('BeforeExecute', TCommonDialogAction_BeforeExecute_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnAccept', TCommonDialogAction_OnAccept_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddProperty('OnCancel', TCommonDialogAction_OnCancel_si, TNotifyEvent_sw, True, True, 0, False);
end;

class function TCommonDialogAction_sw.ToVar(
  const AValue: TCommonDialogAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCommonDialogAction_sw.FromVar(
  const AValue: OleVariant): TCommonDialogAction;
begin
  Result := TCommonDialogAction(ConvFromVar(AValue, TCommonDialogAction));
end;

class function TCommonDialogAction_sw.ClassToVar(
  AClass: TCommonDialogAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCommonDialogAction_sw.ClassFromVar(
  const AClass: OleVariant): TCommonDialogAction_sc;
begin
  Result := TCommonDialogAction_sc(ConvClsFromVar(AClass, TCommonDialogAction));
end;

{ TFileAction_sw }

function TFileAction_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FileName: TFileName read <getter> writ...

  if IsGet then
    Result := TFileName_sw.ToVar(TFileAction_sacc(TFileAction(AObj)).FileName)
  else
    TFileAction_sacc(TFileAction(AObj)).FileName := TFileName_sw.FromVar(
      AArgs[0]);
end;

class function TFileAction_sw.GetTypeName: WideString;
begin
  Result := 'TFileAction';
end;

class function TFileAction_sw.GetWrappedClass: TClass;
begin
  Result := TFileAction;
end;

class procedure TFileAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FileName', TFileAction_FileName_si, TFileName_sw, True, True, 0, True);
end;

class function TFileAction_sw.ToVar(const AValue: TFileAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileAction_sw.FromVar(const AValue: OleVariant): TFileAction;
begin
  Result := TFileAction(ConvFromVar(AValue, TFileAction));
end;

class function TFileAction_sw.ClassToVar(AClass: TFileAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileAction_sw.ClassFromVar(
  const AClass: OleVariant): TFileAction_sc;
begin
  Result := TFileAction_sc(ConvClsFromVar(AClass, TFileAction));
end;

{ TFileOpen_sw }

function TFileOpen_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TOpenDialog read <getter>;

  Result := TOpenDialog_sw.ToVar(TFileOpen(AObj).Dialog);
end;

function TFileOpen_UseDefaultApp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseDefaultApp: Boolean read <getter> write <sett...

  if IsGet then
    Result := TFileOpen(AObj).UseDefaultApp
  else
    TFileOpen(AObj).UseDefaultApp := Boolean(AArgs[0]);
end;

class function TFileOpen_sw.GetTypeName: WideString;
begin
  Result := 'TFileOpen';
end;

class function TFileOpen_sw.GetWrappedClass: TClass;
begin
  Result := TFileOpen;
end;

class procedure TFileOpen_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TFileOpen_Dialog_si, TOpenDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddProperty('UseDefaultApp', TFileOpen_UseDefaultApp_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFileOpen_sw.ToVar(const AValue: TFileOpen): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileOpen_sw.FromVar(const AValue: OleVariant): TFileOpen;
begin
  Result := TFileOpen(ConvFromVar(AValue, TFileOpen));
end;

class function TFileOpen_sw.ClassToVar(AClass: TFileOpen_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileOpen_sw.ClassFromVar(
  const AClass: OleVariant): TFileOpen_sc;
begin
  Result := TFileOpen_sc(ConvClsFromVar(AClass, TFileOpen));
end;

{ TFileOpenWith_sw }

function TFileOpenWith_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TFileOpenWith(AObj).FileName)
  else
    TFileOpenWith(AObj).FileName := TFileName_sw.FromVar(AArgs[0]);
end;

function TFileOpenWith_AfterOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AfterOpen: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFileOpenWith(AObj).AfterOpen)
  else
    TFileOpenWith(AObj).AfterOpen := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TFileOpenWith_sw.GetTypeName: WideString;
begin
  Result := 'TFileOpenWith';
end;

class function TFileOpenWith_sw.GetWrappedClass: TClass;
begin
  Result := TFileOpenWith;
end;

class procedure TFileOpenWith_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FileName', TFileOpenWith_FileName_si, TFileName_sw, True, True, 0, False);
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddProperty('AfterOpen', TFileOpenWith_AfterOpen_si, TNotifyEvent_sw, True, True, 0, False);
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFileOpenWith_sw.ToVar(const AValue: TFileOpenWith): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileOpenWith_sw.FromVar(
  const AValue: OleVariant): TFileOpenWith;
begin
  Result := TFileOpenWith(ConvFromVar(AValue, TFileOpenWith));
end;

class function TFileOpenWith_sw.ClassToVar(
  AClass: TFileOpenWith_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileOpenWith_sw.ClassFromVar(
  const AClass: OleVariant): TFileOpenWith_sc;
begin
  Result := TFileOpenWith_sc(ConvClsFromVar(AClass, TFileOpenWith));
end;

{ TFileSaveAs_sw }

function TFileSaveAs_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TSaveDialog read <getter>;

  Result := TSaveDialog_sw.ToVar(TFileSaveAs(AObj).Dialog);
end;

class function TFileSaveAs_sw.GetTypeName: WideString;
begin
  Result := 'TFileSaveAs';
end;

class function TFileSaveAs_sw.GetWrappedClass: TClass;
begin
  Result := TFileSaveAs;
end;

class procedure TFileSaveAs_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TFileSaveAs_Dialog_si, TSaveDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFileSaveAs_sw.ToVar(const AValue: TFileSaveAs): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileSaveAs_sw.FromVar(const AValue: OleVariant): TFileSaveAs;
begin
  Result := TFileSaveAs(ConvFromVar(AValue, TFileSaveAs));
end;

class function TFileSaveAs_sw.ClassToVar(AClass: TFileSaveAs_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileSaveAs_sw.ClassFromVar(
  const AClass: OleVariant): TFileSaveAs_sc;
begin
  Result := TFileSaveAs_sc(ConvClsFromVar(AClass, TFileSaveAs));
end;

{ TFilePrintSetup_sw }

function TFilePrintSetup_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TPrinterSetupDialog read <getter>;

  Result := TPrinterSetupDialog_sw.ToVar(TFilePrintSetup(AObj).Dialog);
end;

class function TFilePrintSetup_sw.GetTypeName: WideString;
begin
  Result := 'TFilePrintSetup';
end;

class function TFilePrintSetup_sw.GetWrappedClass: TClass;
begin
  Result := TFilePrintSetup;
end;

class procedure TFilePrintSetup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TFilePrintSetup_Dialog_si, TPrinterSetupDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFilePrintSetup_sw.ToVar(
  const AValue: TFilePrintSetup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFilePrintSetup_sw.FromVar(
  const AValue: OleVariant): TFilePrintSetup;
begin
  Result := TFilePrintSetup(ConvFromVar(AValue, TFilePrintSetup));
end;

class function TFilePrintSetup_sw.ClassToVar(
  AClass: TFilePrintSetup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFilePrintSetup_sw.ClassFromVar(
  const AClass: OleVariant): TFilePrintSetup_sc;
begin
  Result := TFilePrintSetup_sc(ConvClsFromVar(AClass, TFilePrintSetup));
end;

{ TFilePageSetup_sw }

function TFilePageSetup_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TPageSetupDialog read <getter>;

  Result := TPageSetupDialog_sw.ToVar(TFilePageSetup(AObj).Dialog);
end;

class function TFilePageSetup_sw.GetTypeName: WideString;
begin
  Result := 'TFilePageSetup';
end;

class function TFilePageSetup_sw.GetWrappedClass: TClass;
begin
  Result := TFilePageSetup;
end;

class procedure TFilePageSetup_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TFilePageSetup_Dialog_si, TPageSetupDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFilePageSetup_sw.ToVar(
  const AValue: TFilePageSetup): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFilePageSetup_sw.FromVar(
  const AValue: OleVariant): TFilePageSetup;
begin
  Result := TFilePageSetup(ConvFromVar(AValue, TFilePageSetup));
end;

class function TFilePageSetup_sw.ClassToVar(
  AClass: TFilePageSetup_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFilePageSetup_sw.ClassFromVar(
  const AClass: OleVariant): TFilePageSetup_sc;
begin
  Result := TFilePageSetup_sc(ConvClsFromVar(AClass, TFilePageSetup));
end;

{ TFileExit_sw }

class function TFileExit_sw.GetTypeName: WideString;
begin
  Result := 'TFileExit';
end;

class function TFileExit_sw.GetWrappedClass: TClass;
begin
  Result := TFileExit;
end;

class procedure TFileExit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFileExit_sw.ToVar(const AValue: TFileExit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFileExit_sw.FromVar(const AValue: OleVariant): TFileExit;
begin
  Result := TFileExit(ConvFromVar(AValue, TFileExit));
end;

class function TFileExit_sw.ClassToVar(AClass: TFileExit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFileExit_sw.ClassFromVar(
  const AClass: OleVariant): TFileExit_sc;
begin
  Result := TFileExit_sc(ConvClsFromVar(AClass, TFileExit));
end;

{ TSearchAction_sw }

function TSearchAction_Search_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Search(Sender: TObject);

  TSearchAction(AObj).Search(TObject_sw.FromVar(AArgs[0]));
end;

class function TSearchAction_sw.GetTypeName: WideString;
begin
  Result := 'TSearchAction';
end;

class function TSearchAction_sw.GetWrappedClass: TClass;
begin
  Result := TSearchAction;
end;

class procedure TSearchAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Search', TSearchAction_Search_si, 1, False);
end;

class function TSearchAction_sw.ToVar(const AValue: TSearchAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSearchAction_sw.FromVar(
  const AValue: OleVariant): TSearchAction;
begin
  Result := TSearchAction(ConvFromVar(AValue, TSearchAction));
end;

class function TSearchAction_sw.ClassToVar(
  AClass: TSearchAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSearchAction_sw.ClassFromVar(
  const AClass: OleVariant): TSearchAction_sc;
begin
  Result := TSearchAction_sc(ConvClsFromVar(AClass, TSearchAction));
end;

{ TSearchFind_sw }

function TSearchFind_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TFindDialog read <getter>;

  Result := TFindDialog_sw.ToVar(TSearchFind(AObj).Dialog);
end;

class function TSearchFind_sw.GetTypeName: WideString;
begin
  Result := 'TSearchFind';
end;

class function TSearchFind_sw.GetWrappedClass: TClass;
begin
  Result := TSearchFind;
end;

class procedure TSearchFind_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Dialog', TSearchFind_Dialog_si, TFindDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TSearchFind_sw.ToVar(const AValue: TSearchFind): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSearchFind_sw.FromVar(const AValue: OleVariant): TSearchFind;
begin
  Result := TSearchFind(ConvFromVar(AValue, TSearchFind));
end;

class function TSearchFind_sw.ClassToVar(AClass: TSearchFind_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSearchFind_sw.ClassFromVar(
  const AClass: OleVariant): TSearchFind_sc;
begin
  Result := TSearchFind_sc(ConvClsFromVar(AClass, TSearchFind));
end;

{ TSearchReplace_sw }

function TSearchReplace_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TReplaceDialog read <getter>;

  Result := TReplaceDialog_sw.ToVar(TSearchReplace(AObj).Dialog);
end;

class function TSearchReplace_sw.GetTypeName: WideString;
begin
  Result := 'TSearchReplace';
end;

class function TSearchReplace_sw.GetWrappedClass: TClass;
begin
  Result := TSearchReplace;
end;

class procedure TSearchReplace_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TSearchReplace_Dialog_si, TReplaceDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TSearchReplace_sw.ToVar(
  const AValue: TSearchReplace): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSearchReplace_sw.FromVar(
  const AValue: OleVariant): TSearchReplace;
begin
  Result := TSearchReplace(ConvFromVar(AValue, TSearchReplace));
end;

class function TSearchReplace_sw.ClassToVar(
  AClass: TSearchReplace_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSearchReplace_sw.ClassFromVar(
  const AClass: OleVariant): TSearchReplace_sc;
begin
  Result := TSearchReplace_sc(ConvClsFromVar(AClass, TSearchReplace));
end;

{ TSearchFindFirst_sw }

class function TSearchFindFirst_sw.GetTypeName: WideString;
begin
  Result := 'TSearchFindFirst';
end;

class function TSearchFindFirst_sw.GetWrappedClass: TClass;
begin
  Result := TSearchFindFirst;
end;

class procedure TSearchFindFirst_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSearchFindFirst_sw.ToVar(
  const AValue: TSearchFindFirst): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSearchFindFirst_sw.FromVar(
  const AValue: OleVariant): TSearchFindFirst;
begin
  Result := TSearchFindFirst(ConvFromVar(AValue, TSearchFindFirst));
end;

class function TSearchFindFirst_sw.ClassToVar(
  AClass: TSearchFindFirst_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSearchFindFirst_sw.ClassFromVar(
  const AClass: OleVariant): TSearchFindFirst_sc;
begin
  Result := TSearchFindFirst_sc(ConvClsFromVar(AClass, TSearchFindFirst));
end;

{ TSearchFindNext_sw }

function TSearchFindNext_SearchFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SearchFind: TSearchFind read <getter> write <set...

  if IsGet then
    Result := TSearchFind_sw.ToVar(TSearchFindNext(AObj).SearchFind)
  else
    TSearchFindNext(AObj).SearchFind := TSearchFind_sw.FromVar(AArgs[0]);
end;

class function TSearchFindNext_sw.GetTypeName: WideString;
begin
  Result := 'TSearchFindNext';
end;

class function TSearchFindNext_sw.GetWrappedClass: TClass;
begin
  Result := TSearchFindNext;
end;

class procedure TSearchFindNext_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddProperty('SearchFind', TSearchFindNext_SearchFind_si, TSearchFind_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TSearchFindNext_sw.ToVar(
  const AValue: TSearchFindNext): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSearchFindNext_sw.FromVar(
  const AValue: OleVariant): TSearchFindNext;
begin
  Result := TSearchFindNext(ConvFromVar(AValue, TSearchFindNext));
end;

class function TSearchFindNext_sw.ClassToVar(
  AClass: TSearchFindNext_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSearchFindNext_sw.ClassFromVar(
  const AClass: OleVariant): TSearchFindNext_sc;
begin
  Result := TSearchFindNext_sc(ConvClsFromVar(AClass, TSearchFindNext));
end;

{ TFontEdit_sw }

function TFontEdit_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TFontDialog read <getter>;

  Result := TFontDialog_sw.ToVar(TFontEdit(AObj).Dialog);
end;

class function TFontEdit_sw.GetTypeName: WideString;
begin
  Result := 'TFontEdit';
end;

class function TFontEdit_sw.GetWrappedClass: TClass;
begin
  Result := TFontEdit;
end;

class procedure TFontEdit_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TFontEdit_Dialog_si, TFontDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TFontEdit_sw.ToVar(const AValue: TFontEdit): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFontEdit_sw.FromVar(const AValue: OleVariant): TFontEdit;
begin
  Result := TFontEdit(ConvFromVar(AValue, TFontEdit));
end;

class function TFontEdit_sw.ClassToVar(AClass: TFontEdit_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFontEdit_sw.ClassFromVar(
  const AClass: OleVariant): TFontEdit_sc;
begin
  Result := TFontEdit_sc(ConvClsFromVar(AClass, TFontEdit));
end;

{ TColorSelect_sw }

function TColorSelect_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TColorDialog read <getter>;

  Result := TColorDialog_sw.ToVar(TColorSelect(AObj).Dialog);
end;

class function TColorSelect_sw.GetTypeName: WideString;
begin
  Result := 'TColorSelect';
end;

class function TColorSelect_sw.GetWrappedClass: TClass;
begin
  Result := TColorSelect;
end;

class procedure TColorSelect_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TColorSelect_Dialog_si, TColorDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TColorSelect_sw.ToVar(const AValue: TColorSelect): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColorSelect_sw.FromVar(const AValue: OleVariant): TColorSelect;
begin
  Result := TColorSelect(ConvFromVar(AValue, TColorSelect));
end;

class function TColorSelect_sw.ClassToVar(AClass: TColorSelect_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColorSelect_sw.ClassFromVar(
  const AClass: OleVariant): TColorSelect_sc;
begin
  Result := TColorSelect_sc(ConvClsFromVar(AClass, TColorSelect));
end;

{ TPrintDlg_sw }

function TPrintDlg_Dialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dialog: TPrintDialog read <getter>;

  Result := TPrintDialog_sw.ToVar(TPrintDlg(AObj).Dialog);
end;

class function TPrintDlg_sw.GetTypeName: WideString;
begin
  Result := 'TPrintDlg';
end;

class function TPrintDlg_sw.GetWrappedClass: TClass;
begin
  Result := TPrintDlg;
end;

class procedure TPrintDlg_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('Dialog', TPrintDlg_Dialog_si, TPrintDialog_sw, True, False, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
  AData.AddPropertyRedecl('OnUpdate');
end;

class function TPrintDlg_sw.ToVar(const AValue: TPrintDlg): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrintDlg_sw.FromVar(const AValue: OleVariant): TPrintDlg;
begin
  Result := TPrintDlg(ConvFromVar(AValue, TPrintDlg));
end;

class function TPrintDlg_sw.ClassToVar(AClass: TPrintDlg_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrintDlg_sw.ClassFromVar(
  const AClass: OleVariant): TPrintDlg_sc;
begin
  Result := TPrintDlg_sc(ConvClsFromVar(AClass, TPrintDlg));
end;

{ TBrowseForFolderOption_sw }

class function TBrowseForFolderOption_sw.GetTypeName: WideString;
begin
  Result := 'TBrowseForFolderOption';
end;

class function TBrowseForFolderOption_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TBrowseForFolderOption);
end;

class function TBrowseForFolderOption_sw.ToVar(
  const AValue: TBrowseForFolderOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBrowseForFolderOption_sw.FromVar(
  const AValue: OleVariant): TBrowseForFolderOption;
begin
  Result := TBrowseForFolderOption(Integer(AValue));
end;

{ TBrowseOptions_sw }

class function TBrowseOptions_sw.GetTypeName: WideString;
begin
  Result := 'TBrowseOptions';
end;

class function TBrowseOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TBrowseOptions);
end;

class function TBrowseOptions_sw.ToVar(
  const AValue: TBrowseOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TBrowseOptions_sw.FromVar(
  const AValue: OleVariant): TBrowseOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TBrowseForFolderCallbackEvent_sh }

function TBrowseForFolderCallbackEvent_sh.GetHandler: TMethod;
var
  hdr: TBrowseForFolderCallbackEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TBrowseForFolderCallbackEvent_sh.Handler(Sender: TBrowseForFolder;
  Wnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM; var Result: Integer);
var
  args: array[0..5] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TBrowseForFolder; Wnd: HWND; uMsg: UIN...

  v_1 := Result;
  args[0] := TBrowseForFolder_sw.ToVar(Sender);
  args[1] := HWND_sw.ToVar(Wnd);
  args[2] := UINT_sw.ToVar(uMsg);
  args[3] := LPARAM_sw.ToVar(lParam);
  args[4] := LPARAM_sw.ToVar(lpData);
  args[5] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Result := Integer(v_1);
end;

{ TBrowseForFolderCallbackEvent_sw }

class function TBrowseForFolderCallbackEvent_sw.GetTypeName: WideString;
begin
  Result := 'TBrowseForFolderCallbackEvent';
end;

class function TBrowseForFolderCallbackEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TBrowseForFolderCallbackEvent_sh;
end;

class function TBrowseForFolderCallbackEvent_sw.ToVar(
  const AValue: TBrowseForFolderCallbackEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TBrowseForFolderCallbackEvent_sw.FromVar(
  const AValue: OleVariant): TBrowseForFolderCallbackEvent;
begin
  Result := TBrowseForFolderCallbackEvent(ConvFromVar(AValue));
end;

class function TBrowseForFolderCallbackEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TBrowseForFolderCallbackEvent;
var
  hdlr: TBrowseForFolderCallbackEvent_sh;
begin
  hdlr   := TBrowseForFolderCallbackEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TBrowseForFolderCallbackEvent_sw));
  Result := hdlr.Handler;
end;

{ TBrowseForFolder_sw }

function TBrowseForFolder_Folder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Folder: string read <getter> write <setter>;

  if IsGet then
    Result := TBrowseForFolder(AObj).Folder
  else
    TBrowseForFolder(AObj).Folder := string(AArgs[0]);
end;

function TBrowseForFolder_DialogCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DialogCaption: string read <getter> write <setter>;

  if IsGet then
    Result := TBrowseForFolder(AObj).DialogCaption
  else
    TBrowseForFolder(AObj).DialogCaption := string(AArgs[0]);
end;

function TBrowseForFolder_BrowseOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BrowseOptions: TBrowseOptions read <getter> writ...

  if IsGet then
    Result := TBrowseOptions_sw.ToVar(TBrowseForFolder(AObj).BrowseOptions)
  else
    TBrowseForFolder(AObj).BrowseOptions := TBrowseOptions_sw.FromVar(AArgs[0]);
end;

function TBrowseForFolder_RootDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RootDir: string read <getter> write <setter>;

  if IsGet then
    Result := TBrowseForFolder(AObj).RootDir
  else
    TBrowseForFolder(AObj).RootDir := string(AArgs[0]);
end;

function TBrowseForFolder_OnCallback_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCallback: TBrowseForFolderCallbackEvent read <...

  if IsGet then
    Result := TBrowseForFolderCallbackEvent_sw.ToVar(TBrowseForFolder(AObj).
      OnCallback)
  else
    TBrowseForFolder(AObj).OnCallback := TBrowseForFolderCallbackEvent_sw.
      FromVar(AArgs[0]);
end;

function TBrowseForFolder_OnValidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnValidate: TBrowseForFolderCallbackEvent read <...

  if IsGet then
    Result := TBrowseForFolderCallbackEvent_sw.ToVar(TBrowseForFolder(AObj).
      OnValidate)
  else
    TBrowseForFolder(AObj).OnValidate := TBrowseForFolderCallbackEvent_sw.
      FromVar(AArgs[0]);
end;

class function TBrowseForFolder_sw.GetTypeName: WideString;
begin
  Result := 'TBrowseForFolder';
end;

class function TBrowseForFolder_sw.GetWrappedClass: TClass;
begin
  Result := TBrowseForFolder;
end;

class procedure TBrowseForFolder_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Folder', TBrowseForFolder_Folder_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Caption');
  AData.AddProperty('DialogCaption', TBrowseForFolder_DialogCaption_si, string_sw, True, True, 0, False);
  AData.AddProperty('BrowseOptions', TBrowseForFolder_BrowseOptions_si, TBrowseOptions_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Enabled');
  AData.AddPropertyRedecl('HelpContext');
  AData.AddPropertyRedecl('HelpKeyword');
  AData.AddPropertyRedecl('HelpType');
  AData.AddPropertyRedecl('Hint');
  AData.AddPropertyRedecl('ImageIndex');
  AData.AddProperty('RootDir', TBrowseForFolder_RootDir_si, string_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ShortCut');
  AData.AddPropertyRedecl('SecondaryShortCuts');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('BeforeExecute');
  AData.AddProperty('OnCallback', TBrowseForFolder_OnCallback_si, TBrowseForFolderCallbackEvent_sw, True, True, 0, False);
  AData.AddProperty('OnValidate', TBrowseForFolder_OnValidate_si, TBrowseForFolderCallbackEvent_sw, True, True, 0, False);
  AData.AddPropertyRedecl('OnAccept');
  AData.AddPropertyRedecl('OnCancel');
  AData.AddPropertyRedecl('OnHint');
end;

class function TBrowseForFolder_sw.ToVar(
  const AValue: TBrowseForFolder): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBrowseForFolder_sw.FromVar(
  const AValue: OleVariant): TBrowseForFolder;
begin
  Result := TBrowseForFolder(ConvFromVar(AValue, TBrowseForFolder));
end;

class function TBrowseForFolder_sw.ClassToVar(
  AClass: TBrowseForFolder_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBrowseForFolder_sw.ClassFromVar(
  const AClass: OleVariant): TBrowseForFolder_sc;
begin
  Result := TBrowseForFolder_sc(ConvClsFromVar(AClass, TBrowseForFolder));
end;

{ StdActns_sw }

function StdActns_THintAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintAction = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(THintAction_sw);
end;

function StdActns_TEditAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditAction = class(TAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditAction_sw);
end;

function StdActns_TEditCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditCut = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditCut_sw);
end;

function StdActns_TEditCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditCopy = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditCopy_sw);
end;

function StdActns_TEditPaste_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditPaste = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditPaste_sw);
end;

function StdActns_TEditSelectAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditSelectAll = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditSelectAll_sw);
end;

function StdActns_TEditUndo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditUndo = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditUndo_sw);
end;

function StdActns_TEditDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditDelete = class(TEditAction);

  Result := TLMDUnitWrapper.TypeToVar(TEditDelete_sw);
end;

function StdActns_TWindowAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowAction = class(TAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowAction_sw);
end;

function StdActns_TWindowClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowClose = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowClose_sw);
end;

function StdActns_TWindowCascade_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowCascade = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowCascade_sw);
end;

function StdActns_TWindowTileHorizontal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowTileHorizontal = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowTileHorizontal_sw);
end;

function StdActns_TWindowTileVertical_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowTileVertical = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowTileVertical_sw);
end;

function StdActns_TWindowMinimizeAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowMinimizeAll = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowMinimizeAll_sw);
end;

function StdActns_TWindowArrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowArrange = class(TWindowAction);

  Result := TLMDUnitWrapper.TypeToVar(TWindowArrange_sw);
end;

function StdActns_THelpAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpAction = class(TAction);

  Result := TLMDUnitWrapper.TypeToVar(THelpAction_sw);
end;

function StdActns_THelpContents_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpContents = class(THelpAction);

  Result := TLMDUnitWrapper.TypeToVar(THelpContents_sw);
end;

function StdActns_THelpTopicSearch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpTopicSearch = class(THelpAction);

  Result := TLMDUnitWrapper.TypeToVar(THelpTopicSearch_sw);
end;

function StdActns_THelpOnHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpOnHelp = class(THelpAction);

  Result := TLMDUnitWrapper.TypeToVar(THelpOnHelp_sw);
end;

function StdActns_THelpContextAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpContextAction = class(THelpAction);

  Result := TLMDUnitWrapper.TypeToVar(THelpContextAction_sw);
end;

function StdActns_TCommonDialogClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonDialogClass = class of TCommonDialog;

  Result := TLMDUnitWrapper.TypeToVar(TCommonDialogClass_sw);
end;

function StdActns_TCommonDialogAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonDialogAction = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TCommonDialogAction_sw);
end;

function StdActns_TFileAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileAction = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TFileAction_sw);
end;

function StdActns_TFileOpen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileOpen = class(TFileAction);

  Result := TLMDUnitWrapper.TypeToVar(TFileOpen_sw);
end;

function StdActns_TFileOpenWith_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileOpenWith = class(TFileOpen);

  Result := TLMDUnitWrapper.TypeToVar(TFileOpenWith_sw);
end;

function StdActns_TFileSaveAs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileSaveAs = class(TFileAction);

  Result := TLMDUnitWrapper.TypeToVar(TFileSaveAs_sw);
end;

function StdActns_TFilePrintSetup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilePrintSetup = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TFilePrintSetup_sw);
end;

function StdActns_TFilePageSetup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilePageSetup = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TFilePageSetup_sw);
end;

function StdActns_TFileExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileExit = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TFileExit_sw);
end;

function StdActns_TSearchAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchAction = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TSearchAction_sw);
end;

function StdActns_TSearchFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchFind = class(TSearchAction);

  Result := TLMDUnitWrapper.TypeToVar(TSearchFind_sw);
end;

function StdActns_TSearchReplace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchReplace = class(TSearchAction);

  Result := TLMDUnitWrapper.TypeToVar(TSearchReplace_sw);
end;

function StdActns_TSearchFindFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchFindFirst = class(TSearchFind);

  Result := TLMDUnitWrapper.TypeToVar(TSearchFindFirst_sw);
end;

function StdActns_TSearchFindNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSearchFindNext = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TSearchFindNext_sw);
end;

function StdActns_TFontEdit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontEdit = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TFontEdit_sw);
end;

function StdActns_TColorSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorSelect = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TColorSelect_sw);
end;

function StdActns_TPrintDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDlg = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TPrintDlg_sw);
end;

function StdActns_TBrowseForFolderOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrowseForFolderOption = (bifBrowseForPrinter, bifBr...

  Result := TLMDUnitWrapper.TypeToVar(TBrowseForFolderOption_sw);
end;

function StdActns_TBrowseOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrowseOptions = set of TBrowseForFolderOption;

  Result := TLMDUnitWrapper.TypeToVar(TBrowseOptions_sw);
end;

function StdActns_TBrowseForFolderCallbackEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrowseForFolderCallbackEvent = procedure (Sender: T...

  Result := TLMDUnitWrapper.TypeToVar(TBrowseForFolderCallbackEvent_sw);
end;

function StdActns_TBrowseForFolder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBrowseForFolder = class(TCommonDialogAction);

  Result := TLMDUnitWrapper.TypeToVar(TBrowseForFolder_sw);
end;

class function StdActns_sw.GetUnitName: WideString;
begin
  Result := 'StdActns';
end;

class procedure StdActns_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(THintAction_sw, StdActns_THintAction_si);
  AData.AddType(TEditAction_sw, StdActns_TEditAction_si);
  AData.AddType(TEditCut_sw, StdActns_TEditCut_si);
  AData.AddType(TEditCopy_sw, StdActns_TEditCopy_si);
  AData.AddType(TEditPaste_sw, StdActns_TEditPaste_si);
  AData.AddType(TEditSelectAll_sw, StdActns_TEditSelectAll_si);
  AData.AddType(TEditUndo_sw, StdActns_TEditUndo_si);
  AData.AddType(TEditDelete_sw, StdActns_TEditDelete_si);
  AData.AddType(TWindowAction_sw, StdActns_TWindowAction_si);
  AData.AddType(TWindowClose_sw, StdActns_TWindowClose_si);
  AData.AddType(TWindowCascade_sw, StdActns_TWindowCascade_si);
  AData.AddType(TWindowTileHorizontal_sw, StdActns_TWindowTileHorizontal_si);
  AData.AddType(TWindowTileVertical_sw, StdActns_TWindowTileVertical_si);
  AData.AddType(TWindowMinimizeAll_sw, StdActns_TWindowMinimizeAll_si);
  AData.AddType(TWindowArrange_sw, StdActns_TWindowArrange_si);
  AData.AddType(THelpAction_sw, StdActns_THelpAction_si);
  AData.AddType(THelpContents_sw, StdActns_THelpContents_si);
  AData.AddType(THelpTopicSearch_sw, StdActns_THelpTopicSearch_si);
  AData.AddType(THelpOnHelp_sw, StdActns_THelpOnHelp_si);
  AData.AddType(THelpContextAction_sw, StdActns_THelpContextAction_si);
  AData.AddType(TCommonDialogClass_sw, StdActns_TCommonDialogClass_si);
  AData.AddType(TCommonDialogAction_sw, StdActns_TCommonDialogAction_si);
  AData.AddType(TFileAction_sw, StdActns_TFileAction_si);
  AData.AddType(TFileOpen_sw, StdActns_TFileOpen_si);
  AData.AddType(TFileOpenWith_sw, StdActns_TFileOpenWith_si);
  AData.AddType(TFileSaveAs_sw, StdActns_TFileSaveAs_si);
  AData.AddType(TFilePrintSetup_sw, StdActns_TFilePrintSetup_si);
  AData.AddType(TFilePageSetup_sw, StdActns_TFilePageSetup_si);
  AData.AddType(TFileExit_sw, StdActns_TFileExit_si);
  AData.AddType(TSearchAction_sw, StdActns_TSearchAction_si);
  AData.AddType(TSearchFind_sw, StdActns_TSearchFind_si);
  AData.AddType(TSearchReplace_sw, StdActns_TSearchReplace_si);
  AData.AddType(TSearchFindFirst_sw, StdActns_TSearchFindFirst_si);
  AData.AddType(TSearchFindNext_sw, StdActns_TSearchFindNext_si);
  AData.AddType(TFontEdit_sw, StdActns_TFontEdit_si);
  AData.AddType(TColorSelect_sw, StdActns_TColorSelect_si);
  AData.AddType(TPrintDlg_sw, StdActns_TPrintDlg_si);
  AData.AddType(TBrowseForFolderOption_sw, StdActns_TBrowseForFolderOption_si);
  AData.AddType(TBrowseOptions_sw, StdActns_TBrowseOptions_si);
  AData.AddType(TBrowseForFolderCallbackEvent_sw, StdActns_TBrowseForFolderCallbackEvent_si);
  AData.AddType(TBrowseForFolder_sw, StdActns_TBrowseForFolder_si);
end;

class function StdActns_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(StdActns_sw);
end;

initialization
  RegisterUnitWrapper(StdActns_sw);
  RegisterClassWrapper(THintAction_sw);
  RegisterClassWrapper(TEditAction_sw);
  RegisterClassWrapper(TEditCut_sw);
  RegisterClassWrapper(TEditCopy_sw);
  RegisterClassWrapper(TEditPaste_sw);
  RegisterClassWrapper(TEditSelectAll_sw);
  RegisterClassWrapper(TEditUndo_sw);
  RegisterClassWrapper(TEditDelete_sw);
  RegisterClassWrapper(TWindowAction_sw);
  RegisterClassWrapper(TWindowClose_sw);
  RegisterClassWrapper(TWindowCascade_sw);
  RegisterClassWrapper(TWindowTileHorizontal_sw);
  RegisterClassWrapper(TWindowTileVertical_sw);
  RegisterClassWrapper(TWindowMinimizeAll_sw);
  RegisterClassWrapper(TWindowArrange_sw);
  RegisterClassWrapper(THelpAction_sw);
  RegisterClassWrapper(THelpContents_sw);
  RegisterClassWrapper(THelpTopicSearch_sw);
  RegisterClassWrapper(THelpOnHelp_sw);
  RegisterClassWrapper(THelpContextAction_sw);
  RegisterClassWrapper(TCommonDialogAction_sw);
  RegisterClassWrapper(TFileAction_sw);
  RegisterClassWrapper(TFileOpen_sw);
  RegisterClassWrapper(TFileOpenWith_sw);
  RegisterClassWrapper(TFileSaveAs_sw);
  RegisterClassWrapper(TFilePrintSetup_sw);
  RegisterClassWrapper(TFilePageSetup_sw);
  RegisterClassWrapper(TFileExit_sw);
  RegisterClassWrapper(TSearchAction_sw);
  RegisterClassWrapper(TSearchFind_sw);
  RegisterClassWrapper(TSearchReplace_sw);
  RegisterClassWrapper(TSearchFindFirst_sw);
  RegisterClassWrapper(TSearchFindNext_sw);
  RegisterClassWrapper(TFontEdit_sw);
  RegisterClassWrapper(TColorSelect_sw);
  RegisterClassWrapper(TPrintDlg_sw);
  RegisterClassWrapper(TBrowseForFolder_sw);
  RegisterEventWrapper(TypeInfo(TBrowseForFolderCallbackEvent), TBrowseForFolderCallbackEvent_sw);

end.
