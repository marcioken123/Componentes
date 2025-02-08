unit ElVerInfo;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative ()
  # Created:
  # Description:
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  ElComponent, LMDProcs, SysUtils, Windows, Classes, ShellAPI, LMDTypes;

Type
  TVersionAttribute = (vaDebug, vaPatched, vaPreRelease, vaPrivateBuild, vaSpecialBuild);
  TVersionAttributes = set of TVersionAttribute;

  TElVersionInfo = class(TElComponent)
  private
    FBuffer: TLMDString;
    FFileName: TLMDString;
    FFixedFileInfo: PVSFixedFileInfo;
    FLanguage: TLMDString;
    function GetAttributes: TVersionAttributes;
    function GetBuild: integer;
    function GetLanguage: TLMDString;
    function GetMajorVersion: integer;
    function GetMinorVersion: integer;
    function GetPredefined(Index: integer): TLMDString;
    function GetRelease: integer;
    function GetValue(const AName: TLMDString): TLMDString;
    function GetIsVerinfoExists: Boolean;
    procedure SetAttributes(const Value: TVersionAttributes);
    //procedure SetDummy(const Value: TLMDString);
    procedure SetDummyEx(Index: integer; const Value: TLMDString);
    procedure SetFileName(const Value: TLMDString);
    procedure SetDummyInt(const Value: integer);
    function StoreFileName: boolean;
    procedure SetLanguage(const Value: TLMDString);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Refresh;
    property Values[const Name: TLMDString]: TLMDString read GetValue; default;
  published
    property IsVerinfoExists: boolean read GetIsVerinfoExists stored False;
    property Attributes: TVersionAttributes read GetAttributes write SetAttributes stored False;
    property Build: integer read GetBuild write SetDummyInt stored False;
    property Comments: TLMDString index 9 read GetPredefined write SetDummyEx stored False;
    property CompanyName: TLMDString index 0 read GetPredefined write SetDummyEx stored False;
    property FileDescription: TLMDString index 1 read GetPredefined write SetDummyEx stored False;
    property FileName: TLMDString read FFileName write SetFileName stored StoreFileName;
    property FileVersion: TLMDString index 2 read GetPredefined write SetDummyEx stored False;
    property InternalName: TLMDString index 3 read GetPredefined write SetDummyEx stored False;
    property Language: TLMDString read GetLanguage write SetLanguage stored False;
    property LegalCopyright: TLMDString index 4 read GetPredefined write SetDummyEx stored False;
    property LegalTrademarks: TLMDString index 5 read GetPredefined write SetDummyEx stored False;
    property MajorVersion: integer read GetMajorVersion write SetDummyInt stored False;
    property MinorVersion: integer read GetMinorVersion write SetDummyInt stored False;
    property OriginalFilename: TLMDString index 6 read GetPredefined write SetDummyEx stored False;
    property ProductName: TLMDString index 7 read GetPredefined write SetDummyEx stored False;
    property ProductVersion: TLMDString index 8 read GetPredefined write SetDummyEx stored False;
    property Release: integer read GetRelease write SetDummyInt stored False;
  end;

implementation

{ TVmVersionInfo }

const
  PredefinedFields: array [0..9] of TLMDString = (
    'CompanyName',
    'FileDescription',
    'FileVersion',
    'InternalName',
    'LegalCopyright',
    'LegalTrademarks',
    'OriginalFilename',
    'ProductName',
    'ProductVersion',
    'Comments'
  );

constructor TElVersionInfo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileName := '';
end;

function TElVersionInfo.GetAttributes: TVersionAttributes;
begin
  Result := [];
  if FFixedFileInfo = nil then
    exit;
  if (VS_FF_DEBUG and FFixedFileInfo.dwFileFlags) <> 0 then Include(Result, vaDebug);
  if (VS_FF_PATCHED and FFixedFileInfo.dwFileFlags) <> 0 then Include(Result, vaPatched);
  if (VS_FF_PRERELEASE and FFixedFileInfo.dwFileFlags) <> 0 then Include(Result, vaPreRelease);
  if (VS_FF_PRIVATEBUILD and FFixedFileInfo.dwFileFlags) <> 0 then Include(Result, vaPrivateBuild);
  if (VS_FF_SPECIALBUILD and FFixedFileInfo.dwFileFlags) <> 0 then Include(Result, vaSpecialBuild);
end;

function TElVersionInfo.GetBuild: Integer;
begin
  if not GetIsVerinfoExists then
  begin
    result := 0;
    exit;
  end;

  Result := LongRec(FFixedFileInfo.dwFileVersionLS).Lo;

end;

function TElVersionInfo.GetLanguage: TLMDString;
begin
  SetLength(Result, 64 * SizeOf(TLMDChar));
  {$ifdef LMD_UNICODE}
  SetLength(Result, VerLanguageNameW(StrToIntDef('$' + Copy(FLanguage, 1, 4), $0409), PLMDChar(Result), 64 * SizeOf(TLMDChar)));
  {$else}
  SetLength(Result, VerLanguageName(StrToIntDef('$' + Copy(FLanguage, 1, 4), $0409), PLMDChar(Result), 64 * SizeOf(TLMDChar)));
  {$endif}
