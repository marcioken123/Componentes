unit System.UITypes_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.UITypes' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Classes, System.SysUtils, System.Variants,
  System.TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  System.UITypes;


{ Type wrappers }

type

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

  TPageMeasureUnits_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPageMeasureUnits): OleVariant;
    class function FromVar(const AValue: OleVariant): TPageMeasureUnits;
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

  TCalDayOfWeek_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCalDayOfWeek): OleVariant;
    class function FromVar(const AValue: OleVariant): TCalDayOfWeek;
  end;

  TBorderIcon_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBorderIcon): OleVariant;
    class function FromVar(const AValue: OleVariant): TBorderIcon;
  end;

  TBorderIcons_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TBorderIcons): OleVariant;
    class function FromVar(const AValue: OleVariant): TBorderIcons;
  end;

  TWindowState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TWindowState): OleVariant;
    class function FromVar(const AValue: OleVariant): TWindowState;
  end;

  TEditCharCase_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TEditCharCase): OleVariant;
    class function FromVar(const AValue: OleVariant): TEditCharCase;
  end;

  TFontCharset_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFontCharset): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontCharset;
  end;

  TFontPitch_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontPitch): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontPitch;
  end;

  TFontQuality_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontQuality): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontQuality;
  end;

  TFontStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TFontStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStyle;
  end;

  TFontStyles_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontStyles): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStyles;
  end;

  TFontName_sw = class(string_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TFontName): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontName;
  end;

  TFontDataName_sw = string_sw;

  TFontStylesBase_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TFontStylesBase): OleVariant;
    class function FromVar(const AValue: OleVariant): TFontStylesBase;
  end;

  TCloseAction_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCloseAction): OleVariant;
    class function FromVar(const AValue: OleVariant): TCloseAction;
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

  TTabOrder_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TTabOrder): OleVariant;
    class function FromVar(const AValue: OleVariant): TTabOrder;
  end;

  TModalResult_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TModalResult): OleVariant;
    class function FromVar(const AValue: OleVariant): TModalResult;
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

  TScrollCode_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollCode): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollCode;
  end;

  TPrinterState_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterState): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterState;
  end;

  TPrinterOrientation_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterOrientation): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterOrientation;
  end;

  TPrinterCapability_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TPrinterCapability): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterCapability;
  end;

  TPrinterCapabilities_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TPrinterCapabilities): OleVariant;
    class function FromVar(const AValue: OleVariant): TPrinterCapabilities;
  end;

  TCursor_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TCursor): OleVariant;
    class function FromVar(const AValue: OleVariant): TCursor;
  end;

  TColorRef_sw = UInt32_sw;

  TColor_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TColor): OleVariant;
    class function FromVar(const AValue: OleVariant): TColor;
  end;

  TColorRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TColorRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TColorRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorRec;
  end;

  TColors_sw = TColorRec_sw;

  TAlphaColor_sw = class(Cardinal_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TAlphaColor): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlphaColor;
  end;

  TAlphaColorRec_sw = class(TLMDRecordWrapper)
  private
    FValue: TAlphaColorRec;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TAlphaColorRec): OleVariant;
    class function FromVar(const AValue: OleVariant): TAlphaColorRec;
  end;

  TAlphaColors_sw = TAlphaColorRec_sw;

  TImageIndex_sw = class(Integer_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TImageIndex): OleVariant;
    class function FromVar(const AValue: OleVariant): TImageIndex;
  end;

  TScrollStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollStyle;
  end;


{ Unit wrapper }

type
  UITypes_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

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
  ENUMS: array[0..11] of TLMDEnumerator = (
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
    (Name: 'mbHelp'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbHelp)),
    (Name: 'mbClose'; Value: Integer({$IFDEF LMDSCT_12}TMsgDlgBtn.{$ENDIF}mbClose))
  );
begin
  AEnums := @ENUMS;
  ACount := 12;
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

{ TCalDayOfWeek_sw }

class function TCalDayOfWeek_sw.GetTypeName: WideString;
begin
  Result := 'TCalDayOfWeek';
end;

class procedure TCalDayOfWeek_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..7] of TLMDEnumerator = (
    (Name: 'dowMonday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowMonday)),
    (Name: 'dowTuesday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowTuesday)),
    (Name: 'dowWednesday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowWednesday)),
    (Name: 'dowThursday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowThursday)),
    (Name: 'dowFriday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowFriday)),
    (Name: 'dowSaturday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowSaturday)),
    (Name: 'dowSunday'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowSunday)),
    (Name: 'dowLocaleDefault'; Value: Integer({$IFDEF LMDSCT_12}TCalDayOfWeek.{$ENDIF}dowLocaleDefault))
  );
begin
  AEnums := @ENUMS;
  ACount := 8;
end;

class function TCalDayOfWeek_sw.ToVar(const AValue: TCalDayOfWeek): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCalDayOfWeek_sw.FromVar(
  const AValue: OleVariant): TCalDayOfWeek;
begin
  Result := TCalDayOfWeek(Integer(AValue));
end;

{ TBorderIcon_sw }

class function TBorderIcon_sw.GetTypeName: WideString;
begin
  Result := 'TBorderIcon';
end;

class procedure TBorderIcon_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'biSystemMenu'; Value: Integer({$IFDEF LMDSCT_12}TBorderIcon.{$ENDIF}biSystemMenu)),
    (Name: 'biMinimize'; Value: Integer({$IFDEF LMDSCT_12}TBorderIcon.{$ENDIF}biMinimize)),
    (Name: 'biMaximize'; Value: Integer({$IFDEF LMDSCT_12}TBorderIcon.{$ENDIF}biMaximize)),
    (Name: 'biHelp'; Value: Integer({$IFDEF LMDSCT_12}TBorderIcon.{$ENDIF}biHelp))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TBorderIcon_sw.ToVar(const AValue: TBorderIcon): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBorderIcon_sw.FromVar(const AValue: OleVariant): TBorderIcon;
begin
  Result := TBorderIcon(Integer(AValue));
end;

{ TBorderIcons_sw }

class function TBorderIcons_sw.GetTypeName: WideString;
begin
  Result := 'TBorderIcons';
end;

class function TBorderIcons_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TBorderIcons);
end;

class function TBorderIcons_sw.ToVar(const AValue: TBorderIcons): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TBorderIcons_sw.FromVar(const AValue: OleVariant): TBorderIcons;
begin
  ConvFromVar(AValue, @Result);
end;

{ TWindowState_sw }

class function TWindowState_sw.GetTypeName: WideString;
begin
  Result := 'TWindowState';
end;

class procedure TWindowState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'wsNormal'; Value: Integer({$IFDEF LMDSCT_12}TWindowState.{$ENDIF}wsNormal)),
    (Name: 'wsMinimized'; Value: Integer({$IFDEF LMDSCT_12}TWindowState.{$ENDIF}wsMinimized)),
    (Name: 'wsMaximized'; Value: Integer({$IFDEF LMDSCT_12}TWindowState.{$ENDIF}wsMaximized))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TWindowState_sw.ToVar(const AValue: TWindowState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TWindowState_sw.FromVar(const AValue: OleVariant): TWindowState;
begin
  Result := TWindowState(Integer(AValue));
end;

{ TEditCharCase_sw }

class function TEditCharCase_sw.GetTypeName: WideString;
begin
  Result := 'TEditCharCase';
end;

class procedure TEditCharCase_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ecNormal'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecNormal)),
    (Name: 'ecUpperCase'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecUpperCase)),
    (Name: 'ecLowerCase'; Value: Integer({$IFDEF LMDSCT_12}TEditCharCase.{$ENDIF}ecLowerCase))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TEditCharCase_sw.ToVar(const AValue: TEditCharCase): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TEditCharCase_sw.FromVar(
  const AValue: OleVariant): TEditCharCase;
begin
  Result := TEditCharCase(Integer(AValue));
end;

{ TFontCharset_sw }

class function TFontCharset_sw.GetTypeName: WideString;
begin
  Result := 'TFontCharset';
end;

class function TFontCharset_sw.ToVar(const AValue: TFontCharset): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontCharset_sw.FromVar(const AValue: OleVariant): TFontCharset;
begin
  Result := TFontCharset(Integer(AValue));
end;

{ TFontPitch_sw }

class function TFontPitch_sw.GetTypeName: WideString;
begin
  Result := 'TFontPitch';
end;

class procedure TFontPitch_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fpDefault'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpDefault)),
    (Name: 'fpVariable'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpVariable)),
    (Name: 'fpFixed'; Value: Integer({$IFDEF LMDSCT_12}TFontPitch.{$ENDIF}fpFixed))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TFontPitch_sw.ToVar(const AValue: TFontPitch): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontPitch_sw.FromVar(const AValue: OleVariant): TFontPitch;
begin
  Result := TFontPitch(Integer(AValue));
end;

{ TFontQuality_sw }

class function TFontQuality_sw.GetTypeName: WideString;
begin
  Result := 'TFontQuality';
end;

class procedure TFontQuality_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'fqDefault'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqDefault)),
    (Name: 'fqDraft'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqDraft)),
    (Name: 'fqProof'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqProof)),
    (Name: 'fqNonAntialiased'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqNonAntialiased)),
    (Name: 'fqAntialiased'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqAntialiased)),
    (Name: 'fqClearType'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqClearType)),
    (Name: 'fqClearTypeNatural'; Value: Integer({$IFDEF LMDSCT_12}TFontQuality.{$ENDIF}fqClearTypeNatural))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TFontQuality_sw.ToVar(const AValue: TFontQuality): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontQuality_sw.FromVar(const AValue: OleVariant): TFontQuality;
begin
  Result := TFontQuality(Integer(AValue));
end;

{ TFontStyle_sw }

class function TFontStyle_sw.GetTypeName: WideString;
begin
  Result := 'TFontStyle';
end;

class procedure TFontStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'fsBold'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsBold)),
    (Name: 'fsItalic'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsItalic)),
    (Name: 'fsUnderline'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsUnderline)),
    (Name: 'fsStrikeOut'; Value: Integer({$IFDEF LMDSCT_12}TFontStyle.{$ENDIF}fsStrikeOut))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TFontStyle_sw.ToVar(const AValue: TFontStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFontStyle_sw.FromVar(const AValue: OleVariant): TFontStyle;
begin
  Result := TFontStyle(Integer(AValue));
end;

{ TFontStyles_sw }

class function TFontStyles_sw.GetTypeName: WideString;
begin
  Result := 'TFontStyles';
end;

class function TFontStyles_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontStyles);
end;

class function TFontStyles_sw.ToVar(const AValue: TFontStyles): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontStyles_sw.FromVar(const AValue: OleVariant): TFontStyles;
begin
  ConvFromVar(AValue, @Result);
end;

{ TFontName_sw }

class function TFontName_sw.GetTypeName: WideString;
begin
  Result := 'TFontName';
end;

class function TFontName_sw.ToVar(const AValue: TFontName): OleVariant;
begin
  Result := string_sw.ToVar(string(AValue));
end;

class function TFontName_sw.FromVar(const AValue: OleVariant): TFontName;
begin
  Result := TFontName(string_sw.FromVar(AValue));
end;

{ TFontStylesBase_sw }

class function TFontStylesBase_sw.GetTypeName: WideString;
begin
  Result := 'TFontStylesBase';
end;

class function TFontStylesBase_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TFontStylesBase);
end;

class function TFontStylesBase_sw.ToVar(
  const AValue: TFontStylesBase): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TFontStylesBase_sw.FromVar(
  const AValue: OleVariant): TFontStylesBase;
begin
  ConvFromVar(AValue, @Result);
end;

{ TCloseAction_sw }

class function TCloseAction_sw.GetTypeName: WideString;
begin
  Result := 'TCloseAction';
end;

class procedure TCloseAction_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'caNone'; Value: Integer({$IFDEF LMDSCT_12}TCloseAction.{$ENDIF}caNone)),
    (Name: 'caHide'; Value: Integer({$IFDEF LMDSCT_12}TCloseAction.{$ENDIF}caHide)),
    (Name: 'caFree'; Value: Integer({$IFDEF LMDSCT_12}TCloseAction.{$ENDIF}caFree)),
    (Name: 'caMinimize'; Value: Integer({$IFDEF LMDSCT_12}TCloseAction.{$ENDIF}caMinimize))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TCloseAction_sw.ToVar(const AValue: TCloseAction): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCloseAction_sw.FromVar(const AValue: OleVariant): TCloseAction;
begin
  Result := TCloseAction(Integer(AValue));
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

{ TScrollCode_sw }

class function TScrollCode_sw.GetTypeName: WideString;
begin
  Result := 'TScrollCode';
end;

class procedure TScrollCode_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'scLineUp'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scLineUp)),
    (Name: 'scLineDown'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scLineDown)),
    (Name: 'scPageUp'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPageUp)),
    (Name: 'scPageDown'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPageDown)),
    (Name: 'scPosition'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scPosition)),
    (Name: 'scTrack'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scTrack)),
    (Name: 'scTop'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scTop)),
    (Name: 'scBottom'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scBottom)),
    (Name: 'scEndScroll'; Value: Integer({$IFDEF LMDSCT_12}TScrollCode.{$ENDIF}scEndScroll))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
end;

class function TScrollCode_sw.ToVar(const AValue: TScrollCode): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollCode_sw.FromVar(const AValue: OleVariant): TScrollCode;
begin
  Result := TScrollCode(Integer(AValue));
end;

{ TPrinterState_sw }

class function TPrinterState_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterState';
end;

class procedure TPrinterState_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'psNoHandle'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psNoHandle)),
    (Name: 'psHandleIC'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psHandleIC)),
    (Name: 'psHandleDC'; Value: Integer({$IFDEF LMDSCT_12}TPrinterState.{$ENDIF}psHandleDC))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrinterState_sw.ToVar(const AValue: TPrinterState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterState_sw.FromVar(
  const AValue: OleVariant): TPrinterState;
begin
  Result := TPrinterState(Integer(AValue));
end;

{ TPrinterOrientation_sw }

class function TPrinterOrientation_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterOrientation';
end;

class procedure TPrinterOrientation_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'poPortrait'; Value: Integer({$IFDEF LMDSCT_12}TPrinterOrientation.{$ENDIF}poPortrait)),
    (Name: 'poLandscape'; Value: Integer({$IFDEF LMDSCT_12}TPrinterOrientation.{$ENDIF}poLandscape))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TPrinterOrientation_sw.ToVar(
  const AValue: TPrinterOrientation): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterOrientation_sw.FromVar(
  const AValue: OleVariant): TPrinterOrientation;
begin
  Result := TPrinterOrientation(Integer(AValue));
end;

{ TPrinterCapability_sw }

class function TPrinterCapability_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterCapability';
end;

class procedure TPrinterCapability_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'pcCopies'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcCopies)),
    (Name: 'pcOrientation'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcOrientation)),
    (Name: 'pcCollation'; Value: Integer({$IFDEF LMDSCT_12}TPrinterCapability.{$ENDIF}pcCollation))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TPrinterCapability_sw.ToVar(
  const AValue: TPrinterCapability): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TPrinterCapability_sw.FromVar(
  const AValue: OleVariant): TPrinterCapability;
begin
  Result := TPrinterCapability(Integer(AValue));
end;

{ TPrinterCapabilities_sw }

class function TPrinterCapabilities_sw.GetTypeName: WideString;
begin
  Result := 'TPrinterCapabilities';
end;

class function TPrinterCapabilities_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TPrinterCapabilities);
end;

class function TPrinterCapabilities_sw.ToVar(
  const AValue: TPrinterCapabilities): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TPrinterCapabilities_sw.FromVar(
  const AValue: OleVariant): TPrinterCapabilities;
begin
  ConvFromVar(AValue, @Result);
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

{ TColor_sw }

class function TColor_sw.GetTypeName: WideString;
begin
  Result := 'TColor';
end;

class function TColor_sw.ToVar(const AValue: TColor): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColor_sw.FromVar(const AValue: OleVariant): TColor;
begin
  Result := TColor(Integer(AValue));
end;

{ TColorRec_sw }

function TColorRec_SystemColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SystemColor = <value>;

  Result := TColorRec.SystemColor;
end;

function TColorRec_cSCROLLBAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cSCROLLBAR = <value>;

  Result := TColorRec.cSCROLLBAR;
end;

function TColorRec_cBACKGROUND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBACKGROUND = <value>;

  Result := TColorRec.cBACKGROUND;
end;

function TColorRec_cACTIVECAPTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cACTIVECAPTION = <value>;

  Result := TColorRec.cACTIVECAPTION;
end;

function TColorRec_cINACTIVECAPTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cINACTIVECAPTION = <value>;

  Result := TColorRec.cINACTIVECAPTION;
end;

function TColorRec_cMENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cMENU = <value>;

  Result := TColorRec.cMENU;
end;

function TColorRec_cWINDOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cWINDOW = <value>;

  Result := TColorRec.cWINDOW;
end;

function TColorRec_cWINDOWFRAME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cWINDOWFRAME = <value>;

  Result := TColorRec.cWINDOWFRAME;
end;

function TColorRec_cMENUTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cMENUTEXT = <value>;

  Result := TColorRec.cMENUTEXT;
end;

function TColorRec_cWINDOWTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cWINDOWTEXT = <value>;

  Result := TColorRec.cWINDOWTEXT;
end;

function TColorRec_cCAPTIONTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cCAPTIONTEXT = <value>;

  Result := TColorRec.cCAPTIONTEXT;
end;

function TColorRec_cACTIVEBORDER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cACTIVEBORDER = <value>;

  Result := TColorRec.cACTIVEBORDER;
end;

function TColorRec_cINACTIVEBORDER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cINACTIVEBORDER = <value>;

  Result := TColorRec.cINACTIVEBORDER;
end;

function TColorRec_cAPPWORKSPACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cAPPWORKSPACE = <value>;

  Result := TColorRec.cAPPWORKSPACE;
end;

function TColorRec_cHIGHLIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cHIGHLIGHT = <value>;

  Result := TColorRec.cHIGHLIGHT;
end;

function TColorRec_cHIGHLIGHTTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cHIGHLIGHTTEXT = <value>;

  Result := TColorRec.cHIGHLIGHTTEXT;
end;

function TColorRec_cBTNFACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBTNFACE = <value>;

  Result := TColorRec.cBTNFACE;
end;

function TColorRec_cBTNSHADOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBTNSHADOW = <value>;

  Result := TColorRec.cBTNSHADOW;
end;

function TColorRec_cGRAYTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cGRAYTEXT = <value>;

  Result := TColorRec.cGRAYTEXT;
end;

function TColorRec_cBTNTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBTNTEXT = <value>;

  Result := TColorRec.cBTNTEXT;
end;

function TColorRec_cINACTIVECAPTIONTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cINACTIVECAPTIONTEXT = <value>;

  Result := TColorRec.cINACTIVECAPTIONTEXT;
end;

function TColorRec_cBTNHIGHLIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBTNHIGHLIGHT = <value>;

  Result := TColorRec.cBTNHIGHLIGHT;
end;

function TColorRec_c3DDKSHADOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DDKSHADOW = <value>;

  Result := TColorRec.c3DDKSHADOW;
end;

function TColorRec_c3DLIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DLIGHT = <value>;

  Result := TColorRec.c3DLIGHT;
end;

function TColorRec_cINFOTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cINFOTEXT = <value>;

  Result := TColorRec.cINFOTEXT;
end;

function TColorRec_cINFOBK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cINFOBK = <value>;

  Result := TColorRec.cINFOBK;
end;

function TColorRec_cHOTLIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cHOTLIGHT = <value>;

  Result := TColorRec.cHOTLIGHT;
end;

function TColorRec_cGRADIENTACTIVECAPTION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cGRADIENTACTIVECAPTION = <value>;

  Result := TColorRec.cGRADIENTACTIVECAPTION;
end;

function TColorRec_cGRADIENTINACTIVECAPTION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cGRADIENTINACTIVECAPTION = <value>;

  Result := TColorRec.cGRADIENTINACTIVECAPTION;
end;

function TColorRec_cMENUHILIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cMENUHILIGHT = <value>;

  Result := TColorRec.cMENUHILIGHT;
end;

function TColorRec_cMENUBAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cMENUBAR = <value>;

  Result := TColorRec.cMENUBAR;
end;

function TColorRec_cENDCOLORS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cENDCOLORS = <value>;

  Result := TColorRec.cENDCOLORS;
end;

function TColorRec_cDESKTOP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cDESKTOP = <value>;

  Result := TColorRec.cDESKTOP;
end;

function TColorRec_c3DFACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DFACE = <value>;

  Result := TColorRec.c3DFACE;
end;

function TColorRec_c3DSHADOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DSHADOW = <value>;

  Result := TColorRec.c3DSHADOW;
end;

function TColorRec_c3DHIGHLIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DHIGHLIGHT = <value>;

  Result := TColorRec.c3DHIGHLIGHT;
end;

function TColorRec_c3DHILIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const c3DHILIGHT = <value>;

  Result := TColorRec.c3DHILIGHT;
end;

function TColorRec_cBTNHILIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cBTNHILIGHT = <value>;

  Result := TColorRec.cBTNHILIGHT;
end;

function TColorRec_SysScrollBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysScrollBar = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysScrollBar);
end;

function TColorRec_SysBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysBackground = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysBackground);
end;

function TColorRec_SysActiveCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysActiveCaption = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysActiveCaption);
end;

function TColorRec_SysInactiveCaption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysInactiveCaption = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysInactiveCaption);
end;

function TColorRec_SysMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysMenu = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysMenu);
end;

function TColorRec_SysWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysWindow = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysWindow);
end;

function TColorRec_SysWindowFrame_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysWindowFrame = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysWindowFrame);
end;

function TColorRec_SysMenuText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysMenuText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysMenuText);
end;

function TColorRec_SysWindowText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysWindowText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysWindowText);
end;

function TColorRec_SysCaptionText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysCaptionText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysCaptionText);
end;

function TColorRec_SysActiveBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysActiveBorder = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysActiveBorder);
end;

function TColorRec_SysInactiveBorder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysInactiveBorder = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysInactiveBorder);
end;

function TColorRec_SysAppWorkSpace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysAppWorkSpace = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysAppWorkSpace);
end;

function TColorRec_SysHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysHighlight = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysHighlight);
end;

function TColorRec_SysHighlightText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysHighlightText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysHighlightText);
end;

function TColorRec_SysBtnFace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysBtnFace = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysBtnFace);
end;

function TColorRec_SysBtnShadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysBtnShadow = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysBtnShadow);
end;

function TColorRec_SysGrayText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysGrayText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysGrayText);
end;

function TColorRec_SysBtnText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysBtnText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysBtnText);
end;

function TColorRec_SysInactiveCaptionText_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysInactiveCaptionText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysInactiveCaptionText);
end;

function TColorRec_SysBtnHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysBtnHighlight = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysBtnHighlight);
end;

function TColorRec_Sys3DDkShadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sys3DDkShadow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Sys3DDkShadow);
end;

function TColorRec_Sys3DLight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sys3DLight = <value>;

  Result := TColor_sw.ToVar(TColorRec.Sys3DLight);
end;

function TColorRec_SysInfoText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysInfoText = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysInfoText);
end;

function TColorRec_SysInfoBk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysInfoBk = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysInfoBk);
end;

function TColorRec_SysHotLight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysHotLight = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysHotLight);
end;

