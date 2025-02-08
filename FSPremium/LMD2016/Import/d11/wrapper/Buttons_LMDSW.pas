unit Buttons_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Buttons' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Windows, Messages, Classes, Controls, Forms,
  Graphics, StdCtrls, ExtCtrls, CommCtrl, ImgList, Buttons, Windows_LMDSW,
  Messages_LMDSW, Classes_LMDSW, Controls_LMDSW, Forms_LMDSW, Graphics_LMDSW,
  StdCtrls_LMDSW, ExtCtrls_LMDSW, CommCtrl_LMDSW, ImgList_LMDSW;


{ Type wrappers }

type
  TSpeedButtonActionLink_sw = class;
  TSpeedButton_sw = class;
  TBitBtnActionLink_sw = class;
  TBitBtn_sw = class;

  TButtonLayout_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TButtonLayout): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonLayout;
  end;

  TButtonState_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TButtonState): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonState;
  end;

  TButtonStyle_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TButtonStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TButtonStyle;
  end;

  TNumGlyphs_sw = class(TLMDSubrangeWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TNumGlyphs): OleVariant;
    class function FromVar(const AValue: OleVariant): TNumGlyphs;
  end;

  TSpeedButtonActionLink_sc = class of TSpeedButtonActionLink;
  TSpeedButtonActionLink_sw = class(TControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSpeedButtonActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TSpeedButtonActionLink;
    class function ClassToVar(AClass: TSpeedButtonActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSpeedButtonActionLink_sc;
  end;

  TSpeedButton_sc = class of TSpeedButton;
  TSpeedButton_sw = class(TGraphicControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TSpeedButton): OleVariant;
    class function FromVar(const AValue: OleVariant): TSpeedButton;
    class function ClassToVar(AClass: TSpeedButton_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TSpeedButton_sc;
  end;

  TBitBtnActionLink_sc = class of TBitBtnActionLink;
  TBitBtnActionLink_sw = class(TControlActionLink_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBitBtnActionLink): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitBtnActionLink;
    class function ClassToVar(AClass: TBitBtnActionLink_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBitBtnActionLink_sc;
  end;

  TBitBtnKind_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TBitBtnKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitBtnKind;
  end;

  TBitBtn_sc = class of TBitBtn;
  TBitBtn_sw = class(TButton_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TBitBtn): OleVariant;
    class function FromVar(const AValue: OleVariant): TBitBtn;
    class function ClassToVar(AClass: TBitBtn_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TBitBtn_sc;
  end;


{ Unit wrapper }

type
  Buttons_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Protected property accessors }

type
  TSpeedButton_sacc = class(TSpeedButton);

{ TButtonLayout_sw }

class function TButtonLayout_sw.GetTypeName: WideString;
begin
  Result := 'TButtonLayout';
end;

class function TButtonLayout_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TButtonLayout);
end;

class function TButtonLayout_sw.ToVar(const AValue: TButtonLayout): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TButtonLayout_sw.FromVar(
  const AValue: OleVariant): TButtonLayout;
begin
  Result := TButtonLayout(Integer(AValue));
end;

{ TButtonState_sw }

class function TButtonState_sw.GetTypeName: WideString;
begin
  Result := 'TButtonState';
end;

class function TButtonState_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TButtonState);
end;

class function TButtonState_sw.ToVar(const AValue: TButtonState): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TButtonState_sw.FromVar(const AValue: OleVariant): TButtonState;
begin
  Result := TButtonState(Integer(AValue));
end;

{ TButtonStyle_sw }

class function TButtonStyle_sw.GetTypeName: WideString;
begin
  Result := 'TButtonStyle';
end;

class function TButtonStyle_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TButtonStyle);
end;

class function TButtonStyle_sw.ToVar(const AValue: TButtonStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TButtonStyle_sw.FromVar(const AValue: OleVariant): TButtonStyle;
begin
  Result := TButtonStyle(Integer(AValue));
end;

{ TNumGlyphs_sw }

class function TNumGlyphs_sw.GetTypeName: WideString;
begin
  Result := 'TNumGlyphs';
end;

class function TNumGlyphs_sw.ToVar(const AValue: TNumGlyphs): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNumGlyphs_sw.FromVar(const AValue: OleVariant): TNumGlyphs;
begin
  Result := TNumGlyphs(Integer(AValue));
end;

{ TSpeedButtonActionLink_sw }

class function TSpeedButtonActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TSpeedButtonActionLink';
end;

class function TSpeedButtonActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TSpeedButtonActionLink;
end;

class procedure TSpeedButtonActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TSpeedButtonActionLink_sw.ToVar(
  const AValue: TSpeedButtonActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSpeedButtonActionLink_sw.FromVar(
  const AValue: OleVariant): TSpeedButtonActionLink;
begin
  Result := TSpeedButtonActionLink(ConvFromVar(AValue, TSpeedButtonActionLink));
end;

class function TSpeedButtonActionLink_sw.ClassToVar(
  AClass: TSpeedButtonActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSpeedButtonActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TSpeedButtonActionLink_sc;
begin
  Result := TSpeedButtonActionLink_sc(ConvClsFromVar(AClass, 
    TSpeedButtonActionLink));
end;

{ TSpeedButton_sw }

function TSpeedButton_MouseInControl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // protected property MouseInControl: Boolean read <getter>;

  Result := TSpeedButton_sacc(TSpeedButton(AObj)).MouseInControl;
end;

function TSpeedButton_AllowAllUp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property AllowAllUp: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).AllowAllUp
  else
    TSpeedButton(AObj).AllowAllUp := Boolean(AArgs[0]);
end;

function TSpeedButton_GroupIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property GroupIndex: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).GroupIndex
  else
    TSpeedButton(AObj).GroupIndex := Integer(AArgs[0]);
end;

function TSpeedButton_Down_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Down: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).Down
  else
    TSpeedButton(AObj).Down := Boolean(AArgs[0]);
end;

function TSpeedButton_Flat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Flat: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).Flat
  else
    TSpeedButton(AObj).Flat := Boolean(AArgs[0]);
