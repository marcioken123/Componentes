unit Dialogs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Dialogs' unit.
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
  LMDSctSysWrappers, Windows, Messages, SysUtils, CommDlg, Printers, Classes,
  Graphics, Controls, Forms, StdCtrls, Dialogs, Windows_LMDSW, Messages_LMDSW,
  SysUtils_LMDSW, CommDlg_LMDSW, Printers_LMDSW, Classes_LMDSW, Graphics_LMDSW,
  Controls_LMDSW, Forms_LMDSW, StdCtrls_LMDSW;


{ Type wrappers }

type
  TCommonDialog_sw = class;
  TOpenDialog_sw = class;
  TSaveDialog_sw = class;
  TColorDialog_sw = class;
  TFontDialog_sw = class;
  TPrinterSetupDialog_sw = class;
  TPrintDialog_sw = class;
  TPageSetupDialog_sw = class;
  TFindDialog_sw = class;
  TReplaceDialog_sw = class;

  TCommonDialog_sc = class of TCommonDialog;
  TCommonDialog_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCommonDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TCommonDialog;
    class function ClassToVar(AClass: TCommonDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCommonDialog_sc;
  end;

  TOpenOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TOpenOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenOption;
  end;

  TOpenOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TOpenOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenOptions;
  end;

  TOpenOptionEx_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TOpenOptionEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenOptionEx;
  end;

  TOpenOptionsEx_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TOpenOptionsEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenOptionsEx;
  end;

  TFileEditStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFileEditStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFileEditStyle;
  end;

  TOFNotifyEx_sw = class(CommDlg_LMDSW.TOFNotifyEx_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TOFNotifyEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TOFNotifyEx;
  end;

  TIncludeItemEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(const OFN: TOFNotifyEx; var Include: Boolean);
  end;

  TIncludeItemEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TIncludeItemEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TIncludeItemEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TIncludeItemEvent;
  end;

  TOpenDialog_sc = class of TOpenDialog;
  TOpenDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TOpenDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TOpenDialog;
    class function ClassToVar(AClass: TOpenDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TOpenDialog_sc;
  end;

  TSaveDialog_sc = class of TSaveDialog;
  TSaveDialog_sw = class(TOpenDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSaveDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TSaveDialog;
    class function ClassToVar(AClass: TSaveDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSaveDialog_sc;
  end;

  TColorDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColorDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialogOption;
  end;

  TColorDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TColorDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialogOptions;
  end;

  TColorDialog_sc = class of TColorDialog;
  TColorDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TColorDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorDialog;
    class function ClassToVar(AClass: TColorDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TColorDialog_sc;
  end;

  TFontDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogOption;
  end;

  TFontDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogOptions;
  end;

  TFontDialogDevice_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontDialogDevice): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialogDevice;
  end;

  TFDApplyEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Wnd: HWND);
  end;

  TFDApplyEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFDApplyEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TFDApplyEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TFDApplyEvent;
  end;

  TFontDialog_sc = class of TFontDialog;
  TFontDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFontDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontDialog;
    class function ClassToVar(AClass: TFontDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFontDialog_sc;
  end;

  TPrinterSetupDialog_sc = class of TPrinterSetupDialog;
  TPrinterSetupDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrinterSetupDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterSetupDialog;
    class function ClassToVar(AClass: TPrinterSetupDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrinterSetupDialog_sc;
  end;

  TPrintRange_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrintRange): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintRange;
  end;

  TPrintDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrintDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintDialogOption;
  end;

  TPrintDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TPrintDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintDialogOptions;
  end;

  TPrintDialog_sc = class of TPrintDialog;
  TPrintDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPrintDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrintDialog;
    class function ClassToVar(AClass: TPrintDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPrintDialog_sc;
  end;

  TPrinterOrientation_sw = Printers_LMDSW.TPrinterOrientation_sw;

  TPageSetupDialogOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageSetupDialogOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupDialogOption;
  end;

  TPageSetupDialogOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TPageSetupDialogOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupDialogOptions;
  end;

  TPrinterKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterKind;
  end;

  TPageType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageType): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageType;
  end;

  TPageSetupBeforePaintEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; const PaperSize: SmallInt;
      const Orientation: TPrinterOrientation; const PageType: TPageType;
      var DoneDrawing: Boolean);
  end;

  TPageSetupBeforePaintEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPageSetupBeforePaintEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupBeforePaintEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPageSetupBeforePaintEvent;
  end;

  TPageMeasureUnits_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageMeasureUnits): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageMeasureUnits;
  end;

  TPaintPageEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Canvas: TCanvas; PageRect: TRect;
      var DoneDrawing: Boolean);
  end;

  TPaintPageEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TPaintPageEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TPaintPageEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TPaintPageEvent;
  end;

  TPageSetupDialog_sc = class of TPageSetupDialog;
  TPageSetupDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPageSetupDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageSetupDialog;
    class function ClassToVar(AClass: TPageSetupDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPageSetupDialog_sc;
  end;

  TFindOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFindOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindOption;
  end;

  TFindOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFindOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindOptions;
  end;

  TFindDialog_sc = class of TFindDialog;
  TFindDialog_sw = class(TCommonDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFindDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TFindDialog;
    class function ClassToVar(AClass: TFindDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFindDialog_sc;
  end;

  TReplaceDialog_sc = class of TReplaceDialog;
  TReplaceDialog_sw = class(TFindDialog_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TReplaceDialog): OleVariant;
    class function FromVar(const AValue: OleVariant): TReplaceDialog;
    class function ClassToVar(AClass: TReplaceDialog_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TReplaceDialog_sc;
  end;

  TMsgDlgType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMsgDlgType): OleVariant;
    class function FromVar(const AValue: OleVariant): TMsgDlgType;
  end;

  TMsgDlgBtn_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TMsgDlgBtn): OleVariant;
    class function FromVar(const AValue: OleVariant): TMsgDlgBtn;
  end;

  TMsgDlgButtons_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TMsgDlgButtons): OleVariant;
    class function FromVar(const AValue: OleVariant): TMsgDlgButtons;
  end;


{ Unit wrapper }

type
  Dialogs_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TCommonDialog_sw }

function TCommonDialog_Execute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Execute: Boolean;

  Result := TCommonDialog(AObj).Execute();
end;

function TCommonDialog_Handle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Handle: HWnd read <getter>;

  Result := HWnd_sw.ToVar(TCommonDialog(AObj).Handle);
end;

function TCommonDialog_Ctl3D_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Ctl3D: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TCommonDialog(AObj).Ctl3D
  else
    TCommonDialog(AObj).Ctl3D := Boolean(AArgs[0]);
end;

function TCommonDialog_HelpContext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HelpContext: THelpContext read <getter> write <s...

  if IsGet then
    Result := THelpContext_sw.ToVar(TCommonDialog(AObj).HelpContext)
  else
    TCommonDialog(AObj).HelpContext := THelpContext_sw.FromVar(AArgs[0]);
end;

function TCommonDialog_OnClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnClose: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialog(AObj).OnClose)
  else
    TCommonDialog(AObj).OnClose := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TCommonDialog_OnShow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnShow: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TCommonDialog(AObj).OnShow)
  else
    TCommonDialog(AObj).OnShow := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TCommonDialog_sw.GetTypeName: WideString;
begin
  Result := 'TCommonDialog';
end;

class function TCommonDialog_sw.GetWrappedClass: TClass;
begin
  Result := TCommonDialog;
end;

class procedure TCommonDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('Execute', TCommonDialog_Execute_si, Boolean_sw, 0, False);
  AData.AddProperty('Handle', TCommonDialog_Handle_si, HWnd_sw, True, False, 0, False, False);
  AData.AddProperty('Ctl3D', TCommonDialog_Ctl3D_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('HelpContext', TCommonDialog_HelpContext_si, THelpContext_sw, True, True, 0, False, False);
  AData.AddProperty('OnClose', TCommonDialog_OnClose_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnShow', TCommonDialog_OnShow_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TCommonDialog_sw.ToVar(const AValue: TCommonDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCommonDialog_sw.FromVar(
  const AValue: OleVariant): TCommonDialog;
begin
  Result := TCommonDialog(ConvFromVar(AValue, TCommonDialog));
end;

class function TCommonDialog_sw.ClassToVar(
  AClass: TCommonDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCommonDialog_sw.ClassFromVar(
  const AClass: OleVariant): TCommonDialog_sc;
begin
  Result := TCommonDialog_sc(ConvClsFromVar(AClass, TCommonDialog));
end;

{ TOpenOption_sw }

class function TOpenOption_sw.GetTypeName: WideString;
begin
  Result := 'TOpenOption';
end;

class procedure TOpenOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..21] of TLMDEnumerator = (
    (Name: 'ofReadOnly'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofReadOnly)),
    (Name: 'ofOverwritePrompt'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofOverwritePrompt)),
    (Name: 'ofHideReadOnly'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofHideReadOnly)),
    (Name: 'ofNoChangeDir'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoChangeDir)),
    (Name: 'ofShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofShowHelp)),
    (Name: 'ofNoValidate'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoValidate)),
    (Name: 'ofAllowMultiSelect'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofAllowMultiSelect)),
    (Name: 'ofExtensionDifferent'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofExtensionDifferent)),
    (Name: 'ofPathMustExist'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofPathMustExist)),
    (Name: 'ofFileMustExist'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofFileMustExist)),
    (Name: 'ofCreatePrompt'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofCreatePrompt)),
    (Name: 'ofShareAware'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofShareAware)),
    (Name: 'ofNoReadOnlyReturn'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoReadOnlyReturn)),
    (Name: 'ofNoTestFileCreate'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoTestFileCreate)),
    (Name: 'ofNoNetworkButton'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoNetworkButton)),
    (Name: 'ofNoLongNames'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoLongNames)),
    (Name: 'ofOldStyleDialog'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofOldStyleDialog)),
    (Name: 'ofNoDereferenceLinks'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofNoDereferenceLinks)),
    (Name: 'ofEnableIncludeNotify'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofEnableIncludeNotify)),
    (Name: 'ofEnableSizing'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofEnableSizing)),
    (Name: 'ofDontAddToRecent'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofDontAddToRecent)),
    (Name: 'ofForceShowHidden'; Value: Integer({$IFDEF LMDSCT_12}TOpenOption.{$ENDIF}ofForceShowHidden))
  );