function TColorRec_SysGradientActiveCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysGradientActiveCaption = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysGradientActiveCaption);
end;

function TColorRec_SysGradientInactiveCaption_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysGradientInactiveCaption = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysGradientInactiveCaption);
end;

function TColorRec_SysMenuHighlight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysMenuHighlight = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysMenuHighlight);
end;

function TColorRec_SysMenuBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysMenuBar = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysMenuBar);
end;

function TColorRec_SysNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysNone = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysNone);
end;

function TColorRec_SysDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SysDefault = <value>;

  Result := TColor_sw.ToVar(TColorRec.SysDefault);
end;

function TColorRec_Aliceblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aliceblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Aliceblue);
end;

function TColorRec_Antiquewhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Antiquewhite = <value>;

  Result := TColor_sw.ToVar(TColorRec.Antiquewhite);
end;

function TColorRec_Aqua_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aqua = <value>;

  Result := TColor_sw.ToVar(TColorRec.Aqua);
end;

function TColorRec_Aquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aquamarine = <value>;

  Result := TColor_sw.ToVar(TColorRec.Aquamarine);
end;

function TColorRec_Azure_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Azure = <value>;

  Result := TColor_sw.ToVar(TColorRec.Azure);
end;

function TColorRec_Beige_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Beige = <value>;

  Result := TColor_sw.ToVar(TColorRec.Beige);
end;

function TColorRec_Bisque_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Bisque = <value>;

  Result := TColor_sw.ToVar(TColorRec.Bisque);
end;

function TColorRec_Black_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Black = <value>;

  Result := TColor_sw.ToVar(TColorRec.Black);
end;

function TColorRec_Blanchedalmond_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blanchedalmond = <value>;

  Result := TColor_sw.ToVar(TColorRec.Blanchedalmond);
end;

function TColorRec_Blue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Blue);
end;

function TColorRec_Blueviolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blueviolet = <value>;

  Result := TColor_sw.ToVar(TColorRec.Blueviolet);
end;

function TColorRec_Brown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Brown = <value>;

  Result := TColor_sw.ToVar(TColorRec.Brown);
end;

function TColorRec_Burlywood_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Burlywood = <value>;

  Result := TColor_sw.ToVar(TColorRec.Burlywood);
end;

function TColorRec_Cadetblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cadetblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Cadetblue);
end;

function TColorRec_Chartreuse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Chartreuse = <value>;

  Result := TColor_sw.ToVar(TColorRec.Chartreuse);
end;

function TColorRec_Chocolate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Chocolate = <value>;

  Result := TColor_sw.ToVar(TColorRec.Chocolate);
end;

function TColorRec_Coral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Coral = <value>;

  Result := TColor_sw.ToVar(TColorRec.Coral);
end;

function TColorRec_Cornflowerblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cornflowerblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Cornflowerblue);
end;

function TColorRec_Cornsilk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cornsilk = <value>;

  Result := TColor_sw.ToVar(TColorRec.Cornsilk);
end;

function TColorRec_Crimson_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Crimson = <value>;

  Result := TColor_sw.ToVar(TColorRec.Crimson);
end;

function TColorRec_Cyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cyan = <value>;

  Result := TColor_sw.ToVar(TColorRec.Cyan);
end;

function TColorRec_Darkblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkblue);
end;

function TColorRec_Darkcyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkcyan = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkcyan);
end;

function TColorRec_Darkgoldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgoldenrod = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkgoldenrod);
end;

function TColorRec_Darkgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkgray);
end;

function TColorRec_Darkgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkgreen);
end;

function TColorRec_Darkgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkgrey);
end;

function TColorRec_Darkkhaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkkhaki = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkkhaki);
end;

function TColorRec_Darkmagenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkmagenta = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkmagenta);
end;

function TColorRec_Darkolivegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkolivegreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkolivegreen);
end;

function TColorRec_Darkorange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkorange = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkorange);
end;

function TColorRec_Darkorchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkorchid = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkorchid);
end;

function TColorRec_Darkred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkred = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkred);
end;

function TColorRec_Darksalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darksalmon = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darksalmon);
end;

function TColorRec_Darkseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkseagreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkseagreen);
end;

function TColorRec_Darkslateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslateblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkslateblue);
end;

function TColorRec_Darkslategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslategray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkslategray);
end;

function TColorRec_Darkslategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslategrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkslategrey);
end;

function TColorRec_Darkturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkturquoise = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkturquoise);
end;

function TColorRec_Darkviolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkviolet = <value>;

  Result := TColor_sw.ToVar(TColorRec.Darkviolet);
end;

function TColorRec_Deeppink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Deeppink = <value>;

  Result := TColor_sw.ToVar(TColorRec.Deeppink);
end;

function TColorRec_Deepskyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Deepskyblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Deepskyblue);
end;

function TColorRec_Dimgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dimgray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Dimgray);
end;

function TColorRec_Dimgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dimgrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Dimgrey);
end;

function TColorRec_Dodgerblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dodgerblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Dodgerblue);
end;

function TColorRec_Firebrick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Firebrick = <value>;

  Result := TColor_sw.ToVar(TColorRec.Firebrick);
end;

function TColorRec_Floralwhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Floralwhite = <value>;

  Result := TColor_sw.ToVar(TColorRec.Floralwhite);
end;

function TColorRec_Forestgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Forestgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Forestgreen);
end;

function TColorRec_Fuchsia_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Fuchsia = <value>;

  Result := TColor_sw.ToVar(TColorRec.Fuchsia);
end;

function TColorRec_Gainsboro_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gainsboro = <value>;

  Result := TColor_sw.ToVar(TColorRec.Gainsboro);
end;

function TColorRec_Ghostwhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Ghostwhite = <value>;

  Result := TColor_sw.ToVar(TColorRec.Ghostwhite);
end;

function TColorRec_Gold_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gold = <value>;

  Result := TColor_sw.ToVar(TColorRec.Gold);
end;

function TColorRec_Goldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Goldenrod = <value>;

  Result := TColor_sw.ToVar(TColorRec.Goldenrod);
end;

function TColorRec_Gray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Gray);
end;

function TColorRec_Green_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Green = <value>;

  Result := TColor_sw.ToVar(TColorRec.Green);
end;

function TColorRec_Greenyellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Greenyellow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Greenyellow);
end;

function TColorRec_Grey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Grey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Grey);
end;

function TColorRec_Honeydew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Honeydew = <value>;

  Result := TColor_sw.ToVar(TColorRec.Honeydew);
end;

function TColorRec_Hotpink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Hotpink = <value>;

  Result := TColor_sw.ToVar(TColorRec.Hotpink);
end;

function TColorRec_Indianred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Indianred = <value>;

  Result := TColor_sw.ToVar(TColorRec.Indianred);
end;

function TColorRec_Indigo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Indigo = <value>;

  Result := TColor_sw.ToVar(TColorRec.Indigo);
end;

function TColorRec_Ivory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Ivory = <value>;

  Result := TColor_sw.ToVar(TColorRec.Ivory);
end;

function TColorRec_Khaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Khaki = <value>;

  Result := TColor_sw.ToVar(TColorRec.Khaki);
end;

function TColorRec_Lavender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lavender = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lavender);
end;

function TColorRec_Lavenderblush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lavenderblush = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lavenderblush);
end;

function TColorRec_Lawngreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lawngreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lawngreen);
end;

function TColorRec_Lemonchiffon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lemonchiffon = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lemonchiffon);
end;

function TColorRec_Lightblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightblue);
end;

function TColorRec_Lightcoral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightcoral = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightcoral);
end;

function TColorRec_Lightcyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightcyan = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightcyan);
end;

function TColorRec_Lightgoldenrodyellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgoldenrodyellow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightgoldenrodyellow);
end;

function TColorRec_Lightgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightgray);
end;

function TColorRec_Lightgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightgreen);
end;

function TColorRec_Lightgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightgrey);
end;

function TColorRec_Lightpink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightpink = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightpink);
end;

function TColorRec_Lightsalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightsalmon = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightsalmon);
end;

function TColorRec_Lightseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightseagreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightseagreen);
end;

function TColorRec_Lightskyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightskyblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightskyblue);
end;

function TColorRec_Lightslategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightslategray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightslategray);
end;

function TColorRec_Lightslategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightslategrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightslategrey);
end;

function TColorRec_Lightsteelblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightsteelblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightsteelblue);
end;

function TColorRec_Lightyellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightyellow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lightyellow);
end;

function TColorRec_LtGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LtGray = <value>;

  Result := TColor_sw.ToVar(TColorRec.LtGray);
end;

function TColorRec_MedGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MedGray = <value>;

  Result := TColor_sw.ToVar(TColorRec.MedGray);
end;

function TColorRec_DkGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DkGray = <value>;

  Result := TColor_sw.ToVar(TColorRec.DkGray);
end;

function TColorRec_MoneyGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MoneyGreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.MoneyGreen);
end;

function TColorRec_LegacySkyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LegacySkyBlue = <value>;

  Result := TColor_sw.ToVar(TColorRec.LegacySkyBlue);
end;

function TColorRec_Cream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cream = <value>;

  Result := TColor_sw.ToVar(TColorRec.Cream);
end;

function TColorRec_Lime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lime = <value>;

  Result := TColor_sw.ToVar(TColorRec.Lime);
end;

function TColorRec_Limegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Limegreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Limegreen);
end;

function TColorRec_Linen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Linen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Linen);
end;

function TColorRec_Magenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Magenta = <value>;

  Result := TColor_sw.ToVar(TColorRec.Magenta);
end;

function TColorRec_Maroon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Maroon = <value>;

  Result := TColor_sw.ToVar(TColorRec.Maroon);
end;

function TColorRec_Mediumaquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumaquamarine = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumaquamarine);
end;

function TColorRec_Mediumblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumblue);
end;

function TColorRec_Mediumorchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumorchid = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumorchid);
end;

function TColorRec_Mediumpurple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumpurple = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumpurple);
end;

function TColorRec_Mediumseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumseagreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumseagreen);
end;

function TColorRec_Mediumslateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumslateblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumslateblue);
end;

function TColorRec_Mediumspringgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumspringgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumspringgreen);
end;

function TColorRec_Mediumturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumturquoise = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumturquoise);
end;

function TColorRec_Mediumvioletred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumvioletred = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mediumvioletred);
end;

function TColorRec_Midnightblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Midnightblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Midnightblue);
end;

function TColorRec_Mintcream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mintcream = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mintcream);
end;

function TColorRec_Mistyrose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mistyrose = <value>;

  Result := TColor_sw.ToVar(TColorRec.Mistyrose);
end;

function TColorRec_Moccasin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Moccasin = <value>;

  Result := TColor_sw.ToVar(TColorRec.Moccasin);
end;

function TColorRec_Navajowhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Navajowhite = <value>;

  Result := TColor_sw.ToVar(TColorRec.Navajowhite);
end;

function TColorRec_Navy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Navy = <value>;

  Result := TColor_sw.ToVar(TColorRec.Navy);
end;

function TColorRec_Oldlace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Oldlace = <value>;

  Result := TColor_sw.ToVar(TColorRec.Oldlace);
end;

function TColorRec_Olive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Olive = <value>;

  Result := TColor_sw.ToVar(TColorRec.Olive);
end;

function TColorRec_Olivedrab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Olivedrab = <value>;

  Result := TColor_sw.ToVar(TColorRec.Olivedrab);
end;

function TColorRec_Orange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orange = <value>;

  Result := TColor_sw.ToVar(TColorRec.Orange);
end;

function TColorRec_Orangered_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orangered = <value>;

  Result := TColor_sw.ToVar(TColorRec.Orangered);
end;

function TColorRec_Orchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orchid = <value>;

  Result := TColor_sw.ToVar(TColorRec.Orchid);
end;

function TColorRec_Palegoldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palegoldenrod = <value>;

  Result := TColor_sw.ToVar(TColorRec.Palegoldenrod);
end;

function TColorRec_Palegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palegreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Palegreen);
end;

function TColorRec_Paleturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Paleturquoise = <value>;

  Result := TColor_sw.ToVar(TColorRec.Paleturquoise);
end;

function TColorRec_Palevioletred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palevioletred = <value>;

  Result := TColor_sw.ToVar(TColorRec.Palevioletred);
end;

function TColorRec_Papayawhip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Papayawhip = <value>;

  Result := TColor_sw.ToVar(TColorRec.Papayawhip);
end;

function TColorRec_Peachpuff_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Peachpuff = <value>;

  Result := TColor_sw.ToVar(TColorRec.Peachpuff);
end;

function TColorRec_Peru_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Peru = <value>;

  Result := TColor_sw.ToVar(TColorRec.Peru);
end;

function TColorRec_Pink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Pink = <value>;

  Result := TColor_sw.ToVar(TColorRec.Pink);
end;

function TColorRec_Plum_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Plum = <value>;

  Result := TColor_sw.ToVar(TColorRec.Plum);
end;

function TColorRec_Powderblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Powderblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Powderblue);
end;

function TColorRec_Purple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Purple = <value>;

  Result := TColor_sw.ToVar(TColorRec.Purple);
end;

function TColorRec_Red_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Red = <value>;

  Result := TColor_sw.ToVar(TColorRec.Red);
end;

function TColorRec_Rosybrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Rosybrown = <value>;

  Result := TColor_sw.ToVar(TColorRec.Rosybrown);
end;

function TColorRec_Royalblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Royalblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Royalblue);
end;

function TColorRec_Saddlebrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Saddlebrown = <value>;

  Result := TColor_sw.ToVar(TColorRec.Saddlebrown);
end;

function TColorRec_Salmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Salmon = <value>;

  Result := TColor_sw.ToVar(TColorRec.Salmon);
end;

function TColorRec_Sandybrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sandybrown = <value>;

  Result := TColor_sw.ToVar(TColorRec.Sandybrown);
end;

function TColorRec_Seagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Seagreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Seagreen);
end;

function TColorRec_Seashell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Seashell = <value>;

  Result := TColor_sw.ToVar(TColorRec.Seashell);
end;

function TColorRec_Sienna_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sienna = <value>;

  Result := TColor_sw.ToVar(TColorRec.Sienna);
end;

function TColorRec_Silver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Silver = <value>;

  Result := TColor_sw.ToVar(TColorRec.Silver);
end;

function TColorRec_Skyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Skyblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Skyblue);
end;

function TColorRec_Slateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slateblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Slateblue);
end;

function TColorRec_Slategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slategray = <value>;

  Result := TColor_sw.ToVar(TColorRec.Slategray);
end;

function TColorRec_Slategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slategrey = <value>;

  Result := TColor_sw.ToVar(TColorRec.Slategrey);
end;

function TColorRec_Snow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Snow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Snow);
end;

function TColorRec_Springgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Springgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Springgreen);
end;

function TColorRec_Steelblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Steelblue = <value>;

  Result := TColor_sw.ToVar(TColorRec.Steelblue);
end;

function TColorRec_Tan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Tan = <value>;

  Result := TColor_sw.ToVar(TColorRec.Tan);
end;

function TColorRec_Teal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Teal = <value>;

  Result := TColor_sw.ToVar(TColorRec.Teal);
end;

function TColorRec_Thistle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Thistle = <value>;

  Result := TColor_sw.ToVar(TColorRec.Thistle);
end;

function TColorRec_Tomato_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Tomato = <value>;

  Result := TColor_sw.ToVar(TColorRec.Tomato);
end;

function TColorRec_Turquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Turquoise = <value>;

  Result := TColor_sw.ToVar(TColorRec.Turquoise);
end;

function TColorRec_Violet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Violet = <value>;

  Result := TColor_sw.ToVar(TColorRec.Violet);
end;

function TColorRec_Wheat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Wheat = <value>;

  Result := TColor_sw.ToVar(TColorRec.Wheat);
end;

function TColorRec_White_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const White = <value>;

  Result := TColor_sw.ToVar(TColorRec.White);
end;

function TColorRec_Whitesmoke_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Whitesmoke = <value>;

  Result := TColor_sw.ToVar(TColorRec.Whitesmoke);
end;

function TColorRec_Yellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Yellow = <value>;

  Result := TColor_sw.ToVar(TColorRec.Yellow);
end;

function TColorRec_Yellowgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Yellowgreen = <value>;

  Result := TColor_sw.ToVar(TColorRec.Yellowgreen);
end;

function TColorRec_Null_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Null = <value>;

  Result := TColor_sw.ToVar(TColorRec.Null);
end;

function TColorRec_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Color: TColor;

  if IsGet then
    Result := TColor_sw.ToVar(TColorRec_sw(AObj).FValue.Color)
  else
    TColorRec_sw(AObj).FValue.Color := TColor_sw.FromVar(AArgs[0]);
end;

function TColorRec_HiWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HiWord: Word;

  if IsGet then
    Result := TColorRec_sw(AObj).FValue.HiWord
  else
    TColorRec_sw(AObj).FValue.HiWord := Word(AArgs[0]);
end;

function TColorRec_LoWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LoWord: Word;

  if IsGet then
    Result := TColorRec_sw(AObj).FValue.LoWord
  else
    TColorRec_sw(AObj).FValue.LoWord := Word(AArgs[0]);
end;

function TColorRec_R_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var R: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TColorRec_sw(AObj).FValue.R)
  else
    TColorRec_sw(AObj).FValue.R := LMDSctSysWrappers.Byte_sw.FromVar(AArgs[0]);
end;

function TColorRec_G_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var G: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TColorRec_sw(AObj).FValue.G)
  else
    TColorRec_sw(AObj).FValue.G := LMDSctSysWrappers.Byte_sw.FromVar(AArgs[0]);
end;

function TColorRec_B_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var B: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TColorRec_sw(AObj).FValue.B)
  else
    TColorRec_sw(AObj).FValue.B := LMDSctSysWrappers.Byte_sw.FromVar(AArgs[0]);
end;

function TColorRec_A_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var A: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TColorRec_sw(AObj).FValue.A)
  else
    TColorRec_sw(AObj).FValue.A := LMDSctSysWrappers.Byte_sw.FromVar(AArgs[0]);
end;

function TColorRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TColorRec_sw.Create as IDispatch;
end;

function TColorRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TColorRec;

  // Implicit record copy method.
  Result := TColorRec_sw.ToVar(TColorRec(AObj));
end;

class function TColorRec_sw.GetTypeName: WideString;
begin
  Result := 'TColorRec';
end;

function TColorRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TColorRec_sw.Create;
  TColorRec_sw(Result).FValue := FValue;
end;