end;

function TSpeedButton_Glyph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Glyph: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TSpeedButton(AObj).Glyph)
  else
    TSpeedButton(AObj).Glyph := TBitmap_sw.FromVar(AArgs[0]);
end;

function TSpeedButton_Layout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Layout: TButtonLayout read <getter> write <setter>;

  if IsGet then
    Result := TButtonLayout_sw.ToVar(TSpeedButton(AObj).Layout)
  else
    TSpeedButton(AObj).Layout := TButtonLayout_sw.FromVar(AArgs[0]);
end;

function TSpeedButton_Margin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).Margin
  else
    TSpeedButton(AObj).Margin := Integer(AArgs[0]);
end;

function TSpeedButton_NumGlyphs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NumGlyphs: TNumGlyphs read <getter> write <setter>;

  if IsGet then
    Result := TNumGlyphs_sw.ToVar(TSpeedButton(AObj).NumGlyphs)
  else
    TSpeedButton(AObj).NumGlyphs := TNumGlyphs_sw.FromVar(AArgs[0]);
end;

function TSpeedButton_Spacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Spacing: Integer read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).Spacing
  else
    TSpeedButton(AObj).Spacing := Integer(AArgs[0]);
end;

function TSpeedButton_Transparent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Transparent: Boolean read <getter> write <setter>;

  if IsGet then
    Result := TSpeedButton(AObj).Transparent
  else
    TSpeedButton(AObj).Transparent := Boolean(AArgs[0]);
end;

class function TSpeedButton_sw.GetTypeName: WideString;
begin
  Result := 'TSpeedButton';
end;

class function TSpeedButton_sw.GetWrappedClass: TClass;
begin
  Result := TSpeedButton;
