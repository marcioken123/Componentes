unit Vcl.Forms_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.Forms' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Variants, System.TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Winapi.Messages, Winapi.Windows,
  System.UITypes, System.SysUtils, System.Classes, System.Actions,
  Vcl.Graphics, Vcl.Menus, Vcl.Controls, Winapi.Imm, Vcl.ActnList,
  Winapi.MultiMon, System.HelpIntfs, Vcl.Forms, Winapi.Messages_LMDSW,
  Winapi.Windows_LMDSW, System.UITypes_LMDSW, System.SysUtils_LMDSW,
  System.Classes_LMDSW, System.Actions_LMDSW, Vcl.Graphics_LMDSW,
  Vcl.Menus_LMDSW, Vcl.Controls_LMDSW, Winapi.Imm_LMDSW, Vcl.ActnList_LMDSW,
  Winapi.MultiMon_LMDSW, System.HelpIntfs_LMDSW;


{ Type wrappers }

type
  TControlScrollBar_sw = class;
  TScrollingWinControl_sw = class;
  TScrollBox_sw = class;
  TCustomFrame_sw = class;
  TCustomFrameClass_sw = class;
  TFrame_sw = class;
  TGlassFrame_sw = class;
  TCustomForm_sw = class;
  TCustomFormClass_sw = class;
  TCustomActiveForm_sw = class;
  TForm_sw = class;
  TFormClass_sw = class;
  TCustomDockForm_sw = class;
  TMonitor_sw = class;
  TScreen_sw = class;
  TApplication_sw = class;

  TScrollBarKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollBarKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollBarKind;
  end;

  TScrollBarInc_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TScrollBarInc): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollBarInc;
  end;

  TScrollBarStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollBarStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollBarStyle;
  end;

  TControlScrollBar_sc = class of TControlScrollBar;
  TControlScrollBar_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TControlScrollBar): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlScrollBar;
    class function ClassToVar(AClass: TControlScrollBar_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TControlScrollBar_sc;
  end;

  TWindowState_sw = System.UITypes_LMDSW.TWindowState_sw;

  TScrollingWinControl_sc = class of TScrollingWinControl;
  TScrollingWinControl_sw = class(TWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TScrollingWinControl): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollingWinControl;
    class function ClassToVar(AClass: TScrollingWinControl_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TScrollingWinControl_sc;
  end;

  TFormBorderStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFormBorderStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFormBorderStyle;
  end;

  TBorderStyle_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TBorderStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TBorderStyle;
  end;

  TScrollBox_sc = class of TScrollBox;
  TScrollBox_sw = class(TScrollingWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TScrollBox): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollBox;
    class function ClassToVar(AClass: TScrollBox_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TScrollBox_sc;
  end;

  TCustomFrame_sc = class of TCustomFrame;
  TCustomFrame_sw = class(TScrollingWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomFrame): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFrame;
    class function ClassToVar(AClass: TCustomFrame_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomFrame_sc;
  end;

  TCustomFrameClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomFrameClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFrameClass;
  end;

  TFrame_sc = class of TFrame;
  TFrame_sw = class(TCustomFrame_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFrame): OleVariant;
    class function FromVar(const AValue: OleVariant): TFrame;
    class function ClassToVar(AClass: TFrame_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFrame_sc;
  end;

  THelpEventData_sw = NativeInt_sw;

  TPopupWnd_sw = class(TLMDRecordWrapper)
  private
    FValue: TPopupWnd;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPopupWnd): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupWnd;
  end;

  TBorderIcon_sw = System.UITypes_LMDSW.TBorderIcon_sw;

  TBorderIcons_sw = System.UITypes_LMDSW.TBorderIcons_sw;

  TFormStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFormStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFormStyle;
  end;

  TPosition_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPosition): OleVariant;
    class function FromVar(const AValue: OleVariant): TPosition;
  end;

  TDefaultMonitor_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TDefaultMonitor): OleVariant;
    class function FromVar(const AValue: OleVariant): TDefaultMonitor;
  end;

  TPrintScale_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrintScale): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintScale;
  end;

  TShowAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TShowAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TShowAction;
  end;

  TTileMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTileMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TTileMode;
  end;

  TCloseAction_sw = System.UITypes_LMDSW.TCloseAction_sw;

  TCloseEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Action: TCloseAction);
  end;

  TCloseEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCloseEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCloseEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCloseEvent;
  end;

  TCloseQueryEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var CanClose: Boolean);
  end;

  TCloseQueryEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCloseQueryEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TCloseQueryEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TCloseQueryEvent;
  end;

  TShortCutEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var Msg: TWMKey; var Handled: Boolean);
  end;

  TShortCutEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TShortCutEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TShortCutEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TShortCutEvent;
  end;

  THelpEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(Command: Word; Data: THelpEventData;
      var CallHelp: Boolean): Boolean;
  end;

  THelpEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: THelpEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): THelpEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): THelpEvent;
  end;

  TMonitorDpiChangedEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; OldDPI: Integer; NewDPI: Integer);
  end;

  TMonitorDpiChangedEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMonitorDpiChangedEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonitorDpiChangedEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMonitorDpiChangedEvent;
  end;

  TPopupMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPopupMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupMode;
  end;

  TGlassFrame_sc = class of TGlassFrame;
  TGlassFrame_sw = class(TPersistent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TGlassFrame): OleVariant;
    class function FromVar(const AValue: OleVariant): TGlassFrame;
    class function ClassToVar(AClass: TGlassFrame_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TGlassFrame_sc;
  end;

  TCustomForm_sc = class of TCustomForm;
  TCustomForm_sw = class(TScrollingWinControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomForm;
    class function ClassToVar(AClass: TCustomForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomForm_sc;
  end;

  TCustomFormClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomFormClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomFormClass;
  end;

  TActiveFormBorderStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TActiveFormBorderStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TActiveFormBorderStyle;
  end;

  TCustomActiveForm_sc = class of TCustomActiveForm;
  TCustomActiveForm_sw = class(TCustomForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomActiveForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomActiveForm;
    class function ClassToVar(AClass: TCustomActiveForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomActiveForm_sc;
  end;

  TForm_sc = class of TForm;
  TForm_sw = class(TCustomForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TForm;
    class function ClassToVar(AClass: TForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TForm_sc;
  end;

  TFormClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TFormClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TFormClass;
  end;

  TCustomDockForm_sc = class of TCustomDockForm;
  TCustomDockForm_sw = class(TCustomForm_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomDockForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomDockForm;
    class function ClassToVar(AClass: TCustomDockForm_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomDockForm_sc;
  end;

  TMonitor_sc = class of TMonitor;
  TMonitor_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TMonitor): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonitor;
    class function ClassToVar(AClass: TMonitor_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TMonitor_sc;
  end;

  TCursorRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TCursorRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCursorRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursorRec;
  end;

  TMonitorDefaultTo_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMonitorDefaultTo): OleVariant;
    class function FromVar(const AValue: OleVariant): TMonitorDefaultTo;
  end;

  TScreen_sc = class of TScreen;
  TScreen_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TScreen): OleVariant;
    class function FromVar(const AValue: OleVariant): TScreen;
    class function ClassToVar(AClass: TScreen_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TScreen_sc;
  end;

  TTimerMode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTimerMode): OleVariant;
    class function FromVar(const AValue: OleVariant): TTimerMode;
  end;

  THintInfo_sw = Vcl.Controls_LMDSW.THintInfo_sw;

  TCMHintShowPause_sw = class(TLMDRecordWrapper)
  private
    FValue: TCMHintShowPause;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCMHintShowPause): OleVariant;
    class function FromVar(const AValue: OleVariant): TCMHintShowPause;
  end;

  TPopupForm_sw = class(TLMDRecordWrapper)
  private
    FValue: TPopupForm;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPopupForm): OleVariant;
    class function FromVar(const AValue: OleVariant): TPopupForm;
  end;

  TMessageEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var Msg: TMsg; var Handled: Boolean);
  end;

  TMessageEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TMessageEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TMessageEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TMessageEvent;
  end;

  TExceptionEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; E: Exception);
  end;

  TExceptionEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TExceptionEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TExceptionEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TExceptionEvent;
  end;

  TGetHandleEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var Handle: HWND);
  end;

  TGetHandleEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TGetHandleEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TGetHandleEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TGetHandleEvent;
  end;

  TIdleEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; var Done: Boolean);
  end;

  TIdleEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TIdleEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TIdleEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TIdleEvent;
  end;

  TShowHintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(var HintStr: string; var CanShow: Boolean;
      var HintInfo: Vcl.Controls.THintInfo);
  end;

  TShowHintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TShowHintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TShowHintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TShowHintEvent;
  end;

  TWindowHook_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    function Handler(var Message: TMessage): Boolean;
  end;

  TWindowHook_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TWindowHook): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowHook;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TWindowHook;
  end;

  TSettingChangeEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Flag: Integer; const Section: string;
      var Result: Longint);
  end;

  TSettingChangeEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TSettingChangeEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TSettingChangeEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TSettingChangeEvent;
  end;

  TApplication_sc = class of TApplication;
  TApplication_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TApplication): OleVariant;
    class function FromVar(const AValue: OleVariant): TApplication;
    class function ClassToVar(AClass: TApplication_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TApplication_sc;
  end;


{ Unit wrapper }

type
  Forms_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TScrollingWinControl_sacc = class(TScrollingWinControl);
  TCustomForm_sacc = class(TCustomForm);

{ TScrollBarKind_sw }

class function TScrollBarKind_sw.GetTypeName: WideString;
begin
  Result := 'TScrollBarKind';
end;

class procedure TScrollBarKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'sbHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TScrollBarKind.{$ENDIF}sbHorizontal)),
    (Name: 'sbVertical'; Value: Integer({$IFDEF LMDSCT_12}TScrollBarKind.{$ENDIF}sbVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TScrollBarKind_sw.ToVar(
  const AValue: TScrollBarKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollBarKind_sw.FromVar(
  const AValue: OleVariant): TScrollBarKind;
begin
  Result := TScrollBarKind(Integer(AValue));
end;

{ TScrollBarInc_sw }

class function TScrollBarInc_sw.GetTypeName: WideString;
begin
  Result := 'TScrollBarInc';
end;

class function TScrollBarInc_sw.ToVar(const AValue: TScrollBarInc): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollBarInc_sw.FromVar(
  const AValue: OleVariant): TScrollBarInc;
begin
  Result := TScrollBarInc(Integer(AValue));
end;

{ TScrollBarStyle_sw }

class function TScrollBarStyle_sw.GetTypeName: WideString;
begin
  Result := 'TScrollBarStyle';
end;

class procedure TScrollBarStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ssRegular'; Value: Integer({$IFDEF LMDSCT_12}TScrollBarStyle.{$ENDIF}ssRegular)),
    (Name: 'ssFlat'; Value: Integer({$IFDEF LMDSCT_12}TScrollBarStyle.{$ENDIF}ssFlat)),
    (Name: 'ssHotTrack'; Value: Integer({$IFDEF LMDSCT_12}TScrollBarStyle.{$ENDIF}ssHotTrack))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TScrollBarStyle_sw.ToVar(
  const AValue: TScrollBarStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollBarStyle_sw.FromVar(
  const AValue: OleVariant): TScrollBarStyle;
begin
  Result := TScrollBarStyle(Integer(AValue));
end;

{ TControlScrollBar_sw }

function TControlScrollBar_ChangeBiDiPosition_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ChangeBiDiPosition;

  TControlScrollBar(AObj).ChangeBiDiPosition();
end;

function TControlScrollBar_Kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Kind: TScrollBarKind read <getter>;

  Result := TScrollBarKind_sw.ToVar(TControlScrollBar(AObj).Kind);
end;

function TControlScrollBar_IsScrollBarVisible_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsScrollBarVisible: Boolean;

  Result := TControlScrollBar(AObj).IsScrollBarVisible();
end;

function TControlScrollBar_ScrollPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ScrollPos: Integer read <getter>;

  Result := TControlScrollBar(AObj).ScrollPos;
end;

function TControlScrollBar_ButtonSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ButtonSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).ButtonSize
  else
    TControlScrollBar(AObj).ButtonSize := Integer(AArgs[0]);
end;

function TControlScrollBar_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TControlScrollBar(AObj).Color)
  else
    TControlScrollBar(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TControlScrollBar_Increment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Increment: TScrollBarInc read <getter> write <se...

  if IsGet then
    Result := TScrollBarInc_sw.ToVar(TControlScrollBar(AObj).Increment)
  else
    TControlScrollBar(AObj).Increment := TScrollBarInc_sw.FromVar(AArgs[0]);
end;

function TControlScrollBar_Margin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margin: Word read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Margin
  else
    TControlScrollBar(AObj).Margin := Word(AArgs[0]);
end;

function TControlScrollBar_ParentColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ParentColor: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).ParentColor
  else
    TControlScrollBar(AObj).ParentColor := Boolean(AArgs[0]);
end;

function TControlScrollBar_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Position
  else
    TControlScrollBar(AObj).Position := Integer(AArgs[0]);
end;

function TControlScrollBar_Range_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Range: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Range
  else
    TControlScrollBar(AObj).Range := Integer(AArgs[0]);
end;

function TControlScrollBar_Smooth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Smooth: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Smooth
  else
    TControlScrollBar(AObj).Smooth := Boolean(AArgs[0]);
end;

function TControlScrollBar_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Size: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Size
  else
    TControlScrollBar(AObj).Size := Integer(AArgs[0]);
end;

function TControlScrollBar_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TScrollBarStyle read <getter> write <sett...

  if IsGet then
    Result := TScrollBarStyle_sw.ToVar(TControlScrollBar(AObj).Style)
  else
    TControlScrollBar(AObj).Style := TScrollBarStyle_sw.FromVar(AArgs[0]);
end;

function TControlScrollBar_ThumbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ThumbSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).ThumbSize
  else
    TControlScrollBar(AObj).ThumbSize := Integer(AArgs[0]);
end;

function TControlScrollBar_Tracking_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Tracking: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Tracking
  else
    TControlScrollBar(AObj).Tracking := Boolean(AArgs[0]);
end;

function TControlScrollBar_Visible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Visible: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TControlScrollBar(AObj).Visible
  else
    TControlScrollBar(AObj).Visible := Boolean(AArgs[0]);
end;

class function TControlScrollBar_sw.GetTypeName: WideString;
begin
  Result := 'TControlScrollBar';
end;

class function TControlScrollBar_sw.GetWrappedClass: TClass;
begin
  Result := TControlScrollBar;
end;

class procedure TControlScrollBar_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ChangeBiDiPosition', TControlScrollBar_ChangeBiDiPosition_si, 0, False);
  AData.AddProperty('Kind', TControlScrollBar_Kind_si, TScrollBarKind_sw, True, False, 0, False, False);
  AData.AddFunction('IsScrollBarVisible', TControlScrollBar_IsScrollBarVisible_si, Boolean_sw, 0, False);
  AData.AddProperty('ScrollPos', TControlScrollBar_ScrollPos_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ButtonSize', TControlScrollBar_ButtonSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Color', TControlScrollBar_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('Increment', TControlScrollBar_Increment_si, TScrollBarInc_sw, True, True, 0, False, False);
  AData.AddProperty('Margin', TControlScrollBar_Margin_si, Word_sw, True, True, 0, False, False);
  AData.AddProperty('ParentColor', TControlScrollBar_ParentColor_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TControlScrollBar_Position_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Range', TControlScrollBar_Range_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Smooth', TControlScrollBar_Smooth_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Size', TControlScrollBar_Size_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Style', TControlScrollBar_Style_si, TScrollBarStyle_sw, True, True, 0, False, False);
  AData.AddProperty('ThumbSize', TControlScrollBar_ThumbSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Tracking', TControlScrollBar_Tracking_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Visible', TControlScrollBar_Visible_si, Boolean_sw, True, True, 0, False, False);
end;

class function TControlScrollBar_sw.ToVar(
  const AValue: TControlScrollBar): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TControlScrollBar_sw.FromVar(
  const AValue: OleVariant): TControlScrollBar;
begin
  Result := TControlScrollBar(ConvFromVar(AValue, TControlScrollBar));
end;

class function TControlScrollBar_sw.ClassToVar(
  AClass: TControlScrollBar_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TControlScrollBar_sw.ClassFromVar(
  const AClass: OleVariant): TControlScrollBar_sc;
begin
  Result := TControlScrollBar_sc(ConvClsFromVar(AClass, TControlScrollBar));
end;

{ TScrollingWinControl_sw }

function TScrollingWinControl_AutoScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AutoScroll: Boolean read <getter> writ...

  if IsGet then
    Result := TScrollingWinControl_sacc(TScrollingWinControl(AObj)).AutoScroll
  else
    TScrollingWinControl_sacc(TScrollingWinControl(AObj)).AutoScroll := Boolean(
      AArgs[0]);
end;

function TScrollingWinControl_DisableAutoRange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableAutoRange;

  TScrollingWinControl(AObj).DisableAutoRange();
end;

function TScrollingWinControl_EnableAutoRange_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableAutoRange;

  TScrollingWinControl(AObj).EnableAutoRange();
end;

function TScrollingWinControl_ScrollInView_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ScrollInView(AControl: TControl);

  TScrollingWinControl(AObj).ScrollInView(TControl_sw.FromVar(AArgs[0]));
end;

function TScrollingWinControl_HorzScrollBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HorzScrollBar: TControlScrollBar read <getter> w...

  if IsGet then
    Result := TControlScrollBar_sw.ToVar(TScrollingWinControl(AObj).
      HorzScrollBar)
  else
    TScrollingWinControl(AObj).HorzScrollBar := TControlScrollBar_sw.FromVar(
      AArgs[0]);
end;

function TScrollingWinControl_VertScrollBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VertScrollBar: TControlScrollBar read <getter> w...

  if IsGet then
    Result := TControlScrollBar_sw.ToVar(TScrollingWinControl(AObj).
      VertScrollBar)
  else
    TScrollingWinControl(AObj).VertScrollBar := TControlScrollBar_sw.FromVar(
      AArgs[0]);
end;

class function TScrollingWinControl_sw.GetTypeName: WideString;
begin
  Result := 'TScrollingWinControl';
end;

class function TScrollingWinControl_sw.GetWrappedClass: TClass;
begin
  Result := TScrollingWinControl;
end;

class procedure TScrollingWinControl_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('AutoScroll', TScrollingWinControl_AutoScroll_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProcedure('DisableAutoRange', TScrollingWinControl_DisableAutoRange_si, 0, False);
  AData.AddProcedure('EnableAutoRange', TScrollingWinControl_EnableAutoRange_si, 0, False);
  AData.AddProcedure('ScrollInView', TScrollingWinControl_ScrollInView_si, 1, False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddProperty('HorzScrollBar', TScrollingWinControl_HorzScrollBar_si, TControlScrollBar_sw, True, True, 0, False, False);
  AData.AddProperty('VertScrollBar', TScrollingWinControl_VertScrollBar_si, TControlScrollBar_sw, True, True, 0, False, False);
end;

class function TScrollingWinControl_sw.ToVar(
  const AValue: TScrollingWinControl): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TScrollingWinControl_sw.FromVar(
  const AValue: OleVariant): TScrollingWinControl;
begin
  Result := TScrollingWinControl(ConvFromVar(AValue, TScrollingWinControl));
end;

class function TScrollingWinControl_sw.ClassToVar(
  AClass: TScrollingWinControl_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TScrollingWinControl_sw.ClassFromVar(
  const AClass: OleVariant): TScrollingWinControl_sc;
begin
  Result := TScrollingWinControl_sc(ConvClsFromVar(AClass, 
    TScrollingWinControl));
end;

{ TFormBorderStyle_sw }

class function TFormBorderStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFormBorderStyle';
end;

class procedure TFormBorderStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'bsNone'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsNone)),
    (Name: 'bsSingle'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsSingle)),
    (Name: 'bsSizeable'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsSizeable)),
    (Name: 'bsDialog'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsDialog)),
    (Name: 'bsToolWindow'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsToolWindow)),
    (Name: 'bsSizeToolWin'; Value: Integer({$IFDEF LMDSCT_12}TFormBorderStyle.{$ENDIF}bsSizeToolWin))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TFormBorderStyle_sw.ToVar(
  const AValue: TFormBorderStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFormBorderStyle_sw.FromVar(
  const AValue: OleVariant): TFormBorderStyle;
begin
  Result := TFormBorderStyle(Integer(AValue));
end;

{ TBorderStyle_sw }

class function TBorderStyle_sw.GetTypeName: WideString;
begin
  Result := 'TBorderStyle';
end;

class function TBorderStyle_sw.ToVar(const AValue: TBorderStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBorderStyle_sw.FromVar(const AValue: OleVariant): TBorderStyle;
begin
  Result := TBorderStyle(Integer(AValue));
end;

{ TScrollBox_sw }

function TScrollBox_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TBorderStyle read <getter> write <s...

  if IsGet then
    Result := TBorderStyle_sw.ToVar(TScrollBox(AObj).BorderStyle)
  else
    TScrollBox(AObj).BorderStyle := TBorderStyle_sw.FromVar(AArgs[0]);
end;

class function TScrollBox_sw.GetTypeName: WideString;
begin
  Result := 'TScrollBox';
end;

class function TScrollBox_sw.GetWrappedClass: TClass;
begin
  Result := TScrollBox;
end;

class procedure TScrollBox_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoScroll', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BevelEdges', False);
  AData.AddPropertyRedecl('BevelInner', False);
  AData.AddPropertyRedecl('BevelOuter', False);
  AData.AddPropertyRedecl('BevelKind', False);
  AData.AddPropertyRedecl('BevelWidth', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddProperty('BorderStyle', TScrollBox_BorderStyle_si, TBorderStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Padding', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TScrollBox_sw.ToVar(const AValue: TScrollBox): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TScrollBox_sw.FromVar(const AValue: OleVariant): TScrollBox;
begin
  Result := TScrollBox(ConvFromVar(AValue, TScrollBox));
end;

class function TScrollBox_sw.ClassToVar(AClass: TScrollBox_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TScrollBox_sw.ClassFromVar(
  const AClass: OleVariant): TScrollBox_sc;
begin
  Result := TScrollBox_sc(ConvClsFromVar(AClass, TScrollBox));
end;

{ TCustomFrame_sw }

class function TCustomFrame_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFrame';
end;

class function TCustomFrame_sw.GetWrappedClass: TClass;
begin
  Result := TCustomFrame;
end;

class procedure TCustomFrame_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TCustomFrame_sw.ToVar(const AValue: TCustomFrame): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFrame_sw.FromVar(const AValue: OleVariant): TCustomFrame;
begin
  Result := TCustomFrame(ConvFromVar(AValue, TCustomFrame));
end;

class function TCustomFrame_sw.ClassToVar(AClass: TCustomFrame_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomFrame_sw.ClassFromVar(
  const AClass: OleVariant): TCustomFrame_sc;
begin
  Result := TCustomFrame_sc(ConvClsFromVar(AClass, TCustomFrame));
end;

{ TCustomFrameClass_sw }

class function TCustomFrameClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFrameClass';
end;

class function TCustomFrameClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomFrame;
end;

class function TCustomFrameClass_sw.ToVar(
  const AValue: TCustomFrameClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFrameClass_sw.FromVar(
  const AValue: OleVariant): TCustomFrameClass;
begin
  Result := TCustomFrameClass(ConvFromVar(AValue, TCustomFrame));
end;

{ TFrame_sw }

class function TFrame_sw.GetTypeName: WideString;
begin
  Result := 'TFrame';
end;

class function TFrame_sw.GetWrappedClass: TClass;
begin
  Result := TFrame;
end;

class procedure TFrame_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoScroll', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragCursor', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Padding', False);
  AData.AddPropertyRedecl('ParentBackground', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('ParentColor', False);
  AData.AddPropertyRedecl('ParentCtl3D', False);
  AData.AddPropertyRedecl('ParentDoubleBuffered', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('ParentShowHint', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('TabOrder', False);
  AData.AddPropertyRedecl('TabStop', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnEndDrag', False);
  AData.AddPropertyRedecl('OnEnter', False);
  AData.AddPropertyRedecl('OnExit', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnStartDrag', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TFrame_sw.ToVar(const AValue: TFrame): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFrame_sw.FromVar(const AValue: OleVariant): TFrame;
begin
  Result := TFrame(ConvFromVar(AValue, TFrame));
end;

class function TFrame_sw.ClassToVar(AClass: TFrame_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFrame_sw.ClassFromVar(const AClass: OleVariant): TFrame_sc;
begin
  Result := TFrame_sc(ConvClsFromVar(AClass, TFrame));
end;

{ TPopupWnd_sw }

function TPopupWnd_ID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ID: Integer;

  if IsGet then
    Result := TPopupWnd_sw(AObj).FValue.ID
  else
    TPopupWnd_sw(AObj).FValue.ID := Integer(AArgs[0]);
end;

function TPopupWnd_ControlWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ControlWnd: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(TPopupWnd_sw(AObj).FValue.ControlWnd)
  else
    TPopupWnd_sw(AObj).FValue.ControlWnd := HWND_sw.FromVar(AArgs[0]);
end;

function TPopupWnd_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPopupWnd_sw.Create as IDispatch;
end;

function TPopupWnd_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPopupWnd;

  // Implicit record copy method.
  Result := TPopupWnd_sw.ToVar(TPopupWnd(AObj));
end;

class function TPopupWnd_sw.GetTypeName: WideString;
begin
  Result := 'TPopupWnd';
end;

function TPopupWnd_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPopupWnd_sw.Create;
  TPopupWnd_sw(Result).FValue := FValue;
end;

class procedure TPopupWnd_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ID', TPopupWnd_ID_si, Integer_sw);
  AData.AddField('ControlWnd', TPopupWnd_ControlWnd_si, HWND_sw);
  AData.AddFunction('Copy', TPopupWnd_Copy_si, TPopupWnd_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPopupWnd_Create_si, 0, False);
end;

class function TPopupWnd_sw.ToVar(const AValue: TPopupWnd): OleVariant;
var
  wrpr: TPopupWnd_sw;
begin
  wrpr        := TPopupWnd_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPopupWnd_sw.FromVar(const AValue: OleVariant): TPopupWnd;
begin
  Result := TPopupWnd_sw(ConvFromVar(AValue)).FValue;
end;

{ TFormStyle_sw }

class function TFormStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFormStyle';
end;

class procedure TFormStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'fsNormal'; Value: Integer({$IFDEF LMDSCT_12}TFormStyle.{$ENDIF}fsNormal)),
    (Name: 'fsMDIChild'; Value: Integer({$IFDEF LMDSCT_12}TFormStyle.{$ENDIF}fsMDIChild)),
    (Name: 'fsMDIForm'; Value: Integer({$IFDEF LMDSCT_12}TFormStyle.{$ENDIF}fsMDIForm)),
    (Name: 'fsStayOnTop'; Value: Integer({$IFDEF LMDSCT_12}TFormStyle.{$ENDIF}fsStayOnTop))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TFormStyle_sw.ToVar(const AValue: TFormStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFormStyle_sw.FromVar(const AValue: OleVariant): TFormStyle;
begin
  Result := TFormStyle(Integer(AValue));
end;

{ TPosition_sw }

class function TPosition_sw.GetTypeName: WideString;
begin
  Result := 'TPosition';
end;

class procedure TPosition_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'poDesigned'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poDesigned)),
    (Name: 'poDefault'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poDefault)),
    (Name: 'poDefaultPosOnly'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poDefaultPosOnly)),
    (Name: 'poDefaultSizeOnly'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poDefaultSizeOnly)),
    (Name: 'poScreenCenter'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poScreenCenter)),
    (Name: 'poDesktopCenter'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poDesktopCenter)),
    (Name: 'poMainFormCenter'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poMainFormCenter)),
    (Name: 'poOwnerFormCenter'; Value: Integer({$IFDEF LMDSCT_12}TPosition.{$ENDIF}poOwnerFormCenter))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TPosition_sw.ToVar(const AValue: TPosition): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPosition_sw.FromVar(const AValue: OleVariant): TPosition;
begin
  Result := TPosition(Integer(AValue));
end;

{ TDefaultMonitor_sw }

class function TDefaultMonitor_sw.GetTypeName: WideString;
begin
  Result := 'TDefaultMonitor';
end;

class procedure TDefaultMonitor_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'dmDesktop'; Value: Integer({$IFDEF LMDSCT_12}TDefaultMonitor.{$ENDIF}dmDesktop)),
    (Name: 'dmPrimary'; Value: Integer({$IFDEF LMDSCT_12}TDefaultMonitor.{$ENDIF}dmPrimary)),
    (Name: 'dmMainForm'; Value: Integer({$IFDEF LMDSCT_12}TDefaultMonitor.{$ENDIF}dmMainForm)),
    (Name: 'dmActiveForm'; Value: Integer({$IFDEF LMDSCT_12}TDefaultMonitor.{$ENDIF}dmActiveForm))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TDefaultMonitor_sw.ToVar(
  const AValue: TDefaultMonitor): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TDefaultMonitor_sw.FromVar(
  const AValue: OleVariant): TDefaultMonitor;
begin
  Result := TDefaultMonitor(Integer(AValue));
end;

{ TPrintScale_sw }

class function TPrintScale_sw.GetTypeName: WideString;
begin
  Result := 'TPrintScale';
end;

class procedure TPrintScale_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'poNone'; Value: Integer({$IFDEF LMDSCT_12}TPrintScale.{$ENDIF}poNone)),
    (Name: 'poProportional'; Value: Integer({$IFDEF LMDSCT_12}TPrintScale.{$ENDIF}poProportional)),
    (Name: 'poPrintToFit'; Value: Integer({$IFDEF LMDSCT_12}TPrintScale.{$ENDIF}poPrintToFit))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrintScale_sw.ToVar(const AValue: TPrintScale): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrintScale_sw.FromVar(const AValue: OleVariant): TPrintScale;
begin
  Result := TPrintScale(Integer(AValue));
end;

{ TShowAction_sw }

class function TShowAction_sw.GetTypeName: WideString;
begin
  Result := 'TShowAction';
end;

class procedure TShowAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'saIgnore'; Value: Integer({$IFDEF LMDSCT_12}TShowAction.{$ENDIF}saIgnore)),
    (Name: 'saRestore'; Value: Integer({$IFDEF LMDSCT_12}TShowAction.{$ENDIF}saRestore)),
    (Name: 'saMinimize'; Value: Integer({$IFDEF LMDSCT_12}TShowAction.{$ENDIF}saMinimize)),
    (Name: 'saMaximize'; Value: Integer({$IFDEF LMDSCT_12}TShowAction.{$ENDIF}saMaximize))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TShowAction_sw.ToVar(const AValue: TShowAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TShowAction_sw.FromVar(const AValue: OleVariant): TShowAction;
begin
  Result := TShowAction(Integer(AValue));
end;

{ TTileMode_sw }

class function TTileMode_sw.GetTypeName: WideString;
begin
  Result := 'TTileMode';
end;

class procedure TTileMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tbHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TTileMode.{$ENDIF}tbHorizontal)),
    (Name: 'tbVertical'; Value: Integer({$IFDEF LMDSCT_12}TTileMode.{$ENDIF}tbVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTileMode_sw.ToVar(const AValue: TTileMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTileMode_sw.FromVar(const AValue: OleVariant): TTileMode;
begin
  Result := TTileMode(Integer(AValue));
end;

{ TCloseEvent_sh }

function TCloseEvent_sh.GetHandler: TMethod;
var
  hdr: TCloseEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCloseEvent_sh.Handler(Sender: TObject; var Action: TCloseAction);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Action: TCloseAction) of ...

  v_1 := TCloseAction_sw.ToVar(Action);
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Action := TCloseAction_sw.FromVar(v_1);
end;

{ TCloseEvent_sw }

class function TCloseEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCloseEvent';
end;

class function TCloseEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCloseEvent_sh;
end;

class function TCloseEvent_sw.ToVar(const AValue: TCloseEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCloseEvent_sw.FromVar(const AValue: OleVariant): TCloseEvent;
begin
  Result := TCloseEvent(ConvFromVar(AValue));
end;

class function TCloseEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TCloseEvent;
var
  hdlr: TCloseEvent_sh;
begin
  hdlr   := TCloseEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TCloseEvent_sw));
  Result := hdlr.Handler;
end;

{ TCloseQueryEvent_sh }

function TCloseQueryEvent_sh.GetHandler: TMethod;
var
  hdr: TCloseQueryEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TCloseQueryEvent_sh.Handler(Sender: TObject; var CanClose: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var CanClose: Boolean) of object

  v_1 := CanClose;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  CanClose := Boolean(v_1);
end;

{ TCloseQueryEvent_sw }

class function TCloseQueryEvent_sw.GetTypeName: WideString;
begin
  Result := 'TCloseQueryEvent';
end;

class function TCloseQueryEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TCloseQueryEvent_sh;
end;

class function TCloseQueryEvent_sw.ToVar(
  const AValue: TCloseQueryEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TCloseQueryEvent_sw.FromVar(
  const AValue: OleVariant): TCloseQueryEvent;
begin
  Result := TCloseQueryEvent(ConvFromVar(AValue));
end;

class function TCloseQueryEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TCloseQueryEvent;
var
  hdlr: TCloseQueryEvent_sh;
begin
  hdlr   := TCloseQueryEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TCloseQueryEvent_sw));
  Result := hdlr.Handler;
end;

{ TShortCutEvent_sh }

function TShortCutEvent_sh.GetHandler: TMethod;
var
  hdr: TShortCutEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TShortCutEvent_sh.Handler(var Msg: TWMKey; var Handled: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (var Msg: TWMKey; var Handled: Boolean) of object

  v_1 := TWMKey_sw.ToVar(Msg);
  v_2 := Handled;
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  Msg := TWMKey_sw.FromVar(v_1);
  Handled := Boolean(v_2);
end;

{ TShortCutEvent_sw }

class function TShortCutEvent_sw.GetTypeName: WideString;
begin
  Result := 'TShortCutEvent';
end;

class function TShortCutEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TShortCutEvent_sh;
end;

class function TShortCutEvent_sw.ToVar(
  const AValue: TShortCutEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TShortCutEvent_sw.FromVar(
  const AValue: OleVariant): TShortCutEvent;
begin
  Result := TShortCutEvent(ConvFromVar(AValue));
end;

class function TShortCutEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TShortCutEvent;
var
  hdlr: TShortCutEvent_sh;
begin
  hdlr   := TShortCutEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TShortCutEvent_sw));
  Result := hdlr.Handler;
end;

{ THelpEvent_sh }

function THelpEvent_sh.GetHandler: TMethod;
var
  hdr: THelpEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function THelpEvent_sh.Handler(Command: Word; Data: THelpEventData;
  var CallHelp: Boolean): Boolean;
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
begin
  // function (Command: Word; Data: THelpEventData; var CallHe...

  v_1 := CallHelp;
  args[0] := Command;
  args[1] := THelpEventData_sw.ToVar(Data);
  args[2] := MakeVarRef(v_1);
  Result := Boolean(Self.Owner.RunProc(Self.ProcName, args));
  CallHelp := Boolean(v_1);
end;

{ THelpEvent_sw }

class function THelpEvent_sw.GetTypeName: WideString;
begin
  Result := 'THelpEvent';
end;

class function THelpEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := THelpEvent_sh;
end;

class function THelpEvent_sw.ToVar(const AValue: THelpEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function THelpEvent_sw.FromVar(const AValue: OleVariant): THelpEvent;
begin
  Result := THelpEvent(ConvFromVar(AValue));
end;

class function THelpEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): THelpEvent;
var
  hdlr: THelpEvent_sh;
begin
  hdlr   := THelpEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    THelpEvent_sw));
  Result := hdlr.Handler;