class procedure TColorRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Color', TColorRec_Color_si, TColor_sw);
  AData.AddField('HiWord', TColorRec_HiWord_si, Word_sw);
  AData.AddField('LoWord', TColorRec_LoWord_si, Word_sw);
  AData.AddField('R', TColorRec_R_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('G', TColorRec_G_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('B', TColorRec_B_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('A', TColorRec_A_si, LMDSctSysWrappers.Byte_sw);
  AData.AddFunction('Copy', TColorRec_Copy_si, TColorRec_sw, 0, False);

  { Class members }

  AData.AddConstant('SystemColor', TColorRec_SystemColor_si, nil, VarType(TColorRec.SystemColor));
  AData.AddConstant('cSCROLLBAR', TColorRec_cSCROLLBAR_si, nil, VarType(TColorRec.cSCROLLBAR));
  AData.AddConstant('cBACKGROUND', TColorRec_cBACKGROUND_si, nil, VarType(TColorRec.cBACKGROUND));
  AData.AddConstant('cACTIVECAPTION', TColorRec_cACTIVECAPTION_si, nil, VarType(TColorRec.cACTIVECAPTION));
  AData.AddConstant('cINACTIVECAPTION', TColorRec_cINACTIVECAPTION_si, nil, VarType(TColorRec.cINACTIVECAPTION));
  AData.AddConstant('cMENU', TColorRec_cMENU_si, nil, VarType(TColorRec.cMENU));
  AData.AddConstant('cWINDOW', TColorRec_cWINDOW_si, nil, VarType(TColorRec.cWINDOW));
  AData.AddConstant('cWINDOWFRAME', TColorRec_cWINDOWFRAME_si, nil, VarType(TColorRec.cWINDOWFRAME));
  AData.AddConstant('cMENUTEXT', TColorRec_cMENUTEXT_si, nil, VarType(TColorRec.cMENUTEXT));
  AData.AddConstant('cWINDOWTEXT', TColorRec_cWINDOWTEXT_si, nil, VarType(TColorRec.cWINDOWTEXT));
  AData.AddConstant('cCAPTIONTEXT', TColorRec_cCAPTIONTEXT_si, nil, VarType(TColorRec.cCAPTIONTEXT));
  AData.AddConstant('cACTIVEBORDER', TColorRec_cACTIVEBORDER_si, nil, VarType(TColorRec.cACTIVEBORDER));
  AData.AddConstant('cINACTIVEBORDER', TColorRec_cINACTIVEBORDER_si, nil, VarType(TColorRec.cINACTIVEBORDER));
  AData.AddConstant('cAPPWORKSPACE', TColorRec_cAPPWORKSPACE_si, nil, VarType(TColorRec.cAPPWORKSPACE));
  AData.AddConstant('cHIGHLIGHT', TColorRec_cHIGHLIGHT_si, nil, VarType(TColorRec.cHIGHLIGHT));
  AData.AddConstant('cHIGHLIGHTTEXT', TColorRec_cHIGHLIGHTTEXT_si, nil, VarType(TColorRec.cHIGHLIGHTTEXT));
  AData.AddConstant('cBTNFACE', TColorRec_cBTNFACE_si, nil, VarType(TColorRec.cBTNFACE));
  AData.AddConstant('cBTNSHADOW', TColorRec_cBTNSHADOW_si, nil, VarType(TColorRec.cBTNSHADOW));
  AData.AddConstant('cGRAYTEXT', TColorRec_cGRAYTEXT_si, nil, VarType(TColorRec.cGRAYTEXT));
  AData.AddConstant('cBTNTEXT', TColorRec_cBTNTEXT_si, nil, VarType(TColorRec.cBTNTEXT));
  AData.AddConstant('cINACTIVECAPTIONTEXT', TColorRec_cINACTIVECAPTIONTEXT_si, nil, VarType(TColorRec.cINACTIVECAPTIONTEXT));
  AData.AddConstant('cBTNHIGHLIGHT', TColorRec_cBTNHIGHLIGHT_si, nil, VarType(TColorRec.cBTNHIGHLIGHT));
  AData.AddConstant('c3DDKSHADOW', TColorRec_c3DDKSHADOW_si, nil, VarType(TColorRec.c3DDKSHADOW));
  AData.AddConstant('c3DLIGHT', TColorRec_c3DLIGHT_si, nil, VarType(TColorRec.c3DLIGHT));
  AData.AddConstant('cINFOTEXT', TColorRec_cINFOTEXT_si, nil, VarType(TColorRec.cINFOTEXT));
  AData.AddConstant('cINFOBK', TColorRec_cINFOBK_si, nil, VarType(TColorRec.cINFOBK));
  AData.AddConstant('cHOTLIGHT', TColorRec_cHOTLIGHT_si, nil, VarType(TColorRec.cHOTLIGHT));
  AData.AddConstant('cGRADIENTACTIVECAPTION', TColorRec_cGRADIENTACTIVECAPTION_si, nil, VarType(TColorRec.cGRADIENTACTIVECAPTION));
  AData.AddConstant('cGRADIENTINACTIVECAPTION', TColorRec_cGRADIENTINACTIVECAPTION_si, nil, VarType(TColorRec.cGRADIENTINACTIVECAPTION));
  AData.AddConstant('cMENUHILIGHT', TColorRec_cMENUHILIGHT_si, nil, VarType(TColorRec.cMENUHILIGHT));
  AData.AddConstant('cMENUBAR', TColorRec_cMENUBAR_si, nil, VarType(TColorRec.cMENUBAR));
  AData.AddConstant('cENDCOLORS', TColorRec_cENDCOLORS_si, Integer_sw);
  AData.AddConstant('cDESKTOP', TColorRec_cDESKTOP_si, Integer_sw);
  AData.AddConstant('c3DFACE', TColorRec_c3DFACE_si, Integer_sw);
  AData.AddConstant('c3DSHADOW', TColorRec_c3DSHADOW_si, Integer_sw);
  AData.AddConstant('c3DHIGHLIGHT', TColorRec_c3DHIGHLIGHT_si, Integer_sw);
  AData.AddConstant('c3DHILIGHT', TColorRec_c3DHILIGHT_si, Integer_sw);
  AData.AddConstant('cBTNHILIGHT', TColorRec_cBTNHILIGHT_si, Integer_sw);
  AData.AddConstant('SysScrollBar', TColorRec_SysScrollBar_si, TColor_sw);
  AData.AddConstant('SysBackground', TColorRec_SysBackground_si, TColor_sw);
  AData.AddConstant('SysActiveCaption', TColorRec_SysActiveCaption_si, TColor_sw);
  AData.AddConstant('SysInactiveCaption', TColorRec_SysInactiveCaption_si, TColor_sw);
  AData.AddConstant('SysMenu', TColorRec_SysMenu_si, TColor_sw);
  AData.AddConstant('SysWindow', TColorRec_SysWindow_si, TColor_sw);
  AData.AddConstant('SysWindowFrame', TColorRec_SysWindowFrame_si, TColor_sw);
  AData.AddConstant('SysMenuText', TColorRec_SysMenuText_si, TColor_sw);
  AData.AddConstant('SysWindowText', TColorRec_SysWindowText_si, TColor_sw);
  AData.AddConstant('SysCaptionText', TColorRec_SysCaptionText_si, TColor_sw);
  AData.AddConstant('SysActiveBorder', TColorRec_SysActiveBorder_si, TColor_sw);
  AData.AddConstant('SysInactiveBorder', TColorRec_SysInactiveBorder_si, TColor_sw);
  AData.AddConstant('SysAppWorkSpace', TColorRec_SysAppWorkSpace_si, TColor_sw);
  AData.AddConstant('SysHighlight', TColorRec_SysHighlight_si, TColor_sw);
  AData.AddConstant('SysHighlightText', TColorRec_SysHighlightText_si, TColor_sw);
  AData.AddConstant('SysBtnFace', TColorRec_SysBtnFace_si, TColor_sw);
  AData.AddConstant('SysBtnShadow', TColorRec_SysBtnShadow_si, TColor_sw);
  AData.AddConstant('SysGrayText', TColorRec_SysGrayText_si, TColor_sw);
  AData.AddConstant('SysBtnText', TColorRec_SysBtnText_si, TColor_sw);
  AData.AddConstant('SysInactiveCaptionText', TColorRec_SysInactiveCaptionText_si, TColor_sw);
  AData.AddConstant('SysBtnHighlight', TColorRec_SysBtnHighlight_si, TColor_sw);
  AData.AddConstant('Sys3DDkShadow', TColorRec_Sys3DDkShadow_si, TColor_sw);
  AData.AddConstant('Sys3DLight', TColorRec_Sys3DLight_si, TColor_sw);
  AData.AddConstant('SysInfoText', TColorRec_SysInfoText_si, TColor_sw);
  AData.AddConstant('SysInfoBk', TColorRec_SysInfoBk_si, TColor_sw);
  AData.AddConstant('SysHotLight', TColorRec_SysHotLight_si, TColor_sw);
  AData.AddConstant('SysGradientActiveCaption', TColorRec_SysGradientActiveCaption_si, TColor_sw);
  AData.AddConstant('SysGradientInactiveCaption', TColorRec_SysGradientInactiveCaption_si, TColor_sw);
  AData.AddConstant('SysMenuHighlight', TColorRec_SysMenuHighlight_si, TColor_sw);
  AData.AddConstant('SysMenuBar', TColorRec_SysMenuBar_si, TColor_sw);
  AData.AddConstant('SysNone', TColorRec_SysNone_si, TColor_sw);
  AData.AddConstant('SysDefault', TColorRec_SysDefault_si, TColor_sw);
  AData.AddConstant('Aliceblue', TColorRec_Aliceblue_si, TColor_sw);
  AData.AddConstant('Antiquewhite', TColorRec_Antiquewhite_si, TColor_sw);
  AData.AddConstant('Aqua', TColorRec_Aqua_si, TColor_sw);
  AData.AddConstant('Aquamarine', TColorRec_Aquamarine_si, TColor_sw);
  AData.AddConstant('Azure', TColorRec_Azure_si, TColor_sw);
  AData.AddConstant('Beige', TColorRec_Beige_si, TColor_sw);
  AData.AddConstant('Bisque', TColorRec_Bisque_si, TColor_sw);
  AData.AddConstant('Black', TColorRec_Black_si, TColor_sw);
  AData.AddConstant('Blanchedalmond', TColorRec_Blanchedalmond_si, TColor_sw);
  AData.AddConstant('Blue', TColorRec_Blue_si, TColor_sw);
  AData.AddConstant('Blueviolet', TColorRec_Blueviolet_si, TColor_sw);
  AData.AddConstant('Brown', TColorRec_Brown_si, TColor_sw);
  AData.AddConstant('Burlywood', TColorRec_Burlywood_si, TColor_sw);
  AData.AddConstant('Cadetblue', TColorRec_Cadetblue_si, TColor_sw);
  AData.AddConstant('Chartreuse', TColorRec_Chartreuse_si, TColor_sw);
  AData.AddConstant('Chocolate', TColorRec_Chocolate_si, TColor_sw);
  AData.AddConstant('Coral', TColorRec_Coral_si, TColor_sw);
  AData.AddConstant('Cornflowerblue', TColorRec_Cornflowerblue_si, TColor_sw);
  AData.AddConstant('Cornsilk', TColorRec_Cornsilk_si, TColor_sw);
  AData.AddConstant('Crimson', TColorRec_Crimson_si, TColor_sw);
  AData.AddConstant('Cyan', TColorRec_Cyan_si, TColor_sw);
  AData.AddConstant('Darkblue', TColorRec_Darkblue_si, TColor_sw);
  AData.AddConstant('Darkcyan', TColorRec_Darkcyan_si, TColor_sw);
  AData.AddConstant('Darkgoldenrod', TColorRec_Darkgoldenrod_si, TColor_sw);
  AData.AddConstant('Darkgray', TColorRec_Darkgray_si, TColor_sw);
  AData.AddConstant('Darkgreen', TColorRec_Darkgreen_si, TColor_sw);
  AData.AddConstant('Darkgrey', TColorRec_Darkgrey_si, TColor_sw);
  AData.AddConstant('Darkkhaki', TColorRec_Darkkhaki_si, TColor_sw);
  AData.AddConstant('Darkmagenta', TColorRec_Darkmagenta_si, TColor_sw);
  AData.AddConstant('Darkolivegreen', TColorRec_Darkolivegreen_si, TColor_sw);
  AData.AddConstant('Darkorange', TColorRec_Darkorange_si, TColor_sw);
  AData.AddConstant('Darkorchid', TColorRec_Darkorchid_si, TColor_sw);
  AData.AddConstant('Darkred', TColorRec_Darkred_si, TColor_sw);
  AData.AddConstant('Darksalmon', TColorRec_Darksalmon_si, TColor_sw);
  AData.AddConstant('Darkseagreen', TColorRec_Darkseagreen_si, TColor_sw);
  AData.AddConstant('Darkslateblue', TColorRec_Darkslateblue_si, TColor_sw);
  AData.AddConstant('Darkslategray', TColorRec_Darkslategray_si, TColor_sw);
  AData.AddConstant('Darkslategrey', TColorRec_Darkslategrey_si, TColor_sw);
  AData.AddConstant('Darkturquoise', TColorRec_Darkturquoise_si, TColor_sw);
  AData.AddConstant('Darkviolet', TColorRec_Darkviolet_si, TColor_sw);
  AData.AddConstant('Deeppink', TColorRec_Deeppink_si, TColor_sw);
  AData.AddConstant('Deepskyblue', TColorRec_Deepskyblue_si, TColor_sw);
  AData.AddConstant('Dimgray', TColorRec_Dimgray_si, TColor_sw);
  AData.AddConstant('Dimgrey', TColorRec_Dimgrey_si, TColor_sw);
  AData.AddConstant('Dodgerblue', TColorRec_Dodgerblue_si, TColor_sw);
  AData.AddConstant('Firebrick', TColorRec_Firebrick_si, TColor_sw);
  AData.AddConstant('Floralwhite', TColorRec_Floralwhite_si, TColor_sw);
  AData.AddConstant('Forestgreen', TColorRec_Forestgreen_si, TColor_sw);
  AData.AddConstant('Fuchsia', TColorRec_Fuchsia_si, TColor_sw);
  AData.AddConstant('Gainsboro', TColorRec_Gainsboro_si, TColor_sw);
  AData.AddConstant('Ghostwhite', TColorRec_Ghostwhite_si, TColor_sw);
  AData.AddConstant('Gold', TColorRec_Gold_si, TColor_sw);
  AData.AddConstant('Goldenrod', TColorRec_Goldenrod_si, TColor_sw);
  AData.AddConstant('Gray', TColorRec_Gray_si, TColor_sw);
  AData.AddConstant('Green', TColorRec_Green_si, TColor_sw);
  AData.AddConstant('Greenyellow', TColorRec_Greenyellow_si, TColor_sw);
  AData.AddConstant('Grey', TColorRec_Grey_si, TColor_sw);
  AData.AddConstant('Honeydew', TColorRec_Honeydew_si, TColor_sw);
  AData.AddConstant('Hotpink', TColorRec_Hotpink_si, TColor_sw);
  AData.AddConstant('Indianred', TColorRec_Indianred_si, TColor_sw);
  AData.AddConstant('Indigo', TColorRec_Indigo_si, TColor_sw);
  AData.AddConstant('Ivory', TColorRec_Ivory_si, TColor_sw);
  AData.AddConstant('Khaki', TColorRec_Khaki_si, TColor_sw);
  AData.AddConstant('Lavender', TColorRec_Lavender_si, TColor_sw);
  AData.AddConstant('Lavenderblush', TColorRec_Lavenderblush_si, TColor_sw);
  AData.AddConstant('Lawngreen', TColorRec_Lawngreen_si, TColor_sw);
  AData.AddConstant('Lemonchiffon', TColorRec_Lemonchiffon_si, TColor_sw);
  AData.AddConstant('Lightblue', TColorRec_Lightblue_si, TColor_sw);
  AData.AddConstant('Lightcoral', TColorRec_Lightcoral_si, TColor_sw);
  AData.AddConstant('Lightcyan', TColorRec_Lightcyan_si, TColor_sw);
  AData.AddConstant('Lightgoldenrodyellow', TColorRec_Lightgoldenrodyellow_si, TColor_sw);
  AData.AddConstant('Lightgray', TColorRec_Lightgray_si, TColor_sw);
  AData.AddConstant('Lightgreen', TColorRec_Lightgreen_si, TColor_sw);
  AData.AddConstant('Lightgrey', TColorRec_Lightgrey_si, TColor_sw);
  AData.AddConstant('Lightpink', TColorRec_Lightpink_si, TColor_sw);
  AData.AddConstant('Lightsalmon', TColorRec_Lightsalmon_si, TColor_sw);
  AData.AddConstant('Lightseagreen', TColorRec_Lightseagreen_si, TColor_sw);
  AData.AddConstant('Lightskyblue', TColorRec_Lightskyblue_si, TColor_sw);
  AData.AddConstant('Lightslategray', TColorRec_Lightslategray_si, TColor_sw);
  AData.AddConstant('Lightslategrey', TColorRec_Lightslategrey_si, TColor_sw);
  AData.AddConstant('Lightsteelblue', TColorRec_Lightsteelblue_si, TColor_sw);
  AData.AddConstant('Lightyellow', TColorRec_Lightyellow_si, TColor_sw);
  AData.AddConstant('LtGray', TColorRec_LtGray_si, TColor_sw);
  AData.AddConstant('MedGray', TColorRec_MedGray_si, TColor_sw);
  AData.AddConstant('DkGray', TColorRec_DkGray_si, TColor_sw);
  AData.AddConstant('MoneyGreen', TColorRec_MoneyGreen_si, TColor_sw);
  AData.AddConstant('LegacySkyBlue', TColorRec_LegacySkyBlue_si, TColor_sw);
  AData.AddConstant('Cream', TColorRec_Cream_si, TColor_sw);
  AData.AddConstant('Lime', TColorRec_Lime_si, TColor_sw);
  AData.AddConstant('Limegreen', TColorRec_Limegreen_si, TColor_sw);
  AData.AddConstant('Linen', TColorRec_Linen_si, TColor_sw);
  AData.AddConstant('Magenta', TColorRec_Magenta_si, TColor_sw);
  AData.AddConstant('Maroon', TColorRec_Maroon_si, TColor_sw);
  AData.AddConstant('Mediumaquamarine', TColorRec_Mediumaquamarine_si, TColor_sw);
  AData.AddConstant('Mediumblue', TColorRec_Mediumblue_si, TColor_sw);
  AData.AddConstant('Mediumorchid', TColorRec_Mediumorchid_si, TColor_sw);
  AData.AddConstant('Mediumpurple', TColorRec_Mediumpurple_si, TColor_sw);
  AData.AddConstant('Mediumseagreen', TColorRec_Mediumseagreen_si, TColor_sw);
  AData.AddConstant('Mediumslateblue', TColorRec_Mediumslateblue_si, TColor_sw);
  AData.AddConstant('Mediumspringgreen', TColorRec_Mediumspringgreen_si, TColor_sw);
  AData.AddConstant('Mediumturquoise', TColorRec_Mediumturquoise_si, TColor_sw);
  AData.AddConstant('Mediumvioletred', TColorRec_Mediumvioletred_si, TColor_sw);
  AData.AddConstant('Midnightblue', TColorRec_Midnightblue_si, TColor_sw);
  AData.AddConstant('Mintcream', TColorRec_Mintcream_si, TColor_sw);
  AData.AddConstant('Mistyrose', TColorRec_Mistyrose_si, TColor_sw);
  AData.AddConstant('Moccasin', TColorRec_Moccasin_si, TColor_sw);
  AData.AddConstant('Navajowhite', TColorRec_Navajowhite_si, TColor_sw);
  AData.AddConstant('Navy', TColorRec_Navy_si, TColor_sw);
  AData.AddConstant('Oldlace', TColorRec_Oldlace_si, TColor_sw);
  AData.AddConstant('Olive', TColorRec_Olive_si, TColor_sw);
  AData.AddConstant('Olivedrab', TColorRec_Olivedrab_si, TColor_sw);
  AData.AddConstant('Orange', TColorRec_Orange_si, TColor_sw);
  AData.AddConstant('Orangered', TColorRec_Orangered_si, TColor_sw);
  AData.AddConstant('Orchid', TColorRec_Orchid_si, TColor_sw);
  AData.AddConstant('Palegoldenrod', TColorRec_Palegoldenrod_si, TColor_sw);
  AData.AddConstant('Palegreen', TColorRec_Palegreen_si, TColor_sw);
  AData.AddConstant('Paleturquoise', TColorRec_Paleturquoise_si, TColor_sw);
  AData.AddConstant('Palevioletred', TColorRec_Palevioletred_si, TColor_sw);
  AData.AddConstant('Papayawhip', TColorRec_Papayawhip_si, TColor_sw);
  AData.AddConstant('Peachpuff', TColorRec_Peachpuff_si, TColor_sw);
  AData.AddConstant('Peru', TColorRec_Peru_si, TColor_sw);
  AData.AddConstant('Pink', TColorRec_Pink_si, TColor_sw);
  AData.AddConstant('Plum', TColorRec_Plum_si, TColor_sw);
  AData.AddConstant('Powderblue', TColorRec_Powderblue_si, TColor_sw);
  AData.AddConstant('Purple', TColorRec_Purple_si, TColor_sw);
  AData.AddConstant('Red', TColorRec_Red_si, TColor_sw);
  AData.AddConstant('Rosybrown', TColorRec_Rosybrown_si, TColor_sw);
  AData.AddConstant('Royalblue', TColorRec_Royalblue_si, TColor_sw);
  AData.AddConstant('Saddlebrown', TColorRec_Saddlebrown_si, TColor_sw);
  AData.AddConstant('Salmon', TColorRec_Salmon_si, TColor_sw);
  AData.AddConstant('Sandybrown', TColorRec_Sandybrown_si, TColor_sw);
  AData.AddConstant('Seagreen', TColorRec_Seagreen_si, TColor_sw);
  AData.AddConstant('Seashell', TColorRec_Seashell_si, TColor_sw);
  AData.AddConstant('Sienna', TColorRec_Sienna_si, TColor_sw);
  AData.AddConstant('Silver', TColorRec_Silver_si, TColor_sw);
  AData.AddConstant('Skyblue', TColorRec_Skyblue_si, TColor_sw);
  AData.AddConstant('Slateblue', TColorRec_Slateblue_si, TColor_sw);
  AData.AddConstant('Slategray', TColorRec_Slategray_si, TColor_sw);
  AData.AddConstant('Slategrey', TColorRec_Slategrey_si, TColor_sw);
  AData.AddConstant('Snow', TColorRec_Snow_si, TColor_sw);
  AData.AddConstant('Springgreen', TColorRec_Springgreen_si, TColor_sw);
  AData.AddConstant('Steelblue', TColorRec_Steelblue_si, TColor_sw);
  AData.AddConstant('Tan', TColorRec_Tan_si, TColor_sw);
  AData.AddConstant('Teal', TColorRec_Teal_si, TColor_sw);
  AData.AddConstant('Thistle', TColorRec_Thistle_si, TColor_sw);
  AData.AddConstant('Tomato', TColorRec_Tomato_si, TColor_sw);
  AData.AddConstant('Turquoise', TColorRec_Turquoise_si, TColor_sw);
  AData.AddConstant('Violet', TColorRec_Violet_si, TColor_sw);
  AData.AddConstant('Wheat', TColorRec_Wheat_si, TColor_sw);
  AData.AddConstant('White', TColorRec_White_si, TColor_sw);
  AData.AddConstant('Whitesmoke', TColorRec_Whitesmoke_si, TColor_sw);
  AData.AddConstant('Yellow', TColorRec_Yellow_si, TColor_sw);
  AData.AddConstant('Yellowgreen', TColorRec_Yellowgreen_si, TColor_sw);
  AData.AddConstant('Null', TColorRec_Null_si, TColor_sw);
  AData.AddConstructor('Create', TColorRec_Create_si, 0, False);
end;

class function TColorRec_sw.ToVar(const AValue: TColorRec): OleVariant;
var
  wrpr: TColorRec_sw;
begin
  wrpr        := TColorRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TColorRec_sw.FromVar(const AValue: OleVariant): TColorRec;
begin
  Result := TColorRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TAlphaColor_sw }

class function TAlphaColor_sw.GetTypeName: WideString;
begin
  Result := 'TAlphaColor';
end;

class function TAlphaColor_sw.ToVar(const AValue: TAlphaColor): OleVariant;
begin
  Result := Cardinal_sw.ToVar(Cardinal(AValue));
end;

class function TAlphaColor_sw.FromVar(const AValue: OleVariant): TAlphaColor;
begin
  Result := TAlphaColor(Cardinal_sw.FromVar(AValue));
end;

{ TAlphaColorRec_sw }

function TAlphaColorRec_Alpha_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Alpha = <value>;

  Result := TAlphaColor_sw.ToVar(TAlphaColorRec.Alpha);
end;

function TAlphaColorRec_Aliceblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aliceblue = <value>;

  Result := TAlphaColorRec.Aliceblue;
end;

function TAlphaColorRec_Antiquewhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Antiquewhite = <value>;

  Result := TAlphaColorRec.Antiquewhite;
end;

function TAlphaColorRec_Aqua_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aqua = <value>;

  Result := TAlphaColorRec.Aqua;
end;

function TAlphaColorRec_Aquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Aquamarine = <value>;

  Result := TAlphaColorRec.Aquamarine;
end;

function TAlphaColorRec_Azure_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Azure = <value>;

  Result := TAlphaColorRec.Azure;
end;

function TAlphaColorRec_Beige_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Beige = <value>;

  Result := TAlphaColorRec.Beige;
end;

function TAlphaColorRec_Bisque_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Bisque = <value>;

  Result := TAlphaColorRec.Bisque;
end;

function TAlphaColorRec_Black_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Black = <value>;

  Result := TAlphaColorRec.Black;
end;

function TAlphaColorRec_Blanchedalmond_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blanchedalmond = <value>;

  Result := TAlphaColorRec.Blanchedalmond;
end;

function TAlphaColorRec_Blue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blue = <value>;

  Result := TAlphaColorRec.Blue;
end;

function TAlphaColorRec_Blueviolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Blueviolet = <value>;

  Result := TAlphaColorRec.Blueviolet;
end;

function TAlphaColorRec_Brown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Brown = <value>;

  Result := TAlphaColorRec.Brown;
end;

function TAlphaColorRec_Burlywood_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Burlywood = <value>;

  Result := TAlphaColorRec.Burlywood;
end;

function TAlphaColorRec_Cadetblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cadetblue = <value>;

  Result := TAlphaColorRec.Cadetblue;
end;

function TAlphaColorRec_Chartreuse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Chartreuse = <value>;

  Result := TAlphaColorRec.Chartreuse;
end;

function TAlphaColorRec_Chocolate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Chocolate = <value>;

  Result := TAlphaColorRec.Chocolate;
end;

function TAlphaColorRec_Coral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Coral = <value>;

  Result := TAlphaColorRec.Coral;
end;

function TAlphaColorRec_Cornflowerblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cornflowerblue = <value>;

  Result := TAlphaColorRec.Cornflowerblue;
end;

function TAlphaColorRec_Cornsilk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cornsilk = <value>;

  Result := TAlphaColorRec.Cornsilk;
end;

function TAlphaColorRec_Crimson_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Crimson = <value>;

  Result := TAlphaColorRec.Crimson;
end;

function TAlphaColorRec_Cyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cyan = <value>;

  Result := TAlphaColorRec.Cyan;
end;

function TAlphaColorRec_Darkblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkblue = <value>;

  Result := TAlphaColorRec.Darkblue;
end;

function TAlphaColorRec_Darkcyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkcyan = <value>;

  Result := TAlphaColorRec.Darkcyan;
end;

function TAlphaColorRec_Darkgoldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgoldenrod = <value>;

  Result := TAlphaColorRec.Darkgoldenrod;
end;

function TAlphaColorRec_Darkgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgray = <value>;

  Result := TAlphaColorRec.Darkgray;
end;

function TAlphaColorRec_Darkgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgreen = <value>;

  Result := TAlphaColorRec.Darkgreen;
end;

function TAlphaColorRec_Darkgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkgrey = <value>;

  Result := TAlphaColorRec.Darkgrey;
end;

function TAlphaColorRec_Darkkhaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkkhaki = <value>;

  Result := TAlphaColorRec.Darkkhaki;
end;

function TAlphaColorRec_Darkmagenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkmagenta = <value>;

  Result := TAlphaColorRec.Darkmagenta;
end;

function TAlphaColorRec_Darkolivegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkolivegreen = <value>;

  Result := TAlphaColorRec.Darkolivegreen;
end;

function TAlphaColorRec_Darkorange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkorange = <value>;

  Result := TAlphaColorRec.Darkorange;
end;

function TAlphaColorRec_Darkorchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkorchid = <value>;

  Result := TAlphaColorRec.Darkorchid;
end;

function TAlphaColorRec_Darkred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkred = <value>;

  Result := TAlphaColorRec.Darkred;
end;

function TAlphaColorRec_Darksalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darksalmon = <value>;

  Result := TAlphaColorRec.Darksalmon;
end;

function TAlphaColorRec_Darkseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkseagreen = <value>;

  Result := TAlphaColorRec.Darkseagreen;
end;

function TAlphaColorRec_Darkslateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslateblue = <value>;

  Result := TAlphaColorRec.Darkslateblue;
end;

function TAlphaColorRec_Darkslategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslategray = <value>;

  Result := TAlphaColorRec.Darkslategray;
end;

function TAlphaColorRec_Darkslategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkslategrey = <value>;

  Result := TAlphaColorRec.Darkslategrey;
end;

function TAlphaColorRec_Darkturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkturquoise = <value>;

  Result := TAlphaColorRec.Darkturquoise;
end;

function TAlphaColorRec_Darkviolet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Darkviolet = <value>;

  Result := TAlphaColorRec.Darkviolet;
end;

function TAlphaColorRec_Deeppink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Deeppink = <value>;

  Result := TAlphaColorRec.Deeppink;
end;

function TAlphaColorRec_Deepskyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Deepskyblue = <value>;

  Result := TAlphaColorRec.Deepskyblue;
end;

function TAlphaColorRec_Dimgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dimgray = <value>;

  Result := TAlphaColorRec.Dimgray;
end;

function TAlphaColorRec_Dimgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dimgrey = <value>;

  Result := TAlphaColorRec.Dimgrey;
end;

function TAlphaColorRec_Dodgerblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Dodgerblue = <value>;

  Result := TAlphaColorRec.Dodgerblue;
end;

function TAlphaColorRec_Firebrick_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Firebrick = <value>;

  Result := TAlphaColorRec.Firebrick;
end;

function TAlphaColorRec_Floralwhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Floralwhite = <value>;

  Result := TAlphaColorRec.Floralwhite;
end;

function TAlphaColorRec_Forestgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Forestgreen = <value>;

  Result := TAlphaColorRec.Forestgreen;
end;

function TAlphaColorRec_Fuchsia_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Fuchsia = <value>;

  Result := TAlphaColorRec.Fuchsia;
end;

function TAlphaColorRec_Gainsboro_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gainsboro = <value>;

  Result := TAlphaColorRec.Gainsboro;
end;

function TAlphaColorRec_Ghostwhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Ghostwhite = <value>;

  Result := TAlphaColorRec.Ghostwhite;
end;

function TAlphaColorRec_Gold_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gold = <value>;

  Result := TAlphaColorRec.Gold;
end;

function TAlphaColorRec_Goldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Goldenrod = <value>;

  Result := TAlphaColorRec.Goldenrod;
end;

function TAlphaColorRec_Gray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Gray = <value>;

  Result := TAlphaColorRec.Gray;
end;

function TAlphaColorRec_Green_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Green = <value>;

  Result := TAlphaColorRec.Green;
end;

function TAlphaColorRec_Greenyellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Greenyellow = <value>;

  Result := TAlphaColorRec.Greenyellow;
end;

function TAlphaColorRec_Grey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Grey = <value>;

  Result := TAlphaColorRec.Grey;
end;

function TAlphaColorRec_Honeydew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Honeydew = <value>;

  Result := TAlphaColorRec.Honeydew;
end;

function TAlphaColorRec_Hotpink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Hotpink = <value>;

  Result := TAlphaColorRec.Hotpink;
end;

function TAlphaColorRec_Indianred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Indianred = <value>;

  Result := TAlphaColorRec.Indianred;
end;

function TAlphaColorRec_Indigo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Indigo = <value>;

  Result := TAlphaColorRec.Indigo;
end;

function TAlphaColorRec_Ivory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Ivory = <value>;

  Result := TAlphaColorRec.Ivory;
end;

function TAlphaColorRec_Khaki_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Khaki = <value>;

  Result := TAlphaColorRec.Khaki;
end;

function TAlphaColorRec_Lavender_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lavender = <value>;

  Result := TAlphaColorRec.Lavender;
end;

function TAlphaColorRec_Lavenderblush_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lavenderblush = <value>;

  Result := TAlphaColorRec.Lavenderblush;
end;

function TAlphaColorRec_Lawngreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lawngreen = <value>;

  Result := TAlphaColorRec.Lawngreen;
end;

function TAlphaColorRec_Lemonchiffon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lemonchiffon = <value>;

  Result := TAlphaColorRec.Lemonchiffon;
end;

function TAlphaColorRec_Lightblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightblue = <value>;

  Result := TAlphaColorRec.Lightblue;
end;

function TAlphaColorRec_Lightcoral_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightcoral = <value>;

  Result := TAlphaColorRec.Lightcoral;
end;

function TAlphaColorRec_Lightcyan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightcyan = <value>;

  Result := TAlphaColorRec.Lightcyan;
end;

function TAlphaColorRec_Lightgoldenrodyellow_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgoldenrodyellow = <value>;

  Result := TAlphaColorRec.Lightgoldenrodyellow;
end;

function TAlphaColorRec_Lightgray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgray = <value>;

  Result := TAlphaColorRec.Lightgray;
end;

function TAlphaColorRec_Lightgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgreen = <value>;

  Result := TAlphaColorRec.Lightgreen;
end;

function TAlphaColorRec_Lightgrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightgrey = <value>;

  Result := TAlphaColorRec.Lightgrey;
end;

function TAlphaColorRec_Lightpink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightpink = <value>;

  Result := TAlphaColorRec.Lightpink;
end;

function TAlphaColorRec_Lightsalmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightsalmon = <value>;

  Result := TAlphaColorRec.Lightsalmon;
end;

function TAlphaColorRec_Lightseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightseagreen = <value>;

  Result := TAlphaColorRec.Lightseagreen;
end;

function TAlphaColorRec_Lightskyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightskyblue = <value>;

  Result := TAlphaColorRec.Lightskyblue;
end;

function TAlphaColorRec_Lightslategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightslategray = <value>;

  Result := TAlphaColorRec.Lightslategray;
end;

function TAlphaColorRec_Lightslategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightslategrey = <value>;

  Result := TAlphaColorRec.Lightslategrey;
end;

function TAlphaColorRec_Lightsteelblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightsteelblue = <value>;

  Result := TAlphaColorRec.Lightsteelblue;
end;

function TAlphaColorRec_Lightyellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lightyellow = <value>;

  Result := TAlphaColorRec.Lightyellow;
end;

function TAlphaColorRec_LtGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LtGray = <value>;

  Result := TAlphaColorRec.LtGray;
end;

function TAlphaColorRec_MedGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MedGray = <value>;

  Result := TAlphaColorRec.MedGray;
end;

function TAlphaColorRec_DkGray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DkGray = <value>;

  Result := TAlphaColorRec.DkGray;
end;

function TAlphaColorRec_MoneyGreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MoneyGreen = <value>;

  Result := TAlphaColorRec.MoneyGreen;
end;

function TAlphaColorRec_LegacySkyBlue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LegacySkyBlue = <value>;

  Result := TAlphaColorRec.LegacySkyBlue;
end;

function TAlphaColorRec_Cream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Cream = <value>;

  Result := TAlphaColorRec.Cream;
end;

function TAlphaColorRec_Lime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Lime = <value>;

  Result := TAlphaColorRec.Lime;
end;

function TAlphaColorRec_Limegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Limegreen = <value>;

  Result := TAlphaColorRec.Limegreen;
end;

function TAlphaColorRec_Linen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Linen = <value>;

  Result := TAlphaColorRec.Linen;
end;

function TAlphaColorRec_Magenta_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Magenta = <value>;

  Result := TAlphaColorRec.Magenta;
end;

function TAlphaColorRec_Maroon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Maroon = <value>;

  Result := TAlphaColorRec.Maroon;
end;

function TAlphaColorRec_Mediumaquamarine_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumaquamarine = <value>;

  Result := TAlphaColorRec.Mediumaquamarine;
end;

function TAlphaColorRec_Mediumblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumblue = <value>;

  Result := TAlphaColorRec.Mediumblue;
end;

function TAlphaColorRec_Mediumorchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumorchid = <value>;

  Result := TAlphaColorRec.Mediumorchid;
end;

function TAlphaColorRec_Mediumpurple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumpurple = <value>;

  Result := TAlphaColorRec.Mediumpurple;
end;

function TAlphaColorRec_Mediumseagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumseagreen = <value>;

  Result := TAlphaColorRec.Mediumseagreen;
end;

function TAlphaColorRec_Mediumslateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumslateblue = <value>;

  Result := TAlphaColorRec.Mediumslateblue;
end;

function TAlphaColorRec_Mediumspringgreen_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumspringgreen = <value>;

  Result := TAlphaColorRec.Mediumspringgreen;
end;

function TAlphaColorRec_Mediumturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumturquoise = <value>;

  Result := TAlphaColorRec.Mediumturquoise;
end;

function TAlphaColorRec_Mediumvioletred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mediumvioletred = <value>;

  Result := TAlphaColorRec.Mediumvioletred;
end;

function TAlphaColorRec_Midnightblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Midnightblue = <value>;

  Result := TAlphaColorRec.Midnightblue;
end;

function TAlphaColorRec_Mintcream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mintcream = <value>;

  Result := TAlphaColorRec.Mintcream;
end;

function TAlphaColorRec_Mistyrose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Mistyrose = <value>;

  Result := TAlphaColorRec.Mistyrose;
end;

function TAlphaColorRec_Moccasin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Moccasin = <value>;

  Result := TAlphaColorRec.Moccasin;
end;

function TAlphaColorRec_Navajowhite_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Navajowhite = <value>;

  Result := TAlphaColorRec.Navajowhite;
end;

function TAlphaColorRec_Navy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Navy = <value>;

  Result := TAlphaColorRec.Navy;
end;

function TAlphaColorRec_Oldlace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Oldlace = <value>;

  Result := TAlphaColorRec.Oldlace;
end;

function TAlphaColorRec_Olive_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Olive = <value>;

  Result := TAlphaColorRec.Olive;
end;

function TAlphaColorRec_Olivedrab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Olivedrab = <value>;

  Result := TAlphaColorRec.Olivedrab;
end;

function TAlphaColorRec_Orange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orange = <value>;

  Result := TAlphaColorRec.Orange;
end;

function TAlphaColorRec_Orangered_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orangered = <value>;

  Result := TAlphaColorRec.Orangered;
end;

function TAlphaColorRec_Orchid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Orchid = <value>;

  Result := TAlphaColorRec.Orchid;
end;

function TAlphaColorRec_Palegoldenrod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palegoldenrod = <value>;

  Result := TAlphaColorRec.Palegoldenrod;
end;

function TAlphaColorRec_Palegreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palegreen = <value>;

  Result := TAlphaColorRec.Palegreen;
end;

function TAlphaColorRec_Paleturquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Paleturquoise = <value>;

  Result := TAlphaColorRec.Paleturquoise;
end;

function TAlphaColorRec_Palevioletred_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Palevioletred = <value>;

  Result := TAlphaColorRec.Palevioletred;
end;

function TAlphaColorRec_Papayawhip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Papayawhip = <value>;

  Result := TAlphaColorRec.Papayawhip;
end;

function TAlphaColorRec_Peachpuff_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Peachpuff = <value>;

  Result := TAlphaColorRec.Peachpuff;
end;

function TAlphaColorRec_Peru_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Peru = <value>;

  Result := TAlphaColorRec.Peru;
end;

function TAlphaColorRec_Pink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Pink = <value>;

  Result := TAlphaColorRec.Pink;
end;

function TAlphaColorRec_Plum_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Plum = <value>;

  Result := TAlphaColorRec.Plum;
end;

function TAlphaColorRec_Powderblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Powderblue = <value>;

  Result := TAlphaColorRec.Powderblue;
end;

function TAlphaColorRec_Purple_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Purple = <value>;

  Result := TAlphaColorRec.Purple;
end;

function TAlphaColorRec_Red_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Red = <value>;

  Result := TAlphaColorRec.Red;
end;

function TAlphaColorRec_Rosybrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Rosybrown = <value>;

  Result := TAlphaColorRec.Rosybrown;
end;

function TAlphaColorRec_Royalblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Royalblue = <value>;

  Result := TAlphaColorRec.Royalblue;
end;

function TAlphaColorRec_Saddlebrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Saddlebrown = <value>;

  Result := TAlphaColorRec.Saddlebrown;
end;

function TAlphaColorRec_Salmon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Salmon = <value>;

  Result := TAlphaColorRec.Salmon;
end;

function TAlphaColorRec_Sandybrown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sandybrown = <value>;

  Result := TAlphaColorRec.Sandybrown;
end;

function TAlphaColorRec_Seagreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Seagreen = <value>;

  Result := TAlphaColorRec.Seagreen;
end;

function TAlphaColorRec_Seashell_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Seashell = <value>;

  Result := TAlphaColorRec.Seashell;
end;

function TAlphaColorRec_Sienna_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Sienna = <value>;

  Result := TAlphaColorRec.Sienna;
end;

function TAlphaColorRec_Silver_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Silver = <value>;

  Result := TAlphaColorRec.Silver;
end;

function TAlphaColorRec_Skyblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Skyblue = <value>;

  Result := TAlphaColorRec.Skyblue;
end;

function TAlphaColorRec_Slateblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slateblue = <value>;

  Result := TAlphaColorRec.Slateblue;
end;

function TAlphaColorRec_Slategray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slategray = <value>;

  Result := TAlphaColorRec.Slategray;
end;

function TAlphaColorRec_Slategrey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Slategrey = <value>;

  Result := TAlphaColorRec.Slategrey;
end;

function TAlphaColorRec_Snow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Snow = <value>;

  Result := TAlphaColorRec.Snow;
end;

function TAlphaColorRec_Springgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Springgreen = <value>;

  Result := TAlphaColorRec.Springgreen;
end;

function TAlphaColorRec_Steelblue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Steelblue = <value>;

  Result := TAlphaColorRec.Steelblue;
end;

function TAlphaColorRec_Tan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Tan = <value>;

  Result := TAlphaColorRec.Tan;
end;

function TAlphaColorRec_Teal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Teal = <value>;

  Result := TAlphaColorRec.Teal;
end;

function TAlphaColorRec_Thistle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Thistle = <value>;

  Result := TAlphaColorRec.Thistle;
end;

function TAlphaColorRec_Tomato_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Tomato = <value>;

  Result := TAlphaColorRec.Tomato;
end;

function TAlphaColorRec_Turquoise_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Turquoise = <value>;

  Result := TAlphaColorRec.Turquoise;
end;

function TAlphaColorRec_Violet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Violet = <value>;

  Result := TAlphaColorRec.Violet;
end;

function TAlphaColorRec_Wheat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Wheat = <value>;

  Result := TAlphaColorRec.Wheat;
end;

function TAlphaColorRec_White_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const White = <value>;

  Result := TAlphaColorRec.White;
end;

function TAlphaColorRec_Whitesmoke_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Whitesmoke = <value>;

  Result := TAlphaColorRec.Whitesmoke;
end;

function TAlphaColorRec_Yellow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Yellow = <value>;

  Result := TAlphaColorRec.Yellow;
end;

function TAlphaColorRec_Yellowgreen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Yellowgreen = <value>;

  Result := TAlphaColorRec.Yellowgreen;
end;

function TAlphaColorRec_Null_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const Null = <value>;

  Result := TAlphaColor_sw.ToVar(TAlphaColorRec.Null);
end;

function TAlphaColorRec_Color_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Color: TAlphaColor;

  if IsGet then
    Result := TAlphaColor_sw.ToVar(TAlphaColorRec_sw(AObj).FValue.Color)
  else
    TAlphaColorRec_sw(AObj).FValue.Color := TAlphaColor_sw.FromVar(AArgs[0]);
end;

function TAlphaColorRec_HiWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var HiWord: Word;

  if IsGet then
    Result := TAlphaColorRec_sw(AObj).FValue.HiWord
  else
    TAlphaColorRec_sw(AObj).FValue.HiWord := Word(AArgs[0]);
end;

function TAlphaColorRec_LoWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LoWord: Word;

  if IsGet then
    Result := TAlphaColorRec_sw(AObj).FValue.LoWord
  else
    TAlphaColorRec_sw(AObj).FValue.LoWord := Word(AArgs[0]);
end;

function TAlphaColorRec_B_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var B: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TAlphaColorRec_sw(AObj).FValue.B)
  else
    TAlphaColorRec_sw(AObj).FValue.B := LMDSctSysWrappers.Byte_sw.FromVar(
      AArgs[0]);
end;

function TAlphaColorRec_G_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var G: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TAlphaColorRec_sw(AObj).FValue.G)
  else
    TAlphaColorRec_sw(AObj).FValue.G := LMDSctSysWrappers.Byte_sw.FromVar(
      AArgs[0]);