end;

class procedure TSpeedButton_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('MouseInControl', TSpeedButton_MouseInControl_si, Boolean_sw, True, False, 0, True);
  AData.AddPropertyRedecl('Action');
  AData.AddPropertyRedecl('Align');
  AData.AddProperty('AllowAllUp', TSpeedButton_AllowAllUp_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Anchors');
  AData.AddPropertyRedecl('BiDiMode');
  AData.AddPropertyRedecl('Constraints');
  AData.AddProperty('GroupIndex', TSpeedButton_GroupIndex_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('Down', TSpeedButton_Down_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Enabled');
  AData.AddProperty('Flat', TSpeedButton_Flat_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Font');
  AData.AddProperty('Glyph', TSpeedButton_Glyph_si, TBitmap_sw, True, True, 0, False);
  AData.AddProperty('Layout', TSpeedButton_Layout_si, TButtonLayout_sw, True, True, 0, False);
  AData.AddProperty('Margin', TSpeedButton_Margin_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('NumGlyphs', TSpeedButton_NumGlyphs_si, TNumGlyphs_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ParentFont');
  AData.AddPropertyRedecl('ParentShowHint');
  AData.AddPropertyRedecl('ParentBiDiMode');
  AData.AddPropertyRedecl('PopupMenu');
  AData.AddPropertyRedecl('ShowHint');
  AData.AddProperty('Spacing', TSpeedButton_Spacing_si, Integer_sw, True, True, 0, False);
  AData.AddProperty('Transparent', TSpeedButton_Transparent_si, Boolean_sw, True, True, 0, False);
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnClick');
  AData.AddPropertyRedecl('OnDblClick');
  AData.AddPropertyRedecl('OnMouseActivate');
  AData.AddPropertyRedecl('OnMouseDown');
  AData.AddPropertyRedecl('OnMouseEnter');
  AData.AddPropertyRedecl('OnMouseLeave');
  AData.AddPropertyRedecl('OnMouseMove');
  AData.AddPropertyRedecl('OnMouseUp');
end;

class function TSpeedButton_sw.ToVar(const AValue: TSpeedButton): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TSpeedButton_sw.FromVar(const AValue: OleVariant): TSpeedButton;
begin
  Result := TSpeedButton(ConvFromVar(AValue, TSpeedButton));
end;

class function TSpeedButton_sw.ClassToVar(AClass: TSpeedButton_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TSpeedButton_sw.ClassFromVar(
  const AClass: OleVariant): TSpeedButton_sc;
begin
  Result := TSpeedButton_sc(ConvClsFromVar(AClass, TSpeedButton));
end;

{ TBitBtnActionLink_sw }

class function TBitBtnActionLink_sw.GetTypeName: WideString;
begin
  Result := 'TBitBtnActionLink';
end;

class function TBitBtnActionLink_sw.GetWrappedClass: TClass;
begin
  Result := TBitBtnActionLink;
end;

class procedure TBitBtnActionLink_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TBitBtnActionLink_sw.ToVar(
  const AValue: TBitBtnActionLink): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBitBtnActionLink_sw.FromVar(
  const AValue: OleVariant): TBitBtnActionLink;
begin
  Result := TBitBtnActionLink(ConvFromVar(AValue, TBitBtnActionLink));
end;

class function TBitBtnActionLink_sw.ClassToVar(
  AClass: TBitBtnActionLink_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBitBtnActionLink_sw.ClassFromVar(
  const AClass: OleVariant): TBitBtnActionLink_sc;
begin
  Result := TBitBtnActionLink_sc(ConvClsFromVar(AClass, TBitBtnActionLink));
end;

{ TBitBtnKind_sw }

class function TBitBtnKind_sw.GetTypeName: WideString;
begin
  Result := 'TBitBtnKind';
end;

class function TBitBtnKind_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TBitBtnKind);
end;

class function TBitBtnKind_sw.ToVar(const AValue: TBitBtnKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBitBtnKind_sw.FromVar(const AValue: OleVariant): TBitBtnKind;
begin
  Result := TBitBtnKind(Integer(AValue));
end;

{ TBitBtn_sw }

function TBitBtn_Glyph_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Glyph: TBitmap read <getter> write <setter>;

  if IsGet then
    Result := TBitmap_sw.ToVar(TBitBtn(AObj).Glyph)
  else
    TBitBtn(AObj).Glyph := TBitmap_sw.FromVar(AArgs[0]);
end;

function TBitBtn_Kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Kind: TBitBtnKind read <getter> write <setter>;

  if IsGet then
    Result := TBitBtnKind_sw.ToVar(TBitBtn(AObj).Kind)
  else
    TBitBtn(AObj).Kind := TBitBtnKind_sw.FromVar(AArgs[0]);
end;

function TBitBtn_Layout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Layout: TButtonLayout read <getter> write <setter>;

  if IsGet then
    Result := TButtonLayout_sw.ToVar(TBitBtn(AObj).Layout)
  else
    TBitBtn(AObj).Layout := TButtonLayout_sw.FromVar(AArgs[0]);
end;

function TBitBtn_Margin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Margin: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBitBtn(AObj).Margin
  else
    TBitBtn(AObj).Margin := Integer(AArgs[0]);
end;

function TBitBtn_NumGlyphs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NumGlyphs: TNumGlyphs read <getter> write <setter>;

  if IsGet then
    Result := TNumGlyphs_sw.ToVar(TBitBtn(AObj).NumGlyphs)
  else
    TBitBtn(AObj).NumGlyphs := TNumGlyphs_sw.FromVar(AArgs[0]);
end;

function TBitBtn_Style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Style: TButtonStyle read <getter> write <setter>;

  if IsGet then
    Result := TButtonStyle_sw.ToVar(TBitBtn(AObj).Style)
  else
    TBitBtn(AObj).Style := TButtonStyle_sw.FromVar(AArgs[0]);
end;

function TBitBtn_Spacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Spacing: Integer read <getter> write <setter>;

  if IsGet then
    Result := TBitBtn(AObj).Spacing
  else
    TBitBtn(AObj).Spacing := Integer(AArgs[0]);
end;

class function TBitBtn_sw.GetTypeName: WideString;
begin
  Result := 'TBitBtn';
end;

class function TBitBtn_sw.GetWrappedClass: TClass;
begin
  Result := TBitBtn;
end;

class procedure TBitBtn_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Action');
  AData.AddPropertyRedecl('Align');
  AData.AddPropertyRedecl('Anchors');
  AData.AddPropertyRedecl('BiDiMode');
  AData.AddPropertyRedecl('Cancel');
  AData.AddPropertyRedecl('Caption');
  AData.AddPropertyRedecl('Constraints');
  AData.AddPropertyRedecl('Default');
  AData.AddPropertyRedecl('Enabled');
  AData.AddProperty('Glyph', TBitBtn_Glyph_si, TBitmap_sw, True, True, 0, False);
  AData.AddProperty('Kind', TBitBtn_Kind_si, TBitBtnKind_sw, True, True, 0, False);
  AData.AddProperty('Layout', TBitBtn_Layout_si, TButtonLayout_sw, True, True, 0, False);
  AData.AddProperty('Margin', TBitBtn_Margin_si, Integer_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ModalResult');
  AData.AddProperty('NumGlyphs', TBitBtn_NumGlyphs_si, TNumGlyphs_sw, True, True, 0, False);
  AData.AddPropertyRedecl('ParentShowHint');
  AData.AddPropertyRedecl('ParentBiDiMode');
  AData.AddPropertyRedecl('ShowHint');
  AData.AddProperty('Style', TBitBtn_Style_si, TButtonStyle_sw, True, True, 0, False);
  AData.AddProperty('Spacing', TBitBtn_Spacing_si, Integer_sw, True, True, 0, False);
  AData.AddPropertyRedecl('TabOrder');
  AData.AddPropertyRedecl('TabStop');
  AData.AddPropertyRedecl('Visible');
  AData.AddPropertyRedecl('OnEnter');
  AData.AddPropertyRedecl('OnExit');
end;

class function TBitBtn_sw.ToVar(const AValue: TBitBtn): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TBitBtn_sw.FromVar(const AValue: OleVariant): TBitBtn;
begin
  Result := TBitBtn(ConvFromVar(AValue, TBitBtn));
end;

class function TBitBtn_sw.ClassToVar(AClass: TBitBtn_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TBitBtn_sw.ClassFromVar(const AClass: OleVariant): TBitBtn_sc;
begin
  Result := TBitBtn_sc(ConvClsFromVar(AClass, TBitBtn));
end;

{ Buttons_sw }

function Buttons_TButtonLayout_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonLayout = (blGlyphRight, blGlyphTop, blGlyphBo...

  Result := TLMDUnitWrapper.TypeToVar(TButtonLayout_sw);
end;

function Buttons_TButtonState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonState = (bsDisabled, bsDown, bsExclusive);

  Result := TLMDUnitWrapper.TypeToVar(TButtonState_sw);
end;

function Buttons_TButtonStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TButtonStyle = (bsWin31, bsNew);

  Result := TLMDUnitWrapper.TypeToVar(TButtonStyle_sw);
end;

function Buttons_TNumGlyphs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNumGlyphs = <min>..<max>;

  Result := TLMDUnitWrapper.TypeToVar(TNumGlyphs_sw);
end;

function Buttons_TSpeedButtonActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSpeedButtonActionLink = class(TControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TSpeedButtonActionLink_sw);
end;

function Buttons_TSpeedButton_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSpeedButton = class(TGraphicControl);

  Result := TLMDUnitWrapper.TypeToVar(TSpeedButton_sw);
end;

function Buttons_TBitBtnActionLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitBtnActionLink = class(TControlActionLink);

  Result := TLMDUnitWrapper.TypeToVar(TBitBtnActionLink_sw);
end;

function Buttons_TBitBtnKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitBtnKind = (bkOK, bkCancel, bkHelp, bkYes, bkNo, ...

  Result := TLMDUnitWrapper.TypeToVar(TBitBtnKind_sw);
end;

function Buttons_TBitBtn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBitBtn = class(TButton);

  Result := TLMDUnitWrapper.TypeToVar(TBitBtn_sw);
end;

class function Buttons_sw.GetUnitName: WideString;
begin
  Result := 'Buttons';
end;

class procedure Buttons_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TButtonLayout_sw, Buttons_TButtonLayout_si);
  AData.AddType(TButtonState_sw, Buttons_TButtonState_si);
  AData.AddType(TButtonStyle_sw, Buttons_TButtonStyle_si);
  AData.AddType(TNumGlyphs_sw, Buttons_TNumGlyphs_si);
  AData.AddType(TSpeedButtonActionLink_sw, Buttons_TSpeedButtonActionLink_si);
  AData.AddType(TSpeedButton_sw, Buttons_TSpeedButton_si);
  AData.AddType(TBitBtnActionLink_sw, Buttons_TBitBtnActionLink_si);
  AData.AddType(TBitBtnKind_sw, Buttons_TBitBtnKind_si);
  AData.AddType(TBitBtn_sw, Buttons_TBitBtn_si);
end;

class function Buttons_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Buttons_sw);
end;

initialization
  RegisterUnitWrapper(Buttons_sw);
  RegisterClassWrapper(TSpeedButtonActionLink_sw);
  RegisterClassWrapper(TSpeedButton_sw);
  RegisterClassWrapper(TBitBtnActionLink_sw);
  RegisterClassWrapper(TBitBtn_sw);

end.