begin
  AEnums := @ENUMS;
  ACount := 22;
end;

class function TOpenOption_sw.ToVar(const AValue: TOpenOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOpenOption_sw.FromVar(const AValue: OleVariant): TOpenOption;
begin
  Result := TOpenOption(Integer(AValue));
end;

{ TOpenOptions_sw }

class function TOpenOptions_sw.GetTypeName: WideString;
begin
  Result := 'TOpenOptions';
end;

class function TOpenOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TOpenOptions);
end;

class function TOpenOptions_sw.ToVar(const AValue: TOpenOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TOpenOptions_sw.FromVar(const AValue: OleVariant): TOpenOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TOpenOptionEx_sw }

class function TOpenOptionEx_sw.GetTypeName: WideString;
begin
  Result := 'TOpenOptionEx';
end;

class procedure TOpenOptionEx_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..0] of TLMDEnumerator = (
    (Name: 'ofExNoPlacesBar'; Value: Integer({$IFDEF LMDSCT_12}TOpenOptionEx.{$ENDIF}ofExNoPlacesBar))
  );
begin
  AEnums := @ENUMS;
  ACount := 1;
end;

class function TOpenOptionEx_sw.ToVar(const AValue: TOpenOptionEx): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOpenOptionEx_sw.FromVar(
  const AValue: OleVariant): TOpenOptionEx;
begin
  Result := TOpenOptionEx(Integer(AValue));
end;

{ TOpenOptionsEx_sw }

class function TOpenOptionsEx_sw.GetTypeName: WideString;
begin
  Result := 'TOpenOptionsEx';
end;

class function TOpenOptionsEx_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TOpenOptionsEx);
end;

class function TOpenOptionsEx_sw.ToVar(
  const AValue: TOpenOptionsEx): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TOpenOptionsEx_sw.FromVar(
  const AValue: OleVariant): TOpenOptionsEx;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFileEditStyle_sw }

class function TFileEditStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFileEditStyle';
end;

class procedure TFileEditStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'fsEdit'; Value: Integer({$IFDEF LMDSCT_12}TFileEditStyle.{$ENDIF}fsEdit)),
    (Name: 'fsComboBox'; Value: Integer({$IFDEF LMDSCT_12}TFileEditStyle.{$ENDIF}fsComboBox))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TFileEditStyle_sw.ToVar(
  const AValue: TFileEditStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFileEditStyle_sw.FromVar(
  const AValue: OleVariant): TFileEditStyle;
begin
  Result := TFileEditStyle(Integer(AValue));
end;

{ TOFNotifyEx_sw }

class function TOFNotifyEx_sw.GetTypeName: WideString;
begin
  Result := 'TOFNotifyEx';
end;

class function TOFNotifyEx_sw.ToVar(const AValue: TOFNotifyEx): OleVariant;
begin
  Result := CommDlg_LMDSW.TOFNotifyEx_sw.ToVar(CommDlg.TOFNotifyEx(AValue));
end;

class function TOFNotifyEx_sw.FromVar(const AValue: OleVariant): TOFNotifyEx;
begin
  Result := TOFNotifyEx(CommDlg_LMDSW.TOFNotifyEx_sw.FromVar(AValue));
end;

{ TIncludeItemEvent_sh }

function TIncludeItemEvent_sh.GetHandler: TMethod;
var
  hdr: TIncludeItemEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TIncludeItemEvent_sh.Handler(const OFN: TOFNotifyEx;
  var Include: Boolean);
var
  args: array[0..1] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (const OFN: TOFNotifyEx; var Include: Boolean) ...

  v_1 := Include;
  args[0] := TOFNotifyEx_sw.ToVar(OFN);
  args[1] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  Include := Boolean(v_1);
end;

{ TIncludeItemEvent_sw }

class function TIncludeItemEvent_sw.GetTypeName: WideString;
begin
  Result := 'TIncludeItemEvent';
end;

class function TIncludeItemEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TIncludeItemEvent_sh;
end;

class function TIncludeItemEvent_sw.ToVar(
  const AValue: TIncludeItemEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TIncludeItemEvent_sw.FromVar(
  const AValue: OleVariant): TIncludeItemEvent;
begin
  Result := TIncludeItemEvent(ConvFromVar(AValue));
end;

class function TIncludeItemEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl; const AProcName: string): TIncludeItemEvent;
var
  hdlr: TIncludeItemEvent_sh;
begin
  hdlr   := TIncludeItemEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TIncludeItemEvent_sw));
  Result := hdlr.Handler;
end;

{ TOpenDialog_sw }

function TOpenDialog_FileEditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileEditStyle: TFileEditStyle read <getter> writ...

  if IsGet then
    Result := TFileEditStyle_sw.ToVar(TOpenDialog(AObj).FileEditStyle)
  else
    TOpenDialog(AObj).FileEditStyle := TFileEditStyle_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Files_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Files: TStrings read <getter>;

  Result := TStrings_sw.ToVar(TOpenDialog(AObj).Files);
end;

function TOpenDialog_HistoryList_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property HistoryList: TStrings read <getter> write <setter>;

  if IsGet then
    Result := TStrings_sw.ToVar(TOpenDialog(AObj).HistoryList)
  else
    TOpenDialog(AObj).HistoryList := TStrings_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_DefaultExt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DefaultExt: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).DefaultExt
  else
    TOpenDialog(AObj).DefaultExt := string(AArgs[0]);
end;

function TOpenDialog_FileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FileName: TFileName read <getter> write <setter>;

  if IsGet then
    Result := TFileName_sw.ToVar(TOpenDialog(AObj).FileName)
  else
    TOpenDialog(AObj).FileName := TFileName_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Filter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Filter: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).Filter
  else
    TOpenDialog(AObj).Filter := string(AArgs[0]);
end;

function TOpenDialog_FilterIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FilterIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).FilterIndex
  else
    TOpenDialog(AObj).FilterIndex := Integer(AArgs[0]);
end;

function TOpenDialog_InitialDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property InitialDir: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).InitialDir
  else
    TOpenDialog(AObj).InitialDir := string(AArgs[0]);
end;

function TOpenDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TOpenOptions read <getter> write <setter>;

  if IsGet then
    Result := TOpenOptions_sw.ToVar(TOpenDialog(AObj).Options)
  else
    TOpenDialog(AObj).Options := TOpenOptions_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OptionsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OptionsEx: TOpenOptionsEx read <getter> write <s...

  if IsGet then
    Result := TOpenOptionsEx_sw.ToVar(TOpenDialog(AObj).OptionsEx)
  else
    TOpenDialog(AObj).OptionsEx := TOpenOptionsEx_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_Title_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Title: string read <getter> write <setter>;

  if IsGet then
    Result := TOpenDialog(AObj).Title
  else
    TOpenDialog(AObj).Title := string(AArgs[0]);
end;

function TOpenDialog_OnCanClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnCanClose: TCloseQueryEvent read <getter> write...

  if IsGet then
    Result := TCloseQueryEvent_sw.ToVar(TOpenDialog(AObj).OnCanClose)
  else
    TOpenDialog(AObj).OnCanClose := TCloseQueryEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnFolderChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFolderChange: TNotifyEvent read <getter> write...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnFolderChange)
  else
    TOpenDialog(AObj).OnFolderChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnSelectionChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnSelectionChange: TNotifyEvent read <getter> wr...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnSelectionChange)
  else
    TOpenDialog(AObj).OnSelectionChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnTypeChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnTypeChange: TNotifyEvent read <getter> write <...

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TOpenDialog(AObj).OnTypeChange)
  else
    TOpenDialog(AObj).OnTypeChange := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

function TOpenDialog_OnIncludeItem_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnIncludeItem: TIncludeItemEvent read <getter> w...

  if IsGet then
    Result := TIncludeItemEvent_sw.ToVar(TOpenDialog(AObj).OnIncludeItem)
  else
    TOpenDialog(AObj).OnIncludeItem := TIncludeItemEvent_sw.FromVar(AArgs[0]);
end;

class function TOpenDialog_sw.GetTypeName: WideString;
begin
  Result := 'TOpenDialog';
end;

class function TOpenDialog_sw.GetWrappedClass: TClass;
begin
  Result := TOpenDialog;
end;