end;

{ TMonitorDpiChangedEvent_sh }

function TMonitorDpiChangedEvent_sh.GetHandler: TMethod;
var
  hdr: TMonitorDpiChangedEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMonitorDpiChangedEvent_sh.Handler(Sender: TObject; OldDPI: Integer;
  NewDPI: Integer);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; OldDPI: Integer; NewDPI: Inte...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := OldDPI;
  args[2] := NewDPI;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TMonitorDpiChangedEvent_sw }

class function TMonitorDpiChangedEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMonitorDpiChangedEvent';
end;

class function TMonitorDpiChangedEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMonitorDpiChangedEvent_sh;
end;

class function TMonitorDpiChangedEvent_sw.ToVar(
  const AValue: TMonitorDpiChangedEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMonitorDpiChangedEvent_sw.FromVar(
  const AValue: OleVariant): TMonitorDpiChangedEvent;
begin
  Result := TMonitorDpiChangedEvent(ConvFromVar(AValue));
end;

class function TMonitorDpiChangedEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TMonitorDpiChangedEvent;
var
  hdlr: TMonitorDpiChangedEvent_sh;
begin
  hdlr   := TMonitorDpiChangedEvent_sh(AScriptControl.GetEventHandler(AProcName,
    TMonitorDpiChangedEvent_sw));
  Result := hdlr.Handler;
end;

{ TPopupMode_sw }

class function TPopupMode_sw.GetTypeName: WideString;
begin
  Result := 'TPopupMode';
end;

class procedure TPopupMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pmNone'; Value: Integer({$IFDEF LMDSCT_12}TPopupMode.{$ENDIF}pmNone)),
    (Name: 'pmAuto'; Value: Integer({$IFDEF LMDSCT_12}TPopupMode.{$ENDIF}pmAuto)),
    (Name: 'pmExplicit'; Value: Integer({$IFDEF LMDSCT_12}TPopupMode.{$ENDIF}pmExplicit))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPopupMode_sw.ToVar(const AValue: TPopupMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPopupMode_sw.FromVar(const AValue: OleVariant): TPopupMode;
begin
  Result := TPopupMode(Integer(AValue));
end;

{ TGlassFrame_sw }

function TGlassFrame_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create(Client: TCustomForm);

  Result := TGlassFrame_sw.ToVar(TGlassFrame_sc(AObj).Create(TCustomForm_sw.
    FromVar(AArgs[0])));
end;

function TGlassFrame_FrameExtended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function FrameExtended: Boolean;

  Result := TGlassFrame(AObj).FrameExtended();
end;

function TGlassFrame_IntersectsControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IntersectsControl(Control: TControl): Boolean;

  Result := TGlassFrame(AObj).IntersectsControl(TControl_sw.FromVar(AArgs[0]));
end;

function TGlassFrame_OnChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnChange: TNotifyEvent read <getter> write <sett...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TGlassFrame(AObj).OnChange)
  else
    TGlassFrame(AObj).OnChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TGlassFrame_Enabled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Enabled: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).Enabled
  else
    TGlassFrame(AObj).Enabled := Boolean(AArgs[0]);
