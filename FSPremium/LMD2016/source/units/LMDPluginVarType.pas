unit LMDPluginVarType;
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

LMDPluginVarType unit (AIH)
---------------------------
Description
Inplement variant types for LMD Plugin Framework
ToDo
----

Changes
-------

Release 0.1 (July 2008)
* Initial Release

###############################################################################}

interface

uses
  TypInfo, Variants, Classes, LMDPluginManager;

function VarLMDPluginCreate(const AValue: ILMDPlugin): Variant; overload;

implementation

uses
  VarUtils, SysUtils, DateUtils, WIndows, Dialogs;

type
  {*************************** TLMDPluginVariantType **************************}
  TLMDPluginVariantType = class (TPublishableVariantType)
  private
    function DoProcFunc(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray; ANeedResult: boolean = false): Boolean;
  protected
    function GetInstance(const V: TVarData): TObject; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData; const AVarType: TVarType); override;
    function DoFunction(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray): Boolean; override;
    function DoProcedure(const V: TVarData; const Name: string;
      const Arguments: TVarDataArray): Boolean; override;
  end;

var
  LMDPluginVariantType: TLMDPluginVariantType = nil;

type
  {***************************** TLMDPluginData *******************************}
  TLMDPluginData = class (TPersistent)
  private
    FPlugin: ILMDPlugin;
  public
    constructor Create(const AValue: ILMDPlugin); overload;
    constructor Create(const AValue: TLMDPluginData); overload;
    function AsString: string;
    property Plugin: ILMDPlugin read FPlugin write FPlugin;
  end;

  {***************************** TLMDPluginVarData ****************************}
  TLMDPluginVarData = packed
  record
    {$ifdef LMDX64}
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    case Integer of
    0: (VPlugin: TLMDPluginData);
    1: (VLargest: TLargestVarData); // to match size as Variant/TVarData type
    {$else}
    VType: TVarType;
    Reserved1, Reserved2, Reserved3: Word;
    VPlugin: TLMDPluginData;
    Reserved4: DWord;
    {$endif}
  end;

{--------------------------------- protected ----------------------------------}
function TLMDPluginVariantType.GetInstance(const V: TVarData): TObject;
begin
  Result := TLMDPluginVarData(V).VPlugin;
end;

{---------------------------------- public ------------------------------------}
procedure TLMDPluginVariantType.Clear(var V: TVarData);
begin
  V.VType := varEmpty;
  FreeAndNil(TLMDPluginVarData(V).VPlugin);
end;