class procedure TOpenDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('FileEditStyle', TOpenDialog_FileEditStyle_si, TFileEditStyle_sw, True, True, 0, False, False);
  AData.AddProperty('Files', TOpenDialog_Files_si, TStrings_sw, True, False, 0, False, False);
  AData.AddProperty('HistoryList', TOpenDialog_HistoryList_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('DefaultExt', TOpenDialog_DefaultExt_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FileName', TOpenDialog_FileName_si, TFileName_sw, True, True, 0, False, False);
  AData.AddProperty('Filter', TOpenDialog_Filter_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('FilterIndex', TOpenDialog_FilterIndex_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('InitialDir', TOpenDialog_InitialDir_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TOpenDialog_Options_si, TOpenOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OptionsEx', TOpenDialog_OptionsEx_si, TOpenOptionsEx_sw, True, True, 0, False, False);
  AData.AddProperty('Title', TOpenDialog_Title_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('OnCanClose', TOpenDialog_OnCanClose_si, TCloseQueryEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnFolderChange', TOpenDialog_OnFolderChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnSelectionChange', TOpenDialog_OnSelectionChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnTypeChange', TOpenDialog_OnTypeChange_si, TNotifyEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnIncludeItem', TOpenDialog_OnIncludeItem_si, TIncludeItemEvent_sw, True, True, 0, False, False);
end;

class function TOpenDialog_sw.ToVar(const AValue: TOpenDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TOpenDialog_sw.FromVar(const AValue: OleVariant): TOpenDialog;
begin
  Result := TOpenDialog(ConvFromVar(AValue, TOpenDialog));
end;

class function TOpenDialog_sw.ClassToVar(AClass: TOpenDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TOpenDialog_sw.ClassFromVar(
  const AClass: OleVariant): TOpenDialog_sc;
begin
  Result := TOpenDialog_sc(ConvClsFromVar(AClass, TOpenDialog));
end;

{ TSaveDialog_sw }

class function TSaveDialog_sw.GetTypeName: WideString;
begin
  Result := 'TSaveDialog';
end;

class function TSaveDialog_sw.GetWrappedClass: TClass;
begin
  Result := TSaveDialog;
end;

class procedure TSaveDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSaveDialog_sw.ToVar(const AValue: TSaveDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSaveDialog_sw.FromVar(const AValue: OleVariant): TSaveDialog;
begin
  Result := TSaveDialog(ConvFromVar(AValue, TSaveDialog));
end;

class function TSaveDialog_sw.ClassToVar(AClass: TSaveDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSaveDialog_sw.ClassFromVar(
  const AClass: OleVariant): TSaveDialog_sc;
begin
  Result := TSaveDialog_sc(ConvClsFromVar(AClass, TSaveDialog));
end;

{ TColorDialogOption_sw }

class function TColorDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialogOption';
end;

class procedure TColorDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'cdFullOpen'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdFullOpen)),
    (Name: 'cdPreventFullOpen'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdPreventFullOpen)),
    (Name: 'cdShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdShowHelp)),
    (Name: 'cdSolidColor'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdSolidColor)),
    (Name: 'cdAnyColor'; Value: Integer({$IFDEF LMDSCT_12}TColorDialogOption.{$ENDIF}cdAnyColor))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TColorDialogOption_sw.ToVar(
  const AValue: TColorDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColorDialogOption_sw.FromVar(
  const AValue: OleVariant): TColorDialogOption;
begin
  Result := TColorDialogOption(Integer(AValue));
end;

{ TColorDialogOptions_sw }

class function TColorDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialogOptions';
end;

class function TColorDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TColorDialogOptions);
end;

class function TColorDialogOptions_sw.ToVar(
  const AValue: TColorDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TColorDialogOptions_sw.FromVar(
  const AValue: OleVariant): TColorDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TColorDialog_sw }

function TColorDialog_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Color: TColor read <getter> write <setter>;

  if IsGet then
    Result := TColor_sw.ToVar(TColorDialog(AObj).Color)
  else
    TColorDialog(AObj).Color := TColor_sw.FromVar(AArgs[0]);
end;

function TColorDialog_CustomColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property CustomColors: TStrings read <getter> write <sett...

  if IsGet then
    Result := TStrings_sw.ToVar(TColorDialog(AObj).CustomColors)
  else
    TColorDialog(AObj).CustomColors := TStrings_sw.FromVar(AArgs[0]);
end;

function TColorDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TColorDialogOptions read <getter> write...

  if IsGet then
    Result := TColorDialogOptions_sw.ToVar(TColorDialog(AObj).Options)
  else
    TColorDialog(AObj).Options := TColorDialogOptions_sw.FromVar(AArgs[0]);
end;

class function TColorDialog_sw.GetTypeName: WideString;
begin
  Result := 'TColorDialog';
end;

class function TColorDialog_sw.GetWrappedClass: TClass;
begin
  Result := TColorDialog;
end;

class procedure TColorDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Color', TColorDialog_Color_si, TColor_sw, True, True, 0, False, False);
  AData.AddPropertyRedecl('Ctl3D', False);
  AData.AddProperty('CustomColors', TColorDialog_CustomColors_si, TStrings_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TColorDialog_Options_si, TColorDialogOptions_sw, True, True, 0, False, False);
end;

class function TColorDialog_sw.ToVar(const AValue: TColorDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TColorDialog_sw.FromVar(const AValue: OleVariant): TColorDialog;
begin
  Result := TColorDialog(ConvFromVar(AValue, TColorDialog));
end;

class function TColorDialog_sw.ClassToVar(AClass: TColorDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TColorDialog_sw.ClassFromVar(
  const AClass: OleVariant): TColorDialog_sc;
begin
  Result := TColorDialog_sc(ConvClsFromVar(AClass, TColorDialog));
end;

{ TFontDialogOption_sw }

class function TFontDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogOption';
end;

class procedure TFontDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..15] of TLMDEnumerator = (
    (Name: 'fdAnsiOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdAnsiOnly)),
    (Name: 'fdTrueTypeOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdTrueTypeOnly)),
    (Name: 'fdEffects'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdEffects)),
    (Name: 'fdFixedPitchOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdFixedPitchOnly)),
    (Name: 'fdForceFontExist'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdForceFontExist)),
    (Name: 'fdNoFaceSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoFaceSel)),
    (Name: 'fdNoOEMFonts'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoOEMFonts)),
    (Name: 'fdNoSimulations'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoSimulations)),
    (Name: 'fdNoSizeSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoSizeSel)),
    (Name: 'fdNoStyleSel'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoStyleSel)),
    (Name: 'fdNoVectorFonts'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdNoVectorFonts)),
    (Name: 'fdShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdShowHelp)),
    (Name: 'fdWysiwyg'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdWysiwyg)),
    (Name: 'fdLimitSize'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdLimitSize)),
    (Name: 'fdScalableOnly'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdScalableOnly)),
    (Name: 'fdApplyButton'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogOption.{$ENDIF}fdApplyButton))
  );
begin
  AEnums := @ENUMS;
  ACount := 16;
end;

class function TFontDialogOption_sw.ToVar(
  const AValue: TFontDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontDialogOption_sw.FromVar(
  const AValue: OleVariant): TFontDialogOption;
begin
  Result := TFontDialogOption(Integer(AValue));
end;

{ TFontDialogOptions_sw }

class function TFontDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogOptions';
end;

class function TFontDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontDialogOptions);
end;

class function TFontDialogOptions_sw.ToVar(
  const AValue: TFontDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontDialogOptions_sw.FromVar(
  const AValue: OleVariant): TFontDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFontDialogDevice_sw }

class function TFontDialogDevice_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialogDevice';
end;

class procedure TFontDialogDevice_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fdScreen'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdScreen)),
    (Name: 'fdPrinter'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdPrinter)),
    (Name: 'fdBoth'; Value: Integer({$IFDEF LMDSCT_12}TFontDialogDevice.{$ENDIF}fdBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFontDialogDevice_sw.ToVar(
  const AValue: TFontDialogDevice): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontDialogDevice_sw.FromVar(
  const AValue: OleVariant): TFontDialogDevice;
begin
  Result := TFontDialogDevice(Integer(AValue));
end;

{ TFDApplyEvent_sh }

function TFDApplyEvent_sh.GetHandler: TMethod;
var
  hdr: TFDApplyEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TFDApplyEvent_sh.Handler(Sender: TObject; Wnd: HWND);
var
  args: array[0..1] of OleVariant;
begin
  // procedure (Sender: TObject; Wnd: HWND) of object

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := HWND_sw.ToVar(Wnd);
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TFDApplyEvent_sw }

class function TFDApplyEvent_sw.GetTypeName: WideString;
begin
  Result := 'TFDApplyEvent';
end;

class function TFDApplyEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TFDApplyEvent_sh;
end;

class function TFDApplyEvent_sw.ToVar(const AValue: TFDApplyEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TFDApplyEvent_sw.FromVar(
  const AValue: OleVariant): TFDApplyEvent;
begin
  Result := TFDApplyEvent(ConvFromVar(AValue));
end;

class function TFDApplyEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TFDApplyEvent;
var
  hdlr: TFDApplyEvent_sh;
begin
  hdlr   := TFDApplyEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TFDApplyEvent_sw));
  Result := hdlr.Handler;
end;

{ TFontDialog_sw }

function TFontDialog_Font_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Font: TFont read <getter> write <setter>;

  if IsGet then
    Result := TFont_sw.ToVar(TFontDialog(AObj).Font)
  else
    TFontDialog(AObj).Font := TFont_sw.FromVar(AArgs[0]);
end;

function TFontDialog_Device_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Device: TFontDialogDevice read <getter> write <s...

  if IsGet then
    Result := TFontDialogDevice_sw.ToVar(TFontDialog(AObj).Device)
  else
    TFontDialog(AObj).Device := TFontDialogDevice_sw.FromVar(AArgs[0]);
end;

function TFontDialog_MinFontSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinFontSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFontDialog(AObj).MinFontSize
  else
    TFontDialog(AObj).MinFontSize := Integer(AArgs[0]);
end;

function TFontDialog_MaxFontSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxFontSize: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFontDialog(AObj).MaxFontSize
  else
    TFontDialog(AObj).MaxFontSize := Integer(AArgs[0]);
end;

function TFontDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TFontDialogOptions read <getter> write ...

  if IsGet then
    Result := TFontDialogOptions_sw.ToVar(TFontDialog(AObj).Options)
  else
    TFontDialog(AObj).Options := TFontDialogOptions_sw.FromVar(AArgs[0]);
end;

function TFontDialog_OnApply_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnApply: TFDApplyEvent read <getter> write <sett...

  if IsGet then
    Result := TFDApplyEvent_sw.ToVar(TFontDialog(AObj).OnApply)
  else
    TFontDialog(AObj).OnApply := TFDApplyEvent_sw.FromVar(AArgs[0]);
end;

class function TFontDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFontDialog';
end;

class function TFontDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFontDialog;
end;

class procedure TFontDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Font', TFontDialog_Font_si, TFont_sw, True, True, 0, False, False);
  AData.AddProperty('Device', TFontDialog_Device_si, TFontDialogDevice_sw, True, True, 0, False, False);
  AData.AddProperty('MinFontSize', TFontDialog_MinFontSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MaxFontSize', TFontDialog_MaxFontSize_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TFontDialog_Options_si, TFontDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OnApply', TFontDialog_OnApply_si, TFDApplyEvent_sw, True, True, 0, False, False);
end;

class function TFontDialog_sw.ToVar(const AValue: TFontDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFontDialog_sw.FromVar(const AValue: OleVariant): TFontDialog;
begin
  Result := TFontDialog(ConvFromVar(AValue, TFontDialog));
end;

class function TFontDialog_sw.ClassToVar(AClass: TFontDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFontDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFontDialog_sc;
begin
  Result := TFontDialog_sc(ConvClsFromVar(AClass, TFontDialog));
end;

{ TPrinterSetupDialog_sw }

class function TPrinterSetupDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterSetupDialog';
end;

class function TPrinterSetupDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPrinterSetupDialog;
end;

class procedure TPrinterSetupDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TPrinterSetupDialog_sw.ToVar(
  const AValue: TPrinterSetupDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrinterSetupDialog_sw.FromVar(
  const AValue: OleVariant): TPrinterSetupDialog;
begin
  Result := TPrinterSetupDialog(ConvFromVar(AValue, TPrinterSetupDialog));
end;

class function TPrinterSetupDialog_sw.ClassToVar(
  AClass: TPrinterSetupDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrinterSetupDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPrinterSetupDialog_sc;
begin
  Result := TPrinterSetupDialog_sc(ConvClsFromVar(AClass, TPrinterSetupDialog));
end;

{ TPrintRange_sw }

class function TPrintRange_sw.GetTypeName: WideString;
begin
  Result := 'TPrintRange';
end;

class procedure TPrintRange_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'prAllPages'; Value: Integer({$IFDEF LMDSCT_12}TPrintRange.{$ENDIF}prAllPages)),
    (Name: 'prSelection'; Value: Integer({$IFDEF LMDSCT_12}TPrintRange.{$ENDIF}prSelection)),
    (Name: 'prPageNums'; Value: Integer({$IFDEF LMDSCT_12}TPrintRange.{$ENDIF}prPageNums))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrintRange_sw.ToVar(const AValue: TPrintRange): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrintRange_sw.FromVar(const AValue: OleVariant): TPrintRange;
begin
  Result := TPrintRange(Integer(AValue));
end;

{ TPrintDialogOption_sw }

class function TPrintDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TPrintDialogOption';
end;

class procedure TPrintDialogOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'poPrintToFile'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poPrintToFile)),
    (Name: 'poPageNums'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poPageNums)),
    (Name: 'poSelection'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poSelection)),
    (Name: 'poWarning'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poWarning)),
    (Name: 'poHelp'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poHelp)),
    (Name: 'poDisablePrintToFile'; Value: Integer({$IFDEF LMDSCT_12}TPrintDialogOption.{$ENDIF}poDisablePrintToFile))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TPrintDialogOption_sw.ToVar(
  const AValue: TPrintDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrintDialogOption_sw.FromVar(
  const AValue: OleVariant): TPrintDialogOption;
begin
  Result := TPrintDialogOption(Integer(AValue));
end;

{ TPrintDialogOptions_sw }

class function TPrintDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TPrintDialogOptions';
end;

class function TPrintDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TPrintDialogOptions);
end;