end;

function TGlassFrame_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).Left
  else
    TGlassFrame(AObj).Left := Integer(AArgs[0]);
end;

function TGlassFrame_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).Top
  else
    TGlassFrame(AObj).Top := Integer(AArgs[0]);
end;

function TGlassFrame_Right_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Right: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).Right
  else
    TGlassFrame(AObj).Right := Integer(AArgs[0]);
end;

function TGlassFrame_Bottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Bottom: Integer read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).Bottom
  else
    TGlassFrame(AObj).Bottom := Integer(AArgs[0]);
end;

function TGlassFrame_SheetOfGlass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SheetOfGlass: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TGlassFrame(AObj).SheetOfGlass
  else
    TGlassFrame(AObj).SheetOfGlass := Boolean(AArgs[0]);
end;

class function TGlassFrame_sw.GetTypeName: WideString;
begin
  Result := 'TGlassFrame';
end;

class function TGlassFrame_sw.GetWrappedClass: TClass;
begin
  Result := TGlassFrame;
end;

class procedure TGlassFrame_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('FrameExtended', TGlassFrame_FrameExtended_si, Boolean_sw, 0, False);
  AData.AddFunction('IntersectsControl', TGlassFrame_IntersectsControl_si, Boolean_sw, 1, False);
  AData.AddProperty('OnChange', TGlassFrame_OnChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('Enabled', TGlassFrame_Enabled_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Left', TGlassFrame_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TGlassFrame_Top_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Right', TGlassFrame_Right_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Bottom', TGlassFrame_Bottom_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('SheetOfGlass', TGlassFrame_SheetOfGlass_si, Boolean_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('Create', TGlassFrame_Create_si, 1, False);
end;

class function TGlassFrame_sw.ToVar(const AValue: TGlassFrame): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TGlassFrame_sw.FromVar(const AValue: OleVariant): TGlassFrame;
begin
  Result := TGlassFrame(ConvFromVar(AValue, TGlassFrame));
end;

class function TGlassFrame_sw.ClassToVar(AClass: TGlassFrame_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TGlassFrame_sw.ClassFromVar(
  const AClass: OleVariant): TGlassFrame_sc;
begin
  Result := TGlassFrame_sc(ConvClsFromVar(AClass, TGlassFrame));
end;

{ TCustomForm_sw }

function TCustomForm_ActiveMDIChild_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ActiveMDIChild: TForm read <getter>;

  Result := TForm_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).ActiveMDIChild);
end;

function TCustomForm_AlphaBlend_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AlphaBlend: Boolean read <getter> writ...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).AlphaBlend
  else
    TCustomForm_sacc(TCustomForm(AObj)).AlphaBlend := Boolean(AArgs[0]);
end;

function TCustomForm_AlphaBlendValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property AlphaBlendValue: Byte read <getter> wr...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).AlphaBlendValue
  else
    TCustomForm_sacc(TCustomForm(AObj)).AlphaBlendValue := Byte(AArgs[0]);
end;

function TCustomForm_BorderIcons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property BorderIcons: TBorderIcons read <getter...

  if IsGet then
    Result := TBorderIcons_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      BorderIcons)
  else
    TCustomForm_sacc(TCustomForm(AObj)).BorderIcons := TBorderIcons_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_TransparentColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TransparentColor: Boolean read <getter...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).TransparentColor
  else
    TCustomForm_sacc(TCustomForm(AObj)).TransparentColor := Boolean(AArgs[0]);
end;

function TCustomForm_TransparentColorValue_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TransparentColorValue: TColor read <ge...

  if IsGet then
    Result := TColor_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      TransparentColorValue)
  else
    TCustomForm_sacc(TCustomForm(AObj)).TransparentColorValue := TColor_sw.
      FromVar(AArgs[0]);
end;

function TCustomForm_DefaultMonitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property DefaultMonitor: TDefaultMonitor read <...

  if IsGet then
    Result := TDefaultMonitor_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      DefaultMonitor)
  else
    TCustomForm_sacc(TCustomForm(AObj)).DefaultMonitor := TDefaultMonitor_sw.
      FromVar(AArgs[0]);
end;

function TCustomForm_Icon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Icon: TIcon read <getter> write <setter>;

  if IsGet then
    Result := TIcon_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).Icon)
  else
    TCustomForm_sacc(TCustomForm(AObj)).Icon := TIcon_sw.FromVar(AArgs[0]);
end;

function TCustomForm_MDIChildCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MDIChildCount: Integer read <getter>;

  Result := TCustomForm_sacc(TCustomForm(AObj)).MDIChildCount;
end;

function TCustomForm_MDIChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MDIChildren[I: Integer]: TForm read <g...

  Result := TForm_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
    MDIChildren[Integer(AArgs[0])]);
end;

function TCustomForm_ObjectMenuItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ObjectMenuItem: TMenuItem read <getter...

  if IsGet then
    Result := TMenuItem_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      ObjectMenuItem)
  else
    TCustomForm_sacc(TCustomForm(AObj)).ObjectMenuItem := TMenuItem_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_PixelsPerInch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PixelsPerInch: Integer read <getter> w...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).PixelsPerInch
  else
    TCustomForm_sacc(TCustomForm(AObj)).PixelsPerInch := Integer(AArgs[0]);
end;

function TCustomForm_PopupChildren_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PopupChildren: TList read <getter>;

  Result := TList_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).PopupChildren);
end;

function TCustomForm_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Position: TPosition read <getter> writ...

  if IsGet then
    Result := TPosition_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).Position)
  else
    TCustomForm_sacc(TCustomForm(AObj)).Position := TPosition_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_PrintScale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property PrintScale: TPrintScale read <getter> ...

  if IsGet then
    Result := TPrintScale_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      PrintScale)
  else
    TCustomForm_sacc(TCustomForm(AObj)).PrintScale := TPrintScale_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_Scaled_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property Scaled: Boolean read <getter> write <s...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).Scaled
  else
    TCustomForm_sacc(TCustomForm(AObj)).Scaled := Boolean(AArgs[0]);
end;

function TCustomForm_TileMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property TileMode: TTileMode read <getter> writ...

  if IsGet then
    Result := TTileMode_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).TileMode)
  else
    TCustomForm_sacc(TCustomForm(AObj)).TileMode := TTileMode_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_WindowMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property WindowMenu: TMenuItem read <getter> wr...

  if IsGet then
    Result := TMenuItem_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).WindowMenu)
  else
    TCustomForm_sacc(TCustomForm(AObj)).WindowMenu := TMenuItem_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_ClientHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property ClientHandle: HWND read <getter>;

  Result := HWND_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).ClientHandle);
end;

function TCustomForm_FormStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property FormStyle: TFormStyle read <getter> wr...

  if IsGet then
    Result := TFormStyle_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).FormStyle)
  else
    TCustomForm_sacc(TCustomForm(AObj)).FormStyle := TFormStyle_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OldCreateOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OldCreateOrder: Boolean read <getter> ...

  if IsGet then
    Result := TCustomForm_sacc(TCustomForm(AObj)).OldCreateOrder
  else
    TCustomForm_sacc(TCustomForm(AObj)).OldCreateOrder := Boolean(AArgs[0]);
end;

function TCustomForm_OnActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnActivate: TNotifyEvent read <getter>...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnActivate)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnActivate := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnAfterMonitorDpiChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnAfterMonitorDpiChanged: TMonitorDpiC...

  if IsGet then
    Result := TMonitorDpiChangedEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(
      AObj)).OnAfterMonitorDpiChanged)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnAfterMonitorDpiChanged := 
      TMonitorDpiChangedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomForm_OnBeforeMonitorDpiChanged_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnBeforeMonitorDpiChanged: TMonitorDpi...

  if IsGet then
    Result := TMonitorDpiChangedEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(
      AObj)).OnBeforeMonitorDpiChanged)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnBeforeMonitorDpiChanged := 
      TMonitorDpiChangedEvent_sw.FromVar(AArgs[0]);
end;

function TCustomForm_OnClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnClose: TCloseEvent read <getter> wri...

  if IsGet then
    Result := TCloseEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).OnClose)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnClose := TCloseEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnCloseQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCloseQuery: TCloseQueryEvent read <g...

  if IsGet then
    Result := TCloseQueryEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnCloseQuery)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnCloseQuery := TCloseQueryEvent_sw.
      FromVar(AArgs[0]);
end;

function TCustomForm_OnCreate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnCreate: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnCreate)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnCreate := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnDestroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDestroy: TNotifyEvent read <getter> ...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnDestroy)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnDestroy := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnDeactivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnDeactivate: TNotifyEvent read <gette...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnDeactivate)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnDeactivate := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnHelp: THelpEvent read <getter> write...

  if IsGet then
    Result := THelpEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).OnHelp)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnHelp := THelpEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnHide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnHide: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).OnHide)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnHide := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnPaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnPaint: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).OnPaint)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnPaint := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnShortCut: TShortCutEvent read <gette...

  if IsGet then
    Result := TShortCutEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).
      OnShortCut)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnShortCut := TShortCutEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_OnShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property OnShow: TNotifyEvent read <getter> wri...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCustomForm_sacc(TCustomForm(AObj)).OnShow)
  else
    TCustomForm_sacc(TCustomForm(AObj)).OnShow := TNotifyEvent_sw.FromVar(
      AArgs[0]);
end;

function TCustomForm_CreateNew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateNew(AOwner: TComponent; Dummy: Integer);

  case AArgsSize of
    1:
    begin
      Result := TCustomForm_sw.ToVar(TCustomForm_sc(AObj).CreateNew(
        TComponent_sw.FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TCustomForm_sw.ToVar(TCustomForm_sc(AObj).CreateNew(
        TComponent_sw.FromVar(AArgs[0]), Integer(AArgs[1])));
    end;
  else
    WrongArgCountError('CreateNew');
  end;
end;

function TCustomForm_Close_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Close;

  TCustomForm(AObj).Close();
end;

function TCustomForm_CloseQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CloseQuery: Boolean;

  Result := TCustomForm(AObj).CloseQuery();
end;

function TCustomForm_DefocusControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DefocusControl(Control: TWinControl; Removing: ...

  TCustomForm(AObj).DefocusControl(TWinControl_sw.FromVar(AArgs[0]), Boolean(
    AArgs[1]));
end;

function TCustomForm_FocusControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure FocusControl(Control: TWinControl);

  TCustomForm(AObj).FocusControl(TWinControl_sw.FromVar(AArgs[0]));
end;

function TCustomForm_GetFormImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetFormImage: TBitmap;

  Result := TBitmap_sw.ToVar(TCustomForm(AObj).GetFormImage());
end;

function TCustomForm_Hide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Hide;

  TCustomForm(AObj).Hide();
end;

function TCustomForm_IsShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TWMKey;
begin
  // function IsShortCut(var Message: TWMKey): Boolean;

  v_1 := TWMKey_sw.FromVar(AArgs[0]);
  Result := TCustomForm(AObj).IsShortCut(v_1);
  AssignRefParam(AArgs[0], TWMKey_sw.ToVar(v_1));
end;

function TCustomForm_MakeFullyVisible_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure MakeFullyVisible(AMonitor: TMonitor);

  case AArgsSize of
    0:
    begin
      TCustomForm(AObj).MakeFullyVisible();
    end;
    1:
    begin
      TCustomForm(AObj).MakeFullyVisible(TMonitor_sw.FromVar(AArgs[0]));
    end;
  else
    WrongArgCountError('MakeFullyVisible');
  end;
end;

function TCustomForm_Print_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Print;

  TCustomForm(AObj).Print();
end;

function TCustomForm_RecreateAsPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RecreateAsPopup(AWindowHandle: HWND);

  TCustomForm(AObj).RecreateAsPopup(HWND_sw.FromVar(AArgs[0]));
end;

function TCustomForm_Release_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Release;

  TCustomForm(AObj).Release();
end;

function TCustomForm_SendCancelMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SendCancelMode(Sender: TControl);

  TCustomForm(AObj).SendCancelMode(TControl_sw.FromVar(AArgs[0]));
end;

function TCustomForm_SetFocusedControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetFocusedControl(Control: TWinControl): Boolean;

  Result := TCustomForm(AObj).SetFocusedControl(TWinControl_sw.FromVar(
    AArgs[0]));
end;

function TCustomForm_Show_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Show;

  TCustomForm(AObj).Show();
end;

function TCustomForm_ShowModal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ShowModal: Integer;

  Result := TCustomForm(AObj).ShowModal();
end;

function TCustomForm_WantChildKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMessage;
begin
  // function WantChildKey(Child: TControl; var Message: TMess...

  v_1 := TMessage_sw.FromVar(AArgs[1]);
  Result := TCustomForm(AObj).WantChildKey(TControl_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TMessage_sw.ToVar(v_1));
end;

function TCustomForm_set_PopupParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure set_PopupParent(Value: TCustomForm);

  TCustomForm(AObj).set_PopupParent(TCustomForm_sw.FromVar(AArgs[0]));
end;

function TCustomForm_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter>;

  Result := TCustomForm(AObj).Active;
end;

function TCustomForm_ActiveControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveControl: TWinControl read <getter> write <...

  if IsGet then
    Result := TWinControl_sw.ToVar(TCustomForm(AObj).ActiveControl)
  else
    TCustomForm(AObj).ActiveControl := TWinControl_sw.FromVar(AArgs[0]);
end;

function TCustomForm_ActiveOleControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveOleControl: TWinControl read <getter> writ...

  if IsGet then
    Result := TWinControl_sw.ToVar(TCustomForm(AObj).ActiveOleControl)
  else
    TCustomForm(AObj).ActiveOleControl := TWinControl_sw.FromVar(AArgs[0]);
end;

function TCustomForm_BorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BorderStyle: TFormBorderStyle read <getter> writ...

  if IsGet then
    Result := TFormBorderStyle_sw.ToVar(TCustomForm(AObj).BorderStyle)
  else
    TCustomForm(AObj).BorderStyle := TFormBorderStyle_sw.FromVar(AArgs[0]);
end;

function TCustomForm_Canvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Canvas: TCanvas read <getter>;

  Result := TCanvas_sw.ToVar(TCustomForm(AObj).Canvas);
end;

function TCustomForm_DropTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DropTarget: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).DropTarget
  else
    TCustomForm(AObj).DropTarget := Boolean(AArgs[0]);
end;

function TCustomForm_GlassFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GlassFrame: TGlassFrame read <getter> write <set...

  if IsGet then
    Result := TGlassFrame_sw.ToVar(TCustomForm(AObj).GlassFrame)
  else
    TCustomForm(AObj).GlassFrame := TGlassFrame_sw.FromVar(AArgs[0]);
end;

function TCustomForm_HelpFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpFile: string read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).HelpFile
  else
    TCustomForm(AObj).HelpFile := string(AArgs[0]);
end;

function TCustomForm_KeyPreview_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property KeyPreview: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).KeyPreview
  else
    TCustomForm(AObj).KeyPreview := Boolean(AArgs[0]);
end;

function TCustomForm_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Menu: TMainMenu read <getter> write <setter>;

  if IsGet then
    Result := TMainMenu_sw.ToVar(TCustomForm(AObj).Menu)
  else
    TCustomForm(AObj).Menu := TMainMenu_sw.FromVar(AArgs[0]);
end;

function TCustomForm_ModalResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalResult: TModalResult read <getter> write <s...

  if IsGet then
    Result := TModalResult_sw.ToVar(TCustomForm(AObj).ModalResult)
  else
    TCustomForm(AObj).ModalResult := TModalResult_sw.FromVar(AArgs[0]);
end;

function TCustomForm_Monitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Monitor: TMonitor read <getter>;

  Result := TMonitor_sw.ToVar(TCustomForm(AObj).Monitor);
end;

function TCustomForm_PopupMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupMode: TPopupMode read <getter> write <setter>;

  if IsGet then
    Result := TPopupMode_sw.ToVar(TCustomForm(AObj).PopupMode)
  else
    TCustomForm(AObj).PopupMode := TPopupMode_sw.FromVar(AArgs[0]);
end;

function TCustomForm_ScreenSnap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ScreenSnap: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).ScreenSnap
  else
    TCustomForm(AObj).ScreenSnap := Boolean(AArgs[0]);
end;

function TCustomForm_SnapBuffer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SnapBuffer: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).SnapBuffer
  else
    TCustomForm(AObj).SnapBuffer := Integer(AArgs[0]);
end;

function TCustomForm_WindowState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WindowState: TWindowState read <getter> write <s...

  if IsGet then
    Result := TWindowState_sw.ToVar(TCustomForm(AObj).WindowState)
  else
    TCustomForm(AObj).WindowState := TWindowState_sw.FromVar(AArgs[0]);
end;

function TCustomForm_PopupParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupParent: TCustomForm read <getter> write <se...

  if IsGet then
    Result := TCustomForm_sw.ToVar(TCustomForm(AObj).PopupParent)
  else
    TCustomForm(AObj).PopupParent := TCustomForm_sw.FromVar(AArgs[0]);
end;

function TCustomForm_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).Left
  else
    TCustomForm(AObj).Left := Integer(AArgs[0]);
end;

function TCustomForm_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TCustomForm(AObj).Top
  else
    TCustomForm(AObj).Top := Integer(AArgs[0]);
end;

class function TCustomForm_sw.GetTypeName: WideString;
begin
  Result := 'TCustomForm';
end;

class function TCustomForm_sw.GetWrappedClass: TClass;
begin
  Result := TCustomForm;
end;