{------------------------------------------------------------------------------}
procedure TLMDPluginVariantType.Copy(var Dest: TVarData; const Source: TVarData;
  const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
    with TLMDPluginVarData(Dest) do
    begin
      VType := VarType;
      VPlugin := TLMDPluginData.Create(TLMDPluginVarData(Source).VPlugin);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPluginVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
var
  LTemp: TVarData;
begin
  if Source.VType = VarType then
    case AVarType of
      varString:
        VarDataFromStr(Dest, TLMDPluginVarData(Source).VPlugin.AsString);
    else
      VarDataInit(LTemp);
    try
        LTemp.VType := varDate;
        LTemp.VUnknown := TLMDPluginVarData (Source).VPlugin;
        VarDataCastTo(Dest, LTemp, AVarType);
    finally
        VarDataClear(LTemp);
    end;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
function TLMDPluginVariantType.DoFunction(var Dest: TVarData;
  const V: TVarData; const Name: string;
  const Arguments: TVarDataArray): Boolean;
begin
  Result := DoProcFunc(Dest, V, Name, Arguments, True);
end;

{---------------------------- private -----------------------------------------}
function TLMDPluginVariantType.DoProcFunc(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray; ANeedResult: boolean): Boolean;

  procedure SetParam(const AParam: ILMDParameter; const AVarData: TVarData);
  begin

    case AParam.ParameterType of
      ptInt64:
        begin
          if AVarData.VType in [varInteger, varSmallint, varByte, varInt64, varWord] then
            AParam.AsInt64 := AVarData.VInteger;
        end;
      ptCurrency:
        begin
          if AVarData.VType = varCurrency then
            AParam.AsCurrency := AVarData.VCurrency;
        end;
      ptInteger:
        begin
          if AVarData.VType in [varByte, varSmallint, varWord, varInteger] then
            AParam.AsInteger := AVarData.VInteger;
        end;
      ptBoolean:
        begin
          if AVarData.VType = varBoolean then
            AParam.AsBoolean := AVarData.VBoolean;
        end;
      ptReal:
        begin
          if AVarData.VType = varDouble then
            AParam.AsReal := AVarData.VDouble;
        end;
      ptString:
        begin
          if (AVarData.VType = varString) or (AVarData.VType = varOleStr) then
            AParam.AsString := string(AVarData.VOleStr {VString});
        end;
      ptWord:
        begin
          if AVarData.VType in [varByte, varSmallint, varWord] then
            AParam.AsWord := AVarData.VWord;
        end;
      ptLongWord:
        begin
          if AVarData.VType in [varByte, varSmallint, varWord, varLongWord] then
            AParam.AsLongWord := AVarData.VLongWord;
        end;
      ptObject:
        begin
          if (AVarData.VType = varByRef) and (TObject(AVarData.VPointer) is TObject) then
            AParam.AsObject := TObject(AVarData.VPointer);
        end;
      ptPointer:
        begin
          if (AVarData.VType = varByRef) then
            AParam.AsPointer := AVarData.VPointer;
        end;
      ptGUID:
        begin
          if (AVarData.VType and varByRef = varByRef) then
            AParam.AsGUID := PGUID(TVarData(AVarData.VPointer^).VPointer)^;
        end;
    end;
  end;

  procedure SetResult(const AParam: ILMDParameter; var AValue: TVarData);
  begin
    case AParam.ParameterType of
      ptBoolean:
      begin
        AValue.VType := varBoolean;
        AValue.VBoolean := AParam.AsBoolean;
      end;

      ptInteger:
      begin
        AValue.VType := varInteger;
        AValue.VInteger := AParam.AsInteger;
      end;

      ptInt64:
      begin
        AValue.VType := varInt64;
        AValue.VInt64 := AParam.AsInt64;
      end;
            ptReal:
      begin
        AValue.VType := varDouble;
        AValue.VDouble := AParam.AsReal;
      end;

      ptString:
      begin
        AValue.VType := varOleStr;
        AValue.VOleStr := StringToOleStr(AParam.AsString);
      end;

      ptCurrency:
      begin
        AValue.VType := varCurrency;
        AValue.VCurrency := AParam.AsCurrency;
      end;

      ptSmallInt:
      begin
         AValue.VType := varSmallint;
         AValue.VSmallInt := AParam.AsSmallInt;
      end;

      ptWord:
      begin
        AValue.VType := varWord;
        AValue.VWord := AParam.AsWord;
      end;

      ptLongWord:
      begin
        AValue.VType := varLongWord;
        AValue.VLongWord := AParam.AsLongWord;
      end;
    end;
  end;
  var
  LAction: ILMDAction;
  i: Integer;
  LResult: ILMDParameter;
begin
  LAction := TLMDPluginVarData(V).VPlugin.Plugin.Actions[Name];
  if Assigned(LAction) then
  begin
    for i := 0 to Length(Arguments) - 1 do
      SetParam(LAction.Parameters[i], Arguments[i]);
    LResult := LAction.PerformAction;
    if ANeedResult then
      try
        SetResult(LResult, Dest);
        Result := True;
      except
        Result := False;
      end
    else
      Result := True;
  end
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
function TLMDPluginVariantType.DoProcedure(const V: TVarData;
  const Name: string; const Arguments: TVarDataArray): Boolean;
var
  LDummyVarData: TVarData;
begin
  Result := DoProcFunc(LDummyVarData, V, Name, Arguments, False);
end;

{--------------------------- TLMDPluginData -----------------------------------}
constructor TLMDPluginData.Create(const AValue: ILMDPlugin);
begin
  inherited Create;
  FPlugin := AValue;
end;

{------------------------------------------------------------------------------}
constructor TLMDPluginData.Create(const AValue: TLMDPluginData);
begin
  inherited Create;
  FPlugin := AValue.Plugin;
end;

{------------------------------------------------------------------------------}
function TLMDPluginData.AsString: string;
begin
  Result := 'Path: ' + FPlugin.FileName + #13#10 + 'Author: ' + FPlugin.Author + #13#10 +
          'Version: ' + IntToStr(FPlugin.GetMajorVersion()) + '.' + IntToStr(FPlugin.GetMinorVersion()) + #13#10 +
          'Description: ' + FPlugin.GetDescription();

end;

{------------------------------------------------------------------------------}
function VarLMDPluginCreate(const AValue: ILMDPlugin): Variant; overload;
begin
  VarClear(Result);
  TLMDPluginVarData(Result).VType := LMDPluginVariantType.VarType;
  TLMDPluginVarData(Result).VPlugin := TLMDPluginData.Create(AValue);
end;

initialization
  LMDPluginVariantType := TLMDPluginVariantType.Create;

finalization
  FreeAndNil(LMDPluginVariantType);

end.