class function TPrintDialogOptions_sw.ToVar(
  const AValue: TPrintDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TPrintDialogOptions_sw.FromVar(
  const AValue: OleVariant): TPrintDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPrintDialog_sw }

function TPrintDialog_Collate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Collate: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).Collate
  else
    TPrintDialog(AObj).Collate := Boolean(AArgs[0]);
end;

function TPrintDialog_Copies_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Copies: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).Copies
  else
    TPrintDialog(AObj).Copies := Integer(AArgs[0]);
end;

function TPrintDialog_FromPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FromPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).FromPage
  else
    TPrintDialog(AObj).FromPage := Integer(AArgs[0]);
end;

function TPrintDialog_MinPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).MinPage
  else
    TPrintDialog(AObj).MinPage := Integer(AArgs[0]);
end;

function TPrintDialog_MaxPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MaxPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).MaxPage
  else
    TPrintDialog(AObj).MaxPage := Integer(AArgs[0]);
end;

function TPrintDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TPrintDialogOptions read <getter> write...

  if IsGet then
    Result := TPrintDialogOptions_sw.ToVar(TPrintDialog(AObj).Options)
  else
    TPrintDialog(AObj).Options := TPrintDialogOptions_sw.FromVar(AArgs[0]);
end;

function TPrintDialog_PrintToFile_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrintToFile: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).PrintToFile
  else
    TPrintDialog(AObj).PrintToFile := Boolean(AArgs[0]);
end;

function TPrintDialog_PrintRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PrintRange: TPrintRange read <getter> write <set...

  if IsGet then
    Result := TPrintRange_sw.ToVar(TPrintDialog(AObj).PrintRange)
  else
    TPrintDialog(AObj).PrintRange := TPrintRange_sw.FromVar(AArgs[0]);
end;

function TPrintDialog_ToPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property ToPage: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPrintDialog(AObj).ToPage
  else
    TPrintDialog(AObj).ToPage := Integer(AArgs[0]);
end;

class function TPrintDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPrintDialog';
end;

class function TPrintDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPrintDialog;
end;

class procedure TPrintDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Collate', TPrintDialog_Collate_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('Copies', TPrintDialog_Copies_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FromPage', TPrintDialog_FromPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinPage', TPrintDialog_MinPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MaxPage', TPrintDialog_MaxPage_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TPrintDialog_Options_si, TPrintDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('PrintToFile', TPrintDialog_PrintToFile_si, Boolean_sw, True, True, 0, False, False);
  AData.AddProperty('PrintRange', TPrintDialog_PrintRange_si, TPrintRange_sw, True, True, 0, False, False);
  AData.AddProperty('ToPage', TPrintDialog_ToPage_si, Integer_sw, True, True, 0, False, False);
end;

class function TPrintDialog_sw.ToVar(const AValue: TPrintDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPrintDialog_sw.FromVar(const AValue: OleVariant): TPrintDialog;
begin
  Result := TPrintDialog(ConvFromVar(AValue, TPrintDialog));
end;

class function TPrintDialog_sw.ClassToVar(AClass: TPrintDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPrintDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPrintDialog_sc;
begin
  Result := TPrintDialog_sc(ConvClsFromVar(AClass, TPrintDialog));
end;

{ TPageSetupDialogOption_sw }

class function TPageSetupDialogOption_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupDialogOption';
end;

class procedure TPageSetupDialogOption_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..10] of TLMDEnumerator = (
    (Name: 'psoDefaultMinMargins'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDefaultMinMargins)),
    (Name: 'psoDisableMargins'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDisableMargins)),
    (Name: 'psoDisableOrientation'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDisableOrientation)),
    (Name: 'psoDisablePagePainting'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDisablePagePainting)),
    (Name: 'psoDisablePaper'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDisablePaper)),
    (Name: 'psoDisablePrinter'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoDisablePrinter)),
    (Name: 'psoMargins'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoMargins)),
    (Name: 'psoMinMargins'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoMinMargins)),
    (Name: 'psoShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoShowHelp)),
    (Name: 'psoWarning'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoWarning)),
    (Name: 'psoNoNetworkButton'; Value: Integer({$IFDEF LMDSCT_12}TPageSetupDialogOption.{$ENDIF}psoNoNetworkButton))
  );
begin
  AEnums := @ENUMS;
  ACount := 11;
end;

class function TPageSetupDialogOption_sw.ToVar(
  const AValue: TPageSetupDialogOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageSetupDialogOption_sw.FromVar(
  const AValue: OleVariant): TPageSetupDialogOption;
begin
  Result := TPageSetupDialogOption(Integer(AValue));
end;

{ TPageSetupDialogOptions_sw }

class function TPageSetupDialogOptions_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupDialogOptions';
end;

class function TPageSetupDialogOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TPageSetupDialogOptions);
end;

