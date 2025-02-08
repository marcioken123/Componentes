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
  LMDSctWrappers, LMDSctSysWrappers, DBCommonTypes;


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
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: FLDVchk): OleVariant;
    class function FromVar(const AValue: OleVariant): FLDVchk;
  end;

  FLDRights_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: FLDRights): OleVariant;
    class function FromVar(const AValue: OleVariant): FLDRights;
  end;

  CBType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: CBType): OleVariant;
    class function FromVar(const AValue: OleVariant): CBType;
  end;

  CBRType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: CBRType): OleVariant;
    class function FromVar(const AValue: OleVariant): CBRType;
  end;

  TKeyIndex_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
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

class procedure FLDVchk_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'fldvNOCHECKS'; Value: Integer({$IFDEF LMDSCT_12}FLDVchk.{$ENDIF}fldvNOCHECKS)),
    (Name: 'fldvHASCHECKS'; Value: Integer({$IFDEF LMDSCT_12}FLDVchk.{$ENDIF}fldvHASCHECKS)),
    (Name: 'fldvUNKNOWN'; Value: Integer({$IFDEF LMDSCT_12}FLDVchk.{$ENDIF}fldvUNKNOWN))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
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

class procedure FLDRights_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'fldrREADWRITE'; Value: Integer({$IFDEF LMDSCT_12}FLDRights.{$ENDIF}fldrREADWRITE)),
    (Name: 'fldrREADONLY'; Value: Integer({$IFDEF LMDSCT_12}FLDRights.{$ENDIF}fldrREADONLY)),
    (Name: 'fldrNONE'; Value: Integer({$IFDEF LMDSCT_12}FLDRights.{$ENDIF}fldrNONE)),
    (Name: 'fldrUNKNOWN'; Value: Integer({$IFDEF LMDSCT_12}FLDRights.{$ENDIF}fldrUNKNOWN))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
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

class procedure CBType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..30] of TLMDEnumerator = (
    (Name: 'cbGENERAL'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbGENERAL)),
    (Name: 'cbRESERVED1'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED1)),
    (Name: 'cbRESERVED2'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED2)),
    (Name: 'cbINPUTREQ'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbINPUTREQ)),
    (Name: 'cbRESERVED4'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED4)),
    (Name: 'cbRESERVED5'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED5)),
    (Name: 'cbBATCHRESULT'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbBATCHRESULT)),
    (Name: 'cbRESERVED7'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED7)),
    (Name: 'cbRESTRUCTURE'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESTRUCTURE)),
    (Name: 'cbRESERVED9'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED9)),
    (Name: 'cbRESERVED10'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED10)),
    (Name: 'cbRESERVED11'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED11)),
    (Name: 'cbRESERVED12'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED12)),
    (Name: 'cbRESERVED13'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED13)),
    (Name: 'cbRESERVED14'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED14)),
    (Name: 'cbRESERVED15'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED15)),
    (Name: 'cbRESERVED16'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED16)),
    (Name: 'cbRESERVED17'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED17)),
    (Name: 'cbTABLECHANGED'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbTABLECHANGED)),
    (Name: 'cbRESERVED19'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED19)),
    (Name: 'cbCANCELQRY'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbCANCELQRY)),
    (Name: 'cbSERVERCALL'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbSERVERCALL)),
    (Name: 'cbRESERVED22'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbRESERVED22)),
    (Name: 'cbGENPROGRESS'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbGENPROGRESS)),
    (Name: 'cbDBASELOGIN'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbDBASELOGIN)),
    (Name: 'cbDELAYEDUPD'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbDELAYEDUPD)),
    (Name: 'cbFIELDRECALC'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbFIELDRECALC)),
    (Name: 'cbTRACE'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbTRACE)),
    (Name: 'cbDBLOGIN'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbDBLOGIN)),
    (Name: 'cbDETACHNOTIFY'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbDETACHNOTIFY)),
    (Name: 'cbNBROFCBS'; Value: Integer({$IFDEF LMDSCT_12}CBType.{$ENDIF}cbNBROFCBS))
  );
begin
  AEnums := @ENUMS;
  ACount := 31;
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

class procedure CBRType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..8] of TLMDEnumerator = (
    (Name: 'cbrUSEDEF'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrUSEDEF)),
    (Name: 'cbrCONTINUE'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrCONTINUE)),
    (Name: 'cbrABORT'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrABORT)),
    (Name: 'cbrCHKINPUT'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrCHKINPUT)),
    (Name: 'cbrYES'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrYES)),
    (Name: 'cbrNO'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrNO)),
    (Name: 'cbrPARTIALASSIST'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrPARTIALASSIST)),
    (Name: 'cbrSKIP'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrSKIP)),
    (Name: 'cbrRETRY'; Value: Integer({$IFDEF LMDSCT_12}CBRType.{$ENDIF}cbrRETRY))
  );
begin
  AEnums := @ENUMS;
  ACount := 9;
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

class procedure TKeyIndex_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'kiLookup'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiLookup)),
    (Name: 'kiRangeStart'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiRangeStart)),
    (Name: 'kiRangeEnd'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiRangeEnd)),
    (Name: 'kiCurRangeStart'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiCurRangeStart)),
    (Name: 'kiCurRangeEnd'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiCurRangeEnd)),
    (Name: 'kiSave'; Value: Integer({$IFDEF LMDSCT_12}TKeyIndex.{$ENDIF}kiSave))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
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
  // type FLDVchk = (fldvNOCHECKS, fldvHASCHECKS, fldvUNKNOWN);

  Result := TLMDUnitWrapper.TypeToVar(FLDVchk_sw);
end;

function DBCommonTypes_FLDRights_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FLDRights = (fldrREADWRITE, fldrREADONLY, fldrNONE, ...

  Result := TLMDUnitWrapper.TypeToVar(FLDRights_sw);
end;

function DBCommonTypes_CBType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CBType = (cbGENERAL, cbRESERVED1, cbRESERVED2, cbINP...

  Result := TLMDUnitWrapper.TypeToVar(CBType_sw);
end;

function DBCommonTypes_CBRType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CBRType = (cbrUSEDEF, cbrCONTINUE, cbrABORT, cbrCHKI...

  Result := TLMDUnitWrapper.TypeToVar(CBRType_sw);
end;

function DBCommonTypes_TKeyIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TKeyIndex = (kiLookup, kiRangeStart, kiRangeEnd, kiC...

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
