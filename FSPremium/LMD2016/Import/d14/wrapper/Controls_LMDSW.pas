unit Controls_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Controls' unit.
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
  LMDSctSysWrappers, Messages, Windows, MultiMon, Classes, SysUtils, Graphics,
  Menus, CommCtrl, Imm, ImgList, ActnList, Types, Controls, Messages_LMDSW,
  Windows_LMDSW, MultiMon_LMDSW, Classes_LMDSW, SysUtils_LMDSW, Graphics_LMDSW,
  Menus_LMDSW, CommCtrl_LMDSW, Imm_LMDSW, ImgList_LMDSW, ActnList_LMDSW,
  Types_LMDSW;


{ Type wrappers }

type
  TWinControlClass_sw = class;
  THintWindowClass_sw = class;
  TDragObject_sw = class;
  TDragObjectClass_sw = class;
  TDragObjectEx_sw = class;
  TBaseDragControlObject_sw = class;
  TDragControlObject_sw = class;
  TDragControlObjectEx_sw = class;
  TDragDockObject_sw = class;
  TDragDockObjectEx_sw = class;
  TControlCanvas_sw = class;
  TCustomControlAction_sw = class;
  TControlAction_sw = class;
  TControlActionLink_sw = class;
  TControlActionLinkClass_sw = class;
  TSizeConstraints_sw = class;
  TMargins_sw = class;
  TPadding_sw = class;
  EGestureException_sw = class;
  TCustomGestureCollectionItem_sw = class;
  TCustomGestureCollection_sw = class;
  TCustomGestureManager_sw = class;
  TCustomGestureEngine_sw = class;
  TCustomTouchManager_sw = class;
  TTouchManager_sw = class;
  TControl_sw = class;
  TControlClass_sw = class;
  TWinControlActionLink_sw = class;
  TWinControlActionLinkClass_sw = class;
  TWinControl_sw = class;
  TGraphicControl_sw = class;
  TCustomControl_sw = class;
  TCustomTransparentControl_sw = class;
  THintWindow_sw = class;
  TDragImageList_sw = class;
  TImageList_sw = class;
  TDockZone_sw = class;
  TDockTreeClass_sw = class;
  TDockTree_sw = class;
  TPanningWindowClass_sw = class;
  TCustomPanningWindow_sw = class;
  TMouse_sw = class;
  TCustomListControl_sw = class;
  TCustomMultiSelectListControl_sw = class;
  TCustomHintWindow_sw = class;
  TCustomHintShowHideThread_sw = class;
  TCustomHint_sw = class;
  TBalloonHint_sw = class;

  TModalResult_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TModalResult): OleVariant;
    class function FromVar(const AValue: OleVariant): TModalResult;
  end;

  TCursor_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCursor): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursor;
  end;

  TInteractiveGestureFlag_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TInteractiveGestureFlag): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGestureFlag;
  end;

  TInteractiveGestureFlags_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TInteractiveGestureFlags): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGestureFlags;
  end;

  TInteractiveGesture_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TInteractiveGesture): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGesture;
  end;

  TInteractiveGestures_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TInteractiveGestures): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGestures;
  end;

  TInteractiveGestureOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TInteractiveGestureOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGestureOption;
  end;

  TInteractiveGestureOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TInteractiveGestureOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TInteractiveGestureOptions;
  end;

  TCustomLongData_sw = Longint_sw;

  TWinControlClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TWinControlClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TWinControlClass;
  end;

  THintWindowClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: THintWindowClass): OleVariant;
    class function FromVar(const AValue: OleVariant): THintWindowClass;
  end;

  TCMActivate_sw = TWMNoParams_sw;

  TCMDeactivate_sw = TWMNoParams_sw;

  TCMGotFocus_sw = TWMNoParams_sw;

  TCMLostFocus_sw = TWMNoParams_sw;

  TCMDialogKey_sw = TWMKey_sw;

  TCMDialogChar_sw = TWMKey_sw;

  TCMHitTest_sw = TWMNCHitTest_sw;

  TCMEnter_sw = TWMNoParams_sw;

  TCMExit_sw = TWMNoParams_sw;

  TCMDesignHitTest_sw = TWMMouse_sw;

  TCMWantSpecialKey_sw = TWMKey_sw;

  TCMMouseWheel_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMMouseWheel;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMMouseWheel): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMMouseWheel;
  end;

  TCMCancelMode_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMCancelMode;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMCancelMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMCancelMode;
  end;

  TCMFocusChanged_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMFocusChanged;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMFocusChanged): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMFocusChanged;
  end;

  TCMControlListChange_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMControlListChange;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMControlListChange): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMControlListChange;
  end;

  TControlListItem_sw = class(TLMDRecordWrapper)
  private
    FValue: TControlListItem;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TControlListItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlListItem;
  end;

  TCMControlListChanging_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMControlListChanging;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMControlListChanging): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMControlListChanging;
  end;

  TCMChildKey_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMChildKey;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMChildKey): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMChildKey;
  end;

  TCMControlChange_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMControlChange;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMControlChange): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMControlChange;
  end;

  TCMChanged_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMChanged;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMChanged): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMChanged;
  end;

  THintInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: THintInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: THintInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): THintInfo;
  end;

  TCMHintShow_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMHintShow;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMHintShow): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMHintShow;
  end;

  TCMParentFontChanged_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMParentFontChanged;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMParentFontChanged): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMParentFontChanged;
  end;

  TDragMessage_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDragMessage): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragMessage;
  end;

  TDragRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TDragRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDragRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragRec;
  end;

  TCMDrag_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMDrag;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMDrag): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMDrag;
  end;

  TDockNotifyRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TDockNotifyRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDockNotifyRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockNotifyRec;
  end;

  TCMDockClient_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMDockClient;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMDockClient): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMDockClient;
  end;

  TCMUnDockClient_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMUnDockClient;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMUnDockClient): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMUnDockClient;
  end;

  TCMFloat_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMFloat;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMFloat): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMFloat;
  end;

  TCMDockNotification_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMDockNotification;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMDockNotification): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMDockNotification;
  end;

  TPopupFormInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TPopupFormInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPopupFormInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupFormInfo;
  end;

  TCMPopupHWndDestroy_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMPopupHWndDestroy;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMPopupHWndDestroy): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMPopupHWndDestroy;
  end;

  TCMCreatePopup_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMCreatePopup;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMCreatePopup): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMCreatePopup;
  end;

  TAlign_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAlign): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlign;
  end;

  TAlignSet_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TAlignSet): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlignSet;
  end;

  TDragObject_sc = class of TDragObject;
  TDragObject_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragObject;
    class function ClassToVar(AClass: TDragObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragObject_sc;
  end;

  TDragObjectClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TDragObjectClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragObjectClass;
  end;

  TDragObjectEx_sc = class of TDragObjectEx;
  TDragObjectEx_sw = class(TDragObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragObjectEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragObjectEx;
    class function ClassToVar(AClass: TDragObjectEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragObjectEx_sc;
  end;

  TBaseDragControlObject_sc = class of TBaseDragControlObject;
  TBaseDragControlObject_sw = class(TDragObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBaseDragControlObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TBaseDragControlObject;
    class function ClassToVar(AClass: TBaseDragControlObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBaseDragControlObject_sc;
  end;

  TDragControlObject_sc = class of TDragControlObject;
  TDragControlObject_sw = class(TBaseDragControlObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragControlObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragControlObject;
    class function ClassToVar(AClass: TDragControlObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragControlObject_sc;
  end;

  TDragControlObjectEx_sc = class of TDragControlObjectEx;
  TDragControlObjectEx_sw = class(TDragControlObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragControlObjectEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragControlObjectEx;
    class function ClassToVar(AClass: TDragControlObjectEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragControlObjectEx_sc;
  end;

  TDragDockObject_sc = class of TDragDockObject;
  TDragDockObject_sw = class(TBaseDragControlObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragDockObject): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragDockObject;
    class function ClassToVar(AClass: TDragDockObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragDockObject_sc;
  end;

  TDragDockObjectEx_sc = class of TDragDockObjectEx;
  TDragDockObjectEx_sw = class(TDragDockObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragDockObjectEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragDockObjectEx;
    class function ClassToVar(AClass: TDragDockObjectEx_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragDockObjectEx_sc;
  end;

  TCanvasDC_sw = HDC_sw;

  TControlCanvas_sc = class of TControlCanvas;
  TControlCanvas_sw = class(TCanvas_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControlCanvas): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlCanvas;
    class function ClassToVar(AClass: TControlCanvas_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControlCanvas_sc;
  end;

  TCustomControlAction_sc = class of TCustomControlAction;
  TCustomControlAction_sw = class(TCustomAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomControlAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomControlAction;
    class function ClassToVar(AClass: TCustomControlAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomControlAction_sc;
  end;

  TControlAction_sc = class of TControlAction;
  TControlAction_sw = class(TCustomControlAction_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControlAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlAction;
    class function ClassToVar(AClass: TControlAction_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControlAction_sc;
  end;

  TControlActionLink_sc = class of TControlActionLink;
  TControlActionLink_sw = class(TActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControlActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlActionLink;
    class function ClassToVar(AClass: TControlActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControlActionLink_sc;
  end;

  TControlActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TControlActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlActionLinkClass;
  end;

  TMouseButton_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMouseButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TMouseButton;
  end;

  TMouseActivate_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMouseActivate): OleVariant;
    class function FromVar(const AValue: OleVariant): TMouseActivate;
  end;

  TDragMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDragMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragMode;
  end;

  TDragState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDragState): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragState;
  end;

  TDragKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDragKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragKind;
  end;

  TTabOrder_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTabOrder): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabOrder;
  end;

  TCaption_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCaption): OleVariant;
    class function FromVar(const AValue: OleVariant): TCaption;
  end;

  TMouseActivateRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TMouseActivateRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMouseActivateRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TMouseActivateRec;
  end;

  TCMMouseActivate_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMMouseActivate;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMMouseActivate): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMMouseActivate;
  end;

  TAnchorKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TAnchorKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TAnchorKind;
  end;

  TAnchors_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TAnchors): OleVariant;
    class function FromVar(const AValue: OleVariant): TAnchors;
  end;

  TConstraintSize_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TConstraintSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TConstraintSize;
  end;

  TSizeConstraints_sc = class of TSizeConstraints;
  TSizeConstraints_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSizeConstraints): OleVariant;
    class function FromVar(const AValue: OleVariant): TSizeConstraints;
    class function ClassToVar(AClass: TSizeConstraints_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSizeConstraints_sc;
  end;

  TMarginSize_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMarginSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TMarginSize;
  end;

  TMargins_sc = class of TMargins;
  TMargins_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMargins): OleVariant;
    class function FromVar(const AValue: OleVariant): TMargins;
    class function ClassToVar(AClass: TMargins_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMargins_sc;
  end;

  TPadding_sc = class of TPadding;
  TPadding_sw = class(TMargins_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPadding): OleVariant;
    class function FromVar(const AValue: OleVariant): TPadding;
    class function ClassToVar(AClass: TPadding_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPadding_sc;
  end;

  TGestureID_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGestureID): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureID;
  end;

  TGestureEventInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TGestureEventInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGestureEventInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureEventInfo;
  end;

  TCMGesture_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMGesture;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMGesture): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMGesture;
  end;

  TGestureEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  end;

  TGestureEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGestureEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGestureEvent;
  end;

  TStandardGesture_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TStandardGesture): OleVariant;
    class function FromVar(const AValue: OleVariant): TStandardGesture;
  end;

  TStandardGestures_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TStandardGestures): OleVariant;
    class function FromVar(const AValue: OleVariant): TStandardGestures;
  end;

  TTabletOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTabletOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabletOption;
  end;

  TTabletOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTabletOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabletOptions;
  end;

  TGestureType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGestureType): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureType;
  end;

  TGestureTypes_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TGestureTypes): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureTypes;
  end;

  TGestureOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGestureOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureOption;
  end;

  TGestureOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TGestureOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TGestureOptions;
  end;

  EGestureException_sc = class of EGestureException;
  EGestureException_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EGestureException): OleVariant;
    class function FromVar(const AValue: OleVariant): EGestureException;
    class function ClassToVar(AClass: EGestureException_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EGestureException_sc;
  end;

  TCustomGestureCollectionItem_sc = class of TCustomGestureCollectionItem;
  TCustomGestureCollectionItem_sw = class(TCollectionItem_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGestureCollectionItem): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGestureCollectionItem;
    class function ClassToVar(AClass: TCustomGestureCollectionItem_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGestureCollectionItem_sc;
  end;

  TCustomGestureCollection_sc = class of TCustomGestureCollection;
  TCustomGestureCollection_sw = class(TCollection_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGestureCollection): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGestureCollection;
    class function ClassToVar(AClass: TCustomGestureCollection_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGestureCollection_sc;
  end;

  TCustomGestureManager_sc = class of TCustomGestureManager;
  TCustomGestureManager_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGestureManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGestureManager;
    class function ClassToVar(AClass: TCustomGestureManager_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGestureManager_sc;
  end;

  TCustomGestureEngine_sc = class of TCustomGestureEngine;
  TCustomGestureEngine_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomGestureEngine): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomGestureEngine;
    class function ClassToVar(AClass: TCustomGestureEngine_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomGestureEngine_sc;
  end;

  TTouchProperty_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTouchProperty): OleVariant;
    class function FromVar(const AValue: OleVariant): TTouchProperty;
  end;

  TCustomTouchManager_sc = class of TCustomTouchManager;
  TCustomTouchManager_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomTouchManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomTouchManager;
    class function ClassToVar(AClass: TCustomTouchManager_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomTouchManager_sc;
  end;

  TTouchManager_sc = class of TTouchManager;
  TTouchManager_sw = class(TCustomTouchManager_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTouchManager): OleVariant;
    class function FromVar(const AValue: OleVariant): TTouchManager;
    class function ClassToVar(AClass: TTouchManager_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTouchManager_sc;
  end;

  TKeyPressEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Key: Char);
  end;

  TKeyPressEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TKeyPressEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TKeyPressEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TKeyPressEvent;
  end;

  TDragOverEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Source: TObject; X: Integer; Y: Integer;
      State: TDragState; var Accept: Boolean);
  end;

  TDragOverEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDragOverEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragOverEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDragOverEvent;
  end;

  TDragDropEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
  end;

  TDragDropEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDragDropEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragDropEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDragDropEvent;
  end;

  TStartDragEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var DragObject: TDragObject);
  end;

  TStartDragEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TStartDragEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TStartDragEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TStartDragEvent;
  end;

  TEndDragEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Target: TObject; X: Integer; Y: Integer);
  end;

  TEndDragEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TEndDragEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TEndDragEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TEndDragEvent;
  end;

  TDockDropEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Source: TDragDockObject; X: Integer;
      Y: Integer);
  end;

  TDockDropEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDockDropEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockDropEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDockDropEvent;
  end;

  TDockOverEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Source: TDragDockObject; X: Integer;
      Y: Integer; State: TDragState; var Accept: Boolean);
  end;

  TDockOverEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TDockOverEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockOverEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TDockOverEvent;
  end;

  TUnDockEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Client: TControl; NewTarget: TWinControl;
      var Allow: Boolean);
  end;

  TUnDockEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TUnDockEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TUnDockEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TUnDockEvent;
  end;

  TStartDockEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var DragObject: TDragDockObject);
  end;

  TStartDockEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TStartDockEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TStartDockEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TStartDockEvent;
  end;

  TGetSiteInfoEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
  end;

  TGetSiteInfoEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetSiteInfoEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetSiteInfoEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetSiteInfoEvent;
  end;

  TCanResizeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var NewWidth: Integer;
      var NewHeight: Integer; var Resize: Boolean);
  end;

  TCanResizeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCanResizeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCanResizeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCanResizeEvent;
  end;

  TConstrainedResizeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var MinWidth: Integer;
      var MinHeight: Integer; var MaxWidth: Integer; var MaxHeight: Integer);
  end;

  TConstrainedResizeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TConstrainedResizeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TConstrainedResizeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TConstrainedResizeEvent;
  end;

  TContextPopupEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  end;

  TContextPopupEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TContextPopupEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TContextPopupEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TContextPopupEvent;
  end;

  TWndMethod_sw = Classes_LMDSW.TWndMethod_sw;

  TDockOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDockOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockOrientation;
  end;

  TControl_sc = class of TControl;
  TControl_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TControl;
    class function ClassToVar(AClass: TControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControl_sc;
  end;

  TControlClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TControlClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlClass;
  end;

  TCreateParams_sw = class(TLMDRecordWrapper)
  private
    FValue: TCreateParams;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCreateParams): OleVariant;
    class function FromVar(const AValue: OleVariant): TCreateParams;
  end;

  TWinControlActionLink_sc = class of TWinControlActionLink;
  TWinControlActionLink_sw = class(TControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWinControlActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TWinControlActionLink;
    class function ClassToVar(AClass: TWinControlActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWinControlActionLink_sc;
  end;

  TWinControlActionLinkClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TWinControlActionLinkClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TWinControlActionLinkClass;
  end;

  TImeMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TImeMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TImeMode;
  end;

  TImeName_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TImeName): OleVariant;
    class function FromVar(const AValue: OleVariant): TImeName;
  end;

  TAlignInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TAlignInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TAlignInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlignInfo;
  end;

  TBorderWidth_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBorderWidth): OleVariant;
    class function FromVar(const AValue: OleVariant): TBorderWidth;
  end;

  TBevelCut_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBevelCut): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelCut;
  end;

  TBevelEdge_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBevelEdge): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelEdge;
  end;

  TBevelEdges_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TBevelEdges): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelEdges;
  end;

  TBevelKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBevelKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelKind;
  end;

  TBevelWidth_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBevelWidth): OleVariant;
    class function FromVar(const AValue: OleVariant): TBevelWidth;
  end;

  TAlignInsertBeforeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(Sender: TWinControl; C1: TControl; C2: TControl): Boolean;
  end;

  TAlignInsertBeforeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAlignInsertBeforeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlignInsertBeforeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TAlignInsertBeforeEvent;
  end;

  TAlignPositionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TWinControl; Control: TControl;
      var NewLeft: Integer; var NewTop: Integer; var NewWidth: Integer;
      var NewHeight: Integer; var AlignRect: TRect; AlignInfo: TAlignInfo);
  end;

  TAlignPositionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAlignPositionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlignPositionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TAlignPositionEvent;
  end;

  TWinControl_sc = class of TWinControl;
  TWinControl_sw = class(TControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TWinControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TWinControl;
    class function ClassToVar(AClass: TWinControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TWinControl_sc;
  end;

  TGraphicControl_sc = class of TGraphicControl;
  TGraphicControl_sw = class(TControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGraphicControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TGraphicControl;
    class function ClassToVar(AClass: TGraphicControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGraphicControl_sc;
  end;

  TCustomControl_sc = class of TCustomControl;
  TCustomControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomControl;
    class function ClassToVar(AClass: TCustomControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomControl_sc;
  end;

  TCustomTransparentControl_sc = class of TCustomTransparentControl;
  TCustomTransparentControl_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomTransparentControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomTransparentControl;
    class function ClassToVar(AClass: TCustomTransparentControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomTransparentControl_sc;
  end;

  THintWindow_sc = class of THintWindow;
  THintWindow_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: THintWindow): OleVariant;
    class function FromVar(const AValue: OleVariant): THintWindow;
    class function ClassToVar(AClass: THintWindow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): THintWindow_sc;
  end;

  TDragImageList_sc = class of TDragImageList;
  TDragImageList_sw = class(TCustomImageList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDragImageList): OleVariant;
    class function FromVar(const AValue: OleVariant): TDragImageList;
    class function ClassToVar(AClass: TDragImageList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDragImageList_sc;
  end;

  TImageList_sc = class of TImageList;
  TImageList_sw = class(TDragImageList_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TImageList): OleVariant;
    class function FromVar(const AValue: OleVariant): TImageList;
    class function ClassToVar(AClass: TImageList_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TImageList_sc;
  end;

  TDockZone_sc = class of TDockZone;
  TDockZone_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDockZone): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockZone;
    class function ClassToVar(AClass: TDockZone_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDockZone_sc;
  end;

  TForEachZoneProc_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Zone: TDockZone);
  end;

  TForEachZoneProc_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TForEachZoneProc): OleVariant;
    class function FromVar(const AValue: OleVariant): TForEachZoneProc;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TForEachZoneProc;
  end;

  TDockTreeClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TDockTreeClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockTreeClass;
  end;

  TDockTree_sc = class of TDockTree;
  TDockTree_sw = class(TInterfacedObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TDockTree): OleVariant;
    class function FromVar(const AValue: OleVariant): TDockTree;
    class function ClassToVar(AClass: TDockTree_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TDockTree_sc;
  end;

  TPanningWindowClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TPanningWindowClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TPanningWindowClass;
  end;

  TCustomPanningWindow_sc = class of TCustomPanningWindow;
  TCustomPanningWindow_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomPanningWindow): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomPanningWindow;
    class function ClassToVar(AClass: TCustomPanningWindow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomPanningWindow_sc;
  end;

  TMouse_sc = class of TMouse;
  TMouse_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMouse): OleVariant;
    class function FromVar(const AValue: OleVariant): TMouse;
    class function ClassToVar(AClass: TMouse_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMouse_sc;
  end;

  TCustomListControl_sc = class of TCustomListControl;
  TCustomListControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomListControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomListControl;
    class function ClassToVar(AClass: TCustomListControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomListControl_sc;
  end;

  TCustomMultiSelectListControl_sc = class of TCustomMultiSelectListControl;
  TCustomMultiSelectListControl_sw = class(TCustomListControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomMultiSelectListControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomMultiSelectListControl;
    class function ClassToVar(AClass: TCustomMultiSelectListControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomMultiSelectListControl_sc;
  end;

  TBalloonHintIcon_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBalloonHintIcon): OleVariant;
    class function FromVar(const AValue: OleVariant): TBalloonHintIcon;
  end;

  TBalloonHintIconSize_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBalloonHintIconSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TBalloonHintIconSize;
  end;

  TBalloonHintStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBalloonHintStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TBalloonHintStyle;
  end;

  TCustomHintWindow_sc = class of TCustomHintWindow;
  TCustomHintWindow_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomHintWindow): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHintWindow;
    class function ClassToVar(AClass: TCustomHintWindow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomHintWindow_sc;
  end;

  TCustomHintShowHideThread_sc = class of TCustomHintShowHideThread;
  TCustomHintShowHideThread_sw = class(TThread_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomHintShowHideThread): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHintShowHideThread;
    class function ClassToVar(AClass: TCustomHintShowHideThread_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomHintShowHideThread_sc;
  end;

  TCustomHint_sc = class of TCustomHint;
  TCustomHint_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomHint): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomHint;
    class function ClassToVar(AClass: TCustomHint_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomHint_sc;
  end;

  TBalloonHint_sc = class of TBalloonHint;
  TBalloonHint_sw = class(TCustomHint_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBalloonHint): OleVariant;
    class function FromVar(const AValue: OleVariant): TBalloonHint;
    class function ClassToVar(AClass: TBalloonHint_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBalloonHint_sc;
  end;


{ Unit wrapper }

type
  Controls_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TSizeConstraints_sacc = class(TSizeConstraints);
  TMargins_sacc = class(TMargins);
  TControl_sacc = class(TControl);
  TWinControl_sacc = class(TWinControl);
  TGraphicControl_sacc = class(TGraphicControl);
  TCustomControl_sacc = class(TCustomControl);
  TDockTree_sacc = class(TDockTree);
  TCustomHint_sacc = class(TCustomHint);

{ TModalResult_sw }

class function TModalResult_sw.GetTypeName: WideString;
begin
  Result := 'TModalResult';
end;

class function TModalResult_sw.ToVar(const AValue: TModalResult): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TModalResult_sw.FromVar(const AValue: OleVariant): TModalResult;
begin
  Result := TModalResult(Integer(AValue));
end;

{ TCursor_sw }

class function TCursor_sw.GetTypeName: WideString;
begin
  Result := 'TCursor';
end;

class function TCursor_sw.ToVar(const AValue: TCursor): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCursor_sw.FromVar(const AValue: OleVariant): TCursor;
begin
  Result := TCursor(Integer(AValue));
end;

{ TInteractiveGestureFlag_sw }

class function TInteractiveGestureFlag_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGestureFlag';
end;

class procedure TInteractiveGestureFlag_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'gfBegin'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureFlag.{$ENDIF}gfBegin)),
    (Name: 'gfInertia'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureFlag.{$ENDIF}gfInertia)),
    (Name: 'gfEnd'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureFlag.{$ENDIF}gfEnd))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TInteractiveGestureFlag_sw.ToVar(
  const AValue: TInteractiveGestureFlag): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TInteractiveGestureFlag_sw.FromVar(
  const AValue: OleVariant): TInteractiveGestureFlag;
begin
  Result := TInteractiveGestureFlag(Integer(AValue));
end;

{ TInteractiveGestureFlags_sw }

class function TInteractiveGestureFlags_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGestureFlags';
end;

class function TInteractiveGestureFlags_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TInteractiveGestureFlags);
end;

class function TInteractiveGestureFlags_sw.ToVar(
  const AValue: TInteractiveGestureFlags): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TInteractiveGestureFlags_sw.FromVar(
  const AValue: OleVariant): TInteractiveGestureFlags;
begin
  ConvFromVar(AValue, @Result);
end;

{ TInteractiveGesture_sw }

class function TInteractiveGesture_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGesture';
end;

class procedure TInteractiveGesture_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'igZoom'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGesture.{$ENDIF}igZoom)),
    (Name: 'igPan'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGesture.{$ENDIF}igPan)),
    (Name: 'igRotate'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGesture.{$ENDIF}igRotate)),
    (Name: 'igTwoFingerTap'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGesture.{$ENDIF}igTwoFingerTap)),
    (Name: 'igPressAndTap'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGesture.{$ENDIF}igPressAndTap))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TInteractiveGesture_sw.ToVar(
  const AValue: TInteractiveGesture): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TInteractiveGesture_sw.FromVar(
  const AValue: OleVariant): TInteractiveGesture;
begin
  Result := TInteractiveGesture(Integer(AValue));
end;

{ TInteractiveGestures_sw }

class function TInteractiveGestures_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGestures';
end;

class function TInteractiveGestures_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TInteractiveGestures);
end;

class function TInteractiveGestures_sw.ToVar(
  const AValue: TInteractiveGestures): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TInteractiveGestures_sw.FromVar(
  const AValue: OleVariant): TInteractiveGestures;
begin
  ConvFromVar(AValue, @Result);
end;

{ TInteractiveGestureOption_sw }

class function TInteractiveGestureOption_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGestureOption';
end;

class procedure TInteractiveGestureOption_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'igoPanSingleFingerHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureOption.{$ENDIF}igoPanSingleFingerHorizontal)),
    (Name: 'igoPanSingleFingerVertical'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureOption.{$ENDIF}igoPanSingleFingerVertical)),
    (Name: 'igoPanInertia'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureOption.{$ENDIF}igoPanInertia)),
    (Name: 'igoPanGutter'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureOption.{$ENDIF}igoPanGutter)),
    (Name: 'igoParentPassthrough'; Value: Integer({$IFDEF LMDSCT_12}TInteractiveGestureOption.{$ENDIF}igoParentPassthrough))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TInteractiveGestureOption_sw.ToVar(
  const AValue: TInteractiveGestureOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TInteractiveGestureOption_sw.FromVar(
  const AValue: OleVariant): TInteractiveGestureOption;
begin
  Result := TInteractiveGestureOption(Integer(AValue));
end;

{ TInteractiveGestureOptions_sw }

class function TInteractiveGestureOptions_sw.GetTypeName: WideString;
begin
  Result := 'TInteractiveGestureOptions';
end;

class function TInteractiveGestureOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TInteractiveGestureOptions);
end;

class function TInteractiveGestureOptions_sw.ToVar(
  const AValue: TInteractiveGestureOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TInteractiveGestureOptions_sw.FromVar(
  const AValue: OleVariant): TInteractiveGestureOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TWinControlClass_sw }

class function TWinControlClass_sw.GetTypeName: WideString;
begin
  Result := 'TWinControlClass';
end;

class function TWinControlClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TWinControl;
end;

class function TWinControlClass_sw.ToVar(
  const AValue: TWinControlClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWinControlClass_sw.FromVar(
  const AValue: OleVariant): TWinControlClass;
begin
  Result := TWinControlClass(ConvFromVar(AValue, TWinControl));
end;

{ THintWindowClass_sw }

class function THintWindowClass_sw.GetTypeName: WideString;
begin
  Result := 'THintWindowClass';
end;

class function THintWindowClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := THintWindow;
end;

class function THintWindowClass_sw.ToVar(
  const AValue: THintWindowClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THintWindowClass_sw.FromVar(
  const AValue: OleVariant): THintWindowClass;
begin
  Result := THintWindowClass(ConvFromVar(AValue, THintWindow));
end;

{ TCMMouseWheel_sw }

function TCMMouseWheel_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMMouseWheel_sw(AObj).FValue.Msg
  else
    TCMMouseWheel_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMMouseWheel_WheelDelta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WheelDelta: SmallInt;

  if IsGet then
    Result := TCMMouseWheel_sw(AObj).FValue.WheelDelta
  else
    TCMMouseWheel_sw(AObj).FValue.WheelDelta := SmallInt(AArgs[0]);
end;

function TCMMouseWheel_XPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var XPos: Smallint;

  if IsGet then
    Result := TCMMouseWheel_sw(AObj).FValue.XPos
  else
    TCMMouseWheel_sw(AObj).FValue.XPos := Smallint(AArgs[0]);
end;

function TCMMouseWheel_YPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var YPos: Smallint;

  if IsGet then
    Result := TCMMouseWheel_sw(AObj).FValue.YPos
  else
    TCMMouseWheel_sw(AObj).FValue.YPos := Smallint(AArgs[0]);
end;

function TCMMouseWheel_Pos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Pos: TSmallPoint;

  if IsGet then
    Result := TSmallPoint_sw.ToVar(TCMMouseWheel_sw(AObj).FValue.Pos)
  else
    TCMMouseWheel_sw(AObj).FValue.Pos := TSmallPoint_sw.FromVar(AArgs[0]);
end;

function TCMMouseWheel_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMMouseWheel_sw(AObj).FValue.Result
  else
    TCMMouseWheel_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMMouseWheel_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMMouseWheel_sw.Create as IDispatch;
end;

function TCMMouseWheel_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMMouseWheel;

  // Implicit record copy method.
  Result := TCMMouseWheel_sw.ToVar(TCMMouseWheel(AObj));
end;

class function TCMMouseWheel_sw.GetTypeName: WideString;
begin
  Result := 'TCMMouseWheel';
end;

function TCMMouseWheel_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMMouseWheel_sw.Create;
  TCMMouseWheel_sw(Result).FValue := FValue;
end;

class procedure TCMMouseWheel_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMMouseWheel_Msg_si, Cardinal_sw);
  AData.AddField('WheelDelta', TCMMouseWheel_WheelDelta_si, SmallInt_sw);
  AData.AddField('XPos', TCMMouseWheel_XPos_si, Smallint_sw);
  AData.AddField('YPos', TCMMouseWheel_YPos_si, Smallint_sw);
  AData.AddField('Pos', TCMMouseWheel_Pos_si, TSmallPoint_sw);
  AData.AddField('Result', TCMMouseWheel_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMMouseWheel_Copy_si, TCMMouseWheel_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMMouseWheel_Create_si, 0, False);
end;

class function TCMMouseWheel_sw.ToVar(const AValue: TCMMouseWheel): OleVariant;
var
  wrpr: TCMMouseWheel_sw;
begin
  wrpr        := TCMMouseWheel_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMMouseWheel_sw.FromVar(
  const AValue: OleVariant): TCMMouseWheel;
begin
  Result := TCMMouseWheel_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMCancelMode_sw }

function TCMCancelMode_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMCancelMode_sw(AObj).FValue.Msg
  else
    TCMCancelMode_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMCancelMode_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Integer;

  if IsGet then
    Result := TCMCancelMode_sw(AObj).FValue.Unused
  else
    TCMCancelMode_sw(AObj).FValue.Unused := Integer(AArgs[0]);
end;

function TCMCancelMode_Sender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Sender: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMCancelMode_sw(AObj).FValue.Sender)
  else
    TCMCancelMode_sw(AObj).FValue.Sender := TControl_sw.FromVar(AArgs[0]);
end;

function TCMCancelMode_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMCancelMode_sw(AObj).FValue.Result
  else
    TCMCancelMode_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMCancelMode_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMCancelMode_sw.Create as IDispatch;
end;

function TCMCancelMode_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMCancelMode;

  // Implicit record copy method.
  Result := TCMCancelMode_sw.ToVar(TCMCancelMode(AObj));
end;

class function TCMCancelMode_sw.GetTypeName: WideString;
begin
  Result := 'TCMCancelMode';
end;

function TCMCancelMode_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMCancelMode_sw.Create;
  TCMCancelMode_sw(Result).FValue := FValue;
end;

class procedure TCMCancelMode_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMCancelMode_Msg_si, Cardinal_sw);
  AData.AddField('Unused', TCMCancelMode_Unused_si, Integer_sw);
  AData.AddField('Sender', TCMCancelMode_Sender_si, TControl_sw);
  AData.AddField('Result', TCMCancelMode_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMCancelMode_Copy_si, TCMCancelMode_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMCancelMode_Create_si, 0, False);
end;

class function TCMCancelMode_sw.ToVar(const AValue: TCMCancelMode): OleVariant;
var
  wrpr: TCMCancelMode_sw;
begin
  wrpr        := TCMCancelMode_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMCancelMode_sw.FromVar(
  const AValue: OleVariant): TCMCancelMode;
begin
  Result := TCMCancelMode_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMFocusChanged_sw }

function TCMFocusChanged_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMFocusChanged_sw(AObj).FValue.Msg
  else
    TCMFocusChanged_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMFocusChanged_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Integer;

  if IsGet then
    Result := TCMFocusChanged_sw(AObj).FValue.Unused
  else
    TCMFocusChanged_sw(AObj).FValue.Unused := Integer(AArgs[0]);
end;

function TCMFocusChanged_Sender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Sender: TWinControl;

  if IsGet then
    Result := TWinControl_sw.ToVar(TCMFocusChanged_sw(AObj).FValue.Sender)
  else
    TCMFocusChanged_sw(AObj).FValue.Sender := TWinControl_sw.FromVar(AArgs[0]);
end;

function TCMFocusChanged_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMFocusChanged_sw(AObj).FValue.Result
  else
    TCMFocusChanged_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMFocusChanged_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMFocusChanged_sw.Create as IDispatch;
end;

function TCMFocusChanged_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMFocusChanged;

  // Implicit record copy method.
  Result := TCMFocusChanged_sw.ToVar(TCMFocusChanged(AObj));
end;

class function TCMFocusChanged_sw.GetTypeName: WideString;
begin
  Result := 'TCMFocusChanged';
end;

function TCMFocusChanged_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMFocusChanged_sw.Create;
  TCMFocusChanged_sw(Result).FValue := FValue;
end;

class procedure TCMFocusChanged_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMFocusChanged_Msg_si, Cardinal_sw);
  AData.AddField('Unused', TCMFocusChanged_Unused_si, Integer_sw);
  AData.AddField('Sender', TCMFocusChanged_Sender_si, TWinControl_sw);
  AData.AddField('Result', TCMFocusChanged_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMFocusChanged_Copy_si, TCMFocusChanged_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMFocusChanged_Create_si, 0, False);
end;

class function TCMFocusChanged_sw.ToVar(
  const AValue: TCMFocusChanged): OleVariant;
var
  wrpr: TCMFocusChanged_sw;
begin
  wrpr        := TCMFocusChanged_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMFocusChanged_sw.FromVar(
  const AValue: OleVariant): TCMFocusChanged;
begin
  Result := TCMFocusChanged_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMControlListChange_sw }

function TCMControlListChange_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMControlListChange_sw(AObj).FValue.Msg
  else
    TCMControlListChange_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMControlListChange_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Control: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMControlListChange_sw(AObj).FValue.Control)
  else
    TCMControlListChange_sw(AObj).FValue.Control := TControl_sw.FromVar(
      AArgs[0]);
end;

function TCMControlListChange_Inserting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Inserting: LongBool;

  if IsGet then
    Result := TCMControlListChange_sw(AObj).FValue.Inserting
  else
    TCMControlListChange_sw(AObj).FValue.Inserting := LongBool(AArgs[0]);
end;

function TCMControlListChange_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMControlListChange_sw(AObj).FValue.Result
  else
    TCMControlListChange_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMControlListChange_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMControlListChange_sw.Create as IDispatch;
end;

function TCMControlListChange_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMControlListChange;

  // Implicit record copy method.
  Result := TCMControlListChange_sw.ToVar(TCMControlListChange(AObj));
end;

class function TCMControlListChange_sw.GetTypeName: WideString;
begin
  Result := 'TCMControlListChange';
end;

function TCMControlListChange_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMControlListChange_sw.Create;
  TCMControlListChange_sw(Result).FValue := FValue;
end;

class procedure TCMControlListChange_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMControlListChange_Msg_si, Cardinal_sw);
  AData.AddField('Control', TCMControlListChange_Control_si, TControl_sw);
  AData.AddField('Inserting', TCMControlListChange_Inserting_si, LongBool_sw);
  AData.AddField('Result', TCMControlListChange_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMControlListChange_Copy_si, TCMControlListChange_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMControlListChange_Create_si, 0, False);
end;

class function TCMControlListChange_sw.ToVar(
  const AValue: TCMControlListChange): OleVariant;
var
  wrpr: TCMControlListChange_sw;
begin
  wrpr        := TCMControlListChange_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMControlListChange_sw.FromVar(
  const AValue: OleVariant): TCMControlListChange;
begin
  Result := TCMControlListChange_sw(ConvFromVar(AValue)).FValue;
end;

{ TControlListItem_sw }

function TControlListItem_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Control: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TControlListItem_sw(AObj).FValue.Control)
  else
    TControlListItem_sw(AObj).FValue.Control := TControl_sw.FromVar(AArgs[0]);
end;

function TControlListItem_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Parent: TWinControl;

  if IsGet then
    Result := TWinControl_sw.ToVar(TControlListItem_sw(AObj).FValue.Parent)
  else
    TControlListItem_sw(AObj).FValue.Parent := TWinControl_sw.FromVar(AArgs[0]);
end;

function TControlListItem_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TControlListItem_sw.Create as IDispatch;
end;

function TControlListItem_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TControlListItem;

  // Implicit record copy method.
  Result := TControlListItem_sw.ToVar(TControlListItem(AObj));
end;

class function TControlListItem_sw.GetTypeName: WideString;
begin
  Result := 'TControlListItem';
end;

function TControlListItem_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TControlListItem_sw.Create;
  TControlListItem_sw(Result).FValue := FValue;
end;

class procedure TControlListItem_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Control', TControlListItem_Control_si, TControl_sw);
  AData.AddField('Parent', TControlListItem_Parent_si, TWinControl_sw);
  AData.AddFunction('Copy', TControlListItem_Copy_si, TControlListItem_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TControlListItem_Create_si, 0, False);
end;

class function TControlListItem_sw.ToVar(
  const AValue: TControlListItem): OleVariant;
var
  wrpr: TControlListItem_sw;
begin
  wrpr        := TControlListItem_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TControlListItem_sw.FromVar(
  const AValue: OleVariant): TControlListItem;
begin
  Result := TControlListItem_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMControlListChanging_sw }

function TCMControlListChanging_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMControlListChanging_sw(AObj).FValue.Msg
  else
    TCMControlListChanging_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMControlListChanging_Inserting_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Inserting: LongBool;

  if IsGet then
    Result := TCMControlListChanging_sw(AObj).FValue.Inserting
  else
    TCMControlListChanging_sw(AObj).FValue.Inserting := LongBool(AArgs[0]);
end;

function TCMControlListChanging_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMControlListChanging_sw(AObj).FValue.Result
  else
    TCMControlListChanging_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMControlListChanging_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMControlListChanging_sw.Create as IDispatch;
end;

function TCMControlListChanging_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMControlListChanging;

  // Implicit record copy method.
  Result := TCMControlListChanging_sw.ToVar(TCMControlListChanging(AObj));
end;

class function TCMControlListChanging_sw.GetTypeName: WideString;
begin
  Result := 'TCMControlListChanging';
end;

function TCMControlListChanging_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMControlListChanging_sw.Create;
  TCMControlListChanging_sw(Result).FValue := FValue;
end;

class procedure TCMControlListChanging_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMControlListChanging_Msg_si, Cardinal_sw);
  AData.AddField('Inserting', TCMControlListChanging_Inserting_si, LongBool_sw);
  AData.AddField('Result', TCMControlListChanging_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMControlListChanging_Copy_si, TCMControlListChanging_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMControlListChanging_Create_si, 0, False);
end;

class function TCMControlListChanging_sw.ToVar(
  const AValue: TCMControlListChanging): OleVariant;
var
  wrpr: TCMControlListChanging_sw;
begin
  wrpr        := TCMControlListChanging_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMControlListChanging_sw.FromVar(
  const AValue: OleVariant): TCMControlListChanging;
begin
  Result := TCMControlListChanging_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMChildKey_sw }

function TCMChildKey_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMChildKey_sw(AObj).FValue.Msg
  else
    TCMChildKey_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMChildKey_CharCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CharCode: Word;

  if IsGet then
    Result := TCMChildKey_sw(AObj).FValue.CharCode
  else
    TCMChildKey_sw(AObj).FValue.CharCode := Word(AArgs[0]);
end;

function TCMChildKey_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Word;

  if IsGet then
    Result := TCMChildKey_sw(AObj).FValue.Unused
  else
    TCMChildKey_sw(AObj).FValue.Unused := Word(AArgs[0]);
end;

function TCMChildKey_Sender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Sender: TWinControl;

  if IsGet then
    Result := TWinControl_sw.ToVar(TCMChildKey_sw(AObj).FValue.Sender)
  else
    TCMChildKey_sw(AObj).FValue.Sender := TWinControl_sw.FromVar(AArgs[0]);
end;

function TCMChildKey_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMChildKey_sw(AObj).FValue.Result
  else
    TCMChildKey_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMChildKey_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMChildKey_sw.Create as IDispatch;
end;

function TCMChildKey_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMChildKey;

  // Implicit record copy method.
  Result := TCMChildKey_sw.ToVar(TCMChildKey(AObj));
end;

class function TCMChildKey_sw.GetTypeName: WideString;
begin
  Result := 'TCMChildKey';
end;

function TCMChildKey_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMChildKey_sw.Create;
  TCMChildKey_sw(Result).FValue := FValue;
end;

class procedure TCMChildKey_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMChildKey_Msg_si, Cardinal_sw);
  AData.AddField('CharCode', TCMChildKey_CharCode_si, Word_sw);
  AData.AddField('Unused', TCMChildKey_Unused_si, Word_sw);
  AData.AddField('Sender', TCMChildKey_Sender_si, TWinControl_sw);
  AData.AddField('Result', TCMChildKey_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMChildKey_Copy_si, TCMChildKey_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMChildKey_Create_si, 0, False);
end;

class function TCMChildKey_sw.ToVar(const AValue: TCMChildKey): OleVariant;
var
  wrpr: TCMChildKey_sw;
begin
  wrpr        := TCMChildKey_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMChildKey_sw.FromVar(const AValue: OleVariant): TCMChildKey;
begin
  Result := TCMChildKey_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMControlChange_sw }

function TCMControlChange_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMControlChange_sw(AObj).FValue.Msg
  else
    TCMControlChange_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMControlChange_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Control: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMControlChange_sw(AObj).FValue.Control)
  else
    TCMControlChange_sw(AObj).FValue.Control := TControl_sw.FromVar(AArgs[0]);
end;

function TCMControlChange_Inserting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Inserting: LongBool;

  if IsGet then
    Result := TCMControlChange_sw(AObj).FValue.Inserting
  else
    TCMControlChange_sw(AObj).FValue.Inserting := LongBool(AArgs[0]);
end;

function TCMControlChange_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMControlChange_sw(AObj).FValue.Result
  else
    TCMControlChange_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMControlChange_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMControlChange_sw.Create as IDispatch;
end;

function TCMControlChange_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMControlChange;

  // Implicit record copy method.
  Result := TCMControlChange_sw.ToVar(TCMControlChange(AObj));
end;

class function TCMControlChange_sw.GetTypeName: WideString;
begin
  Result := 'TCMControlChange';
end;

function TCMControlChange_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMControlChange_sw.Create;
  TCMControlChange_sw(Result).FValue := FValue;
end;

class procedure TCMControlChange_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMControlChange_Msg_si, Cardinal_sw);
  AData.AddField('Control', TCMControlChange_Control_si, TControl_sw);
  AData.AddField('Inserting', TCMControlChange_Inserting_si, LongBool_sw);
  AData.AddField('Result', TCMControlChange_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMControlChange_Copy_si, TCMControlChange_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMControlChange_Create_si, 0, False);
end;

class function TCMControlChange_sw.ToVar(
  const AValue: TCMControlChange): OleVariant;
var
  wrpr: TCMControlChange_sw;
begin
  wrpr        := TCMControlChange_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMControlChange_sw.FromVar(
  const AValue: OleVariant): TCMControlChange;
begin
  Result := TCMControlChange_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMChanged_sw }

function TCMChanged_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMChanged_sw(AObj).FValue.Msg
  else
    TCMChanged_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMChanged_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Longint;

  if IsGet then
    Result := TCMChanged_sw(AObj).FValue.Unused
  else
    TCMChanged_sw(AObj).FValue.Unused := Longint(AArgs[0]);
end;

function TCMChanged_Child_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Child: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMChanged_sw(AObj).FValue.Child)
  else
    TCMChanged_sw(AObj).FValue.Child := TControl_sw.FromVar(AArgs[0]);
end;

function TCMChanged_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMChanged_sw(AObj).FValue.Result
  else
    TCMChanged_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMChanged_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMChanged_sw.Create as IDispatch;
end;

function TCMChanged_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMChanged;

  // Implicit record copy method.
  Result := TCMChanged_sw.ToVar(TCMChanged(AObj));
end;

class function TCMChanged_sw.GetTypeName: WideString;
begin
  Result := 'TCMChanged';
end;

function TCMChanged_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMChanged_sw.Create;
  TCMChanged_sw(Result).FValue := FValue;
end;

class procedure TCMChanged_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMChanged_Msg_si, Cardinal_sw);
  AData.AddField('Unused', TCMChanged_Unused_si, Longint_sw);
  AData.AddField('Child', TCMChanged_Child_si, TControl_sw);
  AData.AddField('Result', TCMChanged_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMChanged_Copy_si, TCMChanged_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMChanged_Create_si, 0, False);
end;

class function TCMChanged_sw.ToVar(const AValue: TCMChanged): OleVariant;
var
  wrpr: TCMChanged_sw;
begin
  wrpr        := TCMChanged_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMChanged_sw.FromVar(const AValue: OleVariant): TCMChanged;
begin
  Result := TCMChanged_sw(ConvFromVar(AValue)).FValue;
end;

{ THintInfo_sw }

function THintInfo_HintControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintControl: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(THintInfo_sw(AObj).FValue.HintControl)
  else
    THintInfo_sw(AObj).FValue.HintControl := TControl_sw.FromVar(AArgs[0]);
end;

function THintInfo_HintWindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintWindowClass: THintWindowClass;

  if IsGet then
    Result := THintWindowClass_sw.ToVar(THintInfo_sw(AObj).FValue.
      HintWindowClass)
  else
    THintInfo_sw(AObj).FValue.HintWindowClass := THintWindowClass_sw.FromVar(
      AArgs[0]);
end;

function THintInfo_HintPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintPos: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(THintInfo_sw(AObj).FValue.HintPos)
  else
    THintInfo_sw(AObj).FValue.HintPos := TPoint_sw.FromVar(AArgs[0]);
end;

function THintInfo_HintMaxWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintMaxWidth: Integer;

  if IsGet then
    Result := THintInfo_sw(AObj).FValue.HintMaxWidth
  else
    THintInfo_sw(AObj).FValue.HintMaxWidth := Integer(AArgs[0]);
end;

function THintInfo_HintColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintColor: TColor;

  if IsGet then
    Result := TColor_sw.ToVar(THintInfo_sw(AObj).FValue.HintColor)
  else
    THintInfo_sw(AObj).FValue.HintColor := TColor_sw.FromVar(AArgs[0]);
end;

function THintInfo_CursorRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CursorRect: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(THintInfo_sw(AObj).FValue.CursorRect)
  else
    THintInfo_sw(AObj).FValue.CursorRect := TRect_sw.FromVar(AArgs[0]);
end;

function THintInfo_CursorPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CursorPos: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(THintInfo_sw(AObj).FValue.CursorPos)
  else
    THintInfo_sw(AObj).FValue.CursorPos := TPoint_sw.FromVar(AArgs[0]);
end;

function THintInfo_ReshowTimeout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ReshowTimeout: Integer;

  if IsGet then
    Result := THintInfo_sw(AObj).FValue.ReshowTimeout
  else
    THintInfo_sw(AObj).FValue.ReshowTimeout := Integer(AArgs[0]);
end;

function THintInfo_HideTimeout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HideTimeout: Integer;

  if IsGet then
    Result := THintInfo_sw(AObj).FValue.HideTimeout
  else
    THintInfo_sw(AObj).FValue.HideTimeout := Integer(AArgs[0]);
end;

function THintInfo_HintStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintStr: string;

  if IsGet then
    Result := THintInfo_sw(AObj).FValue.HintStr
  else
    THintInfo_sw(AObj).FValue.HintStr := string(AArgs[0]);
end;

function THintInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := THintInfo_sw.Create as IDispatch;
end;

function THintInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: THintInfo;

  // Implicit record copy method.
  Result := THintInfo_sw.ToVar(THintInfo(AObj));
end;

class function THintInfo_sw.GetTypeName: WideString;
begin
  Result := 'THintInfo';
end;

function THintInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := THintInfo_sw.Create;
  THintInfo_sw(Result).FValue := FValue;
end;

class procedure THintInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('HintControl', THintInfo_HintControl_si, TControl_sw);
  AData.AddField('HintWindowClass', THintInfo_HintWindowClass_si, THintWindowClass_sw);
  AData.AddField('HintPos', THintInfo_HintPos_si, TPoint_sw);
  AData.AddField('HintMaxWidth', THintInfo_HintMaxWidth_si, Integer_sw);
  AData.AddField('HintColor', THintInfo_HintColor_si, TColor_sw);
  AData.AddField('CursorRect', THintInfo_CursorRect_si, TRect_sw);
  AData.AddField('CursorPos', THintInfo_CursorPos_si, TPoint_sw);
  AData.AddField('ReshowTimeout', THintInfo_ReshowTimeout_si, Integer_sw);
  AData.AddField('HideTimeout', THintInfo_HideTimeout_si, Integer_sw);
  AData.AddField('HintStr', THintInfo_HintStr_si, string_sw);
  AData.AddFunction('Copy', THintInfo_Copy_si, THintInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', THintInfo_Create_si, 0, False);
end;

class function THintInfo_sw.ToVar(const AValue: THintInfo): OleVariant;
var
  wrpr: THintInfo_sw;
begin
  wrpr        := THintInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function THintInfo_sw.FromVar(const AValue: OleVariant): THintInfo;
begin
  Result := THintInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMHintShow_sw }

function TCMHintShow_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMHintShow_sw(AObj).FValue.Msg
  else
    TCMHintShow_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMHintShow_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: Integer;

  if IsGet then
    Result := TCMHintShow_sw(AObj).FValue.Reserved
  else
    TCMHintShow_sw(AObj).FValue.Reserved := Integer(AArgs[0]);
end;

function TCMHintShow_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMHintShow_sw(AObj).FValue.Result
  else
    TCMHintShow_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMHintShow_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMHintShow_sw.Create as IDispatch;
end;

function TCMHintShow_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMHintShow;

  // Implicit record copy method.
  Result := TCMHintShow_sw.ToVar(TCMHintShow(AObj));
end;

class function TCMHintShow_sw.GetTypeName: WideString;
begin
  Result := 'TCMHintShow';
end;

function TCMHintShow_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMHintShow_sw.Create;
  TCMHintShow_sw(Result).FValue := FValue;
end;

class procedure TCMHintShow_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMHintShow_Msg_si, Cardinal_sw);
  AData.AddField('Reserved', TCMHintShow_Reserved_si, Integer_sw);
  AData.AddField('Result', TCMHintShow_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMHintShow_Copy_si, TCMHintShow_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMHintShow_Create_si, 0, False);
end;

class function TCMHintShow_sw.ToVar(const AValue: TCMHintShow): OleVariant;
var
  wrpr: TCMHintShow_sw;
begin
  wrpr        := TCMHintShow_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMHintShow_sw.FromVar(const AValue: OleVariant): TCMHintShow;
begin
  Result := TCMHintShow_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMParentFontChanged_sw }

function TCMParentFontChanged_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMParentFontChanged_sw(AObj).FValue.Msg
  else
    TCMParentFontChanged_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMParentFontChanged_WParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(TCMParentFontChanged_sw(AObj).FValue.WParam)
  else
    TCMParentFontChanged_sw(AObj).FValue.WParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function TCMParentFontChanged_LParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(TCMParentFontChanged_sw(AObj).FValue.LParam)
  else
    TCMParentFontChanged_sw(AObj).FValue.LParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function TCMParentFontChanged_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Font: TFont;

  if IsGet then
    Result := TFont_sw.ToVar(TCMParentFontChanged_sw(AObj).FValue.Font)
  else
    TCMParentFontChanged_sw(AObj).FValue.Font := TFont_sw.FromVar(AArgs[0]);
end;

function TCMParentFontChanged_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TCMParentFontChanged_sw(AObj).FValue.Result)
  else
    TCMParentFontChanged_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TCMParentFontChanged_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMParentFontChanged_sw.Create as IDispatch;
end;

function TCMParentFontChanged_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMParentFontChanged;

  // Implicit record copy method.
  Result := TCMParentFontChanged_sw.ToVar(TCMParentFontChanged(AObj));
end;

class function TCMParentFontChanged_sw.GetTypeName: WideString;
begin
  Result := 'TCMParentFontChanged';
end;

function TCMParentFontChanged_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMParentFontChanged_sw.Create;
  TCMParentFontChanged_sw(Result).FValue := FValue;
end;

class procedure TCMParentFontChanged_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMParentFontChanged_Msg_si, Cardinal_sw);
  AData.AddField('WParam', TCMParentFontChanged_WParam_si, WPARAM_sw);
  AData.AddField('LParam', TCMParentFontChanged_LParam_si, LPARAM_sw);
  AData.AddField('Font', TCMParentFontChanged_Font_si, TFont_sw);
  AData.AddField('Result', TCMParentFontChanged_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TCMParentFontChanged_Copy_si, TCMParentFontChanged_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMParentFontChanged_Create_si, 0, False);
end;

class function TCMParentFontChanged_sw.ToVar(
  const AValue: TCMParentFontChanged): OleVariant;
var
  wrpr: TCMParentFontChanged_sw;
begin
  wrpr        := TCMParentFontChanged_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMParentFontChanged_sw.FromVar(
  const AValue: OleVariant): TCMParentFontChanged;
begin
  Result := TCMParentFontChanged_sw(ConvFromVar(AValue)).FValue;
end;

{ TDragMessage_sw }

class function TDragMessage_sw.GetTypeName: WideString;
begin
  Result := 'TDragMessage';
end;

class procedure TDragMessage_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'dmDragEnter'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmDragEnter)),
    (Name: 'dmDragLeave'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmDragLeave)),
    (Name: 'dmDragMove'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmDragMove)),
    (Name: 'dmDragDrop'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmDragDrop)),
    (Name: 'dmDragCancel'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmDragCancel)),
    (Name: 'dmFindTarget'; Value: Integer({$IFDEF LMDSCT_12}TDragMessage.{$ENDIF}dmFindTarget))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TDragMessage_sw.ToVar(const AValue: TDragMessage): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDragMessage_sw.FromVar(const AValue: OleVariant): TDragMessage;
begin
  Result := TDragMessage(Integer(AValue));
end;

{ TDragRec_sw }

function TDragRec_Pos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Pos: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(TDragRec_sw(AObj).FValue.Pos)
  else
    TDragRec_sw(AObj).FValue.Pos := TPoint_sw.FromVar(AArgs[0]);
end;

function TDragRec_Source_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Source: TDragObject;

  if IsGet then
    Result := TDragObject_sw.ToVar(TDragRec_sw(AObj).FValue.Source)
  else
    TDragRec_sw(AObj).FValue.Source := TDragObject_sw.FromVar(AArgs[0]);
end;

function TDragRec_Docking_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Docking: Boolean;

  if IsGet then
    Result := TDragRec_sw(AObj).FValue.Docking
  else
    TDragRec_sw(AObj).FValue.Docking := Boolean(AArgs[0]);
end;

function TDragRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDragRec_sw.Create as IDispatch;
end;

function TDragRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDragRec;

  // Implicit record copy method.
  Result := TDragRec_sw.ToVar(TDragRec(AObj));
end;

class function TDragRec_sw.GetTypeName: WideString;
begin
  Result := 'TDragRec';
end;

function TDragRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDragRec_sw.Create;
  TDragRec_sw(Result).FValue := FValue;
end;

class procedure TDragRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Pos', TDragRec_Pos_si, TPoint_sw);
  AData.AddField('Source', TDragRec_Source_si, TDragObject_sw);
  AData.AddField('Docking', TDragRec_Docking_si, Boolean_sw);
  AData.AddFunction('Copy', TDragRec_Copy_si, TDragRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDragRec_Create_si, 0, False);
end;

class function TDragRec_sw.ToVar(const AValue: TDragRec): OleVariant;
var
  wrpr: TDragRec_sw;
begin
  wrpr        := TDragRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDragRec_sw.FromVar(const AValue: OleVariant): TDragRec;
begin
  Result := TDragRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMDrag_sw }

function TCMDrag_Msg_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMDrag_sw(AObj).FValue.Msg
  else
    TCMDrag_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMDrag_DragMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DragMessage: TDragMessage;

  if IsGet then
    Result := TDragMessage_sw.ToVar(TCMDrag_sw(AObj).FValue.DragMessage)
  else
    TCMDrag_sw(AObj).FValue.DragMessage := TDragMessage_sw.FromVar(AArgs[0]);
end;

function TCMDrag_Reserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved1: Byte;

  if IsGet then
    Result := TCMDrag_sw(AObj).FValue.Reserved1
  else
    TCMDrag_sw(AObj).FValue.Reserved1 := Byte(AArgs[0]);
end;

function TCMDrag_Reserved2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved2: Word;

  if IsGet then
    Result := TCMDrag_sw(AObj).FValue.Reserved2
  else
    TCMDrag_sw(AObj).FValue.Reserved2 := Word(AArgs[0]);
end;

function TCMDrag_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMDrag_sw(AObj).FValue.Result
  else
    TCMDrag_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMDrag_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMDrag_sw.Create as IDispatch;
end;

function TCMDrag_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMDrag;

  // Implicit record copy method.
  Result := TCMDrag_sw.ToVar(TCMDrag(AObj));
end;

class function TCMDrag_sw.GetTypeName: WideString;
begin
  Result := 'TCMDrag';
end;

function TCMDrag_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMDrag_sw.Create;
  TCMDrag_sw(Result).FValue := FValue;
end;

class procedure TCMDrag_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMDrag_Msg_si, Cardinal_sw);
  AData.AddField('DragMessage', TCMDrag_DragMessage_si, TDragMessage_sw);
  AData.AddField('Reserved1', TCMDrag_Reserved1_si, Byte_sw);
  AData.AddField('Reserved2', TCMDrag_Reserved2_si, Word_sw);
  AData.AddField('Result', TCMDrag_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMDrag_Copy_si, TCMDrag_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMDrag_Create_si, 0, False);
end;

class function TCMDrag_sw.ToVar(const AValue: TCMDrag): OleVariant;
var
  wrpr: TCMDrag_sw;
begin
  wrpr        := TCMDrag_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMDrag_sw.FromVar(const AValue: OleVariant): TCMDrag;
begin
  Result := TCMDrag_sw(ConvFromVar(AValue)).FValue;
end;

{ TDockNotifyRec_sw }

function TDockNotifyRec_ClientMsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ClientMsg: Cardinal;

  if IsGet then
    Result := TDockNotifyRec_sw(AObj).FValue.ClientMsg
  else
    TDockNotifyRec_sw(AObj).FValue.ClientMsg := Cardinal(AArgs[0]);
end;

function TDockNotifyRec_MsgWParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgWParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(TDockNotifyRec_sw(AObj).FValue.MsgWParam)
  else
    TDockNotifyRec_sw(AObj).FValue.MsgWParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function TDockNotifyRec_MsgLParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgLParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(TDockNotifyRec_sw(AObj).FValue.MsgLParam)
  else
    TDockNotifyRec_sw(AObj).FValue.MsgLParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function TDockNotifyRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDockNotifyRec_sw.Create as IDispatch;
end;

function TDockNotifyRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDockNotifyRec;

  // Implicit record copy method.
  Result := TDockNotifyRec_sw.ToVar(TDockNotifyRec(AObj));
end;

class function TDockNotifyRec_sw.GetTypeName: WideString;
begin
  Result := 'TDockNotifyRec';
end;

function TDockNotifyRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDockNotifyRec_sw.Create;
  TDockNotifyRec_sw(Result).FValue := FValue;
end;

class procedure TDockNotifyRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ClientMsg', TDockNotifyRec_ClientMsg_si, Cardinal_sw);
  AData.AddField('MsgWParam', TDockNotifyRec_MsgWParam_si, WPARAM_sw);
  AData.AddField('MsgLParam', TDockNotifyRec_MsgLParam_si, LPARAM_sw);
  AData.AddFunction('Copy', TDockNotifyRec_Copy_si, TDockNotifyRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDockNotifyRec_Create_si, 0, False);
end;

class function TDockNotifyRec_sw.ToVar(
  const AValue: TDockNotifyRec): OleVariant;
var
  wrpr: TDockNotifyRec_sw;
begin
  wrpr        := TDockNotifyRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDockNotifyRec_sw.FromVar(
  const AValue: OleVariant): TDockNotifyRec;
begin
  Result := TDockNotifyRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMDockClient_sw }

function TCMDockClient_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMDockClient_sw(AObj).FValue.Msg
  else
    TCMDockClient_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMDockClient_DockSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DockSource: TDragDockObject;

  if IsGet then
    Result := TDragDockObject_sw.ToVar(TCMDockClient_sw(AObj).FValue.DockSource)
  else
    TCMDockClient_sw(AObj).FValue.DockSource := TDragDockObject_sw.FromVar(
      AArgs[0]);
end;

function TCMDockClient_MousePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MousePos: TSmallPoint;

  if IsGet then
    Result := TSmallPoint_sw.ToVar(TCMDockClient_sw(AObj).FValue.MousePos)
  else
    TCMDockClient_sw(AObj).FValue.MousePos := TSmallPoint_sw.FromVar(AArgs[0]);
end;

function TCMDockClient_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMDockClient_sw(AObj).FValue.Result
  else
    TCMDockClient_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMDockClient_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMDockClient_sw.Create as IDispatch;
end;

function TCMDockClient_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMDockClient;

  // Implicit record copy method.
  Result := TCMDockClient_sw.ToVar(TCMDockClient(AObj));
end;

class function TCMDockClient_sw.GetTypeName: WideString;
begin
  Result := 'TCMDockClient';
end;

function TCMDockClient_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMDockClient_sw.Create;
  TCMDockClient_sw(Result).FValue := FValue;
end;

class procedure TCMDockClient_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMDockClient_Msg_si, Cardinal_sw);
  AData.AddField('DockSource', TCMDockClient_DockSource_si, TDragDockObject_sw);
  AData.AddField('MousePos', TCMDockClient_MousePos_si, TSmallPoint_sw);
  AData.AddField('Result', TCMDockClient_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMDockClient_Copy_si, TCMDockClient_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMDockClient_Create_si, 0, False);
end;

class function TCMDockClient_sw.ToVar(const AValue: TCMDockClient): OleVariant;
var
  wrpr: TCMDockClient_sw;
begin
  wrpr        := TCMDockClient_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMDockClient_sw.FromVar(
  const AValue: OleVariant): TCMDockClient;
begin
  Result := TCMDockClient_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMUnDockClient_sw }

function TCMUnDockClient_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMUnDockClient_sw(AObj).FValue.Msg
  else
    TCMUnDockClient_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMUnDockClient_NewTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NewTarget: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMUnDockClient_sw(AObj).FValue.NewTarget)
  else
    TCMUnDockClient_sw(AObj).FValue.NewTarget := TControl_sw.FromVar(AArgs[0]);
end;

function TCMUnDockClient_Client_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Client: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMUnDockClient_sw(AObj).FValue.Client)
  else
    TCMUnDockClient_sw(AObj).FValue.Client := TControl_sw.FromVar(AArgs[0]);
end;

function TCMUnDockClient_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMUnDockClient_sw(AObj).FValue.Result
  else
    TCMUnDockClient_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMUnDockClient_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMUnDockClient_sw.Create as IDispatch;
end;

function TCMUnDockClient_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMUnDockClient;

  // Implicit record copy method.
  Result := TCMUnDockClient_sw.ToVar(TCMUnDockClient(AObj));
end;

class function TCMUnDockClient_sw.GetTypeName: WideString;
begin
  Result := 'TCMUnDockClient';
end;

function TCMUnDockClient_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMUnDockClient_sw.Create;
  TCMUnDockClient_sw(Result).FValue := FValue;
end;

class procedure TCMUnDockClient_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMUnDockClient_Msg_si, Cardinal_sw);
  AData.AddField('NewTarget', TCMUnDockClient_NewTarget_si, TControl_sw);
  AData.AddField('Client', TCMUnDockClient_Client_si, TControl_sw);
  AData.AddField('Result', TCMUnDockClient_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMUnDockClient_Copy_si, TCMUnDockClient_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMUnDockClient_Create_si, 0, False);
end;

class function TCMUnDockClient_sw.ToVar(
  const AValue: TCMUnDockClient): OleVariant;
var
  wrpr: TCMUnDockClient_sw;
begin
  wrpr        := TCMUnDockClient_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMUnDockClient_sw.FromVar(
  const AValue: OleVariant): TCMUnDockClient;
begin
  Result := TCMUnDockClient_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMFloat_sw }

function TCMFloat_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMFloat_sw(AObj).FValue.Msg
  else
    TCMFloat_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMFloat_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: Integer;

  if IsGet then
    Result := TCMFloat_sw(AObj).FValue.Reserved
  else
    TCMFloat_sw(AObj).FValue.Reserved := Integer(AArgs[0]);
end;

function TCMFloat_DockSource_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DockSource: TDragDockObject;

  if IsGet then
    Result := TDragDockObject_sw.ToVar(TCMFloat_sw(AObj).FValue.DockSource)
  else
    TCMFloat_sw(AObj).FValue.DockSource := TDragDockObject_sw.FromVar(AArgs[0]);
end;

function TCMFloat_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMFloat_sw(AObj).FValue.Result
  else
    TCMFloat_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMFloat_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMFloat_sw.Create as IDispatch;
end;

function TCMFloat_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMFloat;

  // Implicit record copy method.
  Result := TCMFloat_sw.ToVar(TCMFloat(AObj));
end;

class function TCMFloat_sw.GetTypeName: WideString;
begin
  Result := 'TCMFloat';
end;

function TCMFloat_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMFloat_sw.Create;
  TCMFloat_sw(Result).FValue := FValue;
end;

class procedure TCMFloat_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMFloat_Msg_si, Cardinal_sw);
  AData.AddField('Reserved', TCMFloat_Reserved_si, Integer_sw);
  AData.AddField('DockSource', TCMFloat_DockSource_si, TDragDockObject_sw);
  AData.AddField('Result', TCMFloat_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMFloat_Copy_si, TCMFloat_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMFloat_Create_si, 0, False);
end;

class function TCMFloat_sw.ToVar(const AValue: TCMFloat): OleVariant;
var
  wrpr: TCMFloat_sw;
begin
  wrpr        := TCMFloat_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMFloat_sw.FromVar(const AValue: OleVariant): TCMFloat;
begin
  Result := TCMFloat_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMDockNotification_sw }

function TCMDockNotification_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMDockNotification_sw(AObj).FValue.Msg
  else
    TCMDockNotification_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMDockNotification_Client_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Client: TControl;

  if IsGet then
    Result := TControl_sw.ToVar(TCMDockNotification_sw(AObj).FValue.Client)
  else
    TCMDockNotification_sw(AObj).FValue.Client := TControl_sw.FromVar(AArgs[0]);
end;

function TCMDockNotification_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMDockNotification_sw(AObj).FValue.Result
  else
    TCMDockNotification_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMDockNotification_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMDockNotification_sw.Create as IDispatch;
end;

function TCMDockNotification_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMDockNotification;

  // Implicit record copy method.
  Result := TCMDockNotification_sw.ToVar(TCMDockNotification(AObj));
end;

class function TCMDockNotification_sw.GetTypeName: WideString;
begin
  Result := 'TCMDockNotification';
end;

function TCMDockNotification_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMDockNotification_sw.Create;
  TCMDockNotification_sw(Result).FValue := FValue;
end;

class procedure TCMDockNotification_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMDockNotification_Msg_si, Cardinal_sw);
  AData.AddField('Client', TCMDockNotification_Client_si, TControl_sw);
  AData.AddField('Result', TCMDockNotification_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMDockNotification_Copy_si, TCMDockNotification_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMDockNotification_Create_si, 0, False);
end;

class function TCMDockNotification_sw.ToVar(
  const AValue: TCMDockNotification): OleVariant;
var
  wrpr: TCMDockNotification_sw;
begin
  wrpr        := TCMDockNotification_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMDockNotification_sw.FromVar(
  const AValue: OleVariant): TCMDockNotification;
begin
  Result := TCMDockNotification_sw(ConvFromVar(AValue)).FValue;
end;

{ TPopupFormInfo_sw }

function TPopupFormInfo_PopupID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PopupID: Integer;

  if IsGet then
    Result := TPopupFormInfo_sw(AObj).FValue.PopupID
  else
    TPopupFormInfo_sw(AObj).FValue.PopupID := Integer(AArgs[0]);
end;

function TPopupFormInfo_PopupWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PopupWnd: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(TPopupFormInfo_sw(AObj).FValue.PopupWnd)
  else
    TPopupFormInfo_sw(AObj).FValue.PopupWnd := HWND_sw.FromVar(AArgs[0]);
end;

function TPopupFormInfo_IsPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IsPopup: Boolean;

  if IsGet then
    Result := TPopupFormInfo_sw(AObj).FValue.IsPopup
  else
    TPopupFormInfo_sw(AObj).FValue.IsPopup := Boolean(AArgs[0]);
end;

function TPopupFormInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPopupFormInfo_sw.Create as IDispatch;
end;

function TPopupFormInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPopupFormInfo;

  // Implicit record copy method.
  Result := TPopupFormInfo_sw.ToVar(TPopupFormInfo(AObj));
end;

class function TPopupFormInfo_sw.GetTypeName: WideString;
begin
  Result := 'TPopupFormInfo';
end;

function TPopupFormInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPopupFormInfo_sw.Create;
  TPopupFormInfo_sw(Result).FValue := FValue;
end;

class procedure TPopupFormInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('PopupID', TPopupFormInfo_PopupID_si, Integer_sw);
  AData.AddField('PopupWnd', TPopupFormInfo_PopupWnd_si, HWND_sw);
  AData.AddField('IsPopup', TPopupFormInfo_IsPopup_si, Boolean_sw);
  AData.AddFunction('Copy', TPopupFormInfo_Copy_si, TPopupFormInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPopupFormInfo_Create_si, 0, False);
end;

class function TPopupFormInfo_sw.ToVar(
  const AValue: TPopupFormInfo): OleVariant;
var
  wrpr: TPopupFormInfo_sw;
begin
  wrpr        := TPopupFormInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPopupFormInfo_sw.FromVar(
  const AValue: OleVariant): TPopupFormInfo;
begin
  Result := TPopupFormInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMPopupHWndDestroy_sw }

function TCMPopupHWndDestroy_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMPopupHWndDestroy_sw(AObj).FValue.Msg
  else
    TCMPopupHWndDestroy_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMPopupHWndDestroy_PopupControlWnd_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PopupControlWnd: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(TCMPopupHWndDestroy_sw(AObj).FValue.PopupControlWnd)
  else
    TCMPopupHWndDestroy_sw(AObj).FValue.PopupControlWnd := HWND_sw.FromVar(
      AArgs[0]);
end;

function TCMPopupHWndDestroy_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMPopupHWndDestroy_sw(AObj).FValue.Result
  else
    TCMPopupHWndDestroy_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMPopupHWndDestroy_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMPopupHWndDestroy_sw.Create as IDispatch;
end;

function TCMPopupHWndDestroy_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMPopupHWndDestroy;

  // Implicit record copy method.
  Result := TCMPopupHWndDestroy_sw.ToVar(TCMPopupHWndDestroy(AObj));
end;

class function TCMPopupHWndDestroy_sw.GetTypeName: WideString;
begin
  Result := 'TCMPopupHWndDestroy';
end;

function TCMPopupHWndDestroy_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMPopupHWndDestroy_sw.Create;
  TCMPopupHWndDestroy_sw(Result).FValue := FValue;
end;

class procedure TCMPopupHWndDestroy_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMPopupHWndDestroy_Msg_si, Cardinal_sw);
  AData.AddField('PopupControlWnd', TCMPopupHWndDestroy_PopupControlWnd_si, HWND_sw);
  AData.AddField('Result', TCMPopupHWndDestroy_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMPopupHWndDestroy_Copy_si, TCMPopupHWndDestroy_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMPopupHWndDestroy_Create_si, 0, False);
end;

class function TCMPopupHWndDestroy_sw.ToVar(
  const AValue: TCMPopupHWndDestroy): OleVariant;
var
  wrpr: TCMPopupHWndDestroy_sw;
begin
  wrpr        := TCMPopupHWndDestroy_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMPopupHWndDestroy_sw.FromVar(
  const AValue: OleVariant): TCMPopupHWndDestroy;
begin
  Result := TCMPopupHWndDestroy_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMCreatePopup_sw }

function TCMCreatePopup_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMCreatePopup_sw(AObj).FValue.Msg
  else
    TCMCreatePopup_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMCreatePopup_PopupID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PopupID: Integer;

  if IsGet then
    Result := TCMCreatePopup_sw(AObj).FValue.PopupID
  else
    TCMCreatePopup_sw(AObj).FValue.PopupID := Integer(AArgs[0]);
end;

function TCMCreatePopup_OwnerWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OwnerWnd: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(TCMCreatePopup_sw(AObj).FValue.OwnerWnd)
  else
    TCMCreatePopup_sw(AObj).FValue.OwnerWnd := HWND_sw.FromVar(AArgs[0]);
end;

function TCMCreatePopup_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMCreatePopup_sw(AObj).FValue.Result
  else
    TCMCreatePopup_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMCreatePopup_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMCreatePopup_sw.Create as IDispatch;
end;

function TCMCreatePopup_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMCreatePopup;

  // Implicit record copy method.
  Result := TCMCreatePopup_sw.ToVar(TCMCreatePopup(AObj));
end;

class function TCMCreatePopup_sw.GetTypeName: WideString;
begin
  Result := 'TCMCreatePopup';
end;

function TCMCreatePopup_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMCreatePopup_sw.Create;
  TCMCreatePopup_sw(Result).FValue := FValue;
end;

class procedure TCMCreatePopup_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMCreatePopup_Msg_si, Cardinal_sw);
  AData.AddField('PopupID', TCMCreatePopup_PopupID_si, Integer_sw);
  AData.AddField('OwnerWnd', TCMCreatePopup_OwnerWnd_si, HWND_sw);
  AData.AddField('Result', TCMCreatePopup_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMCreatePopup_Copy_si, TCMCreatePopup_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMCreatePopup_Create_si, 0, False);
end;

class function TCMCreatePopup_sw.ToVar(
  const AValue: TCMCreatePopup): OleVariant;
var
  wrpr: TCMCreatePopup_sw;
begin
  wrpr        := TCMCreatePopup_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMCreatePopup_sw.FromVar(
  const AValue: OleVariant): TCMCreatePopup;
begin
  Result := TCMCreatePopup_sw(ConvFromVar(AValue)).FValue;
end;

{ TAlign_sw }

class function TAlign_sw.GetTypeName: WideString;
begin
  Result := 'TAlign';
end;

class procedure TAlign_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'alNone'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alNone)),
    (Name: 'alTop'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alTop)),
    (Name: 'alBottom'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alBottom)),
    (Name: 'alLeft'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alLeft)),
    (Name: 'alRight'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alRight)),
    (Name: 'alClient'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alClient)),
    (Name: 'alCustom'; Value: Integer({$IFDEF LMDSCT_12}TAlign.{$ENDIF}alCustom))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TAlign_sw.ToVar(const AValue: TAlign): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAlign_sw.FromVar(const AValue: OleVariant): TAlign;
begin
  Result := TAlign(Integer(AValue));
end;

{ TAlignSet_sw }

class function TAlignSet_sw.GetTypeName: WideString;
begin
  Result := 'TAlignSet';
end;

class function TAlignSet_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TAlignSet);
end;

class function TAlignSet_sw.ToVar(const AValue: TAlignSet): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TAlignSet_sw.FromVar(const AValue: OleVariant): TAlignSet;
begin
  ConvFromVar(AValue, @Result);
end;

{ TDragObject_sw }

function TDragObject_Assign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Assign(Source: TDragObject);

  TDragObject(AObj).Assign(TDragObject_sw.FromVar(AArgs[0]));
end;

function TDragObject_GetName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetName: string;

  Result := TDragObject(AObj).GetName();
end;

function TDragObject_HideDragImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HideDragImage;

  TDragObject(AObj).HideDragImage();
end;

function TDragObject_Instance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Instance: THandle;

  Result := THandle_sw.ToVar(TDragObject(AObj).Instance());
end;

function TDragObject_ShowDragImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowDragImage;

  TDragObject(AObj).ShowDragImage();
end;

function TDragObject_AlwaysShowDragImages_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AlwaysShowDragImages: Boolean read <getter> writ...

  if IsGet then
    Result := TDragObject(AObj).AlwaysShowDragImages
  else
    TDragObject(AObj).AlwaysShowDragImages := Boolean(AArgs[0]);
end;

function TDragObject_Cancelling_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cancelling: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDragObject(AObj).Cancelling
  else
    TDragObject(AObj).Cancelling := Boolean(AArgs[0]);
end;

function TDragObject_DragHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragHandle: HWND read <getter> write <setter>;

  if IsGet then
    Result := HWND_sw.ToVar(TDragObject(AObj).DragHandle)
  else
    TDragObject(AObj).DragHandle := HWND_sw.FromVar(AArgs[0]);
end;

function TDragObject_DragPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TDragObject(AObj).DragPos)
  else
    TDragObject(AObj).DragPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TDragObject_DragTargetPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragTargetPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TDragObject(AObj).DragTargetPos)
  else
    TDragObject(AObj).DragTargetPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TDragObject_Dropped_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dropped: Boolean read <getter>;

  Result := TDragObject(AObj).Dropped;
end;

function TDragObject_MouseDeltaX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MouseDeltaX: Double read <getter>;

  Result := TDragObject(AObj).MouseDeltaX;
end;

function TDragObject_MouseDeltaY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MouseDeltaY: Double read <getter>;

  Result := TDragObject(AObj).MouseDeltaY;
end;

function TDragObject_RightClickCancels_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RightClickCancels: Boolean read <getter> write <...

  if IsGet then
    Result := TDragObject(AObj).RightClickCancels
  else
    TDragObject(AObj).RightClickCancels := Boolean(AArgs[0]);
end;

class function TDragObject_sw.GetTypeName: WideString;
begin
  Result := 'TDragObject';
end;

class function TDragObject_sw.GetWrappedClass: TClass;
begin
  Result := TDragObject;
end;

class procedure TDragObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Assign', TDragObject_Assign_si, 1, False);
  AData.AddFunction('GetName', TDragObject_GetName_si, string_sw, 0, False);
  AData.AddProcedure('HideDragImage', TDragObject_HideDragImage_si, 0, False);
  AData.AddFunction('Instance', TDragObject_Instance_si, THandle_sw, 0, False);
  AData.AddProcedure('ShowDragImage', TDragObject_ShowDragImage_si, 0, False);
  AData.AddProperty('AlwaysShowDragImages', TDragObject_AlwaysShowDragImages_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Cancelling', TDragObject_Cancelling_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DragHandle', TDragObject_DragHandle_si, HWND_sw, True, True, 0, False, False);
  AData.AddProperty('DragPos', TDragObject_DragPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('DragTargetPos', TDragObject_DragTargetPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Dropped', TDragObject_Dropped_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('MouseDeltaX', TDragObject_MouseDeltaX_si, Double_sw, True, False, 0, False, False);
  AData.AddProperty('MouseDeltaY', TDragObject_MouseDeltaY_si, Double_sw, True, False, 0, False, False);
  AData.AddProperty('RightClickCancels', TDragObject_RightClickCancels_si, Boolean_sw, True, True, 0, False, False);
end;

class function TDragObject_sw.ToVar(const AValue: TDragObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragObject_sw.FromVar(const AValue: OleVariant): TDragObject;
begin
  Result := TDragObject(ConvFromVar(AValue, TDragObject));
end;

class function TDragObject_sw.ClassToVar(AClass: TDragObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragObject_sw.ClassFromVar(
  const AClass: OleVariant): TDragObject_sc;
begin
  Result := TDragObject_sc(ConvClsFromVar(AClass, TDragObject));
end;

{ TDragObjectClass_sw }

class function TDragObjectClass_sw.GetTypeName: WideString;
begin
  Result := 'TDragObjectClass';
end;

class function TDragObjectClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TDragObject;
end;

class function TDragObjectClass_sw.ToVar(
  const AValue: TDragObjectClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragObjectClass_sw.FromVar(
  const AValue: OleVariant): TDragObjectClass;
begin
  Result := TDragObjectClass(ConvFromVar(AValue, TDragObject));
end;

{ TDragObjectEx_sw }

class function TDragObjectEx_sw.GetTypeName: WideString;
begin
  Result := 'TDragObjectEx';
end;

class function TDragObjectEx_sw.GetWrappedClass: TClass;
begin
  Result := TDragObjectEx;
end;

class procedure TDragObjectEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDragObjectEx_sw.ToVar(const AValue: TDragObjectEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragObjectEx_sw.FromVar(
  const AValue: OleVariant): TDragObjectEx;
begin
  Result := TDragObjectEx(ConvFromVar(AValue, TDragObjectEx));
end;

class function TDragObjectEx_sw.ClassToVar(
  AClass: TDragObjectEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragObjectEx_sw.ClassFromVar(
  const AClass: OleVariant): TDragObjectEx_sc;
begin
  Result := TDragObjectEx_sc(ConvClsFromVar(AClass, TDragObjectEx));
end;

{ TBaseDragControlObject_sw }

function TBaseDragControlObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AControl: TControl);

  Result := TBaseDragControlObject_sw.ToVar(TBaseDragControlObject_sc(AObj).
    Create(TControl_sw.FromVar(AArgs[0])));
end;

function TBaseDragControlObject_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TControl read <getter> write <setter>;

  if IsGet then
    Result := TControl_sw.ToVar(TBaseDragControlObject(AObj).Control)
  else
    TBaseDragControlObject(AObj).Control := TControl_sw.FromVar(AArgs[0]);
end;

class function TBaseDragControlObject_sw.GetTypeName: WideString;
begin
  Result := 'TBaseDragControlObject';
end;

class function TBaseDragControlObject_sw.GetWrappedClass: TClass;
begin
  Result := TBaseDragControlObject;
end;

class procedure TBaseDragControlObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Control', TBaseDragControlObject_Control_si, TControl_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TBaseDragControlObject_Create_si, 1, False);
end;

class function TBaseDragControlObject_sw.ToVar(
  const AValue: TBaseDragControlObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBaseDragControlObject_sw.FromVar(
  const AValue: OleVariant): TBaseDragControlObject;
begin
  Result := TBaseDragControlObject(ConvFromVar(AValue, TBaseDragControlObject));
end;

class function TBaseDragControlObject_sw.ClassToVar(
  AClass: TBaseDragControlObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBaseDragControlObject_sw.ClassFromVar(
  const AClass: OleVariant): TBaseDragControlObject_sc;
begin
  Result := TBaseDragControlObject_sc(ConvClsFromVar(AClass, 
    TBaseDragControlObject));
end;

{ TDragControlObject_sw }

class function TDragControlObject_sw.GetTypeName: WideString;
begin
  Result := 'TDragControlObject';
end;

class function TDragControlObject_sw.GetWrappedClass: TClass;
begin
  Result := TDragControlObject;
end;

class procedure TDragControlObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDragControlObject_sw.ToVar(
  const AValue: TDragControlObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragControlObject_sw.FromVar(
  const AValue: OleVariant): TDragControlObject;
begin
  Result := TDragControlObject(ConvFromVar(AValue, TDragControlObject));
end;

class function TDragControlObject_sw.ClassToVar(
  AClass: TDragControlObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragControlObject_sw.ClassFromVar(
  const AClass: OleVariant): TDragControlObject_sc;
begin
  Result := TDragControlObject_sc(ConvClsFromVar(AClass, TDragControlObject));
end;

{ TDragControlObjectEx_sw }

class function TDragControlObjectEx_sw.GetTypeName: WideString;
begin
  Result := 'TDragControlObjectEx';
end;

class function TDragControlObjectEx_sw.GetWrappedClass: TClass;
begin
  Result := TDragControlObjectEx;
end;

class procedure TDragControlObjectEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDragControlObjectEx_sw.ToVar(
  const AValue: TDragControlObjectEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragControlObjectEx_sw.FromVar(
  const AValue: OleVariant): TDragControlObjectEx;
begin
  Result := TDragControlObjectEx(ConvFromVar(AValue, TDragControlObjectEx));
end;

class function TDragControlObjectEx_sw.ClassToVar(
  AClass: TDragControlObjectEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragControlObjectEx_sw.ClassFromVar(
  const AClass: OleVariant): TDragControlObjectEx_sc;
begin
  Result := TDragControlObjectEx_sc(ConvClsFromVar(AClass, 
    TDragControlObjectEx));
end;

{ TDragDockObject_sw }

function TDragDockObject_Brush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Brush: TBrush read <getter> write <setter>;

  if IsGet then
    Result := TBrush_sw.ToVar(TDragDockObject(AObj).Brush)
  else
    TDragDockObject(AObj).Brush := TBrush_sw.FromVar(AArgs[0]);
end;

function TDragDockObject_DockRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DockRect: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TDragDockObject(AObj).DockRect)
  else
    TDragDockObject(AObj).DockRect := TRect_sw.FromVar(AArgs[0]);
end;

function TDragDockObject_DropAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropAlign: TAlign read <getter>;

  Result := TAlign_sw.ToVar(TDragDockObject(AObj).DropAlign);
end;

function TDragDockObject_DropOnControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropOnControl: TControl read <getter>;

  Result := TControl_sw.ToVar(TDragDockObject(AObj).DropOnControl);
end;

function TDragDockObject_EraseDockRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EraseDockRect: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TDragDockObject(AObj).EraseDockRect)
  else
    TDragDockObject(AObj).EraseDockRect := TRect_sw.FromVar(AArgs[0]);
end;

function TDragDockObject_EraseWhenMoving_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EraseWhenMoving: Boolean read <getter>;

  Result := TDragDockObject(AObj).EraseWhenMoving;
end;

function TDragDockObject_Floating_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Floating: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TDragDockObject(AObj).Floating
  else
    TDragDockObject(AObj).Floating := Boolean(AArgs[0]);
end;

function TDragDockObject_FrameWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FrameWidth: Integer read <getter>;

  Result := TDragDockObject(AObj).FrameWidth;
end;

class function TDragDockObject_sw.GetTypeName: WideString;
begin
  Result := 'TDragDockObject';
end;

class function TDragDockObject_sw.GetWrappedClass: TClass;
begin
  Result := TDragDockObject;
end;

class procedure TDragDockObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Brush', TDragDockObject_Brush_si, TBrush_sw, True, True, 0, False, False);
  AData.AddProperty('DockRect', TDragDockObject_DockRect_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('DropAlign', TDragDockObject_DropAlign_si, TAlign_sw, True, False, 0, False, False);
  AData.AddProperty('DropOnControl', TDragDockObject_DropOnControl_si, TControl_sw, True, False, 0, False, False);
  AData.AddProperty('EraseDockRect', TDragDockObject_EraseDockRect_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('EraseWhenMoving', TDragDockObject_EraseWhenMoving_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Floating', TDragDockObject_Floating_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('FrameWidth', TDragDockObject_FrameWidth_si, Integer_sw, True, False, 0, False, False);
end;

class function TDragDockObject_sw.ToVar(
  const AValue: TDragDockObject): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragDockObject_sw.FromVar(
  const AValue: OleVariant): TDragDockObject;
begin
  Result := TDragDockObject(ConvFromVar(AValue, TDragDockObject));
end;

class function TDragDockObject_sw.ClassToVar(
  AClass: TDragDockObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragDockObject_sw.ClassFromVar(
  const AClass: OleVariant): TDragDockObject_sc;
begin
  Result := TDragDockObject_sc(ConvClsFromVar(AClass, TDragDockObject));
end;

{ TDragDockObjectEx_sw }

class function TDragDockObjectEx_sw.GetTypeName: WideString;
begin
  Result := 'TDragDockObjectEx';
end;

class function TDragDockObjectEx_sw.GetWrappedClass: TClass;
begin
  Result := TDragDockObjectEx;
end;

class procedure TDragDockObjectEx_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TDragDockObjectEx_sw.ToVar(
  const AValue: TDragDockObjectEx): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragDockObjectEx_sw.FromVar(
  const AValue: OleVariant): TDragDockObjectEx;
begin
  Result := TDragDockObjectEx(ConvFromVar(AValue, TDragDockObjectEx));
end;

class function TDragDockObjectEx_sw.ClassToVar(
  AClass: TDragDockObjectEx_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragDockObjectEx_sw.ClassFromVar(
  const AClass: OleVariant): TDragDockObjectEx_sc;
begin
  Result := TDragDockObjectEx_sc(ConvClsFromVar(AClass, TDragDockObjectEx));
end;

{ TControlCanvas_sw }

function TControlCanvas_FreeHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FreeHandle;

  TControlCanvas(AObj).FreeHandle();
end;

function TControlCanvas_UpdateTextFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateTextFlags;

  TControlCanvas(AObj).UpdateTextFlags();
end;

function TControlCanvas_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TControl read <getter> write <setter>;

  if IsGet then
    Result := TControl_sw.ToVar(TControlCanvas(AObj).Control)
  else
    TControlCanvas(AObj).Control := TControl_sw.FromVar(AArgs[0]);
end;

class function TControlCanvas_sw.GetTypeName: WideString;
begin
  Result := 'TControlCanvas';
end;

class function TControlCanvas_sw.GetWrappedClass: TClass;
begin
  Result := TControlCanvas;
end;

class procedure TControlCanvas_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('FreeHandle', TControlCanvas_FreeHandle_si, 0, False);
  AData.AddProcedure('UpdateTextFlags', TControlCanvas_UpdateTextFlags_si, 0, False);
  AData.AddProperty('Control', TControlCanvas_Control_si, TControl_sw, True, True, 0, False, False);
end;

class function TControlCanvas_sw.ToVar(
  const AValue: TControlCanvas): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlCanvas_sw.FromVar(
  const AValue: OleVariant): TControlCanvas;
begin
  Result := TControlCanvas(ConvFromVar(AValue, TControlCanvas));
end;

class function TControlCanvas_sw.ClassToVar(
  AClass: TControlCanvas_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControlCanvas_sw.ClassFromVar(
  const AClass: OleVariant): TControlCanvas_sc;
begin
  Result := TControlCanvas_sc(ConvClsFromVar(AClass, TControlCanvas));
end;

{ TCustomControlAction_sw }

function TCustomControlAction_DropdownMenu_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropdownMenu: TPopupMenu read <getter> write <se...

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TCustomControlAction(AObj).DropdownMenu)
  else
    TCustomControlAction(AObj).DropdownMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

function TCustomControlAction_EnableDropdown_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EnableDropdown: Boolean read <getter> write <set...

  if IsGet then
    Result := TCustomControlAction(AObj).EnableDropdown
  else
    TCustomControlAction(AObj).EnableDropdown := Boolean(AArgs[0]);
end;

function TCustomControlAction_PopupMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupMenu: TPopupMenu read <getter> write <setter>;

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TCustomControlAction(AObj).PopupMenu)
  else
    TCustomControlAction(AObj).PopupMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

class function TCustomControlAction_sw.GetTypeName: WideString;
begin
  Result := 'TCustomControlAction';
end;

class function TCustomControlAction_sw.GetWrappedClass: TClass;
begin
  Result := TCustomControlAction;
end;

class procedure TCustomControlAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DropdownMenu', TCustomControlAction_DropdownMenu_si, TPopupMenu_sw, True, True, 0, False, False);
  AData.AddProperty('EnableDropdown', TCustomControlAction_EnableDropdown_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PopupMenu', TCustomControlAction_PopupMenu_si, TPopupMenu_sw, True, True, 0, False, False);
end;

class function TCustomControlAction_sw.ToVar(
  const AValue: TCustomControlAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomControlAction_sw.FromVar(
  const AValue: OleVariant): TCustomControlAction;
begin
  Result := TCustomControlAction(ConvFromVar(AValue, TCustomControlAction));
end;

class function TCustomControlAction_sw.ClassToVar(
  AClass: TCustomControlAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomControlAction_sw.ClassFromVar(
  const AClass: OleVariant): TCustomControlAction_sc;
begin
  Result := TCustomControlAction_sc(ConvClsFromVar(AClass, 
    TCustomControlAction));
end;

{ TControlAction_sw }

class function TControlAction_sw.GetTypeName: WideString;
begin
  Result := 'TControlAction';
end;

class function TControlAction_sw.GetWrappedClass: TClass;
begin
  Result := TControlAction;
end;

class procedure TControlAction_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoCheck', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Checked', False);
  AData.AddPropertyRedecl('DropdownMenu', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('EnableDropdown', False);
  AData.AddPropertyRedecl('GroupIndex', False);
  AData.AddPropertyRedecl('HelpContext', False);
  AData.AddPropertyRedecl('HelpKeyword', False);
  AData.AddPropertyRedecl('HelpType', False);
  AData.AddPropertyRedecl('Hint', False);
  AData.AddPropertyRedecl('ImageIndex', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShortCut', False);
  AData.AddPropertyRedecl('SecondaryShortCuts', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnExecute', False);
  AData.AddPropertyRedecl('OnHint', False);
  AData.AddPropertyRedecl('OnUpdate', False);
end;

class function TControlAction_sw.ToVar(
  const AValue: TControlAction): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlAction_sw.FromVar(
  const AValue: OleVariant): TControlAction;
begin
  Result := TControlAction(ConvFromVar(AValue, TControlAction));
end;

class function TControlAction_sw.ClassToVar(
  AClass: TControlAction_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControlAction_sw.ClassFromVar(
  const AClass: OleVariant): TControlAction_sc;
begin
  Result := TControlAction_sc(ConvClsFromVar(AClass, TControlAction));
end;

{ TControlActionLink_sw }

class function TControlActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TControlActionLink';
end;

class function TControlActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TControlActionLink;
end;

class procedure TControlActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TControlActionLink_sw.ToVar(
  const AValue: TControlActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlActionLink_sw.FromVar(
  const AValue: OleVariant): TControlActionLink;
begin
  Result := TControlActionLink(ConvFromVar(AValue, TControlActionLink));
end;

class function TControlActionLink_sw.ClassToVar(
  AClass: TControlActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControlActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TControlActionLink_sc;
begin
  Result := TControlActionLink_sc(ConvClsFromVar(AClass, TControlActionLink));
end;

{ TControlActionLinkClass_sw }

class function TControlActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TControlActionLinkClass';
end;

class function TControlActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TControlActionLink;
end;

class function TControlActionLinkClass_sw.ToVar(
  const AValue: TControlActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TControlActionLinkClass;
begin
  Result := TControlActionLinkClass(ConvFromVar(AValue, TControlActionLink));
end;

{ TMouseButton_sw }

class function TMouseButton_sw.GetTypeName: WideString;
begin
  Result := 'TMouseButton';
end;

class procedure TMouseButton_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'mbLeft'; Value: Integer({$IFDEF LMDSCT_12}TMouseButton.{$ENDIF}mbLeft)),
    (Name: 'mbRight'; Value: Integer({$IFDEF LMDSCT_12}TMouseButton.{$ENDIF}mbRight)),
    (Name: 'mbMiddle'; Value: Integer({$IFDEF LMDSCT_12}TMouseButton.{$ENDIF}mbMiddle))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMouseButton_sw.ToVar(const AValue: TMouseButton): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMouseButton_sw.FromVar(const AValue: OleVariant): TMouseButton;
begin
  Result := TMouseButton(Integer(AValue));
end;

{ TMouseActivate_sw }

class function TMouseActivate_sw.GetTypeName: WideString;
begin
  Result := 'TMouseActivate';
end;

class procedure TMouseActivate_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'maDefault'; Value: Integer({$IFDEF LMDSCT_12}TMouseActivate.{$ENDIF}maDefault)),
    (Name: 'maActivate'; Value: Integer({$IFDEF LMDSCT_12}TMouseActivate.{$ENDIF}maActivate)),
    (Name: 'maActivateAndEat'; Value: Integer({$IFDEF LMDSCT_12}TMouseActivate.{$ENDIF}maActivateAndEat)),
    (Name: 'maNoActivate'; Value: Integer({$IFDEF LMDSCT_12}TMouseActivate.{$ENDIF}maNoActivate)),
    (Name: 'maNoActivateAndEat'; Value: Integer({$IFDEF LMDSCT_12}TMouseActivate.{$ENDIF}maNoActivateAndEat))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TMouseActivate_sw.ToVar(
  const AValue: TMouseActivate): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMouseActivate_sw.FromVar(
  const AValue: OleVariant): TMouseActivate;
begin
  Result := TMouseActivate(Integer(AValue));
end;

{ TDragMode_sw }

class function TDragMode_sw.GetTypeName: WideString;
begin
  Result := 'TDragMode';
end;

class procedure TDragMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dmManual'; Value: Integer({$IFDEF LMDSCT_12}TDragMode.{$ENDIF}dmManual)),
    (Name: 'dmAutomatic'; Value: Integer({$IFDEF LMDSCT_12}TDragMode.{$ENDIF}dmAutomatic))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDragMode_sw.ToVar(const AValue: TDragMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDragMode_sw.FromVar(const AValue: OleVariant): TDragMode;
begin
  Result := TDragMode(Integer(AValue));
end;

{ TDragState_sw }

class function TDragState_sw.GetTypeName: WideString;
begin
  Result := 'TDragState';
end;

class procedure TDragState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'dsDragEnter'; Value: Integer({$IFDEF LMDSCT_12}TDragState.{$ENDIF}dsDragEnter)),
    (Name: 'dsDragLeave'; Value: Integer({$IFDEF LMDSCT_12}TDragState.{$ENDIF}dsDragLeave)),
    (Name: 'dsDragMove'; Value: Integer({$IFDEF LMDSCT_12}TDragState.{$ENDIF}dsDragMove))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDragState_sw.ToVar(const AValue: TDragState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDragState_sw.FromVar(const AValue: OleVariant): TDragState;
begin
  Result := TDragState(Integer(AValue));
end;

{ TDragKind_sw }

class function TDragKind_sw.GetTypeName: WideString;
begin
  Result := 'TDragKind';
end;

class procedure TDragKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'dkDrag'; Value: Integer({$IFDEF LMDSCT_12}TDragKind.{$ENDIF}dkDrag)),
    (Name: 'dkDock'; Value: Integer({$IFDEF LMDSCT_12}TDragKind.{$ENDIF}dkDock))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TDragKind_sw.ToVar(const AValue: TDragKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDragKind_sw.FromVar(const AValue: OleVariant): TDragKind;
begin
  Result := TDragKind(Integer(AValue));
end;

{ TTabOrder_sw }

class function TTabOrder_sw.GetTypeName: WideString;
begin
  Result := 'TTabOrder';
end;

class function TTabOrder_sw.ToVar(const AValue: TTabOrder): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTabOrder_sw.FromVar(const AValue: OleVariant): TTabOrder;
begin
  Result := TTabOrder(Integer(AValue));
end;

{ TCaption_sw }

class function TCaption_sw.GetTypeName: WideString;
begin
  Result := 'TCaption';
end;

class function TCaption_sw.ToVar(const AValue: TCaption): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TCaption_sw.FromVar(const AValue: OleVariant): TCaption;
begin
  Result := TCaption(string_sw.FromVar(AValue));
end;

{ TMouseActivateRec_sw }

function TMouseActivateRec_MousePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MousePos: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(TMouseActivateRec_sw(AObj).FValue.MousePos)
  else
    TMouseActivateRec_sw(AObj).FValue.MousePos := TPoint_sw.FromVar(AArgs[0]);
end;

function TMouseActivateRec_HitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HitTest: Integer;

  if IsGet then
    Result := TMouseActivateRec_sw(AObj).FValue.HitTest
  else
    TMouseActivateRec_sw(AObj).FValue.HitTest := Integer(AArgs[0]);
end;

function TMouseActivateRec_Button_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Button: TMouseButton;

  if IsGet then
    Result := TMouseButton_sw.ToVar(TMouseActivateRec_sw(AObj).FValue.Button)
  else
    TMouseActivateRec_sw(AObj).FValue.Button := TMouseButton_sw.FromVar(
      AArgs[0]);
end;

function TMouseActivateRec_TopLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TopLevel: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(TMouseActivateRec_sw(AObj).FValue.TopLevel)
  else
    TMouseActivateRec_sw(AObj).FValue.TopLevel := HWND_sw.FromVar(AArgs[0]);
end;

function TMouseActivateRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMouseActivateRec_sw.Create as IDispatch;
end;

function TMouseActivateRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMouseActivateRec;

  // Implicit record copy method.
  Result := TMouseActivateRec_sw.ToVar(TMouseActivateRec(AObj));
end;

class function TMouseActivateRec_sw.GetTypeName: WideString;
begin
  Result := 'TMouseActivateRec';
end;

function TMouseActivateRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMouseActivateRec_sw.Create;
  TMouseActivateRec_sw(Result).FValue := FValue;
end;

class procedure TMouseActivateRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('MousePos', TMouseActivateRec_MousePos_si, TPoint_sw);
  AData.AddField('HitTest', TMouseActivateRec_HitTest_si, Integer_sw);
  AData.AddField('Button', TMouseActivateRec_Button_si, TMouseButton_sw);
  AData.AddField('TopLevel', TMouseActivateRec_TopLevel_si, HWND_sw);
  AData.AddFunction('Copy', TMouseActivateRec_Copy_si, TMouseActivateRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMouseActivateRec_Create_si, 0, False);
end;

class function TMouseActivateRec_sw.ToVar(
  const AValue: TMouseActivateRec): OleVariant;
var
  wrpr: TMouseActivateRec_sw;
begin
  wrpr        := TMouseActivateRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMouseActivateRec_sw.FromVar(
  const AValue: OleVariant): TMouseActivateRec;
begin
  Result := TMouseActivateRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMMouseActivate_sw }

function TCMMouseActivate_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMMouseActivate_sw(AObj).FValue.Msg
  else
    TCMMouseActivate_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMMouseActivate_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: Integer;

  if IsGet then
    Result := TCMMouseActivate_sw(AObj).FValue.Reserved
  else
    TCMMouseActivate_sw(AObj).FValue.Reserved := Integer(AArgs[0]);
end;

function TCMMouseActivate_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Integer;

  if IsGet then
    Result := TCMMouseActivate_sw(AObj).FValue.Result
  else
    TCMMouseActivate_sw(AObj).FValue.Result := Integer(AArgs[0]);
end;

function TCMMouseActivate_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMMouseActivate_sw.Create as IDispatch;
end;

function TCMMouseActivate_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMMouseActivate;

  // Implicit record copy method.
  Result := TCMMouseActivate_sw.ToVar(TCMMouseActivate(AObj));
end;

class function TCMMouseActivate_sw.GetTypeName: WideString;
begin
  Result := 'TCMMouseActivate';
end;

function TCMMouseActivate_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMMouseActivate_sw.Create;
  TCMMouseActivate_sw(Result).FValue := FValue;
end;

class procedure TCMMouseActivate_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMMouseActivate_Msg_si, Cardinal_sw);
  AData.AddField('Reserved', TCMMouseActivate_Reserved_si, Integer_sw);
  AData.AddField('Result', TCMMouseActivate_Result_si, Integer_sw);
  AData.AddFunction('Copy', TCMMouseActivate_Copy_si, TCMMouseActivate_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMMouseActivate_Create_si, 0, False);
end;

class function TCMMouseActivate_sw.ToVar(
  const AValue: TCMMouseActivate): OleVariant;
var
  wrpr: TCMMouseActivate_sw;
begin
  wrpr        := TCMMouseActivate_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMMouseActivate_sw.FromVar(
  const AValue: OleVariant): TCMMouseActivate;
begin
  Result := TCMMouseActivate_sw(ConvFromVar(AValue)).FValue;
end;

{ TAnchorKind_sw }

class function TAnchorKind_sw.GetTypeName: WideString;
begin
  Result := 'TAnchorKind';
end;

class procedure TAnchorKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'akLeft'; Value: Integer({$IFDEF LMDSCT_12}TAnchorKind.{$ENDIF}akLeft)),
    (Name: 'akTop'; Value: Integer({$IFDEF LMDSCT_12}TAnchorKind.{$ENDIF}akTop)),
    (Name: 'akRight'; Value: Integer({$IFDEF LMDSCT_12}TAnchorKind.{$ENDIF}akRight)),
    (Name: 'akBottom'; Value: Integer({$IFDEF LMDSCT_12}TAnchorKind.{$ENDIF}akBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TAnchorKind_sw.ToVar(const AValue: TAnchorKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TAnchorKind_sw.FromVar(const AValue: OleVariant): TAnchorKind;
begin
  Result := TAnchorKind(Integer(AValue));
end;

{ TAnchors_sw }

class function TAnchors_sw.GetTypeName: WideString;
begin
  Result := 'TAnchors';
end;

class function TAnchors_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TAnchors);
end;

class function TAnchors_sw.ToVar(const AValue: TAnchors): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TAnchors_sw.FromVar(const AValue: OleVariant): TAnchors;
begin
  ConvFromVar(AValue, @Result);
end;

{ TConstraintSize_sw }

class function TConstraintSize_sw.GetTypeName: WideString;
begin
  Result := 'TConstraintSize';
end;

class function TConstraintSize_sw.ToVar(
  const AValue: TConstraintSize): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TConstraintSize_sw.FromVar(
  const AValue: OleVariant): TConstraintSize;
begin
  Result := TConstraintSize(Integer(AValue));
end;

{ TSizeConstraints_sw }

function TSizeConstraints_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Control: TControl read <getter>;

  Result := TControl_sw.ToVar(TSizeConstraints_sacc(TSizeConstraints(AObj)).
    Control);
end;

function TSizeConstraints_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Control: TControl);

  Result := TSizeConstraints_sw.ToVar(TSizeConstraints_sc(AObj).Create(
    TControl_sw.FromVar(AArgs[0])));
end;

function TSizeConstraints_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TSizeConstraints(AObj).OnChange)
  else
    TSizeConstraints(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TSizeConstraints_MaxHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxHeight: TConstraintSize read <getter> write <...

  if IsGet then
    Result := TConstraintSize_sw.ToVar(TSizeConstraints(AObj).MaxHeight)
  else
    TSizeConstraints(AObj).MaxHeight := TConstraintSize_sw.FromVar(AArgs[0]);
end;

function TSizeConstraints_MaxWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxWidth: TConstraintSize read <getter> write <s...

  if IsGet then
    Result := TConstraintSize_sw.ToVar(TSizeConstraints(AObj).MaxWidth)
  else
    TSizeConstraints(AObj).MaxWidth := TConstraintSize_sw.FromVar(AArgs[0]);
end;

function TSizeConstraints_MinHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinHeight: TConstraintSize read <getter> write <...

  if IsGet then
    Result := TConstraintSize_sw.ToVar(TSizeConstraints(AObj).MinHeight)
  else
    TSizeConstraints(AObj).MinHeight := TConstraintSize_sw.FromVar(AArgs[0]);
end;

function TSizeConstraints_MinWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinWidth: TConstraintSize read <getter> write <s...

  if IsGet then
    Result := TConstraintSize_sw.ToVar(TSizeConstraints(AObj).MinWidth)
  else
    TSizeConstraints(AObj).MinWidth := TConstraintSize_sw.FromVar(AArgs[0]);
end;

class function TSizeConstraints_sw.GetTypeName: WideString;
begin
  Result := 'TSizeConstraints';
end;

class function TSizeConstraints_sw.GetWrappedClass: TClass;
begin
  Result := TSizeConstraints;
end;

class procedure TSizeConstraints_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Control', TSizeConstraints_Control_si, TControl_sw, True, False, 0, True, False);
  AData.AddProperty('OnChange', TSizeConstraints_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('MaxHeight', TSizeConstraints_MaxHeight_si, TConstraintSize_sw, True, True, 0, False, False);
  AData.AddProperty('MaxWidth', TSizeConstraints_MaxWidth_si, TConstraintSize_sw, True, True, 0, False, False);
  AData.AddProperty('MinHeight', TSizeConstraints_MinHeight_si, TConstraintSize_sw, True, True, 0, False, False);
  AData.AddProperty('MinWidth', TSizeConstraints_MinWidth_si, TConstraintSize_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TSizeConstraints_Create_si, 1, False);
end;

class function TSizeConstraints_sw.ToVar(
  const AValue: TSizeConstraints): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSizeConstraints_sw.FromVar(
  const AValue: OleVariant): TSizeConstraints;
begin
  Result := TSizeConstraints(ConvFromVar(AValue, TSizeConstraints));
end;

class function TSizeConstraints_sw.ClassToVar(
  AClass: TSizeConstraints_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSizeConstraints_sw.ClassFromVar(
  const AClass: OleVariant): TSizeConstraints_sc;
begin
  Result := TSizeConstraints_sc(ConvClsFromVar(AClass, TSizeConstraints));
end;

{ TMarginSize_sw }

class function TMarginSize_sw.GetTypeName: WideString;
begin
  Result := 'TMarginSize';
end;

class function TMarginSize_sw.ToVar(const AValue: TMarginSize): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMarginSize_sw.FromVar(const AValue: OleVariant): TMarginSize;
begin
  Result := TMarginSize(Integer(AValue));
end;

{ TMargins_sw }

function TMargins_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Control: TControl read <getter>;

  Result := TControl_sw.ToVar(TMargins_sacc(TMargins(AObj)).Control);
end;

function TMargins_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Control: TControl);

  Result := TMargins_sw.ToVar(TMargins_sc(AObj).Create(TControl_sw.FromVar(
    AArgs[0])));
end;

function TMargins_SetControlBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SetControlBounds(...); overload;

  case AArgsSize of
    4:
    begin
      TMargins(AObj).SetControlBounds(Integer(AArgs[0]), Integer(AArgs[1]), 
        Integer(AArgs[2]), Integer(AArgs[3]));
    end;
    5:
    begin
      TMargins(AObj).SetControlBounds(Integer(AArgs[0]), Integer(AArgs[1]), 
        Integer(AArgs[2]), Integer(AArgs[3]), Boolean(AArgs[4]));
    end;
    1:
    begin
      TMargins(AObj).SetControlBounds(TRect_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      TMargins(AObj).SetControlBounds(TRect_sw.FromVar(AArgs[0]), Boolean(
        AArgs[1]));
    end;
  else
    WrongArgCountError('SetControlBounds');
  end;
end;

function TMargins_SetBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetBounds(ALeft: Integer; ATop: Integer; ARight...

  TMargins(AObj).SetBounds(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]));
end;

function TMargins_ControlLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ControlLeft: Integer read <getter>;

  Result := TMargins(AObj).ControlLeft;
end;

function TMargins_ControlTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ControlTop: Integer read <getter>;

  Result := TMargins(AObj).ControlTop;
end;

function TMargins_ControlWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ControlWidth: Integer read <getter>;

  Result := TMargins(AObj).ControlWidth;
end;

function TMargins_ControlHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ControlHeight: Integer read <getter>;

  Result := TMargins(AObj).ControlHeight;
end;

function TMargins_ExplicitLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitLeft: Integer read <getter>;

  Result := TMargins(AObj).ExplicitLeft;
end;

function TMargins_ExplicitTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitTop: Integer read <getter>;

  Result := TMargins(AObj).ExplicitTop;
end;

function TMargins_ExplicitWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitWidth: Integer read <getter>;

  Result := TMargins(AObj).ExplicitWidth;
end;

function TMargins_ExplicitHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitHeight: Integer read <getter>;

  Result := TMargins(AObj).ExplicitHeight;
end;

function TMargins_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TMargins(AObj).OnChange)
  else
    TMargins(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TMargins_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: TMarginSize read <getter> write <setter>;

  if IsGet then
    Result := TMarginSize_sw.ToVar(TMargins(AObj).Left)
  else
    TMargins(AObj).Left := TMarginSize_sw.FromVar(AArgs[0]);
end;

function TMargins_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: TMarginSize read <getter> write <setter>;

  if IsGet then
    Result := TMarginSize_sw.ToVar(TMargins(AObj).Top)
  else
    TMargins(AObj).Top := TMarginSize_sw.FromVar(AArgs[0]);
end;

function TMargins_Right_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Right: TMarginSize read <getter> write <setter>;

  if IsGet then
    Result := TMarginSize_sw.ToVar(TMargins(AObj).Right)
  else
    TMargins(AObj).Right := TMarginSize_sw.FromVar(AArgs[0]);
end;

function TMargins_Bottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bottom: TMarginSize read <getter> write <setter>;

  if IsGet then
    Result := TMarginSize_sw.ToVar(TMargins(AObj).Bottom)
  else
    TMargins(AObj).Bottom := TMarginSize_sw.FromVar(AArgs[0]);
end;

class function TMargins_sw.GetTypeName: WideString;
begin
  Result := 'TMargins';
end;

class function TMargins_sw.GetWrappedClass: TClass;
begin
  Result := TMargins;
end;

class procedure TMargins_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Control', TMargins_Control_si, TControl_sw, True, False, 0, True, False);
  AData.AddProcedure('SetControlBounds', TMargins_SetControlBounds_si, 1, True);
  AData.AddProcedure('SetBounds', TMargins_SetBounds_si, 4, False);
  AData.AddProperty('ControlLeft', TMargins_ControlLeft_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ControlTop', TMargins_ControlTop_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ControlWidth', TMargins_ControlWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ControlHeight', TMargins_ControlHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitLeft', TMargins_ExplicitLeft_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitTop', TMargins_ExplicitTop_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitWidth', TMargins_ExplicitWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitHeight', TMargins_ExplicitHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OnChange', TMargins_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('Left', TMargins_Left_si, TMarginSize_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TMargins_Top_si, TMarginSize_sw, True, True, 0, False, False);
  AData.AddProperty('Right', TMargins_Right_si, TMarginSize_sw, True, True, 0, False, False);
  AData.AddProperty('Bottom', TMargins_Bottom_si, TMarginSize_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMargins_Create_si, 1, False);
end;

class function TMargins_sw.ToVar(const AValue: TMargins): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMargins_sw.FromVar(const AValue: OleVariant): TMargins;
begin
  Result := TMargins(ConvFromVar(AValue, TMargins));
end;

class function TMargins_sw.ClassToVar(AClass: TMargins_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMargins_sw.ClassFromVar(const AClass: OleVariant): TMargins_sc;
begin
  Result := TMargins_sc(ConvClsFromVar(AClass, TMargins));
end;

{ TPadding_sw }

class function TPadding_sw.GetTypeName: WideString;
begin
  Result := 'TPadding';
end;

class function TPadding_sw.GetWrappedClass: TClass;
begin
  Result := TPadding;
end;

class procedure TPadding_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Left', False);
  AData.AddPropertyRedecl('Top', False);
  AData.AddPropertyRedecl('Right', False);
  AData.AddPropertyRedecl('Bottom', False);
end;

class function TPadding_sw.ToVar(const AValue: TPadding): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPadding_sw.FromVar(const AValue: OleVariant): TPadding;
begin
  Result := TPadding(ConvFromVar(AValue, TPadding));
end;

class function TPadding_sw.ClassToVar(AClass: TPadding_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPadding_sw.ClassFromVar(const AClass: OleVariant): TPadding_sc;
begin
  Result := TPadding_sc(ConvClsFromVar(AClass, TPadding));
end;

{ TGestureID_sw }

class function TGestureID_sw.GetTypeName: WideString;
begin
  Result := 'TGestureID';
end;

class function TGestureID_sw.ToVar(const AValue: TGestureID): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGestureID_sw.FromVar(const AValue: OleVariant): TGestureID;
begin
  Result := TGestureID(Integer(AValue));
end;

{ TGestureEventInfo_sw }

function TGestureEventInfo_GestureID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var GestureID: TGestureID;

  if IsGet then
    Result := TGestureID_sw.ToVar(TGestureEventInfo_sw(AObj).FValue.GestureID)
  else
    TGestureEventInfo_sw(AObj).FValue.GestureID := TGestureID_sw.FromVar(
      AArgs[0]);
end;

function TGestureEventInfo_Location_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Location: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(TGestureEventInfo_sw(AObj).FValue.Location)
  else
    TGestureEventInfo_sw(AObj).FValue.Location := TPoint_sw.FromVar(AArgs[0]);
end;

function TGestureEventInfo_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: TInteractiveGestureFlags;

  if IsGet then
    Result := TInteractiveGestureFlags_sw.ToVar(TGestureEventInfo_sw(AObj).
      FValue.Flags)
  else
    TGestureEventInfo_sw(AObj).FValue.Flags := TInteractiveGestureFlags_sw.
      FromVar(AArgs[0]);
end;

function TGestureEventInfo_Angle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Angle: Double;

  if IsGet then
    Result := TGestureEventInfo_sw(AObj).FValue.Angle
  else
    TGestureEventInfo_sw(AObj).FValue.Angle := Double(AArgs[0]);
end;

function TGestureEventInfo_InertiaVector_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var InertiaVector: TSmallPoint;

  if IsGet then
    Result := TSmallPoint_sw.ToVar(TGestureEventInfo_sw(AObj).FValue.
      InertiaVector)
  else
    TGestureEventInfo_sw(AObj).FValue.InertiaVector := TSmallPoint_sw.FromVar(
      AArgs[0]);
end;

function TGestureEventInfo_Distance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Distance: Integer;

  if IsGet then
    Result := TGestureEventInfo_sw(AObj).FValue.Distance
  else
    TGestureEventInfo_sw(AObj).FValue.Distance := Integer(AArgs[0]);
end;

function TGestureEventInfo_TapLocation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TapLocation: TSmallPoint;

  if IsGet then
    Result := TSmallPoint_sw.ToVar(TGestureEventInfo_sw(AObj).FValue.
      TapLocation)
  else
    TGestureEventInfo_sw(AObj).FValue.TapLocation := TSmallPoint_sw.FromVar(
      AArgs[0]);
end;

function TGestureEventInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TGestureEventInfo_sw.Create as IDispatch;
end;

function TGestureEventInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TGestureEventInfo;

  // Implicit record copy method.
  Result := TGestureEventInfo_sw.ToVar(TGestureEventInfo(AObj));
end;

class function TGestureEventInfo_sw.GetTypeName: WideString;
begin
  Result := 'TGestureEventInfo';
end;

function TGestureEventInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGestureEventInfo_sw.Create;
  TGestureEventInfo_sw(Result).FValue := FValue;
end;

class procedure TGestureEventInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('GestureID', TGestureEventInfo_GestureID_si, TGestureID_sw);
  AData.AddField('Location', TGestureEventInfo_Location_si, TPoint_sw);
  AData.AddField('Flags', TGestureEventInfo_Flags_si, TInteractiveGestureFlags_sw);
  AData.AddField('Angle', TGestureEventInfo_Angle_si, Double_sw);
  AData.AddField('InertiaVector', TGestureEventInfo_InertiaVector_si, TSmallPoint_sw);
  AData.AddField('Distance', TGestureEventInfo_Distance_si, Integer_sw);
  AData.AddField('TapLocation', TGestureEventInfo_TapLocation_si, TSmallPoint_sw);
  AData.AddFunction('Copy', TGestureEventInfo_Copy_si, TGestureEventInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TGestureEventInfo_Create_si, 0, False);
end;

class function TGestureEventInfo_sw.ToVar(
  const AValue: TGestureEventInfo): OleVariant;
var
  wrpr: TGestureEventInfo_sw;
begin
  wrpr        := TGestureEventInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TGestureEventInfo_sw.FromVar(
  const AValue: OleVariant): TGestureEventInfo;
begin
  Result := TGestureEventInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TCMGesture_sw }

function TCMGesture_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMGesture_sw(AObj).FValue.Msg
  else
    TCMGesture_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMGesture_Reserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved: Integer;

  if IsGet then
    Result := TCMGesture_sw(AObj).FValue.Reserved
  else
    TCMGesture_sw(AObj).FValue.Reserved := Integer(AArgs[0]);
end;

function TCMGesture_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TCMGesture_sw(AObj).FValue.Result
  else
    TCMGesture_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

function TCMGesture_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMGesture_sw.Create as IDispatch;
end;

function TCMGesture_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMGesture;

  // Implicit record copy method.
  Result := TCMGesture_sw.ToVar(TCMGesture(AObj));
end;

class function TCMGesture_sw.GetTypeName: WideString;
begin
  Result := 'TCMGesture';
end;

function TCMGesture_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMGesture_sw.Create;
  TCMGesture_sw(Result).FValue := FValue;
end;

class procedure TCMGesture_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMGesture_Msg_si, Cardinal_sw);
  AData.AddField('Reserved', TCMGesture_Reserved_si, Integer_sw);
  AData.AddField('Result', TCMGesture_Result_si, Longint_sw);
  AData.AddFunction('Copy', TCMGesture_Copy_si, TCMGesture_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMGesture_Create_si, 0, False);
end;

class function TCMGesture_sw.ToVar(const AValue: TCMGesture): OleVariant;
var
  wrpr: TCMGesture_sw;
begin
  wrpr        := TCMGesture_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMGesture_sw.FromVar(const AValue: OleVariant): TCMGesture;
begin
  Result := TCMGesture_sw(ConvFromVar(AValue)).FValue;
end;

{ TGestureEvent_sh }

function TGestureEvent_sh.GetHandler: TMethod;
var
  hdr: TGestureEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGestureEvent_sh.Handler(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; const EventInfo: TGestureEven...

  v_1 := Handled;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TGestureEventInfo_sw.ToVar(EventInfo);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TGestureEvent_sw }

class function TGestureEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGestureEvent';
end;

class function TGestureEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGestureEvent_sh;
end;

class function TGestureEvent_sw.ToVar(const AValue: TGestureEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGestureEvent_sw.FromVar(
  const AValue: OleVariant): TGestureEvent;
begin
  Result := TGestureEvent(ConvFromVar(AValue));
end;

class function TGestureEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGestureEvent;
var
  hdlr: TGestureEvent_sh;
begin
  hdlr   := TGestureEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGestureEvent_sw));
  Result := hdlr.Handler;
end;

{ TStandardGesture_sw }

class function TStandardGesture_sw.GetTypeName: WideString;
begin
  Result := 'TStandardGesture';
end;

class procedure TStandardGesture_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..33] of TLMDEnumerator = (
    (Name: 'sgLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgLeft)),
    (Name: 'sgRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgRight)),
    (Name: 'sgUp'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUp)),
    (Name: 'sgDown'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDown)),
    (Name: 'sgUpLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUpLeft)),
    (Name: 'sgUpRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUpRight)),
    (Name: 'sgDownLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDownLeft)),
    (Name: 'sgDownRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDownRight)),
    (Name: 'sgLeftUp'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgLeftUp)),
    (Name: 'sgLeftDown'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgLeftDown)),
    (Name: 'sgRightUp'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgRightUp)),
    (Name: 'sgRightDown'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgRightDown)),
    (Name: 'sgUpDown'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUpDown)),
    (Name: 'sgDownUp'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDownUp)),
    (Name: 'sgLeftRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgLeftRight)),
    (Name: 'sgRightLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgRightLeft)),
    (Name: 'sgUpLeftLong'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUpLeftLong)),
    (Name: 'sgUpRightLong'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgUpRightLong)),
    (Name: 'sgDownLeftLong'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDownLeftLong)),
    (Name: 'sgDownRightLong'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDownRightLong)),
    (Name: 'sgScratchout'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgScratchout)),
    (Name: 'sgTriangle'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgTriangle)),
    (Name: 'sgSquare'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgSquare)),
    (Name: 'sgCheck'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgCheck)),
    (Name: 'sgCurlicue'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgCurlicue)),
    (Name: 'sgDoubleCurlicue'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDoubleCurlicue)),
    (Name: 'sgCircle'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgCircle)),
    (Name: 'sgDoubleCircle'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgDoubleCircle)),
    (Name: 'sgSemiCircleLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgSemiCircleLeft)),
    (Name: 'sgSemiCircleRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgSemiCircleRight)),
    (Name: 'sgChevronUp'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgChevronUp)),
    (Name: 'sgChevronDown'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgChevronDown)),
    (Name: 'sgChevronLeft'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgChevronLeft)),
    (Name: 'sgChevronRight'; Value: Integer({$IFDEF LMDSCT_12}TStandardGesture.{$ENDIF}sgChevronRight))
  );
begin
  AEnums := @ENUMS;
  ACount := 34;
end;

class function TStandardGesture_sw.ToVar(
  const AValue: TStandardGesture): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TStandardGesture_sw.FromVar(
  const AValue: OleVariant): TStandardGesture;
begin
  Result := TStandardGesture(Integer(AValue));
end;

{ TStandardGestures_sw }

class function TStandardGestures_sw.GetTypeName: WideString;
begin
  Result := 'TStandardGestures';
end;

class function TStandardGestures_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TStandardGestures);
end;

class function TStandardGestures_sw.ToVar(
  const AValue: TStandardGestures): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TStandardGestures_sw.FromVar(
  const AValue: OleVariant): TStandardGestures;
begin
  ConvFromVar(AValue, @Result);
end;

{ TTabletOption_sw }

class function TTabletOption_sw.GetTypeName: WideString;
begin
  Result := 'TTabletOption';
end;

class procedure TTabletOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'toPressAndHold'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toPressAndHold)),
    (Name: 'toPenTapFeedback'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toPenTapFeedback)),
    (Name: 'toPenBarrelFeedback'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toPenBarrelFeedback)),
    (Name: 'toTouchUIForceOn'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toTouchUIForceOn)),
    (Name: 'toTouchUIForceOff'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toTouchUIForceOff)),
    (Name: 'toTouchSwitch'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toTouchSwitch)),
    (Name: 'toFlicks'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toFlicks)),
    (Name: 'toSmoothScrolling'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toSmoothScrolling)),
    (Name: 'toFlickFallbackKeys'; Value: Integer({$IFDEF LMDSCT_12}TTabletOption.{$ENDIF}toFlickFallbackKeys))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TTabletOption_sw.ToVar(const AValue: TTabletOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTabletOption_sw.FromVar(
  const AValue: OleVariant): TTabletOption;
begin
  Result := TTabletOption(Integer(AValue));
end;

{ TTabletOptions_sw }

class function TTabletOptions_sw.GetTypeName: WideString;
begin
  Result := 'TTabletOptions';
end;

class function TTabletOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTabletOptions);
end;

class function TTabletOptions_sw.ToVar(
  const AValue: TTabletOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTabletOptions_sw.FromVar(
  const AValue: OleVariant): TTabletOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TGestureType_sw }

class function TGestureType_sw.GetTypeName: WideString;
begin
  Result := 'TGestureType';
end;

class procedure TGestureType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'gtStandard'; Value: Integer({$IFDEF LMDSCT_12}TGestureType.{$ENDIF}gtStandard)),
    (Name: 'gtRecorded'; Value: Integer({$IFDEF LMDSCT_12}TGestureType.{$ENDIF}gtRecorded)),
    (Name: 'gtRegistered'; Value: Integer({$IFDEF LMDSCT_12}TGestureType.{$ENDIF}gtRegistered)),
    (Name: 'gtNone'; Value: Integer({$IFDEF LMDSCT_12}TGestureType.{$ENDIF}gtNone))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TGestureType_sw.ToVar(const AValue: TGestureType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGestureType_sw.FromVar(const AValue: OleVariant): TGestureType;
begin
  Result := TGestureType(Integer(AValue));
end;

{ TGestureTypes_sw }

class function TGestureTypes_sw.GetTypeName: WideString;
begin
  Result := 'TGestureTypes';
end;

class function TGestureTypes_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TGestureTypes);
end;

class function TGestureTypes_sw.ToVar(const AValue: TGestureTypes): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TGestureTypes_sw.FromVar(
  const AValue: OleVariant): TGestureTypes;
begin
  ConvFromVar(AValue, @Result);
end;

{ TGestureOption_sw }

class function TGestureOption_sw.GetTypeName: WideString;
begin
  Result := 'TGestureOption';
end;

class procedure TGestureOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'goUniDirectional'; Value: Integer({$IFDEF LMDSCT_12}TGestureOption.{$ENDIF}goUniDirectional)),
    (Name: 'goSkew'; Value: Integer({$IFDEF LMDSCT_12}TGestureOption.{$ENDIF}goSkew)),
    (Name: 'goEndpoint'; Value: Integer({$IFDEF LMDSCT_12}TGestureOption.{$ENDIF}goEndpoint)),
    (Name: 'goRotate'; Value: Integer({$IFDEF LMDSCT_12}TGestureOption.{$ENDIF}goRotate))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TGestureOption_sw.ToVar(
  const AValue: TGestureOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGestureOption_sw.FromVar(
  const AValue: OleVariant): TGestureOption;
begin
  Result := TGestureOption(Integer(AValue));
end;

{ TGestureOptions_sw }

class function TGestureOptions_sw.GetTypeName: WideString;
begin
  Result := 'TGestureOptions';
end;

class function TGestureOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TGestureOptions);
end;

class function TGestureOptions_sw.ToVar(
  const AValue: TGestureOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TGestureOptions_sw.FromVar(
  const AValue: OleVariant): TGestureOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ EGestureException_sw }

class function EGestureException_sw.GetTypeName: WideString;
begin
  Result := 'EGestureException';
end;

class function EGestureException_sw.GetWrappedClass: TClass;
begin
  Result := EGestureException;
end;

class procedure EGestureException_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EGestureException_sw.ToVar(
  const AValue: EGestureException): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EGestureException_sw.FromVar(
  const AValue: OleVariant): EGestureException;
begin
  Result := EGestureException(ConvFromVar(AValue, EGestureException));
end;

class function EGestureException_sw.ClassToVar(
  AClass: EGestureException_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EGestureException_sw.ClassFromVar(
  const AClass: OleVariant): EGestureException_sc;
begin
  Result := EGestureException_sc(ConvClsFromVar(AClass, EGestureException));
end;

{ TCustomGestureCollectionItem_sw }

function TCustomGestureCollectionItem_Deviation_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Deviation: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomGestureCollectionItem(AObj).Deviation
  else
    TCustomGestureCollectionItem(AObj).Deviation := Integer(AArgs[0]);
end;

function TCustomGestureCollectionItem_ErrorMargin_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ErrorMargin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomGestureCollectionItem(AObj).ErrorMargin
  else
    TCustomGestureCollectionItem(AObj).ErrorMargin := Integer(AArgs[0]);
end;

function TCustomGestureCollectionItem_GestureID_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GestureID: TGestureID read <getter> write <setter>;

  if IsGet then
    Result := TGestureID_sw.ToVar(TCustomGestureCollectionItem(AObj).GestureID)
  else
    TCustomGestureCollectionItem(AObj).GestureID := TGestureID_sw.FromVar(
      AArgs[0]);
end;

function TCustomGestureCollectionItem_GestureType_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GestureType: TGestureType read <getter>;

  Result := TGestureType_sw.ToVar(TCustomGestureCollectionItem(AObj).
    GestureType);
end;

function TCustomGestureCollectionItem_Options_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TGestureOptions read <getter> write <se...

  if IsGet then
    Result := TGestureOptions_sw.ToVar(TCustomGestureCollectionItem(AObj).
      Options)
  else
    TCustomGestureCollectionItem(AObj).Options := TGestureOptions_sw.FromVar(
      AArgs[0]);
end;

function TCustomGestureCollectionItem_Name_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Name: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomGestureCollectionItem(AObj).Name
  else
    TCustomGestureCollectionItem(AObj).Name := string(AArgs[0]);
end;

function TCustomGestureCollectionItem_Action_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Action: TBasicAction read <getter> write <setter>;

  if IsGet then
    Result := TBasicAction_sw.ToVar(TCustomGestureCollectionItem(AObj).Action)
  else
    TCustomGestureCollectionItem(AObj).Action := TBasicAction_sw.FromVar(
      AArgs[0]);
end;

class function TCustomGestureCollectionItem_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGestureCollectionItem';
end;

class function TCustomGestureCollectionItem_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGestureCollectionItem;
end;

class procedure TCustomGestureCollectionItem_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Deviation', TCustomGestureCollectionItem_Deviation_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ErrorMargin', TCustomGestureCollectionItem_ErrorMargin_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('GestureID', TCustomGestureCollectionItem_GestureID_si, TGestureID_sw, True, True, 0, False, False);
  AData.AddProperty('GestureType', TCustomGestureCollectionItem_GestureType_si, TGestureType_sw, True, False, 0, False, False);
  AData.AddProperty('Options', TCustomGestureCollectionItem_Options_si, TGestureOptions_sw, True, True, 0, False, False);
  AData.AddProperty('Name', TCustomGestureCollectionItem_Name_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Action', TCustomGestureCollectionItem_Action_si, TBasicAction_sw, True, True, 0, False, False);
end;

class function TCustomGestureCollectionItem_sw.ToVar(
  const AValue: TCustomGestureCollectionItem): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGestureCollectionItem_sw.FromVar(
  const AValue: OleVariant): TCustomGestureCollectionItem;
begin
  Result := TCustomGestureCollectionItem(ConvFromVar(AValue, 
    TCustomGestureCollectionItem));
end;

class function TCustomGestureCollectionItem_sw.ClassToVar(
  AClass: TCustomGestureCollectionItem_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGestureCollectionItem_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGestureCollectionItem_sc;
begin
  Result := TCustomGestureCollectionItem_sc(ConvClsFromVar(AClass, 
    TCustomGestureCollectionItem));
end;

{ TCustomGestureCollection_sw }

function TCustomGestureCollection_AddGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddGesture: TCustomGestureCollectionItem;

  Result := TCustomGestureCollectionItem_sw.ToVar(TCustomGestureCollection(
    AObj).AddGesture());
end;

function TCustomGestureCollection_FindGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FindGesture(...); overload;

  Result := TCustomGestureCollectionItem_sw.ToVar(TCustomGestureCollection(
    AObj).FindGesture(TGestureID_sw.FromVar(AArgs[0])));
end;

function TCustomGestureCollection_GetUniqueGestureID_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetUniqueGestureID: TGestureID;

  Result := TGestureID_sw.ToVar(TCustomGestureCollection(AObj).
    GetUniqueGestureID());
end;

function TCustomGestureCollection_RemoveGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveGesture(AGestureID: TGestureID);

  TCustomGestureCollection(AObj).RemoveGesture(TGestureID_sw.FromVar(AArgs[0]));
end;

function TCustomGestureCollection_GestureManager_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GestureManager: TCustomGestureManager read <gett...

  Result := TCustomGestureManager_sw.ToVar(TCustomGestureCollection(AObj).
    GestureManager);
end;

function TCustomGestureCollection_Items_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Items[Index: Integer]: TCustomGestureCollectionI...

  if IsGet then
    Result := TCustomGestureCollectionItem_sw.ToVar(TCustomGestureCollection(
      AObj).Items[Integer(AArgs[0])])
  else
    TCustomGestureCollection(AObj).Items[Integer(AArgs[0])] := 
      TCustomGestureCollectionItem_sw.FromVar(AArgs[1]);
end;

class function TCustomGestureCollection_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGestureCollection';
end;

class function TCustomGestureCollection_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGestureCollection;
end;

class procedure TCustomGestureCollection_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddGesture', TCustomGestureCollection_AddGesture_si, TCustomGestureCollectionItem_sw, 0, False);
  AData.AddFunction('FindGesture', TCustomGestureCollection_FindGesture_si, nil, 1, False);
  AData.AddFunction('GetUniqueGestureID', TCustomGestureCollection_GetUniqueGestureID_si, TGestureID_sw, 0, False);
  AData.AddProcedure('RemoveGesture', TCustomGestureCollection_RemoveGesture_si, 1, False);
  AData.AddProperty('GestureManager', TCustomGestureCollection_GestureManager_si, TCustomGestureManager_sw, True, False, 0, False, False);
  AData.AddProperty('Items', TCustomGestureCollection_Items_si, TCustomGestureCollectionItem_sw, True, True, 1, False, True);
end;

class function TCustomGestureCollection_sw.ToVar(
  const AValue: TCustomGestureCollection): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGestureCollection_sw.FromVar(
  const AValue: OleVariant): TCustomGestureCollection;
begin
  Result := TCustomGestureCollection(ConvFromVar(AValue, 
    TCustomGestureCollection));
end;

class function TCustomGestureCollection_sw.ClassToVar(
  AClass: TCustomGestureCollection_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGestureCollection_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGestureCollection_sc;
begin
  Result := TCustomGestureCollection_sc(ConvClsFromVar(AClass, 
    TCustomGestureCollection));
end;

{ TCustomGestureManager_sw }

function TCustomGestureManager_AddRecordedGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function AddRecordedGesture(...); overload;

  Result := TGestureID_sw.ToVar(TCustomGestureManager(AObj).AddRecordedGesture(
    TCustomGestureCollectionItem_sw.FromVar(AArgs[0])));
end;

function TCustomGestureManager_FindCustomGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FindCustomGesture(...); overload;

  Result := TCustomGestureCollectionItem_sw.ToVar(TCustomGestureManager(AObj).
    FindCustomGesture(TGestureID_sw.FromVar(AArgs[0])));
end;

function TCustomGestureManager_FindGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FindGesture(...); overload;

  Result := TCustomGestureCollectionItem_sw.ToVar(TCustomGestureManager(AObj).
    FindGesture(TControl_sw.FromVar(AArgs[0]), TGestureID_sw.FromVar(AArgs[1])));
end;

function TCustomGestureManager_RegisterControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RegisterControl(AControl: TControl);

  TCustomGestureManager(AObj).RegisterControl(TControl_sw.FromVar(AArgs[0]));
end;

function TCustomGestureManager_RemoveRecordedGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function RemoveRecordedGesture(...); overload;

  TCustomGestureManager(AObj).RemoveRecordedGesture(TGestureID_sw.FromVar(
    AArgs[0]));
end;

function TCustomGestureManager_SelectGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SelectGesture(...); overload;

  Result := TCustomGestureManager(AObj).SelectGesture(TControl_sw.FromVar(
    AArgs[0]), TGestureID_sw.FromVar(AArgs[1]));
end;

function TCustomGestureManager_UnregisterControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnregisterControl(AControl: TControl);

  TCustomGestureManager(AObj).UnregisterControl(TControl_sw.FromVar(AArgs[0]));
end;

function TCustomGestureManager_UnselectGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnselectGesture(AControl: TControl; AGestureID:...

  TCustomGestureManager(AObj).UnselectGesture(TControl_sw.FromVar(AArgs[0]), 
    TGestureID_sw.FromVar(AArgs[1]));
end;

function TCustomGestureManager_StandardGestures_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StandardGestures[AControl: TControl]: TStandardG...

  if IsGet then
    Result := TStandardGestures_sw.ToVar(TCustomGestureManager(AObj).
      StandardGestures[TControl_sw.FromVar(AArgs[0])])
  else
    TCustomGestureManager(AObj).StandardGestures[TControl_sw.FromVar(AArgs[0])] 
      := TStandardGestures_sw.FromVar(AArgs[1]);
end;

class function TCustomGestureManager_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGestureManager';
end;

class function TCustomGestureManager_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGestureManager;
end;

class procedure TCustomGestureManager_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('AddRecordedGesture', TCustomGestureManager_AddRecordedGesture_si, nil, 1, False);
  AData.AddFunction('FindCustomGesture', TCustomGestureManager_FindCustomGesture_si, nil, 1, False);
  AData.AddFunction('FindGesture', TCustomGestureManager_FindGesture_si, nil, 2, False);
  AData.AddProcedure('RegisterControl', TCustomGestureManager_RegisterControl_si, 1, False);
  AData.AddProcedure('RemoveRecordedGesture', TCustomGestureManager_RemoveRecordedGesture_si, 1, False);
  AData.AddFunction('SelectGesture', TCustomGestureManager_SelectGesture_si, nil, 2, False);
  AData.AddProcedure('UnregisterControl', TCustomGestureManager_UnregisterControl_si, 1, False);
  AData.AddProcedure('UnselectGesture', TCustomGestureManager_UnselectGesture_si, 2, False);
  AData.AddProperty('StandardGestures', TCustomGestureManager_StandardGestures_si, TStandardGestures_sw, True, True, 1, False, False);
end;

class function TCustomGestureManager_sw.ToVar(
  const AValue: TCustomGestureManager): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGestureManager_sw.FromVar(
  const AValue: OleVariant): TCustomGestureManager;
begin
  Result := TCustomGestureManager(ConvFromVar(AValue, TCustomGestureManager));
end;

class function TCustomGestureManager_sw.ClassToVar(
  AClass: TCustomGestureManager_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGestureManager_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGestureManager_sc;
begin
  Result := TCustomGestureManager_sc(ConvClsFromVar(AClass, 
    TCustomGestureManager));
end;

{ TCustomGestureEngine_sw }

function TCustomGestureEngine_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AControl: TWinControl);

  Result := TCustomGestureEngine_sw.ToVar(TCustomGestureEngine_sc(AObj).Create(
    TWinControl_sw.FromVar(AArgs[0])));
end;

function TCustomGestureEngine_Notification_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Notification(const Message: TMessage);

  TCustomGestureEngine(AObj).Notification(TMessage_sw.FromVar(AArgs[0]));
end;

function TCustomGestureEngine_Supported_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function Supported: Boolean;

  Result := TCustomGestureEngine_sc(AObj).Supported();
end;

function TCustomGestureEngine_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomGestureEngine(AObj).Active
  else
    TCustomGestureEngine(AObj).Active := Boolean(AArgs[0]);
end;

class function TCustomGestureEngine_sw.GetTypeName: WideString;
begin
  Result := 'TCustomGestureEngine';
end;

class function TCustomGestureEngine_sw.GetWrappedClass: TClass;
begin
  Result := TCustomGestureEngine;
end;

class procedure TCustomGestureEngine_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('Notification', TCustomGestureEngine_Notification_si, 1, False);
  AData.AddProperty('Active', TCustomGestureEngine_Active_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TCustomGestureEngine_Create_si, 1, False);
  AData.AddClassFunction('Supported', TCustomGestureEngine_Supported_si, Boolean_sw, 0, False);
end;

class function TCustomGestureEngine_sw.ToVar(
  const AValue: TCustomGestureEngine): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomGestureEngine_sw.FromVar(
  const AValue: OleVariant): TCustomGestureEngine;
begin
  Result := TCustomGestureEngine(ConvFromVar(AValue, TCustomGestureEngine));
end;

class function TCustomGestureEngine_sw.ClassToVar(
  AClass: TCustomGestureEngine_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomGestureEngine_sw.ClassFromVar(
  const AClass: OleVariant): TCustomGestureEngine_sc;
begin
  Result := TCustomGestureEngine_sc(ConvClsFromVar(AClass, 
    TCustomGestureEngine));
end;

{ TTouchProperty_sw }

class function TTouchProperty_sw.GetTypeName: WideString;
begin
  Result := 'TTouchProperty';
end;

class procedure TTouchProperty_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'tpInteractiveGestures'; Value: Integer({$IFDEF LMDSCT_12}TTouchProperty.{$ENDIF}tpInteractiveGestures)),
    (Name: 'tpInteractiveGestureOptions'; Value: Integer({$IFDEF LMDSCT_12}TTouchProperty.{$ENDIF}tpInteractiveGestureOptions)),
    (Name: 'tpParentTabletOptions'; Value: Integer({$IFDEF LMDSCT_12}TTouchProperty.{$ENDIF}tpParentTabletOptions)),
    (Name: 'tpTabletOptions'; Value: Integer({$IFDEF LMDSCT_12}TTouchProperty.{$ENDIF}tpTabletOptions))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TTouchProperty_sw.ToVar(
  const AValue: TTouchProperty): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTouchProperty_sw.FromVar(
  const AValue: OleVariant): TTouchProperty;
begin
  Result := TTouchProperty(Integer(AValue));
end;

{ TCustomTouchManager_sw }

function TCustomTouchManager_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(AControl: TControl);

  Result := TCustomTouchManager_sw.ToVar(TCustomTouchManager_sc(AObj).Create(
    TControl_sw.FromVar(AArgs[0])));
end;

function TCustomTouchManager_ChangeNotification_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ChangeNotification(AControl: TControl);

  TCustomTouchManager(AObj).ChangeNotification(TControl_sw.FromVar(AArgs[0]));
end;

function TCustomTouchManager_FindGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function FindGesture(...); overload;

  Result := TCustomGestureCollectionItem_sw.ToVar(TCustomTouchManager(AObj).
    FindGesture(TGestureID_sw.FromVar(AArgs[0])));
end;

function TCustomTouchManager_RemoveChangeNotification_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveChangeNotification(AControl: TControl);

  TCustomTouchManager(AObj).RemoveChangeNotification(TControl_sw.FromVar(
    AArgs[0]));
end;

function TCustomTouchManager_SelectGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function SelectGesture(...); overload;

  Result := TCustomTouchManager(AObj).SelectGesture(TGestureID_sw.FromVar(
    AArgs[0]));
end;

function TCustomTouchManager_UnselectGesture_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnselectGesture(AGestureID: TGestureID);

  TCustomTouchManager(AObj).UnselectGesture(TGestureID_sw.FromVar(AArgs[0]));
end;

function TCustomTouchManager_GestureEngine_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GestureEngine: TCustomGestureEngine read <getter...

  if IsGet then
    Result := TCustomGestureEngine_sw.ToVar(TCustomTouchManager(AObj).
      GestureEngine)
  else
    TCustomTouchManager(AObj).GestureEngine := TCustomGestureEngine_sw.FromVar(
      AArgs[0]);
end;

function TCustomTouchManager_GestureManager_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GestureManager: TCustomGestureManager read <gett...

  if IsGet then
    Result := TCustomGestureManager_sw.ToVar(TCustomTouchManager(AObj).
      GestureManager)
  else
    TCustomTouchManager(AObj).GestureManager := TCustomGestureManager_sw.
      FromVar(AArgs[0]);
end;

function TCustomTouchManager_InteractiveGestures_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InteractiveGestures: TInteractiveGestures read <...

  if IsGet then
    Result := TInteractiveGestures_sw.ToVar(TCustomTouchManager(AObj).
      InteractiveGestures)
  else
    TCustomTouchManager(AObj).InteractiveGestures := TInteractiveGestures_sw.
      FromVar(AArgs[0]);
end;

function TCustomTouchManager_InteractiveGestureOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InteractiveGestureOptions: TInteractiveGestureOp...

  if IsGet then
    Result := TInteractiveGestureOptions_sw.ToVar(TCustomTouchManager(AObj).
      InteractiveGestureOptions)
  else
    TCustomTouchManager(AObj).InteractiveGestureOptions := 
      TInteractiveGestureOptions_sw.FromVar(AArgs[0]);
end;

function TCustomTouchManager_ParentTabletOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentTabletOptions: Boolean read <getter> write...

  if IsGet then
    Result := TCustomTouchManager(AObj).ParentTabletOptions
  else
    TCustomTouchManager(AObj).ParentTabletOptions := Boolean(AArgs[0]);
end;

function TCustomTouchManager_StandardGestures_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property StandardGestures: TStandardGestures read <getter...

  if IsGet then
    Result := TStandardGestures_sw.ToVar(TCustomTouchManager(AObj).
      StandardGestures)
  else
    TCustomTouchManager(AObj).StandardGestures := TStandardGestures_sw.FromVar(
      AArgs[0]);
end;

function TCustomTouchManager_TabletOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabletOptions: TTabletOptions read <getter> writ...

  if IsGet then
    Result := TTabletOptions_sw.ToVar(TCustomTouchManager(AObj).TabletOptions)
  else
    TCustomTouchManager(AObj).TabletOptions := TTabletOptions_sw.FromVar(
      AArgs[0]);
end;

class function TCustomTouchManager_sw.GetTypeName: WideString;
begin
  Result := 'TCustomTouchManager';
end;

class function TCustomTouchManager_sw.GetWrappedClass: TClass;
begin
  Result := TCustomTouchManager;
end;

class procedure TCustomTouchManager_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ChangeNotification', TCustomTouchManager_ChangeNotification_si, 1, False);
  AData.AddFunction('FindGesture', TCustomTouchManager_FindGesture_si, nil, 1, False);
  AData.AddProcedure('RemoveChangeNotification', TCustomTouchManager_RemoveChangeNotification_si, 1, False);
  AData.AddFunction('SelectGesture', TCustomTouchManager_SelectGesture_si, nil, 1, False);
  AData.AddProcedure('UnselectGesture', TCustomTouchManager_UnselectGesture_si, 1, False);
  AData.AddProperty('GestureEngine', TCustomTouchManager_GestureEngine_si, TCustomGestureEngine_sw, True, True, 0, False, False);
  AData.AddProperty('GestureManager', TCustomTouchManager_GestureManager_si, TCustomGestureManager_sw, True, True, 0, False, False);
  AData.AddProperty('InteractiveGestures', TCustomTouchManager_InteractiveGestures_si, TInteractiveGestures_sw, True, True, 0, False, False);
  AData.AddProperty('InteractiveGestureOptions', TCustomTouchManager_InteractiveGestureOptions_si, TInteractiveGestureOptions_sw, True, True, 0, False, False);
  AData.AddProperty('ParentTabletOptions', TCustomTouchManager_ParentTabletOptions_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('StandardGestures', TCustomTouchManager_StandardGestures_si, TStandardGestures_sw, True, True, 0, False, False);
  AData.AddProperty('TabletOptions', TCustomTouchManager_TabletOptions_si, TTabletOptions_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TCustomTouchManager_Create_si, 1, False);
end;

class function TCustomTouchManager_sw.ToVar(
  const AValue: TCustomTouchManager): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomTouchManager_sw.FromVar(
  const AValue: OleVariant): TCustomTouchManager;
begin
  Result := TCustomTouchManager(ConvFromVar(AValue, TCustomTouchManager));
end;

class function TCustomTouchManager_sw.ClassToVar(
  AClass: TCustomTouchManager_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomTouchManager_sw.ClassFromVar(
  const AClass: OleVariant): TCustomTouchManager_sc;
begin
  Result := TCustomTouchManager_sc(ConvClsFromVar(AClass, TCustomTouchManager));
end;

{ TTouchManager_sw }

class function TTouchManager_sw.GetTypeName: WideString;
begin
  Result := 'TTouchManager';
end;

class function TTouchManager_sw.GetWrappedClass: TClass;
begin
  Result := TTouchManager;
end;

class procedure TTouchManager_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('GestureManager', False);
  AData.AddPropertyRedecl('InteractiveGestures', False);
  AData.AddPropertyRedecl('InteractiveGestureOptions', False);
  AData.AddPropertyRedecl('ParentTabletOptions', False);
  AData.AddPropertyRedecl('TabletOptions', False);
end;

class function TTouchManager_sw.ToVar(const AValue: TTouchManager): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTouchManager_sw.FromVar(
  const AValue: OleVariant): TTouchManager;
begin
  Result := TTouchManager(ConvFromVar(AValue, TTouchManager));
end;

class function TTouchManager_sw.ClassToVar(
  AClass: TTouchManager_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTouchManager_sw.ClassFromVar(
  const AClass: OleVariant): TTouchManager_sc;
begin
  Result := TTouchManager_sc(ConvClsFromVar(AClass, TTouchManager));
end;

{ TKeyPressEvent_sh }

function TKeyPressEvent_sh.GetHandler: TMethod;
var
  hdr: TKeyPressEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TKeyPressEvent_sh.Handler(Sender: TObject; var Key: Char);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Key: Char) of object

  v_1 := Key;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Key := Char(Integer(v_1));
end;

{ TKeyPressEvent_sw }

class function TKeyPressEvent_sw.GetTypeName: WideString;
begin
  Result := 'TKeyPressEvent';
end;

class function TKeyPressEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TKeyPressEvent_sh;
end;

class function TKeyPressEvent_sw.ToVar(
  const AValue: TKeyPressEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TKeyPressEvent_sw.FromVar(
  const AValue: OleVariant): TKeyPressEvent;
begin
  Result := TKeyPressEvent(ConvFromVar(AValue));
end;

class function TKeyPressEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TKeyPressEvent;
var
  hdlr: TKeyPressEvent_sh;
begin
  hdlr   := TKeyPressEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TKeyPressEvent_sw));
  Result := hdlr.Handler;
end;

{ TDragOverEvent_sh }

function TDragOverEvent_sh.GetHandler: TMethod;
var
  hdr: TDragOverEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDragOverEvent_sh.Handler(Sender: TObject; Source: TObject;
  X: Integer; Y: Integer; State: TDragState; var Accept: Boolean);
var
  args: array[0..5] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Source: TObject; X: Integer; ...

  v_1 := Accept;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TObject_sw.ToVar(Source);
  args[2] := X;
  args[3] := Y;
  args[4] := TDragState_sw.ToVar(State);
  args[5] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Accept := Boolean(v_1);
end;

{ TDragOverEvent_sw }

class function TDragOverEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDragOverEvent';
end;

class function TDragOverEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDragOverEvent_sh;
end;

class function TDragOverEvent_sw.ToVar(
  const AValue: TDragOverEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDragOverEvent_sw.FromVar(
  const AValue: OleVariant): TDragOverEvent;
begin
  Result := TDragOverEvent(ConvFromVar(AValue));
end;

class function TDragOverEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDragOverEvent;
var
  hdlr: TDragOverEvent_sh;
begin
  hdlr   := TDragOverEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDragOverEvent_sw));
  Result := hdlr.Handler;
end;

{ TDragDropEvent_sh }

function TDragDropEvent_sh.GetHandler: TMethod;
var
  hdr: TDragDropEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDragDropEvent_sh.Handler(Sender: TObject; Source: TObject;
  X: Integer; Y: Integer);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; Source: TObject; X: Integer; ...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TObject_sw.ToVar(Source);
  args[2] := X;
  args[3] := Y;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDragDropEvent_sw }

class function TDragDropEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDragDropEvent';
end;

class function TDragDropEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDragDropEvent_sh;
end;

class function TDragDropEvent_sw.ToVar(
  const AValue: TDragDropEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDragDropEvent_sw.FromVar(
  const AValue: OleVariant): TDragDropEvent;
begin
  Result := TDragDropEvent(ConvFromVar(AValue));
end;

class function TDragDropEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDragDropEvent;
var
  hdlr: TDragDropEvent_sh;
begin
  hdlr   := TDragDropEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDragDropEvent_sw));
  Result := hdlr.Handler;
end;

{ TStartDragEvent_sh }

function TStartDragEvent_sh.GetHandler: TMethod;
var
  hdr: TStartDragEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TStartDragEvent_sh.Handler(Sender: TObject;
  var DragObject: TDragObject);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var DragObject: TDragObject) ...

  v_1 := TDragObject_sw.ToVar(DragObject);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DragObject := TDragObject_sw.FromVar(v_1);
end;

{ TStartDragEvent_sw }

class function TStartDragEvent_sw.GetTypeName: WideString;
begin
  Result := 'TStartDragEvent';
end;

class function TStartDragEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TStartDragEvent_sh;
end;

class function TStartDragEvent_sw.ToVar(
  const AValue: TStartDragEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TStartDragEvent_sw.FromVar(
  const AValue: OleVariant): TStartDragEvent;
begin
  Result := TStartDragEvent(ConvFromVar(AValue));
end;

class function TStartDragEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TStartDragEvent;
var
  hdlr: TStartDragEvent_sh;
begin
  hdlr   := TStartDragEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TStartDragEvent_sw));
  Result := hdlr.Handler;
end;

{ TEndDragEvent_sh }

function TEndDragEvent_sh.GetHandler: TMethod;
var
  hdr: TEndDragEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TEndDragEvent_sh.Handler(Sender: TObject; Target: TObject; X: Integer;
  Y: Integer);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; Target: TObject; X: Integer; ...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TObject_sw.ToVar(Target);
  args[2] := X;
  args[3] := Y;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TEndDragEvent_sw }

class function TEndDragEvent_sw.GetTypeName: WideString;
begin
  Result := 'TEndDragEvent';
end;

class function TEndDragEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TEndDragEvent_sh;
end;

class function TEndDragEvent_sw.ToVar(const AValue: TEndDragEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TEndDragEvent_sw.FromVar(
  const AValue: OleVariant): TEndDragEvent;
begin
  Result := TEndDragEvent(ConvFromVar(AValue));
end;

class function TEndDragEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TEndDragEvent;
var
  hdlr: TEndDragEvent_sh;
begin
  hdlr   := TEndDragEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TEndDragEvent_sw));
  Result := hdlr.Handler;
end;

{ TDockDropEvent_sh }

function TDockDropEvent_sh.GetHandler: TMethod;
var
  hdr: TDockDropEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDockDropEvent_sh.Handler(Sender: TObject; Source: TDragDockObject;
  X: Integer; Y: Integer);
var
  args: array[0..3] of OleVariant;
begin
  // procedure (Sender: TObject; Source: TDragDockObject; X: I...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDragDockObject_sw.ToVar(Source);
  args[2] := X;
  args[3] := Y;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TDockDropEvent_sw }

class function TDockDropEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDockDropEvent';
end;

class function TDockDropEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDockDropEvent_sh;
end;

class function TDockDropEvent_sw.ToVar(
  const AValue: TDockDropEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDockDropEvent_sw.FromVar(
  const AValue: OleVariant): TDockDropEvent;
begin
  Result := TDockDropEvent(ConvFromVar(AValue));
end;

class function TDockDropEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDockDropEvent;
var
  hdlr: TDockDropEvent_sh;
begin
  hdlr   := TDockDropEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDockDropEvent_sw));
  Result := hdlr.Handler;
end;

{ TDockOverEvent_sh }

function TDockOverEvent_sh.GetHandler: TMethod;
var
  hdr: TDockOverEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TDockOverEvent_sh.Handler(Sender: TObject; Source: TDragDockObject;
  X: Integer; Y: Integer; State: TDragState; var Accept: Boolean);
var
  args: array[0..5] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Source: TDragDockObject; X: I...

  v_1 := Accept;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TDragDockObject_sw.ToVar(Source);
  args[2] := X;
  args[3] := Y;
  args[4] := TDragState_sw.ToVar(State);
  args[5] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Accept := Boolean(v_1);
end;

{ TDockOverEvent_sw }

class function TDockOverEvent_sw.GetTypeName: WideString;
begin
  Result := 'TDockOverEvent';
end;

class function TDockOverEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TDockOverEvent_sh;
end;

class function TDockOverEvent_sw.ToVar(
  const AValue: TDockOverEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TDockOverEvent_sw.FromVar(
  const AValue: OleVariant): TDockOverEvent;
begin
  Result := TDockOverEvent(ConvFromVar(AValue));
end;

class function TDockOverEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TDockOverEvent;
var
  hdlr: TDockOverEvent_sh;
begin
  hdlr   := TDockOverEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TDockOverEvent_sw));
  Result := hdlr.Handler;
end;

{ TUnDockEvent_sh }

function TUnDockEvent_sh.GetHandler: TMethod;
var
  hdr: TUnDockEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TUnDockEvent_sh.Handler(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Client: TControl; NewTarget: ...

  v_1 := Allow;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Client);
  args[2] := TWinControl_sw.ToVar(NewTarget);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Allow := Boolean(v_1);
end;

{ TUnDockEvent_sw }

class function TUnDockEvent_sw.GetTypeName: WideString;
begin
  Result := 'TUnDockEvent';
end;

class function TUnDockEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TUnDockEvent_sh;
end;

class function TUnDockEvent_sw.ToVar(const AValue: TUnDockEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TUnDockEvent_sw.FromVar(const AValue: OleVariant): TUnDockEvent;
begin
  Result := TUnDockEvent(ConvFromVar(AValue));
end;

class function TUnDockEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TUnDockEvent;
var
  hdlr: TUnDockEvent_sh;
begin
  hdlr   := TUnDockEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TUnDockEvent_sw));
  Result := hdlr.Handler;
end;

{ TStartDockEvent_sh }

function TStartDockEvent_sh.GetHandler: TMethod;
var
  hdr: TStartDockEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TStartDockEvent_sh.Handler(Sender: TObject;
  var DragObject: TDragDockObject);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var DragObject: TDragDockObje...

  v_1 := TDragDockObject_sw.ToVar(DragObject);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DragObject := TDragDockObject_sw.FromVar(v_1);
end;

{ TStartDockEvent_sw }

class function TStartDockEvent_sw.GetTypeName: WideString;
begin
  Result := 'TStartDockEvent';
end;

class function TStartDockEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TStartDockEvent_sh;
end;

class function TStartDockEvent_sw.ToVar(
  const AValue: TStartDockEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TStartDockEvent_sw.FromVar(
  const AValue: OleVariant): TStartDockEvent;
begin
  Result := TStartDockEvent(ConvFromVar(AValue));
end;

class function TStartDockEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TStartDockEvent;
var
  hdlr: TStartDockEvent_sh;
begin
  hdlr   := TStartDockEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TStartDockEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetSiteInfoEvent_sh }

function TGetSiteInfoEvent_sh.GetHandler: TMethod;
var
  hdr: TGetSiteInfoEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetSiteInfoEvent_sh.Handler(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (Sender: TObject; DockClient: TControl; var Inf...

  v_1 := TRect_sw.ToVar(InfluenceRect);
  v_2 := CanDock;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(DockClient);
  args[2] := MakeVarRef(v_1);
  args[3] := TPoint_sw.ToVar(MousePos);
  args[4] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  InfluenceRect := TRect_sw.FromVar(v_1);
  CanDock := Boolean(v_2);
end;

{ TGetSiteInfoEvent_sw }

class function TGetSiteInfoEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetSiteInfoEvent';
end;

class function TGetSiteInfoEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetSiteInfoEvent_sh;
end;

class function TGetSiteInfoEvent_sw.ToVar(
  const AValue: TGetSiteInfoEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetSiteInfoEvent_sw.FromVar(
  const AValue: OleVariant): TGetSiteInfoEvent;
begin
  Result := TGetSiteInfoEvent(ConvFromVar(AValue));
end;

class function TGetSiteInfoEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TGetSiteInfoEvent;
var
  hdlr: TGetSiteInfoEvent_sh;
begin
  hdlr   := TGetSiteInfoEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetSiteInfoEvent_sw));
  Result := hdlr.Handler;
end;

{ TCanResizeEvent_sh }

function TCanResizeEvent_sh.GetHandler: TMethod;
var
  hdr: TCanResizeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCanResizeEvent_sh.Handler(Sender: TObject; var NewWidth: Integer;
  var NewHeight: Integer; var Resize: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
begin
  // procedure (Sender: TObject; var NewWidth: Integer; var Ne...

  v_1 := NewWidth;
  v_2 := NewHeight;
  v_3 := Resize;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  args[2] := MakeVarRef(v_2);
  args[3] := MakeVarRef(v_3);
  Self.Owner.RunProc(Self.ProcName, args);
  NewWidth := Integer(v_1);
  NewHeight := Integer(v_2);
  Resize := Boolean(v_3);
end;

{ TCanResizeEvent_sw }

class function TCanResizeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCanResizeEvent';
end;

class function TCanResizeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCanResizeEvent_sh;
end;

class function TCanResizeEvent_sw.ToVar(
  const AValue: TCanResizeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCanResizeEvent_sw.FromVar(
  const AValue: OleVariant): TCanResizeEvent;
begin
  Result := TCanResizeEvent(ConvFromVar(AValue));
end;

class function TCanResizeEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TCanResizeEvent;
var
  hdlr: TCanResizeEvent_sh;
begin
  hdlr   := TCanResizeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TCanResizeEvent_sw));
  Result := hdlr.Handler;
end;

{ TConstrainedResizeEvent_sh }

function TConstrainedResizeEvent_sh.GetHandler: TMethod;
var
  hdr: TConstrainedResizeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TConstrainedResizeEvent_sh.Handler(Sender: TObject;
  var MinWidth: Integer; var MinHeight: Integer; var MaxWidth: Integer;
  var MaxHeight: Integer);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
  v_4: OleVariant;
begin
  // procedure (Sender: TObject; var MinWidth: Integer; var Mi...

  v_1 := MinWidth;
  v_2 := MinHeight;
  v_3 := MaxWidth;
  v_4 := MaxHeight;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  args[2] := MakeVarRef(v_2);
  args[3] := MakeVarRef(v_3);
  args[4] := MakeVarRef(v_4);
  Self.Owner.RunProc(Self.ProcName, args);
  MinWidth := Integer(v_1);
  MinHeight := Integer(v_2);
  MaxWidth := Integer(v_3);
  MaxHeight := Integer(v_4);
end;

{ TConstrainedResizeEvent_sw }

class function TConstrainedResizeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TConstrainedResizeEvent';
end;

class function TConstrainedResizeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TConstrainedResizeEvent_sh;
end;

class function TConstrainedResizeEvent_sw.ToVar(
  const AValue: TConstrainedResizeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TConstrainedResizeEvent_sw.FromVar(
  const AValue: OleVariant): TConstrainedResizeEvent;
begin
  Result := TConstrainedResizeEvent(ConvFromVar(AValue));
end;

class function TConstrainedResizeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TConstrainedResizeEvent;
var
  hdlr: TConstrainedResizeEvent_sh;
begin
  hdlr   := TConstrainedResizeEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TConstrainedResizeEvent_sw));
  Result := hdlr.Handler;
end;

{ TContextPopupEvent_sh }

function TContextPopupEvent_sh.GetHandler: TMethod;
var
  hdr: TContextPopupEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TContextPopupEvent_sh.Handler(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; MousePos: TPoint; var Handled...

  v_1 := Handled;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TPoint_sw.ToVar(MousePos);
  args[2] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handled := Boolean(v_1);
end;

{ TContextPopupEvent_sw }

class function TContextPopupEvent_sw.GetTypeName: WideString;
begin
  Result := 'TContextPopupEvent';
end;

class function TContextPopupEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TContextPopupEvent_sh;
end;

class function TContextPopupEvent_sw.ToVar(
  const AValue: TContextPopupEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TContextPopupEvent_sw.FromVar(
  const AValue: OleVariant): TContextPopupEvent;
begin
  Result := TContextPopupEvent(ConvFromVar(AValue));
end;

class function TContextPopupEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TContextPopupEvent;
var
  hdlr: TContextPopupEvent_sh;
begin
  hdlr   := TContextPopupEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TContextPopupEvent_sw));
  Result := hdlr.Handler;
end;

{ TDockOrientation_sw }

class function TDockOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TDockOrientation';
end;

class procedure TDockOrientation_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'doNoOrient'; Value: Integer({$IFDEF LMDSCT_12}TDockOrientation.{$ENDIF}doNoOrient)),
    (Name: 'doHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TDockOrientation.{$ENDIF}doHorizontal)),
    (Name: 'doVertical'; Value: Integer({$IFDEF LMDSCT_12}TDockOrientation.{$ENDIF}doVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TDockOrientation_sw.ToVar(
  const AValue: TDockOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDockOrientation_sw.FromVar(
  const AValue: OleVariant): TDockOrientation;
begin
  Result := TDockOrientation(Integer(AValue));
end;

{ TControl_sw }

function TControl_ActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActionLink: TControlActionLink read <g...

  if IsGet then
    Result := TControlActionLink_sw.ToVar(TControl_sacc(TControl(AObj)).
      ActionLink)
  else
    TControl_sacc(TControl(AObj)).ActionLink := TControlActionLink_sw.FromVar(
      AArgs[0]);
end;

function TControl_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoSize: Boolean read <getter> write ...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).AutoSize
  else
    TControl_sacc(TControl(AObj)).AutoSize := Boolean(AArgs[0]);
end;

function TControl_Caption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Caption: TCaption read <getter> write ...

  if IsGet then
    Result := TCaption_sw.ToVar(TControl_sacc(TControl(AObj)).Caption)
  else
    TControl_sacc(TControl(AObj)).Caption := TCaption_sw.FromVar(AArgs[0]);
end;

function TControl_DesktopFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DesktopFont: Boolean read <getter> wri...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).DesktopFont
  else
    TControl_sacc(TControl(AObj)).DesktopFont := Boolean(AArgs[0]);
end;

function TControl_DragKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DragKind: TDragKind read <getter> writ...

  if IsGet then
    Result := TDragKind_sw.ToVar(TControl_sacc(TControl(AObj)).DragKind)
  else
    TControl_sacc(TControl(AObj)).DragKind := TDragKind_sw.FromVar(AArgs[0]);
end;

function TControl_DragCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DragCursor: TCursor read <getter> writ...

  if IsGet then
    Result := TCursor_sw.ToVar(TControl_sacc(TControl(AObj)).DragCursor)
  else
    TControl_sacc(TControl(AObj)).DragCursor := TCursor_sw.FromVar(AArgs[0]);
end;

function TControl_DragMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DragMode: TDragMode read <getter> writ...

  if IsGet then
    Result := TDragMode_sw.ToVar(TControl_sacc(TControl(AObj)).DragMode)
  else
    TControl_sacc(TControl(AObj)).DragMode := TDragMode_sw.FromVar(AArgs[0]);
end;

function TControl_IsControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property IsControl: Boolean read <getter> write...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).IsControl
  else
    TControl_sacc(TControl(AObj)).IsControl := Boolean(AArgs[0]);
end;

function TControl_MouseCapture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MouseCapture: Boolean read <getter> wr...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).MouseCapture
  else
    TControl_sacc(TControl(AObj)).MouseCapture := Boolean(AArgs[0]);
end;

function TControl_ParentBiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentBiDiMode: Boolean read <getter> ...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).ParentBiDiMode
  else
    TControl_sacc(TControl(AObj)).ParentBiDiMode := Boolean(AArgs[0]);
end;

function TControl_ParentColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentColor: Boolean read <getter> wri...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).ParentColor
  else
    TControl_sacc(TControl(AObj)).ParentColor := Boolean(AArgs[0]);
end;

function TControl_ParentFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentFont: Boolean read <getter> writ...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).ParentFont
  else
    TControl_sacc(TControl(AObj)).ParentFont := Boolean(AArgs[0]);
end;

function TControl_ParentShowHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentShowHint: Boolean read <getter> ...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).ParentShowHint
  else
    TControl_sacc(TControl(AObj)).ParentShowHint := Boolean(AArgs[0]);
end;

function TControl_PopupMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PopupMenu: TPopupMenu read <getter> wr...

  if IsGet then
    Result := TPopupMenu_sw.ToVar(TControl_sacc(TControl(AObj)).PopupMenu)
  else
    TControl_sacc(TControl(AObj)).PopupMenu := TPopupMenu_sw.FromVar(AArgs[0]);
end;

function TControl_Text_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Text: TCaption read <getter> write <se...

  if IsGet then
    Result := TCaption_sw.ToVar(TControl_sacc(TControl(AObj)).Text)
  else
    TControl_sacc(TControl(AObj)).Text := TCaption_sw.FromVar(AArgs[0]);
end;

function TControl_WheelAccumulator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WheelAccumulator: Integer read <getter...

  if IsGet then
    Result := TControl_sacc(TControl(AObj)).WheelAccumulator
  else
    TControl_sacc(TControl(AObj)).WheelAccumulator := Integer(AArgs[0]);
end;

function TControl_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Color: TColor read <getter> write <set...

  if IsGet then
    Result := TColor_sw.ToVar(TControl_sacc(TControl(AObj)).Color)
  else
    TControl_sacc(TControl(AObj)).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TControl_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TControl_sacc(TControl(AObj)).Font)
  else
    TControl_sacc(TControl(AObj)).Font := TFont_sw.FromVar(AArgs[0]);
end;

function TControl_OnCanResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCanResize: TCanResizeEvent read <get...

  if IsGet then
    Result := TCanResizeEvent_sw.ToVar(TControl_sacc(TControl(AObj)).
      OnCanResize)
  else
    TControl_sacc(TControl(AObj)).OnCanResize := TCanResizeEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnClick: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnClick)
  else
    TControl_sacc(TControl(AObj)).OnClick := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TControl_OnConstrainedResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnConstrainedResize: TConstrainedResiz...

  if IsGet then
    Result := TConstrainedResizeEvent_sw.ToVar(TControl_sacc(TControl(AObj)).
      OnConstrainedResize)
  else
    TControl_sacc(TControl(AObj)).OnConstrainedResize := 
      TConstrainedResizeEvent_sw.FromVar(AArgs[0]);
end;

function TControl_OnContextPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnContextPopup: TContextPopupEvent rea...

  if IsGet then
    Result := TContextPopupEvent_sw.ToVar(TControl_sacc(TControl(AObj)).
      OnContextPopup)
  else
    TControl_sacc(TControl(AObj)).OnContextPopup := TContextPopupEvent_sw.
      FromVar(AArgs[0]);
end;

function TControl_OnDblClick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDblClick: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnDblClick)
  else
    TControl_sacc(TControl(AObj)).OnDblClick := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnDragDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDragDrop: TDragDropEvent read <gette...

  if IsGet then
    Result := TDragDropEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnDragDrop)
  else
    TControl_sacc(TControl(AObj)).OnDragDrop := TDragDropEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnDragOver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDragOver: TDragOverEvent read <gette...

  if IsGet then
    Result := TDragOverEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnDragOver)
  else
    TControl_sacc(TControl(AObj)).OnDragOver := TDragOverEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnEndDock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEndDock: TEndDragEvent read <getter>...

  if IsGet then
    Result := TEndDragEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnEndDock)
  else
    TControl_sacc(TControl(AObj)).OnEndDock := TEndDragEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnEndDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEndDrag: TEndDragEvent read <getter>...

  if IsGet then
    Result := TEndDragEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnEndDrag)
  else
    TControl_sacc(TControl(AObj)).OnEndDrag := TEndDragEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnMouseEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMouseEnter: TNotifyEvent read <gette...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnMouseEnter)
  else
    TControl_sacc(TControl(AObj)).OnMouseEnter := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnMouseLeave_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnMouseLeave: TNotifyEvent read <gette...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnMouseLeave)
  else
    TControl_sacc(TControl(AObj)).OnMouseLeave := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnResize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnResize: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TControl_sacc(TControl(AObj)).OnResize)
  else
    TControl_sacc(TControl(AObj)).OnResize := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TControl_OnStartDock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnStartDock: TStartDockEvent read <get...

  if IsGet then
    Result := TStartDockEvent_sw.ToVar(TControl_sacc(TControl(AObj)).
      OnStartDock)
  else
    TControl_sacc(TControl(AObj)).OnStartDock := TStartDockEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_OnStartDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnStartDrag: TStartDragEvent read <get...

  if IsGet then
    Result := TStartDragEvent_sw.ToVar(TControl_sacc(TControl(AObj)).
      OnStartDrag)
  else
    TControl_sacc(TControl(AObj)).OnStartDrag := TStartDragEvent_sw.FromVar(
      AArgs[0]);
end;

function TControl_BeginDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BeginDrag(Immediate: Boolean; Threshold: Integer);

  case AArgsSize of
    1:
    begin
      TControl(AObj).BeginDrag(Boolean(AArgs[0]));
    end;
    2:
    begin
      TControl(AObj).BeginDrag(Boolean(AArgs[0]), Integer(AArgs[1]));
    end;
  else
    WrongArgCountError('BeginDrag');
  end;
end;

function TControl_BringToFront_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BringToFront;

  TControl(AObj).BringToFront();
end;

function TControl_ClientToScreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ClientToScreen(const Point: TPoint): TPoint;

  Result := TPoint_sw.ToVar(TControl(AObj).ClientToScreen(TPoint_sw.FromVar(
    AArgs[0])));
end;

function TControl_ClientToParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ClientToParent(const Point: TPoint; AParent: TWi...

  case AArgsSize of
    1:
    begin
      Result := TPoint_sw.ToVar(TControl(AObj).ClientToParent(TPoint_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := TPoint_sw.ToVar(TControl(AObj).ClientToParent(TPoint_sw.FromVar(
        AArgs[0]), TWinControl_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('ClientToParent');
  end;
end;

function TControl_Dock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Dock(NewDockSite: TWinControl; ARect: TRect);

  TControl(AObj).Dock(TWinControl_sw.FromVar(AArgs[0]), TRect_sw.FromVar(
    AArgs[1]));
end;

function TControl_Dragging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Dragging: Boolean;

  Result := TControl(AObj).Dragging();
end;

function TControl_DragDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DragDrop(Source: TObject; X: Integer; Y: Integer);

  TControl(AObj).DragDrop(TObject_sw.FromVar(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]));
end;

function TControl_DrawTextBiDiModeFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DrawTextBiDiModeFlags(Flags: Longint): Longint;

  Result := TControl(AObj).DrawTextBiDiModeFlags(Longint(AArgs[0]));
end;

function TControl_DrawTextBiDiModeFlagsReadingOnly_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DrawTextBiDiModeFlagsReadingOnly: Longint;

  Result := TControl(AObj).DrawTextBiDiModeFlagsReadingOnly();
end;

function TControl_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Enabled
  else
    TControl(AObj).Enabled := Boolean(AArgs[0]);
end;

function TControl_EndDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EndDrag(Drop: Boolean);

  TControl(AObj).EndDrag(Boolean(AArgs[0]));
end;

function TControl_GetControlsAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetControlsAlignment: TAlignment;

  Result := TAlignment_sw.ToVar(TControl(AObj).GetControlsAlignment());
end;

function TControl_Hide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Hide;

  TControl(AObj).Hide();
end;

function TControl_InitiateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitiateAction;

  TControl(AObj).InitiateAction();
end;

function TControl_Invalidate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Invalidate;

  TControl(AObj).Invalidate();
end;

function TControl_MouseWheelHandler_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMessage;
begin
  // procedure MouseWheelHandler(var Message: TMessage);

  v_1 := TMessage_sw.FromVar(AArgs[0]);
  TControl(AObj).MouseWheelHandler(v_1);
  AssignRefParam(AArgs[0], TMessage_sw.ToVar(v_1));
end;

function TControl_IsRightToLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsRightToLeft: Boolean;

  Result := TControl(AObj).IsRightToLeft();
end;

function TControl_ManualDock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ManualDock(NewDockSite: TWinControl; DropControl...

  case AArgsSize of
    1:
    begin
      Result := TControl(AObj).ManualDock(TWinControl_sw.FromVar(AArgs[0]));
    end;
    2:
    begin
      Result := TControl(AObj).ManualDock(TWinControl_sw.FromVar(AArgs[0]), 
        TControl_sw.FromVar(AArgs[1]));
    end;
    3:
    begin
      Result := TControl(AObj).ManualDock(TWinControl_sw.FromVar(AArgs[0]), 
        TControl_sw.FromVar(AArgs[1]), TAlign_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('ManualDock');
  end;
end;

function TControl_ManualFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ManualFloat(ScreenPos: TRect): Boolean;

  Result := TControl(AObj).ManualFloat(TRect_sw.FromVar(AArgs[0]));
end;

function TControl_Perform_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Perform(...); overload;

  Result := LRESULT_sw.ToVar(TControl(AObj).Perform(Cardinal(AArgs[0]), 
    WPARAM_sw.FromVar(AArgs[1]), LPARAM_sw.FromVar(AArgs[2])));
end;

function TControl_Refresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Refresh;

  TControl(AObj).Refresh();
end;

function TControl_Repaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Repaint;

  TControl(AObj).Repaint();
end;

function TControl_ReplaceDockedControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ReplaceDockedControl(Control: TControl; NewDockS...

  Result := TControl(AObj).ReplaceDockedControl(TControl_sw.FromVar(AArgs[0]), 
    TWinControl_sw.FromVar(AArgs[1]), TControl_sw.FromVar(AArgs[2]), TAlign_sw.
    FromVar(AArgs[3]));
end;

function TControl_ScreenToClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ScreenToClient(const Point: TPoint): TPoint;

  Result := TPoint_sw.ToVar(TControl(AObj).ScreenToClient(TPoint_sw.FromVar(
    AArgs[0])));
end;

function TControl_ParentToClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ParentToClient(const Point: TPoint; AParent: TWi...

  case AArgsSize of
    1:
    begin
      Result := TPoint_sw.ToVar(TControl(AObj).ParentToClient(TPoint_sw.FromVar(
        AArgs[0])));
    end;
    2:
    begin
      Result := TPoint_sw.ToVar(TControl(AObj).ParentToClient(TPoint_sw.FromVar(
        AArgs[0]), TWinControl_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('ParentToClient');
  end;
end;

function TControl_SendToBack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SendToBack;

  TControl(AObj).SendToBack();
end;

function TControl_SetBounds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth...

  TControl(AObj).SetBounds(Integer(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]), Integer(AArgs[3]));
end;

function TControl_SetDesignVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetDesignVisible(Value: Boolean);

  TControl(AObj).SetDesignVisible(Boolean(AArgs[0]));
end;

function TControl_Show_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Show;

  TControl(AObj).Show();
end;

function TControl_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TControl(AObj).Update();
end;

function TControl_UseRightToLeftAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftAlignment: Boolean;

  Result := TControl(AObj).UseRightToLeftAlignment();
end;

function TControl_UseRightToLeftReading_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftReading: Boolean;

  Result := TControl(AObj).UseRightToLeftReading();
end;

function TControl_UseRightToLeftScrollBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftScrollBar: Boolean;

  Result := TControl(AObj).UseRightToLeftScrollBar();
end;

function TControl_GetTextLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTextLen: Integer;

  Result := TControl(AObj).GetTextLen();
end;

function TControl_Action_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Action: TBasicAction read <getter> write <setter>;

  if IsGet then
    Result := TBasicAction_sw.ToVar(TControl(AObj).Action)
  else
    TControl(AObj).Action := TBasicAction_sw.FromVar(AArgs[0]);
end;

function TControl_Align_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Align: TAlign read <getter> write <setter>;

  if IsGet then
    Result := TAlign_sw.ToVar(TControl(AObj).Align)
  else
    TControl(AObj).Align := TAlign_sw.FromVar(AArgs[0]);
end;

function TControl_Anchors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Anchors: TAnchors read <getter> write <setter>;

  if IsGet then
    Result := TAnchors_sw.ToVar(TControl(AObj).Anchors)
  else
    TControl(AObj).Anchors := TAnchors_sw.FromVar(AArgs[0]);
end;

function TControl_BiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiMode: TBiDiMode read <getter> write <setter>;

  if IsGet then
    Result := TBiDiMode_sw.ToVar(TControl(AObj).BiDiMode)
  else
    TControl(AObj).BiDiMode := TBiDiMode_sw.FromVar(AArgs[0]);
end;

function TControl_BoundsRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BoundsRect: TRect read <getter> write <setter>;

  if IsGet then
    Result := TRect_sw.ToVar(TControl(AObj).BoundsRect)
  else
    TControl(AObj).BoundsRect := TRect_sw.FromVar(AArgs[0]);
end;

function TControl_ClientHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).ClientHeight
  else
    TControl(AObj).ClientHeight := Integer(AArgs[0]);
end;

function TControl_ClientOrigin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientOrigin: TPoint read <getter>;

  Result := TPoint_sw.ToVar(TControl(AObj).ClientOrigin);
end;

function TControl_ClientRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TControl(AObj).ClientRect);
end;

function TControl_ClientWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ClientWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).ClientWidth
  else
    TControl(AObj).ClientWidth := Integer(AArgs[0]);
end;

function TControl_Constraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Constraints: TSizeConstraints read <getter> writ...

  if IsGet then
    Result := TSizeConstraints_sw.ToVar(TControl(AObj).Constraints)
  else
    TControl(AObj).Constraints := TSizeConstraints_sw.FromVar(AArgs[0]);
end;

function TControl_DockOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DockOrientation: TDockOrientation read <getter> ...

  if IsGet then
    Result := TDockOrientation_sw.ToVar(TControl(AObj).DockOrientation)
  else
    TControl(AObj).DockOrientation := TDockOrientation_sw.FromVar(AArgs[0]);
end;

function TControl_ExplicitLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitLeft: Integer read <getter>;

  Result := TControl(AObj).ExplicitLeft;
end;

function TControl_ExplicitTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitTop: Integer read <getter>;

  Result := TControl(AObj).ExplicitTop;
end;

function TControl_ExplicitWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitWidth: Integer read <getter>;

  Result := TControl(AObj).ExplicitWidth;
end;

function TControl_ExplicitHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExplicitHeight: Integer read <getter>;

  Result := TControl(AObj).ExplicitHeight;
end;

function TControl_Floating_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Floating: Boolean read <getter>;

  Result := TControl(AObj).Floating;
end;

function TControl_FloatingDockSiteClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FloatingDockSiteClass: TWinControlClass read <ge...

  if IsGet then
    Result := TWinControlClass_sw.ToVar(TControl(AObj).FloatingDockSiteClass)
  else
    TControl(AObj).FloatingDockSiteClass := TWinControlClass_sw.FromVar(
      AArgs[0]);
end;

function TControl_HostDockSite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HostDockSite: TWinControl read <getter> write <s...

  if IsGet then
    Result := TWinControl_sw.ToVar(TControl(AObj).HostDockSite)
  else
    TControl(AObj).HostDockSite := TWinControl_sw.FromVar(AArgs[0]);
end;

function TControl_LRDockWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LRDockWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).LRDockWidth
  else
    TControl(AObj).LRDockWidth := Integer(AArgs[0]);
end;

function TControl_ShowHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowHint: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).ShowHint
  else
    TControl(AObj).ShowHint := Boolean(AArgs[0]);
end;

function TControl_TBDockHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TBDockHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).TBDockHeight
  else
    TControl(AObj).TBDockHeight := Integer(AArgs[0]);
end;

function TControl_Touch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Touch: TTouchManager read <getter> write <setter>;

  if IsGet then
    Result := TTouchManager_sw.ToVar(TControl(AObj).Touch)
  else
    TControl(AObj).Touch := TTouchManager_sw.FromVar(AArgs[0]);
end;

function TControl_UndockHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UndockHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).UndockHeight
  else
    TControl(AObj).UndockHeight := Integer(AArgs[0]);
end;

function TControl_UndockWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UndockWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).UndockWidth
  else
    TControl(AObj).UndockWidth := Integer(AArgs[0]);
end;

function TControl_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Visible
  else
    TControl(AObj).Visible := Boolean(AArgs[0]);
end;

function TControl_WindowProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WindowProc: TWndMethod read <getter> write <sett...

  if IsGet then
    Result := TWndMethod_sw.ToVar(TControl(AObj).WindowProc)
  else
    TControl(AObj).WindowProc := TWndMethod_sw.FromVar(AArgs[0]);
end;

function TControl_Parent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Parent: TWinControl read <getter> write <setter>;

  if IsGet then
    Result := TWinControl_sw.ToVar(TControl(AObj).Parent)
  else
    TControl(AObj).Parent := TWinControl_sw.FromVar(AArgs[0]);
end;

function TControl_OnGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGesture: TGestureEvent read <getter> write <se...

  if IsGet then
    Result := TGestureEvent_sw.ToVar(TControl(AObj).OnGesture)
  else
    TControl(AObj).OnGesture := TGestureEvent_sw.FromVar(AArgs[0]);
end;

function TControl_AlignWithMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AlignWithMargins: Boolean read <getter> write <s...

  if IsGet then
    Result := TControl(AObj).AlignWithMargins
  else
    TControl(AObj).AlignWithMargins := Boolean(AArgs[0]);
end;

function TControl_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Left
  else
    TControl(AObj).Left := Integer(AArgs[0]);
end;

function TControl_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Top
  else
    TControl(AObj).Top := Integer(AArgs[0]);
end;

function TControl_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Width
  else
    TControl(AObj).Width := Integer(AArgs[0]);
end;

function TControl_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Height
  else
    TControl(AObj).Height := Integer(AArgs[0]);
end;

function TControl_Cursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cursor: TCursor read <getter> write <setter>;

  if IsGet then
    Result := TCursor_sw.ToVar(TControl(AObj).Cursor)
  else
    TControl(AObj).Cursor := TCursor_sw.FromVar(AArgs[0]);
end;

function TControl_Hint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hint: string read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).Hint
  else
    TControl(AObj).Hint := string(AArgs[0]);
end;

function TControl_HelpType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpType: THelpType read <getter> write <setter>;

  if IsGet then
    Result := THelpType_sw.ToVar(TControl(AObj).HelpType)
  else
    TControl(AObj).HelpType := THelpType_sw.FromVar(AArgs[0]);
end;

function TControl_HelpKeyword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpKeyword: string read <getter> write <setter>;

  if IsGet then
    Result := TControl(AObj).HelpKeyword
  else
    TControl(AObj).HelpKeyword := string(AArgs[0]);
end;

function TControl_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TControl(AObj).HelpContext)
  else
    TControl(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TControl_Margins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margins: TMargins read <getter> write <setter>;

  if IsGet then
    Result := TMargins_sw.ToVar(TControl(AObj).Margins)
  else
    TControl(AObj).Margins := TMargins_sw.FromVar(AArgs[0]);
end;

function TControl_CustomHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomHint: TCustomHint read <getter> write <set...

  if IsGet then
    Result := TCustomHint_sw.ToVar(TControl(AObj).CustomHint)
  else
    TControl(AObj).CustomHint := TCustomHint_sw.FromVar(AArgs[0]);
end;

function TControl_ParentCustomHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentCustomHint: Boolean read <getter> write <s...

  if IsGet then
    Result := TControl(AObj).ParentCustomHint
  else
    TControl(AObj).ParentCustomHint := Boolean(AArgs[0]);
end;

class function TControl_sw.GetTypeName: WideString;
begin
  Result := 'TControl';
end;

class function TControl_sw.GetWrappedClass: TClass;
begin
  Result := TControl;
end;

class procedure TControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActionLink', TControl_ActionLink_si, TControlActionLink_sw, True, True, 0, True, False);
  AData.AddProperty('AutoSize', TControl_AutoSize_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('Caption', TControl_Caption_si, TCaption_sw, True, True, 0, True, False);
  AData.AddProperty('DesktopFont', TControl_DesktopFont_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('DragKind', TControl_DragKind_si, TDragKind_sw, True, True, 0, True, False);
  AData.AddProperty('DragCursor', TControl_DragCursor_si, TCursor_sw, True, True, 0, True, False);
  AData.AddProperty('DragMode', TControl_DragMode_si, TDragMode_sw, True, True, 0, True, False);
  AData.AddProperty('IsControl', TControl_IsControl_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('MouseCapture', TControl_MouseCapture_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ParentBiDiMode', TControl_ParentBiDiMode_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ParentColor', TControl_ParentColor_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ParentFont', TControl_ParentFont_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ParentShowHint', TControl_ParentShowHint_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('PopupMenu', TControl_PopupMenu_si, TPopupMenu_sw, True, True, 0, True, False);
  AData.AddProperty('Text', TControl_Text_si, TCaption_sw, True, True, 0, True, False);
  AData.AddProperty('WheelAccumulator', TControl_WheelAccumulator_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('Color', TControl_Color_si, TColor_sw, True, True, 0, True, False);
  AData.AddProperty('Font', TControl_Font_si, TFont_sw, True, True, 0, True, False);
  AData.AddProperty('OnCanResize', TControl_OnCanResize_si, TCanResizeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnClick', TControl_OnClick_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnConstrainedResize', TControl_OnConstrainedResize_si, TConstrainedResizeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnContextPopup', TControl_OnContextPopup_si, TContextPopupEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDblClick', TControl_OnDblClick_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDragDrop', TControl_OnDragDrop_si, TDragDropEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDragOver', TControl_OnDragOver_si, TDragOverEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEndDock', TControl_OnEndDock_si, TEndDragEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEndDrag', TControl_OnEndDrag_si, TEndDragEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnMouseEnter', TControl_OnMouseEnter_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnMouseLeave', TControl_OnMouseLeave_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnResize', TControl_OnResize_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnStartDock', TControl_OnStartDock_si, TStartDockEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnStartDrag', TControl_OnStartDrag_si, TStartDragEvent_sw, True, True, 0, True, False);
  AData.AddProcedure('BeginDrag', TControl_BeginDrag_si, 1, True);
  AData.AddProcedure('BringToFront', TControl_BringToFront_si, 0, False);
  AData.AddFunction('ClientToScreen', TControl_ClientToScreen_si, TPoint_sw, 1, False);
  AData.AddFunction('ClientToParent', TControl_ClientToParent_si, TPoint_sw, 1, True);
  AData.AddProcedure('Dock', TControl_Dock_si, 2, False);
  AData.AddFunction('Dragging', TControl_Dragging_si, Boolean_sw, 0, False);
  AData.AddProcedure('DragDrop', TControl_DragDrop_si, 3, False);
  AData.AddFunction('DrawTextBiDiModeFlags', TControl_DrawTextBiDiModeFlags_si, Longint_sw, 1, False);
  AData.AddFunction('DrawTextBiDiModeFlagsReadingOnly', TControl_DrawTextBiDiModeFlagsReadingOnly_si, Longint_sw, 0, False);
  AData.AddProperty('Enabled', TControl_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProcedure('EndDrag', TControl_EndDrag_si, 1, False);
  AData.AddFunction('GetControlsAlignment', TControl_GetControlsAlignment_si, TAlignment_sw, 0, False);
  AData.AddProcedure('Hide', TControl_Hide_si, 0, False);
  AData.AddProcedure('InitiateAction', TControl_InitiateAction_si, 0, False);
  AData.AddProcedure('Invalidate', TControl_Invalidate_si, 0, False);
  AData.AddProcedure('MouseWheelHandler', TControl_MouseWheelHandler_si, 1, False);
  AData.AddFunction('IsRightToLeft', TControl_IsRightToLeft_si, Boolean_sw, 0, False);
  AData.AddFunction('ManualDock', TControl_ManualDock_si, Boolean_sw, 1, True);
  AData.AddFunction('ManualFloat', TControl_ManualFloat_si, Boolean_sw, 1, False);
  AData.AddFunction('Perform', TControl_Perform_si, nil, 3, False);
  AData.AddProcedure('Refresh', TControl_Refresh_si, 0, False);
  AData.AddProcedure('Repaint', TControl_Repaint_si, 0, False);
  AData.AddFunction('ReplaceDockedControl', TControl_ReplaceDockedControl_si, Boolean_sw, 4, False);
  AData.AddFunction('ScreenToClient', TControl_ScreenToClient_si, TPoint_sw, 1, False);
  AData.AddFunction('ParentToClient', TControl_ParentToClient_si, TPoint_sw, 1, True);
  AData.AddProcedure('SendToBack', TControl_SendToBack_si, 0, False);
  AData.AddProcedure('SetBounds', TControl_SetBounds_si, 4, False);
  AData.AddProcedure('SetDesignVisible', TControl_SetDesignVisible_si, 1, False);
  AData.AddProcedure('Show', TControl_Show_si, 0, False);
  AData.AddProcedure('Update', TControl_Update_si, 0, False);
  AData.AddFunction('UseRightToLeftAlignment', TControl_UseRightToLeftAlignment_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftReading', TControl_UseRightToLeftReading_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftScrollBar', TControl_UseRightToLeftScrollBar_si, Boolean_sw, 0, False);
  AData.AddFunction('GetTextLen', TControl_GetTextLen_si, Integer_sw, 0, False);
  AData.AddProperty('Action', TControl_Action_si, TBasicAction_sw, True, True, 0, False, False);
  AData.AddProperty('Align', TControl_Align_si, TAlign_sw, True, True, 0, False, False);
  AData.AddProperty('Anchors', TControl_Anchors_si, TAnchors_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiMode', TControl_BiDiMode_si, TBiDiMode_sw, True, True, 0, False, False);
  AData.AddProperty('BoundsRect', TControl_BoundsRect_si, TRect_sw, True, True, 0, False, False);
  AData.AddProperty('ClientHeight', TControl_ClientHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ClientOrigin', TControl_ClientOrigin_si, TPoint_sw, True, False, 0, False, False);
  AData.AddProperty('ClientRect', TControl_ClientRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('ClientWidth', TControl_ClientWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Constraints', TControl_Constraints_si, TSizeConstraints_sw, True, True, 0, False, False);
  AData.AddProperty('DockOrientation', TControl_DockOrientation_si, TDockOrientation_sw, True, True, 0, False, False);
  AData.AddProperty('ExplicitLeft', TControl_ExplicitLeft_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitTop', TControl_ExplicitTop_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitWidth', TControl_ExplicitWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ExplicitHeight', TControl_ExplicitHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Floating', TControl_Floating_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('FloatingDockSiteClass', TControl_FloatingDockSiteClass_si, TWinControlClass_sw, True, True, 0, False, False);
  AData.AddProperty('HostDockSite', TControl_HostDockSite_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddProperty('LRDockWidth', TControl_LRDockWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ShowHint', TControl_ShowHint_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('TBDockHeight', TControl_TBDockHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Touch', TControl_Touch_si, TTouchManager_sw, True, True, 0, False, False);
  AData.AddProperty('UndockHeight', TControl_UndockHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('UndockWidth', TControl_UndockWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TControl_Visible_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('WindowProc', TControl_WindowProc_si, TWndMethod_sw, True, True, 0, False, False);
  AData.AddProperty('Parent', TControl_Parent_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddProperty('OnGesture', TControl_OnGesture_si, TGestureEvent_sw, True, True, 0, False, False);
  AData.AddProperty('AlignWithMargins', TControl_AlignWithMargins_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Left', TControl_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TControl_Top_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Width', TControl_Width_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Height', TControl_Height_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Cursor', TControl_Cursor_si, TCursor_sw, True, True, 0, False, False);
  AData.AddProperty('Hint', TControl_Hint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('HelpType', TControl_HelpType_si, THelpType_sw, True, True, 0, False, False);
  AData.AddProperty('HelpKeyword', TControl_HelpKeyword_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('HelpContext', TControl_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddProperty('Margins', TControl_Margins_si, TMargins_sw, True, True, 0, False, False);
  AData.AddProperty('CustomHint', TControl_CustomHint_si, TCustomHint_sw, True, True, 0, False, False);
  AData.AddProperty('ParentCustomHint', TControl_ParentCustomHint_si, Boolean_sw, True, True, 0, False, False);
end;

class function TControl_sw.ToVar(const AValue: TControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControl_sw.FromVar(const AValue: OleVariant): TControl;
begin
  Result := TControl(ConvFromVar(AValue, TControl));
end;

class function TControl_sw.ClassToVar(AClass: TControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControl_sw.ClassFromVar(const AClass: OleVariant): TControl_sc;
begin
  Result := TControl_sc(ConvClsFromVar(AClass, TControl));
end;

{ TControlClass_sw }

class function TControlClass_sw.GetTypeName: WideString;
begin
  Result := 'TControlClass';
end;

class function TControlClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TControl;
end;

class function TControlClass_sw.ToVar(const AValue: TControlClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlClass_sw.FromVar(
  const AValue: OleVariant): TControlClass;
begin
  Result := TControlClass(ConvFromVar(AValue, TControl));
end;

{ TCreateParams_sw }

function TCreateParams_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Style: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(TCreateParams_sw(AObj).FValue.Style)
  else
    TCreateParams_sw(AObj).FValue.Style := DWORD_sw.FromVar(AArgs[0]);
end;

function TCreateParams_ExStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ExStyle: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(TCreateParams_sw(AObj).FValue.ExStyle)
  else
    TCreateParams_sw(AObj).FValue.ExStyle := DWORD_sw.FromVar(AArgs[0]);
end;

function TCreateParams_X_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var X: Integer;

  if IsGet then
    Result := TCreateParams_sw(AObj).FValue.X
  else
    TCreateParams_sw(AObj).FValue.X := Integer(AArgs[0]);
end;

function TCreateParams_Y_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Y: Integer;

  if IsGet then
    Result := TCreateParams_sw(AObj).FValue.Y
  else
    TCreateParams_sw(AObj).FValue.Y := Integer(AArgs[0]);
end;

function TCreateParams_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Width: Integer;

  if IsGet then
    Result := TCreateParams_sw(AObj).FValue.Width
  else
    TCreateParams_sw(AObj).FValue.Width := Integer(AArgs[0]);
end;

function TCreateParams_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Height: Integer;

  if IsGet then
    Result := TCreateParams_sw(AObj).FValue.Height
  else
    TCreateParams_sw(AObj).FValue.Height := Integer(AArgs[0]);
end;

function TCreateParams_WndParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WndParent: HWnd;

  if IsGet then
    Result := HWnd_sw.ToVar(TCreateParams_sw(AObj).FValue.WndParent)
  else
    TCreateParams_sw(AObj).FValue.WndParent := HWnd_sw.FromVar(AArgs[0]);
end;

function TCreateParams_WindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WindowClass: TWndClass;

  if IsGet then
    Result := TWndClass_sw.ToVar(TCreateParams_sw(AObj).FValue.WindowClass)
  else
    TCreateParams_sw(AObj).FValue.WindowClass := TWndClass_sw.FromVar(AArgs[0]);
end;

function TCreateParams_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCreateParams_sw.Create as IDispatch;
end;

function TCreateParams_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCreateParams;

  // Implicit record copy method.
  Result := TCreateParams_sw.ToVar(TCreateParams(AObj));
end;

class function TCreateParams_sw.GetTypeName: WideString;
begin
  Result := 'TCreateParams';
end;

function TCreateParams_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCreateParams_sw.Create;
  TCreateParams_sw(Result).FValue := FValue;
end;

class procedure TCreateParams_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Style', TCreateParams_Style_si, DWORD_sw);
  AData.AddField('ExStyle', TCreateParams_ExStyle_si, DWORD_sw);
  AData.AddField('X', TCreateParams_X_si, Integer_sw);
  AData.AddField('Y', TCreateParams_Y_si, Integer_sw);
  AData.AddField('Width', TCreateParams_Width_si, Integer_sw);
  AData.AddField('Height', TCreateParams_Height_si, Integer_sw);
  AData.AddField('WndParent', TCreateParams_WndParent_si, HWnd_sw);
  AData.AddField('WindowClass', TCreateParams_WindowClass_si, TWndClass_sw);
  AData.AddFunction('Copy', TCreateParams_Copy_si, TCreateParams_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCreateParams_Create_si, 0, False);
end;

class function TCreateParams_sw.ToVar(const AValue: TCreateParams): OleVariant;
var
  wrpr: TCreateParams_sw;
begin
  wrpr        := TCreateParams_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCreateParams_sw.FromVar(
  const AValue: OleVariant): TCreateParams;
begin
  Result := TCreateParams_sw(ConvFromVar(AValue)).FValue;
end;

{ TWinControlActionLink_sw }

class function TWinControlActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TWinControlActionLink';
end;

class function TWinControlActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TWinControlActionLink;
end;

class procedure TWinControlActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TWinControlActionLink_sw.ToVar(
  const AValue: TWinControlActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWinControlActionLink_sw.FromVar(
  const AValue: OleVariant): TWinControlActionLink;
begin
  Result := TWinControlActionLink(ConvFromVar(AValue, TWinControlActionLink));
end;

class function TWinControlActionLink_sw.ClassToVar(
  AClass: TWinControlActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWinControlActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TWinControlActionLink_sc;
begin
  Result := TWinControlActionLink_sc(ConvClsFromVar(AClass, 
    TWinControlActionLink));
end;

{ TWinControlActionLinkClass_sw }

class function TWinControlActionLinkClass_sw.GetTypeName: WideString;
begin
  Result := 'TWinControlActionLinkClass';
end;

class function TWinControlActionLinkClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TWinControlActionLink;
end;

class function TWinControlActionLinkClass_sw.ToVar(
  const AValue: TWinControlActionLinkClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWinControlActionLinkClass_sw.FromVar(
  const AValue: OleVariant): TWinControlActionLinkClass;
begin
  Result := TWinControlActionLinkClass(ConvFromVar(AValue, 
    TWinControlActionLink));
end;

{ TImeMode_sw }

class function TImeMode_sw.GetTypeName: WideString;
begin
  Result := 'TImeMode';
end;

class procedure TImeMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..11] of TLMDEnumerator = (
    (Name: 'imDisable'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imDisable)),
    (Name: 'imClose'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imClose)),
    (Name: 'imOpen'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imOpen)),
    (Name: 'imDontCare'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imDontCare)),
    (Name: 'imSAlpha'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imSAlpha)),
    (Name: 'imAlpha'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imAlpha)),
    (Name: 'imHira'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imHira)),
    (Name: 'imSKata'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imSKata)),
    (Name: 'imKata'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imKata)),
    (Name: 'imChinese'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imChinese)),
    (Name: 'imSHanguel'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imSHanguel)),
    (Name: 'imHanguel'; Value: Integer({$IFDEF LMDSCT_12}TImeMode.{$ENDIF}imHanguel))
  );
begin
  AEnums := @ENUMS;
  ACount := 12;
end;

class function TImeMode_sw.ToVar(const AValue: TImeMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TImeMode_sw.FromVar(const AValue: OleVariant): TImeMode;
begin
  Result := TImeMode(Integer(AValue));
end;

{ TImeName_sw }

class function TImeName_sw.GetTypeName: WideString;
begin
  Result := 'TImeName';
end;

class function TImeName_sw.ToVar(const AValue: TImeName): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TImeName_sw.FromVar(const AValue: OleVariant): TImeName;
begin
  Result := TImeName(string_sw.FromVar(AValue));
end;

{ TAlignInfo_sw }

function TAlignInfo_AlignList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AlignList: TList;

  if IsGet then
    Result := TList_sw.ToVar(TAlignInfo_sw(AObj).FValue.AlignList)
  else
    TAlignInfo_sw(AObj).FValue.AlignList := TList_sw.FromVar(AArgs[0]);
end;

function TAlignInfo_ControlIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ControlIndex: Integer;

  if IsGet then
    Result := TAlignInfo_sw(AObj).FValue.ControlIndex
  else
    TAlignInfo_sw(AObj).FValue.ControlIndex := Integer(AArgs[0]);
end;

function TAlignInfo_Align_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Align: TAlign;

  if IsGet then
    Result := TAlign_sw.ToVar(TAlignInfo_sw(AObj).FValue.Align)
  else
    TAlignInfo_sw(AObj).FValue.Align := TAlign_sw.FromVar(AArgs[0]);
end;

function TAlignInfo_Scratch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Scratch: Integer;

  if IsGet then
    Result := TAlignInfo_sw(AObj).FValue.Scratch
  else
    TAlignInfo_sw(AObj).FValue.Scratch := Integer(AArgs[0]);
end;

function TAlignInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TAlignInfo_sw.Create as IDispatch;
end;

function TAlignInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TAlignInfo;

  // Implicit record copy method.
  Result := TAlignInfo_sw.ToVar(TAlignInfo(AObj));
end;

class function TAlignInfo_sw.GetTypeName: WideString;
begin
  Result := 'TAlignInfo';
end;

function TAlignInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TAlignInfo_sw.Create;
  TAlignInfo_sw(Result).FValue := FValue;
end;

class procedure TAlignInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('AlignList', TAlignInfo_AlignList_si, TList_sw);
  AData.AddField('ControlIndex', TAlignInfo_ControlIndex_si, Integer_sw);
  AData.AddField('Align', TAlignInfo_Align_si, TAlign_sw);
  AData.AddField('Scratch', TAlignInfo_Scratch_si, Integer_sw);
  AData.AddFunction('Copy', TAlignInfo_Copy_si, TAlignInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TAlignInfo_Create_si, 0, False);
end;

class function TAlignInfo_sw.ToVar(const AValue: TAlignInfo): OleVariant;
var
  wrpr: TAlignInfo_sw;
begin
  wrpr        := TAlignInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TAlignInfo_sw.FromVar(const AValue: OleVariant): TAlignInfo;
begin
  Result := TAlignInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TBorderWidth_sw }

class function TBorderWidth_sw.GetTypeName: WideString;
begin
  Result := 'TBorderWidth';
end;

class function TBorderWidth_sw.ToVar(const AValue: TBorderWidth): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBorderWidth_sw.FromVar(const AValue: OleVariant): TBorderWidth;
begin
  Result := TBorderWidth(Integer(AValue));
end;

{ TBevelCut_sw }

class function TBevelCut_sw.GetTypeName: WideString;
begin
  Result := 'TBevelCut';
end;

class procedure TBevelCut_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'bvNone'; Value: Integer({$IFDEF LMDSCT_12}TBevelCut.{$ENDIF}bvNone)),
    (Name: 'bvLowered'; Value: Integer({$IFDEF LMDSCT_12}TBevelCut.{$ENDIF}bvLowered)),
    (Name: 'bvRaised'; Value: Integer({$IFDEF LMDSCT_12}TBevelCut.{$ENDIF}bvRaised)),
    (Name: 'bvSpace'; Value: Integer({$IFDEF LMDSCT_12}TBevelCut.{$ENDIF}bvSpace))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBevelCut_sw.ToVar(const AValue: TBevelCut): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelCut_sw.FromVar(const AValue: OleVariant): TBevelCut;
begin
  Result := TBevelCut(Integer(AValue));
end;

{ TBevelEdge_sw }

class function TBevelEdge_sw.GetTypeName: WideString;
begin
  Result := 'TBevelEdge';
end;

class procedure TBevelEdge_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'beLeft'; Value: Integer({$IFDEF LMDSCT_12}TBevelEdge.{$ENDIF}beLeft)),
    (Name: 'beTop'; Value: Integer({$IFDEF LMDSCT_12}TBevelEdge.{$ENDIF}beTop)),
    (Name: 'beRight'; Value: Integer({$IFDEF LMDSCT_12}TBevelEdge.{$ENDIF}beRight)),
    (Name: 'beBottom'; Value: Integer({$IFDEF LMDSCT_12}TBevelEdge.{$ENDIF}beBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBevelEdge_sw.ToVar(const AValue: TBevelEdge): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelEdge_sw.FromVar(const AValue: OleVariant): TBevelEdge;
begin
  Result := TBevelEdge(Integer(AValue));
end;

{ TBevelEdges_sw }

class function TBevelEdges_sw.GetTypeName: WideString;
begin
  Result := 'TBevelEdges';
end;

class function TBevelEdges_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TBevelEdges);
end;

class function TBevelEdges_sw.ToVar(const AValue: TBevelEdges): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TBevelEdges_sw.FromVar(const AValue: OleVariant): TBevelEdges;
begin
  ConvFromVar(AValue, @Result);
end;

{ TBevelKind_sw }

class function TBevelKind_sw.GetTypeName: WideString;
begin
  Result := 'TBevelKind';
end;

class procedure TBevelKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'bkNone'; Value: Integer({$IFDEF LMDSCT_12}TBevelKind.{$ENDIF}bkNone)),
    (Name: 'bkTile'; Value: Integer({$IFDEF LMDSCT_12}TBevelKind.{$ENDIF}bkTile)),
    (Name: 'bkSoft'; Value: Integer({$IFDEF LMDSCT_12}TBevelKind.{$ENDIF}bkSoft)),
    (Name: 'bkFlat'; Value: Integer({$IFDEF LMDSCT_12}TBevelKind.{$ENDIF}bkFlat))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBevelKind_sw.ToVar(const AValue: TBevelKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelKind_sw.FromVar(const AValue: OleVariant): TBevelKind;
begin
  Result := TBevelKind(Integer(AValue));
end;

{ TBevelWidth_sw }

class function TBevelWidth_sw.GetTypeName: WideString;
begin
  Result := 'TBevelWidth';
end;

class function TBevelWidth_sw.ToVar(const AValue: TBevelWidth): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBevelWidth_sw.FromVar(const AValue: OleVariant): TBevelWidth;
begin
  Result := TBevelWidth(Integer(AValue));
end;

{ TAlignInsertBeforeEvent_sh }

function TAlignInsertBeforeEvent_sh.GetHandler: TMethod;
var
  hdr: TAlignInsertBeforeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TAlignInsertBeforeEvent_sh.Handler(Sender: TWinControl; C1: TControl;
  C2: TControl): Boolean;
var
  args: array[0..2] of OleVariant;
begin
  // function (Sender: TWinControl; C1: TControl; C2: TControl...

  args[0] := TWinControl_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(C1);
  args[2] := TControl_sw.ToVar(C2);
  Result := Boolean(Self.Owner.RunProc(Self.ProcName, args));
end;

{ TAlignInsertBeforeEvent_sw }

class function TAlignInsertBeforeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TAlignInsertBeforeEvent';
end;

class function TAlignInsertBeforeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TAlignInsertBeforeEvent_sh;
end;

class function TAlignInsertBeforeEvent_sw.ToVar(
  const AValue: TAlignInsertBeforeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TAlignInsertBeforeEvent_sw.FromVar(
  const AValue: OleVariant): TAlignInsertBeforeEvent;
begin
  Result := TAlignInsertBeforeEvent(ConvFromVar(AValue));
end;

class function TAlignInsertBeforeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TAlignInsertBeforeEvent;
var
  hdlr: TAlignInsertBeforeEvent_sh;
begin
  hdlr   := TAlignInsertBeforeEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TAlignInsertBeforeEvent_sw));
  Result := hdlr.Handler;
end;

{ TAlignPositionEvent_sh }

function TAlignPositionEvent_sh.GetHandler: TMethod;
var
  hdr: TAlignPositionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TAlignPositionEvent_sh.Handler(Sender: TWinControl; Control: TControl;
  var NewLeft: Integer; var NewTop: Integer; var NewWidth: Integer;
  var NewHeight: Integer; var AlignRect: TRect; AlignInfo: TAlignInfo);
var
  args: array[0..7] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
  v_4: OleVariant;
  v_5: OleVariant;
begin
  // procedure (Sender: TWinControl; Control: TControl; var Ne...

  v_1 := NewLeft;
  v_2 := NewTop;
  v_3 := NewWidth;
  v_4 := NewHeight;
  v_5 := TRect_sw.ToVar(AlignRect);
  args[0] := TWinControl_sw.ToVar(Sender);
  args[1] := TControl_sw.ToVar(Control);
  args[2] := MakeVarRef(v_1);
  args[3] := MakeVarRef(v_2);
  args[4] := MakeVarRef(v_3);
  args[5] := MakeVarRef(v_4);
  args[6] := MakeVarRef(v_5);
  args[7] := TAlignInfo_sw.ToVar(AlignInfo);
  Self.Owner.RunProc(Self.ProcName, args);
  NewLeft := Integer(v_1);
  NewTop := Integer(v_2);
  NewWidth := Integer(v_3);
  NewHeight := Integer(v_4);
  AlignRect := TRect_sw.FromVar(v_5);
end;

{ TAlignPositionEvent_sw }

class function TAlignPositionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TAlignPositionEvent';
end;

class function TAlignPositionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TAlignPositionEvent_sh;
end;

class function TAlignPositionEvent_sw.ToVar(
  const AValue: TAlignPositionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TAlignPositionEvent_sw.FromVar(
  const AValue: OleVariant): TAlignPositionEvent;
begin
  Result := TAlignPositionEvent(ConvFromVar(AValue));
end;

class function TAlignPositionEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TAlignPositionEvent;
var
  hdlr: TAlignPositionEvent_sh;
begin
  hdlr   := TAlignPositionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TAlignPositionEvent_sw));
  Result := hdlr.Handler;
end;

{ TWinControl_sw }

function TWinControl_AlignControlList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AlignControlList: TList read <getter>;

  Result := TList_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
    AlignControlList);
end;

function TWinControl_BevelEdges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelEdges: TBevelEdges read <getter> ...

  if IsGet then
    Result := TBevelEdges_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      BevelEdges)
  else
    TWinControl_sacc(TWinControl(AObj)).BevelEdges := TBevelEdges_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_BevelInner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelInner: TBevelCut read <getter> wr...

  if IsGet then
    Result := TBevelCut_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).BevelInner)
  else
    TWinControl_sacc(TWinControl(AObj)).BevelInner := TBevelCut_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_BevelOuter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelOuter: TBevelCut read <getter> wr...

  if IsGet then
    Result := TBevelCut_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).BevelOuter)
  else
    TWinControl_sacc(TWinControl(AObj)).BevelOuter := TBevelCut_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_BevelKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelKind: TBevelKind read <getter> wr...

  if IsGet then
    Result := TBevelKind_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).BevelKind)
  else
    TWinControl_sacc(TWinControl(AObj)).BevelKind := TBevelKind_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_BevelWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BevelWidth: TBevelWidth read <getter> ...

  if IsGet then
    Result := TBevelWidth_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      BevelWidth)
  else
    TWinControl_sacc(TWinControl(AObj)).BevelWidth := TBevelWidth_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_BorderWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderWidth: TBorderWidth read <getter...

  if IsGet then
    Result := TBorderWidth_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      BorderWidth)
  else
    TWinControl_sacc(TWinControl(AObj)).BorderWidth := TBorderWidth_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_Ctl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Ctl3D: Boolean read <getter> write <se...

  if IsGet then
    Result := TWinControl_sacc(TWinControl(AObj)).Ctl3D
  else
    TWinControl_sacc(TWinControl(AObj)).Ctl3D := Boolean(AArgs[0]);
end;

function TWinControl_ImeMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ImeMode: TImeMode read <getter> write ...

  if IsGet then
    Result := TImeMode_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).ImeMode)
  else
    TWinControl_sacc(TWinControl(AObj)).ImeMode := TImeMode_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_ImeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ImeName: TImeName read <getter> write ...

  if IsGet then
    Result := TImeName_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).ImeName)
  else
    TWinControl_sacc(TWinControl(AObj)).ImeName := TImeName_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_ParentBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentBackground: Boolean read <getter...

  if IsGet then
    Result := TWinControl_sacc(TWinControl(AObj)).ParentBackground
  else
    TWinControl_sacc(TWinControl(AObj)).ParentBackground := Boolean(AArgs[0]);
end;

function TWinControl_ParentCtl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ParentCtl3D: Boolean read <getter> wri...

  if IsGet then
    Result := TWinControl_sacc(TWinControl(AObj)).ParentCtl3D
  else
    TWinControl_sacc(TWinControl(AObj)).ParentCtl3D := Boolean(AArgs[0]);
end;

function TWinControl_WindowHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WindowHandle: HWnd read <getter> write...

  if IsGet then
    Result := HWnd_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).WindowHandle)
  else
    TWinControl_sacc(TWinControl(AObj)).WindowHandle := HWnd_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnAlignInsertBefore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAlignInsertBefore: TAlignInsertBefor...

  if IsGet then
    Result := TAlignInsertBeforeEvent_sw.ToVar(TWinControl_sacc(TWinControl(
      AObj)).OnAlignInsertBefore)
  else
    TWinControl_sacc(TWinControl(AObj)).OnAlignInsertBefore := 
      TAlignInsertBeforeEvent_sw.FromVar(AArgs[0]);
end;

function TWinControl_OnAlignPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAlignPosition: TAlignPositionEvent r...

  if IsGet then
    Result := TAlignPositionEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnAlignPosition)
  else
    TWinControl_sacc(TWinControl(AObj)).OnAlignPosition := 
      TAlignPositionEvent_sw.FromVar(AArgs[0]);
end;

function TWinControl_OnDockDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDockDrop: TDockDropEvent read <gette...

  if IsGet then
    Result := TDockDropEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnDockDrop)
  else
    TWinControl_sacc(TWinControl(AObj)).OnDockDrop := TDockDropEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnDockOver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDockOver: TDockOverEvent read <gette...

  if IsGet then
    Result := TDockOverEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnDockOver)
  else
    TWinControl_sacc(TWinControl(AObj)).OnDockOver := TDockOverEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnEnter: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).OnEnter)
  else
    TWinControl_sacc(TWinControl(AObj)).OnEnter := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnExit: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).OnExit)
  else
    TWinControl_sacc(TWinControl(AObj)).OnExit := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnGetSiteInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnGetSiteInfo: TGetSiteInfoEvent read ...

  if IsGet then
    Result := TGetSiteInfoEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnGetSiteInfo)
  else
    TWinControl_sacc(TWinControl(AObj)).OnGetSiteInfo := TGetSiteInfoEvent_sw.
      FromVar(AArgs[0]);
end;

function TWinControl_OnKeyPress_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnKeyPress: TKeyPressEvent read <gette...

  if IsGet then
    Result := TKeyPressEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnKeyPress)
  else
    TWinControl_sacc(TWinControl(AObj)).OnKeyPress := TKeyPressEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_OnUnDock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnUnDock: TUnDockEvent read <getter> w...

  if IsGet then
    Result := TUnDockEvent_sw.ToVar(TWinControl_sacc(TWinControl(AObj)).
      OnUnDock)
  else
    TWinControl_sacc(TWinControl(AObj)).OnUnDock := TUnDockEvent_sw.FromVar(
      AArgs[0]);
end;

function TWinControl_CreateParented_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateParented(ParentWindow: HWnd);

  Result := TWinControl_sw.ToVar(TWinControl_sc(AObj).CreateParented(HWnd_sw.
    FromVar(AArgs[0])));
end;

function TWinControl_CreateParentedControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // class function CreateParentedControl(ParentWindow: HWND):...

  Result := TWinControl_sw.ToVar(TWinControl_sc(AObj).CreateParentedControl(
    HWND_sw.FromVar(AArgs[0])));
end;

function TWinControl_CanFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CanFocus: Boolean;

  Result := TWinControl(AObj).CanFocus();
end;

function TWinControl_ContainsControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ContainsControl(Control: TControl): Boolean;

  Result := TWinControl(AObj).ContainsControl(TControl_sw.FromVar(AArgs[0]));
end;

function TWinControl_ControlAtPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ControlAtPos(const Pos: TPoint; AllowDisabled: B...

  case AArgsSize of
    2:
    begin
      Result := TControl_sw.ToVar(TWinControl(AObj).ControlAtPos(TPoint_sw.
        FromVar(AArgs[0]), Boolean(AArgs[1])));
    end;
    3:
    begin
      Result := TControl_sw.ToVar(TWinControl(AObj).ControlAtPos(TPoint_sw.
        FromVar(AArgs[0]), Boolean(AArgs[1]), Boolean(AArgs[2])));
    end;
    4:
    begin
      Result := TControl_sw.ToVar(TWinControl(AObj).ControlAtPos(TPoint_sw.
        FromVar(AArgs[0]), Boolean(AArgs[1]), Boolean(AArgs[2]), Boolean(
        AArgs[3])));
    end;
  else
    WrongArgCountError('ControlAtPos');
  end;
end;

function TWinControl_DisableAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableAlign;

  TWinControl(AObj).DisableAlign();
end;

function TWinControl_DockClientCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DockClientCount: Integer read <getter>;

  Result := TWinControl(AObj).DockClientCount;
end;

function TWinControl_DockClients_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DockClients[Index: Integer]: TControl read <gett...

  Result := TControl_sw.ToVar(TWinControl(AObj).DockClients[Integer(AArgs[0])]);
end;

function TWinControl_DockDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DockDrop(Source: TDragDockObject; X: Integer; Y...

  TWinControl(AObj).DockDrop(TDragDockObject_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]));
end;

function TWinControl_DockSite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DockSite: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TWinControl(AObj).DockSite
  else
    TWinControl(AObj).DockSite := Boolean(AArgs[0]);
end;

function TWinControl_DoubleBuffered_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DoubleBuffered: Boolean read <getter> write <set...

  if IsGet then
    Result := TWinControl(AObj).DoubleBuffered
  else
    TWinControl(AObj).DoubleBuffered := Boolean(AArgs[0]);
end;

function TWinControl_EnableAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableAlign;

  TWinControl(AObj).EnableAlign();
end;

function TWinControl_FindChildControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindChildControl(const ControlName: string): TCo...

  Result := TControl_sw.ToVar(TWinControl(AObj).FindChildControl(string(
    AArgs[0])));
end;

function TWinControl_FlipChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FlipChildren(AllLevels: Boolean);

  TWinControl(AObj).FlipChildren(Boolean(AArgs[0]));
end;

function TWinControl_Focused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Focused: Boolean;

  Result := TWinControl(AObj).Focused();
end;

function TWinControl_GetTabOrderList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetTabOrderList(List: TList);

  TWinControl(AObj).GetTabOrderList(TList_sw.FromVar(AArgs[0]));
end;

function TWinControl_HandleAllocated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HandleAllocated: Boolean;

  Result := TWinControl(AObj).HandleAllocated();
end;

function TWinControl_HandleNeeded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HandleNeeded;

  TWinControl(AObj).HandleNeeded();
end;

function TWinControl_InsertControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InsertControl(AControl: TControl);

  TWinControl(AObj).InsertControl(TControl_sw.FromVar(AArgs[0]));
end;

function TWinControl_PaintTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PaintTo(...); overload;

  TWinControl(AObj).PaintTo(TCanvas_sw.FromVar(AArgs[0]), Integer(AArgs[1]), 
    Integer(AArgs[2]));
end;

function TWinControl_PreProcessMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMsg;
begin
  // function PreProcessMessage(var Msg: TMsg): Boolean;

  v_1 := TMsg_sw.FromVar(AArgs[0]);
  Result := TWinControl(AObj).PreProcessMessage(v_1);
  AssignRefParam(AArgs[0], TMsg_sw.ToVar(v_1));
end;

function TWinControl_RemoveControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemoveControl(AControl: TControl);

  TWinControl(AObj).RemoveControl(TControl_sw.FromVar(AArgs[0]));
end;

function TWinControl_Realign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Realign;

  TWinControl(AObj).Realign();
end;

function TWinControl_ScaleBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ScaleBy(M: Integer; D: Integer);

  TWinControl(AObj).ScaleBy(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TWinControl_ScrollBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ScrollBy(DeltaX: Integer; DeltaY: Integer);

  TWinControl(AObj).ScrollBy(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TWinControl_SetFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetFocus;

  TWinControl(AObj).SetFocus();
end;

function TWinControl_UpdateControlState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UpdateControlState;

  TWinControl(AObj).UpdateControlState();
end;

function TWinControl_AlignDisabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AlignDisabled: Boolean read <getter>;

  Result := TWinControl(AObj).AlignDisabled;
end;

function TWinControl_MouseInClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MouseInClient: Boolean read <getter>;

  Result := TWinControl(AObj).MouseInClient;
end;

function TWinControl_VisibleDockClientCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VisibleDockClientCount: Integer read <getter>;

  Result := TWinControl(AObj).VisibleDockClientCount;
end;

function TWinControl_Brush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Brush: TBrush read <getter>;

  Result := TBrush_sw.ToVar(TWinControl(AObj).Brush);
end;

function TWinControl_Controls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Controls[Index: Integer]: TControl read <getter>;

  Result := TControl_sw.ToVar(TWinControl(AObj).Controls[Integer(AArgs[0])]);
end;

function TWinControl_ControlCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ControlCount: Integer read <getter>;

  Result := TWinControl(AObj).ControlCount;
end;

function TWinControl_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWND read <getter>;

  Result := HWND_sw.ToVar(TWinControl(AObj).Handle);
end;

function TWinControl_Padding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Padding: TPadding read <getter> write <setter>;

  if IsGet then
    Result := TPadding_sw.ToVar(TWinControl(AObj).Padding)
  else
    TWinControl(AObj).Padding := TPadding_sw.FromVar(AArgs[0]);
end;

function TWinControl_ParentDoubleBuffered_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentDoubleBuffered: Boolean read <getter> writ...

  if IsGet then
    Result := TWinControl(AObj).ParentDoubleBuffered
  else
    TWinControl(AObj).ParentDoubleBuffered := Boolean(AArgs[0]);
end;

function TWinControl_ParentWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentWindow: HWND read <getter> write <setter>;

  if IsGet then
    Result := HWND_sw.ToVar(TWinControl(AObj).ParentWindow)
  else
    TWinControl(AObj).ParentWindow := HWND_sw.FromVar(AArgs[0]);
end;

function TWinControl_Showing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Showing: Boolean read <getter>;

  Result := TWinControl(AObj).Showing;
end;

function TWinControl_TabOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabOrder: TTabOrder read <getter> write <setter>;

  if IsGet then
    Result := TTabOrder_sw.ToVar(TWinControl(AObj).TabOrder)
  else
    TWinControl(AObj).TabOrder := TTabOrder_sw.FromVar(AArgs[0]);
end;

function TWinControl_TabStop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property TabStop: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TWinControl(AObj).TabStop
  else
    TWinControl(AObj).TabStop := Boolean(AArgs[0]);
end;

function TWinControl_UseDockManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UseDockManager: Boolean read <getter> write <set...

  if IsGet then
    Result := TWinControl(AObj).UseDockManager
  else
    TWinControl(AObj).UseDockManager := Boolean(AArgs[0]);
end;

class function TWinControl_sw.GetTypeName: WideString;
begin
  Result := 'TWinControl';
end;

class function TWinControl_sw.GetWrappedClass: TClass;
begin
  Result := TWinControl;
end;

class procedure TWinControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AlignControlList', TWinControl_AlignControlList_si, TList_sw, True, False, 0, True, False);
  AData.AddProperty('BevelEdges', TWinControl_BevelEdges_si, TBevelEdges_sw, True, True, 0, True, False);
  AData.AddProperty('BevelInner', TWinControl_BevelInner_si, TBevelCut_sw, True, True, 0, True, False);
  AData.AddProperty('BevelOuter', TWinControl_BevelOuter_si, TBevelCut_sw, True, True, 0, True, False);
  AData.AddProperty('BevelKind', TWinControl_BevelKind_si, TBevelKind_sw, True, True, 0, True, False);
  AData.AddProperty('BevelWidth', TWinControl_BevelWidth_si, TBevelWidth_sw, True, True, 0, True, False);
  AData.AddProperty('BorderWidth', TWinControl_BorderWidth_si, TBorderWidth_sw, True, True, 0, True, False);
  AData.AddProperty('Ctl3D', TWinControl_Ctl3D_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ImeMode', TWinControl_ImeMode_si, TImeMode_sw, True, True, 0, True, False);
  AData.AddProperty('ImeName', TWinControl_ImeName_si, TImeName_sw, True, True, 0, True, False);
  AData.AddProperty('ParentBackground', TWinControl_ParentBackground_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('ParentCtl3D', TWinControl_ParentCtl3D_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('WindowHandle', TWinControl_WindowHandle_si, HWnd_sw, True, True, 0, True, False);
  AData.AddProperty('OnAlignInsertBefore', TWinControl_OnAlignInsertBefore_si, TAlignInsertBeforeEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnAlignPosition', TWinControl_OnAlignPosition_si, TAlignPositionEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDockDrop', TWinControl_OnDockDrop_si, TDockDropEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDockOver', TWinControl_OnDockOver_si, TDockOverEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnEnter', TWinControl_OnEnter_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnExit', TWinControl_OnExit_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnGetSiteInfo', TWinControl_OnGetSiteInfo_si, TGetSiteInfoEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnKeyPress', TWinControl_OnKeyPress_si, TKeyPressEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnUnDock', TWinControl_OnUnDock_si, TUnDockEvent_sw, True, True, 0, True, False);
  AData.AddFunction('CanFocus', TWinControl_CanFocus_si, Boolean_sw, 0, False);
  AData.AddFunction('ContainsControl', TWinControl_ContainsControl_si, Boolean_sw, 1, False);
  AData.AddFunction('ControlAtPos', TWinControl_ControlAtPos_si, TControl_sw, 2, True);
  AData.AddProcedure('DisableAlign', TWinControl_DisableAlign_si, 0, False);
  AData.AddProperty('DockClientCount', TWinControl_DockClientCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DockClients', TWinControl_DockClients_si, TControl_sw, True, False, 1, False, False);
  AData.AddProcedure('DockDrop', TWinControl_DockDrop_si, 3, False);
  AData.AddProperty('DockSite', TWinControl_DockSite_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DoubleBuffered', TWinControl_DoubleBuffered_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProcedure('EnableAlign', TWinControl_EnableAlign_si, 0, False);
  AData.AddFunction('FindChildControl', TWinControl_FindChildControl_si, TControl_sw, 1, False);
  AData.AddProcedure('FlipChildren', TWinControl_FlipChildren_si, 1, False);
  AData.AddFunction('Focused', TWinControl_Focused_si, Boolean_sw, 0, False);
  AData.AddProcedure('GetTabOrderList', TWinControl_GetTabOrderList_si, 1, False);
  AData.AddFunction('HandleAllocated', TWinControl_HandleAllocated_si, Boolean_sw, 0, False);
  AData.AddProcedure('HandleNeeded', TWinControl_HandleNeeded_si, 0, False);
  AData.AddProcedure('InsertControl', TWinControl_InsertControl_si, 1, False);
  AData.AddProcedure('PaintTo', TWinControl_PaintTo_si, 3, False);
  AData.AddFunction('PreProcessMessage', TWinControl_PreProcessMessage_si, Boolean_sw, 1, False);
  AData.AddProcedure('RemoveControl', TWinControl_RemoveControl_si, 1, False);
  AData.AddProcedure('Realign', TWinControl_Realign_si, 0, False);
  AData.AddProcedure('ScaleBy', TWinControl_ScaleBy_si, 2, False);
  AData.AddProcedure('ScrollBy', TWinControl_ScrollBy_si, 2, False);
  AData.AddProcedure('SetFocus', TWinControl_SetFocus_si, 0, False);
  AData.AddProcedure('UpdateControlState', TWinControl_UpdateControlState_si, 0, False);
  AData.AddProperty('AlignDisabled', TWinControl_AlignDisabled_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('MouseInClient', TWinControl_MouseInClient_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('VisibleDockClientCount', TWinControl_VisibleDockClientCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Brush', TWinControl_Brush_si, TBrush_sw, True, False, 0, False, False);
  AData.AddProperty('Controls', TWinControl_Controls_si, TControl_sw, True, False, 1, False, False);
  AData.AddProperty('ControlCount', TWinControl_ControlCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Handle', TWinControl_Handle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('Padding', TWinControl_Padding_si, TPadding_sw, True, True, 0, False, False);
  AData.AddProperty('ParentDoubleBuffered', TWinControl_ParentDoubleBuffered_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ParentWindow', TWinControl_ParentWindow_si, HWND_sw, True, True, 0, False, False);
  AData.AddProperty('Showing', TWinControl_Showing_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('TabOrder', TWinControl_TabOrder_si, TTabOrder_sw, True, True, 0, False, False);
  AData.AddProperty('TabStop', TWinControl_TabStop_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('UseDockManager', TWinControl_UseDockManager_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('CreateParented', TWinControl_CreateParented_si, 1, False);
  AData.AddClassFunction('CreateParentedControl', TWinControl_CreateParentedControl_si, TWinControl_sw, 1, False);
end;

class function TWinControl_sw.ToVar(const AValue: TWinControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TWinControl_sw.FromVar(const AValue: OleVariant): TWinControl;
begin
  Result := TWinControl(ConvFromVar(AValue, TWinControl));
end;

class function TWinControl_sw.ClassToVar(AClass: TWinControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TWinControl_sw.ClassFromVar(
  const AClass: OleVariant): TWinControl_sc;
begin
  Result := TWinControl_sc(ConvClsFromVar(AClass, TWinControl));
end;

{ TGraphicControl_sw }

function TGraphicControl_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TGraphicControl_sacc(TGraphicControl(AObj)).
    Canvas);
end;

class function TGraphicControl_sw.GetTypeName: WideString;
begin
  Result := 'TGraphicControl';
end;

class function TGraphicControl_sw.GetWrappedClass: TClass;
begin
  Result := TGraphicControl;
end;

class procedure TGraphicControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TGraphicControl_Canvas_si, TCanvas_sw, True, False, 0, True, False);
end;

class function TGraphicControl_sw.ToVar(
  const AValue: TGraphicControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGraphicControl_sw.FromVar(
  const AValue: OleVariant): TGraphicControl;
begin
  Result := TGraphicControl(ConvFromVar(AValue, TGraphicControl));
end;

class function TGraphicControl_sw.ClassToVar(
  AClass: TGraphicControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGraphicControl_sw.ClassFromVar(
  const AClass: OleVariant): TGraphicControl_sc;
begin
  Result := TGraphicControl_sc(ConvClsFromVar(AClass, TGraphicControl));
end;

{ TCustomControl_sw }

function TCustomControl_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomControl_sacc(TCustomControl(AObj)).Canvas);
end;

class function TCustomControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomControl';
end;

class function TCustomControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomControl;
end;

class procedure TCustomControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Canvas', TCustomControl_Canvas_si, TCanvas_sw, True, False, 0, True, False);
end;

class function TCustomControl_sw.ToVar(
  const AValue: TCustomControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomControl_sw.FromVar(
  const AValue: OleVariant): TCustomControl;
begin
  Result := TCustomControl(ConvFromVar(AValue, TCustomControl));
end;

class function TCustomControl_sw.ClassToVar(
  AClass: TCustomControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomControl_sc;
begin
  Result := TCustomControl_sc(ConvClsFromVar(AClass, TCustomControl));
end;

{ TCustomTransparentControl_sw }

function TCustomTransparentControl_InterceptMouse_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InterceptMouse: Boolean read <getter> write <set...

  if IsGet then
    Result := TCustomTransparentControl(AObj).InterceptMouse
  else
    TCustomTransparentControl(AObj).InterceptMouse := Boolean(AArgs[0]);
end;

class function TCustomTransparentControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomTransparentControl';
end;

class function TCustomTransparentControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomTransparentControl;
end;

class procedure TCustomTransparentControl_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('InterceptMouse', TCustomTransparentControl_InterceptMouse_si, Boolean_sw, True, True, 0, False, False);
end;

class function TCustomTransparentControl_sw.ToVar(
  const AValue: TCustomTransparentControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomTransparentControl_sw.FromVar(
  const AValue: OleVariant): TCustomTransparentControl;
begin
  Result := TCustomTransparentControl(ConvFromVar(AValue, 
    TCustomTransparentControl));
end;

class function TCustomTransparentControl_sw.ClassToVar(
  AClass: TCustomTransparentControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomTransparentControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomTransparentControl_sc;
begin
  Result := TCustomTransparentControl_sc(ConvClsFromVar(AClass, 
    TCustomTransparentControl));
end;

{ THintWindow_sw }

function THintWindow_ActivateHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ActivateHint(Rect: TRect; const AHint: string);

  THintWindow(AObj).ActivateHint(TRect_sw.FromVar(AArgs[0]), string(AArgs[1]));
end;

function THintWindow_IsHintMsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMsg;
begin
  // function IsHintMsg(var Msg: TMsg): Boolean;

  v_1 := TMsg_sw.FromVar(AArgs[0]);
  Result := THintWindow(AObj).IsHintMsg(v_1);
  AssignRefParam(AArgs[0], TMsg_sw.ToVar(v_1));
end;

function THintWindow_ShouldHideHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ShouldHideHint: Boolean;

  Result := THintWindow(AObj).ShouldHideHint();
end;

function THintWindow_ReleaseHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ReleaseHandle;

  THintWindow(AObj).ReleaseHandle();
end;

class function THintWindow_sw.GetTypeName: WideString;
begin
  Result := 'THintWindow';
end;

class function THintWindow_sw.GetWrappedClass: TClass;
begin
  Result := THintWindow;
end;

class procedure THintWindow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ActivateHint', THintWindow_ActivateHint_si, 2, False);
  AData.AddFunction('IsHintMsg', THintWindow_IsHintMsg_si, Boolean_sw, 1, False);
  AData.AddFunction('ShouldHideHint', THintWindow_ShouldHideHint_si, Boolean_sw, 0, False);
  AData.AddProcedure('ReleaseHandle', THintWindow_ReleaseHandle_si, 0, False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Canvas', False);
  AData.AddPropertyRedecl('Font', False);
end;

class function THintWindow_sw.ToVar(const AValue: THintWindow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function THintWindow_sw.FromVar(const AValue: OleVariant): THintWindow;
begin
  Result := THintWindow(ConvFromVar(AValue, THintWindow));
end;

class function THintWindow_sw.ClassToVar(AClass: THintWindow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function THintWindow_sw.ClassFromVar(
  const AClass: OleVariant): THintWindow_sc;
begin
  Result := THintWindow_sc(ConvClsFromVar(AClass, THintWindow));
end;

{ TDragImageList_sw }

function TDragImageList_BeginDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function BeginDrag(Window: HWND; X: Integer; Y: Integer):...

  Result := TDragImageList(AObj).BeginDrag(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]));
end;

function TDragImageList_DragLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DragLock(Window: HWND; XPos: Integer; YPos: Inte...

  Result := TDragImageList(AObj).DragLock(HWND_sw.FromVar(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]));
end;

function TDragImageList_DragMove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function DragMove(X: Integer; Y: Integer): Boolean;

  Result := TDragImageList(AObj).DragMove(Integer(AArgs[0]), Integer(AArgs[1]));
end;

function TDragImageList_DragUnlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DragUnlock;

  TDragImageList(AObj).DragUnlock();
end;

function TDragImageList_EndDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EndDrag: Boolean;

  Result := TDragImageList(AObj).EndDrag();
end;

function TDragImageList_HideDragImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HideDragImage;

  TDragImageList(AObj).HideDragImage();
end;

function TDragImageList_SetDragImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetDragImage(Index: Integer; HotSpotX: Integer; ...

  Result := TDragImageList(AObj).SetDragImage(Integer(AArgs[0]), Integer(
    AArgs[1]), Integer(AArgs[2]));
end;

function TDragImageList_ShowDragImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowDragImage;

  TDragImageList(AObj).ShowDragImage();
end;

function TDragImageList_DragCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragCursor: TCursor read <getter> write <setter>;

  if IsGet then
    Result := TCursor_sw.ToVar(TDragImageList(AObj).DragCursor)
  else
    TDragImageList(AObj).DragCursor := TCursor_sw.FromVar(AArgs[0]);
end;

function TDragImageList_DragHotspot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragHotspot: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TDragImageList(AObj).DragHotspot)
  else
    TDragImageList(AObj).DragHotspot := TPoint_sw.FromVar(AArgs[0]);
end;

function TDragImageList_Dragging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Dragging: Boolean read <getter>;

  Result := TDragImageList(AObj).Dragging;
end;

class function TDragImageList_sw.GetTypeName: WideString;
begin
  Result := 'TDragImageList';
end;

class function TDragImageList_sw.GetWrappedClass: TClass;
begin
  Result := TDragImageList;
end;

class procedure TDragImageList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('BeginDrag', TDragImageList_BeginDrag_si, Boolean_sw, 3, False);
  AData.AddFunction('DragLock', TDragImageList_DragLock_si, Boolean_sw, 3, False);
  AData.AddFunction('DragMove', TDragImageList_DragMove_si, Boolean_sw, 2, False);
  AData.AddProcedure('DragUnlock', TDragImageList_DragUnlock_si, 0, False);
  AData.AddFunction('EndDrag', TDragImageList_EndDrag_si, Boolean_sw, 0, False);
  AData.AddProcedure('HideDragImage', TDragImageList_HideDragImage_si, 0, False);
  AData.AddFunction('SetDragImage', TDragImageList_SetDragImage_si, Boolean_sw, 3, False);
  AData.AddProcedure('ShowDragImage', TDragImageList_ShowDragImage_si, 0, False);
  AData.AddProperty('DragCursor', TDragImageList_DragCursor_si, TCursor_sw, True, True, 0, False, False);
  AData.AddProperty('DragHotspot', TDragImageList_DragHotspot_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Dragging', TDragImageList_Dragging_si, Boolean_sw, True, False, 0, False, False);
end;

class function TDragImageList_sw.ToVar(
  const AValue: TDragImageList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDragImageList_sw.FromVar(
  const AValue: OleVariant): TDragImageList;
begin
  Result := TDragImageList(ConvFromVar(AValue, TDragImageList));
end;

class function TDragImageList_sw.ClassToVar(
  AClass: TDragImageList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDragImageList_sw.ClassFromVar(
  const AClass: OleVariant): TDragImageList_sc;
begin
  Result := TDragImageList_sc(ConvClsFromVar(AClass, TDragImageList));
end;

{ TImageList_sw }

class function TImageList_sw.GetTypeName: WideString;
begin
  Result := 'TImageList';
end;

class function TImageList_sw.GetWrappedClass: TClass;
begin
  Result := TImageList;
end;

class procedure TImageList_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('BlendColor', False);
  AData.AddPropertyRedecl('BkColor', False);
  AData.AddPropertyRedecl('AllocBy', False);
  AData.AddPropertyRedecl('ColorDepth', False);
  AData.AddPropertyRedecl('DrawingStyle', False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddPropertyRedecl('ImageType', False);
  AData.AddPropertyRedecl('Masked', False);
  AData.AddPropertyRedecl('OnChange', False);
  AData.AddPropertyRedecl('ShareImages', False);
  AData.AddPropertyRedecl('Width', False);
end;

class function TImageList_sw.ToVar(const AValue: TImageList): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TImageList_sw.FromVar(const AValue: OleVariant): TImageList;
begin
  Result := TImageList(ConvFromVar(AValue, TImageList));
end;

class function TImageList_sw.ClassToVar(AClass: TImageList_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TImageList_sw.ClassFromVar(
  const AClass: OleVariant): TImageList_sc;
begin
  Result := TImageList_sc(ConvClsFromVar(AClass, TImageList));
end;

{ TDockZone_sw }

function TDockZone_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Tree: TDockTree);

  Result := TDockZone_sw.ToVar(TDockZone_sc(AObj).Create(TDockTree_sw.FromVar(
    AArgs[0])));
end;

function TDockZone_ExpandZoneLimit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ExpandZoneLimit(NewLimit: Integer);

  TDockZone(AObj).ExpandZoneLimit(Integer(AArgs[0]));
end;

function TDockZone_FirstVisibleChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FirstVisibleChild: TDockZone;

  Result := TDockZone_sw.ToVar(TDockZone(AObj).FirstVisibleChild());
end;

function TDockZone_NextVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function NextVisible: TDockZone;

  Result := TDockZone_sw.ToVar(TDockZone(AObj).NextVisible());
end;

function TDockZone_PrevVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PrevVisible: TDockZone;

  Result := TDockZone_sw.ToVar(TDockZone(AObj).PrevVisible());
end;

function TDockZone_ResetChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetChildren;

  TDockZone(AObj).ResetChildren();
end;

function TDockZone_ResetZoneLimits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetZoneLimits;

  TDockZone(AObj).ResetZoneLimits();
end;

function TDockZone_Update_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Update;

  TDockZone(AObj).Update();
end;

function TDockZone_ChildCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChildCount: Integer read <getter>;

  Result := TDockZone(AObj).ChildCount;
end;

function TDockZone_ChildControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ChildControl: TControl read <getter>;

  Result := TControl_sw.ToVar(TDockZone(AObj).ChildControl);
end;

function TDockZone_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter>;

  Result := TDockZone(AObj).Height;
end;

function TDockZone_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter>;

  Result := TDockZone(AObj).Left;
end;

function TDockZone_LimitBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LimitBegin: Integer read <getter>;

  Result := TDockZone(AObj).LimitBegin;
end;

function TDockZone_LimitSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property LimitSize: Integer read <getter>;

  Result := TDockZone(AObj).LimitSize;
end;

function TDockZone_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter>;

  Result := TDockZone(AObj).Top;
end;

function TDockZone_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter>;

  Result := TDockZone(AObj).Visible;
end;

function TDockZone_VisibleChildCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VisibleChildCount: Integer read <getter>;

  Result := TDockZone(AObj).VisibleChildCount;
end;

function TDockZone_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter>;

  Result := TDockZone(AObj).Width;
end;

function TDockZone_ZoneLimit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ZoneLimit: Integer read <getter> write <setter>;

  if IsGet then
    Result := TDockZone(AObj).ZoneLimit
  else
    TDockZone(AObj).ZoneLimit := Integer(AArgs[0]);
end;

class function TDockZone_sw.GetTypeName: WideString;
begin
  Result := 'TDockZone';
end;

class function TDockZone_sw.GetWrappedClass: TClass;
begin
  Result := TDockZone;
end;

class procedure TDockZone_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ExpandZoneLimit', TDockZone_ExpandZoneLimit_si, 1, False);
  AData.AddFunction('FirstVisibleChild', TDockZone_FirstVisibleChild_si, TDockZone_sw, 0, False);
  AData.AddFunction('NextVisible', TDockZone_NextVisible_si, TDockZone_sw, 0, False);
  AData.AddFunction('PrevVisible', TDockZone_PrevVisible_si, TDockZone_sw, 0, False);
  AData.AddProcedure('ResetChildren', TDockZone_ResetChildren_si, 0, False);
  AData.AddProcedure('ResetZoneLimits', TDockZone_ResetZoneLimits_si, 0, False);
  AData.AddProcedure('Update', TDockZone_Update_si, 0, False);
  AData.AddProperty('ChildCount', TDockZone_ChildCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ChildControl', TDockZone_ChildControl_si, TControl_sw, True, False, 0, False, False);
  AData.AddProperty('Height', TDockZone_Height_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Left', TDockZone_Left_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('LimitBegin', TDockZone_LimitBegin_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('LimitSize', TDockZone_LimitSize_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Top', TDockZone_Top_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Visible', TDockZone_Visible_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('VisibleChildCount', TDockZone_VisibleChildCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Width', TDockZone_Width_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ZoneLimit', TDockZone_ZoneLimit_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TDockZone_Create_si, 1, False);
end;

class function TDockZone_sw.ToVar(const AValue: TDockZone): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDockZone_sw.FromVar(const AValue: OleVariant): TDockZone;
begin
  Result := TDockZone(ConvFromVar(AValue, TDockZone));
end;

class function TDockZone_sw.ClassToVar(AClass: TDockZone_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDockZone_sw.ClassFromVar(
  const AClass: OleVariant): TDockZone_sc;
begin
  Result := TDockZone_sc(ConvClsFromVar(AClass, TDockZone));
end;

{ TForEachZoneProc_sh }

function TForEachZoneProc_sh.GetHandler: TMethod;
var
  hdr: TForEachZoneProc;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TForEachZoneProc_sh.Handler(Zone: TDockZone);
var
  args: array[0..0] of OleVariant;
begin
  // procedure (Zone: TDockZone) of object

  args[0] := TDockZone_sw.ToVar(Zone);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TForEachZoneProc_sw }

class function TForEachZoneProc_sw.GetTypeName: WideString;
begin
  Result := 'TForEachZoneProc';
end;

class function TForEachZoneProc_sw.GetScriptHandlerClass: TClass;
begin
  Result := TForEachZoneProc_sh;
end;

class function TForEachZoneProc_sw.ToVar(
  const AValue: TForEachZoneProc): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TForEachZoneProc_sw.FromVar(
  const AValue: OleVariant): TForEachZoneProc;
begin
  Result := TForEachZoneProc(ConvFromVar(AValue));
end;

class function TForEachZoneProc_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TForEachZoneProc;
var
  hdlr: TForEachZoneProc_sh;
begin
  hdlr   := TForEachZoneProc_sh(AScriptControl.GetEventHandler(AProcName, 
    TForEachZoneProc_sw));
  Result := hdlr.Handler;
end;

{ TDockTreeClass_sw }

class function TDockTreeClass_sw.GetTypeName: WideString;
begin
  Result := 'TDockTreeClass';
end;

class function TDockTreeClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TDockTree;
end;

class function TDockTreeClass_sw.ToVar(
  const AValue: TDockTreeClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDockTreeClass_sw.FromVar(
  const AValue: OleVariant): TDockTreeClass;
begin
  Result := TDockTreeClass(ConvFromVar(AValue, TDockTree));
end;

{ TDockTree_sw }

function TDockTree_DockSite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DockSite: TWinControl read <getter> wr...

  if IsGet then
    Result := TWinControl_sw.ToVar(TDockTree_sacc(TDockTree(AObj)).DockSite)
  else
    TDockTree_sacc(TDockTree(AObj)).DockSite := TWinControl_sw.FromVar(
      AArgs[0]);
end;

function TDockTree_RelativeSizes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property RelativeSizes: Boolean read <getter> w...

  if IsGet then
    Result := TDockTree_sacc(TDockTree(AObj)).RelativeSizes
  else
    TDockTree_sacc(TDockTree(AObj)).RelativeSizes := Boolean(AArgs[0]);
end;

function TDockTree_TopZone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TopZone: TDockZone read <getter>;

  Result := TDockZone_sw.ToVar(TDockTree_sacc(TDockTree(AObj)).TopZone);
end;

function TDockTree_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(DockSite: TWinControl);

  Result := TDockTree_sw.ToVar(TDockTree_sc(AObj).Create(TWinControl_sw.FromVar(
    AArgs[0])));
end;

function TDockTree_PaintSite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PaintSite(DC: HDC);

  TDockTree(AObj).PaintSite(HDC_sw.FromVar(AArgs[0]));
end;

class function TDockTree_sw.GetTypeName: WideString;
begin
  Result := 'TDockTree';
end;

class function TDockTree_sw.GetWrappedClass: TClass;
begin
  Result := TDockTree;
end;

class procedure TDockTree_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DockSite', TDockTree_DockSite_si, TWinControl_sw, True, True, 0, True, False);
  AData.AddProperty('RelativeSizes', TDockTree_RelativeSizes_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('TopZone', TDockTree_TopZone_si, TDockZone_sw, True, False, 0, True, False);
  AData.AddProcedure('PaintSite', TDockTree_PaintSite_si, 1, False);

  { Class members }

  AData.AddConstructor('Create', TDockTree_Create_si, 1, False);
end;

class function TDockTree_sw.ToVar(const AValue: TDockTree): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TDockTree_sw.FromVar(const AValue: OleVariant): TDockTree;
begin
  Result := TDockTree(ConvFromVar(AValue, TDockTree));
end;

class function TDockTree_sw.ClassToVar(AClass: TDockTree_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TDockTree_sw.ClassFromVar(
  const AClass: OleVariant): TDockTree_sc;
begin
  Result := TDockTree_sc(ConvClsFromVar(AClass, TDockTree));
end;

{ TPanningWindowClass_sw }

class function TPanningWindowClass_sw.GetTypeName: WideString;
begin
  Result := 'TPanningWindowClass';
end;

class function TPanningWindowClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomPanningWindow;
end;

class function TPanningWindowClass_sw.ToVar(
  const AValue: TPanningWindowClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPanningWindowClass_sw.FromVar(
  const AValue: OleVariant): TPanningWindowClass;
begin
  Result := TPanningWindowClass(ConvFromVar(AValue, TCustomPanningWindow));
end;

{ TCustomPanningWindow_sw }

function TCustomPanningWindow_GetIsPanning_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetIsPanning: Boolean;

  Result := TCustomPanningWindow(AObj).GetIsPanning();
end;

function TCustomPanningWindow_StartPanning_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StartPanning(AHandle: THandle; AControl: TContro...

  Result := TCustomPanningWindow(AObj).StartPanning(THandle_sw.FromVar(
    AArgs[0]), TControl_sw.FromVar(AArgs[1]));
end;

function TCustomPanningWindow_StopPanning_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure StopPanning;

  TCustomPanningWindow(AObj).StopPanning();
end;

class function TCustomPanningWindow_sw.GetTypeName: WideString;
begin
  Result := 'TCustomPanningWindow';
end;

class function TCustomPanningWindow_sw.GetWrappedClass: TClass;
begin
  Result := TCustomPanningWindow;
end;

class procedure TCustomPanningWindow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetIsPanning', TCustomPanningWindow_GetIsPanning_si, Boolean_sw, 0, False);
  AData.AddFunction('StartPanning', TCustomPanningWindow_StartPanning_si, Boolean_sw, 2, False);
  AData.AddProcedure('StopPanning', TCustomPanningWindow_StopPanning_si, 0, False);
end;

class function TCustomPanningWindow_sw.ToVar(
  const AValue: TCustomPanningWindow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomPanningWindow_sw.FromVar(
  const AValue: OleVariant): TCustomPanningWindow;
begin
  Result := TCustomPanningWindow(ConvFromVar(AValue, TCustomPanningWindow));
end;

class function TCustomPanningWindow_sw.ClassToVar(
  AClass: TCustomPanningWindow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomPanningWindow_sw.ClassFromVar(
  const AClass: OleVariant): TCustomPanningWindow_sc;
begin
  Result := TCustomPanningWindow_sc(ConvClsFromVar(AClass, 
    TCustomPanningWindow));
end;

{ TMouse_sw }

function TMouse_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TMouse_sw.ToVar(TMouse_sc(AObj).Create());
end;

function TMouse_SettingChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SettingChanged(Setting: Integer);

  TMouse(AObj).SettingChanged(Integer(AArgs[0]));
end;

function TMouse_CreatePanningWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreatePanningWindow: TCustomPanningWindow;

  Result := TCustomPanningWindow_sw.ToVar(TMouse(AObj).CreatePanningWindow());
end;

function TMouse_Capture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Capture: HWND read <getter> write <setter>;

  if IsGet then
    Result := HWND_sw.ToVar(TMouse(AObj).Capture)
  else
    TMouse(AObj).Capture := HWND_sw.FromVar(AArgs[0]);
end;

function TMouse_CursorPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CursorPos: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TMouse(AObj).CursorPos)
  else
    TMouse(AObj).CursorPos := TPoint_sw.FromVar(AArgs[0]);
end;

function TMouse_DragImmediate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragImmediate: Boolean read <getter> write <sett...

  if IsGet then
    Result := TMouse(AObj).DragImmediate
  else
    TMouse(AObj).DragImmediate := Boolean(AArgs[0]);
end;

function TMouse_DragThreshold_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DragThreshold: Integer read <getter> write <sett...

  if IsGet then
    Result := TMouse(AObj).DragThreshold
  else
    TMouse(AObj).DragThreshold := Integer(AArgs[0]);
end;

function TMouse_MousePresent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MousePresent: Boolean read <getter>;

  Result := TMouse(AObj).MousePresent;
end;

function TMouse_IsDragging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsDragging: Boolean read <getter>;

  Result := TMouse(AObj).IsDragging;
end;

function TMouse_IsPanning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsPanning: Boolean read <getter>;

  Result := TMouse(AObj).IsPanning;
end;

function TMouse_PanningWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanningWindow: TCustomPanningWindow read <getter...

  if IsGet then
    Result := TCustomPanningWindow_sw.ToVar(TMouse(AObj).PanningWindow)
  else
    TMouse(AObj).PanningWindow := TCustomPanningWindow_sw.FromVar(AArgs[0]);
end;

function TMouse_PanningWindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PanningWindowClass: TPanningWindowClass read <ge...

  if IsGet then
    Result := TPanningWindowClass_sw.ToVar(TMouse(AObj).PanningWindowClass)
  else
    TMouse(AObj).PanningWindowClass := TPanningWindowClass_sw.FromVar(AArgs[0]);
end;

function TMouse_RegWheelMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property RegWheelMessage: UINT read <getter>;

  Result := UINT_sw.ToVar(TMouse(AObj).RegWheelMessage);
end;

function TMouse_WheelPresent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WheelPresent: Boolean read <getter>;

  Result := TMouse(AObj).WheelPresent;
end;

function TMouse_WheelScrollLines_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WheelScrollLines: Integer read <getter>;

  Result := TMouse(AObj).WheelScrollLines;
end;

class function TMouse_sw.GetTypeName: WideString;
begin
  Result := 'TMouse';
end;

class function TMouse_sw.GetWrappedClass: TClass;
begin
  Result := TMouse;
end;

class procedure TMouse_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SettingChanged', TMouse_SettingChanged_si, 1, False);
  AData.AddFunction('CreatePanningWindow', TMouse_CreatePanningWindow_si, TCustomPanningWindow_sw, 0, False);
  AData.AddProperty('Capture', TMouse_Capture_si, HWND_sw, True, True, 0, False, False);
  AData.AddProperty('CursorPos', TMouse_CursorPos_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('DragImmediate', TMouse_DragImmediate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('DragThreshold', TMouse_DragThreshold_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MousePresent', TMouse_MousePresent_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('IsDragging', TMouse_IsDragging_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('IsPanning', TMouse_IsPanning_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('PanningWindow', TMouse_PanningWindow_si, TCustomPanningWindow_sw, True, True, 0, False, False);
  AData.AddProperty('PanningWindowClass', TMouse_PanningWindowClass_si, TPanningWindowClass_sw, True, True, 0, False, False);
  AData.AddProperty('RegWheelMessage', TMouse_RegWheelMessage_si, UINT_sw, True, False, 0, False, False);
  AData.AddProperty('WheelPresent', TMouse_WheelPresent_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('WheelScrollLines', TMouse_WheelScrollLines_si, Integer_sw, True, False, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TMouse_Create_si, 0, False);
end;

class function TMouse_sw.ToVar(const AValue: TMouse): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMouse_sw.FromVar(const AValue: OleVariant): TMouse;
begin
  Result := TMouse(ConvFromVar(AValue, TMouse));
end;

class function TMouse_sw.ClassToVar(AClass: TMouse_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMouse_sw.ClassFromVar(const AClass: OleVariant): TMouse_sc;
begin
  Result := TMouse_sc(ConvClsFromVar(AClass, TMouse));
end;

{ TCustomListControl_sw }

function TCustomListControl_AddItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AddItem(Item: string; AObject: TObject);

  TCustomListControl(AObj).AddItem(string(AArgs[0]), TObject_sw.FromVar(
    AArgs[1]));
end;

function TCustomListControl_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Clear;

  TCustomListControl(AObj).Clear();
end;

function TCustomListControl_ClearSelection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ClearSelection;

  TCustomListControl(AObj).ClearSelection();
end;

function TCustomListControl_CopySelection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CopySelection(Destination: TCustomListControl);

  TCustomListControl(AObj).CopySelection(TCustomListControl_sw.FromVar(
    AArgs[0]));
end;

function TCustomListControl_DeleteSelected_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DeleteSelected;

  TCustomListControl(AObj).DeleteSelected();
end;

function TCustomListControl_GetCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCount: Integer;

  Result := TCustomListControl(AObj).GetCount();
end;

function TCustomListControl_MoveSelection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MoveSelection(Destination: TCustomListControl);

  TCustomListControl(AObj).MoveSelection(TCustomListControl_sw.FromVar(
    AArgs[0]));
end;

function TCustomListControl_SelectAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SelectAll;

  TCustomListControl(AObj).SelectAll();
end;

function TCustomListControl_ItemIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ItemIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomListControl(AObj).ItemIndex
  else
    TCustomListControl(AObj).ItemIndex := Integer(AArgs[0]);
end;

class function TCustomListControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomListControl';
end;

class function TCustomListControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomListControl;
end;

class procedure TCustomListControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('AddItem', TCustomListControl_AddItem_si, 2, False);
  AData.AddProcedure('Clear', TCustomListControl_Clear_si, 0, False);
  AData.AddProcedure('ClearSelection', TCustomListControl_ClearSelection_si, 0, False);
  AData.AddProcedure('CopySelection', TCustomListControl_CopySelection_si, 1, False);
  AData.AddProcedure('DeleteSelected', TCustomListControl_DeleteSelected_si, 0, False);
  AData.AddFunction('GetCount', TCustomListControl_GetCount_si, Integer_sw, 0, False);
  AData.AddProcedure('MoveSelection', TCustomListControl_MoveSelection_si, 1, False);
  AData.AddProcedure('SelectAll', TCustomListControl_SelectAll_si, 0, False);
  AData.AddProperty('ItemIndex', TCustomListControl_ItemIndex_si, Integer_sw, True, True, 0, False, False);
end;

class function TCustomListControl_sw.ToVar(
  const AValue: TCustomListControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomListControl_sw.FromVar(
  const AValue: OleVariant): TCustomListControl;
begin
  Result := TCustomListControl(ConvFromVar(AValue, TCustomListControl));
end;

class function TCustomListControl_sw.ClassToVar(
  AClass: TCustomListControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomListControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomListControl_sc;
begin
  Result := TCustomListControl_sc(ConvClsFromVar(AClass, TCustomListControl));
end;

{ TCustomMultiSelectListControl_sw }

function TCustomMultiSelectListControl_MultiSelect_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MultiSelect: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomMultiSelectListControl(AObj).MultiSelect
  else
    TCustomMultiSelectListControl(AObj).MultiSelect := Boolean(AArgs[0]);
end;

function TCustomMultiSelectListControl_SelCount_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SelCount: Integer read <getter>;

  Result := TCustomMultiSelectListControl(AObj).SelCount;
end;

class function TCustomMultiSelectListControl_sw.GetTypeName: WideString;
begin
  Result := 'TCustomMultiSelectListControl';
end;

class function TCustomMultiSelectListControl_sw.GetWrappedClass: TClass;
begin
  Result := TCustomMultiSelectListControl;
end;

class procedure TCustomMultiSelectListControl_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MultiSelect', TCustomMultiSelectListControl_MultiSelect_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SelCount', TCustomMultiSelectListControl_SelCount_si, Integer_sw, True, False, 0, False, False);
end;

class function TCustomMultiSelectListControl_sw.ToVar(
  const AValue: TCustomMultiSelectListControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomMultiSelectListControl_sw.FromVar(
  const AValue: OleVariant): TCustomMultiSelectListControl;
begin
  Result := TCustomMultiSelectListControl(ConvFromVar(AValue, 
    TCustomMultiSelectListControl));
end;

class function TCustomMultiSelectListControl_sw.ClassToVar(
  AClass: TCustomMultiSelectListControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomMultiSelectListControl_sw.ClassFromVar(
  const AClass: OleVariant): TCustomMultiSelectListControl_sc;
begin
  Result := TCustomMultiSelectListControl_sc(ConvClsFromVar(AClass, 
    TCustomMultiSelectListControl));
end;

{ TBalloonHintIcon_sw }

class function TBalloonHintIcon_sw.GetTypeName: WideString;
begin
  Result := 'TBalloonHintIcon';
end;

class procedure TBalloonHintIcon_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'bhInfo'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIcon.{$ENDIF}bhInfo)),
    (Name: 'bhWarning'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIcon.{$ENDIF}bhWarning)),
    (Name: 'bhError'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIcon.{$ENDIF}bhError))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TBalloonHintIcon_sw.ToVar(
  const AValue: TBalloonHintIcon): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBalloonHintIcon_sw.FromVar(
  const AValue: OleVariant): TBalloonHintIcon;
begin
  Result := TBalloonHintIcon(Integer(AValue));
end;

{ TBalloonHintIconSize_sw }

class function TBalloonHintIconSize_sw.GetTypeName: WideString;
begin
  Result := 'TBalloonHintIconSize';
end;

class procedure TBalloonHintIconSize_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'bhsNormal'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIconSize.{$ENDIF}bhsNormal)),
    (Name: 'bhsLarge'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIconSize.{$ENDIF}bhsLarge)),
    (Name: 'bhsSmall'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintIconSize.{$ENDIF}bhsSmall))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TBalloonHintIconSize_sw.ToVar(
  const AValue: TBalloonHintIconSize): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBalloonHintIconSize_sw.FromVar(
  const AValue: OleVariant): TBalloonHintIconSize;
begin
  Result := TBalloonHintIconSize(Integer(AValue));
end;

{ TBalloonHintStyle_sw }

class function TBalloonHintStyle_sw.GetTypeName: WideString;
begin
  Result := 'TBalloonHintStyle';
end;

class procedure TBalloonHintStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'bhsStandard'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintStyle.{$ENDIF}bhsStandard)),
    (Name: 'bhsBalloon'; Value: Integer({$IFDEF LMDSCT_12}TBalloonHintStyle.{$ENDIF}bhsBalloon))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TBalloonHintStyle_sw.ToVar(
  const AValue: TBalloonHintStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBalloonHintStyle_sw.FromVar(
  const AValue: OleVariant): TBalloonHintStyle;
begin
  Result := TBalloonHintStyle(Integer(AValue));
end;

{ TCustomHintWindow_sw }

function TCustomHintWindow_AutoSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure AutoSize;

  TCustomHintWindow(AObj).AutoSize();
end;

function TCustomHintWindow_PositionAt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function PositionAt(...); overload;

  TCustomHintWindow(AObj).PositionAt(TPoint_sw.FromVar(AArgs[0]));
end;

function TCustomHintWindow_PositionAtCursor_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PositionAtCursor;

  TCustomHintWindow(AObj).PositionAtCursor();
end;

function TCustomHintWindow_HintParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintParent: TCustomHint read <getter> write <set...

  if IsGet then
    Result := TCustomHint_sw.ToVar(TCustomHintWindow(AObj).HintParent)
  else
    TCustomHintWindow(AObj).HintParent := TCustomHint_sw.FromVar(AArgs[0]);
end;

function TCustomHintWindow_PopAbove_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopAbove: Boolean read <getter>;

  Result := TCustomHintWindow(AObj).PopAbove;
end;

function TCustomHintWindow_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter>;

  Result := TCustomHintWindow(AObj).Title;
end;

function TCustomHintWindow_Description_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Description: string read <getter>;

  Result := TCustomHintWindow(AObj).Description;
end;

function TCustomHintWindow_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter>;

  Result := TImageIndex_sw.ToVar(TCustomHintWindow(AObj).ImageIndex);
end;

class function TCustomHintWindow_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHintWindow';
end;

class function TCustomHintWindow_sw.GetWrappedClass: TClass;
begin
  Result := TCustomHintWindow;
end;

class procedure TCustomHintWindow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('AutoSize', TCustomHintWindow_AutoSize_si, 0, False);
  AData.AddProcedure('PositionAt', TCustomHintWindow_PositionAt_si, 1, False);
  AData.AddProcedure('PositionAtCursor', TCustomHintWindow_PositionAtCursor_si, 0, False);
  AData.AddProperty('HintParent', TCustomHintWindow_HintParent_si, TCustomHint_sw, True, True, 0, False, False);
  AData.AddProperty('PopAbove', TCustomHintWindow_PopAbove_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Title', TCustomHintWindow_Title_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('Description', TCustomHintWindow_Description_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('ImageIndex', TCustomHintWindow_ImageIndex_si, TImageIndex_sw, True, False, 0, False, False);
end;

class function TCustomHintWindow_sw.ToVar(
  const AValue: TCustomHintWindow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomHintWindow_sw.FromVar(
  const AValue: OleVariant): TCustomHintWindow;
begin
  Result := TCustomHintWindow(ConvFromVar(AValue, TCustomHintWindow));
end;

class function TCustomHintWindow_sw.ClassToVar(
  AClass: TCustomHintWindow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomHintWindow_sw.ClassFromVar(
  const AClass: OleVariant): TCustomHintWindow_sc;
begin
  Result := TCustomHintWindow_sc(ConvClsFromVar(AClass, TCustomHintWindow));
end;

{ TCustomHintShowHideThread_sw }

function TCustomHintShowHideThread_Create_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  Result := TCustomHintShowHideThread_sw.ToVar(TCustomHintShowHideThread_sc(
    AObj).Create(TCustomHintWindow_sw.FromVar(AArgs[0]), TCustomHint_sw.FromVar(
    AArgs[1])));
end;

function TCustomHintShowHideThread_ResumeWork_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResumeWork;

  TCustomHintShowHideThread(AObj).ResumeWork();
end;

function TCustomHintShowHideThread_HideHint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HideHint;

  TCustomHintShowHideThread(AObj).HideHint();
end;

class function TCustomHintShowHideThread_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHintShowHideThread';
end;

class function TCustomHintShowHideThread_sw.GetWrappedClass: TClass;
begin
  Result := TCustomHintShowHideThread;
end;

class procedure TCustomHintShowHideThread_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ResumeWork', TCustomHintShowHideThread_ResumeWork_si, 0, False);
  AData.AddProcedure('HideHint', TCustomHintShowHideThread_HideHint_si, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCustomHintShowHideThread_Create_si, 2, False);
end;

class function TCustomHintShowHideThread_sw.ToVar(
  const AValue: TCustomHintShowHideThread): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomHintShowHideThread_sw.FromVar(
  const AValue: OleVariant): TCustomHintShowHideThread;
begin
  Result := TCustomHintShowHideThread(ConvFromVar(AValue, 
    TCustomHintShowHideThread));
end;

class function TCustomHintShowHideThread_sw.ClassToVar(
  AClass: TCustomHintShowHideThread_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomHintShowHideThread_sw.ClassFromVar(
  const AClass: OleVariant): TCustomHintShowHideThread_sc;
begin
  Result := TCustomHintShowHideThread_sc(ConvClsFromVar(AClass, 
    TCustomHintShowHideThread));
end;

{ TCustomHint_sw }

function TCustomHint_WorkComplete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WorkComplete: Boolean read <getter>;

  Result := TCustomHint_sacc(TCustomHint(AObj)).WorkComplete;
end;

function TCustomHint_ShowHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function ShowHint(...); overload;

  case AArgsSize of
    0:
    begin
      TCustomHint(AObj).ShowHint();
    end;
    1:
    begin
      TCustomHint(AObj).ShowHint(TPoint_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('ShowHint');
  end;
end;

function TCustomHint_HideHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function HideHint(...); overload;

  case AArgsSize of
    0:
    begin
      TCustomHint(AObj).HideHint();
    end;
    1:
    begin
      TCustomHint(AObj).HideHint(TControl_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('HideHint');
  end;
end;

function TCustomHint_PaintHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PaintHint(HintWindow: TCustomHintWindow);

  TCustomHint(AObj).PaintHint(TCustomHintWindow_sw.FromVar(AArgs[0]));
end;

function TCustomHint_NCPaintHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NCPaintHint(HintWindow: TCustomHintWindow; DC: ...

  TCustomHint(AObj).NCPaintHint(TCustomHintWindow_sw.FromVar(AArgs[0]), HDC_sw.
    FromVar(AArgs[1]));
end;

function TCustomHint_SetHintSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetHintSize(HintWindow: TCustomHintWindow);

  TCustomHint(AObj).SetHintSize(TCustomHintWindow_sw.FromVar(AArgs[0]));
end;

function TCustomHint_ShowingHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowingHint: Boolean read <getter>;

  Result := TCustomHint(AObj).ShowingHint;
end;

function TCustomHint_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomHint(AObj).Title
  else
    TCustomHint(AObj).Title := string(AArgs[0]);
end;

function TCustomHint_Description_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Description: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomHint(AObj).Description
  else
    TCustomHint(AObj).Description := string(AArgs[0]);
end;

function TCustomHint_ImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ImageIndex: TImageIndex read <getter> write <set...

  if IsGet then
    Result := TImageIndex_sw.ToVar(TCustomHint(AObj).ImageIndex)
  else
    TCustomHint(AObj).ImageIndex := TImageIndex_sw.FromVar(AArgs[0]);
end;

function TCustomHint_Images_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Images: TImageList read <getter> write <setter>;

  if IsGet then
    Result := TImageList_sw.ToVar(TCustomHint(AObj).Images)
  else
    TCustomHint(AObj).Images := TImageList_sw.FromVar(AArgs[0]);
end;

function TCustomHint_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TBalloonHintStyle read <getter> write <se...

  if IsGet then
    Result := TBalloonHintStyle_sw.ToVar(TCustomHint(AObj).Style)
  else
    TCustomHint(AObj).Style := TBalloonHintStyle_sw.FromVar(AArgs[0]);
end;

function TCustomHint_Delay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Delay: Cardinal read <getter> write <setter>;

  if IsGet then
    Result := TCustomHint(AObj).Delay
  else
    TCustomHint(AObj).Delay := Cardinal(AArgs[0]);
end;

function TCustomHint_HideAfter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HideAfter: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomHint(AObj).HideAfter
  else
    TCustomHint(AObj).HideAfter := Integer(AArgs[0]);
end;

class function TCustomHint_sw.GetTypeName: WideString;
begin
  Result := 'TCustomHint';
end;

class function TCustomHint_sw.GetWrappedClass: TClass;
begin
  Result := TCustomHint;
end;

class procedure TCustomHint_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('WorkComplete', TCustomHint_WorkComplete_si, Boolean_sw, True, False, 0, True, False);
  AData.AddProcedure('ShowHint', TCustomHint_ShowHint_si, 0, True);
  AData.AddProcedure('HideHint', TCustomHint_HideHint_si, 0, True);
  AData.AddProcedure('PaintHint', TCustomHint_PaintHint_si, 1, False);
  AData.AddProcedure('NCPaintHint', TCustomHint_NCPaintHint_si, 2, False);
  AData.AddProcedure('SetHintSize', TCustomHint_SetHintSize_si, 1, False);
  AData.AddProperty('ShowingHint', TCustomHint_ShowingHint_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Title', TCustomHint_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Description', TCustomHint_Description_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ImageIndex', TCustomHint_ImageIndex_si, TImageIndex_sw, True, True, 0, False, False);
  AData.AddProperty('Images', TCustomHint_Images_si, TImageList_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TCustomHint_Style_si, TBalloonHintStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Delay', TCustomHint_Delay_si, Cardinal_sw, True, True, 0, False, False);
  AData.AddProperty('HideAfter', TCustomHint_HideAfter_si, Integer_sw, True, True, 0, False, False);
end;

class function TCustomHint_sw.ToVar(const AValue: TCustomHint): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomHint_sw.FromVar(const AValue: OleVariant): TCustomHint;
begin
  Result := TCustomHint(ConvFromVar(AValue, TCustomHint));
end;

class function TCustomHint_sw.ClassToVar(AClass: TCustomHint_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomHint_sw.ClassFromVar(
  const AClass: OleVariant): TCustomHint_sc;
begin
  Result := TCustomHint_sc(ConvClsFromVar(AClass, TCustomHint));
end;

{ TBalloonHint_sw }

class function TBalloonHint_sw.GetTypeName: WideString;
begin
  Result := 'TBalloonHint';
end;

class function TBalloonHint_sw.GetWrappedClass: TClass;
begin
  Result := TBalloonHint;
end;

class procedure TBalloonHint_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBalloonHint_sw.ToVar(const AValue: TBalloonHint): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBalloonHint_sw.FromVar(const AValue: OleVariant): TBalloonHint;
begin
  Result := TBalloonHint(ConvFromVar(AValue, TBalloonHint));
end;

class function TBalloonHint_sw.ClassToVar(AClass: TBalloonHint_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBalloonHint_sw.ClassFromVar(
  const AClass: OleVariant): TBalloonHint_sc;
begin
  Result := TBalloonHint_sc(ConvClsFromVar(AClass, TBalloonHint));
end;

{ Controls_sw }

function Controls_CM_BASE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_BASE = <value>;

  Result := CM_BASE;
end;

function Controls_CM_CLROFFSET_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CLROFFSET = <value>;

  Result := CM_CLROFFSET;
end;

function Controls_CM_ACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ACTIVATE = <value>;

  Result := CM_ACTIVATE;
end;

function Controls_CM_DEACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DEACTIVATE = <value>;

  Result := CM_DEACTIVATE;
end;

function Controls_CM_GOTFOCUS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_GOTFOCUS = <value>;

  Result := CM_GOTFOCUS;
end;

function Controls_CM_LOSTFOCUS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_LOSTFOCUS = <value>;

  Result := CM_LOSTFOCUS;
end;

function Controls_CM_CANCELMODE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CANCELMODE = <value>;

  Result := CM_CANCELMODE;
end;

function Controls_CM_DIALOGKEY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DIALOGKEY = <value>;

  Result := CM_DIALOGKEY;
end;

function Controls_CM_DIALOGCHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DIALOGCHAR = <value>;

  Result := CM_DIALOGCHAR;
end;

function Controls_CM_FOCUSCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_FOCUSCHANGED = <value>;

  Result := CM_FOCUSCHANGED;
end;

function Controls_CM_PARENTFONTCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTFONTCHANGED = <value>;

  Result := CM_PARENTFONTCHANGED;
end;

function Controls_CM_PARENTCOLORCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTCOLORCHANGED = <value>;

  Result := CM_PARENTCOLORCHANGED;
end;

function Controls_CM_HITTEST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_HITTEST = <value>;

  Result := CM_HITTEST;
end;

function Controls_CM_VISIBLECHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_VISIBLECHANGED = <value>;

  Result := CM_VISIBLECHANGED;
end;

function Controls_CM_ENABLEDCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ENABLEDCHANGED = <value>;

  Result := CM_ENABLEDCHANGED;
end;

function Controls_CM_COLORCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_COLORCHANGED = <value>;

  Result := CM_COLORCHANGED;
end;

function Controls_CM_FONTCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_FONTCHANGED = <value>;

  Result := CM_FONTCHANGED;
end;

function Controls_CM_CURSORCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CURSORCHANGED = <value>;

  Result := CM_CURSORCHANGED;
end;

function Controls_CM_CTL3DCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CTL3DCHANGED = <value>;

  Result := CM_CTL3DCHANGED;
end;

function Controls_CM_PARENTCTL3DCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTCTL3DCHANGED = <value>;

  Result := CM_PARENTCTL3DCHANGED;
end;

function Controls_CM_TEXTCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_TEXTCHANGED = <value>;

  Result := CM_TEXTCHANGED;
end;

function Controls_CM_MOUSEENTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_MOUSEENTER = <value>;

  Result := CM_MOUSEENTER;
end;

function Controls_CM_MOUSELEAVE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_MOUSELEAVE = <value>;

  Result := CM_MOUSELEAVE;
end;

function Controls_CM_MENUCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_MENUCHANGED = <value>;

  Result := CM_MENUCHANGED;
end;

function Controls_CM_APPKEYDOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_APPKEYDOWN = <value>;

  Result := CM_APPKEYDOWN;
end;

function Controls_CM_APPSYSCOMMAND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_APPSYSCOMMAND = <value>;

  Result := CM_APPSYSCOMMAND;
end;

function Controls_CM_BUTTONPRESSED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_BUTTONPRESSED = <value>;

  Result := CM_BUTTONPRESSED;
end;

function Controls_CM_SHOWINGCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SHOWINGCHANGED = <value>;

  Result := CM_SHOWINGCHANGED;
end;

function Controls_CM_ENTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ENTER = <value>;

  Result := CM_ENTER;
end;

function Controls_CM_EXIT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_EXIT = <value>;

  Result := CM_EXIT;
end;

function Controls_CM_DESIGNHITTEST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DESIGNHITTEST = <value>;

  Result := CM_DESIGNHITTEST;
end;

function Controls_CM_ICONCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ICONCHANGED = <value>;

  Result := CM_ICONCHANGED;
end;

function Controls_CM_WANTSPECIALKEY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_WANTSPECIALKEY = <value>;

  Result := CM_WANTSPECIALKEY;
end;

function Controls_CM_INVOKEHELP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_INVOKEHELP = <value>;

  Result := CM_INVOKEHELP;
end;

function Controls_CM_WINDOWHOOK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_WINDOWHOOK = <value>;

  Result := CM_WINDOWHOOK;
end;

function Controls_CM_RELEASE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_RELEASE = <value>;

  Result := CM_RELEASE;
end;

function Controls_CM_SHOWHINTCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SHOWHINTCHANGED = <value>;

  Result := CM_SHOWHINTCHANGED;
end;

function Controls_CM_PARENTSHOWHINTCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTSHOWHINTCHANGED = <value>;

  Result := CM_PARENTSHOWHINTCHANGED;
end;

function Controls_CM_SYSCOLORCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SYSCOLORCHANGE = <value>;

  Result := CM_SYSCOLORCHANGE;
end;

function Controls_CM_WININICHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_WININICHANGE = <value>;

  Result := CM_WININICHANGE;
end;

function Controls_CM_FONTCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_FONTCHANGE = <value>;

  Result := CM_FONTCHANGE;
end;

function Controls_CM_TIMECHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_TIMECHANGE = <value>;

  Result := CM_TIMECHANGE;
end;

function Controls_CM_TABSTOPCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_TABSTOPCHANGED = <value>;

  Result := CM_TABSTOPCHANGED;
end;

function Controls_CM_UIACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_UIACTIVATE = <value>;

  Result := CM_UIACTIVATE;
end;

function Controls_CM_UIDEACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_UIDEACTIVATE = <value>;

  Result := CM_UIDEACTIVATE;
end;

function Controls_CM_DOCWINDOWACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DOCWINDOWACTIVATE = <value>;

  Result := CM_DOCWINDOWACTIVATE;
end;

function Controls_CM_CONTROLLISTCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CONTROLLISTCHANGE = <value>;

  Result := CM_CONTROLLISTCHANGE;
end;

function Controls_CM_GETDATALINK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_GETDATALINK = <value>;

  Result := CM_GETDATALINK;
end;

function Controls_CM_CHILDKEY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CHILDKEY = <value>;

  Result := CM_CHILDKEY;
end;

function Controls_CM_DRAG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DRAG = <value>;

  Result := CM_DRAG;
end;

function Controls_CM_HINTSHOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_HINTSHOW = <value>;

  Result := CM_HINTSHOW;
end;

function Controls_CM_DIALOGHANDLE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DIALOGHANDLE = <value>;

  Result := CM_DIALOGHANDLE;
end;

function Controls_CM_ISTOOLCONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ISTOOLCONTROL = <value>;

  Result := CM_ISTOOLCONTROL;
end;

function Controls_CM_RECREATEWND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_RECREATEWND = <value>;

  Result := CM_RECREATEWND;
end;

function Controls_CM_INVALIDATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_INVALIDATE = <value>;

  Result := CM_INVALIDATE;
end;

function Controls_CM_SYSFONTCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SYSFONTCHANGED = <value>;

  Result := CM_SYSFONTCHANGED;
end;

function Controls_CM_CONTROLCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CONTROLCHANGE = <value>;

  Result := CM_CONTROLCHANGE;
end;

function Controls_CM_CHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CHANGED = <value>;

  Result := CM_CHANGED;
end;

function Controls_CM_DOCKCLIENT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DOCKCLIENT = <value>;

  Result := CM_DOCKCLIENT;
end;

function Controls_CM_UNDOCKCLIENT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_UNDOCKCLIENT = <value>;

  Result := CM_UNDOCKCLIENT;
end;

function Controls_CM_FLOAT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_FLOAT = <value>;

  Result := CM_FLOAT;
end;

function Controls_CM_BORDERCHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_BORDERCHANGED = <value>;

  Result := CM_BORDERCHANGED;
end;

function Controls_CM_BIDIMODECHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_BIDIMODECHANGED = <value>;

  Result := CM_BIDIMODECHANGED;
end;

function Controls_CM_PARENTBIDIMODECHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTBIDIMODECHANGED = <value>;

  Result := CM_PARENTBIDIMODECHANGED;
end;

function Controls_CM_ALLCHILDRENFLIPPED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ALLCHILDRENFLIPPED = <value>;

  Result := CM_ALLCHILDRENFLIPPED;
end;

function Controls_CM_ACTIONUPDATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ACTIONUPDATE = <value>;

  Result := CM_ACTIONUPDATE;
end;

function Controls_CM_ACTIONEXECUTE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ACTIONEXECUTE = <value>;

  Result := CM_ACTIONEXECUTE;
end;

function Controls_CM_HINTSHOWPAUSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_HINTSHOWPAUSE = <value>;

  Result := CM_HINTSHOWPAUSE;
end;

function Controls_CM_DOCKNOTIFICATION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DOCKNOTIFICATION = <value>;

  Result := CM_DOCKNOTIFICATION;
end;

function Controls_CM_MOUSEWHEEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_MOUSEWHEEL = <value>;

  Result := CM_MOUSEWHEEL;
end;

function Controls_CM_ISSHORTCUT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_ISSHORTCUT = <value>;

  Result := CM_ISSHORTCUT;
end;

function Controls_CM_UPDATEACTIONS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_UPDATEACTIONS = <value>;

  Result := CM_UPDATEACTIONS;
end;

function Controls_CM_INVALIDATEDOCKHOST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_INVALIDATEDOCKHOST = <value>;

  Result := CM_INVALIDATEDOCKHOST;
end;

function Controls_CM_SETACTIVECONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_SETACTIVECONTROL = <value>;

  Result := CM_SETACTIVECONTROL;
end;

function Controls_CM_POPUPHWNDDESTROY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_POPUPHWNDDESTROY = <value>;

  Result := CM_POPUPHWNDDESTROY;
end;

function Controls_CM_CREATEPOPUP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CREATEPOPUP = <value>;

  Result := CM_CREATEPOPUP;
end;

function Controls_CM_DESTROYHANDLE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DESTROYHANDLE = <value>;

  Result := CM_DESTROYHANDLE;
end;

function Controls_CM_MOUSEACTIVATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_MOUSEACTIVATE = <value>;

  Result := CM_MOUSEACTIVATE;
end;

function Controls_CM_BUFFEREDPRINTCLIENT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_BUFFEREDPRINTCLIENT = <value>;

  Result := CM_BUFFEREDPRINTCLIENT;
end;

function Controls_CM_UNTHEMECONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_UNTHEMECONTROL = <value>;

  Result := CM_UNTHEMECONTROL;
end;

function Controls_CM_DOUBLEBUFFEREDCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_DOUBLEBUFFEREDCHANGED = <value>;

  Result := CM_DOUBLEBUFFEREDCHANGED;
end;

function Controls_CM_PARENTDOUBLEBUFFEREDCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTDOUBLEBUFFEREDCHANGED = <value>;

  Result := CM_PARENTDOUBLEBUFFEREDCHANGED;
end;

function Controls_CM_THEMECHANGED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_THEMECHANGED = <value>;

  Result := CM_THEMECHANGED;
end;

function Controls_CM_GESTURE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_GESTURE = <value>;

  Result := CM_GESTURE;
end;

function Controls_CM_CUSTOMGESTURESCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_CUSTOMGESTURESCHANGED = <value>;

  Result := CM_CUSTOMGESTURESCHANGED;
end;

function Controls_CM_GESTUREMANAGERCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_GESTUREMANAGERCHANGED = <value>;

  Result := CM_GESTUREMANAGERCHANGED;
end;

function Controls_CM_STANDARDGESTURESCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_STANDARDGESTURESCHANGED = <value>;

  Result := CM_STANDARDGESTURESCHANGED;
end;

function Controls_CM_INPUTLANGCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_INPUTLANGCHANGE = <value>;

  Result := CM_INPUTLANGCHANGE;
end;

function Controls_CM_TABLETOPTIONSCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_TABLETOPTIONSCHANGED = <value>;

  Result := CM_TABLETOPTIONSCHANGED;
end;

function Controls_CM_PARENTTABLETOPTIONSCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CM_PARENTTABLETOPTIONSCHANGED = <value>;

  Result := CM_PARENTTABLETOPTIONSCHANGED;
end;

function Controls_CN_BASE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_BASE = <value>;

  Result := CN_BASE;
end;

function Controls_CN_CHARTOITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CHARTOITEM = <value>;

  Result := CN_CHARTOITEM;
end;

function Controls_CN_COMMAND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_COMMAND = <value>;

  Result := CN_COMMAND;
end;

function Controls_CN_COMPAREITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_COMPAREITEM = <value>;

  Result := CN_COMPAREITEM;
end;

function Controls_CN_CTLCOLORBTN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORBTN = <value>;

  Result := CN_CTLCOLORBTN;
end;

function Controls_CN_CTLCOLORDLG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORDLG = <value>;

  Result := CN_CTLCOLORDLG;
end;

function Controls_CN_CTLCOLOREDIT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLOREDIT = <value>;

  Result := CN_CTLCOLOREDIT;
end;

function Controls_CN_CTLCOLORLISTBOX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORLISTBOX = <value>;

  Result := CN_CTLCOLORLISTBOX;
end;

function Controls_CN_CTLCOLORMSGBOX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORMSGBOX = <value>;

  Result := CN_CTLCOLORMSGBOX;
end;

function Controls_CN_CTLCOLORSCROLLBAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORSCROLLBAR = <value>;

  Result := CN_CTLCOLORSCROLLBAR;
end;

function Controls_CN_CTLCOLORSTATIC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CTLCOLORSTATIC = <value>;

  Result := CN_CTLCOLORSTATIC;
end;

function Controls_CN_DELETEITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_DELETEITEM = <value>;

  Result := CN_DELETEITEM;
end;

function Controls_CN_DRAWITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_DRAWITEM = <value>;

  Result := CN_DRAWITEM;
end;

function Controls_CN_HSCROLL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_HSCROLL = <value>;

  Result := CN_HSCROLL;
end;

function Controls_CN_MEASUREITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_MEASUREITEM = <value>;

  Result := CN_MEASUREITEM;
end;

function Controls_CN_PARENTNOTIFY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_PARENTNOTIFY = <value>;

  Result := CN_PARENTNOTIFY;
end;

function Controls_CN_VKEYTOITEM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_VKEYTOITEM = <value>;

  Result := CN_VKEYTOITEM;
end;

function Controls_CN_VSCROLL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_VSCROLL = <value>;

  Result := CN_VSCROLL;
end;

function Controls_CN_KEYDOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_KEYDOWN = <value>;

  Result := CN_KEYDOWN;
end;

function Controls_CN_KEYUP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_KEYUP = <value>;

  Result := CN_KEYUP;
end;

function Controls_CN_CHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_CHAR = <value>;

  Result := CN_CHAR;
end;

function Controls_CN_SYSKEYDOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_SYSKEYDOWN = <value>;

  Result := CN_SYSKEYDOWN;
end;

function Controls_CN_SYSCHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_SYSCHAR = <value>;

  Result := CN_SYSCHAR;
end;

function Controls_CN_NOTIFY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CN_NOTIFY = <value>;

  Result := CN_NOTIFY;
end;

function Controls_mrNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNone = <value>;

  Result := mrNone;
end;

function Controls_mrOk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrOk = <value>;

  Result := mrOk;
end;

function Controls_mrCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrCancel = <value>;

  Result := mrCancel;
end;

function Controls_mrAbort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrAbort = <value>;

  Result := mrAbort;
end;

function Controls_mrRetry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrRetry = <value>;

  Result := mrRetry;
end;

function Controls_mrIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrIgnore = <value>;

  Result := mrIgnore;
end;

function Controls_mrYes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrYes = <value>;

  Result := mrYes;
end;

function Controls_mrNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNo = <value>;

  Result := mrNo;
end;

function Controls_mrAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrAll = <value>;

  Result := mrAll;
end;

function Controls_mrNoToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNoToAll = <value>;

  Result := mrNoToAll;
end;

function Controls_mrYesToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrYesToAll = <value>;

  Result := mrYesToAll;
end;

function Controls_mrClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrClose = <value>;

  Result := mrClose;
end;

function Controls_TModalResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TModalResult = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TModalResult_sw);
end;

function Controls_IsPositiveResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsPositiveResult(const AModalResult: TModalResul...

  Result := Controls.IsPositiveResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function Controls_IsNegativeResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsNegativeResult(const AModalResult: TModalResul...

  Result := Controls.IsNegativeResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function Controls_IsAbortResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAbortResult(const AModalResult: TModalResult):...

  Result := Controls.IsAbortResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function Controls_IsAnAllResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAnAllResult(const AModalResult: TModalResult):...

  Result := Controls.IsAnAllResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function Controls_StripAllFromResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StripAllFromResult(const AModalResult: TModalRes...

  Result := TModalResult_sw.ToVar(Controls.StripAllFromResult(TModalResult_sw.
    FromVar(AArgs[0])));
end;

function Controls_TCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursor = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TCursor_sw);
end;

function Controls_crDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crDefault = <value>;

  Result := TCursor_sw.ToVar(crDefault);
end;

function Controls_crNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNone = <value>;

  Result := TCursor_sw.ToVar(crNone);
end;

function Controls_crArrow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crArrow = <value>;

  Result := TCursor_sw.ToVar(crArrow);
end;

function Controls_crCross_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crCross = <value>;

  Result := TCursor_sw.ToVar(crCross);
end;

function Controls_crIBeam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crIBeam = <value>;

  Result := TCursor_sw.ToVar(crIBeam);
end;

function Controls_crSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSize = <value>;

  Result := TCursor_sw.ToVar(crSize);
end;

function Controls_crSizeNESW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNESW = <value>;

  Result := TCursor_sw.ToVar(crSizeNESW);
end;

function Controls_crSizeNS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNS = <value>;

  Result := TCursor_sw.ToVar(crSizeNS);
end;

function Controls_crSizeNWSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNWSE = <value>;

  Result := TCursor_sw.ToVar(crSizeNWSE);
end;

function Controls_crSizeWE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeWE = <value>;

  Result := TCursor_sw.ToVar(crSizeWE);
end;

function Controls_crUpArrow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crUpArrow = <value>;

  Result := TCursor_sw.ToVar(crUpArrow);
end;

function Controls_crHourGlass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHourGlass = <value>;

  Result := TCursor_sw.ToVar(crHourGlass);
end;

function Controls_crDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crDrag = <value>;

  Result := TCursor_sw.ToVar(crDrag);
end;

function Controls_crNoDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNoDrop = <value>;

  Result := TCursor_sw.ToVar(crNoDrop);
end;

function Controls_crHSplit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHSplit = <value>;

  Result := TCursor_sw.ToVar(crHSplit);
end;

function Controls_crVSplit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crVSplit = <value>;

  Result := TCursor_sw.ToVar(crVSplit);
end;

function Controls_crMultiDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crMultiDrag = <value>;

  Result := TCursor_sw.ToVar(crMultiDrag);
end;

function Controls_crSQLWait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSQLWait = <value>;

  Result := TCursor_sw.ToVar(crSQLWait);
end;

function Controls_crNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNo = <value>;

  Result := TCursor_sw.ToVar(crNo);
end;

function Controls_crAppStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crAppStart = <value>;

  Result := TCursor_sw.ToVar(crAppStart);
end;

function Controls_crHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHelp = <value>;

  Result := TCursor_sw.ToVar(crHelp);
end;

function Controls_crHandPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHandPoint = <value>;

  Result := TCursor_sw.ToVar(crHandPoint);
end;

function Controls_crSizeAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeAll = <value>;

  Result := TCursor_sw.ToVar(crSizeAll);
end;

function Controls_sgiNoGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiNoGesture = <value>;

  Result := sgiNoGesture;
end;

function Controls_sgiLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeft = <value>;

  Result := sgiLeft;
end;

function Controls_sgiRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRight = <value>;

  Result := sgiRight;
end;

function Controls_sgiUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUp = <value>;

  Result := sgiUp;
end;

function Controls_sgiDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDown = <value>;

  Result := sgiDown;
end;

function Controls_sgiUpLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpLeft = <value>;

  Result := sgiUpLeft;
end;

function Controls_sgiUpRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpRight = <value>;

  Result := sgiUpRight;
end;

function Controls_sgiDownLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownLeft = <value>;

  Result := sgiDownLeft;
end;

function Controls_sgiDownRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownRight = <value>;

  Result := sgiDownRight;
end;

function Controls_sgiLeftUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftUp = <value>;

  Result := sgiLeftUp;
end;

function Controls_sgiLeftDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftDown = <value>;

  Result := sgiLeftDown;
end;

function Controls_sgiRightUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightUp = <value>;

  Result := sgiRightUp;
end;

function Controls_sgiRightDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightDown = <value>;

  Result := sgiRightDown;
end;

function Controls_sgiUpDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpDown = <value>;

  Result := sgiUpDown;
end;

function Controls_sgiDownUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownUp = <value>;

  Result := sgiDownUp;
end;

function Controls_sgiLeftRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftRight = <value>;

  Result := sgiLeftRight;
end;

function Controls_sgiRightLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightLeft = <value>;

  Result := sgiRightLeft;
end;

function Controls_sgiUpLeftLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpLeftLong = <value>;

  Result := sgiUpLeftLong;
end;

function Controls_sgiUpRightLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpRightLong = <value>;

  Result := sgiUpRightLong;
end;

function Controls_sgiDownLeftLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownLeftLong = <value>;

  Result := sgiDownLeftLong;
end;

function Controls_sgiDownRightLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownRightLong = <value>;

  Result := sgiDownRightLong;
end;

function Controls_sgiScratchout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiScratchout = <value>;

  Result := sgiScratchout;
end;

function Controls_sgiTriangle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiTriangle = <value>;

  Result := sgiTriangle;
end;

function Controls_sgiSquare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSquare = <value>;

  Result := sgiSquare;
end;

function Controls_sgiCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCheck = <value>;

  Result := sgiCheck;
end;

function Controls_sgiCurlicue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCurlicue = <value>;

  Result := sgiCurlicue;
end;

function Controls_sgiDoubleCurlicue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDoubleCurlicue = <value>;

  Result := sgiDoubleCurlicue;
end;

function Controls_sgiCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCircle = <value>;

  Result := sgiCircle;
end;

function Controls_sgiDoubleCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDoubleCircle = <value>;

  Result := sgiDoubleCircle;
end;

function Controls_sgiSemiCircleLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSemiCircleLeft = <value>;

  Result := sgiSemiCircleLeft;
end;

function Controls_sgiSemiCircleRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSemiCircleRight = <value>;

  Result := sgiSemiCircleRight;
end;

function Controls_sgiChevronUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronUp = <value>;

  Result := sgiChevronUp;
end;

function Controls_sgiChevronDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronDown = <value>;

  Result := sgiChevronDown;
end;

function Controls_sgiChevronLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronLeft = <value>;

  Result := sgiChevronLeft;
end;

function Controls_sgiChevronRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronRight = <value>;

  Result := sgiChevronRight;
end;

function Controls_sgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiFirst = <value>;

  Result := sgiFirst;
end;

function Controls_sgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLast = <value>;

  Result := sgiLast;
end;

function Controls_cgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cgiFirst = <value>;

  Result := cgiFirst;
end;

function Controls_cgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cgiLast = <value>;

  Result := cgiLast;
end;

function Controls_rgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rgiFirst = <value>;

  Result := rgiFirst;
end;

function Controls_rgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rgiLast = <value>;

  Result := rgiLast;
end;

function Controls_igiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiFirst = <value>;

  Result := igiFirst;
end;

function Controls_igiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiLast = <value>;

  Result := igiLast;
end;

function Controls_igiBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiBegin = <value>;

  Result := igiBegin;
end;

function Controls_igiEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiEnd = <value>;

  Result := igiEnd;
end;

function Controls_igiZoom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiZoom = <value>;

  Result := igiZoom;
end;

function Controls_igiPan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiPan = <value>;

  Result := igiPan;
end;

function Controls_igiRotate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiRotate = <value>;

  Result := igiRotate;
end;

function Controls_igiTwoFingerTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiTwoFingerTap = <value>;

  Result := igiTwoFingerTap;
end;

function Controls_igiPressAndTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiPressAndTap = <value>;

  Result := igiPressAndTap;
end;

function Controls_gcnRefreshAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const gcnRefreshAll = <value>;

  Result := gcnRefreshAll;
end;

function Controls_gcnAdded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const gcnAdded = <value>;

  Result := gcnAdded;
end;

function Controls_gcnRemoved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const gcnRemoved = <value>;

  Result := gcnRemoved;
end;

function Controls_gcnModified_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const gcnModified = <value>;

  Result := gcnModified;
end;

function Controls_TInteractiveGestureFlag_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGestureFlag = (gfBegin, gfInertia, gfEnd);

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGestureFlag_sw);
end;

function Controls_TInteractiveGestureFlags_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGestureFlags = set of TInteractiveGestur...

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGestureFlags_sw);
end;

function Controls_TInteractiveGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGesture = (igZoom, igPan, igRotate, igTw...

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGesture_sw);
end;

function Controls_TInteractiveGestures_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGestures = set of TInteractiveGesture;

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGestures_sw);
end;

function Controls_TInteractiveGestureOption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGestureOption = (igoPanSingleFingerHoriz...

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGestureOption_sw);
end;

function Controls_TInteractiveGestureOptions_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInteractiveGestureOptions = set of TInteractiveGest...

  Result := TLMDUnitWrapper.TypeToVar(TInteractiveGestureOptions_sw);
end;

function Controls_TCustomLongData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomLongData = Longint;

  Result := TLMDUnitWrapper.TypeToVar(TCustomLongData_sw);
end;

function Controls_TWinControlClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWinControlClass = class of TWinControl;

  Result := TLMDUnitWrapper.TypeToVar(TWinControlClass_sw);
end;

function Controls_THintWindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintWindowClass = class of THintWindow;

  Result := TLMDUnitWrapper.TypeToVar(THintWindowClass_sw);
end;

function Controls_TCMActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMActivate = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMActivate_sw);
end;

function Controls_TCMDeactivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDeactivate = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMDeactivate_sw);
end;

function Controls_TCMGotFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMGotFocus = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMGotFocus_sw);
end;

function Controls_TCMLostFocus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMLostFocus = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMLostFocus_sw);
end;

function Controls_TCMDialogKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDialogKey = TWMKey;

  Result := TLMDUnitWrapper.TypeToVar(TCMDialogKey_sw);
end;

function Controls_TCMDialogChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDialogChar = TWMKey;

  Result := TLMDUnitWrapper.TypeToVar(TCMDialogChar_sw);
end;

function Controls_TCMHitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMHitTest = TWMNCHitTest;

  Result := TLMDUnitWrapper.TypeToVar(TCMHitTest_sw);
end;

function Controls_TCMEnter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMEnter = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMEnter_sw);
end;

function Controls_TCMExit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMExit = TWMNoParams;

  Result := TLMDUnitWrapper.TypeToVar(TCMExit_sw);
end;

function Controls_TCMDesignHitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDesignHitTest = TWMMouse;

  Result := TLMDUnitWrapper.TypeToVar(TCMDesignHitTest_sw);
end;

function Controls_TCMWantSpecialKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMWantSpecialKey = TWMKey;

  Result := TLMDUnitWrapper.TypeToVar(TCMWantSpecialKey_sw);
end;

function Controls_TCMMouseWheel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMMouseWheel = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMMouseWheel_sw);
end;

function Controls_TCMCancelMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMCancelMode = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMCancelMode_sw);
end;

function Controls_TCMFocusChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMFocusChanged = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMFocusChanged_sw);
end;

function Controls_TCMControlListChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMControlListChange = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMControlListChange_sw);
end;

function Controls_TControlListItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlListItem = record;

  Result := TLMDUnitWrapper.TypeToVar(TControlListItem_sw);
end;

function Controls_TCMControlListChanging_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMControlListChanging = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMControlListChanging_sw);
end;

function Controls_TCMChildKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMChildKey = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMChildKey_sw);
end;

function Controls_TCMControlChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMControlChange = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMControlChange_sw);
end;

function Controls_TCMChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMChanged = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMChanged_sw);
end;

function Controls_THintInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(THintInfo_sw);
end;

function Controls_TCMHintShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMHintShow = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMHintShow_sw);
end;

function Controls_TCMParentFontChanged_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMParentFontChanged = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMParentFontChanged_sw);
end;

function Controls_TDragMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragMessage = (dmDragEnter, dmDragLeave, dmDragMove...

  Result := TLMDUnitWrapper.TypeToVar(TDragMessage_sw);
end;

function Controls_TDragRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TDragRec_sw);
end;

function Controls_TCMDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDrag = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMDrag_sw);
end;

function Controls_TDockNotifyRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockNotifyRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TDockNotifyRec_sw);
end;

function Controls_TCMDockClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDockClient = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMDockClient_sw);
end;

function Controls_TCMUnDockClient_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMUnDockClient = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMUnDockClient_sw);
end;

function Controls_TCMFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMFloat = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMFloat_sw);
end;

function Controls_TCMDockNotification_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMDockNotification = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMDockNotification_sw);
end;

function Controls_TPopupFormInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupFormInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TPopupFormInfo_sw);
end;

function Controls_TCMPopupHWndDestroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMPopupHWndDestroy = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMPopupHWndDestroy_sw);
end;

function Controls_TCMCreatePopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMCreatePopup = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMCreatePopup_sw);
end;

function Controls_TAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlign = (alNone, alTop, alBottom, alLeft, alRight, ...

  Result := TLMDUnitWrapper.TypeToVar(TAlign_sw);
end;

function Controls_TAlignSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignSet = set of TAlign;

  Result := TLMDUnitWrapper.TypeToVar(TAlignSet_sw);
end;

function Controls_TDragObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragObject = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragObject_sw);
end;

function Controls_TDragObjectClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragObjectClass = class of TDragObject;

  Result := TLMDUnitWrapper.TypeToVar(TDragObjectClass_sw);
end;

function Controls_TDragObjectEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragObjectEx = class(TDragObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragObjectEx_sw);
end;

function Controls_TBaseDragControlObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBaseDragControlObject = class(TDragObject);

  Result := TLMDUnitWrapper.TypeToVar(TBaseDragControlObject_sw);
end;

function Controls_TDragControlObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragControlObject = class(TBaseDragControlObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragControlObject_sw);
end;

function Controls_TDragControlObjectEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragControlObjectEx = class(TDragControlObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragControlObjectEx_sw);
end;

function Controls_TDragDockObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragDockObject = class(TBaseDragControlObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragDockObject_sw);
end;

function Controls_TDragDockObjectEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragDockObjectEx = class(TDragDockObject);

  Result := TLMDUnitWrapper.TypeToVar(TDragDockObjectEx_sw);
end;

function Controls_TCanvasDC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanvasDC = HDC;

  Result := TLMDUnitWrapper.TypeToVar(TCanvasDC_sw);
end;

function Controls_TControlCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlCanvas = class(TCanvas);

  Result := TLMDUnitWrapper.TypeToVar(TControlCanvas_sw);
end;

function Controls_TCustomControlAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomControlAction = class(TCustomAction);

  Result := TLMDUnitWrapper.TypeToVar(TCustomControlAction_sw);
end;

function Controls_TControlAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlAction = class(TCustomControlAction);

  Result := TLMDUnitWrapper.TypeToVar(TControlAction_sw);
end;

function Controls_TControlActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlActionLink = class(TActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TControlActionLink_sw);
end;

function Controls_TControlActionLinkClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlActionLinkClass = class of TControlActionLink;

  Result := TLMDUnitWrapper.TypeToVar(TControlActionLinkClass_sw);
end;

function Controls_TMouseButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouseButton = (mbLeft, mbRight, mbMiddle);

  Result := TLMDUnitWrapper.TypeToVar(TMouseButton_sw);
end;

function Controls_TMouseActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouseActivate = (maDefault, maActivate, maActivateA...

  Result := TLMDUnitWrapper.TypeToVar(TMouseActivate_sw);
end;

function Controls_TDragMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragMode = (dmManual, dmAutomatic);

  Result := TLMDUnitWrapper.TypeToVar(TDragMode_sw);
end;

function Controls_TDragState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragState = (dsDragEnter, dsDragLeave, dsDragMove);

  Result := TLMDUnitWrapper.TypeToVar(TDragState_sw);
end;

function Controls_TDragKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragKind = (dkDrag, dkDock);

  Result := TLMDUnitWrapper.TypeToVar(TDragKind_sw);
end;

function Controls_TTabOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabOrder = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TTabOrder_sw);
end;

function Controls_TCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCaption = string;

  Result := TLMDUnitWrapper.TypeToVar(TCaption_sw);
end;

function Controls_TMouseActivateRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouseActivateRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TMouseActivateRec_sw);
end;

function Controls_TCMMouseActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMMouseActivate = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMMouseActivate_sw);
end;

function Controls_TAnchorKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnchorKind = (akLeft, akTop, akRight, akBottom);

  Result := TLMDUnitWrapper.TypeToVar(TAnchorKind_sw);
end;

function Controls_TAnchors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnchors = set of TAnchorKind;

  Result := TLMDUnitWrapper.TypeToVar(TAnchors_sw);
end;

function Controls_TConstraintSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConstraintSize = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TConstraintSize_sw);
end;

function Controls_TSizeConstraints_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSizeConstraints = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TSizeConstraints_sw);
end;

function Controls_TMarginSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMarginSize = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TMarginSize_sw);
end;

function Controls_TMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMargins = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TMargins_sw);
end;

function Controls_TPadding_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPadding = class(TMargins);

  Result := TLMDUnitWrapper.TypeToVar(TPadding_sw);
end;

function Controls_TGestureID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureID = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TGestureID_sw);
end;

function Controls_TGestureEventInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureEventInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TGestureEventInfo_sw);
end;

function Controls_TCMGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMGesture = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMGesture_sw);
end;

function Controls_TGestureEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureEvent = procedure (Sender: TObject; const Ev...

  Result := TLMDUnitWrapper.TypeToVar(TGestureEvent_sw);
end;

function Controls_TStandardGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStandardGesture = (sgLeft, sgRight, sgUp, sgDown, s...

  Result := TLMDUnitWrapper.TypeToVar(TStandardGesture_sw);
end;

function Controls_TStandardGestures_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStandardGestures = set of TStandardGesture;

  Result := TLMDUnitWrapper.TypeToVar(TStandardGestures_sw);
end;

function Controls_TTabletOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabletOption = (toPressAndHold, toPenTapFeedback, t...

  Result := TLMDUnitWrapper.TypeToVar(TTabletOption_sw);
end;

function Controls_TTabletOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabletOptions = set of TTabletOption;

  Result := TLMDUnitWrapper.TypeToVar(TTabletOptions_sw);
end;

function Controls_TGestureType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureType = (gtStandard, gtRecorded, gtRegistered...

  Result := TLMDUnitWrapper.TypeToVar(TGestureType_sw);
end;

function Controls_TGestureTypes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureTypes = set of TGestureType;

  Result := TLMDUnitWrapper.TypeToVar(TGestureTypes_sw);
end;

function Controls_TGestureOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureOption = (goUniDirectional, goSkew, goEndpoi...

  Result := TLMDUnitWrapper.TypeToVar(TGestureOption_sw);
end;

function Controls_TGestureOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGestureOptions = set of TGestureOption;

  Result := TLMDUnitWrapper.TypeToVar(TGestureOptions_sw);
end;

function Controls_EGestureException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EGestureException = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EGestureException_sw);
end;

function Controls_TCustomGestureCollectionItem_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGestureCollectionItem = class(TCollectionItem);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGestureCollectionItem_sw);
end;

function Controls_TCustomGestureCollection_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGestureCollection = class(TCollection);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGestureCollection_sw);
end;

function Controls_TCustomGestureManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGestureManager = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGestureManager_sw);
end;

function Controls_TCustomGestureEngine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomGestureEngine = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCustomGestureEngine_sw);
end;

function Controls_TTouchProperty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTouchProperty = (tpInteractiveGestures, tpInteracti...

  Result := TLMDUnitWrapper.TypeToVar(TTouchProperty_sw);
end;

function Controls_TCustomTouchManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomTouchManager = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomTouchManager_sw);
end;

function Controls_TTouchManager_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTouchManager = class(TCustomTouchManager);

  Result := TLMDUnitWrapper.TypeToVar(TTouchManager_sw);
end;

function Controls_TKeyPressEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyPressEvent = procedure (Sender: TObject; var Key...

  Result := TLMDUnitWrapper.TypeToVar(TKeyPressEvent_sw);
end;

function Controls_TDragOverEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragOverEvent = procedure (Sender: TObject; Source:...

  Result := TLMDUnitWrapper.TypeToVar(TDragOverEvent_sw);
end;

function Controls_TDragDropEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragDropEvent = procedure (Sender: TObject; Source:...

  Result := TLMDUnitWrapper.TypeToVar(TDragDropEvent_sw);
end;

function Controls_TStartDragEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStartDragEvent = procedure (Sender: TObject; var Dr...

  Result := TLMDUnitWrapper.TypeToVar(TStartDragEvent_sw);
end;

function Controls_TEndDragEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEndDragEvent = procedure (Sender: TObject; Target: ...

  Result := TLMDUnitWrapper.TypeToVar(TEndDragEvent_sw);
end;

function Controls_TDockDropEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockDropEvent = procedure (Sender: TObject; Source:...

  Result := TLMDUnitWrapper.TypeToVar(TDockDropEvent_sw);
end;

function Controls_TDockOverEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockOverEvent = procedure (Sender: TObject; Source:...

  Result := TLMDUnitWrapper.TypeToVar(TDockOverEvent_sw);
end;

function Controls_TUnDockEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TUnDockEvent = procedure (Sender: TObject; Client: T...

  Result := TLMDUnitWrapper.TypeToVar(TUnDockEvent_sw);
end;

function Controls_TStartDockEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStartDockEvent = procedure (Sender: TObject; var Dr...

  Result := TLMDUnitWrapper.TypeToVar(TStartDockEvent_sw);
end;

function Controls_TGetSiteInfoEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetSiteInfoEvent = procedure (Sender: TObject; Dock...

  Result := TLMDUnitWrapper.TypeToVar(TGetSiteInfoEvent_sw);
end;

function Controls_TCanResizeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCanResizeEvent = procedure (Sender: TObject; var Ne...

  Result := TLMDUnitWrapper.TypeToVar(TCanResizeEvent_sw);
end;

function Controls_TConstrainedResizeEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TConstrainedResizeEvent = procedure (Sender: TObject...

  Result := TLMDUnitWrapper.TypeToVar(TConstrainedResizeEvent_sw);
end;

function Controls_TContextPopupEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TContextPopupEvent = procedure (Sender: TObject; Mou...

  Result := TLMDUnitWrapper.TypeToVar(TContextPopupEvent_sw);
end;

function Controls_TWndMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWndMethod = Classes.TWndMethod;

  Result := TLMDUnitWrapper.TypeToVar(TWndMethod_sw);
end;

function Controls_TDockOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockOrientation = (doNoOrient, doHorizontal, doVert...

  Result := TLMDUnitWrapper.TypeToVar(TDockOrientation_sw);
end;

function Controls_TControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControl = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TControl_sw);
end;

function Controls_TControlClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlClass = class of TControl;

  Result := TLMDUnitWrapper.TypeToVar(TControlClass_sw);
end;

function Controls_TCreateParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCreateParams = record;

  Result := TLMDUnitWrapper.TypeToVar(TCreateParams_sw);
end;

function Controls_TWinControlActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWinControlActionLink = class(TControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TWinControlActionLink_sw);
end;

function Controls_TWinControlActionLinkClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWinControlActionLinkClass = class of TWinControlAct...

  Result := TLMDUnitWrapper.TypeToVar(TWinControlActionLinkClass_sw);
end;

function Controls_TImeMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImeMode = (imDisable, imClose, imOpen, imDontCare, ...

  Result := TLMDUnitWrapper.TypeToVar(TImeMode_sw);
end;

function Controls_TImeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImeName = string;

  Result := TLMDUnitWrapper.TypeToVar(TImeName_sw);
end;

function Controls_TAlignInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TAlignInfo_sw);
end;

function Controls_TBorderWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderWidth = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TBorderWidth_sw);
end;

function Controls_TBevelCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelCut = (bvNone, bvLowered, bvRaised, bvSpace);

  Result := TLMDUnitWrapper.TypeToVar(TBevelCut_sw);
end;

function Controls_TBevelEdge_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelEdge = (beLeft, beTop, beRight, beBottom);

  Result := TLMDUnitWrapper.TypeToVar(TBevelEdge_sw);
end;

function Controls_TBevelEdges_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelEdges = set of TBevelEdge;

  Result := TLMDUnitWrapper.TypeToVar(TBevelEdges_sw);
end;

function Controls_TBevelKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelKind = (bkNone, bkTile, bkSoft, bkFlat);

  Result := TLMDUnitWrapper.TypeToVar(TBevelKind_sw);
end;

function Controls_TBevelWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBevelWidth = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TBevelWidth_sw);
end;

function Controls_TAlignInsertBeforeEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignInsertBeforeEvent = function (Sender: TWinCont...

  Result := TLMDUnitWrapper.TypeToVar(TAlignInsertBeforeEvent_sw);
end;

function Controls_TAlignPositionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlignPositionEvent = procedure (Sender: TWinControl...

  Result := TLMDUnitWrapper.TypeToVar(TAlignPositionEvent_sw);
end;

function Controls_TWinControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWinControl = class(TControl);

  Result := TLMDUnitWrapper.TypeToVar(TWinControl_sw);
end;

function Controls_TGraphicControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGraphicControl = class(TControl);

  Result := TLMDUnitWrapper.TypeToVar(TGraphicControl_sw);
end;

function Controls_TCustomControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomControl_sw);
end;

function Controls_TCustomTransparentControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomTransparentControl = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomTransparentControl_sw);
end;

function Controls_THintWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintWindow = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(THintWindow_sw);
end;

function Controls_TDragImageList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragImageList = class(TCustomImageList);

  Result := TLMDUnitWrapper.TypeToVar(TDragImageList_sw);
end;

function Controls_TImageList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImageList = class(TDragImageList);

  Result := TLMDUnitWrapper.TypeToVar(TImageList_sw);
end;

function Controls_TDockZone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockZone = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TDockZone_sw);
end;

function Controls_TForEachZoneProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TForEachZoneProc = procedure (Zone: TDockZone) of ob...

  Result := TLMDUnitWrapper.TypeToVar(TForEachZoneProc_sw);
end;

function Controls_TDockTreeClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockTreeClass = class of TDockTree;

  Result := TLMDUnitWrapper.TypeToVar(TDockTreeClass_sw);
end;

function Controls_TDockTree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDockTree = class(TInterfacedObject);

  Result := TLMDUnitWrapper.TypeToVar(TDockTree_sw);
end;

function Controls_TPanningWindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPanningWindowClass = class of TCustomPanningWindow;

  Result := TLMDUnitWrapper.TypeToVar(TPanningWindowClass_sw);
end;

function Controls_TCustomPanningWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomPanningWindow = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomPanningWindow_sw);
end;

function Controls_TMouse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouse = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TMouse_sw);
end;

function Controls_TCustomListControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomListControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomListControl_sw);
end;

function Controls_TCustomMultiSelectListControl_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomMultiSelectListControl = class(TCustomListCon...

  Result := TLMDUnitWrapper.TypeToVar(TCustomMultiSelectListControl_sw);
end;

function Controls_TBalloonHintIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBalloonHintIcon = (bhInfo, bhWarning, bhError);

  Result := TLMDUnitWrapper.TypeToVar(TBalloonHintIcon_sw);
end;

function Controls_TBalloonHintIconSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBalloonHintIconSize = (bhsNormal, bhsLarge, bhsSmall);

  Result := TLMDUnitWrapper.TypeToVar(TBalloonHintIconSize_sw);
end;

function Controls_TBalloonHintStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBalloonHintStyle = (bhsStandard, bhsBalloon);

  Result := TLMDUnitWrapper.TypeToVar(TBalloonHintStyle_sw);
end;

function Controls_TCustomHintWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHintWindow = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomHintWindow_sw);
end;

function Controls_TCustomHintShowHideThread_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHintShowHideThread = class(TThread);

  Result := TLMDUnitWrapper.TypeToVar(TCustomHintShowHideThread_sw);
end;

function Controls_TCustomHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomHint = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCustomHint_sw);
end;

function Controls_TBalloonHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBalloonHint = class(TCustomHint);

  Result := TLMDUnitWrapper.TypeToVar(TBalloonHint_sw);
end;

function Controls_cImageMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cImageMargin = <value>;

  Result := cImageMargin;
end;

function Controls_cTextVerticalMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cTextVerticalMargin = <value>;

  Result := cTextVerticalMargin;
end;

function Controls_cTextHorizontalMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cTextHorizontalMargin = <value>;

  Result := cTextHorizontalMargin;
end;

function Controls_cBalloonStemHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBalloonStemHeight = <value>;

  Result := cBalloonStemHeight;
end;

function Controls_cEdgeRadius_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cEdgeRadius = <value>;

  Result := cEdgeRadius;
end;

function Controls_Mouse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Mouse: TMouse;

  if IsGet then
    Result := TMouse_sw.ToVar(Controls.Mouse)
  else
    Controls.Mouse := TMouse_sw.FromVar(AArgs[0]);
end;

function Controls_IsDragObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsDragObject(Sender: TObject): Boolean;

  Result := Controls.IsDragObject(TObject_sw.FromVar(AArgs[0]));
end;

function Controls_IsVCLControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsVCLControl(Handle: HWND): Boolean;

  Result := Controls.IsVCLControl(HWND_sw.FromVar(AArgs[0]));
end;

function Controls_FindControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindControl(Handle: HWND): TWinControl;

  Result := TWinControl_sw.ToVar(Controls.FindControl(HWND_sw.FromVar(
    AArgs[0])));
end;

function Controls_FindVCLWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindVCLWindow(const Pos: TPoint): TWinControl;

  Result := TWinControl_sw.ToVar(Controls.FindVCLWindow(TPoint_sw.FromVar(
    AArgs[0])));
end;

function Controls_FindDragTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FindDragTarget(const Pos: TPoint; AllowDisabled:...

  Result := TControl_sw.ToVar(Controls.FindDragTarget(TPoint_sw.FromVar(
    AArgs[0]), Boolean(AArgs[1])));
end;

function Controls_GetCaptureControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetCaptureControl: TControl;

  Result := TControl_sw.ToVar(Controls.GetCaptureControl());
end;

function Controls_SetCaptureControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetCaptureControl(Control: TControl);

  Controls.SetCaptureControl(TControl_sw.FromVar(AArgs[0]));
end;

function Controls_CancelDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelDrag;

  Controls.CancelDrag();
end;

function Controls_CursorToString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CursorToString(Cursor: TCursor): string;

  Result := Controls.CursorToString(TCursor_sw.FromVar(AArgs[0]));
end;

function Controls_StringToCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StringToCursor(const S: string): TCursor;

  Result := TCursor_sw.ToVar(Controls.StringToCursor(string(AArgs[0])));
end;

function Controls_GetCursorValues_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GetCursorValues(Proc: TGetStrProc);

  Controls.GetCursorValues(TGetStrProc_sw.FromVar(AArgs[0]));
end;

function Controls_CursorToIdent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function CursorToIdent(Cursor: Longint; var Ident: string...

  v_1 := string(AArgs[1]);
  Result := Controls.CursorToIdent(Longint(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Controls_IdentToCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Longint;
begin
  // function IdentToCursor(const Ident: string; var Cursor: L...

  v_1 := Longint(AArgs[1]);
  Result := Controls.IdentToCursor(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], v_1);
end;

function Controls_GetShortHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetShortHint(const Hint: string): string;

  Result := Controls.GetShortHint(string(AArgs[0]));
end;

function Controls_GetLongHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetLongHint(const Hint: string): string;

  Result := Controls.GetLongHint(string(AArgs[0]));
end;

function Controls_PerformEraseBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PerformEraseBackground(Control: TControl; DC: H...

  Controls.PerformEraseBackground(TControl_sw.FromVar(AArgs[0]), HDC_sw.FromVar(
    AArgs[1]));
end;

function Controls_PerformBufferedPrintClient_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure PerformBufferedPrintClient(Handle: HWND; const ...

  Controls.PerformBufferedPrintClient(HWND_sw.FromVar(AArgs[0]), TRect_sw.
    FromVar(AArgs[1]));
end;

function Controls_InitWndProc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InitWndProc(HWindow: HWND; Msg: UINT; WParam: WP...

  Result := LRESULT_sw.ToVar(Controls.InitWndProc(HWND_sw.FromVar(AArgs[0]), 
    UINT_sw.FromVar(AArgs[1]), WPARAM_sw.FromVar(AArgs[2]), LPARAM_sw.FromVar(
    AArgs[3])));
end;

function Controls_DefaultDockTreeClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DefaultDockTreeClass: TDockTreeClass;

  if IsGet then
    Result := TDockTreeClass_sw.ToVar(Controls.DefaultDockTreeClass)
  else
    Controls.DefaultDockTreeClass := TDockTreeClass_sw.FromVar(AArgs[0]);
end;

function Controls_CreationControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CreationControl: TWinControl;

  if IsGet then
    Result := TWinControl_sw.ToVar(Controls.CreationControl)
  else
    Controls.CreationControl := TWinControl_sw.FromVar(AArgs[0]);
end;

function Controls_CTL3D_ALL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CTL3D_ALL = <value>;

  Result := CTL3D_ALL;
end;

function Controls_NullDockSite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NullDockSite = <value>;

  Result := TWinControl_sw.ToVar(NullDockSite);
end;

function Controls_NewStyleControls_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NewStyleControls: Boolean;

  if IsGet then
    Result := Controls.NewStyleControls
  else
    Controls.NewStyleControls := Boolean(AArgs[0]);
end;

function Controls_ChangeBiDiModeAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TAlignment;
begin
  // procedure ChangeBiDiModeAlignment(var Alignment: TAlignme...

  v_1 := TAlignment_sw.FromVar(AArgs[0]);
  Controls.ChangeBiDiModeAlignment(v_1);
  AssignRefParam(AArgs[0], TAlignment_sw.ToVar(v_1));
end;

function Controls_SendAppMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SendAppMessage(Msg: Cardinal; WParam: Longint; L...

  Result := Controls.SendAppMessage(Cardinal(AArgs[0]), Longint(AArgs[1]), 
    Longint(AArgs[2]));
end;

function Controls_MoveWindowOrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MoveWindowOrg(DC: HDC; DX: Integer; DY: Integer);

  Controls.MoveWindowOrg(HDC_sw.FromVar(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]));
end;

function Controls_SetImeMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetImeMode(hWnd: HWND; Mode: TImeMode);

  Controls.SetImeMode(HWND_sw.FromVar(AArgs[0]), TImeMode_sw.FromVar(AArgs[1]));
end;

function Controls_SetImeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetImeName(Name: TImeName);

  Controls.SetImeName(TImeName_sw.FromVar(AArgs[0]));
end;

function Controls_Win32NLSEnableIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Win32NLSEnableIME(hWnd: HWND; Enable: Boolean): ...

  Result := Controls.Win32NLSEnableIME(HWND_sw.FromVar(AArgs[0]), Boolean(
    AArgs[1]));
end;

function Controls_Imm32GetContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32GetContext(hWnd: HWND): HIMC;

  Result := HIMC_sw.ToVar(Controls.Imm32GetContext(HWND_sw.FromVar(AArgs[0])));
end;

function Controls_Imm32ReleaseContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32ReleaseContext(hWnd: HWND; hImc: HIMC): Boo...

  Result := Controls.Imm32ReleaseContext(HWND_sw.FromVar(AArgs[0]), HIMC_sw.
    FromVar(AArgs[1]));
end;

function Controls_Imm32GetConversionStatus_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: DWORD;
  v_2: DWORD;
begin
  // function Imm32GetConversionStatus(hImc: HIMC; var Convers...

  v_1 := DWORD_sw.FromVar(AArgs[1]);
  v_2 := DWORD_sw.FromVar(AArgs[2]);
  Result := Controls.Imm32GetConversionStatus(HIMC_sw.FromVar(AArgs[0]), v_1, 
    v_2);
  AssignRefParam(AArgs[1], DWORD_sw.ToVar(v_1));
  AssignRefParam(AArgs[2], DWORD_sw.ToVar(v_2));
end;

function Controls_Imm32SetConversionStatus_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32SetConversionStatus(hImc: HIMC; Conversion:...

  Result := Controls.Imm32SetConversionStatus(HIMC_sw.FromVar(AArgs[0]), 
    DWORD_sw.FromVar(AArgs[1]), DWORD_sw.FromVar(AArgs[2]));
end;

function Controls_Imm32SetOpenStatus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32SetOpenStatus(hImc: HIMC; fOpen: Boolean): ...

  Result := Controls.Imm32SetOpenStatus(HIMC_sw.FromVar(AArgs[0]), Boolean(
    AArgs[1]));
end;

function Controls_Imm32SetCompositionWindow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Imm32SetCompositionWindow(...); overload;

  Result := Controls.Imm32SetCompositionWindow(HIMC_sw.FromVar(AArgs[0]), 
    TCOMPOSITIONFORM_sw.FromVar(AArgs[1]));
end;

function Controls_Imm32SetCompositionFont_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: LOGFONT;
begin
  // procedure/function Imm32SetCompositionFont(...); overload;

  v_1 := LOGFONT_sw.FromVar(AArgs[1]);
  Result := Controls.Imm32SetCompositionFont(HIMC_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], LOGFONT_sw.ToVar(v_1));
end;

function Controls_Imm32IsIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32IsIME(hKl: HKL): Boolean;

  Result := Controls.Imm32IsIME(HKL_sw.FromVar(AArgs[0]));
end;

function Controls_Imm32NotifyIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Imm32NotifyIME(hImc: HIMC; dwAction: DWORD; dwIn...

  Result := Controls.Imm32NotifyIME(HIMC_sw.FromVar(AArgs[0]), DWORD_sw.FromVar(
    AArgs[1]), DWORD_sw.FromVar(AArgs[2]), DWORD_sw.FromVar(AArgs[3]));
end;

function Controls_DragDone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DragDone(Drop: Boolean);

  Controls.DragDone(Boolean(AArgs[0]));
end;

class function Controls_sw.GetUnitName: WideString;
begin
  Result := 'Controls';
end;

class procedure Controls_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('CM_BASE', Controls_CM_BASE_si, nil, VarType(Controls.CM_BASE));
  AData.AddConstant('CM_CLROFFSET', Controls_CM_CLROFFSET_si, nil, VarType(Controls.CM_CLROFFSET));
  AData.AddConstant('CM_ACTIVATE', Controls_CM_ACTIVATE_si, nil, VarType(Controls.CM_ACTIVATE));
  AData.AddConstant('CM_DEACTIVATE', Controls_CM_DEACTIVATE_si, nil, VarType(Controls.CM_DEACTIVATE));
  AData.AddConstant('CM_GOTFOCUS', Controls_CM_GOTFOCUS_si, nil, VarType(Controls.CM_GOTFOCUS));
  AData.AddConstant('CM_LOSTFOCUS', Controls_CM_LOSTFOCUS_si, nil, VarType(Controls.CM_LOSTFOCUS));
  AData.AddConstant('CM_CANCELMODE', Controls_CM_CANCELMODE_si, nil, VarType(Controls.CM_CANCELMODE));
  AData.AddConstant('CM_DIALOGKEY', Controls_CM_DIALOGKEY_si, nil, VarType(Controls.CM_DIALOGKEY));
  AData.AddConstant('CM_DIALOGCHAR', Controls_CM_DIALOGCHAR_si, nil, VarType(Controls.CM_DIALOGCHAR));
  AData.AddConstant('CM_FOCUSCHANGED', Controls_CM_FOCUSCHANGED_si, nil, VarType(Controls.CM_FOCUSCHANGED));
  AData.AddConstant('CM_PARENTFONTCHANGED', Controls_CM_PARENTFONTCHANGED_si, nil, VarType(Controls.CM_PARENTFONTCHANGED));
  AData.AddConstant('CM_PARENTCOLORCHANGED', Controls_CM_PARENTCOLORCHANGED_si, nil, VarType(Controls.CM_PARENTCOLORCHANGED));
  AData.AddConstant('CM_HITTEST', Controls_CM_HITTEST_si, nil, VarType(Controls.CM_HITTEST));
  AData.AddConstant('CM_VISIBLECHANGED', Controls_CM_VISIBLECHANGED_si, nil, VarType(Controls.CM_VISIBLECHANGED));
  AData.AddConstant('CM_ENABLEDCHANGED', Controls_CM_ENABLEDCHANGED_si, nil, VarType(Controls.CM_ENABLEDCHANGED));
  AData.AddConstant('CM_COLORCHANGED', Controls_CM_COLORCHANGED_si, nil, VarType(Controls.CM_COLORCHANGED));
  AData.AddConstant('CM_FONTCHANGED', Controls_CM_FONTCHANGED_si, nil, VarType(Controls.CM_FONTCHANGED));
  AData.AddConstant('CM_CURSORCHANGED', Controls_CM_CURSORCHANGED_si, nil, VarType(Controls.CM_CURSORCHANGED));
  AData.AddConstant('CM_CTL3DCHANGED', Controls_CM_CTL3DCHANGED_si, nil, VarType(Controls.CM_CTL3DCHANGED));
  AData.AddConstant('CM_PARENTCTL3DCHANGED', Controls_CM_PARENTCTL3DCHANGED_si, nil, VarType(Controls.CM_PARENTCTL3DCHANGED));
  AData.AddConstant('CM_TEXTCHANGED', Controls_CM_TEXTCHANGED_si, nil, VarType(Controls.CM_TEXTCHANGED));
  AData.AddConstant('CM_MOUSEENTER', Controls_CM_MOUSEENTER_si, nil, VarType(Controls.CM_MOUSEENTER));
  AData.AddConstant('CM_MOUSELEAVE', Controls_CM_MOUSELEAVE_si, nil, VarType(Controls.CM_MOUSELEAVE));
  AData.AddConstant('CM_MENUCHANGED', Controls_CM_MENUCHANGED_si, nil, VarType(Controls.CM_MENUCHANGED));
  AData.AddConstant('CM_APPKEYDOWN', Controls_CM_APPKEYDOWN_si, nil, VarType(Controls.CM_APPKEYDOWN));
  AData.AddConstant('CM_APPSYSCOMMAND', Controls_CM_APPSYSCOMMAND_si, nil, VarType(Controls.CM_APPSYSCOMMAND));
  AData.AddConstant('CM_BUTTONPRESSED', Controls_CM_BUTTONPRESSED_si, nil, VarType(Controls.CM_BUTTONPRESSED));
  AData.AddConstant('CM_SHOWINGCHANGED', Controls_CM_SHOWINGCHANGED_si, nil, VarType(Controls.CM_SHOWINGCHANGED));
  AData.AddConstant('CM_ENTER', Controls_CM_ENTER_si, nil, VarType(Controls.CM_ENTER));
  AData.AddConstant('CM_EXIT', Controls_CM_EXIT_si, nil, VarType(Controls.CM_EXIT));
  AData.AddConstant('CM_DESIGNHITTEST', Controls_CM_DESIGNHITTEST_si, nil, VarType(Controls.CM_DESIGNHITTEST));
  AData.AddConstant('CM_ICONCHANGED', Controls_CM_ICONCHANGED_si, nil, VarType(Controls.CM_ICONCHANGED));
  AData.AddConstant('CM_WANTSPECIALKEY', Controls_CM_WANTSPECIALKEY_si, nil, VarType(Controls.CM_WANTSPECIALKEY));
  AData.AddConstant('CM_INVOKEHELP', Controls_CM_INVOKEHELP_si, nil, VarType(Controls.CM_INVOKEHELP));
  AData.AddConstant('CM_WINDOWHOOK', Controls_CM_WINDOWHOOK_si, nil, VarType(Controls.CM_WINDOWHOOK));
  AData.AddConstant('CM_RELEASE', Controls_CM_RELEASE_si, nil, VarType(Controls.CM_RELEASE));
  AData.AddConstant('CM_SHOWHINTCHANGED', Controls_CM_SHOWHINTCHANGED_si, nil, VarType(Controls.CM_SHOWHINTCHANGED));
  AData.AddConstant('CM_PARENTSHOWHINTCHANGED', Controls_CM_PARENTSHOWHINTCHANGED_si, nil, VarType(Controls.CM_PARENTSHOWHINTCHANGED));
  AData.AddConstant('CM_SYSCOLORCHANGE', Controls_CM_SYSCOLORCHANGE_si, nil, VarType(Controls.CM_SYSCOLORCHANGE));
  AData.AddConstant('CM_WININICHANGE', Controls_CM_WININICHANGE_si, nil, VarType(Controls.CM_WININICHANGE));
  AData.AddConstant('CM_FONTCHANGE', Controls_CM_FONTCHANGE_si, nil, VarType(Controls.CM_FONTCHANGE));
  AData.AddConstant('CM_TIMECHANGE', Controls_CM_TIMECHANGE_si, nil, VarType(Controls.CM_TIMECHANGE));
  AData.AddConstant('CM_TABSTOPCHANGED', Controls_CM_TABSTOPCHANGED_si, nil, VarType(Controls.CM_TABSTOPCHANGED));
  AData.AddConstant('CM_UIACTIVATE', Controls_CM_UIACTIVATE_si, nil, VarType(Controls.CM_UIACTIVATE));
  AData.AddConstant('CM_UIDEACTIVATE', Controls_CM_UIDEACTIVATE_si, nil, VarType(Controls.CM_UIDEACTIVATE));
  AData.AddConstant('CM_DOCWINDOWACTIVATE', Controls_CM_DOCWINDOWACTIVATE_si, nil, VarType(Controls.CM_DOCWINDOWACTIVATE));
  AData.AddConstant('CM_CONTROLLISTCHANGE', Controls_CM_CONTROLLISTCHANGE_si, nil, VarType(Controls.CM_CONTROLLISTCHANGE));
  AData.AddConstant('CM_GETDATALINK', Controls_CM_GETDATALINK_si, nil, VarType(Controls.CM_GETDATALINK));
  AData.AddConstant('CM_CHILDKEY', Controls_CM_CHILDKEY_si, nil, VarType(Controls.CM_CHILDKEY));
  AData.AddConstant('CM_DRAG', Controls_CM_DRAG_si, nil, VarType(Controls.CM_DRAG));
  AData.AddConstant('CM_HINTSHOW', Controls_CM_HINTSHOW_si, nil, VarType(Controls.CM_HINTSHOW));
  AData.AddConstant('CM_DIALOGHANDLE', Controls_CM_DIALOGHANDLE_si, nil, VarType(Controls.CM_DIALOGHANDLE));
  AData.AddConstant('CM_ISTOOLCONTROL', Controls_CM_ISTOOLCONTROL_si, nil, VarType(Controls.CM_ISTOOLCONTROL));
  AData.AddConstant('CM_RECREATEWND', Controls_CM_RECREATEWND_si, nil, VarType(Controls.CM_RECREATEWND));
  AData.AddConstant('CM_INVALIDATE', Controls_CM_INVALIDATE_si, nil, VarType(Controls.CM_INVALIDATE));
  AData.AddConstant('CM_SYSFONTCHANGED', Controls_CM_SYSFONTCHANGED_si, nil, VarType(Controls.CM_SYSFONTCHANGED));
  AData.AddConstant('CM_CONTROLCHANGE', Controls_CM_CONTROLCHANGE_si, nil, VarType(Controls.CM_CONTROLCHANGE));
  AData.AddConstant('CM_CHANGED', Controls_CM_CHANGED_si, nil, VarType(Controls.CM_CHANGED));
  AData.AddConstant('CM_DOCKCLIENT', Controls_CM_DOCKCLIENT_si, nil, VarType(Controls.CM_DOCKCLIENT));
  AData.AddConstant('CM_UNDOCKCLIENT', Controls_CM_UNDOCKCLIENT_si, nil, VarType(Controls.CM_UNDOCKCLIENT));
  AData.AddConstant('CM_FLOAT', Controls_CM_FLOAT_si, nil, VarType(Controls.CM_FLOAT));
  AData.AddConstant('CM_BORDERCHANGED', Controls_CM_BORDERCHANGED_si, nil, VarType(Controls.CM_BORDERCHANGED));
  AData.AddConstant('CM_BIDIMODECHANGED', Controls_CM_BIDIMODECHANGED_si, nil, VarType(Controls.CM_BIDIMODECHANGED));
  AData.AddConstant('CM_PARENTBIDIMODECHANGED', Controls_CM_PARENTBIDIMODECHANGED_si, nil, VarType(Controls.CM_PARENTBIDIMODECHANGED));
  AData.AddConstant('CM_ALLCHILDRENFLIPPED', Controls_CM_ALLCHILDRENFLIPPED_si, nil, VarType(Controls.CM_ALLCHILDRENFLIPPED));
  AData.AddConstant('CM_ACTIONUPDATE', Controls_CM_ACTIONUPDATE_si, nil, VarType(Controls.CM_ACTIONUPDATE));
  AData.AddConstant('CM_ACTIONEXECUTE', Controls_CM_ACTIONEXECUTE_si, nil, VarType(Controls.CM_ACTIONEXECUTE));
  AData.AddConstant('CM_HINTSHOWPAUSE', Controls_CM_HINTSHOWPAUSE_si, nil, VarType(Controls.CM_HINTSHOWPAUSE));
  AData.AddConstant('CM_DOCKNOTIFICATION', Controls_CM_DOCKNOTIFICATION_si, nil, VarType(Controls.CM_DOCKNOTIFICATION));
  AData.AddConstant('CM_MOUSEWHEEL', Controls_CM_MOUSEWHEEL_si, nil, VarType(Controls.CM_MOUSEWHEEL));
  AData.AddConstant('CM_ISSHORTCUT', Controls_CM_ISSHORTCUT_si, nil, VarType(Controls.CM_ISSHORTCUT));
  AData.AddConstant('CM_UPDATEACTIONS', Controls_CM_UPDATEACTIONS_si, nil, VarType(Controls.CM_UPDATEACTIONS));
  AData.AddConstant('CM_INVALIDATEDOCKHOST', Controls_CM_INVALIDATEDOCKHOST_si, nil, VarType(Controls.CM_INVALIDATEDOCKHOST));
  AData.AddConstant('CM_SETACTIVECONTROL', Controls_CM_SETACTIVECONTROL_si, nil, VarType(Controls.CM_SETACTIVECONTROL));
  AData.AddConstant('CM_POPUPHWNDDESTROY', Controls_CM_POPUPHWNDDESTROY_si, nil, VarType(Controls.CM_POPUPHWNDDESTROY));
  AData.AddConstant('CM_CREATEPOPUP', Controls_CM_CREATEPOPUP_si, nil, VarType(Controls.CM_CREATEPOPUP));
  AData.AddConstant('CM_DESTROYHANDLE', Controls_CM_DESTROYHANDLE_si, nil, VarType(Controls.CM_DESTROYHANDLE));
  AData.AddConstant('CM_MOUSEACTIVATE', Controls_CM_MOUSEACTIVATE_si, nil, VarType(Controls.CM_MOUSEACTIVATE));
  AData.AddConstant('CM_BUFFEREDPRINTCLIENT', Controls_CM_BUFFEREDPRINTCLIENT_si, nil, VarType(Controls.CM_BUFFEREDPRINTCLIENT));
  AData.AddConstant('CM_UNTHEMECONTROL', Controls_CM_UNTHEMECONTROL_si, nil, VarType(Controls.CM_UNTHEMECONTROL));
  AData.AddConstant('CM_DOUBLEBUFFEREDCHANGED', Controls_CM_DOUBLEBUFFEREDCHANGED_si, nil, VarType(Controls.CM_DOUBLEBUFFEREDCHANGED));
  AData.AddConstant('CM_PARENTDOUBLEBUFFEREDCHANGED', Controls_CM_PARENTDOUBLEBUFFEREDCHANGED_si, nil, VarType(Controls.CM_PARENTDOUBLEBUFFEREDCHANGED));
  AData.AddConstant('CM_THEMECHANGED', Controls_CM_THEMECHANGED_si, nil, VarType(Controls.CM_THEMECHANGED));
  AData.AddConstant('CM_GESTURE', Controls_CM_GESTURE_si, nil, VarType(Controls.CM_GESTURE));
  AData.AddConstant('CM_CUSTOMGESTURESCHANGED', Controls_CM_CUSTOMGESTURESCHANGED_si, nil, VarType(Controls.CM_CUSTOMGESTURESCHANGED));
  AData.AddConstant('CM_GESTUREMANAGERCHANGED', Controls_CM_GESTUREMANAGERCHANGED_si, nil, VarType(Controls.CM_GESTUREMANAGERCHANGED));
  AData.AddConstant('CM_STANDARDGESTURESCHANGED', Controls_CM_STANDARDGESTURESCHANGED_si, nil, VarType(Controls.CM_STANDARDGESTURESCHANGED));
  AData.AddConstant('CM_INPUTLANGCHANGE', Controls_CM_INPUTLANGCHANGE_si, nil, VarType(Controls.CM_INPUTLANGCHANGE));
  AData.AddConstant('CM_TABLETOPTIONSCHANGED', Controls_CM_TABLETOPTIONSCHANGED_si, nil, VarType(Controls.CM_TABLETOPTIONSCHANGED));
  AData.AddConstant('CM_PARENTTABLETOPTIONSCHANGED', Controls_CM_PARENTTABLETOPTIONSCHANGED_si, nil, VarType(Controls.CM_PARENTTABLETOPTIONSCHANGED));
  AData.AddConstant('CN_BASE', Controls_CN_BASE_si, nil, VarType(Controls.CN_BASE));
  AData.AddConstant('CN_CHARTOITEM', Controls_CN_CHARTOITEM_si, nil, VarType(Controls.CN_CHARTOITEM));
  AData.AddConstant('CN_COMMAND', Controls_CN_COMMAND_si, nil, VarType(Controls.CN_COMMAND));
  AData.AddConstant('CN_COMPAREITEM', Controls_CN_COMPAREITEM_si, nil, VarType(Controls.CN_COMPAREITEM));
  AData.AddConstant('CN_CTLCOLORBTN', Controls_CN_CTLCOLORBTN_si, nil, VarType(Controls.CN_CTLCOLORBTN));
  AData.AddConstant('CN_CTLCOLORDLG', Controls_CN_CTLCOLORDLG_si, nil, VarType(Controls.CN_CTLCOLORDLG));
  AData.AddConstant('CN_CTLCOLOREDIT', Controls_CN_CTLCOLOREDIT_si, nil, VarType(Controls.CN_CTLCOLOREDIT));
  AData.AddConstant('CN_CTLCOLORLISTBOX', Controls_CN_CTLCOLORLISTBOX_si, nil, VarType(Controls.CN_CTLCOLORLISTBOX));
  AData.AddConstant('CN_CTLCOLORMSGBOX', Controls_CN_CTLCOLORMSGBOX_si, nil, VarType(Controls.CN_CTLCOLORMSGBOX));
  AData.AddConstant('CN_CTLCOLORSCROLLBAR', Controls_CN_CTLCOLORSCROLLBAR_si, nil, VarType(Controls.CN_CTLCOLORSCROLLBAR));
  AData.AddConstant('CN_CTLCOLORSTATIC', Controls_CN_CTLCOLORSTATIC_si, nil, VarType(Controls.CN_CTLCOLORSTATIC));
  AData.AddConstant('CN_DELETEITEM', Controls_CN_DELETEITEM_si, nil, VarType(Controls.CN_DELETEITEM));
  AData.AddConstant('CN_DRAWITEM', Controls_CN_DRAWITEM_si, nil, VarType(Controls.CN_DRAWITEM));
  AData.AddConstant('CN_HSCROLL', Controls_CN_HSCROLL_si, nil, VarType(Controls.CN_HSCROLL));
  AData.AddConstant('CN_MEASUREITEM', Controls_CN_MEASUREITEM_si, nil, VarType(Controls.CN_MEASUREITEM));
  AData.AddConstant('CN_PARENTNOTIFY', Controls_CN_PARENTNOTIFY_si, nil, VarType(Controls.CN_PARENTNOTIFY));
  AData.AddConstant('CN_VKEYTOITEM', Controls_CN_VKEYTOITEM_si, nil, VarType(Controls.CN_VKEYTOITEM));
  AData.AddConstant('CN_VSCROLL', Controls_CN_VSCROLL_si, nil, VarType(Controls.CN_VSCROLL));
  AData.AddConstant('CN_KEYDOWN', Controls_CN_KEYDOWN_si, nil, VarType(Controls.CN_KEYDOWN));
  AData.AddConstant('CN_KEYUP', Controls_CN_KEYUP_si, nil, VarType(Controls.CN_KEYUP));
  AData.AddConstant('CN_CHAR', Controls_CN_CHAR_si, nil, VarType(Controls.CN_CHAR));
  AData.AddConstant('CN_SYSKEYDOWN', Controls_CN_SYSKEYDOWN_si, nil, VarType(Controls.CN_SYSKEYDOWN));
  AData.AddConstant('CN_SYSCHAR', Controls_CN_SYSCHAR_si, nil, VarType(Controls.CN_SYSCHAR));
  AData.AddConstant('CN_NOTIFY', Controls_CN_NOTIFY_si, nil, VarType(Controls.CN_NOTIFY));
  AData.AddConstant('mrNone', Controls_mrNone_si, nil, VarType(Controls.mrNone));
  AData.AddConstant('mrOk', Controls_mrOk_si, Integer_sw);
  AData.AddConstant('mrCancel', Controls_mrCancel_si, Integer_sw);
  AData.AddConstant('mrAbort', Controls_mrAbort_si, Integer_sw);
  AData.AddConstant('mrRetry', Controls_mrRetry_si, Integer_sw);
  AData.AddConstant('mrIgnore', Controls_mrIgnore_si, Integer_sw);
  AData.AddConstant('mrYes', Controls_mrYes_si, Integer_sw);
  AData.AddConstant('mrNo', Controls_mrNo_si, Integer_sw);
  AData.AddConstant('mrAll', Controls_mrAll_si, nil, VarType(Controls.mrAll));
  AData.AddConstant('mrNoToAll', Controls_mrNoToAll_si, nil, VarType(Controls.mrNoToAll));
  AData.AddConstant('mrYesToAll', Controls_mrYesToAll_si, nil, VarType(Controls.mrYesToAll));
  AData.AddConstant('mrClose', Controls_mrClose_si, nil, VarType(Controls.mrClose));
  AData.AddType(TModalResult_sw, Controls_TModalResult_si);
  AData.AddFunction('IsPositiveResult', Controls_IsPositiveResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsNegativeResult', Controls_IsNegativeResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsAbortResult', Controls_IsAbortResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsAnAllResult', Controls_IsAnAllResult_si, Boolean_sw, 1, False);
  AData.AddFunction('StripAllFromResult', Controls_StripAllFromResult_si, TModalResult_sw, 1, False);
  AData.AddType(TCursor_sw, Controls_TCursor_si);
  AData.AddConstant('crDefault', Controls_crDefault_si, TCursor_sw);
  AData.AddConstant('crNone', Controls_crNone_si, TCursor_sw);
  AData.AddConstant('crArrow', Controls_crArrow_si, TCursor_sw);
  AData.AddConstant('crCross', Controls_crCross_si, TCursor_sw);
  AData.AddConstant('crIBeam', Controls_crIBeam_si, TCursor_sw);
  AData.AddConstant('crSize', Controls_crSize_si, TCursor_sw);
  AData.AddConstant('crSizeNESW', Controls_crSizeNESW_si, TCursor_sw);
  AData.AddConstant('crSizeNS', Controls_crSizeNS_si, TCursor_sw);
  AData.AddConstant('crSizeNWSE', Controls_crSizeNWSE_si, TCursor_sw);
  AData.AddConstant('crSizeWE', Controls_crSizeWE_si, TCursor_sw);
  AData.AddConstant('crUpArrow', Controls_crUpArrow_si, TCursor_sw);
  AData.AddConstant('crHourGlass', Controls_crHourGlass_si, TCursor_sw);
  AData.AddConstant('crDrag', Controls_crDrag_si, TCursor_sw);
  AData.AddConstant('crNoDrop', Controls_crNoDrop_si, TCursor_sw);
  AData.AddConstant('crHSplit', Controls_crHSplit_si, TCursor_sw);
  AData.AddConstant('crVSplit', Controls_crVSplit_si, TCursor_sw);
  AData.AddConstant('crMultiDrag', Controls_crMultiDrag_si, TCursor_sw);
  AData.AddConstant('crSQLWait', Controls_crSQLWait_si, TCursor_sw);
  AData.AddConstant('crNo', Controls_crNo_si, TCursor_sw);
  AData.AddConstant('crAppStart', Controls_crAppStart_si, TCursor_sw);
  AData.AddConstant('crHelp', Controls_crHelp_si, TCursor_sw);
  AData.AddConstant('crHandPoint', Controls_crHandPoint_si, TCursor_sw);
  AData.AddConstant('crSizeAll', Controls_crSizeAll_si, TCursor_sw);
  AData.AddConstant('sgiNoGesture', Controls_sgiNoGesture_si, nil, VarType(Controls.sgiNoGesture));
  AData.AddConstant('sgiLeft', Controls_sgiLeft_si, nil, VarType(Controls.sgiLeft));
  AData.AddConstant('sgiRight', Controls_sgiRight_si, nil, VarType(Controls.sgiRight));
  AData.AddConstant('sgiUp', Controls_sgiUp_si, nil, VarType(Controls.sgiUp));
  AData.AddConstant('sgiDown', Controls_sgiDown_si, nil, VarType(Controls.sgiDown));
  AData.AddConstant('sgiUpLeft', Controls_sgiUpLeft_si, nil, VarType(Controls.sgiUpLeft));
  AData.AddConstant('sgiUpRight', Controls_sgiUpRight_si, nil, VarType(Controls.sgiUpRight));
  AData.AddConstant('sgiDownLeft', Controls_sgiDownLeft_si, nil, VarType(Controls.sgiDownLeft));
  AData.AddConstant('sgiDownRight', Controls_sgiDownRight_si, nil, VarType(Controls.sgiDownRight));
  AData.AddConstant('sgiLeftUp', Controls_sgiLeftUp_si, nil, VarType(Controls.sgiLeftUp));
  AData.AddConstant('sgiLeftDown', Controls_sgiLeftDown_si, nil, VarType(Controls.sgiLeftDown));
  AData.AddConstant('sgiRightUp', Controls_sgiRightUp_si, nil, VarType(Controls.sgiRightUp));
  AData.AddConstant('sgiRightDown', Controls_sgiRightDown_si, nil, VarType(Controls.sgiRightDown));
  AData.AddConstant('sgiUpDown', Controls_sgiUpDown_si, nil, VarType(Controls.sgiUpDown));
  AData.AddConstant('sgiDownUp', Controls_sgiDownUp_si, nil, VarType(Controls.sgiDownUp));
  AData.AddConstant('sgiLeftRight', Controls_sgiLeftRight_si, nil, VarType(Controls.sgiLeftRight));
  AData.AddConstant('sgiRightLeft', Controls_sgiRightLeft_si, nil, VarType(Controls.sgiRightLeft));
  AData.AddConstant('sgiUpLeftLong', Controls_sgiUpLeftLong_si, nil, VarType(Controls.sgiUpLeftLong));
  AData.AddConstant('sgiUpRightLong', Controls_sgiUpRightLong_si, nil, VarType(Controls.sgiUpRightLong));
  AData.AddConstant('sgiDownLeftLong', Controls_sgiDownLeftLong_si, nil, VarType(Controls.sgiDownLeftLong));
  AData.AddConstant('sgiDownRightLong', Controls_sgiDownRightLong_si, nil, VarType(Controls.sgiDownRightLong));
  AData.AddConstant('sgiScratchout', Controls_sgiScratchout_si, nil, VarType(Controls.sgiScratchout));
  AData.AddConstant('sgiTriangle', Controls_sgiTriangle_si, nil, VarType(Controls.sgiTriangle));
  AData.AddConstant('sgiSquare', Controls_sgiSquare_si, nil, VarType(Controls.sgiSquare));
  AData.AddConstant('sgiCheck', Controls_sgiCheck_si, nil, VarType(Controls.sgiCheck));
  AData.AddConstant('sgiCurlicue', Controls_sgiCurlicue_si, nil, VarType(Controls.sgiCurlicue));
  AData.AddConstant('sgiDoubleCurlicue', Controls_sgiDoubleCurlicue_si, nil, VarType(Controls.sgiDoubleCurlicue));
  AData.AddConstant('sgiCircle', Controls_sgiCircle_si, nil, VarType(Controls.sgiCircle));
  AData.AddConstant('sgiDoubleCircle', Controls_sgiDoubleCircle_si, nil, VarType(Controls.sgiDoubleCircle));
  AData.AddConstant('sgiSemiCircleLeft', Controls_sgiSemiCircleLeft_si, nil, VarType(Controls.sgiSemiCircleLeft));
  AData.AddConstant('sgiSemiCircleRight', Controls_sgiSemiCircleRight_si, nil, VarType(Controls.sgiSemiCircleRight));
  AData.AddConstant('sgiChevronUp', Controls_sgiChevronUp_si, nil, VarType(Controls.sgiChevronUp));
  AData.AddConstant('sgiChevronDown', Controls_sgiChevronDown_si, nil, VarType(Controls.sgiChevronDown));
  AData.AddConstant('sgiChevronLeft', Controls_sgiChevronLeft_si, nil, VarType(Controls.sgiChevronLeft));
  AData.AddConstant('sgiChevronRight', Controls_sgiChevronRight_si, nil, VarType(Controls.sgiChevronRight));
  AData.AddConstant('sgiFirst', Controls_sgiFirst_si, Integer_sw);
  AData.AddConstant('sgiLast', Controls_sgiLast_si, Integer_sw);
  AData.AddConstant('cgiFirst', Controls_cgiFirst_si, nil, VarType(Controls.cgiFirst));
  AData.AddConstant('cgiLast', Controls_cgiLast_si, nil, VarType(Controls.cgiLast));
  AData.AddConstant('rgiFirst', Controls_rgiFirst_si, nil, VarType(Controls.rgiFirst));
  AData.AddConstant('rgiLast', Controls_rgiLast_si, nil, VarType(Controls.rgiLast));
  AData.AddConstant('igiFirst', Controls_igiFirst_si, nil, VarType(Controls.igiFirst));
  AData.AddConstant('igiLast', Controls_igiLast_si, nil, VarType(Controls.igiLast));
  AData.AddConstant('igiBegin', Controls_igiBegin_si, nil, VarType(Controls.igiBegin));
  AData.AddConstant('igiEnd', Controls_igiEnd_si, nil, VarType(Controls.igiEnd));
  AData.AddConstant('igiZoom', Controls_igiZoom_si, nil, VarType(Controls.igiZoom));
  AData.AddConstant('igiPan', Controls_igiPan_si, nil, VarType(Controls.igiPan));
  AData.AddConstant('igiRotate', Controls_igiRotate_si, nil, VarType(Controls.igiRotate));
  AData.AddConstant('igiTwoFingerTap', Controls_igiTwoFingerTap_si, nil, VarType(Controls.igiTwoFingerTap));
  AData.AddConstant('igiPressAndTap', Controls_igiPressAndTap_si, nil, VarType(Controls.igiPressAndTap));
  AData.AddConstant('gcnRefreshAll', Controls_gcnRefreshAll_si, nil, VarType(Controls.gcnRefreshAll));
  AData.AddConstant('gcnAdded', Controls_gcnAdded_si, nil, VarType(Controls.gcnAdded));
  AData.AddConstant('gcnRemoved', Controls_gcnRemoved_si, nil, VarType(Controls.gcnRemoved));
  AData.AddConstant('gcnModified', Controls_gcnModified_si, nil, VarType(Controls.gcnModified));
  AData.AddType(TInteractiveGestureFlag_sw, Controls_TInteractiveGestureFlag_si);
  AData.AddType(TInteractiveGestureFlags_sw, Controls_TInteractiveGestureFlags_si);
  AData.AddType(TInteractiveGesture_sw, Controls_TInteractiveGesture_si);
  AData.AddType(TInteractiveGestures_sw, Controls_TInteractiveGestures_si);
  AData.AddType(TInteractiveGestureOption_sw, Controls_TInteractiveGestureOption_si);
  AData.AddType(TInteractiveGestureOptions_sw, Controls_TInteractiveGestureOptions_si);
  AData.AddType(TCustomLongData_sw, Controls_TCustomLongData_si);
  AData.AddType(TWinControlClass_sw, Controls_TWinControlClass_si);
  AData.AddType(THintWindowClass_sw, Controls_THintWindowClass_si);
  AData.AddType(TCMActivate_sw, Controls_TCMActivate_si);
  AData.AddType(TCMDeactivate_sw, Controls_TCMDeactivate_si);
  AData.AddType(TCMGotFocus_sw, Controls_TCMGotFocus_si);
  AData.AddType(TCMLostFocus_sw, Controls_TCMLostFocus_si);
  AData.AddType(TCMDialogKey_sw, Controls_TCMDialogKey_si);
  AData.AddType(TCMDialogChar_sw, Controls_TCMDialogChar_si);
  AData.AddType(TCMHitTest_sw, Controls_TCMHitTest_si);
  AData.AddType(TCMEnter_sw, Controls_TCMEnter_si);
  AData.AddType(TCMExit_sw, Controls_TCMExit_si);
  AData.AddType(TCMDesignHitTest_sw, Controls_TCMDesignHitTest_si);
  AData.AddType(TCMWantSpecialKey_sw, Controls_TCMWantSpecialKey_si);
  AData.AddType(TCMMouseWheel_sw, Controls_TCMMouseWheel_si);
  AData.AddType(TCMCancelMode_sw, Controls_TCMCancelMode_si);
  AData.AddType(TCMFocusChanged_sw, Controls_TCMFocusChanged_si);
  AData.AddType(TCMControlListChange_sw, Controls_TCMControlListChange_si);
  AData.AddType(TControlListItem_sw, Controls_TControlListItem_si);
  AData.AddType(TCMControlListChanging_sw, Controls_TCMControlListChanging_si);
  AData.AddType(TCMChildKey_sw, Controls_TCMChildKey_si);
  AData.AddType(TCMControlChange_sw, Controls_TCMControlChange_si);
  AData.AddType(TCMChanged_sw, Controls_TCMChanged_si);
  AData.AddType(THintInfo_sw, Controls_THintInfo_si);
  AData.AddType(TCMHintShow_sw, Controls_TCMHintShow_si);
  AData.AddType(TCMParentFontChanged_sw, Controls_TCMParentFontChanged_si);
  AData.AddType(TDragMessage_sw, Controls_TDragMessage_si);
  AData.AddType(TDragRec_sw, Controls_TDragRec_si);
  AData.AddType(TCMDrag_sw, Controls_TCMDrag_si);
  AData.AddType(TDockNotifyRec_sw, Controls_TDockNotifyRec_si);
  AData.AddType(TCMDockClient_sw, Controls_TCMDockClient_si);
  AData.AddType(TCMUnDockClient_sw, Controls_TCMUnDockClient_si);
  AData.AddType(TCMFloat_sw, Controls_TCMFloat_si);
  AData.AddType(TCMDockNotification_sw, Controls_TCMDockNotification_si);
  AData.AddType(TPopupFormInfo_sw, Controls_TPopupFormInfo_si);
  AData.AddType(TCMPopupHWndDestroy_sw, Controls_TCMPopupHWndDestroy_si);
  AData.AddType(TCMCreatePopup_sw, Controls_TCMCreatePopup_si);
  AData.AddType(TAlign_sw, Controls_TAlign_si);
  AData.AddType(TAlignSet_sw, Controls_TAlignSet_si);
  AData.AddType(TDragObject_sw, Controls_TDragObject_si);
  AData.AddType(TDragObjectClass_sw, Controls_TDragObjectClass_si);
  AData.AddType(TDragObjectEx_sw, Controls_TDragObjectEx_si);
  AData.AddType(TBaseDragControlObject_sw, Controls_TBaseDragControlObject_si);
  AData.AddType(TDragControlObject_sw, Controls_TDragControlObject_si);
  AData.AddType(TDragControlObjectEx_sw, Controls_TDragControlObjectEx_si);
  AData.AddType(TDragDockObject_sw, Controls_TDragDockObject_si);
  AData.AddType(TDragDockObjectEx_sw, Controls_TDragDockObjectEx_si);
  AData.AddType(TCanvasDC_sw, Controls_TCanvasDC_si);
  AData.AddType(TControlCanvas_sw, Controls_TControlCanvas_si);
  AData.AddType(TCustomControlAction_sw, Controls_TCustomControlAction_si);
  AData.AddType(TControlAction_sw, Controls_TControlAction_si);
  AData.AddType(TControlActionLink_sw, Controls_TControlActionLink_si);
  AData.AddType(TControlActionLinkClass_sw, Controls_TControlActionLinkClass_si);
  AData.AddType(TMouseButton_sw, Controls_TMouseButton_si);
  AData.AddType(TMouseActivate_sw, Controls_TMouseActivate_si);
  AData.AddType(TDragMode_sw, Controls_TDragMode_si);
  AData.AddType(TDragState_sw, Controls_TDragState_si);
  AData.AddType(TDragKind_sw, Controls_TDragKind_si);
  AData.AddType(TTabOrder_sw, Controls_TTabOrder_si);
  AData.AddType(TCaption_sw, Controls_TCaption_si);
  AData.AddType(TMouseActivateRec_sw, Controls_TMouseActivateRec_si);
  AData.AddType(TCMMouseActivate_sw, Controls_TCMMouseActivate_si);
  AData.AddType(TAnchorKind_sw, Controls_TAnchorKind_si);
  AData.AddType(TAnchors_sw, Controls_TAnchors_si);
  AData.AddType(TConstraintSize_sw, Controls_TConstraintSize_si);
  AData.AddType(TSizeConstraints_sw, Controls_TSizeConstraints_si);
  AData.AddType(TMarginSize_sw, Controls_TMarginSize_si);
  AData.AddType(TMargins_sw, Controls_TMargins_si);
  AData.AddType(TPadding_sw, Controls_TPadding_si);
  AData.AddType(TGestureID_sw, Controls_TGestureID_si);
  AData.AddType(TGestureEventInfo_sw, Controls_TGestureEventInfo_si);
  AData.AddType(TCMGesture_sw, Controls_TCMGesture_si);
  AData.AddType(TGestureEvent_sw, Controls_TGestureEvent_si);
  AData.AddType(TStandardGesture_sw, Controls_TStandardGesture_si);
  AData.AddType(TStandardGestures_sw, Controls_TStandardGestures_si);
  AData.AddType(TTabletOption_sw, Controls_TTabletOption_si);
  AData.AddType(TTabletOptions_sw, Controls_TTabletOptions_si);
  AData.AddType(TGestureType_sw, Controls_TGestureType_si);
  AData.AddType(TGestureTypes_sw, Controls_TGestureTypes_si);
  AData.AddType(TGestureOption_sw, Controls_TGestureOption_si);
  AData.AddType(TGestureOptions_sw, Controls_TGestureOptions_si);
  AData.AddType(EGestureException_sw, Controls_EGestureException_si);
  AData.AddType(TCustomGestureCollectionItem_sw, Controls_TCustomGestureCollectionItem_si);
  AData.AddType(TCustomGestureCollection_sw, Controls_TCustomGestureCollection_si);
  AData.AddType(TCustomGestureManager_sw, Controls_TCustomGestureManager_si);
  AData.AddType(TCustomGestureEngine_sw, Controls_TCustomGestureEngine_si);
  AData.AddType(TTouchProperty_sw, Controls_TTouchProperty_si);
  AData.AddType(TCustomTouchManager_sw, Controls_TCustomTouchManager_si);
  AData.AddType(TTouchManager_sw, Controls_TTouchManager_si);
  AData.AddType(TKeyPressEvent_sw, Controls_TKeyPressEvent_si);
  AData.AddType(TDragOverEvent_sw, Controls_TDragOverEvent_si);
  AData.AddType(TDragDropEvent_sw, Controls_TDragDropEvent_si);
  AData.AddType(TStartDragEvent_sw, Controls_TStartDragEvent_si);
  AData.AddType(TEndDragEvent_sw, Controls_TEndDragEvent_si);
  AData.AddType(TDockDropEvent_sw, Controls_TDockDropEvent_si);
  AData.AddType(TDockOverEvent_sw, Controls_TDockOverEvent_si);
  AData.AddType(TUnDockEvent_sw, Controls_TUnDockEvent_si);
  AData.AddType(TStartDockEvent_sw, Controls_TStartDockEvent_si);
  AData.AddType(TGetSiteInfoEvent_sw, Controls_TGetSiteInfoEvent_si);
  AData.AddType(TCanResizeEvent_sw, Controls_TCanResizeEvent_si);
  AData.AddType(TConstrainedResizeEvent_sw, Controls_TConstrainedResizeEvent_si);
  AData.AddType(TContextPopupEvent_sw, Controls_TContextPopupEvent_si);
  AData.AddType(TWndMethod_sw, Controls_TWndMethod_si);
  AData.AddType(TDockOrientation_sw, Controls_TDockOrientation_si);
  AData.AddType(TControl_sw, Controls_TControl_si);
  AData.AddType(TControlClass_sw, Controls_TControlClass_si);
  AData.AddType(TCreateParams_sw, Controls_TCreateParams_si);
  AData.AddType(TWinControlActionLink_sw, Controls_TWinControlActionLink_si);
  AData.AddType(TWinControlActionLinkClass_sw, Controls_TWinControlActionLinkClass_si);
  AData.AddType(TImeMode_sw, Controls_TImeMode_si);
  AData.AddType(TImeName_sw, Controls_TImeName_si);
  AData.AddType(TAlignInfo_sw, Controls_TAlignInfo_si);
  AData.AddType(TBorderWidth_sw, Controls_TBorderWidth_si);
  AData.AddType(TBevelCut_sw, Controls_TBevelCut_si);
  AData.AddType(TBevelEdge_sw, Controls_TBevelEdge_si);
  AData.AddType(TBevelEdges_sw, Controls_TBevelEdges_si);
  AData.AddType(TBevelKind_sw, Controls_TBevelKind_si);
  AData.AddType(TBevelWidth_sw, Controls_TBevelWidth_si);
  AData.AddType(TAlignInsertBeforeEvent_sw, Controls_TAlignInsertBeforeEvent_si);
  AData.AddType(TAlignPositionEvent_sw, Controls_TAlignPositionEvent_si);
  AData.AddType(TWinControl_sw, Controls_TWinControl_si);
  AData.AddType(TGraphicControl_sw, Controls_TGraphicControl_si);
  AData.AddType(TCustomControl_sw, Controls_TCustomControl_si);
  AData.AddType(TCustomTransparentControl_sw, Controls_TCustomTransparentControl_si);
  AData.AddType(THintWindow_sw, Controls_THintWindow_si);
  AData.AddType(TDragImageList_sw, Controls_TDragImageList_si);
  AData.AddType(TImageList_sw, Controls_TImageList_si);
  AData.AddType(TDockZone_sw, Controls_TDockZone_si);
  AData.AddType(TForEachZoneProc_sw, Controls_TForEachZoneProc_si);
  AData.AddType(TDockTreeClass_sw, Controls_TDockTreeClass_si);
  AData.AddType(TDockTree_sw, Controls_TDockTree_si);
  AData.AddType(TPanningWindowClass_sw, Controls_TPanningWindowClass_si);
  AData.AddType(TCustomPanningWindow_sw, Controls_TCustomPanningWindow_si);
  AData.AddType(TMouse_sw, Controls_TMouse_si);
  AData.AddType(TCustomListControl_sw, Controls_TCustomListControl_si);
  AData.AddType(TCustomMultiSelectListControl_sw, Controls_TCustomMultiSelectListControl_si);
  AData.AddType(TBalloonHintIcon_sw, Controls_TBalloonHintIcon_si);
  AData.AddType(TBalloonHintIconSize_sw, Controls_TBalloonHintIconSize_si);
  AData.AddType(TBalloonHintStyle_sw, Controls_TBalloonHintStyle_si);
  AData.AddType(TCustomHintWindow_sw, Controls_TCustomHintWindow_si);
  AData.AddType(TCustomHintShowHideThread_sw, Controls_TCustomHintShowHideThread_si);
  AData.AddType(TCustomHint_sw, Controls_TCustomHint_si);
  AData.AddType(TBalloonHint_sw, Controls_TBalloonHint_si);
  AData.AddConstant('cImageMargin', Controls_cImageMargin_si, nil, VarType(Controls.cImageMargin));
  AData.AddConstant('cTextVerticalMargin', Controls_cTextVerticalMargin_si, nil, VarType(Controls.cTextVerticalMargin));
  AData.AddConstant('cTextHorizontalMargin', Controls_cTextHorizontalMargin_si, nil, VarType(Controls.cTextHorizontalMargin));
  AData.AddConstant('cBalloonStemHeight', Controls_cBalloonStemHeight_si, nil, VarType(Controls.cBalloonStemHeight));
  AData.AddConstant('cEdgeRadius', Controls_cEdgeRadius_si, nil, VarType(Controls.cEdgeRadius));
  AData.AddVariable('Mouse', Controls_Mouse_si, TMouse_sw);
  AData.AddFunction('IsDragObject', Controls_IsDragObject_si, Boolean_sw, 1, False);
  AData.AddFunction('IsVCLControl', Controls_IsVCLControl_si, Boolean_sw, 1, False);
  AData.AddFunction('FindControl', Controls_FindControl_si, TWinControl_sw, 1, False);
  AData.AddFunction('FindVCLWindow', Controls_FindVCLWindow_si, TWinControl_sw, 1, False);
  AData.AddFunction('FindDragTarget', Controls_FindDragTarget_si, TControl_sw, 2, False);
  AData.AddFunction('GetCaptureControl', Controls_GetCaptureControl_si, TControl_sw, 0, False);
  AData.AddProcedure('SetCaptureControl', Controls_SetCaptureControl_si, 1, False);
  AData.AddProcedure('CancelDrag', Controls_CancelDrag_si, 0, False);
  AData.AddFunction('CursorToString', Controls_CursorToString_si, string_sw, 1, False);
  AData.AddFunction('StringToCursor', Controls_StringToCursor_si, TCursor_sw, 1, False);
  AData.AddProcedure('GetCursorValues', Controls_GetCursorValues_si, 1, False);
  AData.AddFunction('CursorToIdent', Controls_CursorToIdent_si, Boolean_sw, 2, False);
  AData.AddFunction('IdentToCursor', Controls_IdentToCursor_si, Boolean_sw, 2, False);
  AData.AddFunction('GetShortHint', Controls_GetShortHint_si, string_sw, 1, False);
  AData.AddFunction('GetLongHint', Controls_GetLongHint_si, string_sw, 1, False);
  AData.AddProcedure('PerformEraseBackground', Controls_PerformEraseBackground_si, 2, False);
  AData.AddProcedure('PerformBufferedPrintClient', Controls_PerformBufferedPrintClient_si, 2, False);
  AData.AddFunction('InitWndProc', Controls_InitWndProc_si, LRESULT_sw, 4, False);
  AData.AddVariable('DefaultDockTreeClass', Controls_DefaultDockTreeClass_si, TDockTreeClass_sw);
  AData.AddVariable('CreationControl', Controls_CreationControl_si, TWinControl_sw);
  AData.AddConstant('CTL3D_ALL', Controls_CTL3D_ALL_si, nil, VarType(Controls.CTL3D_ALL));
  AData.AddConstant('NullDockSite', Controls_NullDockSite_si, TWinControl_sw);
  AData.AddVariable('NewStyleControls', Controls_NewStyleControls_si, Boolean_sw);
  AData.AddProcedure('ChangeBiDiModeAlignment', Controls_ChangeBiDiModeAlignment_si, 1, False);
  AData.AddFunction('SendAppMessage', Controls_SendAppMessage_si, Longint_sw, 3, False);
  AData.AddProcedure('MoveWindowOrg', Controls_MoveWindowOrg_si, 3, False);
  AData.AddProcedure('SetImeMode', Controls_SetImeMode_si, 2, False);
  AData.AddProcedure('SetImeName', Controls_SetImeName_si, 1, False);
  AData.AddFunction('Win32NLSEnableIME', Controls_Win32NLSEnableIME_si, Boolean_sw, 2, False);
  AData.AddFunction('Imm32GetContext', Controls_Imm32GetContext_si, HIMC_sw, 1, False);
  AData.AddFunction('Imm32ReleaseContext', Controls_Imm32ReleaseContext_si, Boolean_sw, 2, False);
  AData.AddFunction('Imm32GetConversionStatus', Controls_Imm32GetConversionStatus_si, Boolean_sw, 3, False);
  AData.AddFunction('Imm32SetConversionStatus', Controls_Imm32SetConversionStatus_si, Boolean_sw, 3, False);
  AData.AddFunction('Imm32SetOpenStatus', Controls_Imm32SetOpenStatus_si, Boolean_sw, 2, False);
  AData.AddFunction('Imm32SetCompositionWindow', Controls_Imm32SetCompositionWindow_si, nil, 2, False);
  AData.AddFunction('Imm32SetCompositionFont', Controls_Imm32SetCompositionFont_si, nil, 2, False);
  AData.AddFunction('Imm32IsIME', Controls_Imm32IsIME_si, Boolean_sw, 1, False);
  AData.AddFunction('Imm32NotifyIME', Controls_Imm32NotifyIME_si, Boolean_sw, 4, False);
  AData.AddProcedure('DragDone', Controls_DragDone_si, 1, False);
end;

class function Controls_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Controls_sw);
end;

initialization
  RegisterUnitWrapper(Controls_sw);
  RegisterClassWrapper(TDragObject_sw);
  RegisterClassWrapper(TDragObjectEx_sw);
  RegisterClassWrapper(TBaseDragControlObject_sw);
  RegisterClassWrapper(TDragControlObject_sw);
  RegisterClassWrapper(TDragControlObjectEx_sw);
  RegisterClassWrapper(TDragDockObject_sw);
  RegisterClassWrapper(TDragDockObjectEx_sw);
  RegisterClassWrapper(TControlCanvas_sw);
  RegisterClassWrapper(TCustomControlAction_sw);
  RegisterClassWrapper(TControlAction_sw);
  RegisterClassWrapper(TControlActionLink_sw);
  RegisterClassWrapper(TSizeConstraints_sw);
  RegisterClassWrapper(TMargins_sw);
  RegisterClassWrapper(TPadding_sw);
  RegisterClassWrapper(EGestureException_sw);
  RegisterClassWrapper(TCustomGestureCollectionItem_sw);
  RegisterClassWrapper(TCustomGestureCollection_sw);
  RegisterClassWrapper(TCustomGestureManager_sw);
  RegisterClassWrapper(TCustomGestureEngine_sw);
  RegisterClassWrapper(TCustomTouchManager_sw);
  RegisterClassWrapper(TTouchManager_sw);
  RegisterClassWrapper(TControl_sw);
  RegisterClassWrapper(TWinControlActionLink_sw);
  RegisterClassWrapper(TWinControl_sw);
  RegisterClassWrapper(TGraphicControl_sw);
  RegisterClassWrapper(TCustomControl_sw);
  RegisterClassWrapper(TCustomTransparentControl_sw);
  RegisterClassWrapper(THintWindow_sw);
  RegisterClassWrapper(TDragImageList_sw);
  RegisterClassWrapper(TImageList_sw);
  RegisterClassWrapper(TDockZone_sw);
  RegisterClassWrapper(TDockTree_sw);
  RegisterClassWrapper(TCustomPanningWindow_sw);
  RegisterClassWrapper(TMouse_sw);
  RegisterClassWrapper(TCustomListControl_sw);
  RegisterClassWrapper(TCustomMultiSelectListControl_sw);
  RegisterClassWrapper(TCustomHintWindow_sw);
  RegisterClassWrapper(TCustomHintShowHideThread_sw);
  RegisterClassWrapper(TCustomHint_sw);
  RegisterClassWrapper(TBalloonHint_sw);
  RegisterEventWrapper(TypeInfo(TGestureEvent), TGestureEvent_sw);
  RegisterEventWrapper(TypeInfo(TKeyPressEvent), TKeyPressEvent_sw);
  RegisterEventWrapper(TypeInfo(TDragOverEvent), TDragOverEvent_sw);
  RegisterEventWrapper(TypeInfo(TDragDropEvent), TDragDropEvent_sw);
  RegisterEventWrapper(TypeInfo(TStartDragEvent), TStartDragEvent_sw);
  RegisterEventWrapper(TypeInfo(TEndDragEvent), TEndDragEvent_sw);
  RegisterEventWrapper(TypeInfo(TDockDropEvent), TDockDropEvent_sw);
  RegisterEventWrapper(TypeInfo(TDockOverEvent), TDockOverEvent_sw);
  RegisterEventWrapper(TypeInfo(TUnDockEvent), TUnDockEvent_sw);
  RegisterEventWrapper(TypeInfo(TStartDockEvent), TStartDockEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetSiteInfoEvent), TGetSiteInfoEvent_sw);
  RegisterEventWrapper(TypeInfo(TCanResizeEvent), TCanResizeEvent_sw);
  RegisterEventWrapper(TypeInfo(TConstrainedResizeEvent), TConstrainedResizeEvent_sw);
  RegisterEventWrapper(TypeInfo(TContextPopupEvent), TContextPopupEvent_sw);
  RegisterEventWrapper(TypeInfo(TAlignInsertBeforeEvent), TAlignInsertBeforeEvent_sw);
  RegisterEventWrapper(TypeInfo(TAlignPositionEvent), TAlignPositionEvent_sw);
  RegisterEventWrapper(TypeInfo(TForEachZoneProc), TForEachZoneProc_sw);

end.