class function TPageSetupDialogOptions_sw.ToVar(
  const AValue: TPageSetupDialogOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TPageSetupDialogOptions_sw.FromVar(
  const AValue: OleVariant): TPageSetupDialogOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TPrinterKind_sw }

class function TPrinterKind_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterKind';
end;

class procedure TPrinterKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'pkDotMatrix'; Value: Integer({$IFDEF LMDSCT_12}TPrinterKind.{$ENDIF}pkDotMatrix)),
    (Name: 'pkHPPCL'; Value: Integer({$IFDEF LMDSCT_12}TPrinterKind.{$ENDIF}pkHPPCL))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPrinterKind_sw.ToVar(const AValue: TPrinterKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterKind_sw.FromVar(const AValue: OleVariant): TPrinterKind;
begin
  Result := TPrinterKind(Integer(AValue));
end;

{ TPageType_sw }

class function TPageType_sw.GetTypeName: WideString;
begin
  Result := 'TPageType';
end;

class procedure TPageType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'ptEnvelope'; Value: Integer({$IFDEF LMDSCT_12}TPageType.{$ENDIF}ptEnvelope)),
    (Name: 'ptPaper'; Value: Integer({$IFDEF LMDSCT_12}TPageType.{$ENDIF}ptPaper))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPageType_sw.ToVar(const AValue: TPageType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageType_sw.FromVar(const AValue: OleVariant): TPageType;
begin
  Result := TPageType(Integer(AValue));
end;

{ TPageSetupBeforePaintEvent_sh }

function TPageSetupBeforePaintEvent_sh.GetHandler: TMethod;
var
  hdr: TPageSetupBeforePaintEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPageSetupBeforePaintEvent_sh.Handler(Sender: TObject;
  const PaperSize: SmallInt; const Orientation: TPrinterOrientation;
  const PageType: TPageType; var DoneDrawing: Boolean);
var
  args: array[0..4] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; const PaperSize: SmallInt; co...

  v_1 := DoneDrawing;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := PaperSize;
  args[2] := TPrinterOrientation_sw.ToVar(Orientation);
  args[3] := TPageType_sw.ToVar(PageType);
  args[4] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DoneDrawing := Boolean(v_1);
end;

{ TPageSetupBeforePaintEvent_sw }

class function TPageSetupBeforePaintEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupBeforePaintEvent';
end;

class function TPageSetupBeforePaintEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPageSetupBeforePaintEvent_sh;
end;

class function TPageSetupBeforePaintEvent_sw.ToVar(
  const AValue: TPageSetupBeforePaintEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPageSetupBeforePaintEvent_sw.FromVar(
  const AValue: OleVariant): TPageSetupBeforePaintEvent;
begin
  Result := TPageSetupBeforePaintEvent(ConvFromVar(AValue));
end;

class function TPageSetupBeforePaintEvent_sw.GetHandler(
  AScriptControl: TLMDScriptControl;
  const AProcName: string): TPageSetupBeforePaintEvent;
var
  hdlr: TPageSetupBeforePaintEvent_sh;
begin
  hdlr   := TPageSetupBeforePaintEvent_sh(AScriptControl.GetEventHandler(
    AProcName, TPageSetupBeforePaintEvent_sw));
  Result := hdlr.Handler;
end;

{ TPageMeasureUnits_sw }

class function TPageMeasureUnits_sw.GetTypeName: WideString;
begin
  Result := 'TPageMeasureUnits';
end;

class procedure TPageMeasureUnits_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pmDefault'; Value: Integer({$IFDEF LMDSCT_12}TPageMeasureUnits.{$ENDIF}pmDefault)),
    (Name: 'pmMillimeters'; Value: Integer({$IFDEF LMDSCT_12}TPageMeasureUnits.{$ENDIF}pmMillimeters)),
    (Name: 'pmInches'; Value: Integer({$IFDEF LMDSCT_12}TPageMeasureUnits.{$ENDIF}pmInches))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPageMeasureUnits_sw.ToVar(
  const AValue: TPageMeasureUnits): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPageMeasureUnits_sw.FromVar(
  const AValue: OleVariant): TPageMeasureUnits;
begin
  Result := TPageMeasureUnits(Integer(AValue));
end;

{ TPaintPageEvent_sh }

function TPaintPageEvent_sh.GetHandler: TMethod;
var
  hdr: TPaintPageEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TPaintPageEvent_sh.Handler(Sender: TObject; Canvas: TCanvas;
  PageRect: TRect; var DoneDrawing: Boolean);
var
  args: array[0..3] of OleVariant;
  v_1: OleVariant;
begin
  // procedure (Sender: TObject; Canvas: TCanvas; PageRect: TR...

  v_1 := DoneDrawing;
  args[0] := TObject_sw.ToVar(Sender);
  args[1] := TCanvas_sw.ToVar(Canvas);
  args[2] := TRect_sw.ToVar(PageRect);
  args[3] := MakeVarRef(v_1);
  Self.Owner.RunProc(Self.ProcName, args);
  DoneDrawing := Boolean(v_1);
end;

{ TPaintPageEvent_sw }

class function TPaintPageEvent_sw.GetTypeName: WideString;
begin
  Result := 'TPaintPageEvent';
end;

class function TPaintPageEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TPaintPageEvent_sh;
end;

class function TPaintPageEvent_sw.ToVar(
  const AValue: TPaintPageEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TPaintPageEvent_sw.FromVar(
  const AValue: OleVariant): TPaintPageEvent;
begin
  Result := TPaintPageEvent(ConvFromVar(AValue));
end;

class function TPaintPageEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TPaintPageEvent;
var
  hdlr: TPaintPageEvent_sh;
begin
  hdlr   := TPaintPageEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TPaintPageEvent_sw));
  Result := hdlr.Handler;
end;

{ TPageSetupDialog_sw }

function TPageSetupDialog_GetDefaults_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetDefaults: Boolean;

  Result := TPageSetupDialog(AObj).GetDefaults();
end;

function TPageSetupDialog_PageSetupDlgRec_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageSetupDlgRec: TPageSetupDlg read <getter>;

  Result := TPageSetupDlg_sw.ToVar(TPageSetupDialog(AObj).PageSetupDlgRec);
end;

function TPageSetupDialog_MinMarginLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginLeft: Integer read <getter> write <sett...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginLeft
  else
    TPageSetupDialog(AObj).MinMarginLeft := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginTop: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginTop
  else
    TPageSetupDialog(AObj).MinMarginTop := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginRight: Integer read <getter> write <set...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginRight
  else
    TPageSetupDialog(AObj).MinMarginRight := Integer(AArgs[0]);
end;

function TPageSetupDialog_MinMarginBottom_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MinMarginBottom: Integer read <getter> write <se...

  if IsGet then
    Result := TPageSetupDialog(AObj).MinMarginBottom
  else
    TPageSetupDialog(AObj).MinMarginBottom := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginLeft: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginLeft
  else
    TPageSetupDialog(AObj).MarginLeft := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginTop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginTop: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginTop
  else
    TPageSetupDialog(AObj).MarginTop := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginRight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginRight
  else
    TPageSetupDialog(AObj).MarginRight := Integer(AArgs[0]);
end;

function TPageSetupDialog_MarginBottom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property MarginBottom: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).MarginBottom
  else
    TPageSetupDialog(AObj).MarginBottom := Integer(AArgs[0]);
end;

function TPageSetupDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TPageSetupDialogOptions read <getter> w...

  if IsGet then
    Result := TPageSetupDialogOptions_sw.ToVar(TPageSetupDialog(AObj).Options)
  else
    TPageSetupDialog(AObj).Options := TPageSetupDialogOptions_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_PageWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageWidth: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).PageWidth
  else
    TPageSetupDialog(AObj).PageWidth := Integer(AArgs[0]);
end;

function TPageSetupDialog_PageHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property PageHeight: Integer read <getter> write <setter>;

  if IsGet then
    Result := TPageSetupDialog(AObj).PageHeight
  else
    TPageSetupDialog(AObj).PageHeight := Integer(AArgs[0]);
end;

function TPageSetupDialog_Units_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Units: TPageMeasureUnits read <getter> write <se...

  if IsGet then
    Result := TPageMeasureUnits_sw.ToVar(TPageSetupDialog(AObj).Units)
  else
    TPageSetupDialog(AObj).Units := TPageMeasureUnits_sw.FromVar(AArgs[0]);
end;

function TPageSetupDialog_BeforePaint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property BeforePaint: TPageSetupBeforePaintEvent read <ge...

  if IsGet then
    Result := TPageSetupBeforePaintEvent_sw.ToVar(TPageSetupDialog(AObj).
      BeforePaint)
  else
    TPageSetupDialog(AObj).BeforePaint := TPageSetupBeforePaintEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawFullPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawFullPage: TPaintPageEvent read <getter> wr...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawFullPage)
  else
    TPageSetupDialog(AObj).OnDrawFullPage := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawMinMargin_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawMinMargin: TPaintPageEvent read <getter> w...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawMinMargin)
  else
    TPageSetupDialog(AObj).OnDrawMinMargin := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawMargin: TPaintPageEvent read <getter> writ...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawMargin)
  else
    TPageSetupDialog(AObj).OnDrawMargin := TPaintPageEvent_sw.FromVar(AArgs[0]);
end;