end;

function TAlphaColorRec_R_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var R: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TAlphaColorRec_sw(AObj).FValue.R)
  else
    TAlphaColorRec_sw(AObj).FValue.R := LMDSctSysWrappers.Byte_sw.FromVar(
      AArgs[0]);
end;

function TAlphaColorRec_A_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var A: System.Byte;

  if IsGet then
    Result := LMDSctSysWrappers.Byte_sw.ToVar(TAlphaColorRec_sw(AObj).FValue.A)
  else
    TAlphaColorRec_sw(AObj).FValue.A := LMDSctSysWrappers.Byte_sw.FromVar(
      AArgs[0]);
end;

function TAlphaColorRec_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TAlphaColorRec_sw.Create as IDispatch;
end;

function TAlphaColorRec_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TAlphaColorRec;

  // Implicit record copy method.
  Result := TAlphaColorRec_sw.ToVar(TAlphaColorRec(AObj));
end;

class function TAlphaColorRec_sw.GetTypeName: WideString;
begin
  Result := 'TAlphaColorRec';
end;

function TAlphaColorRec_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TAlphaColorRec_sw.Create;
  TAlphaColorRec_sw(Result).FValue := FValue;
end;

class procedure TAlphaColorRec_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Color', TAlphaColorRec_Color_si, TAlphaColor_sw);
  AData.AddField('HiWord', TAlphaColorRec_HiWord_si, Word_sw);
  AData.AddField('LoWord', TAlphaColorRec_LoWord_si, Word_sw);
  AData.AddField('B', TAlphaColorRec_B_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('G', TAlphaColorRec_G_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('R', TAlphaColorRec_R_si, LMDSctSysWrappers.Byte_sw);
  AData.AddField('A', TAlphaColorRec_A_si, LMDSctSysWrappers.Byte_sw);
  AData.AddFunction('Copy', TAlphaColorRec_Copy_si, TAlphaColorRec_sw, 0, False);

  { Class members }

  AData.AddConstant('Alpha', TAlphaColorRec_Alpha_si, TAlphaColor_sw);
  AData.AddConstant('Aliceblue', TAlphaColorRec_Aliceblue_si, nil, VarType(TAlphaColorRec.Aliceblue));
  AData.AddConstant('Antiquewhite', TAlphaColorRec_Antiquewhite_si, nil, VarType(TAlphaColorRec.Antiquewhite));
  AData.AddConstant('Aqua', TAlphaColorRec_Aqua_si, nil, VarType(TAlphaColorRec.Aqua));
  AData.AddConstant('Aquamarine', TAlphaColorRec_Aquamarine_si, nil, VarType(TAlphaColorRec.Aquamarine));
  AData.AddConstant('Azure', TAlphaColorRec_Azure_si, nil, VarType(TAlphaColorRec.Azure));
  AData.AddConstant('Beige', TAlphaColorRec_Beige_si, nil, VarType(TAlphaColorRec.Beige));
  AData.AddConstant('Bisque', TAlphaColorRec_Bisque_si, nil, VarType(TAlphaColorRec.Bisque));
  AData.AddConstant('Black', TAlphaColorRec_Black_si, nil, VarType(TAlphaColorRec.Black));
  AData.AddConstant('Blanchedalmond', TAlphaColorRec_Blanchedalmond_si, nil, VarType(TAlphaColorRec.Blanchedalmond));
  AData.AddConstant('Blue', TAlphaColorRec_Blue_si, nil, VarType(TAlphaColorRec.Blue));
  AData.AddConstant('Blueviolet', TAlphaColorRec_Blueviolet_si, nil, VarType(TAlphaColorRec.Blueviolet));
  AData.AddConstant('Brown', TAlphaColorRec_Brown_si, nil, VarType(TAlphaColorRec.Brown));
  AData.AddConstant('Burlywood', TAlphaColorRec_Burlywood_si, nil, VarType(TAlphaColorRec.Burlywood));
  AData.AddConstant('Cadetblue', TAlphaColorRec_Cadetblue_si, nil, VarType(TAlphaColorRec.Cadetblue));
  AData.AddConstant('Chartreuse', TAlphaColorRec_Chartreuse_si, nil, VarType(TAlphaColorRec.Chartreuse));
  AData.AddConstant('Chocolate', TAlphaColorRec_Chocolate_si, nil, VarType(TAlphaColorRec.Chocolate));
  AData.AddConstant('Coral', TAlphaColorRec_Coral_si, nil, VarType(TAlphaColorRec.Coral));
  AData.AddConstant('Cornflowerblue', TAlphaColorRec_Cornflowerblue_si, nil, VarType(TAlphaColorRec.Cornflowerblue));
  AData.AddConstant('Cornsilk', TAlphaColorRec_Cornsilk_si, nil, VarType(TAlphaColorRec.Cornsilk));
  AData.AddConstant('Crimson', TAlphaColorRec_Crimson_si, nil, VarType(TAlphaColorRec.Crimson));
  AData.AddConstant('Cyan', TAlphaColorRec_Cyan_si, nil, VarType(TAlphaColorRec.Cyan));
  AData.AddConstant('Darkblue', TAlphaColorRec_Darkblue_si, nil, VarType(TAlphaColorRec.Darkblue));
  AData.AddConstant('Darkcyan', TAlphaColorRec_Darkcyan_si, nil, VarType(TAlphaColorRec.Darkcyan));
  AData.AddConstant('Darkgoldenrod', TAlphaColorRec_Darkgoldenrod_si, nil, VarType(TAlphaColorRec.Darkgoldenrod));
  AData.AddConstant('Darkgray', TAlphaColorRec_Darkgray_si, nil, VarType(TAlphaColorRec.Darkgray));
  AData.AddConstant('Darkgreen', TAlphaColorRec_Darkgreen_si, nil, VarType(TAlphaColorRec.Darkgreen));
  AData.AddConstant('Darkgrey', TAlphaColorRec_Darkgrey_si, nil, VarType(TAlphaColorRec.Darkgrey));
  AData.AddConstant('Darkkhaki', TAlphaColorRec_Darkkhaki_si, nil, VarType(TAlphaColorRec.Darkkhaki));
  AData.AddConstant('Darkmagenta', TAlphaColorRec_Darkmagenta_si, nil, VarType(TAlphaColorRec.Darkmagenta));
  AData.AddConstant('Darkolivegreen', TAlphaColorRec_Darkolivegreen_si, nil, VarType(TAlphaColorRec.Darkolivegreen));
  AData.AddConstant('Darkorange', TAlphaColorRec_Darkorange_si, nil, VarType(TAlphaColorRec.Darkorange));
  AData.AddConstant('Darkorchid', TAlphaColorRec_Darkorchid_si, nil, VarType(TAlphaColorRec.Darkorchid));
  AData.AddConstant('Darkred', TAlphaColorRec_Darkred_si, nil, VarType(TAlphaColorRec.Darkred));
  AData.AddConstant('Darksalmon', TAlphaColorRec_Darksalmon_si, nil, VarType(TAlphaColorRec.Darksalmon));
  AData.AddConstant('Darkseagreen', TAlphaColorRec_Darkseagreen_si, nil, VarType(TAlphaColorRec.Darkseagreen));
  AData.AddConstant('Darkslateblue', TAlphaColorRec_Darkslateblue_si, nil, VarType(TAlphaColorRec.Darkslateblue));
  AData.AddConstant('Darkslategray', TAlphaColorRec_Darkslategray_si, nil, VarType(TAlphaColorRec.Darkslategray));
  AData.AddConstant('Darkslategrey', TAlphaColorRec_Darkslategrey_si, nil, VarType(TAlphaColorRec.Darkslategrey));
  AData.AddConstant('Darkturquoise', TAlphaColorRec_Darkturquoise_si, nil, VarType(TAlphaColorRec.Darkturquoise));
  AData.AddConstant('Darkviolet', TAlphaColorRec_Darkviolet_si, nil, VarType(TAlphaColorRec.Darkviolet));
  AData.AddConstant('Deeppink', TAlphaColorRec_Deeppink_si, nil, VarType(TAlphaColorRec.Deeppink));
  AData.AddConstant('Deepskyblue', TAlphaColorRec_Deepskyblue_si, nil, VarType(TAlphaColorRec.Deepskyblue));
  AData.AddConstant('Dimgray', TAlphaColorRec_Dimgray_si, nil, VarType(TAlphaColorRec.Dimgray));
  AData.AddConstant('Dimgrey', TAlphaColorRec_Dimgrey_si, nil, VarType(TAlphaColorRec.Dimgrey));
  AData.AddConstant('Dodgerblue', TAlphaColorRec_Dodgerblue_si, nil, VarType(TAlphaColorRec.Dodgerblue));
  AData.AddConstant('Firebrick', TAlphaColorRec_Firebrick_si, nil, VarType(TAlphaColorRec.Firebrick));
  AData.AddConstant('Floralwhite', TAlphaColorRec_Floralwhite_si, nil, VarType(TAlphaColorRec.Floralwhite));
  AData.AddConstant('Forestgreen', TAlphaColorRec_Forestgreen_si, nil, VarType(TAlphaColorRec.Forestgreen));
  AData.AddConstant('Fuchsia', TAlphaColorRec_Fuchsia_si, nil, VarType(TAlphaColorRec.Fuchsia));
  AData.AddConstant('Gainsboro', TAlphaColorRec_Gainsboro_si, nil, VarType(TAlphaColorRec.Gainsboro));
  AData.AddConstant('Ghostwhite', TAlphaColorRec_Ghostwhite_si, nil, VarType(TAlphaColorRec.Ghostwhite));
  AData.AddConstant('Gold', TAlphaColorRec_Gold_si, nil, VarType(TAlphaColorRec.Gold));
  AData.AddConstant('Goldenrod', TAlphaColorRec_Goldenrod_si, nil, VarType(TAlphaColorRec.Goldenrod));
  AData.AddConstant('Gray', TAlphaColorRec_Gray_si, nil, VarType(TAlphaColorRec.Gray));
  AData.AddConstant('Green', TAlphaColorRec_Green_si, nil, VarType(TAlphaColorRec.Green));
  AData.AddConstant('Greenyellow', TAlphaColorRec_Greenyellow_si, nil, VarType(TAlphaColorRec.Greenyellow));
  AData.AddConstant('Grey', TAlphaColorRec_Grey_si, nil, VarType(TAlphaColorRec.Grey));
  AData.AddConstant('Honeydew', TAlphaColorRec_Honeydew_si, nil, VarType(TAlphaColorRec.Honeydew));
  AData.AddConstant('Hotpink', TAlphaColorRec_Hotpink_si, nil, VarType(TAlphaColorRec.Hotpink));
  AData.AddConstant('Indianred', TAlphaColorRec_Indianred_si, nil, VarType(TAlphaColorRec.Indianred));
  AData.AddConstant('Indigo', TAlphaColorRec_Indigo_si, nil, VarType(TAlphaColorRec.Indigo));
  AData.AddConstant('Ivory', TAlphaColorRec_Ivory_si, nil, VarType(TAlphaColorRec.Ivory));
  AData.AddConstant('Khaki', TAlphaColorRec_Khaki_si, nil, VarType(TAlphaColorRec.Khaki));
  AData.AddConstant('Lavender', TAlphaColorRec_Lavender_si, nil, VarType(TAlphaColorRec.Lavender));
  AData.AddConstant('Lavenderblush', TAlphaColorRec_Lavenderblush_si, nil, VarType(TAlphaColorRec.Lavenderblush));
  AData.AddConstant('Lawngreen', TAlphaColorRec_Lawngreen_si, nil, VarType(TAlphaColorRec.Lawngreen));
  AData.AddConstant('Lemonchiffon', TAlphaColorRec_Lemonchiffon_si, nil, VarType(TAlphaColorRec.Lemonchiffon));
  AData.AddConstant('Lightblue', TAlphaColorRec_Lightblue_si, nil, VarType(TAlphaColorRec.Lightblue));
  AData.AddConstant('Lightcoral', TAlphaColorRec_Lightcoral_si, nil, VarType(TAlphaColorRec.Lightcoral));
  AData.AddConstant('Lightcyan', TAlphaColorRec_Lightcyan_si, nil, VarType(TAlphaColorRec.Lightcyan));
  AData.AddConstant('Lightgoldenrodyellow', TAlphaColorRec_Lightgoldenrodyellow_si, nil, VarType(TAlphaColorRec.Lightgoldenrodyellow));
  AData.AddConstant('Lightgray', TAlphaColorRec_Lightgray_si, nil, VarType(TAlphaColorRec.Lightgray));
  AData.AddConstant('Lightgreen', TAlphaColorRec_Lightgreen_si, nil, VarType(TAlphaColorRec.Lightgreen));
  AData.AddConstant('Lightgrey', TAlphaColorRec_Lightgrey_si, nil, VarType(TAlphaColorRec.Lightgrey));
  AData.AddConstant('Lightpink', TAlphaColorRec_Lightpink_si, nil, VarType(TAlphaColorRec.Lightpink));
  AData.AddConstant('Lightsalmon', TAlphaColorRec_Lightsalmon_si, nil, VarType(TAlphaColorRec.Lightsalmon));
  AData.AddConstant('Lightseagreen', TAlphaColorRec_Lightseagreen_si, nil, VarType(TAlphaColorRec.Lightseagreen));
  AData.AddConstant('Lightskyblue', TAlphaColorRec_Lightskyblue_si, nil, VarType(TAlphaColorRec.Lightskyblue));
  AData.AddConstant('Lightslategray', TAlphaColorRec_Lightslategray_si, nil, VarType(TAlphaColorRec.Lightslategray));
  AData.AddConstant('Lightslategrey', TAlphaColorRec_Lightslategrey_si, nil, VarType(TAlphaColorRec.Lightslategrey));
  AData.AddConstant('Lightsteelblue', TAlphaColorRec_Lightsteelblue_si, nil, VarType(TAlphaColorRec.Lightsteelblue));
  AData.AddConstant('Lightyellow', TAlphaColorRec_Lightyellow_si, nil, VarType(TAlphaColorRec.Lightyellow));
  AData.AddConstant('LtGray', TAlphaColorRec_LtGray_si, nil, VarType(TAlphaColorRec.LtGray));
  AData.AddConstant('MedGray', TAlphaColorRec_MedGray_si, nil, VarType(TAlphaColorRec.MedGray));
  AData.AddConstant('DkGray', TAlphaColorRec_DkGray_si, nil, VarType(TAlphaColorRec.DkGray));
  AData.AddConstant('MoneyGreen', TAlphaColorRec_MoneyGreen_si, nil, VarType(TAlphaColorRec.MoneyGreen));
  AData.AddConstant('LegacySkyBlue', TAlphaColorRec_LegacySkyBlue_si, nil, VarType(TAlphaColorRec.LegacySkyBlue));
  AData.AddConstant('Cream', TAlphaColorRec_Cream_si, nil, VarType(TAlphaColorRec.Cream));
  AData.AddConstant('Lime', TAlphaColorRec_Lime_si, nil, VarType(TAlphaColorRec.Lime));
  AData.AddConstant('Limegreen', TAlphaColorRec_Limegreen_si, nil, VarType(TAlphaColorRec.Limegreen));
  AData.AddConstant('Linen', TAlphaColorRec_Linen_si, nil, VarType(TAlphaColorRec.Linen));
  AData.AddConstant('Magenta', TAlphaColorRec_Magenta_si, nil, VarType(TAlphaColorRec.Magenta));
  AData.AddConstant('Maroon', TAlphaColorRec_Maroon_si, nil, VarType(TAlphaColorRec.Maroon));
  AData.AddConstant('Mediumaquamarine', TAlphaColorRec_Mediumaquamarine_si, nil, VarType(TAlphaColorRec.Mediumaquamarine));
  AData.AddConstant('Mediumblue', TAlphaColorRec_Mediumblue_si, nil, VarType(TAlphaColorRec.Mediumblue));
  AData.AddConstant('Mediumorchid', TAlphaColorRec_Mediumorchid_si, nil, VarType(TAlphaColorRec.Mediumorchid));
  AData.AddConstant('Mediumpurple', TAlphaColorRec_Mediumpurple_si, nil, VarType(TAlphaColorRec.Mediumpurple));
  AData.AddConstant('Mediumseagreen', TAlphaColorRec_Mediumseagreen_si, nil, VarType(TAlphaColorRec.Mediumseagreen));
  AData.AddConstant('Mediumslateblue', TAlphaColorRec_Mediumslateblue_si, nil, VarType(TAlphaColorRec.Mediumslateblue));
  AData.AddConstant('Mediumspringgreen', TAlphaColorRec_Mediumspringgreen_si, nil, VarType(TAlphaColorRec.Mediumspringgreen));
  AData.AddConstant('Mediumturquoise', TAlphaColorRec_Mediumturquoise_si, nil, VarType(TAlphaColorRec.Mediumturquoise));
  AData.AddConstant('Mediumvioletred', TAlphaColorRec_Mediumvioletred_si, nil, VarType(TAlphaColorRec.Mediumvioletred));
  AData.AddConstant('Midnightblue', TAlphaColorRec_Midnightblue_si, nil, VarType(TAlphaColorRec.Midnightblue));
  AData.AddConstant('Mintcream', TAlphaColorRec_Mintcream_si, nil, VarType(TAlphaColorRec.Mintcream));
  AData.AddConstant('Mistyrose', TAlphaColorRec_Mistyrose_si, nil, VarType(TAlphaColorRec.Mistyrose));
  AData.AddConstant('Moccasin', TAlphaColorRec_Moccasin_si, nil, VarType(TAlphaColorRec.Moccasin));
  AData.AddConstant('Navajowhite', TAlphaColorRec_Navajowhite_si, nil, VarType(TAlphaColorRec.Navajowhite));
  AData.AddConstant('Navy', TAlphaColorRec_Navy_si, nil, VarType(TAlphaColorRec.Navy));
  AData.AddConstant('Oldlace', TAlphaColorRec_Oldlace_si, nil, VarType(TAlphaColorRec.Oldlace));
  AData.AddConstant('Olive', TAlphaColorRec_Olive_si, nil, VarType(TAlphaColorRec.Olive));
  AData.AddConstant('Olivedrab', TAlphaColorRec_Olivedrab_si, nil, VarType(TAlphaColorRec.Olivedrab));
  AData.AddConstant('Orange', TAlphaColorRec_Orange_si, nil, VarType(TAlphaColorRec.Orange));
  AData.AddConstant('Orangered', TAlphaColorRec_Orangered_si, nil, VarType(TAlphaColorRec.Orangered));
  AData.AddConstant('Orchid', TAlphaColorRec_Orchid_si, nil, VarType(TAlphaColorRec.Orchid));
  AData.AddConstant('Palegoldenrod', TAlphaColorRec_Palegoldenrod_si, nil, VarType(TAlphaColorRec.Palegoldenrod));
  AData.AddConstant('Palegreen', TAlphaColorRec_Palegreen_si, nil, VarType(TAlphaColorRec.Palegreen));
  AData.AddConstant('Paleturquoise', TAlphaColorRec_Paleturquoise_si, nil, VarType(TAlphaColorRec.Paleturquoise));
  AData.AddConstant('Palevioletred', TAlphaColorRec_Palevioletred_si, nil, VarType(TAlphaColorRec.Palevioletred));
  AData.AddConstant('Papayawhip', TAlphaColorRec_Papayawhip_si, nil, VarType(TAlphaColorRec.Papayawhip));
  AData.AddConstant('Peachpuff', TAlphaColorRec_Peachpuff_si, nil, VarType(TAlphaColorRec.Peachpuff));
  AData.AddConstant('Peru', TAlphaColorRec_Peru_si, nil, VarType(TAlphaColorRec.Peru));
  AData.AddConstant('Pink', TAlphaColorRec_Pink_si, nil, VarType(TAlphaColorRec.Pink));
  AData.AddConstant('Plum', TAlphaColorRec_Plum_si, nil, VarType(TAlphaColorRec.Plum));
  AData.AddConstant('Powderblue', TAlphaColorRec_Powderblue_si, nil, VarType(TAlphaColorRec.Powderblue));
  AData.AddConstant('Purple', TAlphaColorRec_Purple_si, nil, VarType(TAlphaColorRec.Purple));
  AData.AddConstant('Red', TAlphaColorRec_Red_si, nil, VarType(TAlphaColorRec.Red));
  AData.AddConstant('Rosybrown', TAlphaColorRec_Rosybrown_si, nil, VarType(TAlphaColorRec.Rosybrown));
  AData.AddConstant('Royalblue', TAlphaColorRec_Royalblue_si, nil, VarType(TAlphaColorRec.Royalblue));
  AData.AddConstant('Saddlebrown', TAlphaColorRec_Saddlebrown_si, nil, VarType(TAlphaColorRec.Saddlebrown));
  AData.AddConstant('Salmon', TAlphaColorRec_Salmon_si, nil, VarType(TAlphaColorRec.Salmon));
  AData.AddConstant('Sandybrown', TAlphaColorRec_Sandybrown_si, nil, VarType(TAlphaColorRec.Sandybrown));
  AData.AddConstant('Seagreen', TAlphaColorRec_Seagreen_si, nil, VarType(TAlphaColorRec.Seagreen));
  AData.AddConstant('Seashell', TAlphaColorRec_Seashell_si, nil, VarType(TAlphaColorRec.Seashell));
  AData.AddConstant('Sienna', TAlphaColorRec_Sienna_si, nil, VarType(TAlphaColorRec.Sienna));
  AData.AddConstant('Silver', TAlphaColorRec_Silver_si, nil, VarType(TAlphaColorRec.Silver));
  AData.AddConstant('Skyblue', TAlphaColorRec_Skyblue_si, nil, VarType(TAlphaColorRec.Skyblue));
  AData.AddConstant('Slateblue', TAlphaColorRec_Slateblue_si, nil, VarType(TAlphaColorRec.Slateblue));
  AData.AddConstant('Slategray', TAlphaColorRec_Slategray_si, nil, VarType(TAlphaColorRec.Slategray));
  AData.AddConstant('Slategrey', TAlphaColorRec_Slategrey_si, nil, VarType(TAlphaColorRec.Slategrey));
  AData.AddConstant('Snow', TAlphaColorRec_Snow_si, nil, VarType(TAlphaColorRec.Snow));
  AData.AddConstant('Springgreen', TAlphaColorRec_Springgreen_si, nil, VarType(TAlphaColorRec.Springgreen));
  AData.AddConstant('Steelblue', TAlphaColorRec_Steelblue_si, nil, VarType(TAlphaColorRec.Steelblue));
  AData.AddConstant('Tan', TAlphaColorRec_Tan_si, nil, VarType(TAlphaColorRec.Tan));
  AData.AddConstant('Teal', TAlphaColorRec_Teal_si, nil, VarType(TAlphaColorRec.Teal));
  AData.AddConstant('Thistle', TAlphaColorRec_Thistle_si, nil, VarType(TAlphaColorRec.Thistle));
  AData.AddConstant('Tomato', TAlphaColorRec_Tomato_si, nil, VarType(TAlphaColorRec.Tomato));
  AData.AddConstant('Turquoise', TAlphaColorRec_Turquoise_si, nil, VarType(TAlphaColorRec.Turquoise));
  AData.AddConstant('Violet', TAlphaColorRec_Violet_si, nil, VarType(TAlphaColorRec.Violet));
  AData.AddConstant('Wheat', TAlphaColorRec_Wheat_si, nil, VarType(TAlphaColorRec.Wheat));
  AData.AddConstant('White', TAlphaColorRec_White_si, nil, VarType(TAlphaColorRec.White));
  AData.AddConstant('Whitesmoke', TAlphaColorRec_Whitesmoke_si, nil, VarType(TAlphaColorRec.Whitesmoke));
  AData.AddConstant('Yellow', TAlphaColorRec_Yellow_si, nil, VarType(TAlphaColorRec.Yellow));
  AData.AddConstant('Yellowgreen', TAlphaColorRec_Yellowgreen_si, nil, VarType(TAlphaColorRec.Yellowgreen));
  AData.AddConstant('Null', TAlphaColorRec_Null_si, TAlphaColor_sw);
  AData.AddConstructor('Create', TAlphaColorRec_Create_si, 0, False);
end;

class function TAlphaColorRec_sw.ToVar(
  const AValue: TAlphaColorRec): OleVariant;
var
  wrpr: TAlphaColorRec_sw;
begin
  wrpr        := TAlphaColorRec_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TAlphaColorRec_sw.FromVar(
  const AValue: OleVariant): TAlphaColorRec;
begin
  Result := TAlphaColorRec_sw(ConvFromVar(AValue)).FValue;
end;

{ TImageIndex_sw }

class function TImageIndex_sw.GetTypeName: WideString;
begin
  Result := 'TImageIndex';
end;

class function TImageIndex_sw.ToVar(const AValue: TImageIndex): OleVariant;
begin
  Result := Integer_sw.ToVar(Integer(AValue));
end;

class function TImageIndex_sw.FromVar(const AValue: OleVariant): TImageIndex;
begin
  Result := TImageIndex(Integer_sw.FromVar(AValue));
end;

{ TScrollStyle_sw }

class function TScrollStyle_sw.GetTypeName: WideString;
begin
  Result := 'TScrollStyle';
end;

class procedure TScrollStyle_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'ssNone'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssNone)),
    (Name: 'ssHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssHorizontal)),
    (Name: 'ssVertical'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssVertical)),
    (Name: 'ssBoth'; Value: Integer({$IFDEF LMDSCT_12}TScrollStyle.{$ENDIF}ssBoth))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TScrollStyle_sw.ToVar(const AValue: TScrollStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollStyle_sw.FromVar(const AValue: OleVariant): TScrollStyle;
begin
  Result := TScrollStyle(Integer(AValue));
end;

{ UITypes_sw }

function UITypes_LF_FACESIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LF_FACESIZE = <value>;

  Result := LF_FACESIZE;
end;

function UITypes_TOpenOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOption = (ofReadOnly, ofOverwritePrompt, ofHide...

  Result := TLMDUnitWrapper.TypeToVar(TOpenOption_sw);
end;

function UITypes_TOpenOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptions = set of TOpenOption;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptions_sw);
end;

function UITypes_TOpenOptionEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionEx = (ofExNoPlacesBar);

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionEx_sw);
end;

