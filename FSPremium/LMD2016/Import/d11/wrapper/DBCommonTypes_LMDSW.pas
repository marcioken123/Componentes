unit DBCommonTypes_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCommonTypes' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Types, DBCommonTypes;


{ Type wrappers }

type

  TLoginEvent_sh = class(TLMDScriptEventHandler)
  public
    function  GetHandler: TMethod; override;
    procedure Handler(Sender: TObject; Username: string; Password: string);
  end;

  TLoginEvent_sw = class(TLMDEventWrapper)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: TLoginEvent): OleVariant;
    class function FromVar(const AValue: OleVariant): TLoginEvent;
    class function GetScriptHandlerClass: TClass; override;
    class function GetHandler(AScriptControl: TLMDScriptControl;
                              const AProcName: string): TLoginEvent;
  end;

  FLDVchk_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: FLDVchk): OleVariant;
    class function FromVar(const AValue: OleVariant): FLDVchk;
  end;

  FLDRights_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: FLDRights): OleVariant;
    class function FromVar(const AValue: OleVariant): FLDRights;
  end;

  CBType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: CBType): OleVariant;
    class function FromVar(const AValue: OleVariant): CBType;
  end;

  CBRType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: CBRType): OleVariant;
    class function FromVar(const AValue: OleVariant): CBRType;
  end;

  TKeyIndex_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TKeyIndex): OleVariant;
    class function FromVar(const AValue: OleVariant): TKeyIndex;
  end;


{ Unit wrapper }

type
  DBCommonTypes_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TLoginEvent_sh }

function TLoginEvent_sh.GetHandler: TMethod;
var
  hdr: TLoginEvent;
begin
  hdr    := Handler;
  Result := TMethod(hdr);
end;

procedure TLoginEvent_sh.Handler(Sender: TObject; Username: string;
  Password: string);
var
  args: array[0..2] of OleVariant;
begin
  // procedure (Sender: TObject; Username: string; Password: s...

  args[0] := TObject_sw.ToVar(Sender);
  args[1] := Username;
  args[2] := Password;
  Self.Owner.RunProc(Self.ProcName, args);
end;

{ TLoginEvent_sw }

class function TLoginEvent_sw.GetTypeName: WideString;
begin
  Result := 'TLoginEvent';
end;

class function TLoginEvent_sw.GetScriptHandlerClass: TClass;
begin
  Result := TLoginEvent_sh;
end;

class function TLoginEvent_sw.ToVar(const AValue: TLoginEvent): OleVariant;
begin
  Result := ConvToVar(TMethod(AValue));
end;

class function TLoginEvent_sw.FromVar(const AValue: OleVariant): TLoginEvent;
begin
  Result := TLoginEvent(ConvFromVar(AValue));
end;

class function TLoginEvent_sw.GetHandler(AScriptControl: TLMDScriptControl;
  const AProcName: string): TLoginEvent;
var
  hdlr: TLoginEvent_sh;
begin
  hdlr   := TLoginEvent_sh(AScriptControl.GetEventHandler(AProcName, 
    TLoginEvent_sw));
  Result := hdlr.Handler;
end;

{ FLDVchk_sw }

class function FLDVchk_sw.GetTypeName: WideString;
begin
  Result := 'FLDVchk';
end;

class function FLDVchk_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(FLDVchk);
end;

class function FLDVchk_sw.ToVar(const AValue: FLDVchk): OleVariant;
begin
  Result := Integer(AValue);
end;

class function FLDVchk_sw.FromVar(const AValue: OleVariant): FLDVchk;
begin
  Result := FLDVchk(Integer(AValue));
end;

{ FLDRights_sw }

class function FLDRights_sw.GetTypeName: WideString;
begin
  Result := 'FLDRights';
end;

class function FLDRights_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(FLDRights);
end;

class function FLDRights_sw.ToVar(const AValue: FLDRights): OleVariant;
begin
  Result := Integer(AValue);
end;

class function FLDRights_sw.FromVar(const AValue: OleVariant): FLDRights;
begin
  Result := FLDRights(Integer(AValue));
end;

{ CBType_sw }

class function CBType_sw.GetTypeName: WideString;
begin
  Result := 'CBType';
end;

class function CBType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(CBType);
end;

class function CBType_sw.ToVar(const AValue: CBType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function CBType_sw.FromVar(const AValue: OleVariant): CBType;
begin
  Result := CBType(Integer(AValue));
end;

{ CBRType_sw }

class function CBRType_sw.GetTypeName: WideString;
begin
  Result := 'CBRType';
end;

class function CBRType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(CBRType);
end;

class function CBRType_sw.ToVar(const AValue: CBRType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function CBRType_sw.FromVar(const AValue: OleVariant): CBRType;
begin
  Result := CBRType(Integer(AValue));
end;

{ TKeyIndex_sw }

class function TKeyIndex_sw.GetTypeName: WideString;
begin
  Result := 'TKeyIndex';
end;

class function TKeyIndex_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TKeyIndex);
end;

class function TKeyIndex_sw.ToVar(const AValue: TKeyIndex): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TKeyIndex_sw.FromVar(const AValue: OleVariant): TKeyIndex;
begin
  Result := TKeyIndex(Integer(AValue));
end;

{ DBCommonTypes_sw }

function DBCommonTypes_TLoginEvent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLoginEvent = procedure (Sender: TObject; Username: ...

  Result := TLMDUnitWrapper.TypeToVar(TLoginEvent_sw);
end;

function DBCommonTypes_FLDVchk_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FLDVchk = (fldvHASCHECKS, fldvUNKNOWN);

  Result := TLMDUnitWrapper.TypeToVar(FLDVchk_sw);
end;

function DBCommonTypes_FLDRights_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FLDRights = (fldrREADONLY, fldrNONE, fldrUNKNOWN);

  Result := TLMDUnitWrapper.TypeToVar(FLDRights_sw);
end;

function DBCommonTypes_CBType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CBType = (cbRESERVED1, cbRESERVED2, cbINPUTREQ, cbRE...

  Result := TLMDUnitWrapper.TypeToVar(CBType_sw);
end;

function DBCommonTypes_CBRType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CBRType = (cbrCONTINUE, cbrABORT, cbrCHKINPUT, cbrYE...

  Result := TLMDUnitWrapper.TypeToVar(CBRType_sw);
end;

function DBCommonTypes_TKeyIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyIndex = (kiRangeStart, kiRangeEnd, kiCurRangeSta...

  Result := TLMDUnitWrapper.TypeToVar(TKeyIndex_sw);
end;

class function DBCommonTypes_sw.GetUnitName: WideString;
begin
  Result := 'DBCommonTypes';
end;

class procedure DBCommonTypes_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TLoginEvent_sw, DBCommonTypes_TLoginEvent_si);
  AData.AddType(FLDVchk_sw, DBCommonTypes_FLDVchk_si);
  AData.AddType(FLDRights_sw, DBCommonTypes_FLDRights_si);
  AData.AddType(CBType_sw, DBCommonTypes_CBType_si);
  AData.AddType(CBRType_sw, DBCommonTypes_CBRType_si);
  AData.AddType(TKeyIndex_sw, DBCommonTypes_TKeyIndex_si);
end;

class function DBCommonTypes_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCommonTypes_sw);
end;

initialization
  RegisterUnitWrapper(DBCommonTypes_sw);
  RegisterEventWrapper(TypeInfo(TLoginEvent), TLoginEvent_sw);

end.