function TPageSetupDialog_OnDrawGreekText_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawGreekText: TPaintPageEvent read <getter> w...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawGreekText)
  else
    TPageSetupDialog(AObj).OnDrawGreekText := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawEnvStamp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawEnvStamp: TPaintPageEvent read <getter> wr...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawEnvStamp)
  else
    TPageSetupDialog(AObj).OnDrawEnvStamp := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

function TPageSetupDialog_OnDrawRetAddress_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnDrawRetAddress: TPaintPageEvent read <getter> ...

  if IsGet then
    Result := TPaintPageEvent_sw.ToVar(TPageSetupDialog(AObj).OnDrawRetAddress)
  else
    TPageSetupDialog(AObj).OnDrawRetAddress := TPaintPageEvent_sw.FromVar(
      AArgs[0]);
end;

class function TPageSetupDialog_sw.GetTypeName: WideString;
begin
  Result := 'TPageSetupDialog';
end;

class function TPageSetupDialog_sw.GetWrappedClass: TClass;
begin
  Result := TPageSetupDialog;
end;

class procedure TPageSetupDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetDefaults', TPageSetupDialog_GetDefaults_si, Boolean_sw, 0, False);
  AData.AddProperty('PageSetupDlgRec', TPageSetupDialog_PageSetupDlgRec_si, TPageSetupDlg_sw, True, False, 0, False, False);
  AData.AddProperty('MinMarginLeft', TPageSetupDialog_MinMarginLeft_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginTop', TPageSetupDialog_MinMarginTop_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginRight', TPageSetupDialog_MinMarginRight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MinMarginBottom', TPageSetupDialog_MinMarginBottom_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginLeft', TPageSetupDialog_MarginLeft_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginTop', TPageSetupDialog_MarginTop_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginRight', TPageSetupDialog_MarginRight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('MarginBottom', TPageSetupDialog_MarginBottom_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TPageSetupDialog_Options_si, TPageSetupDialogOptions_sw, True, True, 0, False, False);
  AData.AddProperty('PageWidth', TPageSetupDialog_PageWidth_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('PageHeight', TPageSetupDialog_PageHeight_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Units', TPageSetupDialog_Units_si, TPageMeasureUnits_sw, True, True, 0, False, False);
  AData.AddProperty('BeforePaint', TPageSetupDialog_BeforePaint_si, TPageSetupBeforePaintEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawFullPage', TPageSetupDialog_OnDrawFullPage_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawMinMargin', TPageSetupDialog_OnDrawMinMargin_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawMargin', TPageSetupDialog_OnDrawMargin_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawGreekText', TPageSetupDialog_OnDrawGreekText_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawEnvStamp', TPageSetupDialog_OnDrawEnvStamp_si, TPaintPageEvent_sw, True, True, 0, False, False);
  AData.AddProperty('OnDrawRetAddress', TPageSetupDialog_OnDrawRetAddress_si, TPaintPageEvent_sw, True, True, 0, False, False);
end;

class function TPageSetupDialog_sw.ToVar(
  const AValue: TPageSetupDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPageSetupDialog_sw.FromVar(
  const AValue: OleVariant): TPageSetupDialog;
begin
  Result := TPageSetupDialog(ConvFromVar(AValue, TPageSetupDialog));
end;

class function TPageSetupDialog_sw.ClassToVar(
  AClass: TPageSetupDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPageSetupDialog_sw.ClassFromVar(
  const AClass: OleVariant): TPageSetupDialog_sc;
begin
  Result := TPageSetupDialog_sc(ConvClsFromVar(AClass, TPageSetupDialog));
end;

{ TFindOption_sw }

class function TFindOption_sw.GetTypeName: WideString;
begin
  Result := 'TFindOption';
end;

class procedure TFindOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..12] of TLMDEnumerator = (
    (Name: 'frDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDown)),
    (Name: 'frFindNext'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frFindNext)),
    (Name: 'frHideMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideMatchCase)),
    (Name: 'frHideWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideWholeWord)),
    (Name: 'frHideUpDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frHideUpDown)),
    (Name: 'frMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frMatchCase)),
    (Name: 'frDisableMatchCase'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableMatchCase)),
    (Name: 'frDisableUpDown'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableUpDown)),
    (Name: 'frDisableWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frDisableWholeWord)),
    (Name: 'frReplace'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frReplace)),
    (Name: 'frReplaceAll'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frReplaceAll)),
    (Name: 'frWholeWord'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frWholeWord)),
    (Name: 'frShowHelp'; Value: Integer({$IFDEF LMDSCT_12}TFindOption.{$ENDIF}frShowHelp))
  );
begin
  AEnums := @ENUMS;
  ACount := 13;
end;

class function TFindOption_sw.ToVar(const AValue: TFindOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFindOption_sw.FromVar(const AValue: OleVariant): TFindOption;
begin
  Result := TFindOption(Integer(AValue));
end;

{ TFindOptions_sw }

class function TFindOptions_sw.GetTypeName: WideString;
begin
  Result := 'TFindOptions';
end;

class function TFindOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFindOptions);
end;

class function TFindOptions_sw.ToVar(const AValue: TFindOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFindOptions_sw.FromVar(const AValue: OleVariant): TFindOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFindDialog_sw }

function TFindDialog_CloseDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure CloseDialog;

  TFindDialog(AObj).CloseDialog();
end;

function TFindDialog_Left_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Left: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).Left
  else
    TFindDialog(AObj).Left := Integer(AArgs[0]);
end;

function TFindDialog_Position_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Position: TPoint read <getter> write <setter>;

  if IsGet then
    Result := TPoint_sw.ToVar(TFindDialog(AObj).Position)
  else
    TFindDialog(AObj).Position := TPoint_sw.FromVar(AArgs[0]);
end;

function TFindDialog_Top_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Top: Integer read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).Top
  else
    TFindDialog(AObj).Top := Integer(AArgs[0]);
end;

function TFindDialog_FindText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property FindText: string read <getter> write <setter>;

  if IsGet then
    Result := TFindDialog(AObj).FindText
  else
    TFindDialog(AObj).FindText := string(AArgs[0]);
end;

function TFindDialog_Options_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Options: TFindOptions read <getter> write <setter>;

  if IsGet then
    Result := TFindOptions_sw.ToVar(TFindDialog(AObj).Options)
  else
    TFindDialog(AObj).Options := TFindOptions_sw.FromVar(AArgs[0]);
end;

function TFindDialog_OnFind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property OnFind: TNotifyEvent read <getter> write <setter>;

  if IsGet then
    Result := TNotifyEvent_sw.ToVar(TFindDialog(AObj).OnFind)
  else
    TFindDialog(AObj).OnFind := TNotifyEvent_sw.FromVar(AArgs[0]);
end;

class function TFindDialog_sw.GetTypeName: WideString;
begin
  Result := 'TFindDialog';
end;

class function TFindDialog_sw.GetWrappedClass: TClass;
begin
  Result := TFindDialog;
end;

class procedure TFindDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('CloseDialog', TFindDialog_CloseDialog_si, 0, False);
  AData.AddProperty('Left', TFindDialog_Left_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('Position', TFindDialog_Position_si, TPoint_sw, True, True, 0, False, False);
  AData.AddProperty('Top', TFindDialog_Top_si, Integer_sw, True, True, 0, False, False);
  AData.AddProperty('FindText', TFindDialog_FindText_si, string_sw, True, True, 0, False, False);
  AData.AddProperty('Options', TFindDialog_Options_si, TFindOptions_sw, True, True, 0, False, False);
  AData.AddProperty('OnFind', TFindDialog_OnFind_si, TNotifyEvent_sw, True, True, 0, False, False);
end;

class function TFindDialog_sw.ToVar(const AValue: TFindDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFindDialog_sw.FromVar(const AValue: OleVariant): TFindDialog;
begin
  Result := TFindDialog(ConvFromVar(AValue, TFindDialog));
end;

class function TFindDialog_sw.ClassToVar(AClass: TFindDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFindDialog_sw.ClassFromVar(
  const AClass: OleVariant): TFindDialog_sc;
begin
  Result := TFindDialog_sc(ConvClsFromVar(AClass, TFindDialog));
end;

{ TReplaceDialog_sw }

class function TReplaceDialog_sw.GetTypeName: WideString;
begin
  Result := 'TReplaceDialog';
end;

class function TReplaceDialog_sw.GetWrappedClass: TClass;
begin
  Result := TReplaceDialog;
end;

class procedure TReplaceDialog_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ReplaceText', False);
  AData.AddPropertyRedecl('OnReplace', False);
end;

class function TReplaceDialog_sw.ToVar(
  const AValue: TReplaceDialog): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TReplaceDialog_sw.FromVar(
  const AValue: OleVariant): TReplaceDialog;
begin
  Result := TReplaceDialog(ConvFromVar(AValue, TReplaceDialog));
end;

class function TReplaceDialog_sw.ClassToVar(
  AClass: TReplaceDialog_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TReplaceDialog_sw.ClassFromVar(
  const AClass: OleVariant): TReplaceDialog_sc;
begin
  Result := TReplaceDialog_sc(ConvClsFromVar(AClass, TReplaceDialog));
end;

{ TMsgDlgType_sw }

class function TMsgDlgType_sw.GetTypeName: WideString;
begin
  Result := 'TMsgDlgType';
end;

class procedure TMsgDlgType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..4] of TLMDEnumerator = (
    (Name: 'mtWarning'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgType.{$ENDIF}mtWarning)),
    (Name: 'mtError'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgType.{$ENDIF}mtError)),
    (Name: 'mtInformation'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgType.{$ENDIF}mtInformation)),
    (Name: 'mtConfirmation'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgType.{$ENDIF}mtConfirmation)),
    (Name: 'mtCustom'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgType.{$ENDIF}mtCustom))
  );
begin
  AEnums := @ENUMS;
  ACount := 5;
end;

class function TMsgDlgType_sw.ToVar(const AValue: TMsgDlgType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMsgDlgType_sw.FromVar(const AValue: OleVariant): TMsgDlgType;
begin
  Result := TMsgDlgType(Integer(AValue));
end;

{ TMsgDlgBtn_sw }

class function TMsgDlgBtn_sw.GetTypeName: WideString;
begin
  Result := 'TMsgDlgBtn';
end;

class procedure TMsgDlgBtn_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..10] of TLMDEnumerator = (
    (Name: 'mbYes'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbYes)),
    (Name: 'mbNo'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbNo)),
    (Name: 'mbOK'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbOK)),
    (Name: 'mbCancel'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbCancel)),
    (Name: 'mbAbort'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbAbort)),
    (Name: 'mbRetry'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbRetry)),
    (Name: 'mbIgnore'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbIgnore)),
    (Name: 'mbAll'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbAll)),
    (Name: 'mbNoToAll'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbNoToAll)),
    (Name: 'mbYesToAll'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbYesToAll)),
    (Name: 'mbHelp'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbHelp))
  );