function UITypes_TOpenOptionsEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOpenOptionsEx = set of TOpenOptionEx;

  Result := TLMDUnitWrapper.TypeToVar(TOpenOptionsEx_sw);
end;

function UITypes_TPrintRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintRange = (prAllPages, prSelection, prPageNums);

  Result := TLMDUnitWrapper.TypeToVar(TPrintRange_sw);
end;

function UITypes_TPrintDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOption = (poPrintToFile, poPageNums, poS...

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOption_sw);
end;

function UITypes_TPrintDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrintDialogOptions = set of TPrintDialogOption;

  Result := TLMDUnitWrapper.TypeToVar(TPrintDialogOptions_sw);
end;

function UITypes_TPageSetupDialogOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOption = (psoDefaultMinMargins, psoD...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOption_sw);
end;

function UITypes_TPageSetupDialogOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDialogOptions = set of TPageSetupDialogOpt...

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDialogOptions_sw);
end;

function UITypes_TPrinterKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterKind = (pkDotMatrix, pkHPPCL);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterKind_sw);
end;

function UITypes_TPageType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageType = (ptEnvelope, ptPaper);

  Result := TLMDUnitWrapper.TypeToVar(TPageType_sw);
end;

function UITypes_TPageMeasureUnits_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageMeasureUnits = (pmDefault, pmMillimeters, pmInc...

  Result := TLMDUnitWrapper.TypeToVar(TPageMeasureUnits_sw);
end;

function UITypes_TMsgDlgType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgType = (mtWarning, mtError, mtInformation, mt...

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgType_sw);
end;

function UITypes_TMsgDlgBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, ...

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgBtn_sw);
end;

function UITypes_TMsgDlgButtons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgDlgButtons = set of TMsgDlgBtn;

  Result := TLMDUnitWrapper.TypeToVar(TMsgDlgButtons_sw);
end;