end;

function TElVersionInfo.GetMajorVersion: Integer;
begin
  if not GetIsVerinfoExists then
  begin
    result := 0;
    exit;
  end;

  Result := LongRec(FFixedFileInfo.dwFileVersionMS).Hi;

end;

function TElVersionInfo.GetMinorVersion: Integer;
begin
  if not GetIsVerinfoExists then
  begin
    result := 0;
    exit;
  end;

  Result := LongRec(FFixedFileInfo.dwFileVersionMS).Lo;

end;

function TElVersionInfo.GetPredefined(Index: integer): TLMDString;
begin
  if not GetIsVerinfoExists then
  begin
    result := '';
    exit;
  end;
  Result := GetValue(PredefinedFields[Index]);
end;

function TElVersionInfo.GetRelease: Integer;
begin
  if not GetIsVerinfoExists then
  begin
    result := 0;
    exit;
  end;

  Result := LongRec(FFixedFileInfo.dwFileVersionLS).Hi;

end;

function TElVersionInfo.GetValue(const AName: TLMDString): TLMDString;
var
  Value: PLMDChar;
  Size: DWORD;
begin
  if Length(FBuffer) > 0 then
  begin
    Value := nil;
    {$ifdef LMD_UNICODE}
    VerQueryValueW(PLMDChar(FBuffer), PLMDChar('\StringFileInfo\' + FLanguage + '\' + AName), Pointer(Value), Size);
    {$else}
    VerQueryValue(PLMDChar(FBuffer), PLMDChar('\StringFileInfo\' + FLanguage + '\' + AName), Pointer(Value), Size);
    {$endif}
      Result := Value;
    end
  else
    Result := '';
end;

function TElVersionInfo.GetIsVerinfoExists: Boolean;
begin
  Result := FFixedFileInfo <> nil;
end;

procedure TElVersionInfo.Refresh;
begin
  SetFileName(FFileName);
end;

procedure TElVersionInfo.SetAttributes(const Value: TVersionAttributes);
begin
end;

//procedure TElVersionInfo.SetDummy(const Value: TLMDString);
//begin
//end;

procedure TElVersionInfo.SetDummyEx(Index: integer; const Value: TLMDString);
begin
end;

procedure TElVersionInfo.SetDummyInt(const Value: integer);
begin
end;

procedure TElVersionInfo.SetFileName(const Value: TLMDString);
var
  Size, Dummy: DWORD;
  P: pointer;
  FileName: TLMDString;
begin
  if Value = '' then
  begin
    if csDesigning in ComponentState then
    begin
      SetLength(FileName, MAX_PATH);
      SetLength(FileName, GetModuleFileName(hInstance, Int_Ref(FileName), MAX_PATH));
      end
    else
      FileName := ParamStr(0);
  end
  else
    FileName := Value;

  FFileName := Value;
  try
    SetLength(FBuffer, 0);
    {$ifdef LMD_UNICODE}
    Size := GetFileVersionInfoSizeW(int_RefW(FileName), Dummy);
    {$else}
    Size := GetFileVersionInfoSize(Int_Ref(FileName), Dummy);
    {$endif}
    if Size > 0 then
    begin
      SetLength(FBuffer, Size);
      FLanguage := '040904E4';
      {$ifdef LMD_UNICODE}
      Win32Check(GetFileVersionInfoW(PLMDChar(FileName), Dummy, Size, PLMDChar(FBuffer)));
      if VerQueryValueW(PLMDChar(FBuffer), '\VarFileInfo\Translation', P, Size) then
      {$else}
      Win32Check(GetFileVersionInfo(PLMDChar(FileName), Dummy, Size, PLMDChar(FBuffer)));
      if VerQueryValue(PLMDChar(FBuffer), '\VarFileInfo\Translation', P, Size) then
      {$endif}
      begin
        FLanguage := IntToHex(PLongint(P)^, 8);
        FLanguage := Copy(FLanguage, 5, 4) + Copy(FLanguage, 1, 4);
      end;
      {$ifdef LMD_UNICODE}
      VerQueryValueW(Pointer(FBuffer), '\', Pointer(FFixedFileInfo), Size);
      {$else}
      VerQueryValue(Pointer(FBuffer), '\', Pointer(FFixedFileInfo), Size);
      {$endif}
      end
    else
      FFixedFileInfo := nil;
      finally
  end;
end;

procedure TElVersionInfo.SetLanguage(const Value: TLMDString);
begin
  FLanguage := Value;
end;

function TElVersionInfo.StoreFileName: Boolean;
begin
  Result := (FFileName <> ParamStr(0)) and (FFileName <> '');
end;

end.