begin
  AEnums := @ENUMS;
  ACount := 11;
end;

class function TMsgDlgBtn_sw.ToVar(const AValue: TMsgDlgBtn): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMsgDlgBtn_sw.FromVar(const AValue: OleVariant): TMsgDlgBtn;
begin
  Result := TMsgDlgBtn(Integer(AValue));
end;

{ TMsgDlgButtons_sw }

class function TMsgDlgButtons_sw.GetTypeName: WideString;
begin
  Result := 'TMsgDlgButtons';
end;

class function TMsgDlgButtons_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TMsgDlgButtons);
end;

class function TMsgDlgButtons_sw.ToVar(
  const AValue: TMsgDlgButtons): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TMsgDlgButtons_sw.FromVar(
  const AValue: OleVariant): TMsgDlgButtons;
begin
  ConvFromVar(AValue, @Result);
end;

{ Dialogs_sw }

function Dialogs_MaxCustomColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxCustomColors = <value>;

  Result := MaxCustomColors;
end;

function Dialogs_TCommonDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCommonDialog = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TCommonDialog_sw);
end;

function Dialogs_TOpenOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOption = (ofReadOnly, ofOverwritePrompt, ofHide...

  Result := TLMDUnitWrapper.TypeToVar(TOpenOption_sw);
end;

function Dialogs_TOpenOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptions = set of TOpenOption;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptions_sw);
end;

function Dialogs_TOpenOptionEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionEx = (ofExNoPlacesBar);

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionEx_sw);
end;

function Dialogs_TOpenOptionsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionsEx = set of TOpenOptionEx;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionsEx_sw);
end;

function Dialogs_TFileEditStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileEditStyle = (fsEdit, fsComboBox);

  Result := TLMDUnitWrapper.TypeToVar(TFileEditStyle_sw);
end;

function Dialogs_TOFNotifyEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyEx = CommDlg.TOFNotifyEx;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyEx_sw);
end;

function Dialogs_TIncludeItemEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIncludeItemEvent = procedure (const OFN: TOFNotifyE...

  Result := TLMDUnitWrapper.TypeToVar(TIncludeItemEvent_sw);
end;

function Dialogs_TOpenDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TOpenDialog_sw);
end;

function Dialogs_TSaveDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSaveDialog = class(TOpenDialog);

  Result := TLMDUnitWrapper.TypeToVar(TSaveDialog_sw);
end;

function Dialogs_TColorDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialogOption = (cdFullOpen, cdPreventFullOpen,...

  Result := TLMDUnitWrapper.TypeToVar(TColorDialogOption_sw);
end;

function Dialogs_TColorDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialogOptions = set of TColorDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TColorDialogOptions_sw);
end;

function Dialogs_TColorDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TColorDialog_sw);
end;

function Dialogs_TFontDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogOption = (fdAnsiOnly, fdTrueTypeOnly, fdE...

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogOption_sw);
end;

function Dialogs_TFontDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogOptions = set of TFontDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogOptions_sw);
end;

function Dialogs_TFontDialogDevice_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialogDevice = (fdScreen, fdPrinter, fdBoth);

  Result := TLMDUnitWrapper.TypeToVar(TFontDialogDevice_sw);
end;

function Dialogs_TFDApplyEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFDApplyEvent = procedure (Sender: TObject; Wnd: HWN...

  Result := TLMDUnitWrapper.TypeToVar(TFDApplyEvent_sw);
end;

function Dialogs_TFontDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFontDialog_sw);
end;

function Dialogs_TPrinterSetupDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterSetupDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterSetupDialog_sw);
end;

function Dialogs_TPrintRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintRange = (prAllPages, prSelection, prPageNums);

  Result := TLMDUnitWrapper.TypeToVar(TPrintRange_sw);
end;

function Dialogs_TPrintDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOption = (poPrintToFile, poPageNums, poS...

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOption_sw);
end;

function Dialogs_TPrintDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOptions = set of TPrintDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOptions_sw);
end;

function Dialogs_TPrintDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialog_sw);
end;

function Dialogs_TPrinterOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterOrientation = Printers.TPrinterOrientation;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterOrientation_sw);
end;

function Dialogs_TPageSetupDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOption = (psoDefaultMinMargins, psoD...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOption_sw);
end;

function Dialogs_TPageSetupDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOptions = set of TPageSetupDialogOpt...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOptions_sw);
end;

function Dialogs_TPrinterKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterKind = (pkDotMatrix, pkHPPCL);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterKind_sw);
end;

function Dialogs_TPageType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageType = (ptEnvelope, ptPaper);

  Result := TLMDUnitWrapper.TypeToVar(TPageType_sw);
end;

function Dialogs_TPageSetupBeforePaintEvent_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupBeforePaintEvent = procedure (Sender: TObj...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupBeforePaintEvent_sw);
end;

function Dialogs_TPageMeasureUnits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageMeasureUnits = (pmDefault, pmMillimeters, pmInc...

  Result := TLMDUnitWrapper.TypeToVar(TPageMeasureUnits_sw);
end;

function Dialogs_TPaintPageEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPaintPageEvent = procedure (Sender: TObject; Canvas...

  Result := TLMDUnitWrapper.TypeToVar(TPaintPageEvent_sw);
end;

function Dialogs_TPageSetupDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialog_sw);
end;

function Dialogs_TFindOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindOption = (frDown, frFindNext, frHideMatchCase, ...

  Result := TLMDUnitWrapper.TypeToVar(TFindOption_sw);
end;

function Dialogs_TFindOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindOptions = set of TFindOption;

  Result := TLMDUnitWrapper.TypeToVar(TFindOptions_sw);
end;

function Dialogs_TFindDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindDialog = class(TCommonDialog);

  Result := TLMDUnitWrapper.TypeToVar(TFindDialog_sw);
end;

function Dialogs_TReplaceDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReplaceDialog = class(TFindDialog);

  Result := TLMDUnitWrapper.TypeToVar(TReplaceDialog_sw);
end;

function Dialogs_TMsgDlgType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgType = (mtWarning, mtError, mtInformation, mt...

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgType_sw);
end;

function Dialogs_TMsgDlgBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, ...

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgBtn_sw);
end;

function Dialogs_TMsgDlgButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgButtons = set of TMsgDlgBtn;

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgButtons_sw);
end;

function Dialogs_mbYesNoCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesNoCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbYesNoCancel), mbYesNoCancel);
end;

function Dialogs_mbYesAllNoAllCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbYesAllNoAllCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbYesAllNoAllCancel), mbYesAllNoAllCancel);
end;

function Dialogs_mbOKCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbOKCancel = <value>;

  Result := LMDSetToVar(SizeOf(mbOKCancel), mbOKCancel);
end;

function Dialogs_mbAbortRetryIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAbortRetryIgnore = <value>;

  Result := LMDSetToVar(SizeOf(mbAbortRetryIgnore), mbAbortRetryIgnore);
end;

function Dialogs_mbAbortIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mbAbortIgnore = <value>;

  Result := LMDSetToVar(SizeOf(mbAbortIgnore), mbAbortIgnore);
end;

function Dialogs_CreateMessageDialog_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CreateMessageDialog(const Msg: string; DlgType: ...

  Result := TForm_sw.ToVar(Dialogs.CreateMessageDialog(string(AArgs[0]), 
    TMsgDlgType_sw.FromVar(AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2])));
end;

function Dialogs_MessageDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MessageDlg(const Msg: string; DlgType: TMsgDlgTy...

  Result := Dialogs.MessageDlg(string(AArgs[0]), TMsgDlgType_sw.FromVar(
    AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]));
end;

function Dialogs_MessageDlgPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MessageDlgPos(const Msg: string; DlgType: TMsgDl...

  Result := Dialogs.MessageDlgPos(string(AArgs[0]), TMsgDlgType_sw.FromVar(
    AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]), Integer(
    AArgs[4]), Integer(AArgs[5]));
end;