function UITypes_TCalDayOfWeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCalDayOfWeek = (dowMonday, dowTuesday, dowWednesday...

  Result := TLMDUnitWrapper.TypeToVar(TCalDayOfWeek_sw);
end;

function UITypes_TBorderIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderIcon = (biSystemMenu, biMinimize, biMaximize,...

  Result := TLMDUnitWrapper.TypeToVar(TBorderIcon_sw);
end;

function UITypes_TBorderIcons_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBorderIcons = set of TBorderIcon;

  Result := TLMDUnitWrapper.TypeToVar(TBorderIcons_sw);
end;

function UITypes_TWindowState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWindowState = (wsNormal, wsMinimized, wsMaximized);

  Result := TLMDUnitWrapper.TypeToVar(TWindowState_sw);
end;

function UITypes_TEditCharCase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditCharCase = (ecNormal, ecUpperCase, ecLowerCase);

  Result := TLMDUnitWrapper.TypeToVar(TEditCharCase_sw);
end;

function UITypes_TFontCharset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontCharset = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TFontCharset_sw);
end;

function UITypes_TFontPitch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontPitch = (fpDefault, fpVariable, fpFixed);

  Result := TLMDUnitWrapper.TypeToVar(TFontPitch_sw);
end;

function UITypes_TFontQuality_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontQuality = (fqDefault, fqDraft, fqProof, fqNonAn...

  Result := TLMDUnitWrapper.TypeToVar(TFontQuality_sw);
end;

function UITypes_TFontStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrik...

  Result := TLMDUnitWrapper.TypeToVar(TFontStyle_sw);
end;

function UITypes_TFontStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStyles = set of TFontStyle;

  Result := TLMDUnitWrapper.TypeToVar(TFontStyles_sw);
end;

function UITypes_TFontName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFontName_sw);
end;

function UITypes_TFontDataName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontDataName = string;

  Result := TLMDUnitWrapper.TypeToVar(TFontDataName_sw);
end;

function UITypes_TFontStylesBase_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFontStylesBase = set of TFontStyle;

  Result := TLMDUnitWrapper.TypeToVar(TFontStylesBase_sw);
end;

function UITypes_TCloseAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCloseAction = (caNone, caHide, caFree, caMinimize);

  Result := TLMDUnitWrapper.TypeToVar(TCloseAction_sw);
end;

function UITypes_TMouseButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouseButton = (mbLeft, mbRight, mbMiddle);

  Result := TLMDUnitWrapper.TypeToVar(TMouseButton_sw);
end;

function UITypes_TMouseActivate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMouseActivate = (maDefault, maActivate, maActivateA...

  Result := TLMDUnitWrapper.TypeToVar(TMouseActivate_sw);
end;

function UITypes_TTabOrder_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTabOrder = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TTabOrder_sw);
end;

function UITypes_TModalResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TModalResult = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TModalResult_sw);
end;

function UITypes_TDragMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragMode = (dmManual, dmAutomatic);

  Result := TLMDUnitWrapper.TypeToVar(TDragMode_sw);
end;

function UITypes_TDragState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragState = (dsDragEnter, dsDragLeave, dsDragMove);

  Result := TLMDUnitWrapper.TypeToVar(TDragState_sw);
end;

function UITypes_TDragKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDragKind = (dkDrag, dkDock);

  Result := TLMDUnitWrapper.TypeToVar(TDragKind_sw);
end;

function UITypes_TAnchorKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnchorKind = (akLeft, akTop, akRight, akBottom);

  Result := TLMDUnitWrapper.TypeToVar(TAnchorKind_sw);
end;

function UITypes_TAnchors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAnchors = set of TAnchorKind;

  Result := TLMDUnitWrapper.TypeToVar(TAnchors_sw);
end;

function UITypes_TScrollCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollCode = (scLineUp, scLineDown, scPageUp, scPag...

  Result := TLMDUnitWrapper.TypeToVar(TScrollCode_sw);
end;

function UITypes_TPrinterState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterState = (psNoHandle, psHandleIC, psHandleDC);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterState_sw);
end;

function UITypes_TPrinterOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterOrientation = (poPortrait, poLandscape);

  Result := TLMDUnitWrapper.TypeToVar(TPrinterOrientation_sw);
end;

function UITypes_TPrinterCapability_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapability = (pcCopies, pcOrientation, pcCol...

  Result := TLMDUnitWrapper.TypeToVar(TPrinterCapability_sw);
end;

function UITypes_TPrinterCapabilities_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPrinterCapabilities = set of TPrinterCapability;

  Result := TLMDUnitWrapper.TypeToVar(TPrinterCapabilities_sw);
end;

function UITypes_TCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCursor = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TCursor_sw);
end;

function UITypes_crDefault_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crDefault = <value>;

  Result := TCursor_sw.ToVar(crDefault);
end;

function UITypes_crNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNone = <value>;

  Result := TCursor_sw.ToVar(crNone);
end;

function UITypes_crArrow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crArrow = <value>;

  Result := TCursor_sw.ToVar(crArrow);
end;

function UITypes_crCross_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crCross = <value>;

  Result := TCursor_sw.ToVar(crCross);
end;

function UITypes_crIBeam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crIBeam = <value>;

  Result := TCursor_sw.ToVar(crIBeam);
end;

function UITypes_crSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSize = <value>;

  Result := TCursor_sw.ToVar(crSize);
end;

function UITypes_crSizeNESW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNESW = <value>;

  Result := TCursor_sw.ToVar(crSizeNESW);
end;

function UITypes_crSizeNS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNS = <value>;

  Result := TCursor_sw.ToVar(crSizeNS);
end;

function UITypes_crSizeNWSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeNWSE = <value>;

  Result := TCursor_sw.ToVar(crSizeNWSE);
end;

function UITypes_crSizeWE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeWE = <value>;

  Result := TCursor_sw.ToVar(crSizeWE);
end;

function UITypes_crUpArrow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crUpArrow = <value>;

  Result := TCursor_sw.ToVar(crUpArrow);
end;

function UITypes_crHourGlass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHourGlass = <value>;

  Result := TCursor_sw.ToVar(crHourGlass);
end;

function UITypes_crDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crDrag = <value>;

  Result := TCursor_sw.ToVar(crDrag);
end;

function UITypes_crNoDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNoDrop = <value>;

  Result := TCursor_sw.ToVar(crNoDrop);
end;

function UITypes_crHSplit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHSplit = <value>;

  Result := TCursor_sw.ToVar(crHSplit);
end;

function UITypes_crVSplit_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crVSplit = <value>;

  Result := TCursor_sw.ToVar(crVSplit);
end;

function UITypes_crMultiDrag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crMultiDrag = <value>;

  Result := TCursor_sw.ToVar(crMultiDrag);
end;

function UITypes_crSQLWait_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSQLWait = <value>;

  Result := TCursor_sw.ToVar(crSQLWait);
end;

function UITypes_crNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crNo = <value>;

  Result := TCursor_sw.ToVar(crNo);
end;

function UITypes_crAppStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crAppStart = <value>;

  Result := TCursor_sw.ToVar(crAppStart);
end;

function UITypes_crHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHelp = <value>;

  Result := TCursor_sw.ToVar(crHelp);
end;

function UITypes_crHandPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crHandPoint = <value>;

  Result := TCursor_sw.ToVar(crHandPoint);
end;

function UITypes_crSizeAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const crSizeAll = <value>;

  Result := TCursor_sw.ToVar(crSizeAll);
end;

function UITypes_idOK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idOK = <value>;

  Result := idOK;
end;

function UITypes_idCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idCancel = <value>;

  Result := idCancel;
end;

function UITypes_idAbort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idAbort = <value>;

  Result := idAbort;
end;

function UITypes_idRetry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idRetry = <value>;

  Result := idRetry;
end;

function UITypes_idIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idIgnore = <value>;

  Result := idIgnore;
end;

function UITypes_idYes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idYes = <value>;

  Result := idYes;
end;

function UITypes_idNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idNo = <value>;

  Result := idNo;
end;

function UITypes_idClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idClose = <value>;

  Result := idClose;
end;

function UITypes_idHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idHelp = <value>;

  Result := idHelp;
end;

function UITypes_idTryAgain_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idTryAgain = <value>;

  Result := idTryAgain;
end;

function UITypes_idContinue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const idContinue = <value>;

  Result := idContinue;
end;

function UITypes_mrNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNone = <value>;

  Result := mrNone;
end;

function UITypes_mrOk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrOk = <value>;

  Result := mrOk;
end;

function UITypes_mrCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrCancel = <value>;

  Result := mrCancel;
end;

function UITypes_mrAbort_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrAbort = <value>;

  Result := mrAbort;
end;

function UITypes_mrRetry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrRetry = <value>;

  Result := mrRetry;
end;

function UITypes_mrIgnore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrIgnore = <value>;

  Result := mrIgnore;
end;

function UITypes_mrYes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrYes = <value>;

  Result := mrYes;
end;

function UITypes_mrNo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNo = <value>;

  Result := mrNo;
end;

function UITypes_mrClose_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrClose = <value>;

  Result := mrClose;
end;

function UITypes_mrHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrHelp = <value>;

  Result := mrHelp;
end;

function UITypes_mrTryAgain_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrTryAgain = <value>;

  Result := mrTryAgain;
end;

function UITypes_mrContinue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrContinue = <value>;

  Result := mrContinue;
end;

function UITypes_mrAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrAll = <value>;

  Result := mrAll;
end;

function UITypes_mrNoToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrNoToAll = <value>;

  Result := mrNoToAll;
end;

function UITypes_mrYesToAll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const mrYesToAll = <value>;

  Result := mrYesToAll;
end;

