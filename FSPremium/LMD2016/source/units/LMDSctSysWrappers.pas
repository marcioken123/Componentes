unit LMDSctSysWrappers;
{$I lmdcmps.inc}

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

LMDSctSysWrappers unit (YB)
---------------------------
LMD Script Pack manually created wrappers for implicitly defined Object Pascal
types, such as 'Integer' and for types and routines contained in Delphi 'System'
unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Variants, Classes, LMDSctClass, LMDSctWrappers, LMDSctScripter;

type
  {***************************** class Boolean_sw *****************************}

  Boolean_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Boolean): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Boolean;
  end;

  {**************************** class ByteBool_sw *****************************}

  ByteBool_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Boolean): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Boolean;
  end;

  {***************************** class WordBool_sw ****************************}

  WordBool_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: WordBool): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): WordBool;
  end;

  {***************************** class LongBool_sw ****************************}

  LongBool_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: LongBool): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): LongBool;
  end;

  {***************************** class Integer_sw *****************************}

  Integer_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Integer): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Integer;
  end;

  {***************************** class Cardinal_sw ****************************}

  Cardinal_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Cardinal): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Cardinal;
  end;

  {****************************** class Int64_sw ******************************}

  Int64_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Int64): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Int64;
  end;

  {***************************** class UInt64_sw ******************************}

  {$IFDEF LMDCOMP12}
  UInt64_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: UInt64): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): UInt64;
  end;
  {$ENDIF}

  {*************************** class NativeInt_sw *****************************}

  {$IFDEF LMDCOMP16}
  NativeInt_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: NativeInt): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): NativeInt;
  end;
  {$ENDIF}

  {************************** class NativeUInt_sw *****************************}

  {$IFDEF LMDCOMP16}
  NativeUInt_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: NativeUInt): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): NativeUInt;
  end;
  {$ENDIF}

  {*************************** class FixedInt_sw ******************************}

  {$IFDEF LMDCOMP22}
  FixedInt_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: FixedInt): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): FixedInt;
  end;
  {$ENDIF}

  {*************************** class FixedUInt_sw *****************************}

  {$IFDEF LMDCOMP22}
  FixedUInt_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: FixedUInt): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): FixedUInt;
  end;
  {$ENDIF}

  {***************************** class Single_sw ******************************}

  Single_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Single): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Single;
  end;

  {***************************** class Double_sw ******************************}

  Double_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Double): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Double;
  end;

  {***************************** class Extended_sw ****************************}

  Extended_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Extended): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Extended;
  end;

  {******************************* class Comp_sw ******************************}

  Comp_sw = Int64_sw;

  {**************************** class Currency_sw *****************************}

  Currency_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Currency): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Currency;
  end;

  {******************************* class Byte_sw ******************************}

  Byte_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Byte): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Byte;
  end;

  {***************************** class Smallint_sw ****************************}

  Smallint_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Smallint): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Smallint;
  end;

  {***************************** class Shortint_sw ****************************}

  Shortint_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Shortint): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Shortint;
  end;

  {******************************* class Word_sw ******************************}

  Word_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Word): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Word;
  end;

  {***************************** class Longword_sw ****************************}

  Longword_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Longword): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Longword;
  end;

  {***************************** class Longint_sw *****************************}

  Longint_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Longint): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Longint;
  end;

  {******************************* class Char_sw ******************************}

  Char_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Char): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Char;
  end;

  {***************************** class AnsiChar_sw ****************************}

  AnsiChar_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: AnsiChar): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): AnsiChar;
  end;

  {***************************** class WideChar_sw ****************************}

  WideChar_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: WideChar): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): WideChar;
  end;

  {***************************** class String_sw ******************************}

  String_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(const AValue: string): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): string;
  end;

  {*************************** class ShortString_sw ***************************}

  ShortString_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: ShortString): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): ShortString;
  end;

  {**************************** class AnsiString_sw ***************************}

  AnsiString_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: AnsiString): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): AnsiString;
  end;

  {*************************** class WideString_sw ****************************}

  WideString_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: WideString): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): WideString;
  end;

  {************************* class UnicodeString_sw ***************************}

  {$IFDEF LMDCOMP12}
  UnicodeString_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: WideString): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): WideString;
  end;
  {$ENDIF}

  {************************** class RawByteString_sw **************************}

  {$IFDEF LMDCOMP12}
  RawByteString_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: RawByteString): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): RawByteString;
  end;
  {$ENDIF}

  {**************************** class TDateTime_sw ****************************}

  TDateTime_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: TDateTime): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): TDateTime;
  end;

  {***************************** class Variant_sw *****************************}

  Variant_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: Variant): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): Variant;
  end;

  {*************************** class OleVariant_sw ****************************}

  OleVariant_sw = class(TLMDPredTypeWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetVarType: TVarType; override;
  public
    class function ToVar(AValue: OleVariant): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): OleVariant;
  end;

  {**************************** class TVarRecord_sw ***************************}

  {$IFDEF LMDCOMP16}
  TVarRecord_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarRecord;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarRecord): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarRecord;
  end;
  {$ENDIF}

  {**************************** class TVarData_sw *****************************}

  TVarData_sw = class(TLMDRecordWrapper)
  private
    FValue: TVarData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVarData): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarData;
  end;

  {***************************** class TGUID_sw *******************************}

  TGUID_sw = class(TLMDRecordWrapper)
  private
    FValue: TGUID;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TGUID): OleVariant;
    class function FromVar(const AValue: OleVariant): TGUID;
  end;

  {**************************** class TMethod_sw ******************************}

  TMethod_sw = class(TLMDRecordWrapper)
  private
    FValue: TMethod;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMethod): OleVariant;
    class function FromVar(const AValue: OleVariant): TMethod;
  end;

  {********************** class TTextLineBreakStyle_sw ************************}

  TTextLineBreakStyle_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TTextLineBreakStyle): OleVariant;
    class function FromVar(const AValue: OleVariant): TTextLineBreakStyle;
  end;

  HRESULT_sw     = Longint_sw;
  THandle_sw     = Longword_sw;
  HINST_sw       = THandle_sw;
  HMODULE_sw     = HINST_sw;
  HGLOBAL_sw     = THandle_sw;
  TOACurrency_sw = Int64_sw;
  Int8_sw        = ShortInt_sw;
  Int16_sw       = Smallint_sw;
  Int32_sw       = Integer_sw;
  {$IFDEF LMDCOMP16}
  IntPtr_sw      = NativeInt_sw;
  {$ENDIF}
  UInt8_sw       = Byte_sw;
  UInt16_sw      = Word_sw;
  UInt32_sw      = Cardinal_sw;
  {$IFDEF LMDCOMP16}
  UIntPtr_sw     = NativeUInt_sw;
  {$ENDIF}
  TVarType_sw    = Word_sw;
  TDate_sw       = TDateTime_sw;
  TTime_sw       = TDateTime_sw;
  TVarOp_sw      = Integer_sw;
  TThreadID_sw   = LongWord_sw;

  {***************************** class TObject_sw *****************************}

  TObject_sw = class(TLMDClassWrapper)
  protected
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(AObject: TObject): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AObject: OleVariant): TObject;
    class function ClassToVar(AClass: TClass): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TClass;
  end;

  {***************************** class TClass_sw ******************************}

  TClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(AValue: TClass): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): TClass;
  end;

  {************************ class TInterfacedObject_sw ************************}

  TInterfacedObject_sc = class of TInterfacedObject;
  TInterfacedObject_sw = class(TObject_sw)
  protected
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(AObject: TInterfacedObject): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AObject: OleVariant): TInterfacedObject;
    class function ClassToVar(AClass: TInterfacedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInterfacedObject_sc;
  end;

  {*********************** class TInterfacedClass_sw **************************}

  TInterfacedClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(AValue: TInterfacedClass): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AValue: OleVariant): TInterfacedClass;
  end;

  {************************ class TAggregatedObject_sw ************************}

  TAggregatedObject_sc = class of TAggregatedObject;
  TAggregatedObject_sw = class(TObject_sw)
  protected
    class function GetWrappedClass: TClass; override;
  public
    class function ToVar(AObject: TAggregatedObject): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AObject: OleVariant): TAggregatedObject;
    class function ClassToVar(AClass: TAggregatedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TAggregatedObject_sc;
  end;

  {************************* class TContainedObject_sw ************************}

  TContainedObject_sc = class of TContainedObject;
  TContainedObject_sw = class(TAggregatedObject_sw)
  protected
    class function GetWrappedClass: TClass; override;
  public
    class function ToVar(AObject: TContainedObject): OleVariant;
    class function UntypedToVar(const AValue): OleVariant;
    class function FromVar(const AObject: OleVariant): TContainedObject;
    class function ClassToVar(AClass: TContainedObject_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TContainedObject_sc;
  end;

  {************************* class TCustomAttribute_sw ************************}

  {$IFDEF LMDCOMP14}
  TCustomAttribute_sc = class of TCustomAttribute;
  TCustomAttribute_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomAttribute): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomAttribute;
    class function ClassToVar(AClass: TCustomAttribute_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomAttribute_sc;
  end;
  {$ENDIF}

  {$IFDEF LMDCOMP17}
  TPtrWrapper_sw = class(TLMDRecordWrapper)
  private
    FValue: TPtrWrapper;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPtrWrapper): OleVariant;
    class function FromVar(const AValue: OleVariant): TPtrWrapper;
  end;
  {$ENDIF}

  {***************************** class System_sw ******************************}

  System_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

procedure _RegisterSysWrappers;

implementation

{ ---------------------------------------------------------------------------- }

procedure _RegisterSysWrappers;
begin
  RegisterUnitWrapper(System_sw);
  RegisterClassWrapper(TObject_sw);
  RegisterClassWrapper(TInterfacedObject_sw);
  RegisterClassWrapper(TAggregatedObject_sw);
  RegisterClassWrapper(TContainedObject_sw);
end;

{****************************** class Boolean_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function Boolean_sw.GetTypeName: WideString;
begin
  Result := 'Boolean';
end;

{ --------------------------------- public ----------------------------------- }

class function Boolean_sw.ToVar(AValue: Boolean): OleVariant;
begin
  Result := AValue;
end;

{ --------------------------------- public ----------------------------------- }

class function Boolean_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Boolean(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Boolean_sw.FromVar(const AValue: OleVariant): Boolean;
begin
  Result := AValue;
end;

{***************************** class ByteBool_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function ByteBool_sw.GetTypeName: WideString;
begin
  Result := 'ByteBool';
end;

{ --------------------------------- public ----------------------------------- }

class function ByteBool_sw.ToVar(AValue: Boolean): OleVariant;
begin
  Result := AValue;
end;

class function ByteBool_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Boolean(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function ByteBool_sw.FromVar(const AValue: OleVariant): Boolean;
begin
  Result := AValue;
end;

{****************************** class WordBool_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function WordBool_sw.GetTypeName: WideString;
begin
  Result := 'WordBool';
end;

{ --------------------------------- public ----------------------------------- }

class function WordBool_sw.ToVar(AValue: WordBool): OleVariant;
begin
  Result := AValue;
end;

class function WordBool_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(WordBool(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function WordBool_sw.FromVar(const AValue: OleVariant): WordBool;
begin
  Result := WordBool(AValue);
end;

{****************************** class LongBool_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function LongBool_sw.GetTypeName: WideString;
begin
  Result := 'LongBool';
end;

{ --------------------------------- public ----------------------------------- }

class function LongBool_sw.ToVar(AValue: LongBool): OleVariant;
begin
  Result := AValue;
end;

class function LongBool_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(LongBool(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function LongBool_sw.FromVar(const AValue: OleVariant): LongBool;
begin
  Result := LongBool(AValue);
end;

{****************************** class Integer_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function Integer_sw.GetTypeName: WideString;
begin
  Result := 'Integer';
end;

{ --------------------------------- public ----------------------------------- }

class function Integer_sw.ToVar(AValue: Integer): OleVariant;
begin
  Result := AValue;
end;
                               
class function Integer_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Integer(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Integer_sw.FromVar(const AValue: OleVariant): Integer;
begin
  Result := AValue;
end;

{****************************** class Cardinal_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function Cardinal_sw.GetTypeName: WideString;
begin
  Result := 'Cardinal';
end;

{ --------------------------------- public ----------------------------------- }

class function Cardinal_sw.ToVar(AValue: Cardinal): OleVariant;
begin
  Result := AValue;
end;
                                 
class function Cardinal_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Cardinal(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Cardinal_sw.FromVar(const AValue: OleVariant): Cardinal;
begin
  Result := AValue;
end;

{******************************* class Int64_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Int64_sw.GetTypeName: WideString;
begin
  Result := 'Int64';
end;

{ --------------------------------- public ----------------------------------- }

class function Int64_sw.ToVar(AValue: Int64): OleVariant;
begin
  Result := AValue;
end;

class function Int64_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Int64(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Int64_sw.FromVar(const AValue: OleVariant): Int64;
begin
  Result := AValue;
end;

{****************************** class UInt64_sw *******************************}
{ --------------------------------- protected -------------------------------- }

{$IFDEF LMDCOMP12}
class function UInt64_sw.GetTypeName: WideString;
begin
  Result := 'Int64';
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP12}
class function UInt64_sw.GetVarType: TVarType;
begin
  Result := varUInt64;
end;
{$ENDIF}

{ --------------------------------- public ----------------------------------- }

{$IFDEF LMDCOMP12}
class function UInt64_sw.ToVar(AValue: UInt64): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP12}
class function UInt64_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(UInt64(AValue));
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP12}
class function UInt64_sw.FromVar(const AValue: OleVariant): UInt64;
begin
  Result := AValue;
end;
{$ENDIF}

{**************************** class NativeInt_sw ******************************}
{ --------------------------------- protected -------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeInt_sw.GetTypeName: WideString;
begin
  Result := 'NativeInt';
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeInt_sw.GetVarType: TVarType;
begin
  Result := varInteger;
end;
{$ENDIF}

{ --------------------------------- public ----------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeInt_sw.ToVar(AValue: NativeInt): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeInt_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(NativeInt(AValue));
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeInt_sw.FromVar(const AValue: OleVariant): NativeInt;
begin
  Result := AValue;
end;
{$ENDIF}

{*************************** class NativeUInt_sw ******************************}
{ --------------------------------- protected -------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeUInt_sw.GetTypeName: WideString;
begin
  Result := 'NativeUInt';
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeUInt_sw.GetVarType: TVarType;
begin
  Result := varLongWord;
end;
{$ENDIF}

{ --------------------------------- public ----------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeUInt_sw.ToVar(AValue: NativeUInt): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeUInt_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(NativeUInt(AValue));
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF LMDCOMP16}
class function NativeUInt_sw.FromVar(const AValue: OleVariant): NativeUInt;
begin
  Result := AValue;
end;
{$ENDIF}

{****************************** class Single_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Single_sw.GetTypeName: WideString;
begin
  Result := 'Single';
end;

{ --------------------------------- public ----------------------------------- }

class function Single_sw.ToVar(AValue: Single): OleVariant;
begin
  Result := AValue;
end;
                                 
class function Single_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Single(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Single_sw.FromVar(const AValue: OleVariant): Single;
begin
  Result := AValue;
end;

{****************************** class Double_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Double_sw.GetTypeName: WideString;
begin
  Result := 'Double';
end;

{ --------------------------------- public ----------------------------------- }

class function Double_sw.ToVar(AValue: Double): OleVariant;
begin
  Result := AValue;
end;
                                
class function Double_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Double(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Double_sw.FromVar(const AValue: OleVariant): Double;
begin
  Result := AValue;
end;

{****************************** class Extended_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function Extended_sw.GetTypeName: WideString;
begin
  Result := 'Extended';
end;

{ --------------------------------- public ----------------------------------- }

class function Extended_sw.ToVar(AValue: Extended): OleVariant;
begin
  Result := AValue;
end;
                               
class function Extended_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Extended(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Extended_sw.FromVar(const AValue: OleVariant): Extended;
begin
  Result := AValue;
end;

{***************************** class Currency_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function Currency_sw.GetTypeName: WideString;
begin
  Result := 'Currency';
end;

{ --------------------------------- public ----------------------------------- }

class function Currency_sw.ToVar(AValue: Currency): OleVariant;
begin
  Result := AValue;
end;
                             
class function Currency_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Currency(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Currency_sw.FromVar(const AValue: OleVariant): Currency;
begin
  Result := AValue;
end;

{******************************** class Byte_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Byte_sw.GetTypeName: WideString;
begin
  Result := 'Byte';
end;

{ --------------------------------- public ----------------------------------- }

class function Byte_sw.ToVar(AValue: Byte): OleVariant;
begin
  Result := AValue;
end;
                            
class function Byte_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Byte(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Byte_sw.FromVar(const AValue: OleVariant): Byte;
begin
  Result := AValue;
end;

{****************************** class Smallint_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function Smallint_sw.GetTypeName: WideString;
begin
  Result := 'Smallint';
end;

{ --------------------------------- public ----------------------------------- }

class function Smallint_sw.ToVar(AValue: Smallint): OleVariant;
begin
  Result := AValue;
end;
                            
class function Smallint_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Smallint(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Smallint_sw.FromVar(const AValue: OleVariant): Smallint;
begin
  Result := AValue;
end;

{***************************** class Shortint_sw ****************************}
{ --------------------------------- protected -------------------------------- }

class function Shortint_sw.GetTypeName: WideString;
begin
  Result := 'Shortint';
end;

{ --------------------------------- public ----------------------------------- }

class function Shortint_sw.ToVar(AValue: Shortint): OleVariant;
begin
  Result := AValue;
end;
                             
class function Shortint_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Shortint(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Shortint_sw.FromVar(const AValue: OleVariant): Shortint;
begin
  Result := AValue;
end;

{******************************** class Word_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Word_sw.GetTypeName: WideString;
begin
  Result := 'Word';
end;

{ --------------------------------- public ----------------------------------- }

class function Word_sw.ToVar(AValue: Word): OleVariant;
begin
  Result := AValue;
end;
                               
class function Word_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Word(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Word_sw.FromVar(const AValue: OleVariant): Word;
begin
  Result := AValue;
end;

{****************************** class Longword_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function Longword_sw.GetTypeName: WideString;
begin
  Result := 'Longword';
end;

{ --------------------------------- public ----------------------------------- }

class function Longword_sw.ToVar(AValue: Longword): OleVariant;
begin
  Result := AValue;
end;
                              
class function Longword_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Longword(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Longword_sw.FromVar(const AValue: OleVariant): Longword;
begin
  Result := AValue;
end;

{****************************** class Longint_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function Longint_sw.GetTypeName: WideString;
begin
  Result := 'Longint';
end;

{ --------------------------------- public ----------------------------------- }

class function Longint_sw.ToVar(AValue: Integer): OleVariant;
begin
  Result := AValue;
end;
                            
class function Longint_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Integer(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Longint_sw.FromVar(const AValue: OleVariant): Longint;
begin
  Result := AValue;
end;

{******************************** class Char_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function Char_sw.GetTypeName: WideString;
begin
  Result := 'Char';
end;

{ --------------------------------- public ----------------------------------- }

class function Char_sw.ToVar(AValue: Char): OleVariant;
begin
  Result := Integer(AValue);
end;

class function Char_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Char(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Char_sw.FromVar(const AValue: OleVariant): Char;
begin
  Result := Char(Integer(AValue));
end;

{****************************** class AnsiChar_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function AnsiChar_sw.GetTypeName: WideString;
begin
  Result := 'AnsiChar';
end;

{ --------------------------------- public ----------------------------------- }

class function AnsiChar_sw.ToVar(AValue: AnsiChar): OleVariant;
begin
  Result := Integer(AValue);
end;

class function AnsiChar_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(AnsiChar(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function AnsiChar_sw.FromVar(const AValue: OleVariant): AnsiChar;
begin
  Result := AnsiChar(Integer(AValue));
end;

{****************************** class WideChar_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function WideChar_sw.GetTypeName: WideString;
begin
  Result := 'WideChar';
end;

{ --------------------------------- public ----------------------------------- }

class function WideChar_sw.ToVar(AValue: WideChar): OleVariant;
begin
  Result := Integer(AValue);
end;
                          
class function WideChar_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(WideChar(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function WideChar_sw.FromVar(const AValue: OleVariant): WideChar;
begin
  Result := WideChar(Integer(AValue));
end;

{****************************** class String_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function String_sw.GetTypeName: WideString;
begin
  Result := 'String';
end;

{ --------------------------------- public ----------------------------------- }

class function String_sw.ToVar(const AValue: string): OleVariant;
begin
  Result := AValue;
end;
                              
class function String_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(String(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function String_sw.FromVar(const AValue: OleVariant): string;
begin
  Result := AValue;
end;

{**************************** class ShortString_sw ****************************}
{ --------------------------------- protected -------------------------------- }

class function ShortString_sw.GetTypeName: WideString;
begin
  Result := 'ShortString';
end;

{ --------------------------------- public ----------------------------------- }

class function ShortString_sw.ToVar(AValue: ShortString): OleVariant;
begin
  Result := AValue;
end;
                                 
class function ShortString_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(ShortString(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function ShortString_sw.FromVar(const AValue: OleVariant): ShortString;
begin
  Result := ShortString(AValue);
end;

{***************************** class AnsiString_sw ****************************}
{ --------------------------------- protected -------------------------------- }

class function AnsiString_sw.GetTypeName: WideString;
begin
  Result := 'AnsiString';
end;

{ --------------------------------- public ----------------------------------- }

class function AnsiString_sw.ToVar(AValue: AnsiString): OleVariant;
begin
  Result := AValue;
end;
                          
class function AnsiString_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(AnsiString(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function AnsiString_sw.FromVar(const AValue: OleVariant): AnsiString;
begin
  Result := AnsiString(AValue);
end;

{**************************** class WideString_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function WideString_sw.GetTypeName: WideString;
begin
  Result := 'WideString';
end;

{ --------------------------------- public ----------------------------------- }

class function WideString_sw.ToVar(AValue: WideString): OleVariant;
begin
  Result := AValue;
end;
                                 
class function WideString_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(WideString(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function WideString_sw.FromVar(const AValue: OleVariant): WideString;
begin
  Result := AValue;
end;

{****************************** class Variant_sw ******************************}
{ --------------------------------- protected -------------------------------- }

class function Variant_sw.GetTypeName: WideString;
begin
  Result := 'Variant';
end;

{ --------------------------------- public ----------------------------------- }

class function Variant_sw.ToVar(AValue: Variant): OleVariant;
begin
  Result := AValue;
end;
                            
class function Variant_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(Variant(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function Variant_sw.FromVar(const AValue: OleVariant): Variant;
begin
  // FindVarData is required! Because in Variant to Variant
  // conversion Delphi does not dereference var-refs.

  Result := Variant(FindVarData(AValue)^);
end;

{**************************** class OleVariant_sw *****************************}
{ --------------------------------- protected -------------------------------- }

class function OleVariant_sw.GetTypeName: WideString;
begin
  Result := 'OleVariant';
end;

{ --------------------------------- public ----------------------------------- }

class function OleVariant_sw.ToVar(AValue: OleVariant): OleVariant;
begin
  Result := AValue;
end;
                           
class function OleVariant_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(OleVariant(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function OleVariant_sw.FromVar(const AValue: OleVariant): OleVariant;
begin
  // FindVarData is required! Because in Variant to Variant
  // conversion Delphi does not dereference var-refs.

  Result := OleVariant(FindVarData(AValue)^);
end;

{****************************** class TObject_sw ******************************}
{ --------------------------------- protected -------------------------------- }

function TObject_ClassType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TClass_sw.ToVar(TObject(AObj).ClassType);
end;

{ ---------------------------------------------------------------------------- }

function TObject_Free_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  TObject(AObj).Free;
end;

{ ---------------------------------------------------------------------------- }

function TObject_Destroy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  TObject(AObj).Destroy;
end;

{ ---------------------------------------------------------------------------- }

function TObject_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TObject_sw.ToVar(TClass(AObj).Create);
end;

{ ---------------------------------------------------------------------------- }

function TObject_ClassName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TClass(AObj).ClassName;
end;

{ ---------------------------------------------------------------------------- }

function TObject_ClassNameIs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TClass(AObj).ClassNameIs(AArgs[0]);
end;

{ ---------------------------------------------------------------------------- }

function TObject_ClassParent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TObject_sw.ClassToVar(TClass(AObj).ClassParent);
end;

{ ---------------------------------------------------------------------------- }

function TObject_InstanceSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TClass(AObj).InstanceSize;
end;

{ ---------------------------------------------------------------------------- }

function TObject_InheritsFrom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TClass(AObj).InheritsFrom(TObject_sw.ClassFromVar(AArgs[0]));
end;

{ ---------------------------------------------------------------------------- }

class function TObject_sw.GetWrappedClass: TClass;
begin
  Result := TObject;
end;

{ ---------------------------------------------------------------------------- }

class procedure TObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance }

  AData.AddFunction('ClassType', TObject_ClassType_si, TClass_sw, 0);
  AData.AddProcedure('Free', TObject_Free_si, 0);
  AData.AddProcedure('Destroy', TObject_Destroy_si, 0);

  { Class }

  AData.AddConstructor('Create', TObject_Create_si, 0);
  AData.AddClassFunction('ClassName', TObject_ClassName_si, String_sw, 0);
  AData.AddClassFunction('ClassNameIs', TObject_ClassNameIs_si, Boolean_sw, 1);
  AData.AddClassFunction('ClassParent', TObject_ClassParent_si, TClass_sw, 0);
  AData.AddClassFunction('InstanceSize', TObject_InstanceSize_si, Integer_sw, 0);
  AData.AddClassFunction('InheritsFrom', TObject_InheritsFrom_si, Boolean_sw, 1);
end;

{ --------------------------------- public ----------------------------------- }

class function TObject_sw.ToVar(AObject: TObject): OleVariant;
begin
  Result := ConvToVar(AObject);
end;

class function TObject_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TObject(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TObject_sw.FromVar(const AObject: OleVariant): TObject;
begin
  Result := ConvFromVar(AObject);
end;
                                 
{ ---------------------------------------------------------------------------- }

class function TObject_sw.ClassToVar(AClass: TClass): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;
                                 
{ ---------------------------------------------------------------------------- }

class function TObject_sw.ClassFromVar(const AClass: OleVariant): TClass;
begin
  Result := ConvClsFromVar(AClass);
end;


{****************************** class TClass_sw *******************************}
{ --------------------------------- protected -------------------------------- }

class function TClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TObject;
end;

{ --------------------------------- public ----------------------------------- }

class function TClass_sw.ToVar(AValue: TClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;
    
class function TClass_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TClass(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TClass_sw.FromVar(const AValue: OleVariant): TClass;
begin
  Result := TClass(ConvFromVar(AValue, TObject));
end;

{************************* class TInterfacedObject_sw *************************}
{ --------------------------------- protected -------------------------------- }

function TInterfacedObject_RefCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TInterfacedObject(AObj).RefCount;
end;

class function TInterfacedObject_sw.GetWrappedClass: TClass;
begin
  Result := TInterfacedObject;
end;

{ ---------------------------------------------------------------------------- }

class procedure TInterfacedObject_sw.DoInit(AData: TLMDClassWrapperData);
begin
  AData.AddProperty('RefCount', TInterfacedObject_RefCount_si, Integer_sw,
                    True, False, 0);
end;

{ --------------------------------- public ----------------------------------- }

class function TInterfacedObject_sw.ToVar(
  AObject: TInterfacedObject): OleVariant;
begin
  Result := ConvToVar(AObject);
end;

class function TInterfacedObject_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TInterfacedObject(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TInterfacedObject_sw.FromVar(
  const AObject: OleVariant): TInterfacedObject;
begin
  Result := TInterfacedObject(ConvFromVar(AObject, TInterfacedObject));
end;
                  
{ ---------------------------------------------------------------------------- }

class function TInterfacedObject_sw.ClassToVar(
  AClass: TInterfacedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;
                          
{ ---------------------------------------------------------------------------- }

class function TInterfacedObject_sw.ClassFromVar(
  const AClass: OleVariant): TInterfacedObject_sc;
begin
  Result := TInterfacedObject_sc(ConvClsFromVar(
    AClass, TInterfacedObject));
end;

{************************ class TInterfacedClass_sw ***************************}
{ --------------------------------- protected -------------------------------- }

class function TInterfacedClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TInterfacedObject;
end;

{ --------------------------------- public ----------------------------------- }

class function TInterfacedClass_sw.ToVar(AValue: TInterfacedClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInterfacedClass_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TInterfacedClass(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TInterfacedClass_sw.FromVar(
  const AValue: OleVariant): TInterfacedClass;
begin
  Result := TInterfacedClass(ConvFromVar(AValue, TInterfacedObject));
end;

{************************* class TAggregatedObject_sw *************************}
{ --------------------------------- protected -------------------------------- }

class function TAggregatedObject_sw.GetWrappedClass: TClass;
begin
  Result := TAggregatedObject;
end;

{ --------------------------------- public ----------------------------------- }

class function TAggregatedObject_sw.ToVar(
  AObject: TAggregatedObject): OleVariant;
begin
  Result := ConvToVar(AObject);
end;

class function TAggregatedObject_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TAggregatedObject(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TAggregatedObject_sw.FromVar(
  const AObject: OleVariant): TAggregatedObject;
begin
  Result := TAggregatedObject(ConvFromVar(AObject, TAggregatedObject));
end;

{ ---------------------------------------------------------------------------- }

class function TAggregatedObject_sw.ClassToVar(
  AClass: TAggregatedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

{ ---------------------------------------------------------------------------- }

class function TAggregatedObject_sw.ClassFromVar(
  const AClass: OleVariant): TAggregatedObject_sc;
begin
  Result := TAggregatedObject_sc(ConvClsFromVar(
    AClass, TAggregatedObject));
end;

{************************** class TContainedObject_sw *************************}
{ --------------------------------- protected -------------------------------- }

class function TContainedObject_sw.GetWrappedClass: TClass;
begin
  Result := TContainedObject;
end;

{ --------------------------------- public ----------------------------------- }

class function TContainedObject_sw.ToVar(
  AObject: TContainedObject): OleVariant;
begin
  Result := ConvToVar(AObject);
end;

class function TContainedObject_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TContainedObject(AValue));
end;

{ ---------------------------------------------------------------------------- }

class function TContainedObject_sw.FromVar(
  const AObject: OleVariant): TContainedObject;
begin
  Result := TContainedObject(ConvFromVar(AObject, TContainedObject));
end;

{ ---------------------------------------------------------------------------- }

class function TContainedObject_sw.ClassToVar(
  AClass: TContainedObject_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

{ ---------------------------------------------------------------------------- }

class function TContainedObject_sw.ClassFromVar(
  const AClass: OleVariant): TContainedObject_sc;
begin
  Result := TContainedObject_sc(ConvClsFromVar(
    AClass, TContainedObject));
end;

{****************************** class System_sw *******************************}
{ --------------------------------- protected -------------------------------- }

function System_TObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TObject_sw);
end;

function System_TInterfacedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TInterfacedObject_sw);
end;

function System_TAggregatedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TAggregatedObject_sw);
end;

function System_TContainedObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TContainedObject_sw);
end;

function System_Abs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Abs(Extended(AArgs[0]));
end;

function System_AnsiToUtf8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := AnsiToUtf8(AArgs[0]);
end;

function System_ArcTan_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := ArcTan(AArgs[0]);
end;

function System_Assert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  case AArgsSize of
    1:  Assert(Boolean(AArgs[0]));
    2:  Assert(Boolean(AArgs[0]), AArgs[1]);
  else
    WrongArgCountError('Assert');
  end;
end;

function System_ChDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  ChDir(string(AArgs[0]));
end;

function System_Chr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Chr(Byte(AArgs[0]));
end;

function System_CompToCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := CompToCurrency(AArgs[0]);
end;

function System_CompToDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := CompToDouble(AArgs[0]);
end;

function System_Concat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  s: string;
  i: Integer;
begin
  { Emulate 'Concat' function }

  s := '';
  for i := 0 to AArgsSize - 1 do
    s := s + string(AArgs[i]);
  Result := s;
end;

function System_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Copy(string(AArgs[0]), Integer(AArgs[1]), Integer(AArgs[2]));
end;

function System_Cos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Cos(AArgs[0]);
end;

function System_CurrencyToComp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  c: Comp;
begin
  c := AArgs[1];
  CurrencyToComp(AArgs[0], c);
  AssignRefParam(AArgs[1], c);
end;

function System_Delete_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  s: string;
begin
  s := AArgs[0];
  Delete(s, Integer(AArgs[1]), Integer(AArgs[2]));
  AssignRefParam(AArgs[0], s);
end;

function System_DoubleToComp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  c: Comp;
begin
  c := AArgs[1];
  DoubleToComp(AArgs[0], c);
  AssignRefParam(AArgs[1], c);
end;

function System_ExceptObject_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TObject_sw.ToVar(ExceptObject);
end;

function System_Exp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Exp(AArgs[0]);
end;

function System_Frac_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Frac(AArgs[0]);
end;

function System_GetDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  s: string;
begin
  s := AArgs[1];
  GetDir(Byte(AArgs[0]), s);
  AssignRefParam(AArgs[1], s);
end;

function System_Insert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  s: string;
begin
  s := AArgs[1];
  Insert(AArgs[0], s, Integer(AArgs[2]));
  AssignRefParam(AArgs[1], s);
end;

function System_Int_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Int(AArgs[0]);
end;

function System_Length_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Length(string(AArgs[0]));
end;

function System_Ln_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Ln(AArgs[0]);
end;

function System_MaxInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := MaxInt;
end;

function System_MaxLongint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := MaxLongint;
end;

function System_MkDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  MkDir(string(AArgs[0]));
end;

function System_Odd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Odd(Longint(AArgs[0]));
end;

function System_Pi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Pi;
end;

function System_Pos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Pos(AArgs[0], AArgs[1]);
end;

function System_Random_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  case AArgsSize of
    0: Result := Random;
    1: Result := Random(Integer(AArgs[0]));
  else
    WrongArgCountError('Random');
  end;
end;

function System_Randomize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Randomize;
end;

function System_RandSeed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  if IsGet then Result := RandSeed else RandSeed := AArgs[0];
end;

function System_RmDir_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  RmDir(AArgs[0]);
end;

function System_Round_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Int64_sw.ToVar(Round(AArgs[0]));
end;

function System_SetLength_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  s: string;
begin
  s := AArgs[0];
  SetLength(s, Integer(AArgs[1]));
  AssignRefParam(AArgs[0], s);
end;

function System_Sin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Sin(AArgs[0]);
end;

function System_Sqr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Sqr(Extended(AArgs[0]));
end;

function System_Sqrt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Sqrt(AArgs[0]);
end;

function System_Str_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  {$IFDEF LMDCOMP12}
  tmp: AnsiString;
  {$ENDIF}
  s:   string;
begin
  {$IFDEF LMDCOMP12}
  tmp := AnsiString(AArgs[AArgsSize - 1]);
  {$ELSE}
  s   := AArgs[AArgsSize - 1];
  {$ENDIF}

  case AArgsSize of
  {$IFDEF LMDCOMP12}
    2: Str(Extended(AArgs[0]), tmp);
    3: Str(Extended(AArgs[0]) : Integer(AArgs[1]), tmp);
    4: Str(Extended(AArgs[0]) : Integer(AArgs[1]) : Integer(AArgs[2]), tmp);
  {$ELSE}
    2: Str(Extended(AArgs[0]), s);
    3: Str(Extended(AArgs[0]) : Integer(AArgs[1]), s);
    4: Str(Extended(AArgs[0]) : Integer(AArgs[1]) : Integer(AArgs[2]), s);
  {$ENDIF}
  else
    WrongArgCountError('Str');
  end;

  {$IFDEF LMDCOMP12}
  s := string(tmp);
  {$ENDIF}

  AssignRefParam(AArgs[AArgsSize - 1], s);
end;

function System_Trunc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := Int64_sw.ToVar(Trunc(AArgs[0]));
end;

function System_Boolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Boolean_sw);
end;

function System_WordBool_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(WordBool_sw);
end;

function System_Integer_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Integer_sw);
end;

function System_Cardinal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Cardinal_sw);
end;

function System_Int64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Int64_sw);
end;

{$IFDEF LMDCOMP12}
function System_UInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(UInt64_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
function System_NativeInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(NativeInt_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
function System_NativeUInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(NativeUInt_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
function System_FixedInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(FixedInt_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
function System_FixedUInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(FixedUInt_sw);
end;
{$ENDIF}

function System_Single_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Single_sw);
end;

function System_Double_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Double_sw);
end;

function System_Extended_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Extended_sw);
end;

function System_Comp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Comp_sw);
end;

function System_Currency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Currency_sw);
end;

function System_Byte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Byte_sw);
end;

function System_Smallint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Smallint_sw);
end;

function System_Shorint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Shortint_sw);
end;

function System_Word_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Word_sw);
end;

function System_Longword_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Longword_sw);
end;

function System_Longint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Longint_sw);
end;

function System_Char_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Char_sw);
end;

function System_AnsyChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(AnsiChar_sw);
end;

function System_WideChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(WideChar_sw);
end;

function System_String_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(String_sw);
end;

function System_ShortString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(ShortString_sw);
end;

function System_AnsiString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(AnsiString_sw);
end;

{$IFDEF LMDCOMP12}
function System_UnicodeString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(UnicodeString_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
function System_RawByteString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(RawByteString_sw);
end;
{$ENDIF}

function System_WideString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(WideString_sw);
end;

function System_Variant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(Variant_sw);
end;

function System_OleVariant_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(OleVariant_sw);
end;

function System_TGUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TGUID_sw);
end;

{$IFDEF LMDCOMP16}
function System_TVarRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TVarRecord_sw);
end;
{$ENDIF}

function System_TVarData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TVarData_sw);
end;

function System_TTextLineBreakStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TTextLineBreakStyle_sw);
end;

{$IFDEF LMDCOMP14}
function System_TCustomAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TCustomAttribute_sw);
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
function System_TPtrWrapper_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPtrWrapper = record;

  Result := TLMDUnitWrapper.TypeToVar(TPtrWrapper_sw);
end;
{$ENDIF}

function System_TMethod_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDUnitWrapper.TypeToVar(TMethod_sw);
end;

function System_Include_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  AssignRefParam(AArgs[0], VarSetInclude(AArgs[0], AArgs[1]));
end;

function System_Exclude_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  AssignRefParam(AArgs[0], VarSetExclude(AArgs[0], AArgs[1]));
end;

function System_SetIn_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarSetIn(AArgs[0], AArgs[1]);
end;

function System_SetMake_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarSetMake(AArgs, AArgsSize);
end;

function System_SetEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarSetEmpty;
end;

function System_ObjectIs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarObjectIs(AArgs[0], AArgs[1]);
end;

function System_RecIs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarRecIs(AArgs[0], AArgs[1]);
end;

function System_RecNew_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarRecNew(AArgs[0]);
end;

function System_RecCopy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := VarRecCopy(AArgs[0]);
end;

function System_EventMake_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TLMDEventWrapper.ToVar(TLMDUnitWrapper(AObj).ScriptControl,
                                   AArgs[0]);
end;

class procedure System_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TObject_sw, System_TObject_si);
  AData.AddType(TInterfacedObject_sw, System_TInterfacedObject_si);
  AData.AddType(TAggregatedObject_sw, System_TAggregatedObject_si);
  AData.AddType(TContainedObject_sw, System_TContainedObject_si);
  AData.AddFunction('Abs', System_Abs_si, Extended_sw, 1);
  AData.AddFunction('AnsiToUtf8', System_AnsiToUtf8_si, String_sw, 1);
  AData.AddFunction('ArcTan', System_ArcTan_si, Extended_sw, 1);
  AData.AddProcedure('Assert', System_Assert_si, 1, True);
  AData.AddProcedure('ChDir', System_ChDir_si, 1);
  AData.AddFunction('Chr', System_Chr_si, Char_sw, 1);
  AData.AddFunction('CompToCurrency', System_CompToCurrency_si, Currency_sw, 1);
  AData.AddFunction('CompToDouble', System_CompToDouble_si, Double_sw, 1);
  AData.AddFunction('Concat', System_Concat_si, String_sw, 1, True);
  AData.AddFunction('Copy', System_Copy_si, String_sw, 3);
  AData.AddFunction('Cos', System_Cos_si, Extended_sw, 1);
  AData.AddProcedure('CurrencyToComp', System_CurrencyToComp_si, 2);
  AData.AddProcedure('Delete', System_Delete_si, 3);
  AData.AddProcedure('DoubleToComp', System_DoubleToComp_si, 2);
  AData.AddFunction('ExceptObject', System_ExceptObject_si, TObject_sw, 0);
  AData.AddFunction('Exp', System_Exp_si, Extended_sw, 1);
  AData.AddFunction('Frac', System_Frac_si, Extended_sw, 1);
  AData.AddProcedure('GetDir', System_GetDir_si, 2);
  AData.AddProcedure('Insert', System_Insert_si, 3);
  AData.AddFunction('Int', System_Int_si, Extended_sw, 1);
  AData.AddFunction('Length', System_Length_si, Integer_sw, 1);
  AData.AddFunction('Ln', System_Ln_si, Extended_sw, 1);
  AData.AddConstant('MaxInt', System_MaxInt_si, Integer_sw);
  AData.AddConstant('MaxLongint', System_MaxLongint_si, Integer_sw);
  AData.AddProcedure('MkDir', System_MaxLongint_si, 1);
  AData.AddFunction('Odd', System_Odd_si, Boolean_sw, 1);
  AData.AddFunction('Pi', System_Pi_si, Extended_sw, 0);
  AData.AddFunction('Pos', System_Pos_si, Integer_sw, 2);
  AData.AddFunction('Random', System_Random_si, Extended_sw, 0, True);
  AData.AddProcedure('Randomize', System_Randomize_si, 0);
  AData.AddVariable('RandSeed', System_RandSeed_si, Integer_sw);
  AData.AddProcedure('RmDir', System_RmDir_si, 1);
  AData.AddFunction('Round', System_Round_si, Int64_sw, 1);
  AData.AddProcedure('SetLength', System_SetLength_si, 2);
  AData.AddFunction('Sin', System_Sin_si, Extended_sw, 1);
  AData.AddFunction('Sqr', System_Sqr_si, Extended_sw, 1);
  AData.AddFunction('Sqrt', System_Sqrt_si, Extended_sw, 1);
  AData.AddProcedure('Str', System_Str_si, 2, True);
  AData.AddFunction('Trunc', System_Trunc_si, Int64_sw, 1);
  AData.AddType(Boolean_sw, System_Boolean_si);
  AData.AddType(WordBool_sw, System_WordBool_si);
  AData.AddType(Integer_sw, System_Integer_si);
  AData.AddType(Cardinal_sw, System_Cardinal_si);
  AData.AddType(Int64_sw, System_Int64_si);
  {$IFDEF LMDCOMP12}
  AData.AddType(UInt64_sw, System_UInt64_si);
  {$ENDIF}
  {$IFDEF LMDCOMP16}
  AData.AddType(NativeInt_sw, System_NativeInt_si);
  AData.AddType(NativeUInt_sw, System_NativeUInt_si);
  {$ENDIF}
  {$IFDEF LMDCOMP22}
  AData.AddType(FixedInt_sw, System_FixedInt_si);
  AData.AddType(FixedUInt_sw, System_FixedInt_si);
  {$ENDIF}
  AData.AddType(Single_sw, System_Single_si);
  AData.AddType(Double_sw, System_Double_si);
  AData.AddType(Extended_sw, System_Extended_si);
  AData.AddType(Comp_sw, System_Comp_si);
  AData.AddType(Currency_sw, System_Currency_si);
  AData.AddType(Byte_sw, System_Byte_si);
  AData.AddType(Smallint_sw, System_Smallint_si);
  AData.AddType(Shortint_sw, System_Shorint_si);
  AData.AddType(Word_sw, System_Word_si);
  AData.AddType(Longword_sw, System_Longword_si);
  AData.AddType(Longint_sw, System_Longint_si);
  AData.AddType(Char_sw, System_Char_si);
  AData.AddType(AnsiChar_sw, System_AnsyChar_si);
  AData.AddType(WideChar_sw, System_WideChar_si);
  AData.AddType(String_sw, System_String_si);
  AData.AddType(ShortString_sw, System_ShortString_si);
  AData.AddType(AnsiString_sw, System_AnsiString_si);
  AData.AddType(WideString_sw, System_WideString_si);
  AData.AddType(Variant_sw, System_Variant_si);
  AData.AddType(OleVariant_sw, System_OleVariant_si);
  AData.AddType(TGUID_sw, System_TGUID_si);
  {$IFDEF LMDCOMP16}
  AData.AddType(TVarRecord_sw, System_TVarRecord_si);
  {$ENDIF}
  AData.AddType(TVarData_sw, System_TVarData_si);
  AData.AddType(TTextLineBreakStyle_sw, System_TTextLineBreakStyle_si);
  {$IFDEF LMDCOMP12}
  AData.AddType(RawByteString_sw, System_RawByteString_si);
  AData.AddType(UnicodeString_sw, System_UnicodeString_si);
  {$ENDIF}
  {$IFDEF LMDCOMP14}
  AData.AddType(TCustomAttribute_sw, System_TCustomAttribute_si);
  {$ENDIF}
  {$IFDEF LMDCOMP17}
  AData.AddType(TPtrWrapper_sw, System_TPtrWrapper_si);
  {$ENDIF}
  AData.AddType(TMethod_sw, System_TMethod_si);
  AData.AddProcedure('Include', System_Include_si, 2);
  AData.AddProcedure('Exclude', System_Exclude_si, 2);
  AData.AddFunction('SetIn', System_SetIn_si, Boolean_sw, 2);
  AData.AddFunction('SetMake', System_SetMake_si, Integer_sw, 0, True);
  AData.AddFunction('SetEmpty', System_SetEmpty_si, Integer_sw, 0);
  AData.AddFunction('ObjectIs', System_ObjectIs_si, Boolean_sw, 2);
  AData.AddFunction('RecIs', System_RecIs_si, Boolean_sw, 2);
  AData.AddFunction('RecNew', System_RecNew_si, TObject_sw, 1);
  AData.AddFunction('RecCopy', System_RecCopy_si, TObject_sw, 1);
  AData.AddFunction('EventMake', System_EventMake_si, TObject_sw, 1);
end;

{ --------------------------------- public ----------------------------------- }

class function System_sw.GetUnitName: WideString;
begin
  Result := 'System';
end;

{ ---------------------------------------------------------------------------- }

class function System_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(System_sw);
end;

class function Boolean_sw.GetVarType: TVarType;
begin
  Result := varBoolean;
end;

class function ByteBool_sw.GetVarType: TVarType;
begin
  Result := varBoolean;
end;

class function WordBool_sw.GetVarType: TVarType;
begin
  Result := varBoolean;
end;

class function LongBool_sw.GetVarType: TVarType;
begin
  Result := varBoolean;
end;

class function Integer_sw.GetVarType: TVarType;
begin
  Result := varInteger;
end;

class function Cardinal_sw.GetVarType: TVarType;
begin
  Result := varLongWord;
end;

class function Int64_sw.GetVarType: TVarType;
begin
  Result := varInt64;
end;

class function Single_sw.GetVarType: TVarType;
begin
  Result := varSingle;
end;

class function Double_sw.GetVarType: TVarType;
begin
  Result := varDouble;
end;

class function Extended_sw.GetVarType: TVarType;
begin
  Result := varDouble;
end;

class function Currency_sw.GetVarType: TVarType;
begin
  Result := varCurrency;
end;

class function Byte_sw.GetVarType: TVarType;
begin
  Result := varByte;
end;

class function Smallint_sw.GetVarType: TVarType;
begin
  Result := varSmallint;
end;

class function Shortint_sw.GetVarType: TVarType;
begin
  Result := varShortInt;
end;

class function Word_sw.GetVarType: TVarType;
begin
  Result := varWord;
end;

class function Longword_sw.GetVarType: TVarType;
begin
  Result := varLongWord;
end;

class function Longint_sw.GetVarType: TVarType;
begin
  Result := varInteger; 
end;

class function Char_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function AnsiChar_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function WideChar_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function String_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function ShortString_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function AnsiString_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function WideString_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;

class function Variant_sw.GetVarType: TVarType;
begin
  Result := varVariant;
end;

class function OleVariant_sw.GetVarType: TVarType;
begin
  Result := varVariant;
end;

{ TGUID_sw }

function TGUID_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  Result := TGUID_sw.ToVar(TGUID(AObj));
end;

function TGUID_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TGUID_sw.Create as IDispatch;
end;

function TGUID_D1_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D1: LongWord;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D1
  else
    TGUID_sw(AObj).FValue.D1 := LongWord(AArgs[0]);
end;

function TGUID_D2_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D2: Word;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D2
  else
    TGUID_sw(AObj).FValue.D2 := Word(AArgs[0]);
end;

function TGUID_D3_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var D3: Word;

  if IsGet then
    Result := TGUID_sw(AObj).FValue.D3
  else
    TGUID_sw(AObj).FValue.D3 := Word(AArgs[0]);
end;

{$IFDEF LMDCOMP16}
function TGUID_Empty_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // class function Empty: TGUID;

  Result := TGUID_sw.ToVar(TGUID.Empty());
end;
{$ENDIF}

class function TGUID_sw.GetTypeName: WideString;
begin
  Result := 'TGUID';
end;

function TGUID_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TGUID_sw.Create;
  TGUID_sw(Result).FValue := FValue;
end;

class procedure TGUID_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TGUID_Copy_si, TGUID_sw, 0);
  AData.AddField('D1', TGUID_D1_si, LongWord_sw);
  AData.AddField('D2', TGUID_D2_si, Word_sw);
  AData.AddField('D3', TGUID_D3_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TGUID_Create_si, 0);
  {$IFDEF LMDCOMP16}
  AData.AddClassFunction('Empty', TGUID_Empty_si, TGUID_sw, 0, False);
  {$ENDIF}
end;

class function TGUID_sw.ToVar(const AValue: TGUID): OleVariant;
var
  wrpr: TGUID_sw;
begin
  wrpr        := TGUID_sw.Create;
  wrpr.FValue := AValue;

  Result := ConvToVar(wrpr);
end;

class function TGUID_sw.FromVar(const AValue: OleVariant): TGUID;
begin
  Result := TGUID_sw(ConvFromVar(AValue)).FValue;
end;

{ TCustomAttribute_sw }

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.GetTypeName: WideString;
begin
  Result := 'TCustomAttribute';
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.GetWrappedClass: TClass;
begin
  Result := TCustomAttribute;
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class procedure TCustomAttribute_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.ToVar(
  const AValue: TCustomAttribute): OleVariant;
begin
  Result := ConvToVar(AValue);
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.FromVar(
  const AValue: OleVariant): TCustomAttribute;
begin
  Result := TCustomAttribute(ConvFromVar(AValue, TCustomAttribute));
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.ClassToVar(
  AClass: TCustomAttribute_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;
{$ENDIF}

{$IFDEF LMDCOMP14}
class function TCustomAttribute_sw.ClassFromVar(
  const AClass: OleVariant): TCustomAttribute_sc;
begin
  Result := TCustomAttribute_sc(ConvClsFromVar(AClass, TCustomAttribute));
end;
{$ENDIF}

{ TMethod_sw }

function TMethod_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TMethod_sw.ToVar(TMethod(AObj));
end;

function TMethod_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TMethod_sw.Create as IDispatch;
end;

class function TMethod_sw.GetTypeName: WideString;
begin
  Result := 'TMethod';
end;

function TMethod_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMethod_sw.Create;
  TMethod_sw(Result).FValue := FValue;
end;

class procedure TMethod_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TMethod_Copy_si, TMethod_sw, 0);

  { Class members }

  AData.AddConstructor('Create', TMethod_Create_si, 0);
end;

class function TMethod_sw.ToVar(const AValue: TMethod): OleVariant;
var
  wrpr: TMethod_sw;
begin
  wrpr        := TMethod_sw.Create;
  wrpr.FValue := AValue;

  Result := ConvToVar(wrpr);
end;

class function TMethod_sw.FromVar(const AValue: OleVariant): TMethod;
begin
  Result := TMethod_sw(ConvFromVar(AValue)).FValue;
end;

{ TTextLineBreakStyle_sw }

class function TTextLineBreakStyle_sw.GetTypeName: WideString;
begin
  Result := 'TTextLineBreakStyle';
end;

class procedure TTextLineBreakStyle_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'tlbsLF'; Value: Integer({$IFDEF LMDSCT_12}TTextLineBreakStyle.{$ENDIF}tlbsLF)),
    (Name: 'tlbsCRLF'; Value: Integer({$IFDEF LMDSCT_12}TTextLineBreakStyle.{$ENDIF}tlbsCRLF))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TTextLineBreakStyle_sw.ToVar(
  const AValue: TTextLineBreakStyle): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTextLineBreakStyle_sw.FromVar(
  const AValue: OleVariant): TTextLineBreakStyle;
begin
  Result := TTextLineBreakStyle(Integer(AValue));
end;

{ TVarData_sw }

function TVarData_VType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VType: TVarType;

  if IsGet then
    Result := TVarType_sw.ToVar(TVarData_sw(AObj).FValue.VType)
  else
    TVarData_sw(AObj).FValue.VType := TVarType_sw.FromVar(AArgs[0]);
end;

function TVarData_Reserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved1: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved1
  else
    TVarData_sw(AObj).FValue.Reserved1 := Word(AArgs[0]);
end;

function TVarData_Reserved2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved2: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved2
  else
    TVarData_sw(AObj).FValue.Reserved2 := Word(AArgs[0]);
end;

function TVarData_Reserved3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Reserved3: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.Reserved3
  else
    TVarData_sw(AObj).FValue.Reserved3 := Word(AArgs[0]);
end;

function TVarData_VSmallInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VSmallInt: SmallInt;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VSmallInt
  else
    TVarData_sw(AObj).FValue.VSmallInt := SmallInt(AArgs[0]);
end;

function TVarData_VInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VInteger: Integer;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VInteger
  else
    TVarData_sw(AObj).FValue.VInteger := Integer(AArgs[0]);
end;

function TVarData_VSingle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VSingle: Single;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VSingle
  else
    TVarData_sw(AObj).FValue.VSingle := Single(AArgs[0]);
end;

function TVarData_VDouble_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VDouble: Double;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VDouble
  else
    TVarData_sw(AObj).FValue.VDouble := Double(AArgs[0]);
end;

function TVarData_VCurrency_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VCurrency: Currency;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VCurrency
  else
    TVarData_sw(AObj).FValue.VCurrency := Currency(AArgs[0]);
end;

function TVarData_VDate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VDate: TDateTime;

  if IsGet then
    Result := TDateTime_sw.ToVar(TVarData_sw(AObj).FValue.VDate)
  else
    TVarData_sw(AObj).FValue.VDate := TDateTime_sw.FromVar(AArgs[0]);
end;

function TVarData_VError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VError: HRESULT;

  if IsGet then
    Result := HRESULT_sw.ToVar(TVarData_sw(AObj).FValue.VError)
  else
    TVarData_sw(AObj).FValue.VError := HRESULT_sw.FromVar(AArgs[0]);
end;

function TVarData_VBoolean_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VBoolean: WordBool;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VBoolean
  else
    TVarData_sw(AObj).FValue.VBoolean := WordBool(AArgs[0]);
end;

function TVarData_VShortInt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VShortInt: ShortInt;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VShortInt
  else
    TVarData_sw(AObj).FValue.VShortInt := ShortInt(AArgs[0]);
end;

function TVarData_VByte_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VByte: Byte;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VByte
  else
    TVarData_sw(AObj).FValue.VByte := Byte(AArgs[0]);
end;

function TVarData_VWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VWord: Word;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VWord
  else
    TVarData_sw(AObj).FValue.VWord := Word(AArgs[0]);
end;

function TVarData_VLongWord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VLongWord: LongWord;

  if IsGet then
    Result := TVarData_sw(AObj).FValue.VLongWord
  else
    TVarData_sw(AObj).FValue.VLongWord := LongWord(AArgs[0]);
end;

function TVarData_VInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VInt64: Int64;

  if IsGet then
    Result := Int64_sw.ToVar(TVarData_sw(AObj).FValue.VInt64)
  else
    TVarData_sw(AObj).FValue.VInt64 := Int64_sw.FromVar(AArgs[0]);
end;

{$IFDEF LMDCOMP12}
function TVarData_VUInt64_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VUInt64: UInt64;

  if IsGet then
    Result := UInt64_sw.ToVar(TVarData_sw(AObj).FValue.VUInt64)
  else
    TVarData_sw(AObj).FValue.VUInt64 := UInt64_sw.FromVar(AArgs[0]);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
function TVarData_VRecord_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VRecord: TVarRecord;

  if IsGet then
    Result := TVarRecord_sw.ToVar(TVarData_sw(AObj).FValue.VRecord)
  else
    TVarData_sw(AObj).FValue.VRecord := TVarRecord_sw.FromVar(AArgs[0]);
end;
{$ENDIF}

function TVarData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TVarData_sw.Create as IDispatch;
end;

function TVarData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarData;

  Result := TVarData_sw.ToVar(TVarData(AObj));
end;

class function TVarData_sw.GetTypeName: WideString;
begin
  Result := 'TVarData';
end;

function TVarData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarData_sw.Create;
  TVarData_sw(Result).FValue := FValue;
end;

class procedure TVarData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('VType', TVarData_VType_si, TVarType_sw);
  AData.AddField('Reserved1', TVarData_Reserved1_si, Word_sw);
  AData.AddField('Reserved2', TVarData_Reserved2_si, Word_sw);
  AData.AddField('Reserved3', TVarData_Reserved3_si, Word_sw);
  AData.AddField('VSmallInt', TVarData_VSmallInt_si, SmallInt_sw);
  AData.AddField('VInteger', TVarData_VInteger_si, Integer_sw);
  AData.AddField('VSingle', TVarData_VSingle_si, Single_sw);
  AData.AddField('VDouble', TVarData_VDouble_si, Double_sw);
  AData.AddField('VCurrency', TVarData_VCurrency_si, Currency_sw);
  AData.AddField('VDate', TVarData_VDate_si, TDateTime_sw);
  AData.AddField('VError', TVarData_VError_si, HRESULT_sw);
  AData.AddField('VBoolean', TVarData_VBoolean_si, WordBool_sw);
  AData.AddField('VShortInt', TVarData_VShortInt_si, ShortInt_sw);
  AData.AddField('VByte', TVarData_VByte_si, Byte_sw);
  AData.AddField('VWord', TVarData_VWord_si, Word_sw);
  AData.AddField('VLongWord', TVarData_VLongWord_si, LongWord_sw);
  AData.AddField('VInt64', TVarData_VInt64_si, Int64_sw);
  {$IFDEF LMDCOMP12}
  AData.AddField('VUInt64', TVarData_VUInt64_si, UInt64_sw);
  {$ENDIF}
  {$IFDEF LMDCOMP16}
  AData.AddField('VRecord', TVarData_VRecord_si, TVarRecord_sw);
  {$ENDIF}
  AData.AddFunction('Copy', TVarData_Copy_si, TVarData_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarData_Create_si, 0, False);
end;

class function TVarData_sw.ToVar(const AValue: TVarData): OleVariant;
var
  wrpr: TVarData_sw;
begin
  wrpr        := TVarData_sw.Create;
  wrpr.FValue := AValue;

  Result := ConvToVar(wrpr);
end;

class function TVarData_sw.FromVar(const AValue: OleVariant): TVarData;
begin
  Result := TVarData_sw(ConvFromVar(AValue)).FValue;
end;

{ TVarRecord_sw }

{$IFDEF LMDCOMP16}
function TVarRecord_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  Result := TVarRecord_sw.Create as IDispatch;
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
function TVarRecord_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TVarRecord;

  Result := TVarRecord_sw.ToVar(TVarRecord(AObj));
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class function TVarRecord_sw.GetTypeName: WideString;
begin
  Result := 'TVarRecord';
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
function TVarRecord_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVarRecord_sw.Create;
  TVarRecord_sw(Result).FValue := FValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class procedure TVarRecord_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVarRecord_Copy_si, TVarRecord_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TVarRecord_Create_si, 0, False);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class function TVarRecord_sw.ToVar(const AValue: TVarRecord): OleVariant;
var
  wrpr: TVarRecord_sw;
begin
  wrpr        := TVarRecord_sw.Create;
  wrpr.FValue := AValue;

  Result := ConvToVar(wrpr);
end;
{$ENDIF}

{$IFDEF LMDCOMP16}
class function TVarRecord_sw.FromVar(const AValue: OleVariant): TVarRecord;
begin
  Result := TVarRecord_sw(ConvFromVar(AValue)).FValue;
end;
{$ENDIF}

{ RawByteString_sw }

{$IFDEF LMDCOMP12}
class function RawByteString_sw.FromVar(
  const AValue: OleVariant): RawByteString;
begin
  Result := RawByteString(AValue);
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function RawByteString_sw.GetTypeName: WideString;
begin
  Result := 'RawByteString';
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function RawByteString_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function RawByteString_sw.ToVar(AValue: RawByteString): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function RawByteString_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(RawByteString(AValue));
end;
{$ENDIF}

{ UnicodeString_sw }

{$IFDEF LMDCOMP12}
class function UnicodeString_sw.FromVar(const AValue: OleVariant): WideString;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function UnicodeString_sw.GetTypeName: WideString;
begin
  Result := 'UnicodeString';
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function UnicodeString_sw.GetVarType: TVarType;
begin
  Result := varOleStr;
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function UnicodeString_sw.ToVar(AValue: WideString): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP12}
class function UnicodeString_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(UnicodeString(AValue));
end;
{$ENDIF}

{ TDateTime_sw }

class function TDateTime_sw.FromVar(const AValue: OleVariant): TDateTime;
begin
  Result := AValue;
end;

class function TDateTime_sw.GetTypeName: WideString;
begin
  Result := 'TDateTime';
end;

class function TDateTime_sw.GetVarType: TVarType;
begin
  Result := varDate;
end;

class function TDateTime_sw.ToVar(AValue: TDateTime): OleVariant;
begin
  Result := AValue;
end;

class function TDateTime_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(TDateTime(AValue));
end;

{ TPtrWrapper_sw }

{$IFDEF LMDCOMP17}
function TPtrWrapper_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    1:
    begin
      Result := TPtrWrapper_sw.ToVar(TPtrWrapper.Create(NativeInt_sw.FromVar(
        AArgs[0])));
    end;
    0:
    begin
      // Implicit parameterless constructor.
      Result := TPtrWrapper_sw.Create as IDispatch;
    end;
  else
    WrongArgCountError('Create');
  end;
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
function TPtrWrapper_ToInteger_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ToInteger: NativeInt;

  Result := NativeInt_sw.ToVar(TPtrWrapper_sw(AObj).FValue.ToInteger());
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
function TPtrWrapper_NilValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property NilValue: TPtrWrapper read <getter>;

  Result := TPtrWrapper_sw.ToVar(TPtrWrapper.NilValue);
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
function TPtrWrapper_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TPtrWrapper;

  // Implicit record copy method.
  Result := TPtrWrapper_sw.ToVar(TPtrWrapper(AObj));
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
class function TPtrWrapper_sw.GetTypeName: WideString;
begin
  Result := 'TPtrWrapper';
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
function TPtrWrapper_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPtrWrapper_sw.Create;
  TPtrWrapper_sw(Result).FValue := FValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
class procedure TPtrWrapper_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('ToInteger', TPtrWrapper_ToInteger_si, NativeInt_sw, 0, False);
  AData.AddFunction('Copy', TPtrWrapper_Copy_si, TPtrWrapper_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TPtrWrapper_Create_si, 0, True);
  AData.AddClassProperty('NilValue', TPtrWrapper_NilValue_si, TPtrWrapper_sw, True, False, 0, False);
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
class function TPtrWrapper_sw.ToVar(const AValue: TPtrWrapper): OleVariant;
var
  wrpr: TPtrWrapper_sw;
begin
  wrpr        := TPtrWrapper_sw.Create;
  wrpr.FValue := AValue;

  Result := ConvToVar(wrpr);
end;
{$ENDIF}

{$IFDEF LMDCOMP17}
class function TPtrWrapper_sw.FromVar(const AValue: OleVariant): TPtrWrapper;
begin
  Result := TPtrWrapper_sw(ConvFromVar(AValue)).FValue;
end;
{$ENDIF}

{ FixedUInt_sw }

{$IFDEF LMDCOMP22}
class function FixedUInt_sw.FromVar(const AValue: OleVariant): FixedUInt;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedUInt_sw.GetTypeName: WideString;
begin
  Result := 'FixedUInt';
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedUInt_sw.GetVarType: TVarType;
begin
  Result := varLongWord;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedUInt_sw.ToVar(AValue: FixedUInt): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedUInt_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(FixedUInt(AValue));
end;
{$ENDIF}

{ FixedInt_sw }

{$IFDEF LMDCOMP22}
class function FixedInt_sw.FromVar(const AValue: OleVariant): FixedInt;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedInt_sw.GetTypeName: WideString;
begin
  Result := 'FixedInt';
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedInt_sw.GetVarType: TVarType;
begin
  Result := varInteger;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedInt_sw.ToVar(AValue: FixedInt): OleVariant;
begin
  Result := AValue;
end;
{$ENDIF}

{$IFDEF LMDCOMP22}
class function FixedInt_sw.UntypedToVar(const AValue): OleVariant;
begin
  Result := ToVar(FixedInt(AValue));
end;
{$ENDIF}

end.
