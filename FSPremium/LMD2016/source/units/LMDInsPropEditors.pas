unit LMDInsPropEditors;
{$I LmdCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDInsPropEditors unit (YB)
---------------------------
Standard property editors unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Controls, Graphics, Forms, Dialogs, TypInfo,
  Menus, Masks, RTLConsts, Variants, Types, LMDTypes, LMDUnicode,
  LMDUnicodeStrings, LMDInsClass, LMDInsCst, LMDInsEditorWnds, LMDInsPropInsp
  {$IFDEF LMDCOMP16},UITypes{$ENDIF};

type
  { Standard property editors }

  { ************************ TLMDOrdinalPropEditor *************************** }

  TLMDOrdinalPropEditor = class(TLMDPropEditor)
  protected
    function AllEqual: Boolean; override;
  end;

  { ************************ TLMDIntegerPropEditor *************************** }

  TLMDIntegerPropEditor = class(TLMDOrdinalPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************** TLMDCharPropEditor **************************** }

  TLMDCharPropEditor = class(TLMDOrdinalPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************** TLMDEnumPropEditor **************************** }

  TLMDEnumPropEditor = class(TLMDOrdinalPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetValues(AValues: TLMDStrings); override;
  end;

  { ************************* TLMDFloatPropEditor **************************** }

  TLMDFloatPropEditor = class(TLMDPropEditor)
  protected
    function  AllEqual: Boolean; override;
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************* TLMDStringPropEditor *************************** }

  TLMDStringPropEditor = class(TLMDPropEditor)
  protected
    function  AllEqual: Boolean; override;
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { *********************** TLMDWideStringPropEditor ************************* }

  TLMDWideStringPropEditor = class(TLMDPropEditor)
  protected
    function  AllEqual: Boolean; override;
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************* TLMDSetElemPropEditor ************************** }

  TLMDSetElemPropEditor = class(TLMDNestedPropEditor)
  private
    FElement: Integer;
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetValues(AValues: TLMDStrings); override;
    function  GetPropName: TLMDString; override;
    function  AllEqual: Boolean; override;
  public
    constructor Create(AParent: TLMDPropEditor; AElement: Integer);
    property    Element: Integer read FElement;
  end;

  { *************************** TLMDSetPropEditor **************************** }

  TLMDSetPropEditor = class(TLMDOrdinalPropEditor)
  protected
    function  GetValue: TLMDString; override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetSubProps(AResult: TList); override;
  end;

  { ************************** TLMDClassPropEditor *************************** }

  TLMDClassPropEditor = class(TLMDPropEditor)
  private
    function  GetObjects(AResult: TList): Boolean;
  protected
    function  GetValue: TLMDString; override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetSubProps(AResult: TList); override;
  end;

  { ************************ TLMDComponentPropEditor ************************* }

  TLMDComponentPropEditor = class(TLMDPropEditor)
  protected
    function  AllEqual: Boolean; override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetSubProps(AResult: TList); override;
    function  GetValue: TLMDString; override;
    procedure GetValues(AValues: TLMDStrings); override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ********************** TLMDVariantTypePropEditor ************************* }

  TLMDVariantTypePropEditor = class(TLMDNestedPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    procedure GetValues(AValues: TLMDStrings); override;
    function  GetPropName: TLMDString; override;
    function  GetAttrs: TLMDPropAttrs; override;
    function  AllEqual: Boolean; override;
  end;

  { ************************ TLMDVariantPropEditor *************************** }

  TLMDVariantPropEditor = class(TLMDPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetSubProps(AResult: TList); override;
  end;

  { ************************* TLMDInt64PropEditor **************************** }

  TLMDInt64PropEditor = class(TLMDPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  AllEqual: Boolean; override;
  end;

  { ********************* TLMDComponentNamePropEditor ************************ }

  TLMDComponentNamePropEditor = class(TLMDStringPropEditor)
  protected
    function GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************** TLMDDatePropEditor **************************** }

  TLMDDatePropEditor = class(TLMDPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************** TLMDTimePropEditor **************************** }

  TLMDTimePropEditor = class(TLMDPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************ TLMDDateTimePropEditor ************************** }

  TLMDDateTimePropEditor = class(TLMDPropEditor)
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************** TLMDEventPropEditor *************************** }

  TLMDEventPropEditor = class(TLMDPropEditor)
  protected
    function  AllEqual: Boolean; override;
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetValues(AValues: TLMDStrings); override;
    procedure Edit; override;
  end;

  { VCL property editors }

  { ************************* TLMDCaptionPropEditor ************************** }

  TLMDCaptionPropEditor = class(TLMDStringPropEditor)
  protected
    function GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************** TLMDColorPropEditor *************************** }

  TLMDColorPropEditor = class(TLMDIntegerPropEditor)
  private
    FValues: TStrings;                    // Vcl GetColorValues expects
    procedure AddValue(const LS: string); // non-Unicode strings.
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    procedure GetValues(AValues: TLMDStrings); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure Edit; override;
    procedure ValuesMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                  var AHeight: Integer); override;
    procedure ValuesMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                 var AWidth: Integer); override;
    procedure ValuesDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                              const ARect: TRect; ASelected: Boolean); override;
  end;

  { ************************** TLMDCursorPropEditor ************************** }

  TLMDCursorPropEditor = class(TLMDIntegerPropEditor)
  private
    FValues: TStrings;                    // Vcl GetCursorValues expects
    procedure AddValue(const LS: string); // non-Unicode strings.
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    procedure GetValues(AValues: TLMDStrings); override;
    function  GetAttrs: TLMDPropAttrs; override;
    procedure ValuesMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                  var AHeight: Integer); override;
    procedure ValuesMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                 var AWidth: Integer); override;
    procedure ValuesDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                              const ARect: TRect; ASelected: Boolean); override;
  end;

  { ************************ TLMDFontCharsetPropEditor *********************** }

  TLMDFontCharsetPropEditor = class(TLMDIntegerPropEditor)
  private
    FValues: TStrings;                    // Vcl GetCharsetValues expects
    procedure AddValue(const LS: string); // non-Unicode strings.
  protected
    function  GetValue: TLMDString; override;
    procedure SetValue(const Value: TLMDString); override;
    procedure GetValues(AValues: TLMDStrings); override;
    function  GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************* TLMDFontNamePropEditor ************************* }

  TLMDFontNamePropEditor = class(TLMDStringPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetValues(AValues: TLMDStrings); override;
  end;

  { ************************* TLMDImeNamePropEditor ************************** }

  TLMDImeNamePropEditor = class(TLMDStringPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure GetValues(AValues: TLMDStrings); override;
  end;

  { *************************** TLMDFontPropEditor *************************** }

  TLMDFontPropEditor = class(TLMDClassPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure Edit; override;
  end;

  { *********************** TLMDModalResultPropEditor ************************ }

  TLMDModalResultPropEditor = class(TLMDIntegerPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    function  GetValue: TLMDString; override;
    procedure GetValues(AValues: TLMDStrings); override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************* TLMDPenStylePropEditor ************************* }

  TLMDPenStylePropEditor = class(TLMDEnumPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure ValuesMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                  var AHeight: Integer); override;
    procedure ValuesMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                 var AWidth: Integer); override;
    procedure ValuesDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                              const ARect: TRect; ASelected: Boolean); override;
  end;

  { ************************ TLMDBrushStylePropEditor ************************ }

  TLMDBrushStylePropEditor = class(TLMDEnumPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure ValuesMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                  var AHeight: Integer); override;
    procedure ValuesMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                 var AWidth: Integer); override;
    procedure ValuesDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                              const ARect: TRect; ASelected: Boolean); override;
  end;

  { ************************* TLMDTabOrderPropEditor ************************* }

  TLMDTabOrderPropEditor = class(TLMDIntegerPropEditor)
  protected
    function GetAttrs: TLMDPropAttrs; override;
  end;

  { ************************* TLMDShortCutPropEditor ************************* }

  TLMDShortCutPropEditor = class(TLMDOrdinalPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    function  GetValue: TLMDString; override;
    procedure GetValues(AValues: TLMDStrings); override;
    procedure SetValue(const Value: TLMDString); override;
  end;

  { ************************** TLMDStringsPropEditor ************************* }

  TLMDStringsPropEditor = class(TLMDClassPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure Edit; override;
  end;

  { ************************ TLMDWideStringsPropEditor *********************** }

  TLMDWideStringsPropEditor = class(TLMDClassPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    procedure Edit; override;
  end;

  { ************************ TLMDCollectionPropEditor ************************ }

  TLMDCollectionPropEditor = class(TLMDPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    function  GetValue: TLMDString; override;
    procedure Edit; override;
  end;

  { ************************* TLMDMenuItemPropEditor ************************* }

  TLMDMenuItemPropEditor = class(TLMDPropEditor)
  protected
    function  GetAttrs: TLMDPropAttrs; override;
    function  GetValue: TLMDString; override;
    procedure Edit; override;
  end;

implementation

uses
  LMDStrings, LMDInsStrsEditor, LMDInsWideStrsEditor, LMDInsCollectionEditor,
  LMDInsMenuEditor;

const
  SNull              = '(Null)';
  SString            = 'String';
  SUnknown           = '(Unknown)';
  SUnknownType       = 'Unknown Type';
  SNone              = '(None)';
  // Delphi / CBuilder 6 or higher
  VarTypeNames: array[varEmpty..varInt64] of string = (
    'Unassigned', // varEmpty
    'Null',       // varNull
    'Smallint',   // varSmallint
    'Integer',    // varInteger
    'Single',     // varSingle
    'Double',     // varDouble
    'Currency',   // varCurrency
    'Date',       // varDate
    'OleStr',     // varOleStr
    '',           // varDispatch
    '',           // varError
    'Boolean',    // varBoolean
    '',           // varVariant
    '',           // varUnknown
    '',           // [varDecimal]
    '',           // [undefined]
    'Shortint',   // varShortInt
    'Byte',       // varByte
    'Word',       // varWord
    'LongWord',   // varLongWord
    'Int64');     // varInt64

  ModalResults: array[mrNone..mrYesToAll] of string = (
    'mrNone',
    'mrOk',
    'mrCancel',
    'mrAbort',
    'mrRetry',
    'mrIgnore',
    'mrYes',
    'mrNo',
    {$IFDEF LMDCOMP16}
    'mrClose',
    'mrHelp',
    'mrTryAgain',
    'mrContinue',
    {$ENDIF}
    'mrAll',
    'mrNoToAll',
    'mrYesToAll');

  ShortCuts: array[0..108] of TShortCut = (
    scNone,
    Byte('A') or scCtrl,
    Byte('B') or scCtrl,
    Byte('C') or scCtrl,
    Byte('D') or scCtrl,
    Byte('E') or scCtrl,
    Byte('F') or scCtrl,
    Byte('G') or scCtrl,
    Byte('H') or scCtrl,
    Byte('I') or scCtrl,
    Byte('J') or scCtrl,
    Byte('K') or scCtrl,
    Byte('L') or scCtrl,
    Byte('M') or scCtrl,
    Byte('N') or scCtrl,
    Byte('O') or scCtrl,
    Byte('P') or scCtrl,
    Byte('Q') or scCtrl,
    Byte('R') or scCtrl,
    Byte('S') or scCtrl,
    Byte('T') or scCtrl,
    Byte('U') or scCtrl,
    Byte('V') or scCtrl,
    Byte('W') or scCtrl,
    Byte('X') or scCtrl,
    Byte('Y') or scCtrl,
    Byte('Z') or scCtrl,
    Byte('A') or scCtrl or scAlt,
    Byte('B') or scCtrl or scAlt,
    Byte('C') or scCtrl or scAlt,
    Byte('D') or scCtrl or scAlt,
    Byte('E') or scCtrl or scAlt,
    Byte('F') or scCtrl or scAlt,
    Byte('G') or scCtrl or scAlt,
    Byte('H') or scCtrl or scAlt,
    Byte('I') or scCtrl or scAlt,
    Byte('J') or scCtrl or scAlt,
    Byte('K') or scCtrl or scAlt,
    Byte('L') or scCtrl or scAlt,
    Byte('M') or scCtrl or scAlt,
    Byte('N') or scCtrl or scAlt,
    Byte('O') or scCtrl or scAlt,
    Byte('P') or scCtrl or scAlt,
    Byte('Q') or scCtrl or scAlt,
    Byte('R') or scCtrl or scAlt,
    Byte('S') or scCtrl or scAlt,
    Byte('T') or scCtrl or scAlt,
    Byte('U') or scCtrl or scAlt,
    Byte('V') or scCtrl or scAlt,
    Byte('W') or scCtrl or scAlt,
    Byte('X') or scCtrl or scAlt,
    Byte('Y') or scCtrl or scAlt,
    Byte('Z') or scCtrl or scAlt,
    VK_F1,
    VK_F2,
    VK_F3,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12,
    VK_F1 or scCtrl,
    VK_F2 or scCtrl,
    VK_F3 or scCtrl,
    VK_F4 or scCtrl,
    VK_F5 or scCtrl,
    VK_F6 or scCtrl,
    VK_F7 or scCtrl,
    VK_F8 or scCtrl,
    VK_F9 or scCtrl,
    VK_F10 or scCtrl,
    VK_F11 or scCtrl,
    VK_F12 or scCtrl,
    VK_F1 or scShift,
    VK_F2 or scShift,
    VK_F3 or scShift,
    VK_F4 or scShift,
    VK_F5 or scShift,
    VK_F6 or scShift,
    VK_F7 or scShift,
    VK_F8 or scShift,
    VK_F9 or scShift,
    VK_F10 or scShift,
    VK_F11 or scShift,
    VK_F12 or scShift,
    VK_F1 or scShift or scCtrl,
    VK_F2 or scShift or scCtrl,
    VK_F3 or scShift or scCtrl,
    VK_F4 or scShift or scCtrl,
    VK_F5 or scShift or scCtrl,
    VK_F6 or scShift or scCtrl,
    VK_F7 or scShift or scCtrl,
    VK_F8 or scShift or scCtrl,
    VK_F9 or scShift or scCtrl,
    VK_F10 or scShift or scCtrl,
    VK_F11 or scShift or scCtrl,
    VK_F12 or scShift or scCtrl,
    VK_INSERT,
    VK_INSERT or scShift,
    VK_INSERT or scCtrl,
    VK_DELETE,
    VK_DELETE or scShift,
    VK_DELETE or scCtrl,
    VK_BACK or scAlt,
    VK_BACK or scShift or scAlt);

{ ********************** class TLMDOrdinalPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDOrdinalPropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV: Longint;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV := GetOrdValue(0);
      for LI := 1 to PropCount - 1 do
        if GetOrdValue(LI) <> LV then
          begin
            Result := False;
            Break;
          end;
    end;
end;

{ ********************** class TLMDIntegerPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDIntegerPropEditor.GetValue: TLMDString;
begin
  if GetTypeData(PropTypeInfo).OrdType = otULong then // Unsigned
    Result := IntToStr(Cardinal(GetOrdValue(0)))
  else
    Result := IntToStr(GetOrdValue(0));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIntegerPropEditor.SetValue(const Value: TLMDString);
var
  LI: Int64;
begin
  LI := StrToInt64(Value);
  with GetTypeData(PropTypeInfo)^ do
  begin
    if OrdType = otULong then 
    begin
      if (LI < Cardinal(MinValue)) or (LI > Cardinal(MaxValue)) then
        raise ELMDPropEditor.CreateFmt(SLMDPropInspOutOfRange,
                                       [Int64(Cardinal(MinValue)),
                                        Int64(Cardinal(MaxValue))]);
    end
    else if (LI < MinValue) or (LI > MaxValue) then
      raise ELMDPropEditor.CreateFmt(SLMDPropInspOutOfRange, [MinValue, MaxValue]);
  end;
  SetOrdValue(LI);
end;

{ ************************ class TLMDCharPropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDCharPropEditor.GetValue: TLMDString;
var
  LCh: Char;
begin
  LCh := Chr(GetOrdValue(0));
  if Ord(LCh) in [33..127] then
    Result := LCh
  else
    Result := Format('#%d', [Ord(LCh)]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCharPropEditor.SetValue(const Value: TLMDString);
var
  LI: Longint;
begin
  if Length(Value) = 0 then
    LI := 0
  else if Length(Value) = 1 then
    LI := Ord(Value[1])
  else if Value[1] = '#' then
    LI := StrToInt(Copy(Value, 2, Maxint))
  else
    raise ELMDPropEditor.Create(SLMDPropInspInvPropValue);
    with GetTypeData(PropTypeInfo)^ do
  begin
    if (LI < MinValue) or (LI > MaxValue) then
      raise ELMDPropEditor.CreateFmt(SLMDPropInspOutOfRange,
                                     [MinValue, MaxValue]);
  end;
  SetOrdValue(LI);
end;

{ ************************ class TLMDEnumPropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDEnumPropEditor.GetValue: TLMDString;
var
  LI: Longint;
begin
  LI := GetOrdValue(0);

  with GetTypeData(PropTypeInfo)^ do
    if (LI < MinValue) or (LI > MaxValue) then LI := MaxValue;

  Result := GetEnumName(PropTypeInfo, LI);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEnumPropEditor.SetValue(const Value: TLMDString);
var
  LI: Integer;
begin
  LI := GetEnumValue(PropTypeInfo, Value);

  with GetTypeData(PropTypeInfo)^ do
    if (LI < MinValue) or (LI > MaxValue) then
      raise ELMDPropEditor.Create(SLMDPropInspInvPropValue);

  SetOrdValue(LI);
end;

{ ---------------------------------------------------------------------------- }
function TLMDEnumPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList, praSortList];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEnumPropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
  LEnumType: TLMDTypeInfo;
begin
  LEnumType := PropTypeInfo;
  with GetTypeData(LEnumType)^ do
  begin
    if MinValue < 0 then  // Longbool/Wordbool/Bytebool
      begin
        AValues.Add(GetEnumName(LEnumType, 0));
        AValues.Add(GetEnumName(LEnumType, 1));
      end
    else
      for LI := MinValue to MaxValue do AValues.Add(GetEnumName(LEnumType, LI));
  end;
end;

{ *********************** class TLMDFloatPropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDFloatPropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV: Extended;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV := GetFloatValue(0);
      for LI := 1 to PropCount - 1 do
        if GetFloatValue(LI) <> LV then
          begin
            Result := False;
            Break;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFloatPropEditor.GetValue: TLMDString;
const
  LPrecisions: array[TFloatType] of Integer = (7, 15, 18, 18, 18);
begin
  Result := FloatToStrF(GetFloatValue(0), ffGeneral,
    LPrecisions[GetTypeData(PropTypeInfo).FloatType], 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFloatPropEditor.SetValue(const Value: TLMDString);
begin
  SetFloatValue(StrToFloat(Value));
end;

{ *********************** class TLMDStringPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDStringPropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV: string;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV := GetStrValue(0);
      for LI := 1 to PropCount - 1 do
        if GetStrValue(LI) <> LV then
          begin
            Result := False;
            Break;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDStringPropEditor.GetValue: TLMDString;
begin
  Result := GetStrValue(0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStringPropEditor.SetValue(const Value: TLMDString);
begin
  SetStrValue(Value);
end;

{ ********************* class TLMDWideStringPropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDWideStringPropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV: WideString;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV := GetWideStrValue(0);
      for LI := 1 to PropCount - 1 do
        if GetWideStrValue(LI) <> LV then
          begin
            Result := False;
            Break;
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDWideStringPropEditor.GetValue: TLMDString;
begin
  Result := GetWideStrValue(0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWideStringPropEditor.SetValue(const Value: TLMDString);
begin
  SetWideStrValue(Value);
end;

{ *********************** class TLMDSetElemPropEditor ************************ }
{ ------------------------------ protected ----------------------------------- }
function TLMDSetElemPropEditor.GetValue: TLMDString;
var
  LS: TIntegerSet;
begin
  Integer(LS) := GetOrdValue(0);
  Result      := BooleanIdents[FElement in LS];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSetElemPropEditor.SetValue(const Value: TLMDString);
var
  LS: TIntegerSet;
begin
  Integer(LS) := GetOrdValue(0);
  if CompareText(Value, BooleanIdents[True]) = 0 then
    Include(LS, FElement)
  else
    Exclude(LS, FElement);

  SetOrdValue(Integer(LS));
end;

{ ---------------------------------------------------------------------------- }
function TLMDSetElemPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList, praSortList];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSetElemPropEditor.GetValues(AValues: TLMDStrings);
begin
  AValues.Add(BooleanIdents[False]);
  AValues.Add(BooleanIdents[True]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSetElemPropEditor.GetPropName: TLMDString;
begin
  Result := GetEnumName(GetTypeData(PropTypeInfo).CompType^, FElement);
end;

{ ---------------------------------------------------------------------------- }
function TLMDSetElemPropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LS: TIntegerSet;
  LV: Boolean;
begin
  Result := True;
  if PropCount > 1 then
    begin
      Integer(LS) := GetOrdValue(0);
      LV := FElement in LS;
      for LI := 1 to PropCount - 1 do
        begin
          Integer(LS) := GetOrdValue(LI);
          if (FElement in LS) <> LV then
          begin
            Result := False;
            Break;
          end;
        end;
    end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDSetElemPropEditor.Create(AParent: TLMDPropEditor;
  AElement: Integer);
begin
  inherited Create(AParent);
  FElement := AElement;
end;

{ ************************* class TLMDSetPropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDSetPropEditor.GetValue: TLMDString;
var
  LS: TIntegerSet;
  LTypeInfo: TLMDTypeInfo;
  LI: Integer;
begin
  Integer(LS) := GetOrdValue(0);
  LTypeInfo := GetTypeData(PropTypeInfo).CompType^;
  Result := '[';
  for LI := 0 to SizeOf(Integer) * 8 - 1 do
    if LI in LS then
    begin
      if Length(Result) <> 1 then Result := Result + ',';
      Result := Result + GetEnumName(LTypeInfo, LI);
    end;
  Result := Result + ']';
end;

{ ---------------------------------------------------------------------------- }
function TLMDSetPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praSubProperties, praReadOnly];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSetPropEditor.GetSubProps(AResult: TList);
var
  LI: Integer;
begin
  with GetTypeData(GetTypeData(PropTypeInfo).CompType^)^ do
    for LI := MinValue to MaxValue do
      AResult.Add(TLMDSetElemPropEditor.Create(Self, LI));
end;

{ ************************ class TLMDClassPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDClassPropEditor.GetObjects(AResult: TList): Boolean;
var
  LI: Integer;
  LJ: TObject;
begin
  Result := False;

  for LI := 0 to PropCount - 1 do
  begin
    LJ := GetObjectValue(LI);
    if (LJ <> nil) and (LJ.ClassInfo <> nil) then
    begin
      Result := True;
      if AResult <> nil then
        AResult.Add(LJ);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDClassPropEditor.GetValue: TLMDString;
begin
  Result := Format('(%s)', [PropTypeInfo^.Name]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDClassPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praReadOnly];
  if GetObjects(nil) then
    Include(Result, praSubProperties);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDClassPropEditor.GetSubProps(AResult: TList);
var
  LObjects: TList;
begin
  LObjects := TList.Create;
  try
    if GetObjects(LObjects) then
      GetPropEditors(Self, LObjects, False, True, AResult);
  finally
    LObjects.Free;
  end;
end;

{ ********************** class TLMDComponentPropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDComponentPropEditor.AllEqual: Boolean;
var
  LI:         Integer;
  LBaseVal:   TComponent;
begin
  Result    := True;
  LBaseVal  := TComponent(GetObjectValue(0));

  if PropCount > 1 then
  begin
    for LI := 1 to PropCount - 1 do
      if TComponent(GetObjectValue(LI)) <> LBaseVal then
      begin
        Result := False;
        Break;
      end;
  end;

  if Result and (LBaseVal <> nil) then
    GetCompRefName(LBaseVal);
end;

{ ---------------------------------------------------------------------------- }
function TLMDComponentPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praComponentRef];

  if GetPropInfo(0).IsWritable then
    Result := Result + [praValueList, praSortList]
  else
    Result := Result + [praReadOnly];

  if (TComponent(GetObjectValue(0)) <> nil) and AllEqual then
    Result := Result + [praSubProperties, praVolatileSubProperties];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComponentPropEditor.GetSubProps(AResult: TList);
var
  LI:       Integer;
  LJ:       TObject;
  LObjects: TList;
begin
  LObjects := TList.Create;
  try
    for LI := 0 to PropCount - 1 do
    begin
      LJ := GetObjectValue(LI);
      if (LJ <> nil) and (LJ.ClassInfo <> nil) then
        LObjects.Add(LJ);
    end;
    if LObjects.Count > 0 then
      GetPropEditors(nil, LObjects, True, True, AResult); // The referenced
                                                          // components are
                                                          // not part of the
                                                          // parent objects,
                                                          // so we use nil
                                                          // as parent editor.
  finally
    LObjects.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDComponentPropEditor.GetValue: TLMDString;
var
  LVal: TComponent;
begin
  Result := '';
  LVal   := TComponent(GetObjectValue(0));

  if LVal <> nil then
    Result := GetCompRefName(LVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComponentPropEditor.GetValues(AValues: TLMDStrings);
var
  LI:         Integer;
  LCompClass: TComponentClass;
  LList:      TList;
  LS:         TLMDString;
begin
  LCompClass := TComponentClass(GetTypeData(PropTypeInfo).ClassType);
  LList  := TList.Create;
  try
    GetCompRefList(LCompClass, LList);

    for LI := 0 to LList.Count - 1 do
    begin
      LS := GetCompRefName(TComponent(LList[LI]));
      if LS <> '' then
        AValues.Add(LS);
    end;
  finally
    LList.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComponentPropEditor.SetValue(const Value: TLMDString);
var
  LComp: TComponent;
begin
  LComp := nil;
  if Value <> '' then
    LComp := GetCompRef(Value);

  SetObjectValue(LComp);
end;

{ ********************* class TLMDVariantTypePropEditor ********************** }
{ ------------------------------- protected ---------------------------------- }
function TLMDVariantTypePropEditor.GetValue: TLMDString;
begin
  case VarType(GetVarValue(0)) and varTypeMask of
    Low(VarTypeNames)..High(VarTypeNames):
      Result := VarTypeNames[VarType(GetVarValue(0))];
    varString:
      Result := SString;
  else
    Result := SUnknown;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVariantTypePropEditor.SetValue(const Value: TLMDString);

  function _GetSelectedType: Integer;
  var
    LI: Integer;
  begin
    Result := -1;
    for LI := 0 to High(VarTypeNames) do
      if VarTypeNames[LI] = Value then
        begin
          Result := LI;
          Break;
        end;
    if (Result = -1) and (Value = SString) then
      Result := varString;
  end;

var
  LNewType: Integer;
  LV: Variant;

begin
  LV := GetVarValue(0);
  LNewType := _GetSelectedType;
  case LNewType of
    varEmpty: VarClear(LV);
    varNull: LV := NULL;
    -1: raise Exception.Create(SUnknownType);
  else
    try
      VarCast(LV, LV, LNewType);
    except
      { If it cannot cast, clear it and then cast again. }
      VarClear(LV);
      VarCast(LV, LV, LNewType);
    end;
  end;
  SetVarValue(LV);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVariantTypePropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
begin
  for LI := 0 to High(VarTypeNames) do
    if VarTypeNames[LI] <> '' then
      AValues.Add(VarTypeNames[LI]);
  AValues.Add(SString);
end;

{ ---------------------------------------------------------------------------- }
function TLMDVariantTypePropEditor.GetPropName: TLMDString;
begin
  Result := 'Type';
end;

{ ---------------------------------------------------------------------------- }
function TLMDVariantTypePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList, praSortList];
end;

{ ---------------------------------------------------------------------------- }
function TLMDVariantTypePropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV1, LV2: Variant;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV1 := GetVarValue(0);
      for LI := 1 to PropCount - 1 do
        begin
          LV2 := GetVarValue(LI);
          if VarType(LV1) <> VarType(LV2) then
            begin
              Result := False;
              Break;
            end;
        end;
    end;
end;

{ ********************** class TLMDVariantPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDVariantPropEditor.GetValue: TLMDString;

  function _GetVariantStr(const AValue: Variant): string;
  begin
    case VarType(AValue) of
      varBoolean:
        Result := BooleanIdents[AValue = True];
      varCurrency:
        Result := CurrToStr(AValue);
    else
      if VarType(AValue) <> varNull then
        Result := AValue
      else
        Result := '(Null)';
    end;
  end;

var
  LValue: Variant;

begin
  LValue := GetVarValue(0);
  if VarType(LValue) <> varDispatch then
    Result := _GetVariantStr(LValue)
  else
    Result := 'Error';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVariantPropEditor.SetValue(const Value: TLMDString);

  function _Cast(var AValue: Variant; ANewType: Integer): Boolean;
  var
    LV2: Variant;
  begin
    Result := True;
    if ANewType = varCurrency then
      Result := Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}CurrencyString, AValue) > 0;
    if Result then
    try
      VarCast(LV2, AValue, ANewType);
      Result := (ANewType = varDate) or (VarToStr(LV2) = VarToStr(AValue));
      if Result then AValue := LV2;
    except
      Result := False;
    end;
  end;

var
  LV: Variant;
  LOldType: Integer;

begin
  LOldType := VarType(GetVarValue(0));
  LV := Value;
  if Value = '' then
    VarClear(LV) else
  if (CompareText(Value, SNull) = 0) then
    LV := NULL else
  if not _Cast(LV, LOldType) then
    LV := Value;
  SetVarValue(LV);
end;

{ ---------------------------------------------------------------------------- }
function TLMDVariantPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praSubProperties];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDVariantPropEditor.GetSubProps(AResult: TList);
begin
  AResult.Add(TLMDVariantTypePropEditor.Create(Self));
end;

{ *********************** class TLMDInt64PropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDInt64PropEditor.GetValue: TLMDString;
begin
  Result := IntToStr(GetInt64Value(0));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDInt64PropEditor.SetValue(const Value: TLMDString);
begin
  SetInt64Value(StrToInt64(Value));
end;

{ ---------------------------------------------------------------------------- }
function TLMDInt64PropEditor.AllEqual: Boolean;
var
  LI: Integer;
  LV: Int64;
begin
  Result := True;
  if PropCount > 1 then
    begin
      LV := GetInt64Value(0);
      for LI := 1 to PropCount - 1 do
        if GetInt64Value(LI) <> LV then
          begin
            Result := False;
            Break;
          end;
    end;
end;

{ ******************* class TLMDComponentNamePropEditor ********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDComponentNamePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praNotNestable];
end;

{ ************************ class TLMDDatePropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDDatePropEditor.GetValue: TLMDString;
var
  LDT: TDateTime;
begin
  LDT := GetFloatValue(0);
  if LDT = 0.0 then Result := '' else
  Result := DateToStr(LDT);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDatePropEditor.SetValue(const Value: TLMDString);
var
  LDT: TDateTime;
begin
  if Value = '' then LDT := 0.0
  else LDT := StrToDate(Value);
  SetFloatValue(LDT);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDatePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect];
end;

{ ************************ class TLMDTimePropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDTimePropEditor.GetValue: TLMDString;
var
  LDT: TDateTime;
begin
  LDT := GetFloatValue(0);
  if LDT = 0.0 then Result := '' else
  Result := TimeToStr(LDT);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTimePropEditor.SetValue(const Value: TLMDString);
var
  LDT: TDateTime;
begin
  if Value = '' then LDT := 0.0
  else LDT := StrToTime(Value);
  SetFloatValue(LDT);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTimePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect];
end;

{ ********************** class TLMDDateTimePropEditor ************************ }
{ ------------------------------ protected ----------------------------------- }
function TLMDDateTimePropEditor.GetValue: TLMDString;
var
  LDT: TDateTime;
begin
  LDT := GetFloatValue(0);
  if LDT = 0.0 then Result := '' else
  Result := DateTimeToStr(LDT);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDateTimePropEditor.SetValue(const Value: TLMDString);
var
  LDT: TDateTime;
begin
  if Value = '' then LDT := 0.0
  else LDT := StrToDateTime(Value);
  SetFloatValue(LDT);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDateTimePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect];
end;

{ ************************ class TLMDEventPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDEventPropEditor.AllEqual: Boolean;
var
  LI:   Integer;
  LVal: string;
begin
  Result := True;
  LVal   := GetEventValue(0);
  if PropCount > 1 then
  begin
    for LI := 1 to PropCount - 1 do
      if GetEventValue(LI) <> LVal then
      begin
        Result := False;
        Break;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDEventPropEditor.GetValue: TLMDString;
begin
  Result := GetEventValue(0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEventPropEditor.SetValue(const Value: TLMDString);
begin
  SetEventValue(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDEventPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praDialog, praValueList, praSortList];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEventPropEditor.GetValues(AValues: TLMDStrings);
begin
  GetExistingEventHandlers(AValues);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDEventPropEditor.Edit;
var
  LCurName: string;
begin
  LCurName := GetValue;
  if LCurName <> '' then
    ShowEventHandler(LCurName)
  else
    SetValue(GetDefaultEventHandlerName(0));
end;

{ *********************** class TLMDCaptionPropEditor ************************ }
{ ------------------------------ protected ----------------------------------- }
function TLMDCaptionPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praAutoUpdate];
end;

{ ************************ class TLMDColorPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
procedure TLMDColorPropEditor.AddValue(const LS: string);
begin
  FValues.Add(LS);
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorPropEditor.GetValue: TLMDString;
begin
  Result := ColorToString(TColor(GetOrdValue(0)));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.SetValue(const Value: TLMDString);
var
  LNewValue: Longint;
begin
  if IdentToColor(Value, LNewValue) then
    SetOrdValue(LNewValue)
  else
    inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.GetValues(AValues: TLMDStrings);
begin
  FValues := TLMDStringsProxy.Create(AValues);
  try
    GetColorValues(AddValue);
  finally
    FValues.Free;
    FValues := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praDialog, praValueList, praOwnerDrawValues];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.Edit;
var
  LColorDialog: TColorDialog;
begin
  LColorDialog := TColorDialog.Create(Application);
  try
    LColorDialog.Color := GetOrdValue(0);
    LColorDialog.Options := [];
    if LColorDialog.Execute then SetOrdValue(LColorDialog.Color);
  finally
    LColorDialog.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.ValuesMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := ACanvas.TextHeight('Wg') + 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.ValuesMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + ACanvas.TextHeight('Wg');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorPropEditor.ValuesDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);

  function _ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red,
      Green,
      Blue,
      Alpha: Byte;
    end;
  begin
    if (TColorQuad(AColor).Red > 192) or
       (TColorQuad(AColor).Green > 192) or
       (TColorQuad(AColor).Blue > 192) then
      Result := clBlack
    else if ASelected then
      Result := clWhite
    else
      Result := AColor;
  end;

var
  LRight: Integer;
  LOldPenColor, LOldBrushColor: TColor;

begin
  LRight := (ARect.Bottom - ARect.Top) + ARect.Left;
  with ACanvas do
    begin
      LOldPenColor := Pen.Color;
      LOldBrushColor := Brush.Color;
      Pen.Color := Brush.Color;
      Rectangle(ARect.Left, ARect.Top, LRight, ARect.Bottom);
      Brush.Color := StringToColor(AValue);
      Pen.Color := _ColorToBorderColor(ColorToRGB(Brush.Color));
      Rectangle(ARect.Left + 1, ARect.Top + 1, LRight - 1, ARect.Bottom - 1);
      Brush.Color := LOldBrushColor;
      Pen.Color := LOldPenColor;
      ACanvas.TextRect(
        Rect(LRight, ARect.Top, ARect.Right, ARect.Bottom),
        LRight + 1,
        ARect.Top + 1,
        AValue
      );
    end;
end;

{ ************************ class TLMDCursorPropEditor ************************ }
{ ------------------------------ private ------------------------------------- }
procedure TLMDCursorPropEditor.AddValue(const LS: string);
begin
  FValues.Add(LS);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCursorPropEditor.GetValue: TLMDString;
begin
  Result := CursorToString(TCursor(GetOrdValue(0)));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCursorPropEditor.SetValue(const Value: TLMDString);
var
  LNewValue: Longint;
begin
  if IdentToCursor(Value, LNewValue) then
    SetOrdValue(LNewValue)
  else
    inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCursorPropEditor.GetValues(AValues: TLMDStrings);
begin
  FValues := TLMDStringsProxy.Create(AValues);
  try
    GetCursorValues(AddValue);
  finally
    FValues.Free;
    FValues := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCursorPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList, praSortList, praOwnerDrawValues];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCursorPropEditor.ValuesMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
var
  LTextHeight, LCursorHeight: Integer;
begin
  LTextHeight := ACanvas.TextHeight('Wg');
  LCursorHeight := GetSystemMetrics(SM_CYCURSOR) + 4;
  if LTextHeight >= LCursorHeight then
    AHeight := LTextHeight
  else
    AHeight := LCursorHeight;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCursorPropEditor.ValuesMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + GetSystemMetrics(SM_CXCURSOR) + 4;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCursorPropEditor.ValuesDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  LRight: Integer;
  LCursorIndex: Integer;
  LCursorHandle: THandle;
begin
  LRight := ARect.Left + GetSystemMetrics(SM_CXCURSOR) + 4;
  with ACanvas do
    begin
      if not IdentToCursor(AValue, LCursorIndex) then
        LCursorIndex := StrToInt(AValue);
      ACanvas.FillRect(ARect);
      LCursorHandle := Screen.Cursors[LCursorIndex];
      if LCursorHandle <> 0 then
        DrawIconEx(ACanvas.Handle, ARect.Left + 2, ARect.Top + 2, LCursorHandle,
          0, 0, 0, 0, DI_NORMAL or DI_DEFAULTSIZE);
      ACanvas.TextRect(
        Rect(LRight, ARect.Top, ARect.Right, ARect.Bottom),
        LRight + 1,
        ARect.Top + 1,
        AValue
      );
    end;
end;

{ ********************** class TLMDFontCharsetPropEditor ********************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFontCharsetPropEditor.AddValue(const LS: string);
begin
  FValues.Add(LS);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDFontCharsetPropEditor.GetValue: TLMDString;
var
  ident: string;
begin
  if not CharsetToIdent(TFontCharset(GetOrdValue(0)), ident) then
    Result := Format('%d', [GetOrdValue(0)])
  else
    Result := ident;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontCharsetPropEditor.SetValue(const Value: TLMDString);
var
  LNewValue: Longint;
begin
  if IdentToCharset(Value, LNewValue) then
    SetOrdValue(LNewValue)
  else
    inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontCharsetPropEditor.GetValues(AValues: TLMDStrings);
begin
  FValues := TLMDStringsProxy.Create(AValues);
  try
    GetCharsetValues(AddValue);
  finally
    FValues.Free;
    FValues := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontCharsetPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praSortList, praValueList];
end;

{ *********************** class TLMDFontNamePropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDFontNamePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList, praSortList];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontNamePropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
begin
  for LI := 0 to Screen.Fonts.Count - 1 do
    AValues.Add(Screen.Fonts[LI]);
end;

{ *********************** class TLMDImeNamePropEditor ************************ }
{ ------------------------------ protected ----------------------------------- }
function TLMDImeNamePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praValueList, praSortList, praMultiSelect];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDImeNamePropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
begin
  for LI := 0 to Screen.Imes.Count - 1 do
    AValues.Add(Screen.Imes[LI]);
end;

{ ************************* class TLMDFontPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDFontPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praSubProperties, praDialog, praReadOnly];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontPropEditor.Edit;
var
  LFontDialog: TFontDialog;
begin
  LFontDialog := TFontDialog.Create(Application);
  try
    LFontDialog.Font := TFont(GetObjectValue(0));
    LFontDialog.Options := LFontDialog.Options + [fdForceFontExist];
    if LFontDialog.Execute then
      SetObjectValue(LFontDialog.Font);
  finally
    LFontDialog.Free;
  end;
end;

{ ********************* class TLMDModalResultPropEditor ********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDModalResultPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList];
end;

{ ---------------------------------------------------------------------------- }
function TLMDModalResultPropEditor.GetValue: TLMDString;
var
  LCurValue: Longint;
begin
  LCurValue := GetOrdValue(0);
  case LCurValue of
    Low(ModalResults)..High(ModalResults):
      Result := ModalResults[LCurValue];
  else
    Result := IntToStr(LCurValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDModalResultPropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
begin
  for LI := Low(ModalResults) to High(ModalResults) do
    AValues.Add(ModalResults[LI]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDModalResultPropEditor.SetValue(const Value: TLMDString);
var
  LI: Integer;
begin
  if Value = '' then
    begin
      SetOrdValue(0);
      Exit;
    end;
  for LI := Low(ModalResults) to High(ModalResults) do
    if CompareText(ModalResults[LI], Value) = 0 then
      begin
        SetOrdValue(LI);
        Exit;
      end;
  inherited SetValue(Value);
end;

{ *********************** class TLMDPenStylePropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDPenStylePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := inherited GetAttrs + [praOwnerDrawValues];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPenStylePropEditor.ValuesMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := ACanvas.TextHeight('Wg') + 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPenStylePropEditor.ValuesMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + ACanvas.TextHeight('Wg') * 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPenStylePropEditor.ValuesDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  LRight, LTop: Integer;
  LOldPenColor, LOldBrushColor: TColor;
  LOldPenStyle: TPenStyle;
begin
  LRight := (ARect.Bottom - ARect.Top) * 2 + ARect.Left;
  LTop := (ARect.Bottom - ARect.Top) div 2 + ARect.Top;
  with ACanvas do
    begin
      LOldPenColor := Pen.Color;
      LOldBrushColor := Brush.Color;
      LOldPenStyle := Pen.Style;
      Pen.Color := Brush.Color;
      Rectangle(ARect.Left, ARect.Top, LRight, ARect.Bottom);
      Pen.Color := clWindowText;
      Brush.Color := clWindow;
      Rectangle(ARect.Left + 1, ARect.Top + 1, LRight - 1, ARect.Bottom - 1);
      Pen.Color := clWindowText;
      Pen.Style := TPenStyle(GetEnumValue(PropTypeInfo, AValue));
      MoveTo(ARect.Left + 1, LTop);
      LineTo(LRight - 1, LTop);
      MoveTo(ARect.Left + 1, LTop + 1);
      LineTo(LRight - 1, LTop + 1);
      Brush.Color := LOldBrushColor;
      Pen.Style := LOldPenStyle;
      Pen.Color := LOldPenColor;
      ACanvas.TextRect(
        Rect(LRight, ARect.Top, ARect.Right, ARect.Bottom),
        LRight + 1,
        ARect.Top + 1,
        AValue
      );
    end;
end;

{ ********************** class TLMDBrushStylePropEditor ********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDBrushStylePropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := inherited GetAttrs + [praOwnerDrawValues];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrushStylePropEditor.ValuesMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  AHeight := ACanvas.TextHeight('Wg') + 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrushStylePropEditor.ValuesMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  AWidth := AWidth + ACanvas.TextHeight('Wg') * 2;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrushStylePropEditor.ValuesDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  LRight: Integer;
  LOldPenColor, LOldBrushColor: TColor;
  LOldBrushStyle: TBrushStyle;
begin
  LRight := (ARect.Bottom - ARect.Top) + ARect.Left;
  with ACanvas do
    begin
      LOldPenColor := Pen.Color;
      LOldBrushColor := Brush.Color;
      LOldBrushStyle := Brush.Style;
      Pen.Color := Brush.Color;
      Brush.Color := clWindow;
      Rectangle(ARect.Left, ARect.Top, LRight, ARect.Bottom);
      Pen.Color := clWindowText;
      Brush.Style := TBrushStyle(GetEnumValue(PropTypeInfo, AValue));
      if Brush.Style = bsClear then
        begin
          Brush.Color := clWindow;
          Brush.Style := bsSolid;
        end
      else
        Brush.Color := clWindowText;
      Rectangle(ARect.Left + 1, ARect.Top + 1, LRight - 1, ARect.Bottom - 1);
      Brush.Color := LOldBrushColor;
      Brush.Style := LOldBrushStyle;
      Pen.Color := LOldPenColor;
      ACanvas.TextRect(
        Rect(LRight, ARect.Top, ARect.Right, ARect.Bottom),
        LRight + 1,
        ARect.Top + 1,
        AValue
      );
    end;
end;

{ *********************** class TLMDTabOrderPropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDTabOrderPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [];
end;

{ *********************** class TLMDShortCutPropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDShortCutPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praValueList];
end;

{ ---------------------------------------------------------------------------- }
function TLMDShortCutPropEditor.GetValue: TLMDString;
var
  LCurValue: TShortCut;
begin
  LCurValue := GetOrdValue(0);
  if LCurValue = scNone then
    Result := SNone else
    Result := ShortCutToText(LCurValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShortCutPropEditor.GetValues(AValues: TLMDStrings);
var
  LI: Integer;
begin
  AValues.Add(SNone);
  for LI := 1 to High(ShortCuts) do
    AValues.Add(ShortCutToText(ShortCuts[LI]));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShortCutPropEditor.SetValue(const Value: TLMDString);
var
  LNewValue: TShortCut;
begin
  LNewValue := 0;
  if (Value <> '') and (CompareText(Value, SNone) <> 0) then
    begin
      LNewValue := TextToShortCut(Value);
      if LNewValue = 0 then
        raise ELMDPropEditor.Create(SLMDPropInspInvPropValue);
    end;
  SetOrdValue(LNewValue);
end;

{ ************************ class TLMDStringsPropEditor *********************** }
{ ------------------------------ protected ----------------------------------- }
function TLMDStringsPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praDialog, praReadOnly];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStringsPropEditor.Edit;
var
  LDlg: TLMDStringsEditorDialog;
begin
  LDlg := TLMDStringsEditorDialog.Create(Application);
  try
    LDlg.Lines := TStrings(GetObjectValue(0));
    if LDlg.Execute then
      SetObjectValue(LDlg.Lines);
  finally
    LDlg.Free;
  end;
end;

{ ********************** class TLMDWideStringsPropEditor ********************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDWideStringsPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect, praDialog, praReadOnly];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWideStringsPropEditor.Edit;
var
  LDlg: TLMDWideStringsEditorDialog;
begin
  LDlg := TLMDWideStringsEditorDialog.Create(Application);
  try
    LDlg.Lines := TLMDWideStrings(GetObjectValue(0));
    if LDlg.Execute then
      SetObjectValue(LDlg.Lines);
  finally
    LDlg.Free;
  end;
end;

{ ************************* TLMDCollectionPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDCollectionPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praReadOnly, praDialog];
end;

{ ---------------------------------------------------------------------------- }
function TLMDCollectionPropEditor.GetValue: TLMDString;
begin
  Result := Format('(%s)', [PropTypeInfo.Name]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCollectionPropEditor.Edit;
var
  coll: TCollection;
  cbs:  TLMDEditorWindowCallbacks;
begin
  coll := GetObjectValue(0) as TCollection;
  if CreateEditorWndCbs(coll, cbs) then
    TLMDCollectionEditorDialog.OpenEditor(cbs, coll);
end;

{ ************************** TLMDMenuItemPropEditor ************************** }
{ ------------------------------ protected ----------------------------------- }

procedure TLMDMenuItemPropEditor.Edit;
var
  item: TMenuItem;
  cbs:  TLMDEditorWindowCallbacks;
begin
  item := GetObjectValue(0) as TMenuItem;
  if CreateEditorWndCbs(item, cbs) then
    TLMDMenuEditorDialog.OpenEditor(cbs, item);
end;

{ ---------------------------------------------------------------------------- }

function TLMDMenuItemPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praReadOnly, praDialog];
end;

{ ---------------------------------------------------------------------------- }

function TLMDMenuItemPropEditor.GetValue: TLMDString;
begin
  Result := Format('(%s)', [PropTypeInfo.Name]);
end;

{ ---------------------------------------------------------------------------- }

end.