class procedure TCustomForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('ActiveMDIChild', TCustomForm_ActiveMDIChild_si, TForm_sw, True, False, 0, True, False);
  AData.AddProperty('AlphaBlend', TCustomForm_AlphaBlend_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('AlphaBlendValue', TCustomForm_AlphaBlendValue_si, Byte_sw, True, True, 0, True, False);
  AData.AddProperty('BorderIcons', TCustomForm_BorderIcons_si, TBorderIcons_sw, True, True, 0, True, False);
  AData.AddProperty('TransparentColor', TCustomForm_TransparentColor_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('TransparentColorValue', TCustomForm_TransparentColorValue_si, TColor_sw, True, True, 0, True, False);
  AData.AddProperty('DefaultMonitor', TCustomForm_DefaultMonitor_si, TDefaultMonitor_sw, True, True, 0, True, False);
  AData.AddProperty('Icon', TCustomForm_Icon_si, TIcon_sw, True, True, 0, True, False);
  AData.AddProperty('MDIChildCount', TCustomForm_MDIChildCount_si, Integer_sw, True, False, 0, True, False);
  AData.AddProperty('MDIChildren', TCustomForm_MDIChildren_si, TForm_sw, True, False, 1, True, False);
  AData.AddProperty('ObjectMenuItem', TCustomForm_ObjectMenuItem_si, TMenuItem_sw, True, True, 0, True, False);
  AData.AddProperty('PixelsPerInch', TCustomForm_PixelsPerInch_si, Integer_sw, True, True, 0, True, False);
  AData.AddProperty('PopupChildren', TCustomForm_PopupChildren_si, TList_sw, True, False, 0, True, False);
  AData.AddProperty('Position', TCustomForm_Position_si, TPosition_sw, True, True, 0, True, False);
  AData.AddProperty('PrintScale', TCustomForm_PrintScale_si, TPrintScale_sw, True, True, 0, True, False);
  AData.AddProperty('Scaled', TCustomForm_Scaled_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('TileMode', TCustomForm_TileMode_si, TTileMode_sw, True, True, 0, True, False);
  AData.AddProperty('WindowMenu', TCustomForm_WindowMenu_si, TMenuItem_sw, True, True, 0, True, False);
  AData.AddProperty('ClientHandle', TCustomForm_ClientHandle_si, HWND_sw, True, False, 0, True, False);
  AData.AddProperty('FormStyle', TCustomForm_FormStyle_si, TFormStyle_sw, True, True, 0, True, False);
  AData.AddProperty('OldCreateOrder', TCustomForm_OldCreateOrder_si, Boolean_sw, True, True, 0, True, False);
  AData.AddProperty('OnActivate', TCustomForm_OnActivate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnAfterMonitorDpiChanged', TCustomForm_OnAfterMonitorDpiChanged_si, TMonitorDpiChangedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnBeforeMonitorDpiChanged', TCustomForm_OnBeforeMonitorDpiChanged_si, TMonitorDpiChangedEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnClose', TCustomForm_OnClose_si, TCloseEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCloseQuery', TCustomForm_OnCloseQuery_si, TCloseQueryEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnCreate', TCustomForm_OnCreate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDestroy', TCustomForm_OnDestroy_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnDeactivate', TCustomForm_OnDeactivate_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnHelp', TCustomForm_OnHelp_si, THelpEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnHide', TCustomForm_OnHide_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnPaint', TCustomForm_OnPaint_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnShortCut', TCustomForm_OnShortCut_si, TShortCutEvent_sw, True, True, 0, True, False);
  AData.AddProperty('OnShow', TCustomForm_OnShow_si, TNotifyEvent_sw, True, True, 0, True, False);
  AData.AddProcedure('Close', TCustomForm_Close_si, 0, False);
  AData.AddFunction('CloseQuery', TCustomForm_CloseQuery_si, Boolean_sw, 0, False);
  AData.AddProcedure('DefocusControl', TCustomForm_DefocusControl_si, 2, False);
  AData.AddProcedure('FocusControl', TCustomForm_FocusControl_si, 1, False);
  AData.AddFunction('GetFormImage', TCustomForm_GetFormImage_si, TBitmap_sw, 0, False);
  AData.AddProcedure('Hide', TCustomForm_Hide_si, 0, False);
  AData.AddFunction('IsShortCut', TCustomForm_IsShortCut_si, Boolean_sw, 1, False);
  AData.AddProcedure('MakeFullyVisible', TCustomForm_MakeFullyVisible_si, 0, True);
  AData.AddProcedure('Print', TCustomForm_Print_si, 0, False);
  AData.AddProcedure('RecreateAsPopup', TCustomForm_RecreateAsPopup_si, 1, False);
  AData.AddProcedure('Release', TCustomForm_Release_si, 0, False);
  AData.AddProcedure('SendCancelMode', TCustomForm_SendCancelMode_si, 1, False);
  AData.AddFunction('SetFocusedControl', TCustomForm_SetFocusedControl_si, Boolean_sw, 1, False);
  AData.AddProcedure('Show', TCustomForm_Show_si, 0, False);
  AData.AddFunction('ShowModal', TCustomForm_ShowModal_si, Integer_sw, 0, False);
  AData.AddFunction('WantChildKey', TCustomForm_WantChildKey_si, Boolean_sw, 2, False);
  AData.AddProcedure('set_PopupParent', TCustomForm_set_PopupParent_si, 1, False);
  AData.AddProperty('Active', TCustomForm_Active_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ActiveControl', TCustomForm_ActiveControl_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Action', False);
  AData.AddProperty('ActiveOleControl', TCustomForm_ActiveOleControl_si, TWinControl_sw, True, True, 0, False, False);
  AData.AddProperty('BorderStyle', TCustomForm_BorderStyle_si, TFormBorderStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Canvas', TCustomForm_Canvas_si, TCanvas_sw, True, False, 0, False, False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddProperty('DropTarget', TCustomForm_DropTarget_si, Boolean_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddProperty('GlassFrame', TCustomForm_GlassFrame_si, TGlassFrame_sw, True, True, 0, False, False);
  AData.AddProperty('HelpFile', TCustomForm_HelpFile_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('KeyPreview', TCustomForm_KeyPreview_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Menu', TCustomForm_Menu_si, TMainMenu_sw, True, True, 0, False, False);
  AData.AddProperty('ModalResult', TCustomForm_ModalResult_si, TModalResult_sw, True, True, 0, False, False);
  AData.AddProperty('Monitor', TCustomForm_Monitor_si, TMonitor_sw, True, False, 0, False, False);
  AData.AddProperty('PopupMode', TCustomForm_PopupMode_si, TPopupMode_sw, True, True, 0, False, False);
  AData.AddProperty('ScreenSnap', TCustomForm_ScreenSnap_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('SnapBuffer', TCustomForm_SnapBuffer_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('WindowState', TCustomForm_WindowState_si, TWindowState_sw, True, True, 0, False, False);
  AData.AddProperty('PopupParent', TCustomForm_PopupParent_si, TCustomForm_sw, True, True, 0, False, False);
  AData.AddProperty('Left', TCustomForm_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TCustomForm_Top_si, Integer_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('CreateNew', TCustomForm_CreateNew_si, 1, True);
end;

class function TCustomForm_sw.ToVar(const AValue: TCustomForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomForm_sw.FromVar(const AValue: OleVariant): TCustomForm;
begin
  Result := TCustomForm(ConvFromVar(AValue, TCustomForm));
end;

class function TCustomForm_sw.ClassToVar(AClass: TCustomForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomForm_sw.ClassFromVar(
  const AClass: OleVariant): TCustomForm_sc;
begin
  Result := TCustomForm_sc(ConvClsFromVar(AClass, TCustomForm));
end;

{ TCustomFormClass_sw }

class function TCustomFormClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomFormClass';
end;

class function TCustomFormClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomForm;
end;

class function TCustomFormClass_sw.ToVar(
  const AValue: TCustomFormClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomFormClass_sw.FromVar(
  const AValue: OleVariant): TCustomFormClass;
begin
  Result := TCustomFormClass(ConvFromVar(AValue, TCustomForm));
end;

{ TActiveFormBorderStyle_sw }

class function TActiveFormBorderStyle_sw.GetTypeName: WideString;
begin
  Result := 'TActiveFormBorderStyle';
end;

class procedure TActiveFormBorderStyle_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'afbNone'; Value: Integer({$IFDEF LMDSCT_12}TActiveFormBorderStyle.{$ENDIF}afbNone)),
    (Name: 'afbSingle'; Value: Integer({$IFDEF LMDSCT_12}TActiveFormBorderStyle.{$ENDIF}afbSingle)),
    (Name: 'afbSunken'; Value: Integer({$IFDEF LMDSCT_12}TActiveFormBorderStyle.{$ENDIF}afbSunken)),
    (Name: 'afbRaised'; Value: Integer({$IFDEF LMDSCT_12}TActiveFormBorderStyle.{$ENDIF}afbRaised))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TActiveFormBorderStyle_sw.ToVar(
  const AValue: TActiveFormBorderStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TActiveFormBorderStyle_sw.FromVar(
  const AValue: OleVariant): TActiveFormBorderStyle;
begin
  Result := TActiveFormBorderStyle(Integer(AValue));
end;

{ TCustomActiveForm_sw }

function TCustomActiveForm_AxBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AxBorderStyle: TActiveFormBorderStyle read <gett...

  if IsGet then
    Result := TActiveFormBorderStyle_sw.ToVar(TCustomActiveForm(AObj).
      AxBorderStyle)
  else
    TCustomActiveForm(AObj).AxBorderStyle := TActiveFormBorderStyle_sw.FromVar(
      AArgs[0]);
end;

class function TCustomActiveForm_sw.GetTypeName: WideString;
begin
  Result := 'TCustomActiveForm';
end;

class function TCustomActiveForm_sw.GetWrappedClass: TClass;
begin
  Result := TCustomActiveForm;
end;

class procedure TCustomActiveForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('ActiveControl', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoScroll', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddProperty('AxBorderStyle', TCustomActiveForm_AxBorderStyle_si, TActiveFormBorderStyle_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddPropertyRedecl('HorzScrollBar', False);
  AData.AddPropertyRedecl('KeyPreview', False);
  AData.AddPropertyRedecl('Padding', False);
  AData.AddPropertyRedecl('OldCreateOrder', False);
  AData.AddPropertyRedecl('PixelsPerInch', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('PrintScale', False);
  AData.AddPropertyRedecl('Scaled', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('VertScrollBar', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddPropertyRedecl('OnActivate', False);
  AData.AddPropertyRedecl('OnAfterMonitorDpiChanged', False);
  AData.AddPropertyRedecl('OnBeforeMonitorDpiChanged', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnCreate', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDestroy', False);
  AData.AddPropertyRedecl('OnDeactivate', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnPaint', False);
end;

class function TCustomActiveForm_sw.ToVar(
  const AValue: TCustomActiveForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomActiveForm_sw.FromVar(
  const AValue: OleVariant): TCustomActiveForm;
begin
  Result := TCustomActiveForm(ConvFromVar(AValue, TCustomActiveForm));
end;

class function TCustomActiveForm_sw.ClassToVar(
  AClass: TCustomActiveForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomActiveForm_sw.ClassFromVar(
  const AClass: OleVariant): TCustomActiveForm_sc;
begin
  Result := TCustomActiveForm_sc(ConvClsFromVar(AClass, TCustomActiveForm));
end;

{ TForm_sw }

function TForm_ArrangeIcons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ArrangeIcons;

  TForm(AObj).ArrangeIcons();
end;

function TForm_Cascade_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Cascade;

  TForm(AObj).Cascade();
end;

function TForm_Next_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Next;

  TForm(AObj).Next();
end;

function TForm_Previous_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Previous;

  TForm(AObj).Previous();
end;

function TForm_Tile_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // procedure Tile;

  TForm(AObj).Tile();
end;

class function TForm_sw.GetTypeName: WideString;
begin
  Result := 'TForm';
end;

class function TForm_sw.GetWrappedClass: TClass;
begin
  Result := TForm;
end;

class procedure TForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ArrangeIcons', TForm_ArrangeIcons_si, 0, False);
  AData.AddProcedure('Cascade', TForm_Cascade_si, 0, False);
  AData.AddProcedure('Next', TForm_Next_si, 0, False);
  AData.AddProcedure('Previous', TForm_Previous_si, 0, False);
  AData.AddProcedure('Tile', TForm_Tile_si, 0, False);
  AData.AddPropertyRedecl('ActiveMDIChild', False);
  AData.AddPropertyRedecl('ClientHandle', False);
  AData.AddPropertyRedecl('DockManager', False);
  AData.AddPropertyRedecl('MDIChildCount', False);
  AData.AddPropertyRedecl('MDIChildren', False);
  AData.AddPropertyRedecl('TileMode', False);
  AData.AddPropertyRedecl('Action', False);
  AData.AddPropertyRedecl('ActiveControl', False);
  AData.AddPropertyRedecl('Align', False);
  AData.AddPropertyRedecl('AlphaBlend', False);
  AData.AddPropertyRedecl('AlphaBlendValue', False);
  AData.AddPropertyRedecl('Anchors', False);
  AData.AddPropertyRedecl('AutoScroll', False);
  AData.AddPropertyRedecl('AutoSize', False);
  AData.AddPropertyRedecl('BiDiMode', False);
  AData.AddPropertyRedecl('BorderIcons', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('BorderWidth', False);
  AData.AddPropertyRedecl('Caption', False);
  AData.AddPropertyRedecl('ClientHeight', False);
  AData.AddPropertyRedecl('ClientWidth', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('TransparentColor', False);
  AData.AddPropertyRedecl('TransparentColorValue', False);
  AData.AddPropertyRedecl('Constraints', False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddPropertyRedecl('UseDockManager', False);
  AData.AddPropertyRedecl('DefaultMonitor', False);
  AData.AddPropertyRedecl('DockSite', False);
  AData.AddPropertyRedecl('DoubleBuffered', False);
  AData.AddPropertyRedecl('DragKind', False);
  AData.AddPropertyRedecl('DragMode', False);
  AData.AddPropertyRedecl('Enabled', False);
  AData.AddPropertyRedecl('ParentFont', False);
  AData.AddPropertyRedecl('Font', False);
  AData.AddPropertyRedecl('FormStyle', False);
  AData.AddPropertyRedecl('GlassFrame', False);
  AData.AddPropertyRedecl('Height', False);
  AData.AddPropertyRedecl('HelpFile', False);
  AData.AddPropertyRedecl('HorzScrollBar', False);
  AData.AddPropertyRedecl('Icon', False);
  AData.AddPropertyRedecl('KeyPreview', False);
  AData.AddPropertyRedecl('Padding', False);
  AData.AddPropertyRedecl('Menu', False);
  AData.AddPropertyRedecl('OldCreateOrder', False);
  AData.AddPropertyRedecl('ObjectMenuItem', False);
  AData.AddPropertyRedecl('ParentBiDiMode', False);
  AData.AddPropertyRedecl('PixelsPerInch', False);
  AData.AddPropertyRedecl('PopupMenu', False);
  AData.AddPropertyRedecl('PopupMode', False);
  AData.AddPropertyRedecl('PopupParent', False);
  AData.AddPropertyRedecl('Position', False);
  AData.AddPropertyRedecl('PrintScale', False);
  AData.AddPropertyRedecl('Scaled', False);
  AData.AddPropertyRedecl('ScreenSnap', False);
  AData.AddPropertyRedecl('ShowHint', False);
  AData.AddPropertyRedecl('SnapBuffer', False);
  AData.AddPropertyRedecl('Touch', False);
  AData.AddPropertyRedecl('TipMode', False);
  AData.AddPropertyRedecl('VertScrollBar', False);
  AData.AddPropertyRedecl('Visible', False);
  AData.AddPropertyRedecl('Width', False);
  AData.AddPropertyRedecl('WindowState', False);
  AData.AddPropertyRedecl('WindowMenu', False);
  AData.AddPropertyRedecl('StyleElements', False);
  AData.AddPropertyRedecl('OnActivate', False);
  AData.AddPropertyRedecl('OnAfterMonitorDpiChanged', False);
  AData.AddPropertyRedecl('OnAlignInsertBefore', False);
  AData.AddPropertyRedecl('OnAlignPosition', False);
  AData.AddPropertyRedecl('OnBeforeMonitorDpiChanged', False);
  AData.AddPropertyRedecl('OnCanResize', False);
  AData.AddPropertyRedecl('OnClick', False);
  AData.AddPropertyRedecl('OnClose', False);
  AData.AddPropertyRedecl('OnCloseQuery', False);
  AData.AddPropertyRedecl('OnConstrainedResize', False);
  AData.AddPropertyRedecl('OnContextPopup', False);
  AData.AddPropertyRedecl('OnCreate', False);
  AData.AddPropertyRedecl('OnDblClick', False);
  AData.AddPropertyRedecl('OnDestroy', False);
  AData.AddPropertyRedecl('OnDeactivate', False);
  AData.AddPropertyRedecl('OnDockDrop', False);
  AData.AddPropertyRedecl('OnDockOver', False);
  AData.AddPropertyRedecl('OnDragDrop', False);
  AData.AddPropertyRedecl('OnDragOver', False);
  AData.AddPropertyRedecl('OnEndDock', False);
  AData.AddPropertyRedecl('OnGesture', False);
  AData.AddPropertyRedecl('OnGetSiteInfo', False);
  AData.AddPropertyRedecl('OnHide', False);
  AData.AddPropertyRedecl('OnHelp', False);
  AData.AddPropertyRedecl('OnKeyDown', False);
  AData.AddPropertyRedecl('OnKeyPress', False);
  AData.AddPropertyRedecl('OnKeyUp', False);
  AData.AddPropertyRedecl('OnMouseActivate', False);
  AData.AddPropertyRedecl('OnMouseDown', False);
  AData.AddPropertyRedecl('OnMouseEnter', False);
  AData.AddPropertyRedecl('OnMouseLeave', False);
  AData.AddPropertyRedecl('OnMouseMove', False);
  AData.AddPropertyRedecl('OnMouseUp', False);
  AData.AddPropertyRedecl('OnMouseWheel', False);
  AData.AddPropertyRedecl('OnMouseWheelDown', False);
  AData.AddPropertyRedecl('OnMouseWheelUp', False);
  AData.AddPropertyRedecl('OnPaint', False);
  AData.AddPropertyRedecl('OnResize', False);
  AData.AddPropertyRedecl('OnShortCut', False);
  AData.AddPropertyRedecl('OnShow', False);
  AData.AddPropertyRedecl('OnStartDock', False);
  AData.AddPropertyRedecl('OnUnDock', False);
end;

class function TForm_sw.ToVar(const AValue: TForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TForm_sw.FromVar(const AValue: OleVariant): TForm;
begin
  Result := TForm(ConvFromVar(AValue, TForm));
end;

class function TForm_sw.ClassToVar(AClass: TForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TForm_sw.ClassFromVar(const AClass: OleVariant): TForm_sc;
begin
  Result := TForm_sc(ConvClsFromVar(AClass, TForm));
end;

{ TFormClass_sw }

class function TFormClass_sw.GetTypeName: WideString;
begin
  Result := 'TFormClass';
end;

class function TFormClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TForm;
end;

class function TFormClass_sw.ToVar(const AValue: TFormClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFormClass_sw.FromVar(const AValue: OleVariant): TFormClass;
begin
  Result := TFormClass(ConvFromVar(AValue, TForm));
end;

{ TCustomDockForm_sw }

class function TCustomDockForm_sw.GetTypeName: WideString;
begin
  Result := 'TCustomDockForm';
end;

class function TCustomDockForm_sw.GetWrappedClass: TClass;
begin
  Result := TCustomDockForm;
end;

class procedure TCustomDockForm_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('AutoScroll', False);
  AData.AddPropertyRedecl('BorderStyle', False);
  AData.AddPropertyRedecl('FormStyle', False);
  AData.AddPropertyRedecl('PixelsPerInch', False);
end;

class function TCustomDockForm_sw.ToVar(
  const AValue: TCustomDockForm): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomDockForm_sw.FromVar(
  const AValue: OleVariant): TCustomDockForm;
begin
  Result := TCustomDockForm(ConvFromVar(AValue, TCustomDockForm));
end;

class function TCustomDockForm_sw.ClassToVar(
  AClass: TCustomDockForm_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomDockForm_sw.ClassFromVar(
  const AClass: OleVariant): TCustomDockForm_sc;
begin
  Result := TCustomDockForm_sc(ConvClsFromVar(AClass, TCustomDockForm));
end;

{ TMonitor_sw }

function TMonitor_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HMONITOR read <getter>;

  Result := HMONITOR_sw.ToVar(TMonitor(AObj).Handle);
end;

function TMonitor_MonitorNum_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MonitorNum: Integer read <getter>;

  Result := TMonitor(AObj).MonitorNum;
end;

function TMonitor_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter>;

  Result := TMonitor(AObj).Left;
end;

function TMonitor_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter>;

  Result := TMonitor(AObj).Height;
end;

function TMonitor_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter>;

  Result := TMonitor(AObj).Top;
end;

function TMonitor_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter>;

  Result := TMonitor(AObj).Width;
end;

function TMonitor_BoundsRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BoundsRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TMonitor(AObj).BoundsRect);
end;

function TMonitor_WorkareaRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkareaRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TMonitor(AObj).WorkareaRect);
end;

function TMonitor_Primary_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Primary: Boolean read <getter>;

  Result := TMonitor(AObj).Primary;
end;

function TMonitor_PixelsPerInch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PixelsPerInch: Integer read <getter>;

  Result := TMonitor(AObj).PixelsPerInch;
end;

class function TMonitor_sw.GetTypeName: WideString;
begin
  Result := 'TMonitor';
end;

class function TMonitor_sw.GetWrappedClass: TClass;
begin
  Result := TMonitor;
end;

class procedure TMonitor_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Handle', TMonitor_Handle_si, HMONITOR_sw, True, False, 0, False, False);
  AData.AddProperty('MonitorNum', TMonitor_MonitorNum_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Left', TMonitor_Left_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Height', TMonitor_Height_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Top', TMonitor_Top_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Width', TMonitor_Width_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('BoundsRect', TMonitor_BoundsRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('WorkareaRect', TMonitor_WorkareaRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('Primary', TMonitor_Primary_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('PixelsPerInch', TMonitor_PixelsPerInch_si, Integer_sw, True, False, 0, False, False);
end;

class function TMonitor_sw.ToVar(const AValue: TMonitor): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TMonitor_sw.FromVar(const AValue: OleVariant): TMonitor;
begin
  Result := TMonitor(ConvFromVar(AValue, TMonitor));
end;

class function TMonitor_sw.ClassToVar(AClass: TMonitor_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TMonitor_sw.ClassFromVar(const AClass: OleVariant): TMonitor_sc;
begin
  Result := TMonitor_sc(ConvClsFromVar(AClass, TMonitor));
end;

{ TCursorRec_sw }

function TCursorRec_Index_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Index: Integer;

  if IsGet then
    Result := TCursorRec_sw(AObj).FValue.Index
  else
    TCursorRec_sw(AObj).FValue.Index := Integer(AArgs[0]);
end;

function TCursorRec_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Handle: HCURSOR;

  if IsGet then
    Result := HCURSOR_sw.ToVar(TCursorRec_sw(AObj).FValue.Handle)
  else
    TCursorRec_sw(AObj).FValue.Handle := HCURSOR_sw.FromVar(AArgs[0]);
end;

function TCursorRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCursorRec_sw.Create as IDispatch;
end;

function TCursorRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCursorRec;

  // Implicit record copy method.
  Result := TCursorRec_sw.ToVar(TCursorRec(AObj));
end;

class function TCursorRec_sw.GetTypeName: WideString;
begin
  Result := 'TCursorRec';
end;

function TCursorRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCursorRec_sw.Create;
  TCursorRec_sw(Result).FValue := FValue;
end;

class procedure TCursorRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Index', TCursorRec_Index_si, Integer_sw);
  AData.AddField('Handle', TCursorRec_Handle_si, HCURSOR_sw);
  AData.AddFunction('Copy', TCursorRec_Copy_si, TCursorRec_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCursorRec_Create_si, 0, False);
end;

class function TCursorRec_sw.ToVar(const AValue: TCursorRec): OleVariant;
var
  wrpr: TCursorRec_sw;
begin
  wrpr        := TCursorRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCursorRec_sw.FromVar(const AValue: OleVariant): TCursorRec;
begin
  Result := TCursorRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TMonitorDefaultTo_sw }

class function TMonitorDefaultTo_sw.GetTypeName: WideString;
begin
  Result := 'TMonitorDefaultTo';
end;

class procedure TMonitorDefaultTo_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'mdNearest'; Value: Integer({$IFDEF LMDSCT_12}TMonitorDefaultTo.{$ENDIF}mdNearest)),
    (Name: 'mdNull'; Value: Integer({$IFDEF LMDSCT_12}TMonitorDefaultTo.{$ENDIF}mdNull)),
    (Name: 'mdPrimary'; Value: Integer({$IFDEF LMDSCT_12}TMonitorDefaultTo.{$ENDIF}mdPrimary))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TMonitorDefaultTo_sw.ToVar(
  const AValue: TMonitorDefaultTo): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMonitorDefaultTo_sw.FromVar(
  const AValue: OleVariant): TMonitorDefaultTo;
begin
  Result := TMonitorDefaultTo(Integer(AValue));
end;

{ TScreen_sw }

function TScreen_DisableAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DisableAlign;

  TScreen(AObj).DisableAlign();
end;

function TScreen_EnableAlign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure EnableAlign;

  TScreen(AObj).EnableAlign();
end;

function TScreen_MonitorFromPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MonitorFromPoint(const Point: TPoint; MonitorDef...

  case AArgsSize of
    1:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromPoint(TPoint_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromPoint(TPoint_sw.
        FromVar(AArgs[0]), TMonitorDefaultTo_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('MonitorFromPoint');
  end;
end;

function TScreen_MonitorFromRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MonitorFromRect(const Rect: TRect; MonitorDefaul...

  case AArgsSize of
    1:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromRect(TRect_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromRect(TRect_sw.
        FromVar(AArgs[0]), TMonitorDefaultTo_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('MonitorFromRect');
  end;
end;

function TScreen_MonitorFromWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MonitorFromWindow(const Handle: THandle; Monitor...

  case AArgsSize of
    1:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromWindow(THandle_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TMonitor_sw.ToVar(TScreen(AObj).MonitorFromWindow(THandle_sw.
        FromVar(AArgs[0]), TMonitorDefaultTo_sw.FromVar(AArgs[1])));
    end;
  else
    WrongArgCountError('MonitorFromWindow');
  end;
end;

function TScreen_Realign_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Realign;

  TScreen(AObj).Realign();
end;

function TScreen_ResetFonts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ResetFonts;

  TScreen(AObj).ResetFonts();
end;

function TScreen_ActiveControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveControl: TWinControl read <getter>;

  Result := TWinControl_sw.ToVar(TScreen(AObj).ActiveControl);
end;

function TScreen_ActiveCustomForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveCustomForm: TCustomForm read <getter>;

  Result := TCustomForm_sw.ToVar(TScreen(AObj).ActiveCustomForm);
end;

function TScreen_ActiveForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveForm: TForm read <getter>;

  Result := TForm_sw.ToVar(TScreen(AObj).ActiveForm);
end;

function TScreen_CustomFormCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomFormCount: Integer read <getter>;

  Result := TScreen(AObj).CustomFormCount;
end;

function TScreen_CustomForms_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomForms[Index: Integer]: TCustomForm read <g...

  Result := TCustomForm_sw.ToVar(TScreen(AObj).CustomForms[Integer(AArgs[0])]);
end;

function TScreen_CursorCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CursorCount: Integer read <getter>;

  Result := TScreen(AObj).CursorCount;
end;

function TScreen_Cursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cursor: TCursor read <getter> write <setter>;

  if IsGet then
    Result := TCursor_sw.ToVar(TScreen(AObj).Cursor)
  else
    TScreen(AObj).Cursor := TCursor_sw.FromVar(AArgs[0]);
end;

function TScreen_Cursors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Cursors[Index: Integer]: HCURSOR read <getter> w...

  if IsGet then
    Result := HCURSOR_sw.ToVar(TScreen(AObj).Cursors[Integer(AArgs[0])])
  else
    TScreen(AObj).Cursors[Integer(AArgs[0])] := HCURSOR_sw.FromVar(AArgs[1]);
end;

function TScreen_DataModules_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataModules[Index: Integer]: TDataModule read <g...

  Result := TDataModule_sw.ToVar(TScreen(AObj).DataModules[Integer(AArgs[0])]);
end;

function TScreen_DataModuleCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataModuleCount: Integer read <getter>;

  Result := TScreen(AObj).DataModuleCount;
end;

function TScreen_FocusedForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FocusedForm: TCustomForm read <getter> write <se...

  if IsGet then
    Result := TCustomForm_sw.ToVar(TScreen(AObj).FocusedForm)
  else
    TScreen(AObj).FocusedForm := TCustomForm_sw.FromVar(AArgs[0]);
end;

function TScreen_SaveFocusedList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property SaveFocusedList: TList read <getter>;

  Result := TList_sw.ToVar(TScreen(AObj).SaveFocusedList);
end;

function TScreen_MonitorCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MonitorCount: Integer read <getter>;

  Result := TScreen(AObj).MonitorCount;
end;

function TScreen_Monitors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Monitors[Index: Integer]: TMonitor read <getter>;

  Result := TMonitor_sw.ToVar(TScreen(AObj).Monitors[Integer(AArgs[0])]);
end;

function TScreen_DesktopRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesktopRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TScreen(AObj).DesktopRect);
end;

function TScreen_DesktopHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesktopHeight: Integer read <getter>;

  Result := TScreen(AObj).DesktopHeight;
end;

function TScreen_DesktopLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesktopLeft: Integer read <getter>;

  Result := TScreen(AObj).DesktopLeft;
end;

function TScreen_DesktopTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesktopTop: Integer read <getter>;

  Result := TScreen(AObj).DesktopTop;
end;

function TScreen_DesktopWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DesktopWidth: Integer read <getter>;

  Result := TScreen(AObj).DesktopWidth;
end;

function TScreen_WorkAreaRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreaRect: TRect read <getter>;

  Result := TRect_sw.ToVar(TScreen(AObj).WorkAreaRect);
end;

function TScreen_WorkAreaHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreaHeight: Integer read <getter>;

  Result := TScreen(AObj).WorkAreaHeight;
end;

function TScreen_WorkAreaLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreaLeft: Integer read <getter>;

  Result := TScreen(AObj).WorkAreaLeft;
end;

function TScreen_WorkAreaTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreaTop: Integer read <getter>;

  Result := TScreen(AObj).WorkAreaTop;
end;

function TScreen_WorkAreaWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property WorkAreaWidth: Integer read <getter>;

  Result := TScreen(AObj).WorkAreaWidth;
end;

function TScreen_HintFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TScreen(AObj).HintFont)
  else
    TScreen(AObj).HintFont := TFont_sw.FromVar(AArgs[0]);
end;

function TScreen_IconFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IconFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TScreen(AObj).IconFont)
  else
    TScreen(AObj).IconFont := TFont_sw.FromVar(AArgs[0]);
end;

function TScreen_MenuFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MenuFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TScreen(AObj).MenuFont)
  else
    TScreen(AObj).MenuFont := TFont_sw.FromVar(AArgs[0]);
end;

function TScreen_MessageFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MessageFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TScreen(AObj).MessageFont)
  else
    TScreen(AObj).MessageFont := TFont_sw.FromVar(AArgs[0]);
end;

function TScreen_CaptionFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CaptionFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TScreen(AObj).CaptionFont)
  else
    TScreen(AObj).CaptionFont := TFont_sw.FromVar(AArgs[0]);
end;

function TScreen_Fonts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Fonts: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TScreen(AObj).Fonts);
end;

function TScreen_FormCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FormCount: Integer read <getter>;

  Result := TScreen(AObj).FormCount;
end;

function TScreen_Forms_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Forms[Index: Integer]: TForm read <getter>;

  Result := TForm_sw.ToVar(TScreen(AObj).Forms[Integer(AArgs[0])]);
end;

function TScreen_Imes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Imes: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TScreen(AObj).Imes);
end;

function TScreen_DefaultIme_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultIme: string read <getter>;

  Result := TScreen(AObj).DefaultIme;
end;

function TScreen_DefaultKbLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultKbLayout: HKL read <getter>;

  Result := HKL_sw.ToVar(TScreen(AObj).DefaultKbLayout);
end;

function TScreen_Height_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Height: Integer read <getter>;

  Result := TScreen(AObj).Height;
end;

function TScreen_PixelsPerInch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PixelsPerInch: Integer read <getter>;

  Result := TScreen(AObj).PixelsPerInch;
end;

function TScreen_PrimaryMonitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrimaryMonitor: TMonitor read <getter>;

  Result := TMonitor_sw.ToVar(TScreen(AObj).PrimaryMonitor);
end;

function TScreen_Width_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Width: Integer read <getter>;

  Result := TScreen(AObj).Width;
end;

function TScreen_OnActiveControlChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActiveControlChange: TNotifyEvent read <getter...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TScreen(AObj).OnActiveControlChange)
  else
    TScreen(AObj).OnActiveControlChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TScreen_OnActiveFormChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActiveFormChange: TNotifyEvent read <getter> w...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TScreen(AObj).OnActiveFormChange)
  else
    TScreen(AObj).OnActiveFormChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TScreen_sw.GetTypeName: WideString;
begin
  Result := 'TScreen';
end;

class function TScreen_sw.GetWrappedClass: TClass;
begin
  Result := TScreen;
end;

class procedure TScreen_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('DisableAlign', TScreen_DisableAlign_si, 0, False);
  AData.AddProcedure('EnableAlign', TScreen_EnableAlign_si, 0, False);
  AData.AddFunction('MonitorFromPoint', TScreen_MonitorFromPoint_si, TMonitor_sw, 1, True);
  AData.AddFunction('MonitorFromRect', TScreen_MonitorFromRect_si, TMonitor_sw, 1, True);
  AData.AddFunction('MonitorFromWindow', TScreen_MonitorFromWindow_si, TMonitor_sw, 1, True);
  AData.AddProcedure('Realign', TScreen_Realign_si, 0, False);
  AData.AddProcedure('ResetFonts', TScreen_ResetFonts_si, 0, False);
  AData.AddProperty('ActiveControl', TScreen_ActiveControl_si, TWinControl_sw, True, False, 0, False, False);
  AData.AddProperty('ActiveCustomForm', TScreen_ActiveCustomForm_si, TCustomForm_sw, True, False, 0, False, False);
  AData.AddProperty('ActiveForm', TScreen_ActiveForm_si, TForm_sw, True, False, 0, False, False);
  AData.AddProperty('CustomFormCount', TScreen_CustomFormCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('CustomForms', TScreen_CustomForms_si, TCustomForm_sw, True, False, 1, False, False);
  AData.AddProperty('CursorCount', TScreen_CursorCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Cursor', TScreen_Cursor_si, TCursor_sw, True, True, 0, False, False);
  AData.AddProperty('Cursors', TScreen_Cursors_si, HCURSOR_sw, True, True, 1, False, False);
  AData.AddProperty('DataModules', TScreen_DataModules_si, TDataModule_sw, True, False, 1, False, False);
  AData.AddProperty('DataModuleCount', TScreen_DataModuleCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('FocusedForm', TScreen_FocusedForm_si, TCustomForm_sw, True, True, 0, False, False);
  AData.AddProperty('SaveFocusedList', TScreen_SaveFocusedList_si, TList_sw, True, False, 0, False, False);
  AData.AddProperty('MonitorCount', TScreen_MonitorCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Monitors', TScreen_Monitors_si, TMonitor_sw, True, False, 1, False, False);
  AData.AddProperty('DesktopRect', TScreen_DesktopRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('DesktopHeight', TScreen_DesktopHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DesktopLeft', TScreen_DesktopLeft_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DesktopTop', TScreen_DesktopTop_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('DesktopWidth', TScreen_DesktopWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreaRect', TScreen_WorkAreaRect_si, TRect_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreaHeight', TScreen_WorkAreaHeight_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreaLeft', TScreen_WorkAreaLeft_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreaTop', TScreen_WorkAreaTop_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('WorkAreaWidth', TScreen_WorkAreaWidth_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('HintFont', TScreen_HintFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('IconFont', TScreen_IconFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('MenuFont', TScreen_MenuFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('MessageFont', TScreen_MessageFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('CaptionFont', TScreen_CaptionFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('Fonts', TScreen_Fonts_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('FormCount', TScreen_FormCount_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('Forms', TScreen_Forms_si, TForm_sw, True, False, 1, False, False);
  AData.AddProperty('Imes', TScreen_Imes_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultIme', TScreen_DefaultIme_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultKbLayout', TScreen_DefaultKbLayout_si, HKL_sw, True, False, 0, False, False);
  AData.AddProperty('Height', TScreen_Height_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PixelsPerInch', TScreen_PixelsPerInch_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('PrimaryMonitor', TScreen_PrimaryMonitor_si, TMonitor_sw, True, False, 0, False, False);
  AData.AddProperty('Width', TScreen_Width_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('OnActiveControlChange', TScreen_OnActiveControlChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnActiveFormChange', TScreen_OnActiveFormChange_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TScreen_sw.ToVar(const AValue: TScreen): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TScreen_sw.FromVar(const AValue: OleVariant): TScreen;
begin
  Result := TScreen(ConvFromVar(AValue, TScreen));
end;

class function TScreen_sw.ClassToVar(AClass: TScreen_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TScreen_sw.ClassFromVar(const AClass: OleVariant): TScreen_sc;
begin
  Result := TScreen_sc(ConvClsFromVar(AClass, TScreen));
end;

{ TTimerMode_sw }

class function TTimerMode_sw.GetTypeName: WideString;
begin
  Result := 'TTimerMode';
end;

class procedure TTimerMode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tmShow'; Value: Integer({$IFDEF LMDSCT_12}TTimerMode.{$ENDIF}tmShow)),
    (Name: 'tmHide'; Value: Integer({$IFDEF LMDSCT_12}TTimerMode.{$ENDIF}tmHide))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTimerMode_sw.ToVar(const AValue: TTimerMode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTimerMode_sw.FromVar(const AValue: OleVariant): TTimerMode;
begin
  Result := TTimerMode(Integer(AValue));
end;

{ TCMHintShowPause_sw }

function TCMHintShowPause_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TCMHintShowPause_sw(AObj).FValue.Msg
  else
    TCMHintShowPause_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TCMHintShowPause_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TCMHintShowPause_sw(AObj).FValue.MsgFiller)
  else
    TCMHintShowPause_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TCMHintShowPause_WasActive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WasActive: Integer;

  if IsGet then
    Result := TCMHintShowPause_sw(AObj).FValue.WasActive
  else
    TCMHintShowPause_sw(AObj).FValue.WasActive := Integer(AArgs[0]);
end;

function TCMHintShowPause_WasActiveFiller_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WasActiveFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TCMHintShowPause_sw(AObj).FValue.
      WasActiveFiller)
  else
    TCMHintShowPause_sw(AObj).FValue.WasActiveFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TCMHintShowPause_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TCMHintShowPause_sw(AObj).FValue.Result)
  else
    TCMHintShowPause_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TCMHintShowPause_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCMHintShowPause_sw.Create as IDispatch;
end;

function TCMHintShowPause_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCMHintShowPause;

  // Implicit record copy method.
  Result := TCMHintShowPause_sw.ToVar(TCMHintShowPause(AObj));
end;

class function TCMHintShowPause_sw.GetTypeName: WideString;
begin
  Result := 'TCMHintShowPause';
end;

function TCMHintShowPause_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCMHintShowPause_sw.Create;
  TCMHintShowPause_sw(Result).FValue := FValue;
end;

class procedure TCMHintShowPause_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TCMHintShowPause_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TCMHintShowPause_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('WasActive', TCMHintShowPause_WasActive_si, Integer_sw);
  AData.AddField('WasActiveFiller', TCMHintShowPause_WasActiveFiller_si, TDWordFiller_sw);
  AData.AddField('Result', TCMHintShowPause_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TCMHintShowPause_Copy_si, TCMHintShowPause_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCMHintShowPause_Create_si, 0, False);
end;

class function TCMHintShowPause_sw.ToVar(
  const AValue: TCMHintShowPause): OleVariant;
var
  wrpr: TCMHintShowPause_sw;
begin
  wrpr        := TCMHintShowPause_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCMHintShowPause_sw.FromVar(
  const AValue: OleVariant): TCMHintShowPause;
begin
  Result := TCMHintShowPause_sw(ConvFromVar(AValue)).FValue;
end;

{ TPopupForm_sw }

function TPopupForm_FormID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FormID: Integer;

  if IsGet then
    Result := TPopupForm_sw(AObj).FValue.FormID
  else
    TPopupForm_sw(AObj).FValue.FormID := Integer(AArgs[0]);
end;

function TPopupForm_Form_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Form: TCustomForm;

  if IsGet then
    Result := TCustomForm_sw.ToVar(TPopupForm_sw(AObj).FValue.Form)
  else
    TPopupForm_sw(AObj).FValue.Form := TCustomForm_sw.FromVar(AArgs[0]);
end;

function TPopupForm_WasPopup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WasPopup: Boolean;

  if IsGet then
    Result := TPopupForm_sw(AObj).FValue.WasPopup
  else
    TPopupForm_sw(AObj).FValue.WasPopup := Boolean(AArgs[0]);
end;

function TPopupForm_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TPopupForm_sw.Create as IDispatch;
end;

function TPopupForm_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPopupForm;

  // Implicit record copy method.
  Result := TPopupForm_sw.ToVar(TPopupForm(AObj));
end;

class function TPopupForm_sw.GetTypeName: WideString;
begin
  Result := 'TPopupForm';
end;

function TPopupForm_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPopupForm_sw.Create;
  TPopupForm_sw(Result).FValue := FValue;
end;

class procedure TPopupForm_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('FormID', TPopupForm_FormID_si, Integer_sw);
  AData.AddField('Form', TPopupForm_Form_si, TCustomForm_sw);
  AData.AddField('WasPopup', TPopupForm_WasPopup_si, Boolean_sw);
  AData.AddFunction('Copy', TPopupForm_Copy_si, TPopupForm_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPopupForm_Create_si, 0, False);
end;

class function TPopupForm_sw.ToVar(const AValue: TPopupForm): OleVariant;
var
  wrpr: TPopupForm_sw;
begin
  wrpr        := TPopupForm_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPopupForm_sw.FromVar(const AValue: OleVariant): TPopupForm;
begin
  Result := TPopupForm_sw(ConvFromVar(AValue)).FValue;
end;

{ TMessageEvent_sh }

function TMessageEvent_sh.GetHandler: TMethod;
var
  hdr: TMessageEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TMessageEvent_sh.Handler(var Msg: TMsg; var Handled: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
begin
  // procedure (var Msg: TMsg; var Handled: Boolean) of object

  v_1 := TMsg_sw.ToVar(Msg);
  v_2 := Handled;
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  Self.Owner.RunProc(Self.ProcName, args);
  Msg := TMsg_sw.FromVar(v_1);
  Handled := Boolean(v_2);
end;

{ TMessageEvent_sw }

class function TMessageEvent_sw.GetTypeName: WideString;
begin
  Result := 'TMessageEvent';
end;

class function TMessageEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TMessageEvent_sh;
end;

class function TMessageEvent_sw.ToVar(const AValue: TMessageEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TMessageEvent_sw.FromVar(
  const AValue: OleVariant): TMessageEvent;
begin
  Result := TMessageEvent(ConvFromVar(AValue));
end;

class function TMessageEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TMessageEvent;
var
  hdlr: TMessageEvent_sh;
begin
  hdlr   := TMessageEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TMessageEvent_sw));
  Result := hdlr.Handler;
end;

{ TExceptionEvent_sh }

function TExceptionEvent_sh.GetHandler: TMethod;
var
  hdr: TExceptionEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TExceptionEvent_sh.Handler(Sender: TObject; E: Exception);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; E: Exception) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Exception_sw.ToVar(E);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TExceptionEvent_sw }

class function TExceptionEvent_sw.GetTypeName: WideString;
begin
  Result := 'TExceptionEvent';
end;

class function TExceptionEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TExceptionEvent_sh;
end;

class function TExceptionEvent_sw.ToVar(
  const AValue: TExceptionEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TExceptionEvent_sw.FromVar(
  const AValue: OleVariant): TExceptionEvent;
begin
  Result := TExceptionEvent(ConvFromVar(AValue));
end;

class function TExceptionEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TExceptionEvent;
var
  hdlr: TExceptionEvent_sh;
begin
  hdlr   := TExceptionEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TExceptionEvent_sw));
  Result := hdlr.Handler;
end;

{ TGetHandleEvent_sh }

function TGetHandleEvent_sh.GetHandler: TMethod;
var
  hdr: TGetHandleEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TGetHandleEvent_sh.Handler(var Handle: HWND);
var
  args: array[0..0] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (var Handle: HWND) of object

  v_1 := HWND_sw.ToVar(Handle);
  args[0] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Handle := HWND_sw.FromVar(v_1);
end;

{ TGetHandleEvent_sw }

class function TGetHandleEvent_sw.GetTypeName: WideString;
begin
  Result := 'TGetHandleEvent';
end;

class function TGetHandleEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TGetHandleEvent_sh;
end;

class function TGetHandleEvent_sw.ToVar(
  const AValue: TGetHandleEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TGetHandleEvent_sw.FromVar(
  const AValue: OleVariant): TGetHandleEvent;
begin
  Result := TGetHandleEvent(ConvFromVar(AValue));
end;

class function TGetHandleEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TGetHandleEvent;
var
  hdlr: TGetHandleEvent_sh;
begin
  hdlr   := TGetHandleEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TGetHandleEvent_sw));
  Result := hdlr.Handler;
end;

{ TIdleEvent_sh }

function TIdleEvent_sh.GetHandler: TMethod;
var
  hdr: TIdleEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TIdleEvent_sh.Handler(Sender: TObject; var Done: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; var Done: Boolean) of object

  v_1 := Done;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Done := Boolean(v_1);
end;

{ TIdleEvent_sw }

class function TIdleEvent_sw.GetTypeName: WideString;
begin
  Result := 'TIdleEvent';
end;

class function TIdleEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TIdleEvent_sh;
end;

class function TIdleEvent_sw.ToVar(const AValue: TIdleEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TIdleEvent_sw.FromVar(const AValue: OleVariant): TIdleEvent;
begin
  Result := TIdleEvent(ConvFromVar(AValue));
end;

class function TIdleEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TIdleEvent;
var
  hdlr: TIdleEvent_sh;
begin
  hdlr   := TIdleEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TIdleEvent_sw));
  Result := hdlr.Handler;
end;

{ TShowHintEvent_sh }

function TShowHintEvent_sh.GetHandler: TMethod;
var
  hdr: TShowHintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TShowHintEvent_sh.Handler(var HintStr: string; var CanShow: Boolean;
  var HintInfo: Vcl.Controls.THintInfo);
var
  args: array[0..2] of OleVariant;
  v_1: OleVariant;
  v_2: OleVariant;
  v_3: OleVariant;
begin
  // procedure (var HintStr: string; var CanShow: Boolean; var...

  v_1 := HintStr;
  v_2 := CanShow;
  v_3 := Vcl.Controls_LMDSW.THintInfo_sw.ToVar(HintInfo);
  args[0] := MakeVarRef(v_1);
  args[1] := MakeVarRef(v_2);
  args[2] := MakeVarRef(v_3);
  Self.Owner.RunProc(Self.ProcName, args);
  HintStr := string(v_1);
  CanShow := Boolean(v_2);
  HintInfo := Vcl.Controls_LMDSW.THintInfo_sw.FromVar(v_3);
end;

{ TShowHintEvent_sw }

class function TShowHintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TShowHintEvent';
end;

class function TShowHintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TShowHintEvent_sh;
end;

class function TShowHintEvent_sw.ToVar(
  const AValue: TShowHintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TShowHintEvent_sw.FromVar(
  const AValue: OleVariant): TShowHintEvent;
begin
  Result := TShowHintEvent(ConvFromVar(AValue));
end;

class function TShowHintEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TShowHintEvent;
var
  hdlr: TShowHintEvent_sh;
begin
  hdlr   := TShowHintEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TShowHintEvent_sw));
  Result := hdlr.Handler;
end;

{ TWindowHook_sh }

function TWindowHook_sh.GetHandler: TMethod;
var
  hdr: TWindowHook;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

function TWindowHook_sh.Handler(var Message: TMessage): Boolean;
var
  args: array[0..0] of OleVariant;
  v_1: OleVariant;
begin
  // function (var Message: TMessage): Boolean of object

  v_1 := TMessage_sw.ToVar(Message);
  args[0] := MakeVarRef(v_1);
  Result := Boolean(Self.Owner.RunProc(Self.ProcName, args));
  Message := TMessage_sw.FromVar(v_1);
end;

{ TWindowHook_sw }

class function TWindowHook_sw.GetTypeName: WideString;
begin
  Result := 'TWindowHook';
end;

class function TWindowHook_sw.GetScriptHandlerClass: TClass;
begin
  Result := TWindowHook_sh;
end;

class function TWindowHook_sw.ToVar(const AValue: TWindowHook): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TWindowHook_sw.FromVar(const AValue: OleVariant): TWindowHook;
begin
  Result := TWindowHook(ConvFromVar(AValue));
end;

class function TWindowHook_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TWindowHook;
var
  hdlr: TWindowHook_sh;
begin
  hdlr   := TWindowHook_sh(AScriptControl.GetEventHandler(AProcName, 
    TWindowHook_sw));
  Result := hdlr.Handler;
end;

{ TSettingChangeEvent_sh }

function TSettingChangeEvent_sh.GetHandler: TMethod;
var
  hdr: TSettingChangeEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TSettingChangeEvent_sh.Handler(Sender: TObject; Flag: Integer;
  const Section: string; var Result: Longint);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Flag: Integer; const Section:...

  v_1 := Result;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Flag;
  args[2] := Section;
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Result := Longint(v_1);
end;

{ TSettingChangeEvent_sw }

class function TSettingChangeEvent_sw.GetTypeName: WideString;
begin
  Result := 'TSettingChangeEvent';
end;

class function TSettingChangeEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TSettingChangeEvent_sh;
end;

class function TSettingChangeEvent_sw.ToVar(
  const AValue: TSettingChangeEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TSettingChangeEvent_sw.FromVar(
  const AValue: OleVariant): TSettingChangeEvent;
begin
  Result := TSettingChangeEvent(ConvFromVar(AValue));
end;

class function TSettingChangeEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TSettingChangeEvent;
var
  hdlr: TSettingChangeEvent_sh;
begin
  hdlr   := TSettingChangeEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TSettingChangeEvent_sw));
  Result := hdlr.Handler;
end;

{ TApplication_sw }

function TApplication_ActivateHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ActivateHint(CursorPos: TPoint);

  TApplication(AObj).ActivateHint(TPoint_sw.FromVar(AArgs[0]));
end;

function TApplication_ApplyBiDiKeyboardLayout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyBiDiKeyboardLayout;

  TApplication(AObj).ApplyBiDiKeyboardLayout();
end;

function TApplication_ApplyNonBiDiKeyboardLayout_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ApplyNonBiDiKeyboardLayout;

  TApplication(AObj).ApplyNonBiDiKeyboardLayout();
end;

function TApplication_AddPopupForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddPopupForm(APopupForm: TCustomForm): Integer;

  Result := TApplication(AObj).AddPopupForm(TCustomForm_sw.FromVar(AArgs[0]));
end;

function TApplication_BringToFront_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure BringToFront;

  TApplication(AObj).BringToFront();
end;

function TApplication_ControlDestroyed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ControlDestroyed(Control: TControl);

  TApplication(AObj).ControlDestroyed(TControl_sw.FromVar(AArgs[0]));
end;

function TApplication_CancelHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CancelHint;

  TApplication(AObj).CancelHint();
end;

function TApplication_CreateHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CreateHandle;

  TApplication(AObj).CreateHandle();
end;

function TApplication_DoApplicationIdle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DoApplicationIdle;

  TApplication(AObj).DoApplicationIdle();
end;

function TApplication_ExecuteAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ExecuteAction(Action: TBasicAction): Boolean;

  Result := TApplication(AObj).ExecuteAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TApplication_HandleException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HandleException(Sender: TObject);

  TApplication(AObj).HandleException(TObject_sw.FromVar(AArgs[0]));
end;

function TApplication_HandleMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HandleMessage;

  TApplication(AObj).HandleMessage();
end;

function TApplication_HelpCommand_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HelpCommand(Command: Integer; Data: NativeInt): ...

  Result := TApplication(AObj).HelpCommand(Integer(AArgs[0]), NativeInt_sw.
    FromVar(AArgs[1]));
end;

function TApplication_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HelpContext(Context: THelpContext): Boolean;

  Result := TApplication(AObj).HelpContext(THelpContext_sw.FromVar(AArgs[0]));
end;

function TApplication_HelpJump_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HelpJump(const JumpID: string): Boolean;

  Result := TApplication(AObj).HelpJump(string(AArgs[0]));
end;

function TApplication_HelpKeyword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HelpKeyword(const Keyword: string): Boolean;

  Result := TApplication(AObj).HelpKeyword(string(AArgs[0]));
end;

function TApplication_HelpShowTableOfContents_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function HelpShowTableOfContents: Boolean;

  Result := TApplication(AObj).HelpShowTableOfContents();
end;

function TApplication_HideHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HideHint;

  TApplication(AObj).HideHint();
end;

function TApplication_HintMouseMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TMessage;
begin
  // procedure HintMouseMessage(Control: TControl; var Message...

  v_1 := TMessage_sw.FromVar(AArgs[1]);
  TApplication(AObj).HintMouseMessage(TControl_sw.FromVar(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TMessage_sw.ToVar(v_1));
end;

function TApplication_HookMainWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HookMainWindow(Hook: TWindowHook);

  TApplication(AObj).HookMainWindow(TWindowHook_sw.FromVar(AArgs[0]));
end;

function TApplication_HookSynchronizeWakeup_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HookSynchronizeWakeup;

  TApplication(AObj).HookSynchronizeWakeup();
end;

function TApplication_Initialize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Initialize;

  TApplication(AObj).Initialize();
end;

function TApplication_IsRightToLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsRightToLeft: Boolean;

  Result := TApplication(AObj).IsRightToLeft();
end;

function TApplication_Minimize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Minimize;

  TApplication(AObj).Minimize();
end;

function TApplication_ModalStarted_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ModalStarted;

  TApplication(AObj).ModalStarted();
end;

function TApplication_ModalFinished_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ModalFinished;

  TApplication(AObj).ModalFinished();
end;

function TApplication_NormalizeAllTopMosts_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NormalizeAllTopMosts;

  TApplication(AObj).NormalizeAllTopMosts();
end;

function TApplication_NormalizeTopMosts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure NormalizeTopMosts;

  TApplication(AObj).NormalizeTopMosts();
end;

function TApplication_ProcessMessages_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ProcessMessages;

  TApplication(AObj).ProcessMessages();
end;

function TApplication_RemovePopupForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RemovePopupForm(APopupForm: TCustomForm);

  TApplication(AObj).RemovePopupForm(TCustomForm_sw.FromVar(AArgs[0]));
end;

function TApplication_Restore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Restore;

  TApplication(AObj).Restore();
end;

function TApplication_RestoreTopMosts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure RestoreTopMosts;

  TApplication(AObj).RestoreTopMosts();
end;

function TApplication_Run_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Run;

  TApplication(AObj).Run();
end;

function TApplication_ShowException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowException(E: Exception);

  TApplication(AObj).ShowException(Exception_sw.FromVar(AArgs[0]));
end;

function TApplication_Terminate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Terminate;

  TApplication(AObj).Terminate();
end;

function TApplication_UnhookMainWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnhookMainWindow(Hook: TWindowHook);

  TApplication(AObj).UnhookMainWindow(TWindowHook_sw.FromVar(AArgs[0]));
end;

function TApplication_UnhookSynchronizeWakeup_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UnhookSynchronizeWakeup;

  TApplication(AObj).UnhookSynchronizeWakeup();
end;

function TApplication_UpdateAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UpdateAction(Action: TBasicAction): Boolean;

  Result := TApplication(AObj).UpdateAction(TBasicAction_sw.FromVar(AArgs[0]));
end;

function TApplication_UseRightToLeftAlignment_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftAlignment: Boolean;

  Result := TApplication(AObj).UseRightToLeftAlignment();
end;

function TApplication_UseRightToLeftReading_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftReading: Boolean;

  Result := TApplication(AObj).UseRightToLeftReading();
end;

function TApplication_UseRightToLeftScrollBar_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function UseRightToLeftScrollBar: Boolean;

  Result := TApplication(AObj).UseRightToLeftScrollBar();
end;

function TApplication_UseMetropolisUI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure UseMetropolisUI;

  TApplication(AObj).UseMetropolisUI();
end;

function TApplication_Active_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Active: Boolean read <getter>;

  Result := TApplication(AObj).Active;
end;

function TApplication_ActionUpdateDelay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActionUpdateDelay: Integer read <getter> write <...

  if IsGet then
    Result := TApplication(AObj).ActionUpdateDelay
  else
    TApplication(AObj).ActionUpdateDelay := Integer(AArgs[0]);
end;

function TApplication_ActiveFormHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ActiveFormHandle: HWND read <getter>;

  Result := HWND_sw.ToVar(TApplication(AObj).ActiveFormHandle);
end;

function TApplication_AllowTesting_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowTesting: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).AllowTesting
  else
    TApplication(AObj).AllowTesting := Boolean(AArgs[0]);
end;

function TApplication_AutoDragDocking_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AutoDragDocking: Boolean read <getter> write <se...

  if IsGet then
    Result := TApplication(AObj).AutoDragDocking
  else
    TApplication(AObj).AutoDragDocking := Boolean(AArgs[0]);
end;

function TApplication_CurrentHelpFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CurrentHelpFile: string read <getter>;

  Result := TApplication(AObj).CurrentHelpFile;
end;

function TApplication_DefaultFont_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultFont: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TApplication(AObj).DefaultFont)
  else
    TApplication(AObj).DefaultFont := TFont_sw.FromVar(AArgs[0]);
end;

function TApplication_DialogHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DialogHandle: HWnd read <getter> write <setter>;

  if IsGet then
    Result := HWnd_sw.ToVar(TApplication(AObj).DialogHandle)
  else
    TApplication(AObj).DialogHandle := HWnd_sw.FromVar(AArgs[0]);
end;

function TApplication_EnumAllWindowsOnActivateHint_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property EnumAllWindowsOnActivateHint: Boolean read <gett...

  if IsGet then
    Result := TApplication(AObj).EnumAllWindowsOnActivateHint
  else
    TApplication(AObj).EnumAllWindowsOnActivateHint := Boolean(AArgs[0]);
end;

function TApplication_ExeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ExeName: string read <getter>;

  Result := TApplication(AObj).ExeName;
end;

function TApplication_HelpFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpFile: string read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).HelpFile
  else
    TApplication(AObj).HelpFile := string(AArgs[0]);
end;

function TApplication_Hint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Hint: string read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).Hint
  else
    TApplication(AObj).Hint := string(AArgs[0]);
end;

function TApplication_HintColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintColor: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TApplication(AObj).HintColor)
  else
    TApplication(AObj).HintColor := TColor_sw.FromVar(AArgs[0]);
end;

function TApplication_HintHidePause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintHidePause: Integer read <getter> write <sett...

  if IsGet then
    Result := TApplication(AObj).HintHidePause
  else
    TApplication(AObj).HintHidePause := Integer(AArgs[0]);
end;

function TApplication_HintPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintPause: Integer read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).HintPause
  else
    TApplication(AObj).HintPause := Integer(AArgs[0]);
end;

function TApplication_HintShortCuts_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintShortCuts: Boolean read <getter> write <sett...

  if IsGet then
    Result := TApplication(AObj).HintShortCuts
  else
    TApplication(AObj).HintShortCuts := Boolean(AArgs[0]);
end;

function TApplication_HintShortPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HintShortPause: Integer read <getter> write <set...

  if IsGet then
    Result := TApplication(AObj).HintShortPause
  else
    TApplication(AObj).HintShortPause := Integer(AArgs[0]);
end;

function TApplication_Icon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Icon: TIcon read <getter> write <setter>;

  if IsGet then
    Result := TIcon_sw.ToVar(TApplication(AObj).Icon)
  else
    TApplication(AObj).Icon := TIcon_sw.FromVar(AArgs[0]);
end;

function TApplication_IsMetropolisUI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property IsMetropolisUI: Boolean read <getter>;

  Result := TApplication(AObj).IsMetropolisUI;
end;

function TApplication_MainForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MainForm: TForm read <getter>;

  Result := TForm_sw.ToVar(TApplication(AObj).MainForm);
end;

function TApplication_MainFormHandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MainFormHandle: HWND read <getter>;

  Result := HWND_sw.ToVar(TApplication(AObj).MainFormHandle);
end;

function TApplication_MainFormOnTaskBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MainFormOnTaskBar: Boolean read <getter> write <...

  if IsGet then
    Result := TApplication(AObj).MainFormOnTaskBar
  else
    TApplication(AObj).MainFormOnTaskBar := Boolean(AArgs[0]);
end;

function TApplication_ModalLevel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalLevel: Integer read <getter>;

  Result := TApplication(AObj).ModalLevel;
end;

function TApplication_ModalPopupMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ModalPopupMode: TPopupMode read <getter> write <...

  if IsGet then
    Result := TPopupMode_sw.ToVar(TApplication(AObj).ModalPopupMode)
  else
    TApplication(AObj).ModalPopupMode := TPopupMode_sw.FromVar(AArgs[0]);
end;

function TApplication_BiDiMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiMode: TBiDiMode read <getter> write <setter>;

  if IsGet then
    Result := TBiDiMode_sw.ToVar(TApplication(AObj).BiDiMode)
  else
    TApplication(AObj).BiDiMode := TBiDiMode_sw.FromVar(AArgs[0]);
end;

function TApplication_BiDiKeyboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BiDiKeyboard: string read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).BiDiKeyboard
  else
    TApplication(AObj).BiDiKeyboard := string(AArgs[0]);
end;

function TApplication_NonBiDiKeyboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NonBiDiKeyboard: string read <getter> write <set...

  if IsGet then
    Result := TApplication(AObj).NonBiDiKeyboard
  else
    TApplication(AObj).NonBiDiKeyboard := string(AArgs[0]);
end;

function TApplication_ShowHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowHint: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).ShowHint
  else
    TApplication(AObj).ShowHint := Boolean(AArgs[0]);
end;

function TApplication_ShowMainForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ShowMainForm: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).ShowMainForm
  else
    TApplication(AObj).ShowMainForm := Boolean(AArgs[0]);
end;

function TApplication_Terminated_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Terminated: Boolean read <getter>;

  Result := TApplication(AObj).Terminated;
end;

function TApplication_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TApplication(AObj).Title
  else
    TApplication(AObj).Title := string(AArgs[0]);
end;

function TApplication_UpdateFormatSettings_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdateFormatSettings: Boolean read <getter> writ...

  if IsGet then
    Result := TApplication(AObj).UpdateFormatSettings
  else
    TApplication(AObj).UpdateFormatSettings := Boolean(AArgs[0]);
end;

function TApplication_UpdateMetricSettings_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property UpdateMetricSettings: Boolean read <getter> writ...

  if IsGet then
    Result := TApplication(AObj).UpdateMetricSettings
  else
    TApplication(AObj).UpdateMetricSettings := Boolean(AArgs[0]);
end;

function TApplication_OnActionExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActionExecute: TActionEvent read <getter> writ...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TApplication(AObj).OnActionExecute)
  else
    TApplication(AObj).OnActionExecute := TActionEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnActionUpdate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActionUpdate: TActionEvent read <getter> write...

  if IsGet then
    Result := TActionEvent_sw.ToVar(TApplication(AObj).OnActionUpdate)
  else
    TApplication(AObj).OnActionUpdate := TActionEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnActivate: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnActivate)
  else
    TApplication(AObj).OnActivate := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnDeactivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDeactivate: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnDeactivate)
  else
    TApplication(AObj).OnDeactivate := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnException_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnException: TExceptionEvent read <getter> write...

  if IsGet then
    Result := TExceptionEvent_sw.ToVar(TApplication(AObj).OnException)
  else
    TApplication(AObj).OnException := TExceptionEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnGetActiveFormHandle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetActiveFormHandle: TGetHandleEvent read <get...

  if IsGet then
    Result := TGetHandleEvent_sw.ToVar(TApplication(AObj).OnGetActiveFormHandle)
  else
    TApplication(AObj).OnGetActiveFormHandle := TGetHandleEvent_sw.FromVar(
      AArgs[0]);
end;

function TApplication_OnGetMainFormHandle_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnGetMainFormHandle: TGetHandleEvent read <gette...

  if IsGet then
    Result := TGetHandleEvent_sw.ToVar(TApplication(AObj).OnGetMainFormHandle)
  else
    TApplication(AObj).OnGetMainFormHandle := TGetHandleEvent_sw.FromVar(
      AArgs[0]);
end;

function TApplication_OnIdle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnIdle: TIdleEvent read <getter> write <setter>;

  if IsGet then
    Result := TIdleEvent_sw.ToVar(TApplication(AObj).OnIdle)
  else
    TApplication(AObj).OnIdle := TIdleEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHelp: THelpEvent read <getter> write <setter>;

  if IsGet then
    Result := THelpEvent_sw.ToVar(TApplication(AObj).OnHelp)
  else
    TApplication(AObj).OnHelp := THelpEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnHint: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnHint)
  else
    TApplication(AObj).OnHint := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMessage: TMessageEvent read <getter> write <se...

  if IsGet then
    Result := TMessageEvent_sw.ToVar(TApplication(AObj).OnMessage)
  else
    TApplication(AObj).OnMessage := TMessageEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnMinimize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnMinimize: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnMinimize)
  else
    TApplication(AObj).OnMinimize := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnModalBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnModalBegin: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnModalBegin)
  else
    TApplication(AObj).OnModalBegin := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnModalEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnModalEnd: TNotifyEvent read <getter> write <se...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnModalEnd)
  else
    TApplication(AObj).OnModalEnd := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnRestore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnRestore: TNotifyEvent read <getter> write <set...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TApplication(AObj).OnRestore)
  else
    TApplication(AObj).OnRestore := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnShowHint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShowHint: TShowHintEvent read <getter> write <...

  if IsGet then
    Result := TShowHintEvent_sw.ToVar(TApplication(AObj).OnShowHint)
  else
    TApplication(AObj).OnShowHint := TShowHintEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnShortCut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShortCut: TShortCutEvent read <getter> write <...

  if IsGet then
    Result := TShortCutEvent_sw.ToVar(TApplication(AObj).OnShortCut)
  else
    TApplication(AObj).OnShortCut := TShortCutEvent_sw.FromVar(AArgs[0]);
end;

function TApplication_OnSettingChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSettingChange: TSettingChangeEvent read <gette...

  if IsGet then
    Result := TSettingChangeEvent_sw.ToVar(TApplication(AObj).OnSettingChange)
  else
    TApplication(AObj).OnSettingChange := TSettingChangeEvent_sw.FromVar(
      AArgs[0]);
end;

function TApplication_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWnd read <getter> write <setter>;

  if IsGet then
    Result := HWnd_sw.ToVar(TApplication(AObj).Handle)
  else
    TApplication(AObj).Handle := HWnd_sw.FromVar(AArgs[0]);
end;

function TApplication_PopupControlWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PopupControlWnd: HWND read <getter>;

  Result := HWND_sw.ToVar(TApplication(AObj).PopupControlWnd);
end;

class function TApplication_sw.GetTypeName: WideString;
begin
  Result := 'TApplication';
end;

class function TApplication_sw.GetWrappedClass: TClass;
begin
  Result := TApplication;
end;

class procedure TApplication_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('ActivateHint', TApplication_ActivateHint_si, 1, False);
  AData.AddProcedure('ApplyBiDiKeyboardLayout', TApplication_ApplyBiDiKeyboardLayout_si, 0, False);
  AData.AddProcedure('ApplyNonBiDiKeyboardLayout', TApplication_ApplyNonBiDiKeyboardLayout_si, 0, False);
  AData.AddFunction('AddPopupForm', TApplication_AddPopupForm_si, Integer_sw, 1, False);
  AData.AddProcedure('BringToFront', TApplication_BringToFront_si, 0, False);
  AData.AddProcedure('ControlDestroyed', TApplication_ControlDestroyed_si, 1, False);
  AData.AddProcedure('CancelHint', TApplication_CancelHint_si, 0, False);
  AData.AddProcedure('CreateHandle', TApplication_CreateHandle_si, 0, False);
  AData.AddProcedure('DoApplicationIdle', TApplication_DoApplicationIdle_si, 0, False);
  AData.AddFunction('ExecuteAction', TApplication_ExecuteAction_si, Boolean_sw, 1, False);
  AData.AddProcedure('HandleException', TApplication_HandleException_si, 1, False);
  AData.AddProcedure('HandleMessage', TApplication_HandleMessage_si, 0, False);
  AData.AddFunction('HelpCommand', TApplication_HelpCommand_si, Boolean_sw, 2, False);
  AData.AddFunction('HelpContext', TApplication_HelpContext_si, Boolean_sw, 1, False);
  AData.AddFunction('HelpJump', TApplication_HelpJump_si, Boolean_sw, 1, False);
  AData.AddFunction('HelpKeyword', TApplication_HelpKeyword_si, Boolean_sw, 1, False);
  AData.AddFunction('HelpShowTableOfContents', TApplication_HelpShowTableOfContents_si, Boolean_sw, 0, False);
  AData.AddProcedure('HideHint', TApplication_HideHint_si, 0, False);
  AData.AddProcedure('HintMouseMessage', TApplication_HintMouseMessage_si, 2, False);
  AData.AddProcedure('HookMainWindow', TApplication_HookMainWindow_si, 1, False);
  AData.AddProcedure('HookSynchronizeWakeup', TApplication_HookSynchronizeWakeup_si, 0, False);
  AData.AddProcedure('Initialize', TApplication_Initialize_si, 0, False);
  AData.AddFunction('IsRightToLeft', TApplication_IsRightToLeft_si, Boolean_sw, 0, False);
  AData.AddProcedure('Minimize', TApplication_Minimize_si, 0, False);
  AData.AddProcedure('ModalStarted', TApplication_ModalStarted_si, 0, False);
  AData.AddProcedure('ModalFinished', TApplication_ModalFinished_si, 0, False);
  AData.AddProcedure('NormalizeAllTopMosts', TApplication_NormalizeAllTopMosts_si, 0, False);
  AData.AddProcedure('NormalizeTopMosts', TApplication_NormalizeTopMosts_si, 0, False);
  AData.AddProcedure('ProcessMessages', TApplication_ProcessMessages_si, 0, False);
  AData.AddProcedure('RemovePopupForm', TApplication_RemovePopupForm_si, 1, False);
  AData.AddProcedure('Restore', TApplication_Restore_si, 0, False);
  AData.AddProcedure('RestoreTopMosts', TApplication_RestoreTopMosts_si, 0, False);
  AData.AddProcedure('Run', TApplication_Run_si, 0, False);
  AData.AddProcedure('ShowException', TApplication_ShowException_si, 1, False);
  AData.AddProcedure('Terminate', TApplication_Terminate_si, 0, False);
  AData.AddProcedure('UnhookMainWindow', TApplication_UnhookMainWindow_si, 1, False);
  AData.AddProcedure('UnhookSynchronizeWakeup', TApplication_UnhookSynchronizeWakeup_si, 0, False);
  AData.AddFunction('UpdateAction', TApplication_UpdateAction_si, Boolean_sw, 1, False);
  AData.AddFunction('UseRightToLeftAlignment', TApplication_UseRightToLeftAlignment_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftReading', TApplication_UseRightToLeftReading_si, Boolean_sw, 0, False);
  AData.AddFunction('UseRightToLeftScrollBar', TApplication_UseRightToLeftScrollBar_si, Boolean_sw, 0, False);
  AData.AddProcedure('UseMetropolisUI', TApplication_UseMetropolisUI_si, 0, False);
  AData.AddProperty('Active', TApplication_Active_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('ActionUpdateDelay', TApplication_ActionUpdateDelay_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('ActiveFormHandle', TApplication_ActiveFormHandle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('AllowTesting', TApplication_AllowTesting_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('AutoDragDocking', TApplication_AutoDragDocking_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('CurrentHelpFile', TApplication_CurrentHelpFile_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('DefaultFont', TApplication_DefaultFont_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('DialogHandle', TApplication_DialogHandle_si, HWnd_sw, True, True, 0, False, False);
  AData.AddProperty('EnumAllWindowsOnActivateHint', TApplication_EnumAllWindowsOnActivateHint_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ExeName', TApplication_ExeName_si, string_sw, True, False, 0, False, False);
  AData.AddProperty('HelpFile', TApplication_HelpFile_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Hint', TApplication_Hint_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('HintColor', TApplication_HintColor_si, TColor_sw, True, True, 0, False, False);
  AData.AddProperty('HintHidePause', TApplication_HintHidePause_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('HintPause', TApplication_HintPause_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('HintShortCuts', TApplication_HintShortCuts_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HintShortPause', TApplication_HintShortPause_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Icon', TApplication_Icon_si, TIcon_sw, True, True, 0, False, False);
  AData.AddProperty('IsMetropolisUI', TApplication_IsMetropolisUI_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('MainForm', TApplication_MainForm_si, TForm_sw, True, False, 0, False, False);
  AData.AddProperty('MainFormHandle', TApplication_MainFormHandle_si, HWND_sw, True, False, 0, False, False);
  AData.AddProperty('MainFormOnTaskBar', TApplication_MainFormOnTaskBar_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ModalLevel', TApplication_ModalLevel_si, Integer_sw, True, False, 0, False, False);
  AData.AddProperty('ModalPopupMode', TApplication_ModalPopupMode_si, TPopupMode_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiMode', TApplication_BiDiMode_si, TBiDiMode_sw, True, True, 0, False, False);
  AData.AddProperty('BiDiKeyboard', TApplication_BiDiKeyboard_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('NonBiDiKeyboard', TApplication_NonBiDiKeyboard_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('ShowHint', TApplication_ShowHint_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('ShowMainForm', TApplication_ShowMainForm_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Terminated', TApplication_Terminated_si, Boolean_sw, True, False, 0, False, False);
  AData.AddProperty('Title', TApplication_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('UpdateFormatSettings', TApplication_UpdateFormatSettings_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('UpdateMetricSettings', TApplication_UpdateMetricSettings_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('OnActionExecute', TApplication_OnActionExecute_si, TActionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnActionUpdate', TApplication_OnActionUpdate_si, TActionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnActivate', TApplication_OnActivate_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDeactivate', TApplication_OnDeactivate_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnException', TApplication_OnException_si, TExceptionEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetActiveFormHandle', TApplication_OnGetActiveFormHandle_si, TGetHandleEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnGetMainFormHandle', TApplication_OnGetMainFormHandle_si, TGetHandleEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnIdle', TApplication_OnIdle_si, TIdleEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnHelp', TApplication_OnHelp_si, THelpEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnHint', TApplication_OnHint_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMessage', TApplication_OnMessage_si, TMessageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnMinimize', TApplication_OnMinimize_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnModalBegin', TApplication_OnModalBegin_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnModalEnd', TApplication_OnModalEnd_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnRestore', TApplication_OnRestore_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShowHint', TApplication_OnShowHint_si, TShowHintEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShortCut', TApplication_OnShortCut_si, TShortCutEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSettingChange', TApplication_OnSettingChange_si, TSettingChangeEvent_sw, True, True, 0, False, False);
  AData.AddProperty('Handle', TApplication_Handle_si, HWnd_sw, True, True, 0, False, False);
  AData.AddProperty('PopupControlWnd', TApplication_PopupControlWnd_si, HWND_sw, True, False, 0, False, False);
end;

class function TApplication_sw.ToVar(const AValue: TApplication): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TApplication_sw.FromVar(const AValue: OleVariant): TApplication;
begin
  Result := TApplication(ConvFromVar(AValue, TApplication));
end;

class function TApplication_sw.ClassToVar(AClass: TApplication_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TApplication_sw.ClassFromVar(
  const AClass: OleVariant): TApplication_sc;
begin
  Result := TApplication_sc(ConvClsFromVar(AClass, TApplication));
end;

{ Forms_sw }

function Forms_caNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const caNone = <value>;

  Result := TCloseAction_sw.ToVar(caNone);
end;

function Forms_caHide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const caHide = <value>;

  Result := TCloseAction_sw.ToVar(caHide);
end;

function Forms_caFree_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const caFree = <value>;

  Result := TCloseAction_sw.ToVar(caFree);
end;

function Forms_caMinimize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const caMinimize = <value>;

  Result := TCloseAction_sw.ToVar(caMinimize);
end;

function Forms_wsNormal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const wsNormal = <value>;

  Result := TWindowState_sw.ToVar(wsNormal);
end;

function Forms_wsMinimized_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const wsMinimized = <value>;

  Result := TWindowState_sw.ToVar(wsMinimized);
end;

function Forms_wsMaximized_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const wsMaximized = <value>;

  Result := TWindowState_sw.ToVar(wsMaximized);
end;

function Forms_biSystemMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const biSystemMenu = <value>;

  Result := TBorderIcon_sw.ToVar(biSystemMenu);
end;

function Forms_biMinimize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const biMinimize = <value>;

  Result := TBorderIcon_sw.ToVar(biMinimize);
end;

function Forms_biMaximize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const biMaximize = <value>;

  Result := TBorderIcon_sw.ToVar(biMaximize);
end;

function Forms_biHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const biHelp = <value>;

  Result := TBorderIcon_sw.ToVar(biHelp);
end;

function Forms_TScrollBarKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollBarKind = (sbHorizontal, sbVertical);

  Result := TLMDUnitWrapper.TypeToVar(TScrollBarKind_sw);
end;

function Forms_TScrollBarInc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollBarInc = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TScrollBarInc_sw);
end;

function Forms_TScrollBarStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollBarStyle = (ssRegular, ssFlat, ssHotTrack);

  Result := TLMDUnitWrapper.TypeToVar(TScrollBarStyle_sw);
end;

function Forms_TControlScrollBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlScrollBar = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TControlScrollBar_sw);
end;

function Forms_TWindowState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowState = System.UITypes.TWindowState;

  Result := TLMDUnitWrapper.TypeToVar(TWindowState_sw);
end;

function Forms_TScrollingWinControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollingWinControl = class(TWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TScrollingWinControl_sw);
end;

function Forms_TFormBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFormBorderStyle = (bsNone, bsSingle, bsSizeable, bs...

  Result := TLMDUnitWrapper.TypeToVar(TFormBorderStyle_sw);
end;

function Forms_TBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderStyle = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TBorderStyle_sw);
end;

function Forms_TScrollBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollBox = class(TScrollingWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TScrollBox_sw);
end;

function Forms_TCustomFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFrame = class(TScrollingWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomFrame_sw);
end;

function Forms_TCustomFrameClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFrameClass = class of TCustomFrame;

  Result := TLMDUnitWrapper.TypeToVar(TCustomFrameClass_sw);
end;

function Forms_TFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFrame = class(TCustomFrame);

  Result := TLMDUnitWrapper.TypeToVar(TFrame_sw);
end;

function Forms_THelpEventData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpEventData = NativeInt;

  Result := TLMDUnitWrapper.TypeToVar(THelpEventData_sw);
end;

function Forms_TPopupWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupWnd = record;

  Result := TLMDUnitWrapper.TypeToVar(TPopupWnd_sw);
end;

function Forms_TBorderIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderIcon = System.UITypes.TBorderIcon;

  Result := TLMDUnitWrapper.TypeToVar(TBorderIcon_sw);
end;

function Forms_TBorderIcons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderIcons = System.UITypes.TBorderIcons;

  Result := TLMDUnitWrapper.TypeToVar(TBorderIcons_sw);
end;

function Forms_TFormStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFormStyle = (fsNormal, fsMDIChild, fsMDIForm, fsSta...

  Result := TLMDUnitWrapper.TypeToVar(TFormStyle_sw);
end;

function Forms_TPosition_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPosition = (poDesigned, poDefault, poDefaultPosOnly...

  Result := TLMDUnitWrapper.TypeToVar(TPosition_sw);
end;

function Forms_TDefaultMonitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDefaultMonitor = (dmDesktop, dmPrimary, dmMainForm,...

  Result := TLMDUnitWrapper.TypeToVar(TDefaultMonitor_sw);
end;

function Forms_TPrintScale_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintScale = (poNone, poProportional, poPrintToFit);

  Result := TLMDUnitWrapper.TypeToVar(TPrintScale_sw);
end;

function Forms_TShowAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShowAction = (saIgnore, saRestore, saMinimize, saMa...

  Result := TLMDUnitWrapper.TypeToVar(TShowAction_sw);
end;

function Forms_TTileMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTileMode = (tbHorizontal, tbVertical);

  Result := TLMDUnitWrapper.TypeToVar(TTileMode_sw);
end;

function Forms_TCloseAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCloseAction = System.UITypes.TCloseAction;

  Result := TLMDUnitWrapper.TypeToVar(TCloseAction_sw);
end;

function Forms_TCloseEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCloseEvent = procedure (Sender: TObject; var Action...

  Result := TLMDUnitWrapper.TypeToVar(TCloseEvent_sw);
end;

function Forms_TCloseQueryEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCloseQueryEvent = procedure (Sender: TObject; var C...

  Result := TLMDUnitWrapper.TypeToVar(TCloseQueryEvent_sw);
end;

function Forms_TShortCutEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShortCutEvent = procedure (var Msg: TWMKey; var Han...

  Result := TLMDUnitWrapper.TypeToVar(TShortCutEvent_sw);
end;

function Forms_THelpEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THelpEvent = function (Command: Word; Data: THelpEve...

  Result := TLMDUnitWrapper.TypeToVar(THelpEvent_sw);
end;

function Forms_TMonitorDpiChangedEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonitorDpiChangedEvent = procedure (Sender: TObject...

  Result := TLMDUnitWrapper.TypeToVar(TMonitorDpiChangedEvent_sw);
end;

function Forms_TPopupMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupMode = (pmNone, pmAuto, pmExplicit);

  Result := TLMDUnitWrapper.TypeToVar(TPopupMode_sw);
end;

function Forms_TGlassFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGlassFrame = class(TPersistent);

  Result := TLMDUnitWrapper.TypeToVar(TGlassFrame_sw);
end;

function Forms_TCustomForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomForm = class(TScrollingWinControl);

  Result := TLMDUnitWrapper.TypeToVar(TCustomForm_sw);
end;

function Forms_TCustomFormClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomFormClass = class of TCustomForm;

  Result := TLMDUnitWrapper.TypeToVar(TCustomFormClass_sw);
end;

function Forms_TActiveFormBorderStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TActiveFormBorderStyle = (afbNone, afbSingle, afbSun...

  Result := TLMDUnitWrapper.TypeToVar(TActiveFormBorderStyle_sw);
end;

function Forms_TCustomActiveForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomActiveForm = class(TCustomForm);

  Result := TLMDUnitWrapper.TypeToVar(TCustomActiveForm_sw);
end;

function Forms_TForm_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type TForm = class(TCustomForm);

  Result := TLMDUnitWrapper.TypeToVar(TForm_sw);
end;

function Forms_TFormClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFormClass = class of TForm;

  Result := TLMDUnitWrapper.TypeToVar(TFormClass_sw);
end;

function Forms_TCustomDockForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomDockForm = class(TCustomForm);

  Result := TLMDUnitWrapper.TypeToVar(TCustomDockForm_sw);
end;

function Forms_TMonitor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonitor = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TMonitor_sw);
end;

function Forms_TCursorRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursorRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TCursorRec_sw);
end;

function Forms_TMonitorDefaultTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMonitorDefaultTo = (mdNearest, mdNull, mdPrimary);

  Result := TLMDUnitWrapper.TypeToVar(TMonitorDefaultTo_sw);
end;

function Forms_TScreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScreen = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TScreen_sw);
end;

function Forms_TTimerMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTimerMode = (tmShow, tmHide);

  Result := TLMDUnitWrapper.TypeToVar(TTimerMode_sw);
end;

function Forms_THintInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THintInfo = Vcl.Controls.THintInfo;

  Result := TLMDUnitWrapper.TypeToVar(THintInfo_sw);
end;

function Forms_TCMHintShowPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCMHintShowPause = record;

  Result := TLMDUnitWrapper.TypeToVar(TCMHintShowPause_sw);
end;

function Forms_TPopupForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPopupForm = record;

  Result := TLMDUnitWrapper.TypeToVar(TPopupForm_sw);
end;

function Forms_TMessageEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMessageEvent = procedure (var Msg: TMsg; var Handle...

  Result := TLMDUnitWrapper.TypeToVar(TMessageEvent_sw);
end;

function Forms_TExceptionEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExceptionEvent = procedure (Sender: TObject; E: Exc...

  Result := TLMDUnitWrapper.TypeToVar(TExceptionEvent_sw);
end;

function Forms_TGetHandleEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetHandleEvent = procedure (var Handle: HWND) of ob...

  Result := TLMDUnitWrapper.TypeToVar(TGetHandleEvent_sw);
end;

function Forms_TIdleEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIdleEvent = procedure (Sender: TObject; var Done: B...

  Result := TLMDUnitWrapper.TypeToVar(TIdleEvent_sw);
end;

function Forms_TShowHintEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShowHintEvent = procedure (var HintStr: string; var...

  Result := TLMDUnitWrapper.TypeToVar(TShowHintEvent_sw);
end;

function Forms_TWindowHook_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowHook = function (var Message: TMessage): Bool...

  Result := TLMDUnitWrapper.TypeToVar(TWindowHook_sw);
end;

function Forms_TSettingChangeEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSettingChangeEvent = procedure (Sender: TObject; Fl...

  Result := TLMDUnitWrapper.TypeToVar(TSettingChangeEvent_sw);
end;

function Forms_TApplication_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TApplication = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TApplication_sw);
end;

function Forms_Application_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Application: TApplication;

  if IsGet then
    Result := TApplication_sw.ToVar(Vcl.Forms.Application)
  else
    Vcl.Forms.Application := TApplication_sw.FromVar(AArgs[0]);
end;

function Forms_Screen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Screen: TScreen;

  if IsGet then
    Result := TScreen_sw.ToVar(Vcl.Forms.Screen)
  else
    Vcl.Forms.Screen := TScreen_sw.FromVar(AArgs[0]);
end;

function Forms_HintWindowClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HintWindowClass: THintWindowClass;

  if IsGet then
    Result := THintWindowClass_sw.ToVar(Vcl.Forms.HintWindowClass)
  else
    Vcl.Forms.HintWindowClass := THintWindowClass_sw.FromVar(AArgs[0]);
end;

function Forms_GetParentForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetParentForm(Control: TControl; TopForm: Boolea...

  case AArgsSize of
    1:
    begin
      Result := TCustomForm_sw.ToVar(Vcl.Forms.GetParentForm(TControl_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TCustomForm_sw.ToVar(Vcl.Forms.GetParentForm(TControl_sw.
        FromVar(AArgs[0]), Boolean(AArgs[1])));
    end;
  else
    WrongArgCountError('GetParentForm');
  end;
end;

function Forms_ValidParentForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ValidParentForm(Control: TControl; TopForm: Bool...

  case AArgsSize of
    1:
    begin
      Result := TCustomForm_sw.ToVar(Vcl.Forms.ValidParentForm(TControl_sw.
        FromVar(AArgs[0])));
    end;
    2:
    begin
      Result := TCustomForm_sw.ToVar(Vcl.Forms.ValidParentForm(TControl_sw.
        FromVar(AArgs[0]), Boolean(AArgs[1])));
    end;
  else
    WrongArgCountError('ValidParentForm');
  end;
end;

function Forms_Subclass3DWnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Subclass3DWnd(Wnd: HWnd): Boolean;

  Result := Vcl.Forms.Subclass3DWnd(HWnd_sw.FromVar(AArgs[0]));
end;

function Forms_Subclass3DDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure Subclass3DDlg(Wnd: HWnd; Flags: Word);

  Vcl.Forms.Subclass3DDlg(HWnd_sw.FromVar(AArgs[0]), Word(AArgs[1]));
end;

function Forms_SetAutoSubClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetAutoSubClass(Enable: Boolean);

  Vcl.Forms.SetAutoSubClass(Boolean(AArgs[0]));
end;

function Forms_DoneCtl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DoneCtl3D;

  Vcl.Forms.DoneCtl3D();
end;

function Forms_InitCtl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure InitCtl3D;

  Vcl.Forms.InitCtl3D();
end;

function Forms_IsAccel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAccel(VK: Word; const Str: string): Boolean;

  Result := Vcl.Forms.IsAccel(Word(AArgs[0]), string(AArgs[1]));
end;

function Forms_ForegroundTask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ForegroundTask: Boolean;

  Result := Vcl.Forms.ForegroundTask();
end;

class function Forms_sw.GetUnitName: WideString;
begin
  Result := 'Forms';
end;

class procedure Forms_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('caNone', Forms_caNone_si, TCloseAction_sw);
  AData.AddConstant('caHide', Forms_caHide_si, TCloseAction_sw);
  AData.AddConstant('caFree', Forms_caFree_si, TCloseAction_sw);
  AData.AddConstant('caMinimize', Forms_caMinimize_si, TCloseAction_sw);
  AData.AddConstant('wsNormal', Forms_wsNormal_si, TWindowState_sw);
  AData.AddConstant('wsMinimized', Forms_wsMinimized_si, TWindowState_sw);
  AData.AddConstant('wsMaximized', Forms_wsMaximized_si, TWindowState_sw);
  AData.AddConstant('biSystemMenu', Forms_biSystemMenu_si, TBorderIcon_sw);
  AData.AddConstant('biMinimize', Forms_biMinimize_si, TBorderIcon_sw);
  AData.AddConstant('biMaximize', Forms_biMaximize_si, TBorderIcon_sw);
  AData.AddConstant('biHelp', Forms_biHelp_si, TBorderIcon_sw);
  AData.AddType(TScrollBarKind_sw, Forms_TScrollBarKind_si);
  AData.AddType(TScrollBarInc_sw, Forms_TScrollBarInc_si);
  AData.AddType(TScrollBarStyle_sw, Forms_TScrollBarStyle_si);
  AData.AddType(TControlScrollBar_sw, Forms_TControlScrollBar_si);
  AData.AddType(TWindowState_sw, Forms_TWindowState_si);
  AData.AddType(TScrollingWinControl_sw, Forms_TScrollingWinControl_si);
  AData.AddType(TFormBorderStyle_sw, Forms_TFormBorderStyle_si);
  AData.AddType(TBorderStyle_sw, Forms_TBorderStyle_si);
  AData.AddType(TScrollBox_sw, Forms_TScrollBox_si);
  AData.AddType(TCustomFrame_sw, Forms_TCustomFrame_si);
  AData.AddType(TCustomFrameClass_sw, Forms_TCustomFrameClass_si);
  AData.AddType(TFrame_sw, Forms_TFrame_si);
  AData.AddType(THelpEventData_sw, Forms_THelpEventData_si);
  AData.AddType(TPopupWnd_sw, Forms_TPopupWnd_si);
  AData.AddType(TBorderIcon_sw, Forms_TBorderIcon_si);
  AData.AddType(TBorderIcons_sw, Forms_TBorderIcons_si);
  AData.AddType(TFormStyle_sw, Forms_TFormStyle_si);
  AData.AddType(TPosition_sw, Forms_TPosition_si);
  AData.AddType(TDefaultMonitor_sw, Forms_TDefaultMonitor_si);
  AData.AddType(TPrintScale_sw, Forms_TPrintScale_si);
  AData.AddType(TShowAction_sw, Forms_TShowAction_si);
  AData.AddType(TTileMode_sw, Forms_TTileMode_si);
  AData.AddType(TCloseAction_sw, Forms_TCloseAction_si);
  AData.AddType(TCloseEvent_sw, Forms_TCloseEvent_si);
  AData.AddType(TCloseQueryEvent_sw, Forms_TCloseQueryEvent_si);
  AData.AddType(TShortCutEvent_sw, Forms_TShortCutEvent_si);
  AData.AddType(THelpEvent_sw, Forms_THelpEvent_si);
  AData.AddType(TMonitorDpiChangedEvent_sw, Forms_TMonitorDpiChangedEvent_si);
  AData.AddType(TPopupMode_sw, Forms_TPopupMode_si);
  AData.AddType(TGlassFrame_sw, Forms_TGlassFrame_si);
  AData.AddType(TCustomForm_sw, Forms_TCustomForm_si);
  AData.AddType(TCustomFormClass_sw, Forms_TCustomFormClass_si);
  AData.AddType(TActiveFormBorderStyle_sw, Forms_TActiveFormBorderStyle_si);
  AData.AddType(TCustomActiveForm_sw, Forms_TCustomActiveForm_si);
  AData.AddType(TForm_sw, Forms_TForm_si);
  AData.AddType(TFormClass_sw, Forms_TFormClass_si);
  AData.AddType(TCustomDockForm_sw, Forms_TCustomDockForm_si);
  AData.AddType(TMonitor_sw, Forms_TMonitor_si);
  AData.AddType(TCursorRec_sw, Forms_TCursorRec_si);
  AData.AddType(TMonitorDefaultTo_sw, Forms_TMonitorDefaultTo_si);
  AData.AddType(TScreen_sw, Forms_TScreen_si);
  AData.AddType(TTimerMode_sw, Forms_TTimerMode_si);
  AData.AddType(THintInfo_sw, Forms_THintInfo_si);
  AData.AddType(TCMHintShowPause_sw, Forms_TCMHintShowPause_si);
  AData.AddType(TPopupForm_sw, Forms_TPopupForm_si);
  AData.AddType(TMessageEvent_sw, Forms_TMessageEvent_si);
  AData.AddType(TExceptionEvent_sw, Forms_TExceptionEvent_si);
  AData.AddType(TGetHandleEvent_sw, Forms_TGetHandleEvent_si);
  AData.AddType(TIdleEvent_sw, Forms_TIdleEvent_si);
  AData.AddType(TShowHintEvent_sw, Forms_TShowHintEvent_si);
  AData.AddType(TWindowHook_sw, Forms_TWindowHook_si);
  AData.AddType(TSettingChangeEvent_sw, Forms_TSettingChangeEvent_si);
  AData.AddType(TApplication_sw, Forms_TApplication_si);
  AData.AddVariable('Application', Forms_Application_si, TApplication_sw);
  AData.AddVariable('Screen', Forms_Screen_si, TScreen_sw);
  AData.AddVariable('HintWindowClass', Forms_HintWindowClass_si, THintWindowClass_sw);
  AData.AddFunction('GetParentForm', Forms_GetParentForm_si, TCustomForm_sw, 1, True);
  AData.AddFunction('ValidParentForm', Forms_ValidParentForm_si, TCustomForm_sw, 1, True);
  AData.AddFunction('Subclass3DWnd', Forms_Subclass3DWnd_si, Boolean_sw, 1, False);
  AData.AddProcedure('Subclass3DDlg', Forms_Subclass3DDlg_si, 2, False);
  AData.AddProcedure('SetAutoSubClass', Forms_SetAutoSubClass_si, 1, False);
  AData.AddProcedure('DoneCtl3D', Forms_DoneCtl3D_si, 0, False);
  AData.AddProcedure('InitCtl3D', Forms_InitCtl3D_si, 0, False);
  AData.AddFunction('IsAccel', Forms_IsAccel_si, Boolean_sw, 2, False);
  AData.AddFunction('ForegroundTask', Forms_ForegroundTask_si, Boolean_sw, 0, False);
end;

class function Forms_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Forms_sw);
end;

initialization
  RegisterUnitWrapper(Forms_sw);
  RegisterClassWrapper(TControlScrollBar_sw);
  RegisterClassWrapper(TScrollingWinControl_sw);
  RegisterClassWrapper(TScrollBox_sw);
  RegisterClassWrapper(TCustomFrame_sw);
  RegisterClassWrapper(TFrame_sw);
  RegisterClassWrapper(TGlassFrame_sw);
  RegisterClassWrapper(TCustomForm_sw);
  RegisterClassWrapper(TCustomActiveForm_sw);
  RegisterClassWrapper(TForm_sw);
  RegisterClassWrapper(TCustomDockForm_sw);
  RegisterClassWrapper(TMonitor_sw);
  RegisterClassWrapper(TScreen_sw);
  RegisterClassWrapper(TApplication_sw);
  RegisterEventWrapper(TypeInfo(TCloseEvent), TCloseEvent_sw);
  RegisterEventWrapper(TypeInfo(TCloseQueryEvent), TCloseQueryEvent_sw);
  RegisterEventWrapper(TypeInfo(TShortCutEvent), TShortCutEvent_sw);
  RegisterEventWrapper(TypeInfo(THelpEvent), THelpEvent_sw);
  RegisterEventWrapper(TypeInfo(TMonitorDpiChangedEvent), TMonitorDpiChangedEvent_sw);
  RegisterEventWrapper(TypeInfo(TMessageEvent), TMessageEvent_sw);
  RegisterEventWrapper(TypeInfo(TExceptionEvent), TExceptionEvent_sw);
  RegisterEventWrapper(TypeInfo(TGetHandleEvent), TGetHandleEvent_sw);
  RegisterEventWrapper(TypeInfo(TIdleEvent), TIdleEvent_sw);
  RegisterEventWrapper(TypeInfo(TShowHintEvent), TShowHintEvent_sw);
  RegisterEventWrapper(TypeInfo(TWindowHook), TWindowHook_sw);
  RegisterEventWrapper(TypeInfo(TSettingChangeEvent), TSettingChangeEvent_sw);

end.