function Dialogs_MessageDlgPosHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function MessageDlgPosHelp(const Msg: string; DlgType: TM...

  Result := Dialogs.MessageDlgPosHelp(string(AArgs[0]), TMsgDlgType_sw.FromVar(
    AArgs[1]), TMsgDlgButtons_sw.FromVar(AArgs[2]), Longint(AArgs[3]), Integer(
    AArgs[4]), Integer(AArgs[5]), string(AArgs[6]));
end;

function Dialogs_ShowMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowMessage(const Msg: string);

  Dialogs.ShowMessage(string(AArgs[0]));
end;

function Dialogs_ShowMessagePos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ShowMessagePos(const Msg: string; X: Integer; Y...

  Dialogs.ShowMessagePos(string(AArgs[0]), Integer(AArgs[1]), Integer(
    AArgs[2]));
end;

function Dialogs_InputBox_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function InputBox(const ACaption: string; const APrompt: ...

  Result := Dialogs.InputBox(string(AArgs[0]), string(AArgs[1]), string(
    AArgs[2]));
end;

function Dialogs_InputQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function InputQuery(const ACaption: string; const APrompt...

  v_1 := string(AArgs[2]);
  Result := Dialogs.InputQuery(string(AArgs[0]), string(AArgs[1]), v_1);
  AssignRefParam(AArgs[2], v_1);
end;

function Dialogs_PromptForFileName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: string;
begin
  // function PromptForFileName(var AFileName: string; const A...

  case AArgsSize of
    1:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1);
      AssignRefParam(AArgs[0], v_1);
    end;
    2:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1, string(AArgs[1]));
      AssignRefParam(AArgs[0], v_1);
    end;
    3:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]));
      AssignRefParam(AArgs[0], v_1);
    end;
    4:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]));
      AssignRefParam(AArgs[0], v_1);
    end;
    5:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]), string(AArgs[4]));
      AssignRefParam(AArgs[0], v_1);
    end;
    6:
    begin
      v_1 := string(AArgs[0]);
      Result := Dialogs.PromptForFileName(v_1, string(AArgs[1]), string(
        AArgs[2]), string(AArgs[3]), string(AArgs[4]), Boolean(AArgs[5]));
      AssignRefParam(AArgs[0], v_1);
    end;
  else
    WrongArgCountError('PromptForFileName');
  end;
end;

function Dialogs_ForceCurrentDirectory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ForceCurrentDirectory: Boolean;

  if IsGet then
    Result := Dialogs.ForceCurrentDirectory
  else
    Dialogs.ForceCurrentDirectory := Boolean(AArgs[0]);
end;

class function Dialogs_sw.GetUnitName: WideString;
begin
  Result := 'Dialogs';
end;

class procedure Dialogs_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('MaxCustomColors', Dialogs_MaxCustomColors_si, nil, VarType(Dialogs.MaxCustomColors));
  AData.AddType(TCommonDialog_sw, Dialogs_TCommonDialog_si);
  AData.AddType(TOpenOption_sw, Dialogs_TOpenOption_si);
  AData.AddType(TOpenOptions_sw, Dialogs_TOpenOptions_si);
  AData.AddType(TOpenOptionEx_sw, Dialogs_TOpenOptionEx_si);
  AData.AddType(TOpenOptionsEx_sw, Dialogs_TOpenOptionsEx_si);
  AData.AddType(TFileEditStyle_sw, Dialogs_TFileEditStyle_si);
  AData.AddType(TOFNotifyEx_sw, Dialogs_TOFNotifyEx_si);
  AData.AddType(TIncludeItemEvent_sw, Dialogs_TIncludeItemEvent_si);
  AData.AddType(TOpenDialog_sw, Dialogs_TOpenDialog_si);
  AData.AddType(TSaveDialog_sw, Dialogs_TSaveDialog_si);
  AData.AddType(TColorDialogOption_sw, Dialogs_TColorDialogOption_si);
  AData.AddType(TColorDialogOptions_sw, Dialogs_TColorDialogOptions_si);
  AData.AddType(TColorDialog_sw, Dialogs_TColorDialog_si);
  AData.AddType(TFontDialogOption_sw, Dialogs_TFontDialogOption_si);
  AData.AddType(TFontDialogOptions_sw, Dialogs_TFontDialogOptions_si);
  AData.AddType(TFontDialogDevice_sw, Dialogs_TFontDialogDevice_si);
  AData.AddType(TFDApplyEvent_sw, Dialogs_TFDApplyEvent_si);
  AData.AddType(TFontDialog_sw, Dialogs_TFontDialog_si);
  AData.AddType(TPrinterSetupDialog_sw, Dialogs_TPrinterSetupDialog_si);
  AData.AddType(TPrintRange_sw, Dialogs_TPrintRange_si);
  AData.AddType(TPrintDialogOption_sw, Dialogs_TPrintDialogOption_si);
  AData.AddType(TPrintDialogOptions_sw, Dialogs_TPrintDialogOptions_si);
  AData.AddType(TPrintDialog_sw, Dialogs_TPrintDialog_si);
  AData.AddType(TPrinterOrientation_sw, Dialogs_TPrinterOrientation_si);
  AData.AddType(TPageSetupDialogOption_sw, Dialogs_TPageSetupDialogOption_si);
  AData.AddType(TPageSetupDialogOptions_sw, Dialogs_TPageSetupDialogOptions_si);
  AData.AddType(TPrinterKind_sw, Dialogs_TPrinterKind_si);
  AData.AddType(TPageType_sw, Dialogs_TPageType_si);
  AData.AddType(TPageSetupBeforePaintEvent_sw, Dialogs_TPageSetupBeforePaintEvent_si);
  AData.AddType(TPageMeasureUnits_sw, Dialogs_TPageMeasureUnits_si);
  AData.AddType(TPaintPageEvent_sw, Dialogs_TPaintPageEvent_si);
  AData.AddType(TPageSetupDialog_sw, Dialogs_TPageSetupDialog_si);
  AData.AddType(TFindOption_sw, Dialogs_TFindOption_si);
  AData.AddType(TFindOptions_sw, Dialogs_TFindOptions_si);
  AData.AddType(TFindDialog_sw, Dialogs_TFindDialog_si);
  AData.AddType(TReplaceDialog_sw, Dialogs_TReplaceDialog_si);
  AData.AddType(TMsgDlgType_sw, Dialogs_TMsgDlgType_si);
  AData.AddType(TMsgDlgBtn_sw, Dialogs_TMsgDlgBtn_si);
  AData.AddType(TMsgDlgButtons_sw, Dialogs_TMsgDlgButtons_si);
  AData.AddConstant('mbYesNoCancel', Dialogs_mbYesNoCancel_si, nil, varInteger);
  AData.AddConstant('mbYesAllNoAllCancel', Dialogs_mbYesAllNoAllCancel_si, nil, varInteger);
  AData.AddConstant('mbOKCancel', Dialogs_mbOKCancel_si, nil, varInteger);
  AData.AddConstant('mbAbortRetryIgnore', Dialogs_mbAbortRetryIgnore_si, nil, varInteger);
  AData.AddConstant('mbAbortIgnore', Dialogs_mbAbortIgnore_si, nil, varInteger);
  AData.AddFunction('CreateMessageDialog', Dialogs_CreateMessageDialog_si, TForm_sw, 3, False);
  AData.AddFunction('MessageDlg', Dialogs_MessageDlg_si, Integer_sw, 4, False);
  AData.AddFunction('MessageDlgPos', Dialogs_MessageDlgPos_si, Integer_sw, 6, False);
  AData.AddFunction('MessageDlgPosHelp', Dialogs_MessageDlgPosHelp_si, Integer_sw, 7, False);
  AData.AddProcedure('ShowMessage', Dialogs_ShowMessage_si, 1, False);
  AData.AddProcedure('ShowMessagePos', Dialogs_ShowMessagePos_si, 3, False);
  AData.AddFunction('InputBox', Dialogs_InputBox_si, string_sw, 3, False);
  AData.AddFunction('InputQuery', Dialogs_InputQuery_si, Boolean_sw, 3, False);
  AData.AddFunction('PromptForFileName', Dialogs_PromptForFileName_si, Boolean_sw, 1, True);
  AData.AddVariable('ForceCurrentDirectory', Dialogs_ForceCurrentDirectory_si, Boolean_sw);
end;

class function Dialogs_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Dialogs_sw);
end;

initialization
  RegisterUnitWrapper(Dialogs_sw);
  RegisterClassWrapper(TCommonDialog_sw);
  RegisterClassWrapper(TOpenDialog_sw);
  RegisterClassWrapper(TSaveDialog_sw);
  RegisterClassWrapper(TColorDialog_sw);
  RegisterClassWrapper(TFontDialog_sw);
  RegisterClassWrapper(TPrinterSetupDialog_sw);
  RegisterClassWrapper(TPrintDialog_sw);
  RegisterClassWrapper(TPageSetupDialog_sw);
  RegisterClassWrapper(TFindDialog_sw);
  RegisterClassWrapper(TReplaceDialog_sw);
  RegisterEventWrapper(TypeInfo(TIncludeItemEvent), TIncludeItemEvent_sw);
  RegisterEventWrapper(TypeInfo(TFDApplyEvent), TFDApplyEvent_sw);
  RegisterEventWrapper(TypeInfo(TPageSetupBeforePaintEvent), TPageSetupBeforePaintEvent_sw);
  RegisterEventWrapper(TypeInfo(TPaintPageEvent), TPaintPageEvent_sw);

end.
