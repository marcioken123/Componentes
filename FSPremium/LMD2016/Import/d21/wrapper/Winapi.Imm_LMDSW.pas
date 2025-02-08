unit Winapi.Imm_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Winapi.Imm' unit.
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
  Winapi.Windows, Winapi.Imm, Winapi.Windows_LMDSW;


{ Type wrappers }

type

  HIMC_sw = Integer_sw;

  tagCOMPOSITIONFORM_sw = class(TLMDRecordWrapper)
  private
    FValue: tagCOMPOSITIONFORM;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagCOMPOSITIONFORM): OleVariant;
    class function FromVar(const AValue: OleVariant): tagCOMPOSITIONFORM;
  end;

  TCompositionForm_sw = tagCOMPOSITIONFORM_sw;


{ Unit wrapper }

type
  Imm_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ tagCOMPOSITIONFORM_sw }

function tagCOMPOSITIONFORM_dwStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwStyle: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagCOMPOSITIONFORM_sw(AObj).FValue.dwStyle)
  else
    tagCOMPOSITIONFORM_sw(AObj).FValue.dwStyle := DWORD_sw.FromVar(AArgs[0]);
end;

function tagCOMPOSITIONFORM_ptCurrentPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ptCurrentPos: TPOINT;

  if IsGet then
    Result := TPOINT_sw.ToVar(tagCOMPOSITIONFORM_sw(AObj).FValue.ptCurrentPos)
  else
    tagCOMPOSITIONFORM_sw(AObj).FValue.ptCurrentPos := TPOINT_sw.FromVar(
      AArgs[0]);
end;

function tagCOMPOSITIONFORM_rcArea_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcArea: TRECT;

  if IsGet then
    Result := TRECT_sw.ToVar(tagCOMPOSITIONFORM_sw(AObj).FValue.rcArea)
  else
    tagCOMPOSITIONFORM_sw(AObj).FValue.rcArea := TRECT_sw.FromVar(AArgs[0]);
end;

function tagCOMPOSITIONFORM_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagCOMPOSITIONFORM_sw.Create as IDispatch;
end;

function tagCOMPOSITIONFORM_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagCOMPOSITIONFORM;

  // Implicit record copy method.
  Result := tagCOMPOSITIONFORM_sw.ToVar(tagCOMPOSITIONFORM(AObj));
end;

class function tagCOMPOSITIONFORM_sw.GetTypeName: WideString;
begin
  Result := 'tagCOMPOSITIONFORM';
end;

function tagCOMPOSITIONFORM_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagCOMPOSITIONFORM_sw.Create;
  tagCOMPOSITIONFORM_sw(Result).FValue := FValue;
end;

class procedure tagCOMPOSITIONFORM_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('dwStyle', tagCOMPOSITIONFORM_dwStyle_si, DWORD_sw);
  AData.AddField('ptCurrentPos', tagCOMPOSITIONFORM_ptCurrentPos_si, TPOINT_sw);
  AData.AddField('rcArea', tagCOMPOSITIONFORM_rcArea_si, TRECT_sw);
  AData.AddFunction('Copy', tagCOMPOSITIONFORM_Copy_si, tagCOMPOSITIONFORM_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagCOMPOSITIONFORM_Create_si, 0, False);
end;

class function tagCOMPOSITIONFORM_sw.ToVar(
  const AValue: tagCOMPOSITIONFORM): OleVariant;
var
  wrpr: tagCOMPOSITIONFORM_sw;
begin
  wrpr        := tagCOMPOSITIONFORM_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagCOMPOSITIONFORM_sw.FromVar(
  const AValue: OleVariant): tagCOMPOSITIONFORM;
begin
  Result := tagCOMPOSITIONFORM_sw(ConvFromVar(AValue)).FValue;
end;

{ Imm_sw }

function Imm_HIMC_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HIMC = Integer;

  Result := TLMDUnitWrapper.TypeToVar(HIMC_sw);
end;

function Imm_tagCOMPOSITIONFORM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagCOMPOSITIONFORM = record;

  Result := TLMDUnitWrapper.TypeToVar(tagCOMPOSITIONFORM_sw);
end;

function Imm_TCompositionForm_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCompositionForm = tagCOMPOSITIONFORM;

  Result := TLMDUnitWrapper.TypeToVar(TCompositionForm_sw);
end;

class function Imm_sw.GetUnitName: WideString;
begin
  Result := 'Imm';
end;

class procedure Imm_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(HIMC_sw, Imm_HIMC_si);
  AData.AddType(tagCOMPOSITIONFORM_sw, Imm_tagCOMPOSITIONFORM_si);
  AData.AddType(TCompositionForm_sw, Imm_TCompositionForm_si);
end;

class function Imm_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Imm_sw);
end;

initialization
  RegisterUnitWrapper(Imm_sw);

end.