function UITypes_IsPositiveResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsPositiveResult(const AModalResult: TModalResul...

  Result := System.UITypes.IsPositiveResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function UITypes_IsNegativeResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsNegativeResult(const AModalResult: TModalResul...

  Result := System.UITypes.IsNegativeResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function UITypes_IsAbortResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAbortResult(const AModalResult: TModalResult):...

  Result := System.UITypes.IsAbortResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function UITypes_IsAnAllResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsAnAllResult(const AModalResult: TModalResult):...

  Result := System.UITypes.IsAnAllResult(TModalResult_sw.FromVar(AArgs[0]));
end;

function UITypes_StripAllFromResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function StripAllFromResult(const AModalResult: TModalRes...

  Result := TModalResult_sw.ToVar(System.UITypes.StripAllFromResult(
    TModalResult_sw.FromVar(AArgs[0])));
end;

function UITypes_vkLButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLButton = <value>;

  Result := vkLButton;
end;

function UITypes_vkRButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRButton = <value>;

  Result := vkRButton;
end;

function UITypes_vkCancel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkCancel = <value>;

  Result := vkCancel;
end;

function UITypes_vkMButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMButton = <value>;

  Result := vkMButton;
end;

function UITypes_vkXButton1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkXButton1 = <value>;

  Result := vkXButton1;
end;

function UITypes_vkXButton2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkXButton2 = <value>;

  Result := vkXButton2;
end;

function UITypes_vkBack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBack = <value>;

  Result := vkBack;
end;

function UITypes_vkTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkTab = <value>;

  Result := vkTab;
end;

function UITypes_vkLineFeed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLineFeed = <value>;

  Result := vkLineFeed;
end;

function UITypes_vkClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkClear = <value>;

  Result := vkClear;
end;

function UITypes_vkReturn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkReturn = <value>;

  Result := vkReturn;
end;

function UITypes_vkShift_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkShift = <value>;

  Result := vkShift;
end;

function UITypes_vkControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkControl = <value>;

  Result := vkControl;
end;

function UITypes_vkMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMenu = <value>;

  Result := vkMenu;
end;

function UITypes_vkPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPause = <value>;

  Result := vkPause;
end;

function UITypes_vkCapital_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkCapital = <value>;

  Result := vkCapital;
end;

function UITypes_vkKana_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkKana = <value>;

  Result := vkKana;
end;

function UITypes_vkHangul_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkHangul = <value>;

  Result := vkHangul;
end;

function UITypes_vkJunja_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkJunja = <value>;

  Result := vkJunja;
end;

function UITypes_vkFinal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkFinal = <value>;

  Result := vkFinal;
end;

function UITypes_vkHanja_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkHanja = <value>;

  Result := vkHanja;
end;

function UITypes_vkKanji_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkKanji = <value>;

  Result := vkKanji;
end;

function UITypes_vkConvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkConvert = <value>;

  Result := vkConvert;
end;

function UITypes_vkNonConvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNonConvert = <value>;

  Result := vkNonConvert;
end;

function UITypes_vkAccept_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkAccept = <value>;

  Result := vkAccept;
end;

function UITypes_vkModeChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkModeChange = <value>;

  Result := vkModeChange;
end;

function UITypes_vkEscape_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkEscape = <value>;

  Result := vkEscape;
end;

function UITypes_vkSpace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSpace = <value>;

  Result := vkSpace;
end;

function UITypes_vkPrior_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPrior = <value>;

  Result := vkPrior;
end;

function UITypes_vkNext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNext = <value>;

  Result := vkNext;
end;

function UITypes_vkEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkEnd = <value>;

  Result := vkEnd;
end;

function UITypes_vkHome_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkHome = <value>;

  Result := vkHome;
end;

function UITypes_vkLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLeft = <value>;

  Result := vkLeft;
end;

function UITypes_vkUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkUp = <value>;

  Result := vkUp;
end;

function UITypes_vkRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRight = <value>;

  Result := vkRight;
end;

function UITypes_vkDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkDown = <value>;

  Result := vkDown;
end;

function UITypes_vkSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSelect = <value>;

  Result := vkSelect;
end;

function UITypes_vkPrint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPrint = <value>;

  Result := vkPrint;
end;

function UITypes_vkExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkExecute = <value>;

  Result := vkExecute;
end;

function UITypes_vkSnapshot_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSnapshot = <value>;

  Result := vkSnapshot;
end;

function UITypes_vkInsert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkInsert = <value>;

  Result := vkInsert;
end;

function UITypes_vkDelete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkDelete = <value>;

  Result := vkDelete;
end;

function UITypes_vkHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkHelp = <value>;

  Result := vkHelp;
end;

function UITypes_vk0_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk0 = <value>;

  Result := vk0;
end;

function UITypes_vk1_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk1 = <value>;

  Result := vk1;
end;

function UITypes_vk2_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk2 = <value>;

  Result := vk2;
end;

function UITypes_vk3_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk3 = <value>;

  Result := vk3;
end;

function UITypes_vk4_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk4 = <value>;

  Result := vk4;
end;

function UITypes_vk5_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk5 = <value>;

  Result := vk5;
end;

function UITypes_vk6_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk6 = <value>;

  Result := vk6;
end;

function UITypes_vk7_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk7 = <value>;

  Result := vk7;
end;

function UITypes_vk8_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk8 = <value>;

  Result := vk8;
end;

function UITypes_vk9_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vk9 = <value>;

  Result := vk9;
end;

function UITypes_vkA_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkA = <value>;

  Result := vkA;
end;

function UITypes_vkB_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkB = <value>;

  Result := vkB;
end;

function UITypes_vkC_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkC = <value>;

  Result := vkC;
end;

function UITypes_vkD_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkD = <value>;

  Result := vkD;
end;

function UITypes_vkE_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkE = <value>;

  Result := vkE;
end;

function UITypes_vkF_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkF = <value>;

  Result := vkF;
end;

function UITypes_vkG_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkG = <value>;

  Result := vkG;
end;

function UITypes_vkH_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkH = <value>;

  Result := vkH;
end;

function UITypes_vkI_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkI = <value>;

  Result := vkI;
end;

function UITypes_vkJ_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkJ = <value>;

  Result := vkJ;
end;

function UITypes_vkK_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkK = <value>;

  Result := vkK;
end;

function UITypes_vkL_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkL = <value>;

  Result := vkL;
end;

function UITypes_vkM_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkM = <value>;

  Result := vkM;
end;

function UITypes_vkN_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkN = <value>;

  Result := vkN;
end;

function UITypes_vkO_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkO = <value>;

  Result := vkO;
end;

function UITypes_vkP_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkP = <value>;

  Result := vkP;
end;

function UITypes_vkQ_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkQ = <value>;

  Result := vkQ;
end;

function UITypes_vkR_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkR = <value>;

  Result := vkR;
end;

function UITypes_vkS_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkS = <value>;

  Result := vkS;
end;

function UITypes_vkT_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkT = <value>;

  Result := vkT;
end;

function UITypes_vkU_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkU = <value>;

  Result := vkU;
end;

function UITypes_vkV_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkV = <value>;

  Result := vkV;
end;

function UITypes_vkW_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkW = <value>;

  Result := vkW;
end;

function UITypes_vkX_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkX = <value>;

  Result := vkX;
end;

function UITypes_vkY_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkY = <value>;

  Result := vkY;
end;

function UITypes_vkZ_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // const vkZ = <value>;

  Result := vkZ;
end;

function UITypes_vkLWin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLWin = <value>;

  Result := vkLWin;
end;

function UITypes_vkRWin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRWin = <value>;

  Result := vkRWin;
end;

function UITypes_vkApps_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkApps = <value>;

  Result := vkApps;
end;

function UITypes_vkSleep_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSleep = <value>;

  Result := vkSleep;
end;

function UITypes_vkNumpad0_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad0 = <value>;

  Result := vkNumpad0;
end;

function UITypes_vkNumpad1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad1 = <value>;

  Result := vkNumpad1;
end;

function UITypes_vkNumpad2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad2 = <value>;

  Result := vkNumpad2;
end;

function UITypes_vkNumpad3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad3 = <value>;

  Result := vkNumpad3;
end;

function UITypes_vkNumpad4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad4 = <value>;

  Result := vkNumpad4;
end;

function UITypes_vkNumpad5_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad5 = <value>;

  Result := vkNumpad5;
end;

function UITypes_vkNumpad6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad6 = <value>;

  Result := vkNumpad6;
end;

function UITypes_vkNumpad7_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad7 = <value>;

  Result := vkNumpad7;
end;

function UITypes_vkNumpad8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad8 = <value>;

  Result := vkNumpad8;
end;

function UITypes_vkNumpad9_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumpad9 = <value>;

  Result := vkNumpad9;
end;

function UITypes_vkMultiply_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMultiply = <value>;

  Result := vkMultiply;
end;

function UITypes_vkAdd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkAdd = <value>;

  Result := vkAdd;
end;

function UITypes_vkSeparator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSeparator = <value>;

  Result := vkSeparator;
end;

function UITypes_vkSubtract_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSubtract = <value>;

  Result := vkSubtract;
end;

function UITypes_vkDecimal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkDecimal = <value>;

  Result := vkDecimal;
end;

function UITypes_vkDivide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkDivide = <value>;

  Result := vkDivide;
end;

function UITypes_vkF1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF1 = <value>;

  Result := vkF1;
end;

function UITypes_vkF2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF2 = <value>;

  Result := vkF2;
end;

function UITypes_vkF3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF3 = <value>;

  Result := vkF3;
end;

function UITypes_vkF4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF4 = <value>;

  Result := vkF4;
end;

function UITypes_vkF5_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF5 = <value>;

  Result := vkF5;
end;

function UITypes_vkF6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF6 = <value>;

  Result := vkF6;
end;

function UITypes_vkF7_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF7 = <value>;

  Result := vkF7;
end;

function UITypes_vkF8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF8 = <value>;

  Result := vkF8;
end;

function UITypes_vkF9_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF9 = <value>;

  Result := vkF9;
end;

function UITypes_vkF10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF10 = <value>;

  Result := vkF10;
end;

function UITypes_vkF11_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF11 = <value>;

  Result := vkF11;
end;

function UITypes_vkF12_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF12 = <value>;

  Result := vkF12;
end;

function UITypes_vkF13_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF13 = <value>;

  Result := vkF13;
end;

function UITypes_vkF14_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF14 = <value>;

  Result := vkF14;
end;

function UITypes_vkF15_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF15 = <value>;

  Result := vkF15;
end;

function UITypes_vkF16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF16 = <value>;

  Result := vkF16;
end;

function UITypes_vkF17_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF17 = <value>;

  Result := vkF17;
end;

function UITypes_vkF18_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF18 = <value>;

  Result := vkF18;
end;

function UITypes_vkF19_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF19 = <value>;

  Result := vkF19;
end;

function UITypes_vkF20_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF20 = <value>;

  Result := vkF20;
end;

function UITypes_vkF21_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF21 = <value>;

  Result := vkF21;
end;

function UITypes_vkF22_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF22 = <value>;

  Result := vkF22;
end;

function UITypes_vkF23_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF23 = <value>;

  Result := vkF23;
end;

function UITypes_vkF24_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkF24 = <value>;

  Result := vkF24;
end;

function UITypes_vkCamera_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkCamera = <value>;

  Result := vkCamera;
end;

function UITypes_vkHardwareBack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkHardwareBack = <value>;

  Result := vkHardwareBack;
end;

function UITypes_vkNumLock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNumLock = <value>;

  Result := vkNumLock;
end;

function UITypes_vkScroll_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkScroll = <value>;

  Result := vkScroll;
end;

function UITypes_vkLShift_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLShift = <value>;

  Result := vkLShift;
end;

function UITypes_vkRShift_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRShift = <value>;

  Result := vkRShift;
end;

function UITypes_vkLControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLControl = <value>;

  Result := vkLControl;
end;

function UITypes_vkRControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRControl = <value>;

  Result := vkRControl;
end;

function UITypes_vkLMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLMenu = <value>;

  Result := vkLMenu;
end;

function UITypes_vkRMenu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRMenu = <value>;

  Result := vkRMenu;
end;

function UITypes_vkBrowserBack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserBack = <value>;

  Result := vkBrowserBack;
end;

function UITypes_vkBrowserForward_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserForward = <value>;

  Result := vkBrowserForward;
end;

function UITypes_vkBrowserRefresh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserRefresh = <value>;

  Result := vkBrowserRefresh;
end;

function UITypes_vkBrowserStop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserStop = <value>;

  Result := vkBrowserStop;
end;

function UITypes_vkBrowserSearch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserSearch = <value>;

  Result := vkBrowserSearch;
end;

function UITypes_vkBrowserFavorites_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserFavorites = <value>;

  Result := vkBrowserFavorites;
end;

function UITypes_vkBrowserHome_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBrowserHome = <value>;

  Result := vkBrowserHome;
end;

function UITypes_vkVolumeMute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkVolumeMute = <value>;

  Result := vkVolumeMute;
end;

function UITypes_vkVolumeDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkVolumeDown = <value>;

  Result := vkVolumeDown;
end;

function UITypes_vkVolumeUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkVolumeUp = <value>;

  Result := vkVolumeUp;
end;

function UITypes_vkMediaNextTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMediaNextTrack = <value>;

  Result := vkMediaNextTrack;
end;

function UITypes_vkMediaPrevTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMediaPrevTrack = <value>;

  Result := vkMediaPrevTrack;
end;

function UITypes_vkMediaStop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMediaStop = <value>;

  Result := vkMediaStop;
end;

function UITypes_vkMediaPlayPause_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMediaPlayPause = <value>;

  Result := vkMediaPlayPause;
end;

function UITypes_vkLaunchMail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLaunchMail = <value>;

  Result := vkLaunchMail;
end;

function UITypes_vkLaunchMediaSelect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLaunchMediaSelect = <value>;

  Result := vkLaunchMediaSelect;
end;

function UITypes_vkLaunchApp1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLaunchApp1 = <value>;

  Result := vkLaunchApp1;
end;

function UITypes_vkLaunchApp2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLaunchApp2 = <value>;

  Result := vkLaunchApp2;
end;

function UITypes_vkSemicolon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSemicolon = <value>;

  Result := vkSemicolon;
end;

function UITypes_vkEqual_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkEqual = <value>;

  Result := vkEqual;
end;

function UITypes_vkComma_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkComma = <value>;

  Result := vkComma;
end;

function UITypes_vkMinus_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkMinus = <value>;

  Result := vkMinus;
end;

function UITypes_vkPeriod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPeriod = <value>;

  Result := vkPeriod;
end;

function UITypes_vkSlash_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkSlash = <value>;

  Result := vkSlash;
end;

function UITypes_vkTilde_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkTilde = <value>;

  Result := vkTilde;
end;

function UITypes_vkLeftBracket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkLeftBracket = <value>;

  Result := vkLeftBracket;
end;

function UITypes_vkBackslash_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkBackslash = <value>;

  Result := vkBackslash;
end;

function UITypes_vkRightBracket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkRightBracket = <value>;

  Result := vkRightBracket;
end;

function UITypes_vkQuote_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkQuote = <value>;

  Result := vkQuote;
end;

function UITypes_vkPara_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPara = <value>;

  Result := vkPara;
end;

function UITypes_vkOem102_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkOem102 = <value>;

  Result := vkOem102;
end;

function UITypes_vkIcoHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkIcoHelp = <value>;

  Result := vkIcoHelp;
end;

function UITypes_vkIco00_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkIco00 = <value>;

  Result := vkIco00;
end;

function UITypes_vkProcessKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkProcessKey = <value>;

  Result := vkProcessKey;
end;

function UITypes_vkIcoClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkIcoClear = <value>;

  Result := vkIcoClear;
end;

function UITypes_vkPacket_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPacket = <value>;

  Result := vkPacket;
end;

function UITypes_vkAttn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkAttn = <value>;

  Result := vkAttn;
end;

function UITypes_vkCrsel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkCrsel = <value>;

  Result := vkCrsel;
end;

function UITypes_vkExsel_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkExsel = <value>;

  Result := vkExsel;
end;

function UITypes_vkErEof_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkErEof = <value>;

  Result := vkErEof;
end;

function UITypes_vkPlay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPlay = <value>;

  Result := vkPlay;
end;

function UITypes_vkZoom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkZoom = <value>;

  Result := vkZoom;
end;

function UITypes_vkNoname_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNoname = <value>;

  Result := vkNoname;
end;

function UITypes_vkPA1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkPA1 = <value>;

  Result := vkPA1;
end;

function UITypes_vkOemClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkOemClear = <value>;

  Result := vkOemClear;
end;

function UITypes_vkNone_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const vkNone = <value>;

  Result := vkNone;
end;

function UITypes_sgiNoGesture_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiNoGesture = <value>;

  Result := sgiNoGesture;
end;

function UITypes_sgiLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeft = <value>;

  Result := sgiLeft;
end;

function UITypes_sgiRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRight = <value>;

  Result := sgiRight;
end;

function UITypes_sgiUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUp = <value>;

  Result := sgiUp;
end;

function UITypes_sgiDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDown = <value>;

  Result := sgiDown;
end;

function UITypes_sgiUpLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpLeft = <value>;

  Result := sgiUpLeft;
end;

function UITypes_sgiUpRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpRight = <value>;

  Result := sgiUpRight;
end;

function UITypes_sgiDownLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownLeft = <value>;

  Result := sgiDownLeft;
end;

function UITypes_sgiDownRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownRight = <value>;

  Result := sgiDownRight;
end;

function UITypes_sgiLeftUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftUp = <value>;

  Result := sgiLeftUp;
end;

function UITypes_sgiLeftDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftDown = <value>;

  Result := sgiLeftDown;
end;

function UITypes_sgiRightUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightUp = <value>;

  Result := sgiRightUp;
end;

function UITypes_sgiRightDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightDown = <value>;

  Result := sgiRightDown;
end;

function UITypes_sgiUpDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpDown = <value>;

  Result := sgiUpDown;
end;

function UITypes_sgiDownUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownUp = <value>;

  Result := sgiDownUp;
end;

function UITypes_sgiLeftRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLeftRight = <value>;

  Result := sgiLeftRight;
end;

function UITypes_sgiRightLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiRightLeft = <value>;

  Result := sgiRightLeft;
end;

function UITypes_sgiUpLeftLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpLeftLong = <value>;

  Result := sgiUpLeftLong;
end;

function UITypes_sgiUpRightLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiUpRightLong = <value>;

  Result := sgiUpRightLong;
end;

function UITypes_sgiDownLeftLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownLeftLong = <value>;

  Result := sgiDownLeftLong;
end;

function UITypes_sgiDownRightLong_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDownRightLong = <value>;

  Result := sgiDownRightLong;
end;

function UITypes_sgiScratchout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiScratchout = <value>;

  Result := sgiScratchout;
end;

function UITypes_sgiTriangle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiTriangle = <value>;

  Result := sgiTriangle;
end;

function UITypes_sgiSquare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSquare = <value>;

  Result := sgiSquare;
end;

function UITypes_sgiCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCheck = <value>;

  Result := sgiCheck;
end;

function UITypes_sgiCurlicue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCurlicue = <value>;

  Result := sgiCurlicue;
end;

function UITypes_sgiDoubleCurlicue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDoubleCurlicue = <value>;

  Result := sgiDoubleCurlicue;
end;

function UITypes_sgiCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiCircle = <value>;

  Result := sgiCircle;
end;

function UITypes_sgiDoubleCircle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiDoubleCircle = <value>;

  Result := sgiDoubleCircle;
end;

function UITypes_sgiSemiCircleLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSemiCircleLeft = <value>;

  Result := sgiSemiCircleLeft;
end;

function UITypes_sgiSemiCircleRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiSemiCircleRight = <value>;

  Result := sgiSemiCircleRight;
end;

function UITypes_sgiChevronUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronUp = <value>;

  Result := sgiChevronUp;
end;

function UITypes_sgiChevronDown_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronDown = <value>;

  Result := sgiChevronDown;
end;

function UITypes_sgiChevronLeft_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronLeft = <value>;

  Result := sgiChevronLeft;
end;

function UITypes_sgiChevronRight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiChevronRight = <value>;

  Result := sgiChevronRight;
end;

function UITypes_sgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiFirst = <value>;

  Result := sgiFirst;
end;

function UITypes_sgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const sgiLast = <value>;

  Result := sgiLast;
end;

function UITypes_cgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cgiFirst = <value>;

  Result := cgiFirst;
end;

function UITypes_cgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cgiLast = <value>;

  Result := cgiLast;
end;

function UITypes_rgiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rgiFirst = <value>;

  Result := rgiFirst;
end;

function UITypes_rgiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const rgiLast = <value>;

  Result := rgiLast;
end;

function UITypes_igiFirst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiFirst = <value>;

  Result := igiFirst;
end;

function UITypes_igiLast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiLast = <value>;

  Result := igiLast;
end;

function UITypes_igiBegin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiBegin = <value>;

  Result := igiBegin;
end;

function UITypes_igiEnd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiEnd = <value>;

  Result := igiEnd;
end;

function UITypes_igiZoom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiZoom = <value>;

  Result := igiZoom;
end;

function UITypes_igiPan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiPan = <value>;

  Result := igiPan;
end;

function UITypes_igiRotate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiRotate = <value>;

  Result := igiRotate;
end;

function UITypes_igiTwoFingerTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiTwoFingerTap = <value>;

  Result := igiTwoFingerTap;
end;

function UITypes_igiPressAndTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiPressAndTap = <value>;

  Result := igiPressAndTap;
end;

function UITypes_igiLongTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiLongTap = <value>;

  Result := igiLongTap;
end;

function UITypes_igiDoubleTap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const igiDoubleTap = <value>;

  Result := igiDoubleTap;
end;

function UITypes_TColorRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorRef = UInt32;

  Result := TLMDUnitWrapper.TypeToVar(TColorRef_sw);
end;

function UITypes_TColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColor = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TColor_sw);
end;

function UITypes_TColorRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TColorRec_sw);
end;

function UITypes_TColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColors = TColorRec;

  Result := TLMDUnitWrapper.TypeToVar(TColors_sw);
end;

function UITypes_TAlphaColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlphaColor = Cardinal;

  Result := TLMDUnitWrapper.TypeToVar(TAlphaColor_sw);
end;

function UITypes_TAlphaColorRec_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlphaColorRec = record;

  Result := TLMDUnitWrapper.TypeToVar(TAlphaColorRec_sw);
end;

function UITypes_TAlphaColors_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAlphaColors = TAlphaColorRec;

  Result := TLMDUnitWrapper.TypeToVar(TAlphaColors_sw);
end;

function UITypes_TImageIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TImageIndex = Integer;

  Result := TLMDUnitWrapper.TypeToVar(TImageIndex_sw);
end;

function UITypes_TScrollStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollStyle = (ssNone, ssHorizontal, ssVertical, ss...

  Result := TLMDUnitWrapper.TypeToVar(TScrollStyle_sw);
end;

class function UITypes_sw.GetUnitName: WideString;
begin
  Result := 'UITypes';
end;

class procedure UITypes_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('LF_FACESIZE', UITypes_LF_FACESIZE_si, nil, VarType(System.UITypes.LF_FACESIZE));
  AData.AddType(TOpenOption_sw, UITypes_TOpenOption_si);
  AData.AddType(TOpenOptions_sw, UITypes_TOpenOptions_si);
  AData.AddType(TOpenOptionEx_sw, UITypes_TOpenOptionEx_si);
  AData.AddType(TOpenOptionsEx_sw, UITypes_TOpenOptionsEx_si);
  AData.AddType(TPrintRange_sw, UITypes_TPrintRange_si);
  AData.AddType(TPrintDialogOption_sw, UITypes_TPrintDialogOption_si);
  AData.AddType(TPrintDialogOptions_sw, UITypes_TPrintDialogOptions_si);
  AData.AddType(TPageSetupDialogOption_sw, UITypes_TPageSetupDialogOption_si);
  AData.AddType(TPageSetupDialogOptions_sw, UITypes_TPageSetupDialogOptions_si);
  AData.AddType(TPrinterKind_sw, UITypes_TPrinterKind_si);
  AData.AddType(TPageType_sw, UITypes_TPageType_si);
  AData.AddType(TPageMeasureUnits_sw, UITypes_TPageMeasureUnits_si);
  AData.AddType(TMsgDlgType_sw, UITypes_TMsgDlgType_si);
  AData.AddType(TMsgDlgBtn_sw, UITypes_TMsgDlgBtn_si);
  AData.AddType(TMsgDlgButtons_sw, UITypes_TMsgDlgButtons_si);
  AData.AddType(TCalDayOfWeek_sw, UITypes_TCalDayOfWeek_si);
  AData.AddType(TBorderIcon_sw, UITypes_TBorderIcon_si);
  AData.AddType(TBorderIcons_sw, UITypes_TBorderIcons_si);
  AData.AddType(TWindowState_sw, UITypes_TWindowState_si);
  AData.AddType(TEditCharCase_sw, UITypes_TEditCharCase_si);
  AData.AddType(TFontCharset_sw, UITypes_TFontCharset_si);
  AData.AddType(TFontPitch_sw, UITypes_TFontPitch_si);
  AData.AddType(TFontQuality_sw, UITypes_TFontQuality_si);
  AData.AddType(TFontStyle_sw, UITypes_TFontStyle_si);
  AData.AddType(TFontStyles_sw, UITypes_TFontStyles_si);
  AData.AddType(TFontName_sw, UITypes_TFontName_si);
  AData.AddType(TFontDataName_sw, UITypes_TFontDataName_si);
  AData.AddType(TFontStylesBase_sw, UITypes_TFontStylesBase_si);
  AData.AddType(TCloseAction_sw, UITypes_TCloseAction_si);
  AData.AddType(TMouseButton_sw, UITypes_TMouseButton_si);
  AData.AddType(TMouseActivate_sw, UITypes_TMouseActivate_si);
  AData.AddType(TTabOrder_sw, UITypes_TTabOrder_si);
  AData.AddType(TModalResult_sw, UITypes_TModalResult_si);
  AData.AddType(TDragMode_sw, UITypes_TDragMode_si);
  AData.AddType(TDragState_sw, UITypes_TDragState_si);
  AData.AddType(TDragKind_sw, UITypes_TDragKind_si);
  AData.AddType(TAnchorKind_sw, UITypes_TAnchorKind_si);
  AData.AddType(TAnchors_sw, UITypes_TAnchors_si);
  AData.AddType(TScrollCode_sw, UITypes_TScrollCode_si);
  AData.AddType(TPrinterState_sw, UITypes_TPrinterState_si);
  AData.AddType(TPrinterOrientation_sw, UITypes_TPrinterOrientation_si);
  AData.AddType(TPrinterCapability_sw, UITypes_TPrinterCapability_si);
  AData.AddType(TPrinterCapabilities_sw, UITypes_TPrinterCapabilities_si);
  AData.AddType(TCursor_sw, UITypes_TCursor_si);
  AData.AddConstant('crDefault', UITypes_crDefault_si, TCursor_sw);
  AData.AddConstant('crNone', UITypes_crNone_si, TCursor_sw);
  AData.AddConstant('crArrow', UITypes_crArrow_si, TCursor_sw);
  AData.AddConstant('crCross', UITypes_crCross_si, TCursor_sw);
  AData.AddConstant('crIBeam', UITypes_crIBeam_si, TCursor_sw);
  AData.AddConstant('crSize', UITypes_crSize_si, TCursor_sw);
  AData.AddConstant('crSizeNESW', UITypes_crSizeNESW_si, TCursor_sw);
  AData.AddConstant('crSizeNS', UITypes_crSizeNS_si, TCursor_sw);
  AData.AddConstant('crSizeNWSE', UITypes_crSizeNWSE_si, TCursor_sw);
  AData.AddConstant('crSizeWE', UITypes_crSizeWE_si, TCursor_sw);
  AData.AddConstant('crUpArrow', UITypes_crUpArrow_si, TCursor_sw);
  AData.AddConstant('crHourGlass', UITypes_crHourGlass_si, TCursor_sw);
  AData.AddConstant('crDrag', UITypes_crDrag_si, TCursor_sw);
  AData.AddConstant('crNoDrop', UITypes_crNoDrop_si, TCursor_sw);
  AData.AddConstant('crHSplit', UITypes_crHSplit_si, TCursor_sw);
  AData.AddConstant('crVSplit', UITypes_crVSplit_si, TCursor_sw);
  AData.AddConstant('crMultiDrag', UITypes_crMultiDrag_si, TCursor_sw);
  AData.AddConstant('crSQLWait', UITypes_crSQLWait_si, TCursor_sw);
  AData.AddConstant('crNo', UITypes_crNo_si, TCursor_sw);
  AData.AddConstant('crAppStart', UITypes_crAppStart_si, TCursor_sw);
  AData.AddConstant('crHelp', UITypes_crHelp_si, TCursor_sw);
  AData.AddConstant('crHandPoint', UITypes_crHandPoint_si, TCursor_sw);
  AData.AddConstant('crSizeAll', UITypes_crSizeAll_si, TCursor_sw);
  AData.AddConstant('idOK', UITypes_idOK_si, nil, VarType(System.UITypes.idOK));
  AData.AddConstant('idCancel', UITypes_idCancel_si, nil, VarType(System.UITypes.idCancel));
  AData.AddConstant('idAbort', UITypes_idAbort_si, nil, VarType(System.UITypes.idAbort));
  AData.AddConstant('idRetry', UITypes_idRetry_si, nil, VarType(System.UITypes.idRetry));
  AData.AddConstant('idIgnore', UITypes_idIgnore_si, nil, VarType(System.UITypes.idIgnore));
  AData.AddConstant('idYes', UITypes_idYes_si, nil, VarType(System.UITypes.idYes));
  AData.AddConstant('idNo', UITypes_idNo_si, nil, VarType(System.UITypes.idNo));
  AData.AddConstant('idClose', UITypes_idClose_si, nil, VarType(System.UITypes.idClose));
  AData.AddConstant('idHelp', UITypes_idHelp_si, nil, VarType(System.UITypes.idHelp));
  AData.AddConstant('idTryAgain', UITypes_idTryAgain_si, nil, VarType(System.UITypes.idTryAgain));
  AData.AddConstant('idContinue', UITypes_idContinue_si, nil, VarType(System.UITypes.idContinue));
  AData.AddConstant('mrNone', UITypes_mrNone_si, nil, VarType(System.UITypes.mrNone));
  AData.AddConstant('mrOk', UITypes_mrOk_si, Integer_sw);
  AData.AddConstant('mrCancel', UITypes_mrCancel_si, Integer_sw);
  AData.AddConstant('mrAbort', UITypes_mrAbort_si, Integer_sw);
  AData.AddConstant('mrRetry', UITypes_mrRetry_si, Integer_sw);
  AData.AddConstant('mrIgnore', UITypes_mrIgnore_si, Integer_sw);
  AData.AddConstant('mrYes', UITypes_mrYes_si, Integer_sw);
  AData.AddConstant('mrNo', UITypes_mrNo_si, Integer_sw);
  AData.AddConstant('mrClose', UITypes_mrClose_si, Integer_sw);
  AData.AddConstant('mrHelp', UITypes_mrHelp_si, Integer_sw);
  AData.AddConstant('mrTryAgain', UITypes_mrTryAgain_si, Integer_sw);
  AData.AddConstant('mrContinue', UITypes_mrContinue_si, Integer_sw);
  AData.AddConstant('mrAll', UITypes_mrAll_si, nil, VarType(System.UITypes.mrAll));
  AData.AddConstant('mrNoToAll', UITypes_mrNoToAll_si, nil, VarType(System.UITypes.mrNoToAll));
  AData.AddConstant('mrYesToAll', UITypes_mrYesToAll_si, nil, VarType(System.UITypes.mrYesToAll));
  AData.AddFunction('IsPositiveResult', UITypes_IsPositiveResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsNegativeResult', UITypes_IsNegativeResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsAbortResult', UITypes_IsAbortResult_si, Boolean_sw, 1, False);
  AData.AddFunction('IsAnAllResult', UITypes_IsAnAllResult_si, Boolean_sw, 1, False);
  AData.AddFunction('StripAllFromResult', UITypes_StripAllFromResult_si, TModalResult_sw, 1, False);
  AData.AddConstant('vkLButton', UITypes_vkLButton_si, nil, VarType(System.UITypes.vkLButton));
  AData.AddConstant('vkRButton', UITypes_vkRButton_si, nil, VarType(System.UITypes.vkRButton));
  AData.AddConstant('vkCancel', UITypes_vkCancel_si, nil, VarType(System.UITypes.vkCancel));
  AData.AddConstant('vkMButton', UITypes_vkMButton_si, nil, VarType(System.UITypes.vkMButton));
  AData.AddConstant('vkXButton1', UITypes_vkXButton1_si, nil, VarType(System.UITypes.vkXButton1));
  AData.AddConstant('vkXButton2', UITypes_vkXButton2_si, nil, VarType(System.UITypes.vkXButton2));
  AData.AddConstant('vkBack', UITypes_vkBack_si, nil, VarType(System.UITypes.vkBack));
  AData.AddConstant('vkTab', UITypes_vkTab_si, nil, VarType(System.UITypes.vkTab));
  AData.AddConstant('vkLineFeed', UITypes_vkLineFeed_si, nil, VarType(System.UITypes.vkLineFeed));
  AData.AddConstant('vkClear', UITypes_vkClear_si, nil, VarType(System.UITypes.vkClear));
  AData.AddConstant('vkReturn', UITypes_vkReturn_si, nil, VarType(System.UITypes.vkReturn));
  AData.AddConstant('vkShift', UITypes_vkShift_si, nil, VarType(System.UITypes.vkShift));
  AData.AddConstant('vkControl', UITypes_vkControl_si, nil, VarType(System.UITypes.vkControl));
  AData.AddConstant('vkMenu', UITypes_vkMenu_si, nil, VarType(System.UITypes.vkMenu));
  AData.AddConstant('vkPause', UITypes_vkPause_si, nil, VarType(System.UITypes.vkPause));
  AData.AddConstant('vkCapital', UITypes_vkCapital_si, nil, VarType(System.UITypes.vkCapital));
  AData.AddConstant('vkKana', UITypes_vkKana_si, nil, VarType(System.UITypes.vkKana));
  AData.AddConstant('vkHangul', UITypes_vkHangul_si, nil, VarType(System.UITypes.vkHangul));
  AData.AddConstant('vkJunja', UITypes_vkJunja_si, nil, VarType(System.UITypes.vkJunja));
  AData.AddConstant('vkFinal', UITypes_vkFinal_si, nil, VarType(System.UITypes.vkFinal));
  AData.AddConstant('vkHanja', UITypes_vkHanja_si, nil, VarType(System.UITypes.vkHanja));
  AData.AddConstant('vkKanji', UITypes_vkKanji_si, nil, VarType(System.UITypes.vkKanji));
  AData.AddConstant('vkConvert', UITypes_vkConvert_si, nil, VarType(System.UITypes.vkConvert));
  AData.AddConstant('vkNonConvert', UITypes_vkNonConvert_si, nil, VarType(System.UITypes.vkNonConvert));
  AData.AddConstant('vkAccept', UITypes_vkAccept_si, nil, VarType(System.UITypes.vkAccept));
  AData.AddConstant('vkModeChange', UITypes_vkModeChange_si, nil, VarType(System.UITypes.vkModeChange));
  AData.AddConstant('vkEscape', UITypes_vkEscape_si, nil, VarType(System.UITypes.vkEscape));
  AData.AddConstant('vkSpace', UITypes_vkSpace_si, nil, VarType(System.UITypes.vkSpace));
  AData.AddConstant('vkPrior', UITypes_vkPrior_si, nil, VarType(System.UITypes.vkPrior));
  AData.AddConstant('vkNext', UITypes_vkNext_si, nil, VarType(System.UITypes.vkNext));
  AData.AddConstant('vkEnd', UITypes_vkEnd_si, nil, VarType(System.UITypes.vkEnd));
  AData.AddConstant('vkHome', UITypes_vkHome_si, nil, VarType(System.UITypes.vkHome));
  AData.AddConstant('vkLeft', UITypes_vkLeft_si, nil, VarType(System.UITypes.vkLeft));
  AData.AddConstant('vkUp', UITypes_vkUp_si, nil, VarType(System.UITypes.vkUp));
  AData.AddConstant('vkRight', UITypes_vkRight_si, nil, VarType(System.UITypes.vkRight));
  AData.AddConstant('vkDown', UITypes_vkDown_si, nil, VarType(System.UITypes.vkDown));
  AData.AddConstant('vkSelect', UITypes_vkSelect_si, nil, VarType(System.UITypes.vkSelect));
  AData.AddConstant('vkPrint', UITypes_vkPrint_si, nil, VarType(System.UITypes.vkPrint));
  AData.AddConstant('vkExecute', UITypes_vkExecute_si, nil, VarType(System.UITypes.vkExecute));
  AData.AddConstant('vkSnapshot', UITypes_vkSnapshot_si, nil, VarType(System.UITypes.vkSnapshot));
  AData.AddConstant('vkInsert', UITypes_vkInsert_si, nil, VarType(System.UITypes.vkInsert));
  AData.AddConstant('vkDelete', UITypes_vkDelete_si, nil, VarType(System.UITypes.vkDelete));
  AData.AddConstant('vkHelp', UITypes_vkHelp_si, nil, VarType(System.UITypes.vkHelp));
  AData.AddConstant('vk0', UITypes_vk0_si, nil, VarType(System.UITypes.vk0));
  AData.AddConstant('vk1', UITypes_vk1_si, nil, VarType(System.UITypes.vk1));
  AData.AddConstant('vk2', UITypes_vk2_si, nil, VarType(System.UITypes.vk2));
  AData.AddConstant('vk3', UITypes_vk3_si, nil, VarType(System.UITypes.vk3));
  AData.AddConstant('vk4', UITypes_vk4_si, nil, VarType(System.UITypes.vk4));
  AData.AddConstant('vk5', UITypes_vk5_si, nil, VarType(System.UITypes.vk5));
  AData.AddConstant('vk6', UITypes_vk6_si, nil, VarType(System.UITypes.vk6));
  AData.AddConstant('vk7', UITypes_vk7_si, nil, VarType(System.UITypes.vk7));
  AData.AddConstant('vk8', UITypes_vk8_si, nil, VarType(System.UITypes.vk8));
  AData.AddConstant('vk9', UITypes_vk9_si, nil, VarType(System.UITypes.vk9));
  AData.AddConstant('vkA', UITypes_vkA_si, nil, VarType(System.UITypes.vkA));
  AData.AddConstant('vkB', UITypes_vkB_si, nil, VarType(System.UITypes.vkB));
  AData.AddConstant('vkC', UITypes_vkC_si, nil, VarType(System.UITypes.vkC));
  AData.AddConstant('vkD', UITypes_vkD_si, nil, VarType(System.UITypes.vkD));
  AData.AddConstant('vkE', UITypes_vkE_si, nil, VarType(System.UITypes.vkE));
  AData.AddConstant('vkF', UITypes_vkF_si, nil, VarType(System.UITypes.vkF));
  AData.AddConstant('vkG', UITypes_vkG_si, nil, VarType(System.UITypes.vkG));
  AData.AddConstant('vkH', UITypes_vkH_si, nil, VarType(System.UITypes.vkH));
  AData.AddConstant('vkI', UITypes_vkI_si, nil, VarType(System.UITypes.vkI));
  AData.AddConstant('vkJ', UITypes_vkJ_si, nil, VarType(System.UITypes.vkJ));
  AData.AddConstant('vkK', UITypes_vkK_si, nil, VarType(System.UITypes.vkK));
  AData.AddConstant('vkL', UITypes_vkL_si, nil, VarType(System.UITypes.vkL));
  AData.AddConstant('vkM', UITypes_vkM_si, nil, VarType(System.UITypes.vkM));
  AData.AddConstant('vkN', UITypes_vkN_si, nil, VarType(System.UITypes.vkN));
  AData.AddConstant('vkO', UITypes_vkO_si, nil, VarType(System.UITypes.vkO));
  AData.AddConstant('vkP', UITypes_vkP_si, nil, VarType(System.UITypes.vkP));
  AData.AddConstant('vkQ', UITypes_vkQ_si, nil, VarType(System.UITypes.vkQ));
  AData.AddConstant('vkR', UITypes_vkR_si, nil, VarType(System.UITypes.vkR));
  AData.AddConstant('vkS', UITypes_vkS_si, nil, VarType(System.UITypes.vkS));
  AData.AddConstant('vkT', UITypes_vkT_si, nil, VarType(System.UITypes.vkT));
  AData.AddConstant('vkU', UITypes_vkU_si, nil, VarType(System.UITypes.vkU));
  AData.AddConstant('vkV', UITypes_vkV_si, nil, VarType(System.UITypes.vkV));
  AData.AddConstant('vkW', UITypes_vkW_si, nil, VarType(System.UITypes.vkW));
  AData.AddConstant('vkX', UITypes_vkX_si, nil, VarType(System.UITypes.vkX));
  AData.AddConstant('vkY', UITypes_vkY_si, nil, VarType(System.UITypes.vkY));
  AData.AddConstant('vkZ', UITypes_vkZ_si, nil, VarType(System.UITypes.vkZ));
  AData.AddConstant('vkLWin', UITypes_vkLWin_si, nil, VarType(System.UITypes.vkLWin));
  AData.AddConstant('vkRWin', UITypes_vkRWin_si, nil, VarType(System.UITypes.vkRWin));
  AData.AddConstant('vkApps', UITypes_vkApps_si, nil, VarType(System.UITypes.vkApps));
  AData.AddConstant('vkSleep', UITypes_vkSleep_si, nil, VarType(System.UITypes.vkSleep));
  AData.AddConstant('vkNumpad0', UITypes_vkNumpad0_si, nil, VarType(System.UITypes.vkNumpad0));
  AData.AddConstant('vkNumpad1', UITypes_vkNumpad1_si, nil, VarType(System.UITypes.vkNumpad1));
  AData.AddConstant('vkNumpad2', UITypes_vkNumpad2_si, nil, VarType(System.UITypes.vkNumpad2));
  AData.AddConstant('vkNumpad3', UITypes_vkNumpad3_si, nil, VarType(System.UITypes.vkNumpad3));
  AData.AddConstant('vkNumpad4', UITypes_vkNumpad4_si, nil, VarType(System.UITypes.vkNumpad4));
  AData.AddConstant('vkNumpad5', UITypes_vkNumpad5_si, nil, VarType(System.UITypes.vkNumpad5));
  AData.AddConstant('vkNumpad6', UITypes_vkNumpad6_si, nil, VarType(System.UITypes.vkNumpad6));
  AData.AddConstant('vkNumpad7', UITypes_vkNumpad7_si, nil, VarType(System.UITypes.vkNumpad7));
  AData.AddConstant('vkNumpad8', UITypes_vkNumpad8_si, nil, VarType(System.UITypes.vkNumpad8));
  AData.AddConstant('vkNumpad9', UITypes_vkNumpad9_si, nil, VarType(System.UITypes.vkNumpad9));
  AData.AddConstant('vkMultiply', UITypes_vkMultiply_si, nil, VarType(System.UITypes.vkMultiply));
  AData.AddConstant('vkAdd', UITypes_vkAdd_si, nil, VarType(System.UITypes.vkAdd));
  AData.AddConstant('vkSeparator', UITypes_vkSeparator_si, nil, VarType(System.UITypes.vkSeparator));
  AData.AddConstant('vkSubtract', UITypes_vkSubtract_si, nil, VarType(System.UITypes.vkSubtract));
  AData.AddConstant('vkDecimal', UITypes_vkDecimal_si, nil, VarType(System.UITypes.vkDecimal));
  AData.AddConstant('vkDivide', UITypes_vkDivide_si, nil, VarType(System.UITypes.vkDivide));
  AData.AddConstant('vkF1', UITypes_vkF1_si, nil, VarType(System.UITypes.vkF1));
  AData.AddConstant('vkF2', UITypes_vkF2_si, nil, VarType(System.UITypes.vkF2));
  AData.AddConstant('vkF3', UITypes_vkF3_si, nil, VarType(System.UITypes.vkF3));
  AData.AddConstant('vkF4', UITypes_vkF4_si, nil, VarType(System.UITypes.vkF4));
  AData.AddConstant('vkF5', UITypes_vkF5_si, nil, VarType(System.UITypes.vkF5));
  AData.AddConstant('vkF6', UITypes_vkF6_si, nil, VarType(System.UITypes.vkF6));
  AData.AddConstant('vkF7', UITypes_vkF7_si, nil, VarType(System.UITypes.vkF7));
  AData.AddConstant('vkF8', UITypes_vkF8_si, nil, VarType(System.UITypes.vkF8));
  AData.AddConstant('vkF9', UITypes_vkF9_si, nil, VarType(System.UITypes.vkF9));
  AData.AddConstant('vkF10', UITypes_vkF10_si, nil, VarType(System.UITypes.vkF10));
  AData.AddConstant('vkF11', UITypes_vkF11_si, nil, VarType(System.UITypes.vkF11));
  AData.AddConstant('vkF12', UITypes_vkF12_si, nil, VarType(System.UITypes.vkF12));
  AData.AddConstant('vkF13', UITypes_vkF13_si, nil, VarType(System.UITypes.vkF13));
  AData.AddConstant('vkF14', UITypes_vkF14_si, nil, VarType(System.UITypes.vkF14));
  AData.AddConstant('vkF15', UITypes_vkF15_si, nil, VarType(System.UITypes.vkF15));
  AData.AddConstant('vkF16', UITypes_vkF16_si, nil, VarType(System.UITypes.vkF16));
  AData.AddConstant('vkF17', UITypes_vkF17_si, nil, VarType(System.UITypes.vkF17));
  AData.AddConstant('vkF18', UITypes_vkF18_si, nil, VarType(System.UITypes.vkF18));
  AData.AddConstant('vkF19', UITypes_vkF19_si, nil, VarType(System.UITypes.vkF19));
  AData.AddConstant('vkF20', UITypes_vkF20_si, nil, VarType(System.UITypes.vkF20));
  AData.AddConstant('vkF21', UITypes_vkF21_si, nil, VarType(System.UITypes.vkF21));
  AData.AddConstant('vkF22', UITypes_vkF22_si, nil, VarType(System.UITypes.vkF22));
  AData.AddConstant('vkF23', UITypes_vkF23_si, nil, VarType(System.UITypes.vkF23));
  AData.AddConstant('vkF24', UITypes_vkF24_si, nil, VarType(System.UITypes.vkF24));
  AData.AddConstant('vkCamera', UITypes_vkCamera_si, nil, VarType(System.UITypes.vkCamera));
  AData.AddConstant('vkHardwareBack', UITypes_vkHardwareBack_si, nil, VarType(System.UITypes.vkHardwareBack));
  AData.AddConstant('vkNumLock', UITypes_vkNumLock_si, nil, VarType(System.UITypes.vkNumLock));
  AData.AddConstant('vkScroll', UITypes_vkScroll_si, nil, VarType(System.UITypes.vkScroll));
  AData.AddConstant('vkLShift', UITypes_vkLShift_si, nil, VarType(System.UITypes.vkLShift));
  AData.AddConstant('vkRShift', UITypes_vkRShift_si, nil, VarType(System.UITypes.vkRShift));
  AData.AddConstant('vkLControl', UITypes_vkLControl_si, nil, VarType(System.UITypes.vkLControl));
  AData.AddConstant('vkRControl', UITypes_vkRControl_si, nil, VarType(System.UITypes.vkRControl));
  AData.AddConstant('vkLMenu', UITypes_vkLMenu_si, nil, VarType(System.UITypes.vkLMenu));
  AData.AddConstant('vkRMenu', UITypes_vkRMenu_si, nil, VarType(System.UITypes.vkRMenu));
  AData.AddConstant('vkBrowserBack', UITypes_vkBrowserBack_si, nil, VarType(System.UITypes.vkBrowserBack));
  AData.AddConstant('vkBrowserForward', UITypes_vkBrowserForward_si, nil, VarType(System.UITypes.vkBrowserForward));
  AData.AddConstant('vkBrowserRefresh', UITypes_vkBrowserRefresh_si, nil, VarType(System.UITypes.vkBrowserRefresh));
  AData.AddConstant('vkBrowserStop', UITypes_vkBrowserStop_si, nil, VarType(System.UITypes.vkBrowserStop));
  AData.AddConstant('vkBrowserSearch', UITypes_vkBrowserSearch_si, nil, VarType(System.UITypes.vkBrowserSearch));
  AData.AddConstant('vkBrowserFavorites', UITypes_vkBrowserFavorites_si, nil, VarType(System.UITypes.vkBrowserFavorites));
  AData.AddConstant('vkBrowserHome', UITypes_vkBrowserHome_si, nil, VarType(System.UITypes.vkBrowserHome));
  AData.AddConstant('vkVolumeMute', UITypes_vkVolumeMute_si, nil, VarType(System.UITypes.vkVolumeMute));
  AData.AddConstant('vkVolumeDown', UITypes_vkVolumeDown_si, nil, VarType(System.UITypes.vkVolumeDown));
  AData.AddConstant('vkVolumeUp', UITypes_vkVolumeUp_si, nil, VarType(System.UITypes.vkVolumeUp));
  AData.AddConstant('vkMediaNextTrack', UITypes_vkMediaNextTrack_si, nil, VarType(System.UITypes.vkMediaNextTrack));
  AData.AddConstant('vkMediaPrevTrack', UITypes_vkMediaPrevTrack_si, nil, VarType(System.UITypes.vkMediaPrevTrack));
  AData.AddConstant('vkMediaStop', UITypes_vkMediaStop_si, nil, VarType(System.UITypes.vkMediaStop));
  AData.AddConstant('vkMediaPlayPause', UITypes_vkMediaPlayPause_si, nil, VarType(System.UITypes.vkMediaPlayPause));
  AData.AddConstant('vkLaunchMail', UITypes_vkLaunchMail_si, nil, VarType(System.UITypes.vkLaunchMail));
  AData.AddConstant('vkLaunchMediaSelect', UITypes_vkLaunchMediaSelect_si, nil, VarType(System.UITypes.vkLaunchMediaSelect));
  AData.AddConstant('vkLaunchApp1', UITypes_vkLaunchApp1_si, nil, VarType(System.UITypes.vkLaunchApp1));
  AData.AddConstant('vkLaunchApp2', UITypes_vkLaunchApp2_si, nil, VarType(System.UITypes.vkLaunchApp2));
  AData.AddConstant('vkSemicolon', UITypes_vkSemicolon_si, nil, VarType(System.UITypes.vkSemicolon));
  AData.AddConstant('vkEqual', UITypes_vkEqual_si, nil, VarType(System.UITypes.vkEqual));
  AData.AddConstant('vkComma', UITypes_vkComma_si, nil, VarType(System.UITypes.vkComma));
  AData.AddConstant('vkMinus', UITypes_vkMinus_si, nil, VarType(System.UITypes.vkMinus));
  AData.AddConstant('vkPeriod', UITypes_vkPeriod_si, nil, VarType(System.UITypes.vkPeriod));
  AData.AddConstant('vkSlash', UITypes_vkSlash_si, nil, VarType(System.UITypes.vkSlash));
  AData.AddConstant('vkTilde', UITypes_vkTilde_si, nil, VarType(System.UITypes.vkTilde));
  AData.AddConstant('vkLeftBracket', UITypes_vkLeftBracket_si, nil, VarType(System.UITypes.vkLeftBracket));
  AData.AddConstant('vkBackslash', UITypes_vkBackslash_si, nil, VarType(System.UITypes.vkBackslash));
  AData.AddConstant('vkRightBracket', UITypes_vkRightBracket_si, nil, VarType(System.UITypes.vkRightBracket));
  AData.AddConstant('vkQuote', UITypes_vkQuote_si, nil, VarType(System.UITypes.vkQuote));
  AData.AddConstant('vkPara', UITypes_vkPara_si, nil, VarType(System.UITypes.vkPara));
  AData.AddConstant('vkOem102', UITypes_vkOem102_si, nil, VarType(System.UITypes.vkOem102));
  AData.AddConstant('vkIcoHelp', UITypes_vkIcoHelp_si, nil, VarType(System.UITypes.vkIcoHelp));
  AData.AddConstant('vkIco00', UITypes_vkIco00_si, nil, VarType(System.UITypes.vkIco00));
  AData.AddConstant('vkProcessKey', UITypes_vkProcessKey_si, nil, VarType(System.UITypes.vkProcessKey));
  AData.AddConstant('vkIcoClear', UITypes_vkIcoClear_si, nil, VarType(System.UITypes.vkIcoClear));
  AData.AddConstant('vkPacket', UITypes_vkPacket_si, nil, VarType(System.UITypes.vkPacket));
  AData.AddConstant('vkAttn', UITypes_vkAttn_si, nil, VarType(System.UITypes.vkAttn));
  AData.AddConstant('vkCrsel', UITypes_vkCrsel_si, nil, VarType(System.UITypes.vkCrsel));
  AData.AddConstant('vkExsel', UITypes_vkExsel_si, nil, VarType(System.UITypes.vkExsel));
  AData.AddConstant('vkErEof', UITypes_vkErEof_si, nil, VarType(System.UITypes.vkErEof));
  AData.AddConstant('vkPlay', UITypes_vkPlay_si, nil, VarType(System.UITypes.vkPlay));
  AData.AddConstant('vkZoom', UITypes_vkZoom_si, nil, VarType(System.UITypes.vkZoom));
  AData.AddConstant('vkNoname', UITypes_vkNoname_si, nil, VarType(System.UITypes.vkNoname));
  AData.AddConstant('vkPA1', UITypes_vkPA1_si, nil, VarType(System.UITypes.vkPA1));
  AData.AddConstant('vkOemClear', UITypes_vkOemClear_si, nil, VarType(System.UITypes.vkOemClear));
  AData.AddConstant('vkNone', UITypes_vkNone_si, nil, VarType(System.UITypes.vkNone));
  AData.AddConstant('sgiNoGesture', UITypes_sgiNoGesture_si, nil, VarType(System.UITypes.sgiNoGesture));
  AData.AddConstant('sgiLeft', UITypes_sgiLeft_si, nil, VarType(System.UITypes.sgiLeft));
  AData.AddConstant('sgiRight', UITypes_sgiRight_si, nil, VarType(System.UITypes.sgiRight));
  AData.AddConstant('sgiUp', UITypes_sgiUp_si, nil, VarType(System.UITypes.sgiUp));
  AData.AddConstant('sgiDown', UITypes_sgiDown_si, nil, VarType(System.UITypes.sgiDown));
  AData.AddConstant('sgiUpLeft', UITypes_sgiUpLeft_si, nil, VarType(System.UITypes.sgiUpLeft));
  AData.AddConstant('sgiUpRight', UITypes_sgiUpRight_si, nil, VarType(System.UITypes.sgiUpRight));
  AData.AddConstant('sgiDownLeft', UITypes_sgiDownLeft_si, nil, VarType(System.UITypes.sgiDownLeft));
  AData.AddConstant('sgiDownRight', UITypes_sgiDownRight_si, nil, VarType(System.UITypes.sgiDownRight));
  AData.AddConstant('sgiLeftUp', UITypes_sgiLeftUp_si, nil, VarType(System.UITypes.sgiLeftUp));
  AData.AddConstant('sgiLeftDown', UITypes_sgiLeftDown_si, nil, VarType(System.UITypes.sgiLeftDown));
  AData.AddConstant('sgiRightUp', UITypes_sgiRightUp_si, nil, VarType(System.UITypes.sgiRightUp));
  AData.AddConstant('sgiRightDown', UITypes_sgiRightDown_si, nil, VarType(System.UITypes.sgiRightDown));
  AData.AddConstant('sgiUpDown', UITypes_sgiUpDown_si, nil, VarType(System.UITypes.sgiUpDown));
  AData.AddConstant('sgiDownUp', UITypes_sgiDownUp_si, nil, VarType(System.UITypes.sgiDownUp));
  AData.AddConstant('sgiLeftRight', UITypes_sgiLeftRight_si, nil, VarType(System.UITypes.sgiLeftRight));
  AData.AddConstant('sgiRightLeft', UITypes_sgiRightLeft_si, nil, VarType(System.UITypes.sgiRightLeft));
  AData.AddConstant('sgiUpLeftLong', UITypes_sgiUpLeftLong_si, nil, VarType(System.UITypes.sgiUpLeftLong));
  AData.AddConstant('sgiUpRightLong', UITypes_sgiUpRightLong_si, nil, VarType(System.UITypes.sgiUpRightLong));
  AData.AddConstant('sgiDownLeftLong', UITypes_sgiDownLeftLong_si, nil, VarType(System.UITypes.sgiDownLeftLong));
  AData.AddConstant('sgiDownRightLong', UITypes_sgiDownRightLong_si, nil, VarType(System.UITypes.sgiDownRightLong));
  AData.AddConstant('sgiScratchout', UITypes_sgiScratchout_si, nil, VarType(System.UITypes.sgiScratchout));
  AData.AddConstant('sgiTriangle', UITypes_sgiTriangle_si, nil, VarType(System.UITypes.sgiTriangle));
  AData.AddConstant('sgiSquare', UITypes_sgiSquare_si, nil, VarType(System.UITypes.sgiSquare));
  AData.AddConstant('sgiCheck', UITypes_sgiCheck_si, nil, VarType(System.UITypes.sgiCheck));
  AData.AddConstant('sgiCurlicue', UITypes_sgiCurlicue_si, nil, VarType(System.UITypes.sgiCurlicue));
  AData.AddConstant('sgiDoubleCurlicue', UITypes_sgiDoubleCurlicue_si, nil, VarType(System.UITypes.sgiDoubleCurlicue));
  AData.AddConstant('sgiCircle', UITypes_sgiCircle_si, nil, VarType(System.UITypes.sgiCircle));
  AData.AddConstant('sgiDoubleCircle', UITypes_sgiDoubleCircle_si, nil, VarType(System.UITypes.sgiDoubleCircle));
  AData.AddConstant('sgiSemiCircleLeft', UITypes_sgiSemiCircleLeft_si, nil, VarType(System.UITypes.sgiSemiCircleLeft));
  AData.AddConstant('sgiSemiCircleRight', UITypes_sgiSemiCircleRight_si, nil, VarType(System.UITypes.sgiSemiCircleRight));
  AData.AddConstant('sgiChevronUp', UITypes_sgiChevronUp_si, nil, VarType(System.UITypes.sgiChevronUp));
  AData.AddConstant('sgiChevronDown', UITypes_sgiChevronDown_si, nil, VarType(System.UITypes.sgiChevronDown));
  AData.AddConstant('sgiChevronLeft', UITypes_sgiChevronLeft_si, nil, VarType(System.UITypes.sgiChevronLeft));
  AData.AddConstant('sgiChevronRight', UITypes_sgiChevronRight_si, nil, VarType(System.UITypes.sgiChevronRight));
  AData.AddConstant('sgiFirst', UITypes_sgiFirst_si, Integer_sw);
  AData.AddConstant('sgiLast', UITypes_sgiLast_si, Integer_sw);
  AData.AddConstant('cgiFirst', UITypes_cgiFirst_si, nil, VarType(System.UITypes.cgiFirst));
  AData.AddConstant('cgiLast', UITypes_cgiLast_si, nil, VarType(System.UITypes.cgiLast));
  AData.AddConstant('rgiFirst', UITypes_rgiFirst_si, nil, VarType(System.UITypes.rgiFirst));
  AData.AddConstant('rgiLast', UITypes_rgiLast_si, nil, VarType(System.UITypes.rgiLast));
  AData.AddConstant('igiFirst', UITypes_igiFirst_si, nil, VarType(System.UITypes.igiFirst));
  AData.AddConstant('igiLast', UITypes_igiLast_si, nil, VarType(System.UITypes.igiLast));
  AData.AddConstant('igiBegin', UITypes_igiBegin_si, nil, VarType(System.UITypes.igiBegin));
  AData.AddConstant('igiEnd', UITypes_igiEnd_si, nil, VarType(System.UITypes.igiEnd));
  AData.AddConstant('igiZoom', UITypes_igiZoom_si, nil, VarType(System.UITypes.igiZoom));
  AData.AddConstant('igiPan', UITypes_igiPan_si, nil, VarType(System.UITypes.igiPan));
  AData.AddConstant('igiRotate', UITypes_igiRotate_si, nil, VarType(System.UITypes.igiRotate));
  AData.AddConstant('igiTwoFingerTap', UITypes_igiTwoFingerTap_si, nil, VarType(System.UITypes.igiTwoFingerTap));
  AData.AddConstant('igiPressAndTap', UITypes_igiPressAndTap_si, nil, VarType(System.UITypes.igiPressAndTap));
  AData.AddConstant('igiLongTap', UITypes_igiLongTap_si, nil, VarType(System.UITypes.igiLongTap));
  AData.AddConstant('igiDoubleTap', UITypes_igiDoubleTap_si, nil, VarType(System.UITypes.igiDoubleTap));
  AData.AddType(TColorRef_sw, UITypes_TColorRef_si);
  AData.AddType(TColor_sw, UITypes_TColor_si);
  AData.AddType(TColorRec_sw, UITypes_TColorRec_si);
  AData.AddType(TColors_sw, UITypes_TColors_si);
  AData.AddType(TAlphaColor_sw, UITypes_TAlphaColor_si);
  AData.AddType(TAlphaColorRec_sw, UITypes_TAlphaColorRec_si);
  AData.AddType(TAlphaColors_sw, UITypes_TAlphaColors_si);
  AData.AddType(TImageIndex_sw, UITypes_TImageIndex_si);
  AData.AddType(TScrollStyle_sw, UITypes_TScrollStyle_si);
end;

class function UITypes_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(UITypes_sw);
end;

initialization
  RegisterUnitWrapper(UITypes_sw);

end.
